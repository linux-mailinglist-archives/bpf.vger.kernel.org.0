Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 344B0394324
	for <lists+bpf@lfdr.de>; Fri, 28 May 2021 15:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbhE1ND2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 May 2021 09:03:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230080AbhE1ND0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 May 2021 09:03:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF09761001;
        Fri, 28 May 2021 13:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622206912;
        bh=FNx7PuKOW6IqJOgQcEMKBCcMzoBUxAFP70kRxG5nUgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BtQCL3mEOsr3bzTNeYB0hmSZ2K2oOXmVgRFfj3P89ZhmG0J0Ww4/h9vBc6YKmgJYs
         +YmcOhk7WRYTqH5UohfZCDH0lEMt+Ss+srVImaFJ82AFSmrokBCf6M8yv/Z7Y5hNpD
         OSrA5Ac0MTrnZuVFr4QDKDl/EgyFSwwA4PiOnkBU0CMnlvXozG9Iki53DVywZixyAh
         0b6Cx1GrCwSjAwfDvoxZt+5N7LcrynM0scJqlRzRaY0YEYHvc/bbphkWCZ5gMe/91V
         KyfgebpBBJ7cq98WLpIMD4Gp2JfcQOssZxnt+Bj451M8YvA8x15qUCT4njZQL1A1Xq
         gvBM9NcOCZtfQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B47634011C; Fri, 28 May 2021 10:01:48 -0300 (-03)
Date:   Fri, 28 May 2021 10:01:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf@vger.kernel.org
Cc:     "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: perf test 40 Basic BPF llvm compile dumps core (x86 and s390)
Message-ID: <YLDpvKCAJibAhU1S@kernel.org>
References: <f2308775-2a07-ea63-c741-50ab98eafc2c@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f2308775-2a07-ea63-c741-50ab98eafc2c@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, May 28, 2021 at 12:48:56PM +0200, Thomas Richter escreveu:
> I noticed perf test 40.1 dumps core on 5.13.0rc2 and rc3:
> 
> [root@f34 perf]# ./perf test -F 40
> 40: LLVM search and compile                                         :
> 40.1: Basic BPF llvm compile                                        :
> libbpf: elf: skipping unrecognized data section(8) .eh_frame
> libbpf: elf: skipping relo section(9) .rel.eh_frame for section(8) .eh_frame
> Segmentation fault (core dumped)
> [root@f34 perf]#

> The root cause is a NULL pointer reference in function btf__get_nr_types()
> as can be seen with gdb:

This looks like a bug in libbpf:

static int bpf_object__collect_externs(struct bpf_object *obj)
{
        struct btf_type *sec, *kcfg_sec = NULL, *ksym_sec = NULL;
        const struct btf_type *t;
        struct extern_desc *ext;
        int i, n, off, dummy_var_btf_id;
        const char *ext_name, *sec_name;
        Elf_Scn *scn;
        GElf_Shdr sh;

        if (!obj->efile.symbols)
                return 0;

        scn = elf_sec_by_idx(obj, obj->efile.symbols_shndx);
        if (elf_sec_hdr(obj, scn, &sh))
                return -LIBBPF_ERRNO__FORMAT;

        dummy_var_btf_id = add_dummy_ksym_var(obj->btf);
        if (dummy_var_btf_id < 0)
                return dummy_var_btf_id;


obj->btf is NULL, so probably btf__find_by_name_kind() should check that
and return an error, Andrii?

- Arnaldo
 
> Breakpoint 1, 0x000000000065f4b1 in btf__get_nr_types
>      (btf=btf@entry=0x0) at btf.c:425
> 425		return btf->start_id + btf->nr_types - 1;
> 
> This is the same function and reason why test case 42.1 Basic BPF filtering
> fails and dumps core too.
> 
> The call chain is:
> (gdb) where
>  #0  0x000000000065f4b1 in btf__get_nr_types (btf=btf@entry=0x0) at btf.c:425
>  #1  btf__find_by_name_kind (btf=btf@entry=0x0,
> 		type_name=type_name@entry=0x928ab2 ".ksyms",
> 		kind=kind@entry=15) at btf.c:696
>  #2  0x00000000006527fe in add_dummy_ksym_var (btf=0x0) at libbpf.c:3219
>  #3  bpf_object__collect_externs (obj=0xd0ea20) at libbpf.c:3266
>  #4  __bpf_object__open (path=<optimized out>, path@entry=0x0,
> 		obj_buf=obj_buf@entry=0xd12fa0,
> 		obj_buf_sz=obj_buf_sz@entry=1520,
>     		opts=opts@entry=0x7fffffffdb30) at libbpf.c:7372
>  #5  0x0000000000655415 in __bpf_object__open (opts=0x7fffffffdb30,
> 		obj_buf_sz=1520, obj_buf=0xd12fa0, path=0x0) at libbpf.c:7337
>  #6  bpf_object__open_mem (opts=0x7fffffffdb30, obj_buf_sz=1520,
> 		obj_buf=0xd12fa0) at libbpf.c:7454
>  #7  bpf_object__open_mem (opts=0x7fffffffdb30, obj_buf_sz=1520,
> 		obj_buf=0xd12fa0) at libbpf.c:7448
>  #8  bpf_object__open_buffer (obj_buf=0xd12fa0, obj_buf_sz=1520,
> 		name=<optimized out>) at libbpf.c:7471
>  #9  0x00000000004c8c6e in test__bpf_parsing (obj_buf=0xd12fa0,
> 		obj_buf_sz=1520) at tests/llvm.c:16
>  #10 0x00000000004c8fe2 in test__llvm (test=0xac7d20 <generic_tests+2496>,
> 		subtest=0) at tests/llvm.c:142
> ...
> 
> I have no knowledge about BPF and why the core dump happens. Before
> I start digging into this has anybody some hints on where to look?
> 
> Thanks a lot.
> 
> -- 
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
> --
> Vorsitzender des Aufsichtsrats: Gregor Pillen
> Geschäftsführung: Dirk Wittkopp
> Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

-- 

- Arnaldo

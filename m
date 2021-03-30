Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B597334F086
	for <lists+bpf@lfdr.de>; Tue, 30 Mar 2021 20:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbhC3SIU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Mar 2021 14:08:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232644AbhC3SIK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Mar 2021 14:08:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C98F3619D1;
        Tue, 30 Mar 2021 18:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617127690;
        bh=cqkXbHqdsx6UIjRhqnZpaCNAhR38l/zNsT05pOfRbzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UDMrW/n4zM0h9ObcZoRI3CjUd2gUO8p9TZbLXD5x4FnatPlFOnjRpVru/ntX8TU2Z
         C9HKKxfclYM+IVHtx6s5k+3iKlC0h0LGYLSema0MZjp0hU6BgCILCVW21sof7eqCuv
         9Z0Yth1xvJ9DrkAPW87YJGVEBmPchf0F9pkg7aZ/kvDYZicjezZSXCNw/pHA+cXHWB
         BaSycA6smKgkaZnDVXEwjVfd3za73ptb/79glB/+gHwYUWBQSHsFXflVil60yji2+q
         l9BQs4Lv1M8JSh3UMT38v8+QMNCZcz71dh6WrHcIv9adXqtgDWZ+G/+fNgDwgJXkKt
         UXT9Ny1dlRO5w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E8F6340647; Tue, 30 Mar 2021 15:08:06 -0300 (-03)
Date:   Tue, 30 Mar 2021 15:08:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, dwarves@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH dwarves v3 0/3] permit merging all dwarf cu's for clang
 lto built binary
Message-ID: <YGNpBlf7sLalcFWB@kernel.org>
References: <20210328201400.1426437-1-yhs@fb.com>
 <YGIQ9c3Qk+DMa+C7@kernel.org>
 <YGM/Uh61RVExWnTU@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGM/Uh61RVExWnTU@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Mar 30, 2021 at 12:10:10PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Mar 29, 2021 at 02:40:05PM -0300, Arnaldo Carvalho de Melo escreveu:
> > [acme@five pahole]$ ulimit -c 10000000
> > [acme@five pahole]$
> > [acme@five pahole]$ file tcp_bbr.o
> > tcp_bbr.o: ELF 64-bit LSB relocatable, x86-64, version 1 (SYSV), with debug_info, not stripped
> > [acme@five pahole]$ readelf -wi tcp_bbr.o | grep DW_AT_producer
> >     <d>   DW_AT_producer    : (indirect string, offset: 0x4a97): GNU C89 10.2.1 20200723 (Red Hat 10.2.1-1) -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -m64 -mno-80387 -mno-fp-ret-in-387 -mpreferred-stack-boundary=3 -mskip-rax-setup -mtune=generic -mno-red-zone -mcmodel=kernel -mindirect-branch=thunk-extern -mindirect-branch-register -mrecord-mcount -mfentry -march=x86-64 -g -O2 -std=gnu90 -p -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -falign-jumps=1 -falign-loops=1 -fno-asynchronous-unwind-tables -fno-jump-tables -fno-delete-null-pointer-checks -fno-allow-store-data-races -fstack-protector-strong -fno-var-tracking-assignments -fno-strict-overflow -fno-merge-all-constants -fmerge-constants -fstack-check=no -fconserve-stack -fcf-protection=none
> > [acme@five pahole]$ fullcircle tcp_bbr.o
> > /home/acme/bin/fullcircle: line 38: 3969006 Segmentation fault      (core dumped) ${pfunct_bin} --compile $file > $c_output
> > /tmp/fullcircle.4XujnI.c:1435:2: error: unterminated comment
> >  1435 |  /* si
> >       |  ^
> > /tmp/fullcircle.4XujnI.c:1433:2: error: expected specifier-qualifier-list at end of input
> >  1433 |  u32 *                      saved_syn;            /*  2184     8 */
> >       |  ^~~
> > codiff: couldn't load debugging info from /tmp/fullcircle.ZOVXGv.o
> > /home/acme/bin/fullcircle: line 40: 3969019 Segmentation fault      (core dumped) ${codiff_bin} -q -s $file $o_output
> > [acme@five pahole]$
> > 
> > Both seem unrelated to what you've done here, I'm investigating it now.
> 
> The fullcircle one, that crashes at the 'codiff' utility is related to
> the patch that makes dwarf_cu to allocate space for the hash tables, as
> you introduced a destructor for the dwarf_cu hashtables and the dwarf_cu
> that was assigned to cu->priv was a local variable, which wasn't much of
> a problem because we were not freeing it, as it went away at each loop
> iteration, the following patch to that first patch in the series seems
> to cure it, I'm folding it into your patch + a commiter note.

[acme@five pahole]$ codiff tcp_bbr.o /tmp/fullcircle.ceBLyj.o
/home/acme/git/linux/net/ipv4/tcp_bbr.c:
  bbr_unregister                    |   -6
  __compiletime_assert_691          |   +0
  bbr_register                      |  -11
  bbr_ssthresh                      |  -76
  bbr_undo_cwnd                     | -101
  bbr_sndbuf_expand                 |  -11
  bbr_init                          | -385
  bbr_main                          | -2640
  bbr_lt_bw_sampling                | -803
  bbr_packets_in_net_at_edt         | -212
  bbr_inflight                      | -172
  __compiletime_assert_655          |   +0
  bbr_set_pacing_rate               | -182
  kcsan_check_access                |   +6
  kasan_check_write                 |  +14
  tcp_unregister_congestion_control |   +0
  tcp_register_congestion_control   |   +0
  minmax_running_max                |   +0
  prandom_u32                       |   +0
  __warn_printk                     |   +0
  __stack_chk_fail                  |   +0
 21 functions changed, 20 bytes added, 4599 bytes removed, diff: -4579
[acme@five pahole]$
[acme@five pahole]$
[acme@five pahole]$ fullcircle tcp_bbr.o
[acme@five pahole]$

This one is dealt with, doing some more tests and looking at that
array[] versus array[0].

- Arnaldo

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944EA394EAF
	for <lists+bpf@lfdr.de>; Sun, 30 May 2021 02:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhE3Apn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 29 May 2021 20:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhE3Apn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 29 May 2021 20:45:43 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245C7C061574;
        Sat, 29 May 2021 17:44:06 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id b9so3292522ybg.10;
        Sat, 29 May 2021 17:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G/tsG7bSPifg8l0vxnMKIRn4DZczc9OXPGOZRBnB9Gg=;
        b=J8djhMZUi5OPDVVE4uQLkTl/LnB2caKU6xB98d8RI8q0RdeUDLid4ruPgbd6Hw9hcd
         2hnIeIikSy5KWm9k3PSQeLtncjpVLHlNa8xePBcfPXAbKZcBQrniFyZeyYVWWDsSb+UP
         JIJhUFGW53q3lgTuhwTm39psLBJF+HcAzfsX/YPg1rE875KJ2Peso7t8q3eGuxGB2Dfx
         6y8yOOQ5SCxhHeT4WblatvWaK8rIpb92+SUy5sSlQckf9I17U1BDUhKUFEj+CC5/d7lA
         Lv1gi4xj6l1Rci1ekvzGGRxaNLzFzBbzCxD8SPq8SY2TKePWglPY3rRziwjEFJfeoM+N
         X0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G/tsG7bSPifg8l0vxnMKIRn4DZczc9OXPGOZRBnB9Gg=;
        b=qVZODVEDIoVVNwYUuJE4w84a2PoJtvbuWYnQVw1nQRhZBFSvBfG2Sf+WxwagwqfMhr
         N2AvfscOCgIEoCIQywtSml6KH6fDnfF2UHsB1ZK/OnrlDXQdfZiulJeJfO/OPHprcFmp
         6o7dqpM+Y4WEJyW4zKQ+iZY6GJws9P6KwigCArd80o5jccBvG2J677m068agc2GEmn8q
         5acO7CDckoMSpR6FHqfVMAqangCOw/mmUMNqcRZXwF8Y6JtYYhYqSz+vido9lV8iV4MP
         JiGoXXcaOf7sDWgvSi70cc9qRU9RZuk8isPcsogfgUw/Vjr7oHZlvteo2DmMYhxFnjP2
         Mhog==
X-Gm-Message-State: AOAM530B6CJ4A+BH6iWZD02FXbD/hduxuS7RmZOfYTpCxiMmp++BTYyk
        HTOvrYi3JjxvC4tZncytn70Y04hanY8qnaK1s0s=
X-Google-Smtp-Source: ABdhPJxALDTktYBwD25CxGGOCsDhchYDNOsKwZEgS9PBYXjPePemtUQ0brvZlZhtRsWzQofK3Zz4YrsVfTot2uX7Oik=
X-Received: by 2002:a25:9942:: with SMTP id n2mr23274093ybo.230.1622335445286;
 Sat, 29 May 2021 17:44:05 -0700 (PDT)
MIME-Version: 1.0
References: <f2308775-2a07-ea63-c741-50ab98eafc2c@linux.ibm.com> <YLDpvKCAJibAhU1S@kernel.org>
In-Reply-To: <YLDpvKCAJibAhU1S@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 29 May 2021 17:43:54 -0700
Message-ID: <CAEf4BzZ0b3V9ivEOn5UC1xOG79aYPSA8o-yv63+pxykVb+EMWg@mail.gmail.com>
Subject: Re: perf test 40 Basic BPF llvm compile dumps core (x86 and s390)
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>, bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 28, 2021 at 6:01 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Fri, May 28, 2021 at 12:48:56PM +0200, Thomas Richter escreveu:
> > I noticed perf test 40.1 dumps core on 5.13.0rc2 and rc3:
> >
> > [root@f34 perf]# ./perf test -F 40
> > 40: LLVM search and compile                                         :
> > 40.1: Basic BPF llvm compile                                        :
> > libbpf: elf: skipping unrecognized data section(8) .eh_frame
> > libbpf: elf: skipping relo section(9) .rel.eh_frame for section(8) .eh_=
frame
> > Segmentation fault (core dumped)
> > [root@f34 perf]#
>
> > The root cause is a NULL pointer reference in function btf__get_nr_type=
s()
> > as can be seen with gdb:
>
> This looks like a bug in libbpf:
>
> static int bpf_object__collect_externs(struct bpf_object *obj)
> {
>         struct btf_type *sec, *kcfg_sec =3D NULL, *ksym_sec =3D NULL;
>         const struct btf_type *t;
>         struct extern_desc *ext;
>         int i, n, off, dummy_var_btf_id;
>         const char *ext_name, *sec_name;
>         Elf_Scn *scn;
>         GElf_Shdr sh;
>
>         if (!obj->efile.symbols)
>                 return 0;
>
>         scn =3D elf_sec_by_idx(obj, obj->efile.symbols_shndx);
>         if (elf_sec_hdr(obj, scn, &sh))
>                 return -LIBBPF_ERRNO__FORMAT;
>
>         dummy_var_btf_id =3D add_dummy_ksym_var(obj->btf);
>         if (dummy_var_btf_id < 0)
>                 return dummy_var_btf_id;
>
>
> obj->btf is NULL, so probably btf__find_by_name_kind() should check that
> and return an error, Andrii?
>

This is already fixed in libbpf v0.4 ([0]). Can you please update
pahole's libbpf submodule sha?

  [0] https://github.com/libbpf/libbpf/commit/a58b8ca93e39285a2852ca3d60e69=
8598bf7265b

> - Arnaldo
>
> > Breakpoint 1, 0x000000000065f4b1 in btf__get_nr_types
> >      (btf=3Dbtf@entry=3D0x0) at btf.c:425
> > 425           return btf->start_id + btf->nr_types - 1;
> >
> > This is the same function and reason why test case 42.1 Basic BPF filte=
ring
> > fails and dumps core too.
> >
> > The call chain is:
> > (gdb) where
> >  #0  0x000000000065f4b1 in btf__get_nr_types (btf=3Dbtf@entry=3D0x0) at=
 btf.c:425
> >  #1  btf__find_by_name_kind (btf=3Dbtf@entry=3D0x0,
> >               type_name=3Dtype_name@entry=3D0x928ab2 ".ksyms",
> >               kind=3Dkind@entry=3D15) at btf.c:696
> >  #2  0x00000000006527fe in add_dummy_ksym_var (btf=3D0x0) at libbpf.c:3=
219
> >  #3  bpf_object__collect_externs (obj=3D0xd0ea20) at libbpf.c:3266
> >  #4  __bpf_object__open (path=3D<optimized out>, path@entry=3D0x0,
> >               obj_buf=3Dobj_buf@entry=3D0xd12fa0,
> >               obj_buf_sz=3Dobj_buf_sz@entry=3D1520,
> >               opts=3Dopts@entry=3D0x7fffffffdb30) at libbpf.c:7372
> >  #5  0x0000000000655415 in __bpf_object__open (opts=3D0x7fffffffdb30,
> >               obj_buf_sz=3D1520, obj_buf=3D0xd12fa0, path=3D0x0) at lib=
bpf.c:7337
> >  #6  bpf_object__open_mem (opts=3D0x7fffffffdb30, obj_buf_sz=3D1520,
> >               obj_buf=3D0xd12fa0) at libbpf.c:7454
> >  #7  bpf_object__open_mem (opts=3D0x7fffffffdb30, obj_buf_sz=3D1520,
> >               obj_buf=3D0xd12fa0) at libbpf.c:7448
> >  #8  bpf_object__open_buffer (obj_buf=3D0xd12fa0, obj_buf_sz=3D1520,
> >               name=3D<optimized out>) at libbpf.c:7471
> >  #9  0x00000000004c8c6e in test__bpf_parsing (obj_buf=3D0xd12fa0,
> >               obj_buf_sz=3D1520) at tests/llvm.c:16
> >  #10 0x00000000004c8fe2 in test__llvm (test=3D0xac7d20 <generic_tests+2=
496>,
> >               subtest=3D0) at tests/llvm.c:142
> > ...
> >
> > I have no knowledge about BPF and why the core dump happens. Before
> > I start digging into this has anybody some hints on where to look?
> >
> > Thanks a lot.
> >
> > --
> > Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germ=
any
> > --
> > Vorsitzender des Aufsichtsrats: Gregor Pillen
> > Gesch=C3=A4ftsf=C3=BChrung: Dirk Wittkopp
> > Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht St=
uttgart, HRB 243294
>
> --
>
> - Arnaldo

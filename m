Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF145FB7E8
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 18:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiJKQGU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Oct 2022 12:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiJKQGT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Oct 2022 12:06:19 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FCE4F189
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 09:06:17 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id w10so20833216edd.4
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 09:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6R3E6JgqPSve9Z4s/NP4Z3YuqDABv+/glUzu7Y5Cy7M=;
        b=nGm2VjDhzUSrNULobMIPpQthCoxQNNBSoh6u899xAixT083MMOUAY+XLb6g1EzhgUv
         8fW3WAvkM6tvQe6Seih2Uc42i/FWnxLKho+rJSlk+2FPyoobiqrWLZCdKciYDsItVwAq
         dONuClT687M/sKKyXSFfTpKHZ/Ah7LbSYHhwKY21uTBJL0kQqKW8492F3DvGRPLt30Rs
         Ps8uk40CiHV9nPbhmBGfoy+PJ9hU3gJCy2MfNgDUCSsZZ0nU5toTwW7guXt2aoiDhH+7
         zoz2IoGNaKgWDBKGQ+jynY9hdjYVwRMLyln8n32kT91rwnwPs9XEK0/OpSngOQ3s6uhc
         nPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6R3E6JgqPSve9Z4s/NP4Z3YuqDABv+/glUzu7Y5Cy7M=;
        b=MdRxUXYNMpkndTXxqqbIZURtUvcD53Vot/ZG5p59gbW3QT7pJSZ7lwsR2Ogov0rcnl
         rT2rgMuoxPlrZ6C8BCJYmudM0un5eG+8kqIew+DNJUqCRlQvbCpoRKZKO4y/nob/5FTs
         2xKNTBE9ap9ZEMJjfyRpApXkOHoh95gXHM2juIY9hS/ZX8ktJPVhYoclfJYUPLx9erau
         nrk6wRQoFhx7jGiSbvpwPkMylVgRvt7bCTCXBMK9I6Ufu7MVCvlMMklFMNOW8i2pVA2+
         K72Z83fpiQgZotU0vArdbUzea7FqvXgR1NMXDME4VkFskv95OkhqO+Svsp+rNk/p77Zi
         x31Q==
X-Gm-Message-State: ACrzQf2FA8Cg0MMJR0UCB6GtBapbTuAK9nDnp2vrlpVKQnQ24N8c3xo4
        0426LVrGf6J1SQgDmoCQdrlPf9LDKZj0wO4c6Ms=
X-Google-Smtp-Source: AMsMyM67GiUpjeCTlaY2i6/okqtjQxALCZxbZmkjZaYQQn+b2exveJyXBJSiVsxBXgV+SFrNELQll/WLT5V4zsQDDCg=
X-Received: by 2002:aa7:de9a:0:b0:44d:8191:44c5 with SMTP id
 j26-20020aa7de9a000000b0044d819144c5mr23554492edv.232.1665504375581; Tue, 11
 Oct 2022 09:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <20221007174816.17536-1-shung-hsi.yu@suse.com> <20221007174816.17536-2-shung-hsi.yu@suse.com>
 <CAEf4Bzb08aKQQCGozqcxe8c4Qj3Bna6v1AETat_vMm7L=ixcaA@mail.gmail.com>
 <Y0TpKaIGL18UltHF@syu-laptop> <Y0WDcdQyxkYuQVXq@syu-laptop>
In-Reply-To: <Y0WDcdQyxkYuQVXq@syu-laptop>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 11 Oct 2022 09:06:03 -0700
Message-ID: <CAEf4BzZe_U96h31RzOcQbos4nD3kFsBLjNn9O8NvgnV9J3v2JA@mail.gmail.com>
Subject: Re: [PATCH bpf 1/3] libbpf: use elf_getshdrnum() instead of e_shnum
To:     Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc:     bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 11, 2022 at 7:53 AM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
>
> On Tue, Oct 11, 2022 at 11:55:21AM +0800, Shung-Hsi Yu wrote:
> > On Mon, Oct 10, 2022 at 05:44:20PM -0700, Andrii Nakryiko wrote:
> > > On Fri, Oct 7, 2022 at 10:48 AM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> > > >
> > > > This commit replace e_shnum with the elf_getshdrnum() helper to fix two
> > > > oss-fuzz-reported heap-buffer overflow in __bpf_object__open. Both
> > > > reports are incorrectly marked as fixed and while still being
> > > > reproducible in the latest libbpf.
> > > >
> > > >   # clusterfuzz-testcase-minimized-bpf-object-fuzzer-5747922482888704
> > > >   libbpf: loading object 'fuzz-object' from buffer
> > > >   libbpf: sec_cnt is 0
> > > >   libbpf: elf: section(1) .data, size 0, link 538976288, flags 2020202020202020, type=2
> > > >   libbpf: elf: section(2) .data, size 32, link 538976288, flags 202020202020ff20, type=1
> > > >   =================================================================
> > > >   ==13==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x6020000000c0 at pc 0x0000005a7b46 bp 0x7ffd12214af0 sp 0x7ffd12214ae8
> > > >   WRITE of size 4 at 0x6020000000c0 thread T0
> > > >   SCARINESS: 46 (4-byte-write-heap-buffer-overflow-far-from-bounds)
> > > >       #0 0x5a7b45 in bpf_object__elf_collect /src/libbpf/src/libbpf.c:3414:24
> > > >       #1 0x5733c0 in bpf_object_open /src/libbpf/src/libbpf.c:7223:16
> > > >       #2 0x5739fd in bpf_object__open_mem /src/libbpf/src/libbpf.c:7263:20
> > > >       ...
> > > >
> > > > The issue lie in libbpf's direct use of e_shnum field in ELF header as
> > > > the section header count. Where as libelf, on the other hand,
> > > > implemented an extra logic that, when e_shnum is zero and e_shoff is not
> > > > zero, will use sh_size member of the initial section header as the real
> > > > section header count (part of ELF spec to accommodate situation where
> > > > section header counter is larger than SHN_LORESERVE).
> > > >
> > > > The above inconsistency lead to libbpf writing into a zero-entry calloc
> > > > area. So intead of using e_shnum directly, use the elf_getshdrnum()
> > > > helper provided by libelf to retrieve the section header counter into
> > > > sec_cnt.
> > > >
> > > > Link: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=40868
> > > > Link: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=40957
> > > > Fixes: 0d6988e16a12 ("libbpf: Fix section counting logic")
> > > > Fixes: 25bbbd7a444b ("libbpf: Remove assumptions about uniqueness of .rodata/.data/.bss maps")
> > > > Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> > > > ---
> > > >
> > > > To be honest I'm not sure if any of the BPF toolchain will produce such
> > > > ELF binary. Tools like readelf simply refuse to dump section header
> > > > table when e_shnum==0 && e_shoff !=0 case is encountered.
> > > >
> > > > While we can use same approach as readelf, opting for a coherent view
> > > > with libelf for now since that should be less confusing.
> > > >
> > > > ---
> > > >  tools/lib/bpf/libbpf.c | 10 ++++++++--
> > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > > index 184ce1684dcd..a64e13c654f3 100644
> > > > --- a/tools/lib/bpf/libbpf.c
> > > > +++ b/tools/lib/bpf/libbpf.c
> > > > @@ -597,7 +597,7 @@ struct elf_state {
> > > >         size_t shstrndx; /* section index for section name strings */
> > > >         size_t strtabidx;
> > > >         struct elf_sec_desc *secs;
> > > > -       int sec_cnt;
> > > > +       size_t sec_cnt;
> > > >         int btf_maps_shndx;
> > > >         __u32 btf_maps_sec_btf_id;
> > > >         int text_shndx;
> > > > @@ -1369,6 +1369,13 @@ static int bpf_object__elf_init(struct bpf_object *obj)
> > > >                 goto errout;
> > > >         }
> > > >
> > > > +       if (elf_getshdrnum(obj->efile.elf, &obj->efile.sec_cnt)) {
> > >
> > > It bothers me that sec_cnt is initialized in bpf_object__elf_init, but
> > > secs are allocated a bit later in bpf_object__elf_collect(). What if
> > > we move elf_getshdrnum() call and sec_cnt initialization into
> > > bpf_object__elf_collect()?
> >
> > Ack.
> >
> > My rational for placing it there was that it's closer to other elf_*()
> > helper calls, but having it close to the allocation where it's used seems
> > like a better option.
> >
> > Will change accordingly and send a v2 based on top of bpf-next.
> >
> > > > +               pr_warn("elf: failed to get the number of sections for %s: %s\n",
> > > > +                       obj->path, elf_errmsg(-1));
> > > > +               err = -LIBBPF_ERRNO__FORMAT;
> > > > +               goto errout;
> > > > +       }
> > > > +
> > > >         /* Elf is corrupted/truncated, avoid calling elf_strptr. */
> > > >         if (!elf_rawdata(elf_getscn(elf, obj->efile.shstrndx), NULL)) {
> > > >                 pr_warn("elf: failed to get section names strings from %s: %s\n",
> > > > @@ -3315,7 +3322,6 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
> > > >          * section. e_shnum does include sec #0, so e_shnum is the necessary
> > > >          * size of an array to keep all the sections.
> > > >          */
> > > > -       obj->efile.sec_cnt = obj->efile.ehdr->e_shnum;
> > > >         obj->efile.secs = calloc(obj->efile.sec_cnt, sizeof(*obj->efile.secs));
>
> Looking again I realized we're still allocation one more section than
> necessary, even after 0d6988e16a12 ("libbpf: Fix section counting logic").

Yes, that's by design so to preserve ELF's 1-based indexing and not
have to constantly adjust section index by -1 to do a lookup. Please
keep it as is.

>
> elf_nextscn() skips sec #0, so (sec_cnt - 1) * sizeof(secs) should suffice.
>
>   /* In elfutils/libelf/elf_nextscn.c */
>   Elf_Scn *elf_nextscn (Elf *elf, Elf_Scn *scn)
>   {
>     ...
>
>     if (scn == NULL)
>       {
>         /* If no section handle is given return the first (not 0th) section.
>          Set scn to the 0th section and perform nextscn.  */
>         if (elf->class == ELFCLASS32
>            || (offsetof (Elf, state.elf32.scns)
>                == offsetof (Elf, state.elf64.scns)))
>         list = &elf->state.elf32.scns;
>         else
>         list = &elf->state.elf64.scns;
>
>         scn = &list->data[0];
>       }
>     ...
>   }
>
> What do you think? If it make sense then I'll place the sec_cnt - 1 change
> before the current patch unless otherwise suggested.
>
> > > >         if (!obj->efile.secs)
> > > >                 return -ENOMEM;
> > > > --
> > > > 2.37.3
> > > >

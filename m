Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A59C4EE569
	for <lists+bpf@lfdr.de>; Fri,  1 Apr 2022 02:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240452AbiDAAkK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 31 Mar 2022 20:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbiDAAkJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 31 Mar 2022 20:40:09 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1C4C61
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 17:38:18 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id w21so1099172pgm.7
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 17:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vCAk3z9cUX7xZG6ututuB3shKMTN3QyXcXoGAZaZQxk=;
        b=NFRz+W/0cu5FPiOPmqebTNlZwQ7AN+xBYbZaMpzQxgkOyb8QKH2bwDOEMic8RmL0kC
         tHqzmpEaExVUSt5OyrEP4H5J1aO4IIh7JnV42DHe8d4RyU1SgqbRavHmKUWIM8BuPwFE
         XZtj2ULX67wWu6XPicBy8DL0Qqs7bOeo7HkvukJHO+Hdb89BgQImu3hgDc21p8zt6RPX
         i6H41fKaUh6H884tqjaoG+NBzMCdOQ6KOMrkhaCLEKRPsNDrqPtQ7Cf+CYj5k6BB/3vm
         hU5CuFcuGXMmyHl2KtsefuKgKtDKhHGe8iQbrOuxd7qurEqUgNGefExak+PTLlqMQvm0
         L1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vCAk3z9cUX7xZG6ututuB3shKMTN3QyXcXoGAZaZQxk=;
        b=mhEwsKOxgu8nEWFnhbIirBkIEZHG6DDUsbH3/ZrRj9gZ/R+9ney4WWWUOg2Q+4Bpaj
         2uDht66AafUds8adcF0SQRpSyhemltrAN9rpPMDDA/QcBVB/FclhScXCpvRbmFibmBAC
         iSh9xBYjDaOwQBYqeZi/FA3NqyM2OH7QDx/VcPJFoMy6xFXotdor3jdsYqakCeUoJOIQ
         XzENdiebJgAtbm6Vik+k/ydTjGmZSGKoCeDon1qzLmhqw30ahDbyOJ+xgzSR9ilVOXdw
         GJfiweH8Y8u8dEwx01n42zVXPw74uvaJmQfmFdwEURr/9w0/edMF9PFieIqmhZPq0CMR
         lf6w==
X-Gm-Message-State: AOAM533f0LBs5jqSVIMSlCVEbCHTMrf31m9KqBCKsXoW5Xxtc/B0tziK
        kRw7Xvh18a3274S4yiTgQrNrTl8y47pC+fw4SXQ=
X-Google-Smtp-Source: ABdhPJwOoVT4iLYq8Zx5KqKf186aSro0O/c0iqXHxeLNehtFsfUUacY5/gIDcvn8VyB3CIvR8qyRwnQ4k4o6MgcBmRY=
X-Received: by 2002:a05:6a00:1c9e:b0:4fa:d946:378b with SMTP id
 y30-20020a056a001c9e00b004fad946378bmr8147155pfw.46.1648773497859; Thu, 31
 Mar 2022 17:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220325052941.3526715-1-andrii@kernel.org> <20220325052941.3526715-2-andrii@kernel.org>
 <CAADnVQLkYb6NiEq=bkP_AC4pj8OFC1achC8m9UdEhwWp4ahrFw@mail.gmail.com> <CAEf4Bza9_L=biSu_G_ux9vgn05LVTLVdfpfi3P_XH421SeH_4g@mail.gmail.com>
In-Reply-To: <CAEf4Bza9_L=biSu_G_ux9vgn05LVTLVdfpfi3P_XH421SeH_4g@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 31 Mar 2022 17:38:07 -0700
Message-ID: <CAADnVQKuxEj63pGfHgB04n2BBNja+2NuRJXMjZrvx-4SB8ZX8A@mail.gmail.com>
Subject: Re: program local storage. Was: [PATCH bpf-next 1/7] libbpf: add
 BPF-side of USDT support
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 31, 2022 at 1:13 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Mar 31, 2022 at 11:34 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Mar 24, 2022 at 10:30 PM Andrii Nakryiko <andrii@kernel.org> wrote:
> > > +
> > > +struct __bpf_usdt_arg_spec {
> > > +       __u64 val_off;
> > > +       enum __bpf_usdt_arg_type arg_type;
> > > +       short reg_off;
> > > +       bool arg_signed;
> > > +       char arg_bitshift;
> > > +};
> > > +
> > > +/* should match USDT_MAX_ARG_CNT in usdt.c exactly */
> > > +#define BPF_USDT_MAX_ARG_CNT 12
> > > +struct __bpf_usdt_spec {
> > > +       struct __bpf_usdt_arg_spec args[BPF_USDT_MAX_ARG_CNT];
> > > +       __u64 usdt_cookie;
> > > +       short arg_cnt;
> > > +};
> > > +
> > > +__weak struct {
> > > +       __uint(type, BPF_MAP_TYPE_ARRAY);
> > > +       __uint(max_entries, BPF_USDT_MAX_SPEC_CNT);
> > > +       __type(key, int);
> > > +       __type(value, struct __bpf_usdt_spec);
> > > +} __bpf_usdt_specs SEC(".maps");
> > > +
> > > +__weak struct {
> > > +       __uint(type, BPF_MAP_TYPE_HASH);
> > > +       __uint(max_entries, BPF_USDT_MAX_IP_CNT);
> > > +       __type(key, long);
> > > +       __type(value, struct __bpf_usdt_spec);
> > > +} __bpf_usdt_specs_ip_to_id SEC(".maps");
> > ...
> >
> > > +
> > > +/* Fetch USDT argument *arg* (zero-indexed) and put its value into *res.
> > > + * Returns 0 on success; negative error, otherwise.
> > > + * On error *res is guaranteed to be set to zero.
> > > + */
> > > +__hidden __weak
> > > +int bpf_usdt_arg(struct pt_regs *ctx, int arg, long *res)
> > > +{
> > > +       struct __bpf_usdt_spec *spec;
> > > +       struct __bpf_usdt_arg_spec *arg_spec;
> > > +       unsigned long val;
> > > +       int err, spec_id;
> > > +
> > > +       *res = 0;
> > > +
> > > +       spec_id = __bpf_usdt_spec_id(ctx);
> > > +       if (spec_id < 0)
> > > +               return -ESRCH;
> > > +
> > > +       spec = bpf_map_lookup_elem(&__bpf_usdt_specs, &spec_id);
> > > +       if (!spec)
> > > +               return -ESRCH;
> > > +
> > > +       if (arg >= spec->arg_cnt)
> > > +               return -ENOENT;
> > > +
> > > +       arg_spec = &spec->args[arg];
> > > +       switch (arg_spec->arg_type) {
> >
> > Without bpf_cookie in the kernel each arg access is two lookups.
> > With bpf_cookie it's a single lookup in an array that is fast.
> > Multiply that cost by number of args.
> > Not a huge cost, but we can do better long term.
> >
> > How about annotating bpf_cookie with PTR_TO_BTF_ID at prog load time.
> > So that bpf_get_attach_cookie() returns PTR_TO_BTF_ID instead of long.
> > This way bpf_get_attach_cookie() can return
> > "struct __bpf_usdt_spec *".
> >
> > At attach time libbpf will provide populated 'struct __bpf_usdt_spec'
> > to the kernel and the kernel will copy the struct's data
> > in the bpf_link.
> > At detach time that memory is freed.
> >
> > Advantages:
> > - saves an array lookup at runtime
> > - no need to provide size for __bpf_usdt_specs map.
> >   That map is no longer needed.
> >   users don't need to worry about maxing out BPF_USDT_MAX_SPEC_CNT.
> > - libbpf doesn't need to populate __bpf_usdt_specs map
> >   libbpf doesn't need to allocate spec_id-s.
> >   libbpf will keep struct __bpf_usdt_spec per uprobe and
> >   pass it to the kernel at attach time to store in bpf_link.
> >
> > "cookie as ptr_to_btf_id" is a generic mechanism to provide a
> > blob of data to the bpf prog instead of a single "long".
> > That blob can be read/write too.
> > It can be used as per-program + per-attach point scratch area.
> > Similar to task/inode local storage...
> > That would be (prog, attach_point) local storage.
> >
> > Thoughts?
>
> Well, I'm not concerned about ARRAY lookup, as it is inlined and very
> fast. Sizing maps is hard and annoying, true, but I think we should
> eventually just have resizable or dynamically-sized BPF maps, which
> will be useful in a lot of other contexts.

Yes. dynamically sized bpf maps would be great.
That's orthogonal.

> We've had a discussion about a cookie that's bigger than 8 bytes with
> Daniel. I argued for simplicity and I still like it. If you think we
> should add blobs per attachment, it's fine, but let's keep it separate
> from the BPF cookie.

Well, Daniel was right.
This USDT work is first real use of bpf_cookie and
it clearly demonstrates that bpf_cookie alone as 8-byte long
is not enough. The bpf progs have to do map lookup.
I bet the majority of bpf_cookie use cases will include map lookup.
In the case of USDT we were able to get away with array lookup
which is cheap, but we won't be that lucky next time.
Hash lookup will be more costly and dynamically sized map
won't help the performance consideration.

It would be ok to keep ptr_to_btf_id separate from cookie only if
it won't sacrifice performance. The way cookie is shaping up
as part of bpf_run_ctx gives hope that they can stay separate.

> As for the PTR_TO_BTF_ID, I'm a bit confused, as kernel doesn't know
> __bpf_usdt_spec type, it's not part of vmlinux BTF, so you are
> proposing to have PTR_TO_BTF_ID that points to user-provided type?

Yes. It will be pointing to prog's BTF.

> I'm
> not sure I see how exactly that will work from the verifier's
> standpoint, tbh. At least I don't see how verifier can allow more than
> just giving direct memory access to a memory buffer.

It's a longer discussion, but user provided BTF doesn't mean
that it should be limited to scalars only.
Such struct can contain pointers too. Not on day one probably.
kptr and dynptr can be and should be allowed in user's BTFs eventually.

> But then each
> uprobe attachment can have differently-sized blob, so statically
> verifying that during program load time is impossible.

In this USDT case the __bpf_usdt_spec is fixed size for all attach points.
One ptr_to_btf_id as a cookie per program is a minor limitation.
I don't see a need to support different ptr_to_btf_id-s
in different attach points.
USDT use case doesn't need it at least.

> In any case, I don't think we should wait for any extra kernel
> functionality to add USDT support. If we have some of those and they
> bring noticeable benefits, we can opportunistically use them, if the
> kernel is recent enough.

Of course! It's not a blocker for libbpf usdt feature.
That's why this discussion is a separate thread.

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346DE5802D1
	for <lists+bpf@lfdr.de>; Mon, 25 Jul 2022 18:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236270AbiGYQhM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Jul 2022 12:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236242AbiGYQhL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jul 2022 12:37:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 368A7165B3
        for <bpf@vger.kernel.org>; Mon, 25 Jul 2022 09:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658767028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uX/CIl3/NQjIza59k4D84Jqt8oVMF3tjMbQv7DGeXfQ=;
        b=b1yCVj8bq8+JMZ1a5n9a0dxZNwZfxCkJzDYppi3TYb9bs15rRT8upkon+GSIRPTd3FsjrP
        QMMXw3kWicfOuEGO0aRkXTEsdZdHlzidPM6sjeU5aS5Shwf6P3Ms4cFvCdxJtKRPHK4ic/
        pwdKIRP3ktRnE1uo9fug9HP2SnBxPqY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-572-IlPPy9-zNuyKuaPd7ise9w-1; Mon, 25 Jul 2022 12:37:06 -0400
X-MC-Unique: IlPPy9-zNuyKuaPd7ise9w-1
Received: by mail-pj1-f72.google.com with SMTP id r13-20020a17090a454d00b001f04dfc6195so6052559pjm.2
        for <bpf@vger.kernel.org>; Mon, 25 Jul 2022 09:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uX/CIl3/NQjIza59k4D84Jqt8oVMF3tjMbQv7DGeXfQ=;
        b=inzVIe0R9ask7V7gvgJcQcXzUHyXoc4BQbEs3JdcDAdhTOwsKVCXklbH8E839WO9RI
         uYJVsCYr5QR1BGaTdeaPpa2ufta+Oz2JHdeNINxDBWNVvqmI7JuiRwonGGsMDtbB7lxX
         fKOKE4IIpH3JvHdKvUNM5L1kmfaYH0vDf7Y7s2a/6d2c7rnAw2JzSnVx9ruBTYFznT8Z
         PnMiQfIjYJbDFBaz9FRVffp60eNK8nt9izFM0cZBFz+SxW8irIkV/UYR3HZ4G5K0KrXl
         ksdfdafh9zAJQxABFb70xmtAnUI9qsOD4hQhrXw5A/BFYikf57/8caIX4MHDSXRAx8dg
         LcMQ==
X-Gm-Message-State: AJIora8LDPFF4LhYW6I/EjqF/t6GHUbD59hEJY3uBSLEn+WokN/i5qEI
        s/oIs9tnK+HZdmjKRv0A2FIm26reCFoq7DFaIGY4s1XVunVds+o29Yd9GjimzW7zNj2Mb01PM7w
        ptoHTiOWzZnHRnoHKSf5Bvg3ZC1rB
X-Received: by 2002:a17:90b:4a10:b0:1f2:a45c:125 with SMTP id kk16-20020a17090b4a1000b001f2a45c0125mr8074804pjb.246.1658767025429;
        Mon, 25 Jul 2022 09:37:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sPlHp+QRO5zqoXfQQgsIJG2b+XDIphd1zSrT/UPuRkDTksexdZfM2yMaSi/BkdosJi1NznSztsDTzgOqEBrDI=
X-Received: by 2002:a17:90b:4a10:b0:1f2:a45c:125 with SMTP id
 kk16-20020a17090b4a1000b001f2a45c0125mr8074784pjb.246.1658767025181; Mon, 25
 Jul 2022 09:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220721153625.1282007-3-benjamin.tissoires@redhat.com>
 <20220722084556.1342406-1-benjamin.tissoires@redhat.com> <CAADnVQLypx8Yd7L4GByGNEJaWgg0R6ukNV9hz0ge1+ZdW4mdgQ@mail.gmail.com>
In-Reply-To: <CAADnVQLypx8Yd7L4GByGNEJaWgg0R6ukNV9hz0ge1+ZdW4mdgQ@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 25 Jul 2022 18:36:54 +0200
Message-ID: <CAO-hwJK5v8An5W48x2TDH=iNb49iEbC8uGwMbdCak0Bjnmea+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 02/24] bpf/verifier: allow kfunc to read user
 provided context
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Joe Stringer <joe@cilium.io>, Jonathan Corbet <corbet@lwn.net>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 22, 2022 at 6:16 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jul 22, 2022 at 1:46 AM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > When a kfunc was trying to access data from context in a syscall eBPF
> > program, the verifier was rejecting the call.
> > This is because the syscall context is not known at compile time, and
> > so we need to check this when actually accessing it.
> >
> > Check for the valid memory access and allow such situation to happen.
> >
> > Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >
> > ---
> >
> > changes in v8:
> > - fixup comment
> > - return -EACCESS instead of -EINVAL for consistency
> >
> > changes in v7:
> > - renamed access_t into atype
> > - allow zero-byte read
> > - check_mem_access() to the correct offset/size
> >
> > new in v6
> > ---
> >  kernel/bpf/verifier.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 7c1e056624f9..c807c5d7085a 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -248,6 +248,7 @@ struct bpf_call_arg_meta {
> >         struct bpf_map *map_ptr;
> >         bool raw_mode;
> >         bool pkt_access;
> > +       bool is_kfunc;
> >         u8 release_regno;
> >         int regno;
> >         int access_size;
> > @@ -5170,6 +5171,7 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
> >                                    struct bpf_call_arg_meta *meta)
> >  {
> >         struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
> > +       enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
> >         u32 *max_access;
> >
> >         switch (base_type(reg->type)) {
> > @@ -5223,6 +5225,24 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
> >                                 env,
> >                                 regno, reg->off, access_size,
> >                                 zero_size_allowed, ACCESS_HELPER, meta);
> > +       case PTR_TO_CTX:
> > +               /* in case of a kfunc called in a program of type SYSCALL, the context is
> > +                * user supplied, so not computed statically.
> > +                * Dynamically check it now
> > +                */
> > +               if (prog_type == BPF_PROG_TYPE_SYSCALL && meta && meta->is_kfunc) {
>
> prog_type check looks a bit odd here.
> Can we generalize with
> if (!env->ops->convert_ctx_access

Yep, seems to be working fine for my use case and the test cases I
have in this series.

>
> In other words any program type that doesn't have ctx rewrites can
> use helpers to access ctx fields ?
>
> Also why kfunc only?
> It looks safe to allow normal helpers as well.

Well, not sure what is happening here, but if I remove the check for
kfunc, the test for PTR_TO_CTX == NULL and size == 0 gives me a
-EINVAL.

The original reason for kfunc only was because I wanted to scope the
changes to something I can control, but now I am completely out of
ideas on why the NULL test fails if it enters the if branch.

Unfortunately I won't have a lot of time this week to tackle this (I
am on holiday with my family), and next will be tough too (at home but
doing renovations).

I can send the fixup to remove the prog_type check as I just made sure
it works with the selftests. But I won't be able to dig further why it
fails without the kfunc check, because not enough time and
concentration.

Cheers,
Benjamin


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8D7578468
	for <lists+bpf@lfdr.de>; Mon, 18 Jul 2022 15:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbiGRNy1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jul 2022 09:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbiGRNyS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jul 2022 09:54:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D4C5A1089
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 06:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658152455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pc2COzK5DZ3zqU+q9ucYylkxH5lyMmFL6dLIwCvbYD4=;
        b=MSbSP6rRD7uAvChP5Cast9+55jgWHeadQmP3LuML+k9arVw+KzQHdLPWUQvnjIr4SOZKRN
        tufYAvGusgALdEGC27pmEOsHc2uR5Rz3r6IHWQIR9MoNroPX6rb/3Y756NEdMCllUt4C4h
        pmRdC25jolGkwJnuUgndM/ktkKm8cuo=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-182-xLiLcRutMYuXjNI1PL_IBg-1; Mon, 18 Jul 2022 09:54:07 -0400
X-MC-Unique: xLiLcRutMYuXjNI1PL_IBg-1
Received: by mail-pf1-f199.google.com with SMTP id u14-20020a056a00098e00b0052b433b04d6so1194950pfg.12
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 06:54:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pc2COzK5DZ3zqU+q9ucYylkxH5lyMmFL6dLIwCvbYD4=;
        b=4lKdGLnVCkS7AlEpTogebC5cTnNoZMR3tj+HKskbBSq5zkmM2DTUoDZkQ7qeDOMP2a
         J2fwoux/EaDonJaJheE/hi54PZg/72Q5in2RRAb5ihKOSJKY9rSoQuqCrdtlxj/3sMt1
         +JKBvVMZ55rrN9kjjOAjKEHRZsLhWk4a3K4AouxSgY+4DmkR3QLyHS6usuD+e0yKCTuw
         V4rAJZLk17Rpjm+UnJiCavIRalOelDfi3Ucbk53paxJDGwLSlNZnbvMMQWTJyfPq9MuL
         bcxV7k2l2cSCIPn1P2palz529oKEdCjkJoNqlKkZDK4fvojbjeu6aVAbHV5jdEEpALRM
         fCQw==
X-Gm-Message-State: AJIora+BqmJT3GijcTuT6iJW2yTSconNbXYCPaK8QYBOUC4XGGW/LWbi
        ujy5Kn+IeSC/3idvd+sl749KdWxyBRSTNZ3Xs49wJbZc8FmA5YrNdyLpPejroX2Nrfw7TRp4pkm
        JyWoL/nTd1fweh0eSjM3Xon5g2L+l
X-Received: by 2002:a17:90b:3c0c:b0:1ef:e647:ff48 with SMTP id pb12-20020a17090b3c0c00b001efe647ff48mr38420235pjb.173.1658152446338;
        Mon, 18 Jul 2022 06:54:06 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tYWWG5+dHj3RDcKvwCfnQ6XdC8dUoOKHbWxuHGS02OBFyhEdIY4FE1XeYYySiizoSxEBwA/mzE4iBKSc2KOic=
X-Received: by 2002:a17:90b:3c0c:b0:1ef:e647:ff48 with SMTP id
 pb12-20020a17090b3c0c00b001efe647ff48mr38420212pjb.173.1658152446035; Mon, 18
 Jul 2022 06:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220712145850.599666-1-benjamin.tissoires@redhat.com>
 <20220712145850.599666-3-benjamin.tissoires@redhat.com> <CAP01T766-JGd=6twHYhWDmjVBk7wuuvWMLFyDZ656fka6GW8Cw@mail.gmail.com>
In-Reply-To: <CAP01T766-JGd=6twHYhWDmjVBk7wuuvWMLFyDZ656fka6GW8Cw@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 18 Jul 2022 15:53:55 +0200
Message-ID: <CAO-hwJ+RU89t=w5RgJNG=G46veHHF6NiR1zAsec9YuYrX=FF8A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 02/23] bpf/verifier: allow kfunc to read user
 provided context
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Joe Stringer <joe@cilium.io>, Jonathan Corbet <corbet@lwn.net>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jul 16, 2022 at 9:48 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Tue, 12 Jul 2022 at 17:02, Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > When a kfunc was trying to access data from context in a syscall eBPF
> > program, the verifier was rejecting the call.
> > This is because the syscall context is not known at compile time, and
> > so we need to check this when actually accessing it.
> >
> > Check for the valid memory access and allow such situation to happen.
> >
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >
> > ---
> >
> > new in v6
> > ---
> >  kernel/bpf/verifier.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 328cfab3af60..f6af57a84247 100644
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
> > @@ -5223,6 +5225,19 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
> >                                 env,
> >                                 regno, reg->off, access_size,
> >                                 zero_size_allowed, ACCESS_HELPER, meta);
> > +       case PTR_TO_CTX:
> > +               /* in case of a kfunc called in a program of type SYSCALL, the context is
> > +                * user supplied, so not computed statically.
> > +                * Dynamically check it now
> > +                */
> > +               if (prog_type == BPF_PROG_TYPE_SYSCALL && meta && meta->is_kfunc) {
> > +                       enum bpf_access_type access_t = meta->raw_mode ? BPF_WRITE : BPF_READ;
>
> small nit: _t suffix is used for types, so you could probably rename
> this. maybe atype?

Ack, fixed locally.

>
> > +
> > +                       return check_mem_access(env, env->insn_idx, regno, access_size, BPF_B,
> > +                                               access_t, -1, false);
>
> If I read the code correctly, this makes the max_ctx_offset of prog
> access_size + 1 (off + size_to_bytes(BPF_B)), which is 1 more than the
> actual size being accessed.

Oh, correct. I am mixing offset and access_size, which creates this :(

>
> This also messes up check_helper_mem_access when it allows NULL, 0
> pair to pass (because check is against actual size + 1). We do allow
> passing NULL when size is 0 for kfuncs (see zero_size_allowed is true

I am a little bit confused by how check_mem_size_reg() treats the case
when reg->umin_value == 0.

What does it mean to call check_helper_mem_access() with a 0 size if
we have zero_size_allowed?

Can I just have in the PTR_TO_CTX case: "if (access_size == 0) return
zero_size_allowed ? 0 : -EINVAL;" or should I only allow the call if
the ptr in the register is null?

> in check_mem_size_reg), so your hid_hw_request function is missing
> that NULL check for buf too.

Actually, in hid_hw_request() we ensure buf__sz is greater than 1, so
buf can not be null. But I agree it doesn't hurt to have that extra
check to be sure (we are called from a syscall program, so not time
sensitive).

>
> In the selftest that checks for failure in loading
> + bpf_kfunc_call_test_mem_len_pass1(&args->data, sizeof(*args) + 1);
> so it will still fail with just sizeof(*args).

Good point.

>
> Also please add coverage for this case in the next version.

I added both (NULL, 0) and (&args->data, sizeof(*args)) as passing
tests locally.

And thanks for the review!

Cheers,
Benjamin


>
> > +               }
> > +
> > +               fallthrough;
> >         default: /* scalar_value or invalid ptr */
> >                 /* Allow zero-byte read from NULL, regardless of pointer type */
> >                 if (zero_size_allowed && access_size == 0 &&
> > @@ -5335,6 +5350,7 @@ int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state
> >         WARN_ON_ONCE(regno < BPF_REG_2 || regno > BPF_REG_5);
> >
> >         memset(&meta, 0, sizeof(meta));
> > +       meta.is_kfunc = true;
> >
> >         if (may_be_null) {
> >                 saved_reg = *mem_reg;
> > --
> > 2.36.1
> >
>


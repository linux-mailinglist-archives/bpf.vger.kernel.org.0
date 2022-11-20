Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA5A6315C4
	for <lists+bpf@lfdr.de>; Sun, 20 Nov 2022 20:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiKTTKx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 14:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKTTKw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 14:10:52 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C7127FEA
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 11:10:51 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id v28so9466098pfi.12
        for <bpf@vger.kernel.org>; Sun, 20 Nov 2022 11:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VXZmRT1smcUCqMURFiAzCFUsDXeE9fpWNRwPRAhsStQ=;
        b=LcUC74JFcrNrID1f98wAP5LZ3rR0bBuhf/gekWs3dCEWOlrfH9k4/sJJdZR2Fs5JaO
         /lWgWOcZadCzQ5F0tlYEGWwxcBwzQ4JnlXImJRwoNRYZrA0eLL3qQ/smUO32LOuvWeNH
         qMLlgUZESMNI+uF7O9pM5WjGKPoDti0wrrJiGH/guMun4dGppt76bfw/QHRAQfOtRdbw
         rrlBNQoMIceJxfrMpoYS2y+O6r3SzZREoAy6xzaNZchgvhsJwfKlrJQ3ZPzHpDh1ZRcd
         3nMEd2wnwVUN3Q6OI3dmwIh0zcK9I6yHp0IJjFKpalZOcTzQDsLhXjcHPBdpHE+aBWTQ
         /5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXZmRT1smcUCqMURFiAzCFUsDXeE9fpWNRwPRAhsStQ=;
        b=4d+Co6m6+QaNS8lg8yQYVTtHFjznKFUqtpxVGdJTp79EQpACUF2hd/6OmYrRUnaAZA
         aozqWNROGNdgk/c0GUSGzrBO5fve5dJklNhqzo0rLiSNv/lq6yF+rwVddLjPOZHDQgPU
         ckbEepqDGJgOdviPoEgCUVFnzv8x0gELVvVgIwi8XD8vR1UHjjUlCULsYBO1r1XbBX2j
         Ck+6omUWzmko/HeVVRtm63TB/V6rDoWQG3PDJR+Ts5+OLJXQR3dQJw4MuQp1kAleB0x1
         +PPT3XxBYmkl4QEd5nHAQeRReGS/SbIaXHv1n+0EG5Hj9Kdal/EvA3PB7v782o27G3ij
         tOfw==
X-Gm-Message-State: ANoB5pko5kAQn8olWjCIVzgCyLDRAk8m9hJTNxukI/o4dwouG5wG9uFo
        yeKcpE4GeYsnhgkBo825gxo=
X-Google-Smtp-Source: AA0mqf6i8Bd2cMe6o5qoWsYwh3x8GSsf+n5RE3j9B4mbCMgilWU4xsLm42nHN70LZjZjQBEiGroNSw==
X-Received: by 2002:a63:121a:0:b0:477:6ccb:9f1d with SMTP id h26-20020a63121a000000b004776ccb9f1dmr1924798pgl.537.1668971451020;
        Sun, 20 Nov 2022 11:10:51 -0800 (PST)
Received: from macbook-pro-5.dhcp.thefacebook.com ([2620:10d:c090:400::5:7165])
        by smtp.gmail.com with ESMTPSA id p67-20020a625b46000000b0056bd59eaef0sm6992079pfb.4.2022.11.20.11.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 11:10:50 -0800 (PST)
Date:   Sun, 20 Nov 2022 11:10:47 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yonghong Song <yhs@meta.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v2 2/4] bpf: Add a kfunc to type cast from bpf
 uapi ctx to kernel ctx
Message-ID: <20221120191047.nt7zsgsbvocbgjyh@macbook-pro-5.dhcp.thefacebook.com>
References: <20221120161511.831691-1-yhs@fb.com>
 <20221120161522.833411-1-yhs@fb.com>
 <20221120183324.vlgassj34isouosg@macbook-pro-5.dhcp.thefacebook.com>
 <0703ccef-cb2e-3903-fe4d-e907b1b8ceea@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0703ccef-cb2e-3903-fe4d-e907b1b8ceea@meta.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Nov 20, 2022 at 10:55:54AM -0800, Yonghong Song wrote:
> 
> 
> On 11/20/22 10:33 AM, Alexei Starovoitov wrote:
> > On Sun, Nov 20, 2022 at 08:15:22AM -0800, Yonghong Song wrote:
> > > Implement bpf_cast_to_kern_ctx() kfunc which does a type cast
> > > of a uapi ctx object to the corresponding kernel ctx. Previously
> > > if users want to access some data available in kctx but not
> > > in uapi ctx, bpf_probe_read_kernel() helper is needed.
> > > The introduction of bpf_cast_to_kern_ctx() allows direct
> > > memory access which makes code simpler and easier to understand.
> > > 
> > > Signed-off-by: Yonghong Song <yhs@fb.com>
> > > ---
> > >   include/linux/btf.h   |  5 +++++
> > >   kernel/bpf/btf.c      | 25 +++++++++++++++++++++++++
> > >   kernel/bpf/helpers.c  |  6 ++++++
> > >   kernel/bpf/verifier.c | 21 +++++++++++++++++++++
> > >   4 files changed, 57 insertions(+)
> > > 
> > > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > > index d5b26380a60f..4b5d799f5d02 100644
> > > --- a/include/linux/btf.h
> > > +++ b/include/linux/btf.h
> > > @@ -470,6 +470,7 @@ const struct btf_member *
> > >   btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
> > >   		      const struct btf_type *t, enum bpf_prog_type prog_type,
> > >   		      int arg);
> > > +int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type prog_type);
> > >   bool btf_types_are_same(const struct btf *btf1, u32 id1,
> > >   			const struct btf *btf2, u32 id2);
> > >   #else
> > > @@ -514,6 +515,10 @@ btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
> > >   {
> > >   	return NULL;
> > >   }
> > > +static inline int get_kern_ctx_btf_id(struct bpf_verifier_log *log,
> > > +				      enum bpf_prog_type prog_type) {
> > > +	return -EINVAL;
> > > +}
> > >   static inline bool btf_types_are_same(const struct btf *btf1, u32 id1,
> > >   				      const struct btf *btf2, u32 id2)
> > >   {
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index 0a3abbe56c5d..bef1b6cfe6b8 100644
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -5603,6 +5603,31 @@ static int btf_translate_to_vmlinux(struct bpf_verifier_log *log,
> > >   	return kern_ctx_type->type;
> > >   }
> > > +int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type prog_type)
> > > +{
> > > +	const struct btf_member *kctx_member;
> > > +	const struct btf_type *conv_struct;
> > > +	const struct btf_type *kctx_type;
> > > +	u32 kctx_type_id;
> > > +
> > > +	conv_struct = bpf_ctx_convert.t;
> > > +	if (!conv_struct) {
> > > +		bpf_log(log, "btf_vmlinux is malformed\n");
> > > +		return -EINVAL;
> > > +	}
> > 
> > If we get to this point this internal pointer would be already checked.
> > No need to check it again. Just use it.
> 
> This is probably not true.
> 
> Currently, conv_struct is tested in function btf_get_prog_ctx_type() which
> is called by get_kfunc_ptr_arg_type().
> 
> const struct btf_member *
> btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
>                       const struct btf_type *t, enum bpf_prog_type
> prog_type,
>                       int arg)
> {
>         const struct btf_type *conv_struct;
>         const struct btf_type *ctx_struct;
>         const struct btf_member *ctx_type;
>         const char *tname, *ctx_tname;
> 
>         conv_struct = bpf_ctx_convert.t;
>         if (!conv_struct) {
>                 bpf_log(log, "btf_vmlinux is malformed\n");
>                 return NULL;
>         }
> 	...
> }
> 
> In get_kfunc_ptr_arg_type(),
> 
> ...
> 
>         /* In this function, we verify the kfunc's BTF as per the argument
> type,
>          * leaving the rest of the verification with respect to the register
>          * type to our caller. When a set of conditions hold in the BTF type
> of
>          * arguments, we resolve it to a known kfunc_ptr_arg_type.
>          */
>         if (btf_get_prog_ctx_type(&env->log, meta->btf, t,
> resolve_prog_type(env->prog), argno))
>                 return KF_ARG_PTR_TO_CTX;
> 
> Note that if bpf_ctx_convert.t is NULL, btf_get_prog_ctx_type() simply
> returns NULL and the logic simply follows through.

Right. It will return NULL and the code further won't see KF_ARG_PTR_TO_CTX
and will not call get_kern_ctx_btf_id().
So it still looks to me that the check can be dropped.

> Should we actually add a NULL checking for bpf_ctx_convert.t in
> bpf_parse_vmlinux?

Ideally yes, but right now CONFIG_DEBUG_INFO_BTF can be enabled
independently and I'm afraid btf_get_prog_ctx_type() can be called
via btf_translate_to_vmlinux() even when btf_vmlinux == NULL.
So bpf_ctx_convert.t == NULL at that point
because btf_parse_vmlinux wasn't called.

> 
> ...
>         err = btf_check_type_tags(env, btf, 1);
>         if (err)
>                 goto errout;
> 
>         /* btf_parse_vmlinux() runs under bpf_verifier_lock */
>         bpf_ctx_convert.t = btf_type_by_id(btf, bpf_ctx_convert_btf_id[0]);
> 
>         bpf_struct_ops_init(btf, log);
> ...
> 

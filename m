Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7273D629F7E
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 17:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiKOQrM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 11:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbiKOQrK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 11:47:10 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0683C1C914
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 08:47:10 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id 130so13777356pgc.5
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 08:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gw6o36XG0u5wXXSATGXL3ZlsjLB6ZQzQEtwNgPRmg/8=;
        b=GCp55Vxca5CXHR4Scjn2I/TOVr0NaRL/1o6jZYj02jffe6ZSDEdDcrj9+FlsrZK3ty
         XuJ2s+9xrIk0Z2+s3w78NlmM/G6Im95vamxxTmK7ksLnQMb64LIN8OTylil84j78hP/E
         WLq1NOVNvhMx7nJCrGlquvDiZ/DgEuabkEWg9T/rkw5SmJIFTPIBvQAkQFqJqbFvkc0N
         H9IB4J3HR4F3QKokuS3gDP0j5d6Adok+6dsjucKJGrQ4TEdULl0R9FEM4N5AofpREuU7
         AdsgUYWoYT0o7/0iaV03pUbltjWBkVIB29NK36LJ7+42XqRufAVNzT/XNWPf2PpmreF/
         EPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gw6o36XG0u5wXXSATGXL3ZlsjLB6ZQzQEtwNgPRmg/8=;
        b=vbYBf4A+HKJRqWa0MxfSmhe658ywO4/R0joS4tEyqYqAPz1qs2F62+3vxquhi6MhDh
         xR+NuMuwchxj7nLmNVc/ah4zfmYeU/SZVRapoRZDzEXq3745uc7DPGDkPZTtAHh5SGHT
         3xG2QAFnBb3eU/mznfuBkyEcHUwFmLFUNb90sE69XH8yTCPx7LBRy+2beDbgubauJzk/
         ahj61rPJOVx6/I0nLkhpKPkpYdSA262/kTjBRko7sHXrs9lGxfQJ+QRd5jevQ4KSPkR4
         wAYME03jPqoe8CDDTyzimiCMz6zYCQ9ZVQMXC40wixCWzefL673ApIkWa/eiXU+yvCT4
         VYww==
X-Gm-Message-State: ANoB5pmvaUqUlsCrRA9q2nPJeq7FNySteUXKgYm/V3T6dvjSlx0cmZ1N
        ZKbJHlperP2LDmNwtHYbQl8=
X-Google-Smtp-Source: AA0mqf4VgjmjDI7IUOqxxhWibufndVybMp0Dlm3VCtYQPHIqUjlimy52+9Ko4GFsuZU5UyGYfFQlfA==
X-Received: by 2002:a63:c5d:0:b0:42b:87fd:1077 with SMTP id 29-20020a630c5d000000b0042b87fd1077mr16999005pgm.478.1668530829405;
        Tue, 15 Nov 2022 08:47:09 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id e15-20020a170902784f00b00178acc7ef16sm9998667pln.253.2022.11.15.08.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 08:47:09 -0800 (PST)
Date:   Tue, 15 Nov 2022 22:17:04 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: Re: [PATCH bpf-next v7 08/26] bpf: Introduce allocated objects
 support
Message-ID: <20221115164704.ab74gul36mcscnlw@apollo>
References: <20221114191547.1694267-1-memxor@gmail.com>
 <20221114191547.1694267-9-memxor@gmail.com>
 <20221115054818.r7p3jbqg352obbb6@macbook-pro-5.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115054818.r7p3jbqg352obbb6@macbook-pro-5.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 15, 2022 at 11:18:18AM IST, Alexei Starovoitov wrote:
> On Tue, Nov 15, 2022 at 12:45:29AM +0530, Kumar Kartikeya Dwivedi wrote:
> > Introduce support for representing pointers to objects allocated by the
> > BPF program, i.e. PTR_TO_BTF_ID that point to a type in program BTF.
> > This is indicated by the presence of MEM_ALLOC type flag in reg->type to
> > avoid having to check btf_is_kernel when trying to match argument types
> > in helpers.
> >
> > Whenever walking such types, any pointers being walked will always yield
> > a SCALAR instead of pointer. In the future we might permit kptr inside
> > such allocated objects (either kernel or local), and it will then form a
>
> (either kernel or program allocated) ?
>
> > PTR_TO_BTF_ID of the respective type.
> >
> > For now, such allocated objects will always be referenced in verifier
> > context, hence ref_obj_id == 0 for them is a bug. It is allowed to write
> > to such objects, as long fields that are special are not touched
> > (support for which will be added in subsequent patches). Note that once
> > such a pointer is marked PTR_UNTRUSTED, it is no longer allowed to write
> > to it.
> >
> > No PROBE_MEM handling is therefore done for loads into this type unless
> > PTR_UNTRUSTED is part of the register type, since they can never be in
> > an undefined state, and their lifetime will always be valid.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  include/linux/bpf.h   | 11 +++++++++++
> >  kernel/bpf/btf.c      |  5 +++++
> >  kernel/bpf/verifier.c | 25 +++++++++++++++++++++++--
> >  3 files changed, 39 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 49f9d2bec401..3cab113b149e 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -524,6 +524,11 @@ enum bpf_type_flag {
> >  	/* Size is known at compile time. */
> >  	MEM_FIXED_SIZE		= BIT(10 + BPF_BASE_TYPE_BITS),
> >
> > +	/* MEM is of a an allocated object of type from program BTF. This is
> > +	 * used to tag PTR_TO_BTF_ID allocated using bpf_obj_new.
> > +	 */
> > +	MEM_ALLOC		= BIT(11 + BPF_BASE_TYPE_BITS),
> > +
> >  	__BPF_TYPE_FLAG_MAX,
> >  	__BPF_TYPE_LAST_FLAG	= __BPF_TYPE_FLAG_MAX - 1,
> >  };
> > @@ -2791,4 +2796,10 @@ struct bpf_key {
> >  	bool has_ref;
> >  };
> >  #endif /* CONFIG_KEYS */
> > +
> > +static inline bool type_is_alloc(u32 type)
> > +{
> > +	return type & MEM_ALLOC;
> > +}
> > +
> >  #endif /* _LINUX_BPF_H */
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 875355ff3718..9a596f430558 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -6034,6 +6034,11 @@ int btf_struct_access(struct bpf_verifier_log *log,
> >
> >  		switch (err) {
> >  		case WALK_PTR:
> > +			/* For local types, the destination register cannot
> > +			 * become a pointer again.
> > +			 */
> > +			if (type_is_alloc(reg->type))
> > +				return SCALAR_VALUE;
> >  			/* If we found the pointer or scalar on t+off,
> >  			 * we're done.
> >  			 */
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 5e74f460dfd0..d726d55622c9 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -4687,14 +4687,27 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
> >  		return -EACCES;
> >  	}
> >
> > -	if (env->ops->btf_struct_access) {
> > +	if (env->ops->btf_struct_access && !type_is_alloc(reg->type)) {
> > +		if (!btf_is_kernel(reg->btf)) {
> > +			verbose(env, "verifier internal error: reg->btf must be kernel btf\n");
> > +			return -EFAULT;
> > +		}
> >  		ret = env->ops->btf_struct_access(&env->log, reg, off, size, atype, &btf_id, &flag);
> >  	} else {
> > -		if (atype != BPF_READ) {
> > +		/* Writes are permitted with default btf_struct_access for local
> > +		 * kptrs (which always have ref_obj_id > 0), but not for
>
> for program allocated objects (which always have ref_obj_id > 0) ?
>

Ack for both.

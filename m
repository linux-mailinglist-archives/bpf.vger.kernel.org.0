Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BF9592ADF
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 10:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiHOH3H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 03:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiHOH3G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 03:29:06 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D023017E38
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 00:29:04 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id uj29so12219045ejc.0
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 00:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=Nx662cGDnlj30CoMEkkI485lphVgALggLEXbyWaJSA8=;
        b=KBROkE7Io2BFZZENbrtK5kmOPqLWvbSKUtzSOBTUd55+w9jrhRTDUcKw/CMWoW/Yxq
         +JqITxmACShD09N0fCEjmZQWjwcmybfPFZM78+miH4o6bARQgv5/OR3f3nANDHe4S5l0
         uE3K+yEB7xd4pYzICSIhLR3fT+b7SdiTuQE45aUwtu+1W5rZdi4t/qRUZVwydKgieRGa
         c3EiuPBe3ge9a7ZRVLxZeeidUWHJg6wYCx0ldK6ZhWnIMipQ/tm3cIiOITfcvBS+6lJx
         wHw+mC+rT2P2g4iSzKJJyvar8DoE+qyc4aXvz23XA4VXMbPtc8UGVIH53EuZzK7SChEk
         /CkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=Nx662cGDnlj30CoMEkkI485lphVgALggLEXbyWaJSA8=;
        b=K0IeRPZIlnhQDt2nWgGsqfZp2bCueTrSAx20Id6bo65PWn3OM5YWiHT3HkhcpPETmw
         NgyHauaF3zbBDHCNoJJhNtj4fXJz/LEU2EvTAQOFJJSVhb+u7vBroI9MHrs3Wg9go3d8
         ZedYVSJFP4kJPIqBBSgv0DU4+Eyo8FKHDLEPcCONLJFhTwnP0u4H7X3P2UtmZ724zfvy
         3em1OT5clehPEQ/h8ELevyhkOQFYnQqUF0rkJNub36QvD5yRBpF4SPbZPgHwVA9Y9RTv
         uaWxZn8M4p7/9OwZFOEZnFgj0gMOFPFRUzpzJntAs9C8qi03p3wRsretGMmzWnYCw1Vz
         7VzQ==
X-Gm-Message-State: ACgBeo2FykeHMftqDTjZBn10v5KA9DZaSLxaFlC5g0Ofp03SAiEWfOYN
        FWL3IP7sXzOJtGpWozHurnnMPSyRBqhiPA==
X-Google-Smtp-Source: AA6agR5OsxFFggBPmr+R33TF5WNdKGVAhNsZbB7FoJ8Ii7945LbJKk5IsELJLjVuWwMKcWtgdgxlHw==
X-Received: by 2002:a17:907:7d90:b0:738:2f9b:9869 with SMTP id oz16-20020a1709077d9000b007382f9b9869mr5482212ejc.186.1660548543392;
        Mon, 15 Aug 2022 00:29:03 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id n11-20020a17090695cb00b0072f9dc2c246sm3694517ejy.133.2022.08.15.00.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 00:29:03 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 15 Aug 2022 09:29:01 +0200
To:     Yonghong Song <yhs@fb.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v2 3/6] bpf: x86: Support in-register struct
 arguments
Message-ID: <Yvn1vWwU/TMGHjRo@krava>
References: <20220812052419.520522-1-yhs@fb.com>
 <20220812052435.523068-1-yhs@fb.com>
 <YvlZ+ETaaTD3hwrM@krava>
 <ddc5550d-b820-6975-a4dc-53e3656a66d0@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddc5550d-b820-6975-a4dc-53e3656a66d0@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Aug 14, 2022 at 10:29:11PM -0700, Yonghong Song wrote:
> 
> 
> On 8/14/22 1:24 PM, Jiri Olsa wrote:
> > On Thu, Aug 11, 2022 at 10:24:35PM -0700, Yonghong Song wrote:
> > 
> > SNIP
> > 
> > >   }
> > >   static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
> > > @@ -2020,6 +2081,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
> > >   	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
> > >   	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
> > >   	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
> > > +	int struct_val_off, extra_nregs = 0;
> > >   	u8 **branches = NULL;
> > >   	u8 *prog;
> > >   	bool save_ret;
> > > @@ -2028,6 +2090,20 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
> > >   	if (nr_args > 6)
> > >   		return -ENOTSUPP;
> > > +	for (i = 0; i < MAX_BPF_FUNC_ARGS; i++) {
> > > +		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG) {
> > > +			/* Only support up to 16 bytes struct which should keep
> > > +			 * values in registers.
> > > +			 */
> > 
> > it seems that if the struct contains 'double' field, it's passed in
> > SSE register, which we don't support is save/restore
> 
> That is right.
> 
> > 
> > we should probably check struct's BTF in btf_distill_func_proto and
> > fail if we found anything else than regular regs types?
> 
> The reason I didn't add float/double checking is that I didn't actually
> find any float/double struct members in either vmlinux.h or in
> arch/x86 directory. Could you help double check as well?

ok I checked on fedora's BTF and could not find any

still the check might be good or at least mention
that in comment

> 
> > 
> > > +			if (m->arg_size[i] > 16)
> > > +				return -ENOTSUPP;
> > > +
> > > +			extra_nregs += (m->arg_size[i] + 7) / 8 - 1;
> > > +		}
> > > +	}
> > > +	if (nr_args + extra_nregs > 6)
> > 
> > should this value be minus the number of actually found struct arguments?
> 
> In the above we have
> 	extra_nregs += (m->arg_size[i] + 7) / 8 - 1;
> already did the 'minus' part.

there it is ;-) ok

jirka

> 
> > 
> > > +		return -ENOTSUPP;
> > > +
> > >   	/* Generated trampoline stack layout:
> > >   	 *
> > >   	 * RBP + 8         [ return address  ]
> > > @@ -2066,6 +2142,13 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
> > >   	stack_size += (sizeof(struct bpf_tramp_run_ctx) + 7) & ~0x7;
> > >   	run_ctx_off = stack_size;
> > > +	/* For structure argument */
> > > +	for (i = 0; i < MAX_BPF_FUNC_ARGS; i++) {
> > > +		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
> > > +			stack_size += (m->arg_size[i] + 7) & ~0x7;
> > > +	}
> > > +	struct_val_off = stack_size;
> > 
> > could you please update the 'Generated trampoline stack layout' table
> > above with this offset
> 
> Okay, will do in the next revision.
> 
> > 
> > thanks,
> > jirka
> > 
> > > +
> > >   	if (flags & BPF_TRAMP_F_SKIP_FRAME) {
> > >   		/* skip patched call instruction and point orig_call to actual
> > >   		 * body of the kernel function.
> > > @@ -2101,7 +2184,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
> > >   		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -ip_off);
> > >   	}
> > > -	save_regs(m, &prog, nr_args, regs_off);
> > > +	save_regs(m, &prog, nr_args, regs_off, struct_val_off);
> > >   	if (flags & BPF_TRAMP_F_CALL_ORIG) {
> > >   		/* arg1: mov rdi, im */
> > > @@ -2131,7 +2214,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
> > >   	}
> > >   	if (flags & BPF_TRAMP_F_CALL_ORIG) {
> > > -		restore_regs(m, &prog, nr_args, regs_off);
> > > +		restore_regs(m, &prog, nr_args, regs_off, struct_val_off);
> > >   		if (flags & BPF_TRAMP_F_ORIG_STACK) {
> > >   			emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, 8);
> > > @@ -2172,7 +2255,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
> > >   		}
> > >   	if (flags & BPF_TRAMP_F_RESTORE_REGS)
> > > -		restore_regs(m, &prog, nr_args, regs_off);
> > > +		restore_regs(m, &prog, nr_args, regs_off, struct_val_off);
> > >   	/* This needs to be done regardless. If there were fmod_ret programs,
> > >   	 * the return value is only updated on the stack and still needs to be
> > > -- 
> > > 2.30.2
> > > 

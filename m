Return-Path: <bpf+bounces-72083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C73C060B2
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 13:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32E0C3A6E14
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 11:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14603128C0;
	Fri, 24 Oct 2025 11:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKtIE3ce"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53744312814
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 11:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761305641; cv=none; b=W/6/q2VQNtgf5w/qc5geaRVhdC2pk1bkDIAo4G8SEqD8t0+tcoYxCZsTY6rMJhx/uaGmwEmeF1D7KDqbVRNAQeWm7A+3cjVj8DoOiCjXiNQEHnsOYla7m4uItLF0L3p73tcExdLEHHUXh0+qw2RI+4DMazKP1MiXHQhAygNcu1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761305641; c=relaxed/simple;
	bh=Y3gU75x14jqIPczSSN8e2kgpFShAj76PyOlyJWs2Axo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXXdk11IMJyLvSXN8WvqeOZi3FRBP5KkxWlsTBASwHf1a9kPLyuZv4Frzi4xbjVIu1YqI/ZCqZrmhp9pgWA3v0zCDQzFaK8mY9vs6/iXVGzMX43yohTv8B8jfcd5FucUgIylvo9TwvTDXEW8Ds/3oHGWgH3zeC85Dzc4QiKymBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKtIE3ce; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-471191ac79dso20887325e9.3
        for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 04:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761305637; x=1761910437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SQBh0CYrDS616/8l1WwWNdxbTezqsw82Lzxk7tZ2eSg=;
        b=LKtIE3ceuJ3GRwHcMjc8Wj6q5TgKuUKiTcqHbOt5Dwh/IMeBLn706NGGXu6/Zg7yjO
         Fjsa1wuRsMegX+98hQpj3oV9gvfxsl2raNlvPm2z6euCEmsAu/yFxyNAgLXEcyUFlqxN
         4bAkR0wsbqJMwZKdrOVMaYwcTE3SOk5fwjtISbU9J2tHwpuS737e/zi0xkR1kneSV4TP
         xBiF+0wLvfFiNAsAzPJWqDPfjNVewxiPJG/tmghNLveOOYpL93n3tOqK+eBBkblzaDBQ
         nD2Q/ayDFfGuyqbJvO6h+dNIMx5t6RE+g/GXmOS46lHeGy3ihfJH3obkPprACQsP4Z3z
         CPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761305637; x=1761910437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQBh0CYrDS616/8l1WwWNdxbTezqsw82Lzxk7tZ2eSg=;
        b=lDKYLik0o3eV7S6sXEWEcgpddh/h37JuyxLJCeJt4oMHvMSMjarjpyPaCK32671F1A
         /eRFZsYSQBwp13B44bylWtx+JIeVjhnQIUUGNh/qz/D0VIFaxw1/KYstRgTld3VtND42
         hx4c+CXMiUkMdB2fGFwBEhOpomhyEN5JV8HKxccxr9lLhpilP/YVWcM1OjqDqRmTq1au
         Lh5qEJMASy8Jl8b10i6mIoI23Fqr19p8KAfTs5CiKVa63sHdJqs/sUXPcuGg6yF9ztdK
         2xm1z+S2/tbD/bBDI1dFjGzQPdeZ/jYct0kH29w6TmMhWl+12AL9LCftNRvPS7cV1Xds
         Q0jA==
X-Gm-Message-State: AOJu0Yxs70Q+mSQRZSSPpJW2ZcJboY8rH+dfQUxCS8fo20ifFxpCgFD6
	XjrsuHexwaHwT4ewVT4RepkLH9UIfpbAak/ZNjikIg8FVhz4YmZE3nH/RkS+Lg==
X-Gm-Gg: ASbGncsC+3yzMq9WKx7dycMUqqa8didXSMflbbp7Mkd/Jg8J4t41sP0uO2EFFSErwF/
	aHJHusKwdtV/jmEMgqcdEm0Py6Uc7I5x7qRlqPDOYQF+lu41R6N2twR1cwVoh/h6GmTyu2vC65q
	IhoiWLPnt086pB3JkuyzqlYru6TbRjiTIdQf+4d/Hx8v6d9PZaM1NDE+2ze958+kL+Vji6eS9OC
	D/U27a3IXttfIOXYCMvmI7Cp9+69bXENSuLyvGXXEVRArD7qT6tCH0eLY46pudwZRZ2z0OB0018
	jINIJ1lPV/DOKvbcXk7WceNe7sn0uCb+sInOAhmkBW3GU3bPvhag4A8wB70pJw/4I8tDIW0EAau
	n2PLUlkPqZQTv7RBI4tAXd9w/gWxx6ztlolyzB/bfE34RSmsAR4nJf/BiBhANaAikIQPacHgs50
	5JEGcV7T0JNMM4LhB6j/jl
X-Google-Smtp-Source: AGHT+IH9ZGTWlkjil9y6DuU60XSOE4zYt4ArBsjd/mFnW4JKFwC1K3X4lNbApwm7YQNtGS29Xzf8ug==
X-Received: by 2002:a05:600c:a08e:b0:46f:c55a:5a8d with SMTP id 5b1f17b1804b1-475d2e78fd3mr18135765e9.4.1761305637318;
        Fri, 24 Oct 2025 04:33:57 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475d8172443sm11454875e9.11.2025.10.24.04.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 04:33:56 -0700 (PDT)
Date: Fri, 24 Oct 2025 11:40:38 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v6 bpf-next 16/17] selftests/bpf: add new verifier_gotox
 test
Message-ID: <aPtltvv+WHPMEnNt@mail.gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
 <20251019202145.3944697-17-a.s.protopopov@gmail.com>
 <b0e59e59fbe35090809ccbe0b01d923212c789ab.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0e59e59fbe35090809ccbe0b01d923212c789ab.camel@gmail.com>

On 25/10/21 03:42PM, Eduard Zingerman wrote:
> On Sun, 2025-10-19 at 20:21 +0000, Anton Protopopov wrote:
> > Add a set of tests to validate core gotox functionality
> > without need to rely on compilers.
> > 
> > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > ---
> 
> Thank you for adding these.
> Could you please also add a test cases that checks the following errors:
> - "jump table for insn %d points outside of the subprog [%u,%u]"
> - "the sum of R%u umin_value %llu and off %u is too big\n"
> - "register R%d doesn't point to any offset in map id=%d\n"

Yeah, sorry, these actually were on my list, but I've postponed them
for the next version. Will add. (I also need to add a few selftests
on the offset when loading from map.)

> 
> Might be the case that some of these can't be triggered because of the
> check_mem_access() call.
> 
> [...]
> 
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_gotox.c b/tools/testing/selftests/bpf/progs/verifier_gotox.c
> > new file mode 100644
> > index 000000000000..1a92e4d321e8
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c
> 
> [...]
> 
> > +/*
> > + * Gotox is forbidden when there is no jump table loaded
> > + * which points to the sub-function where the gotox is used
> > + */
> > +SEC("socket")
> > +__failure __msg("no jump tables found for subprog starting at 0")
>                                                               ^^^^
> 				Nit: one day we need to figure out a way to
> 				     report subprogram names, when reporting
> 				     check_cfg() errors.

But those are not always present, right?

> 
> > +__naked void jump_table_no_jump_table(void)
> > +{
> > +	asm volatile ("						\
> > +	.8byte %[gotox_r0];					\
> > +	r0 = 1;							\
> > +	exit;							\
> > +"	:							\
> > +	: __imm_insn(gotox_r0, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_0, 0, 0 , 0))
> > +	: __clobber_all);
> > +}
> > +
> > +/*
> > + * Incorrect type of the target register, only PTR_TO_INSN allowed
> > + */
> > +SEC("socket")
> > +__failure __msg("R1 has type 1, expected PTR_TO_INSN")
>                            ^^^^^^
> 	      log.c:reg_type_str() should help here.

Yes, thanks, this was changed to address your comment
in the other patch.

> > +__naked void jump_table_incorrect_dst_reg_type(void)
> > +{
> > +	asm volatile ("						\
> > +	.pushsection .jumptables,\"\",@progbits;		\
> > +jt0_%=:								\
> > +	.quad ret0_%=;						\
> > +	.quad ret1_%=;						\
> > +	.size jt0_%=, 16;					\
> > +	.global jt0_%=;						\
> > +	.popsection;						\
> > +								\
> > +	r0 = jt0_%= ll;						\
> > +	r0 += 8;						\
> > +	r0 = *(u64 *)(r0 + 0);					\
> > +	r1 = 42;						\
> > +	.8byte %[gotox_r1];					\
> > +	ret0_%=:						\
> > +	r0 = 0;							\
> > +	exit;							\
> > +	ret1_%=:						\
> > +	r0 = 1;							\
> > +	exit;							\
> > +"	:							\
> > +	: __imm_insn(gotox_r1, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_1, 0, 0 , 0))
> > +	: __clobber_all);
> > +}
> > +
> > +#define DEFINE_INVALID_SIZE_PROG(READ_SIZE, OUTCOME)			\
> 
> Nit: this can be merged with DEFINE_SIMPLE_JUMP_TABLE_PROG.

Didn't want to overload the macro too much so the prog stays
readable. (Here are two different regs are used.) I will check
how it looks like if I merge them, and merge, if it looks ok-ish.

> > +									\
> > +	SEC("socket")							\
> > +	OUTCOME								\
> > +	__naked void jump_table_invalid_read_size_ ## READ_SIZE(void)	\
> > +	{								\
> > +		asm volatile ("						\
> > +		.pushsection .jumptables,\"\",@progbits;		\
> > +	jt0_%=:								\
> > +		.quad ret0_%=;						\
> > +		.quad ret1_%=;						\
> > +		.size jt0_%=, 16;					\
> > +		.global jt0_%=;						\
> > +		.popsection;						\
> > +									\
> > +		r0 = jt0_%= ll;						\
> > +		r0 += 8;						\
> > +		r0 = *(" #READ_SIZE " *)(r0 + 0);			\
> > +		.8byte %[gotox_r0];					\
> > +		ret0_%=:						\
> > +		r0 = 0;							\
> > +		exit;							\
> > +		ret1_%=:						\
> > +		r0 = 1;							\
> > +		exit;							\
> > +	"	:							\
> > +		: __imm_insn(gotox_r0, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_0, 0, 0 , 0)) \
> > +		: __clobber_all);					\
> > +	}
> > +
> > +DEFINE_INVALID_SIZE_PROG(u32, __failure __msg("Invalid read of 4 bytes from insn_array"))
> > +DEFINE_INVALID_SIZE_PROG(u16, __failure __msg("Invalid read of 2 bytes from insn_array"))
> > +DEFINE_INVALID_SIZE_PROG(u8,  __failure __msg("Invalid read of 1 bytes from insn_array"))
> 
> [...]


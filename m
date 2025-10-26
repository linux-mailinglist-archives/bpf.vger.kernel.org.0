Return-Path: <bpf+bounces-72230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E14C0A6F7
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 13:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 37BFC34705E
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 12:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF57721E087;
	Sun, 26 Oct 2025 12:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYDXnlUh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCA37483
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 12:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761481664; cv=none; b=fXYBdl/LD8Kf4Rs0cIDNsrRTWqPmXTe9Glv4/dzFJJ7Pweif/MqRdnMtcpgEUKyCbW5qrUsWRfV5brCefP+rX7WF5G+peq6mOxWE192PHCGofpEPb/M1vt1CaPi6S2F/7/e/UbD7mQkeeKUu1IJJV85nP7AT5ZvlQ+V7+uK4H/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761481664; c=relaxed/simple;
	bh=vN7vq63DYimrifF2gRdY6Kq9IR6IHE+jAV5HCN4ixV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNyyrQVsYmndUR9V8fxqUwCnN9TrtnmcdHatiUDihvqqtPFo79bH4lpPpp5bUeEuLCRTOIraMPgbs7YNhcVm7FnZFhLPxYm3/6jUSSIm9XHr9eNXPK2j8mjS6VsZ1idKx7nZKK5/MykG/HheSsgluWtaSHf6yhhkpfrNSZHSrMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYDXnlUh; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47114a40161so40726595e9.3
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 05:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761481661; x=1762086461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2vc58ekBNXfQujPrq87lImkUZHBHCJNbrBLZ8gnd45s=;
        b=fYDXnlUhysXA2CyIwHvcNqvVoNga7YytubMxeAwuj5g5+5UcxO1Qqs/BHhx4wt4Ie2
         5sfuAqBxZWtoCJgrwJsie7yF8CsJ0J9dk7+wp44x8YsM7GcbITi8QjjMU7r5bq9nAXja
         c+GdDXssjttkvt7XwvEKw47X0a4ItHMKM/PcJ/dxPB5jzuRSKYVqvVaxKcrX3pTJddIf
         Thj44WhN//xPprNerBJYCgrGnQZMXGXLQU4DAqZrr81hpbJ9pqkjvA+754ew/avuEHnU
         obShHjQgvh3jfgU/ecPseqSWsJ6C5oO3o0mpyuzWmnsE7xFg0DEQZJr0/bZGXIfweiwM
         RBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761481661; x=1762086461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2vc58ekBNXfQujPrq87lImkUZHBHCJNbrBLZ8gnd45s=;
        b=W/Mk86DELG4wJwJ1Zi9rZ5hNAYFU6ynHFY9wtw7AbGahf9/v9k7ltkiq9rXsMcqGvP
         JKy9G2Vi75wDqHco/g7ZQ7fCk/92wZ8+yE5xso9TyISW0NuuTjOkUAz6U8je+eK1QtDH
         cIx/uaCAzPEa3KSJQkPgsGsdyZWqMvU/NzQJchE+Mf2zKDEQRIcHJiWI5N1bpi/XHdOg
         P6JDhTigbmD9j/0kz8ym3eHkyLPXR+uUwWTiOgvLjUzHaNBailU5BpgiH5usvWfo0ccr
         Ur9+nvmENZnKpntaw0hPQKVp9uRnVmM/hP4fGmTzMwBt9w+WTgCrD5DXATk9XH+7m3LV
         r9lw==
X-Gm-Message-State: AOJu0Yw1rQnTsGwbchWrvx8aXsBtwih2ICWzFEjhCYZasLfDNBzregjR
	x8+M+rqV4xjg9fCNZXfBl8NQeLPgw8Q177fwpiOBLdTxPPR5pxvnzIDm
X-Gm-Gg: ASbGncu0kOCNg7azieM9Yl3RwkjxtlKJBui1G4MZtuKpAad8eptm9jPWNFQv+KbHSjD
	HhiuKqlvfbzq6o/wnfcsYqNErfzzw9+3xR6UiBHXp1cBg+BOwl5AhmXk0kC6PkHkGJqdJ7oEJJw
	AWV51yl2jlHc0ewj3eeYlLfWgYEABHBPMprmbb5GOARFSpQSVzruvBR/3npJOTsEVFw5v8Jh0+p
	4R6DLdMdRdAxlg5tK9WP1IHD98CUNW46S0XZldLdBDlV7pd7AGKGwriKG+HvyiLl7hMlQyJeZG4
	Avzh0YS/uolzmfpogEnfu4r7hkDJK20WkKXHI91MFL35rUvWsoTWfvcv4VdWa3XHc/RVhn9kdzC
	9hSjKF4iX2TK4oiM52bRPX2+IwtjLKoSL6ZuQmBaDgNn8iFn8t/VdF2XA+ePFISVxV5hQlb3tUK
	jLYE+/BqvarQ==
X-Google-Smtp-Source: AGHT+IGwdeQuuxmyw+bWYBsi03qv6oGpsftG6MHOTygoBapASDQuKU7KQbziAX4X15H2gEDAyAjswA==
X-Received: by 2002:a05:600c:524c:b0:475:d952:342e with SMTP id 5b1f17b1804b1-475d9523a29mr50618835e9.35.1761481660696;
        Sun, 26 Oct 2025 05:27:40 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475ddd41a5esm37890255e9.5.2025.10.26.05.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 05:27:40 -0700 (PDT)
Date: Sun, 26 Oct 2025 12:34:21 +0000
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
Message-ID: <aP4VTXG6n7XYnm23@mail.gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
 <20251019202145.3944697-17-a.s.protopopov@gmail.com>
 <b0e59e59fbe35090809ccbe0b01d923212c789ab.camel@gmail.com>
 <aPtltvv+WHPMEnNt@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPtltvv+WHPMEnNt@mail.gmail.com>

On 25/10/24 11:40AM, Anton Protopopov wrote:
> On 25/10/21 03:42PM, Eduard Zingerman wrote:
> > On Sun, 2025-10-19 at 20:21 +0000, Anton Protopopov wrote:
> > > Add a set of tests to validate core gotox functionality
> > > without need to rely on compilers.
> > > 
> > > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > > ---
> > 
> > Thank you for adding these.
> > Could you please also add a test cases that checks the following errors:
> > - "jump table for insn %d points outside of the subprog [%u,%u]"
> > - "the sum of R%u umin_value %llu and off %u is too big\n"
> > - "register R%d doesn't point to any offset in map id=%d\n"
> 
> Yeah, sorry, these actually were on my list, but I've postponed them
> for the next version. Will add. (I also need to add a few selftests
> on the offset when loading from map.)

So, tbh, I can't actually find a way to trigger any of them,
looks like these conditions are always caught earlier...

> > 
> > Might be the case that some of these can't be triggered because of the
> > check_mem_access() call.
> > 
> > [...]
> > 
> > > diff --git a/tools/testing/selftests/bpf/progs/verifier_gotox.c b/tools/testing/selftests/bpf/progs/verifier_gotox.c
> > > new file mode 100644
> > > index 000000000000..1a92e4d321e8
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c
> > 
> > [...]
> > 
> > > +/*
> > > + * Gotox is forbidden when there is no jump table loaded
> > > + * which points to the sub-function where the gotox is used
> > > + */
> > > +SEC("socket")
> > > +__failure __msg("no jump tables found for subprog starting at 0")
> >                                                               ^^^^
> > 				Nit: one day we need to figure out a way to
> > 				     report subprogram names, when reporting
> > 				     check_cfg() errors.
> 
> But those are not always present, right?
> 
> > 
> > > +__naked void jump_table_no_jump_table(void)
> > > +{
> > > +	asm volatile ("						\
> > > +	.8byte %[gotox_r0];					\
> > > +	r0 = 1;							\
> > > +	exit;							\
> > > +"	:							\
> > > +	: __imm_insn(gotox_r0, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_0, 0, 0 , 0))
> > > +	: __clobber_all);
> > > +}
> > > +
> > > +/*
> > > + * Incorrect type of the target register, only PTR_TO_INSN allowed
> > > + */
> > > +SEC("socket")
> > > +__failure __msg("R1 has type 1, expected PTR_TO_INSN")
> >                            ^^^^^^
> > 	      log.c:reg_type_str() should help here.
> 
> Yes, thanks, this was changed to address your comment
> in the other patch.
> 
> > > +__naked void jump_table_incorrect_dst_reg_type(void)
> > > +{
> > > +	asm volatile ("						\
> > > +	.pushsection .jumptables,\"\",@progbits;		\
> > > +jt0_%=:								\
> > > +	.quad ret0_%=;						\
> > > +	.quad ret1_%=;						\
> > > +	.size jt0_%=, 16;					\
> > > +	.global jt0_%=;						\
> > > +	.popsection;						\
> > > +								\
> > > +	r0 = jt0_%= ll;						\
> > > +	r0 += 8;						\
> > > +	r0 = *(u64 *)(r0 + 0);					\
> > > +	r1 = 42;						\
> > > +	.8byte %[gotox_r1];					\
> > > +	ret0_%=:						\
> > > +	r0 = 0;							\
> > > +	exit;							\
> > > +	ret1_%=:						\
> > > +	r0 = 1;							\
> > > +	exit;							\
> > > +"	:							\
> > > +	: __imm_insn(gotox_r1, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_1, 0, 0 , 0))
> > > +	: __clobber_all);
> > > +}
> > > +
> > > +#define DEFINE_INVALID_SIZE_PROG(READ_SIZE, OUTCOME)			\
> > 
> > Nit: this can be merged with DEFINE_SIMPLE_JUMP_TABLE_PROG.
> 
> Didn't want to overload the macro too much so the prog stays
> readable. (Here are two different regs are used.) I will check
> how it looks like if I merge them, and merge, if it looks ok-ish.
> 
> > > +									\
> > > +	SEC("socket")							\
> > > +	OUTCOME								\
> > > +	__naked void jump_table_invalid_read_size_ ## READ_SIZE(void)	\
> > > +	{								\
> > > +		asm volatile ("						\
> > > +		.pushsection .jumptables,\"\",@progbits;		\
> > > +	jt0_%=:								\
> > > +		.quad ret0_%=;						\
> > > +		.quad ret1_%=;						\
> > > +		.size jt0_%=, 16;					\
> > > +		.global jt0_%=;						\
> > > +		.popsection;						\
> > > +									\
> > > +		r0 = jt0_%= ll;						\
> > > +		r0 += 8;						\
> > > +		r0 = *(" #READ_SIZE " *)(r0 + 0);			\
> > > +		.8byte %[gotox_r0];					\
> > > +		ret0_%=:						\
> > > +		r0 = 0;							\
> > > +		exit;							\
> > > +		ret1_%=:						\
> > > +		r0 = 1;							\
> > > +		exit;							\
> > > +	"	:							\
> > > +		: __imm_insn(gotox_r0, BPF_RAW_INSN(BPF_JMP | BPF_JA | BPF_X, BPF_REG_0, 0, 0 , 0)) \
> > > +		: __clobber_all);					\
> > > +	}
> > > +
> > > +DEFINE_INVALID_SIZE_PROG(u32, __failure __msg("Invalid read of 4 bytes from insn_array"))
> > > +DEFINE_INVALID_SIZE_PROG(u16, __failure __msg("Invalid read of 2 bytes from insn_array"))
> > > +DEFINE_INVALID_SIZE_PROG(u8,  __failure __msg("Invalid read of 1 bytes from insn_array"))
> > 
> > [...]


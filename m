Return-Path: <bpf+bounces-72553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E26C15509
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 16:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5E28500904
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 15:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98393396F4;
	Tue, 28 Oct 2025 14:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIxRRktd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910DD31815D
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761663551; cv=none; b=pyfSJ64C52MZNp1ce/tHbZauYVDrk2mEFlGg+0pKgjSugLtevUEUhgpcodMM67g4WDEPdoM7jJrEarwBirHGtS9eoyqOXpKuCMcuNF5dhIrDZ934qfUwvJ7t044COzidlknSCHF8mOUD5UsWHwk96is95OfwUJwqgZn0S1uXqj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761663551; c=relaxed/simple;
	bh=m8DCIVaxTeasPR4QZ9qG4yxDX42vr38meJ1MfR+IWJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aR51igU1CYcpO4/fsNC3XTpf6ZROKOKFXx2lL/bdAY3W6WmPALKEP9hrcvA6QOmmix7f6V6bzLWqIT6Ak+U/KK7bLoH99j7SoGMVo8XnuzajaNZ+udLjEyQ97m0Xz1cVVpvUrH50Df6gI+vk18ECy+VLUawbtJStKxi/X3X6yH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIxRRktd; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42557c5cedcso3956444f8f.0
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 07:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761663548; x=1762268348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PI/PZuI71Hv9kIf1B5g7KheAwRmAq5KrbWDu/HPN2HA=;
        b=HIxRRktdANNpCYh3jszqtRKcgpmSsr5en8xWbGTFGBoHU0n23RWTfynH0rapLNejkU
         9DNhRseeZ/IbXQ5BF7J9VQjHznsXKeUppYHe5m4DVe22TMcKXOArHymx5sE8G3TYWonm
         9LoCNO53jOyDfSQXefm2vrZ8vb5GT3YZXJeQGjSC4t9B2X1hzKeRPREH4NVBePAloJTB
         K7UIWvU7CqS4pmlu7ablwIpZD69oI2RU+wd5R3MuNMRP9FIU3F4BVfkBP7Gj7ejxd4jN
         Z8VMem3MMT6IaPvDa1KDjdCGRloj/9vFCGNYeIiIMqWJmf5/DIfdTXwSizSyCvgpVBdf
         iPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761663548; x=1762268348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PI/PZuI71Hv9kIf1B5g7KheAwRmAq5KrbWDu/HPN2HA=;
        b=pMIabg/kofDDp6YF5jpjOq2Yd5guDIHXNoHIqPxExd8HC++v7vIxrBTxZmACHb4u4z
         Atz3xWfN1ghvn07IKvjrTszrUPrOOb+or5mm+Ty6SWpbtkozp7NF6SKlZ4l3tcWRX2Yy
         z3ZVlXOyoXp23+gQyeXP0M6BfkNzh+EOmrPoxhqT2okndmumLoOxrH3THK1nw1FZQ/rb
         UuBWarzcxU4S+ujpImvZHW4YPb12y4Wb++JwwCxy4MX+1SVImcuK9V3lpdEWhcVTxokV
         wJ1p8gXajX3d43wVhgGTO7r9zqukc/7CurUv7g8vP4cWxYl/Fdmj5SQv2rQCL1cOj+mP
         +zxQ==
X-Gm-Message-State: AOJu0Yy2TsLpM/Q2PkF427A+dBZWjKtxmXEDTAE5DaX7NVgvlFjdb3Kf
	H1tvMPBn05OP9CmjA4EIFMoVgVEyyWAAc+RgtlFfiiXPctxQd/hXGwjl
X-Gm-Gg: ASbGnct9HnAEenxSNwBODDhCzOQ4qtWJ5nIuB4KFh13okzqVejh2GFEOUZJN06cQldj
	3WTxSGuLLSCkEZAEBtIg0+zCIHhkaCOEk9QiRu9/3tEE7YK3GU7N3KfsNSm0BwMcGzcY318NYUd
	gcF28F4cAq7JEj5PSzJQy7NyMAqp2qQov9/cay0xGvJjOO+wt223VeyQqUdxiS6NNHDbhGeaTaG
	HGfo4rdIGNj5OBieFAJlDlxEyvMCRfHg9SD1P29OcO+txEe2WE4k0F55qmX48pvyKSLFcsBlB+A
	BSchXR3BIDyNYMf16/htO8SWY6Mj/eqjH00smuHeRLcoK7vwe7rtqusmmCR4ijgVGKsMxEe9NgS
	W3C6MY9y6wzR8IYfFt+v+4yR5fpb+JvE3Iux6tb8WRrMLAGJtNczCItFCeGpQhtFNHUPObqsKsY
	Si9i+rxwlL2Sbd9USkH7zf
X-Google-Smtp-Source: AGHT+IHL/knHDRbkmAAdh+e5/GM1R0pH69p1XnM7aCRUh3ko5T6ct42T+TAbQTHpPcHWZhxhmBgfgw==
X-Received: by 2002:a05:6000:26cf:b0:427:2e8:fe3a with SMTP id ffacd0b85a97d-429a7e4ae98mr3558339f8f.13.1761663547611;
        Tue, 28 Oct 2025 07:59:07 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952de5f9sm20780414f8f.38.2025.10.28.07.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 07:59:07 -0700 (PDT)
Date: Tue, 28 Oct 2025 15:05:42 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	aspsk@isovalent.com, daniel@iogearbox.net, eddyz87@gmail.com,
	qmo@kernel.org, yonghong.song@linux.dev, martin.lau@kernel.org,
	clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH v8 bpf-next 10/11] selftests/bpf: add new verifier_gotox
 test
Message-ID: <aQDbxmPEkOuVcQV1@mail.gmail.com>
References: <20251028142049.1324520-11-a.s.protopopov@gmail.com>
 <33646aa56766cac6c6915ffde6652dd9b2f640a5262203002d7f6cfd4f82c247@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33646aa56766cac6c6915ffde6652dd9b2f640a5262203002d7f6cfd4f82c247@mail.kernel.org>

On 25/10/28 02:45PM, bot+bpf-ci@kernel.org wrote:
> 
> ```
> commit 817a92582203a0d4c62d2de0abae0bd4a5418fa3
> Author: Anton Protopopov <a.s.protopopov@gmail.com>
> 
> selftests/bpf: add new verifier_gotox test
> 
> This commit adds a new BPF selftest file to validate the gotox
> (indirect jump) instruction functionality. The tests cover various
> edge cases including reserved field validation, bounds checking,
> alignment, and register usage.
> 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
> > index c0e8ffdaa..4b4b081b4 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> 
> [ ... ]
> 
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_gotox.c b/tools/testing/selftests/bpf/progs/verifier_gotox.c
> > new file mode 100644
> > index 000000000..f7bf0a5e0
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/verifier_gotox.c
> 
> [ ... ]
> 
> > +SEC("socket")
> > +__failure __msg("writes into insn_array not allowed")
> > +__naked void jump_table_no_writes(void)
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
> > +	r1 = 0xbeef;						\
> > +	*(u64 *)(r0 + 0) = r1;					\
> 
> [ ... ]
> 
> > +SEC("socket")
> > +__failure __msg("jump table for insn 4 points outside of the subprog [0,10]")
> > +__naked void jump_table_outside_subprog(void)
> > +{
> > +	asm volatile ("						\
> > +	.pushsection .jumptables,\"\",@progbits;		\
> > +jt0_%=:								\
> > +	.quad ret0_%=;						\
> > +	.quad ret1_%=;						\
> > +	.quad ret_out_%=;					\
> > +	.size jt0_%=, 24;					\
> > +	.global jt0_%=;						\
> > +	.popsection;						\
> > +								\
> > +	r0 = jt0_%= ll;						\
> > +	r0 += 8;						\
> > +	*(u64 *)(r0 + 0) = r1;					\
> > +	.8byte %[gotox_r0];					\
> 
> Does jump_table_outside_subprog() use the correct operation?  This test

For this test it doesn't matter: the error triggered by this test happens
before the check for the writes. (But thanks AI, I will change the line
for better readability.)

> writes to the jump table (line marked with * above), but the expected
> error message indicates it should be testing bounds checking, not write
> protection. All other bounds validation tests in the file use read
> operations like "r0 = *(u64 *)(r0 + 0);" (see jump_table_misaligned_access,
> jump_table_invalid_mem_acceess_pos, jump_table_invalid_mem_acceess_neg).
> The write operation will cause the verifier to reject the program with
> "writes into insn_array not allowed" before it can validate whether the
> jump target is within the subprogram boundary.
> 
> Should this be changed to a read operation to properly test the intended
> bounds check?
> 
> 
> ```
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> In-Reply-To-Subject: `selftests/bpf: add new verifier_gotox test`
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/18878193924



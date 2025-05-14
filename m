Return-Path: <bpf+bounces-58245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BC0AB77B3
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 23:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD3B74A704C
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 21:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CCD286D56;
	Wed, 14 May 2025 21:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGeB634t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A6D1FC7CB
	for <bpf@vger.kernel.org>; Wed, 14 May 2025 21:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747257218; cv=none; b=O4EKeAKg0mKzTd9EIeT1/tIo21qHr7fH6pl7ii8WXNkKSAsEEOjoFsyQArlMBh9+PZXl0LZmOwl27mBOLrcygwNXL5NmzFQ5dozNfluvhssRhR07VDy83d7DXXqIiCE15x4mT4Mwbb+Xnx1oZVNNaTiM6gD0frWkGuPq+6QjiXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747257218; c=relaxed/simple;
	bh=7QiZU1RfKr1ql4xanXgAZVcjoskpOONx8zCuPmd1Pkw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lUZKuwKDRTOYlT4G6ltDcM/JMU9BsGiUesT2yJZmk2aRIkjito9E1Nh4IwOPy11H/l0060LBvuzpxBXyzqfG3RJmgzEI7CDS7g5vFX1MSK+TcVAbLFRsIZYV4u9vzlRnRsC9NwTEZCAwShK+d/I1CydJ6yYf3icX4o2iaU7r7rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGeB634t; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-30a8cbddca4so336713a91.3
        for <bpf@vger.kernel.org>; Wed, 14 May 2025 14:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747257216; x=1747862016; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qdqcsn2Dg5q6BV98a1NIkhfCP3v4+Q2PRvBske++C9Y=;
        b=TGeB634tMvRV5iYsGaG0VnKxItXBQ/LTAL1UeLjjMHvrz74TdfbBjmuKhohal6qVJK
         EI6deG9CjSDfNkKrvLQ14ysD2SL6g92o58sYNZ20bfU26B8n3VfpIYyCDCNhfM8gBUzd
         ThfwH2RP3ke/rpPTXrYGI1pIXMcYlDmbW/RvfWs+JXuNMMuqQC6r/aD7APKnvfwp7X4o
         jk3bQYAvmDn5FrPqBQknwqVCAwXfyXp6geElfoA4nL69kywXJAOJNPZ37Ot7pVl2N4GK
         AGIxqcbo7Djn842ql/IVdRwzQcBukdK5FYDK78oCnLwtk3p3ypmzExO9PvYNrVCPftru
         eNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747257216; x=1747862016;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qdqcsn2Dg5q6BV98a1NIkhfCP3v4+Q2PRvBske++C9Y=;
        b=RL7MUrpepxAmewaMYORcv+q1ox2St6h+T4kOEnHC3w6n+O3D6/Z3fG/36Ml4q1Rsrl
         7G7H3SPV3a0KX1/Z3vAivsFeYKalGf5GqywC7cP9sCgPswSxsbIgzGvTu2wq4mlFvmAd
         VATT9wf4c8psfk/8uHm6sB7Mi9Wj5mwOw9h1I5IgP94QlyyWibY3kaz+7tK045LYpHwr
         eYKHTdgLwee2IUDnytSKN1xNpTFRZiDXfSLdKYdZETSARJwCf9YkocfR4/Gt0bee2Fb8
         6sVEnYINA1NUXVDGY7nASLCCa5S6y6tOt02yqXA9zjIZXCncyxRci/YkxRRdfX+TC9mH
         RC6g==
X-Gm-Message-State: AOJu0Yx96tLQmyaa254RMb7wd7Q+Gbfd/vPalQxvOVz90TJfeZd7KMVb
	n19s138v8OP+UBEcYk6h4/TJ6HJBholXcT4Udf9a8iXmIZR/UOmkY5ncC/KW
X-Gm-Gg: ASbGncv9Q8GSESpvtzCeq+dZl/5JOCKBaJPcfl2RU/kb3i2LoQbGQYAOFfoQPmt62N1
	d5v6cp/9lv/rWWRRGHEn+qMl86yXQ/UxkYWk1VYSXGrKBYP6YwoaH3DVn1zwUh98CUKKh05ZOC+
	VZsJmGSSxUTWBNgNj+xavxxFtsHCIPGcYD0gGK2goI9ghVTnYPFfBb9Y3FxNFCJACP7epjdJsK6
	1HlM4N8n1WWvtjrjVTD3IYWci/gXg/CKnHTvflEcB7X43SgPt6XJ0d/jpFsfHg19fe7eEgtoHkR
	ZYJz6TVfuAb7GgJEypWJT8WEdwmgv9XCt+uHhdxYTpkGefS0IkAHnwKo5mg=
X-Google-Smtp-Source: AGHT+IGMDdCgmbxT+1/xnRIfyLsaE7mSGlOg0sfFYZGeiDaUmHewu5Ei/UNOCKNbV14829FI0AF85Q==
X-Received: by 2002:a17:90b:1c09:b0:30c:540b:99e with SMTP id 98e67ed59e1d1-30e2e5b678cmr7846221a91.13.1747257216502;
        Wed, 14 May 2025 14:13:36 -0700 (PDT)
Received: from ezingerman-mba ([2620:10d:c090:500::5:5d4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e33424dbbsm2024105a91.11.2025.05.14.14.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 14:13:36 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  Martin KaFai Lau <martin.lau@kernel.org>,  kkd@meta.com,
  kernel-team@meta.com
Subject: Re: [PATCH bpf-next v2] bpf, x86: Add support for signed arena loads
In-Reply-To: <20250514175415.2045783-1-memxor@gmail.com> (Kumar Kartikeya
	Dwivedi's message of "Wed, 14 May 2025 10:54:15 -0700")
References: <20250514175415.2045783-1-memxor@gmail.com>
Date: Wed, 14 May 2025 14:13:34 -0700
Message-ID: <m2y0uyc2v5.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

[...]

> +static void emit_ldsx_index(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, u32 index_reg, int off)
> +{
> +	u8 *prog = *pprog;
> +
> +	switch (size) {
> +	case BPF_B:
> +		/* movsx rax, byte ptr [rax + r12 + off] */
> +		EMIT3(add_3mod(0x40, src_reg, dst_reg, index_reg), 0x0F, 0xBE);
> +		break;
> +	case BPF_H:
> +		/* movsx rax, word ptr [rax + r12 + off] */
> +		EMIT3(add_3mod(0x40, src_reg, dst_reg, index_reg), 0x0F, 0xBF);
> +		break;
> +	case BPF_W:
> +		/* movsx rax, dword ptr [rax + r12 + off] */
> +		EMIT2(add_3mod(0x40, src_reg, dst_reg, index_reg), 0x63);
> +		break;
> +	}
> +	emit_insn_suffix_SIB(&prog, src_reg, dst_reg, index_reg, off);
> +	*pprog = prog;
> +}
> +

I tried the following test to see what disassembly looks like:

  SEC("syscall")
  __success
  __arch_x86_64
  __jited("movslq	0x10(%rax,%r12), %r14d")
  __jited("movswl	0x18(%rax,%r12), %r14d")
  __jited("movsbl	0x20(%rax,%r12), %r14d")
  __jited("movslq	0x10(%rdi,%r12), %r15d")
  __jited("movswl	0x18(%rdi,%r12), %r15d")
  __jited("movsbl	0x20(%rdi,%r12), %r15d")
  __naked void arena_ldsx_disasm(void *ctx)
  {
  	asm volatile (
  	"r1 = %[arena] ll;"
  	"r2 = 0;"
  	"r3 = 1;"
  	"r4 = %[numa_no_node];"
  	"r5 = 0;"
  	"call %[bpf_arena_alloc_pages];"
  	"r0 = addr_space_cast(r0, 0x0, 0x1);"
  	"r1 = r0;"
  	"r8 = *(s32 *)(r0 + 16);"
  	"r8 = *(s16 *)(r0 + 24);"
  	"r8 = *(s8  *)(r0 + 32);"
  	"r9 = *(s32 *)(r1 + 16);"
  	"r9 = *(s16 *)(r1 + 24);"
  	"r9 = *(s8  *)(r1 + 32);"
  	"r0 = 0;"
  	"exit;"
  	:: __imm(bpf_arena_alloc_pages),
  	   __imm_addr(arena),
  	   __imm_const(numa_no_node, NUMA_NO_NODE)
  	:  __clobber_all
  	);
  }

Disassembly shows instructions       movslq, movswl, movsbl.
While I'd expect that these shold be movslq, movswq, movsbq.
(Sign extend dword/word/byte to quad word).
These actually have different encodings, e.g.:

  46 0f be 74 20 20             movsbl  0x20(%rax,%r12), %r14d
  4e 0f be 74 20 20             movsbq  0x20(%rax,%r12), %r14

However, I can't conjure a test that shows a difference when loading and
sotring values. Is this just an instruction set oddity?

[...]


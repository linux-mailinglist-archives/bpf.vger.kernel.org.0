Return-Path: <bpf+bounces-34949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAC9933D76
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 15:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ED111C21CB0
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 13:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7AF1802A7;
	Wed, 17 Jul 2024 13:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="pCn679AA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1245A1BF3A
	for <bpf@vger.kernel.org>; Wed, 17 Jul 2024 13:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721222143; cv=none; b=B2UZ+TSrjXkIgFWKESGh9WQ3Zvu5mV+orA/HN1ZqpI0SODHCmAVgh1QNEoTmCzuQ4GvvOe5QIA6qRVJhqE+KQMyD6ERb3kVienDRi49gnZipEw4gm46qviW5RiGnye5e+Zk54xRa9Dc6iU0ZxJehSKTR4Lkwbu0IGwc61X0itp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721222143; c=relaxed/simple;
	bh=w3lM3QxgiIO2XloHLHUAuPqr2I7Bak5yf/pxxvSHH54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8GUwK2fLWPgFnIC1KBJuu1/Jp0HIggt2HGk/nX1Yap2pnVuJcvcDQEK9W2R5LauFZ7BqBbuFn7eUC0PwgCiT0UQDFaz4Tvl3FOCxeaQUbt6TLTIio3JmcidBTUyvZUWnn8VsQbPwsvPqlHspoPpU2ad2jQBOwVurDaOuYBMDqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=pCn679AA; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7f70a708f54so50416739f.3
        for <bpf@vger.kernel.org>; Wed, 17 Jul 2024 06:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1721222141; x=1721826941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nfyN59SqKKWvXLU3CmJIUvS3Qc0ugEMt32zK3kDXEnU=;
        b=pCn679AAqbmQ8aEZ0gMkxczOAnX6RI3DGskk2a67QuSwJJmQ/LVcSQDD4BQ+7G758U
         Zazq2hfQl/h0iYjfJOutzc9mHP9KeXIGb0X3+XCkoDkZd1yBDghfwBBwtVPjhENR0RQY
         c/I3z29/8ElRq6es6qhON0x/X6AKbPeqMvItG2ModEdzAhnX65nom1gGKvjsH4fqJeC8
         lfayo+Xbxm4+cfVxIpqxpB1XsgPnprQGPRASbCAm7dlFuWLr9CcSAoShnJAorkFRtg04
         aXcOMQfex2KWDt+Ru2+tgeNYg/YMTVb0r+h/BZjWr/p2/53jYW1OqByr/h1tWXkz+glU
         jqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721222141; x=1721826941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfyN59SqKKWvXLU3CmJIUvS3Qc0ugEMt32zK3kDXEnU=;
        b=quvyG0CHDvet6XitatUQZbrMJ9+mUPnJdHA2mbu6lu+rbnMv5FiauubIaYriKbNCkm
         ZKvPz8/mmRPndrx1oqTCBs+3PyBVDaL3hJ7w2mpLp908aAWE8iUhEQP2c6cXCiNsYMZN
         BBDck/j1amcWF2OOQb87DbtElYj9opc+XpFka0iD6VYgO4Yb1Hw3NFsaqjXmF5OIdR6h
         XXIWz3vdfKcH0IXwhZZ2Rnz3K8qcaiD3bBIi7ItqhBnKOs2HSYxJkIduCJ4W1iwfmrPJ
         7pI8Ypmq53aKd4un5xU4GS06LYYwxaTRCk8n5yzQ8GDyZsfieG/isz1LVF9/CclNWQek
         nhaw==
X-Forwarded-Encrypted: i=1; AJvYcCXoIaPTAevpCIAAYELf18VChpiI9B5/mOF+X2bAKAF2WBFilGoLhBspLpV1fmXn/uteTQYg9LrGgoPZW4l2s1TiXn8a
X-Gm-Message-State: AOJu0YxVdP9dzj8eJhwzoGpKgSgIZvWXv2omTxLxH9pfbtb4D0rQQVlI
	ERHb5Xt/hWbs4wUUJmvXCQTv2Y9QKn1PhtJzGiFUzzAbmdtAeQSSj85MRLul0kY=
X-Google-Smtp-Source: AGHT+IGqABt+N2by4fsdmIqsdoYWgZufcwOnrxKz5lnVlQ+PsNG/iBjeIJbo82SPl4wG/8emOYWz6A==
X-Received: by 2002:a05:6602:1406:b0:7f9:1b3b:8465 with SMTP id ca18e2360f4ac-817109e76cbmr216963839f.11.1721222141068;
        Wed, 17 Jul 2024 06:15:41 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c210f21be4sm658490173.91.2024.07.17.06.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 06:15:40 -0700 (PDT)
Date: Wed, 17 Jul 2024 08:15:40 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Samuel Holland <samuel.holland@sifive.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Pu Lehui <pulehui@huawei.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] riscv: patch: Remove redundant functions
Message-ID: <20240717-515ffec38da9b1f5df03e42c@orel>
References: <20240717084102.150914-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717084102.150914-1-alexghiti@rivosinc.com>

On Wed, Jul 17, 2024 at 10:41:02AM GMT, Alexandre Ghiti wrote:
> Commit edf2d546bfd6f5c4 ("riscv: patch: Flush the icache right after
> patching to avoid illegal insns") removed the last differences between
> patch_text_set_nosync() and patch_insn_set(), and between
> patch_text_nosync() and patch_insn_write().
> 
> So remove the redundant *_nosync() functions.
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Closes: https://lore.kernel.org/linux-riscv/CAMuHMdUwx=rU2MWhFTE6KhYHm64phxx2Y6u05-aBLGfeG5696A@mail.gmail.com/
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/errata/sifive/errata.c |  4 ++--
>  arch/riscv/errata/thead/errata.c  |  2 +-
>  arch/riscv/include/asm/patch.h    |  3 +--
>  arch/riscv/kernel/alternative.c   |  4 ++--
>  arch/riscv/kernel/cpufeature.c    |  2 +-
>  arch/riscv/kernel/jump_label.c    |  2 +-
>  arch/riscv/kernel/patch.c         | 24 +-----------------------
>  arch/riscv/net/bpf_jit_core.c     |  4 ++--
>  8 files changed, 11 insertions(+), 34 deletions(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>


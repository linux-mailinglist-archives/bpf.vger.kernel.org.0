Return-Path: <bpf+bounces-58159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9401BAB6045
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 02:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FE8D4A2776
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 00:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CDF282F1;
	Wed, 14 May 2025 00:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZcc/OKl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7E89478
	for <bpf@vger.kernel.org>; Wed, 14 May 2025 00:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747183708; cv=none; b=f9Z2LE6XIHnABQmL6Thr0nOnyVVWMgw8yUW1zwXIcNM2BrUlJ2/f7A8je6UUd//BCECsG8LqJN56Q3Xnfn8hmZFB4x9Da8VULcTalFLlxLndrMoD5XE8fQS9AHItD9CnvLnh+oTT9VX2MAoY3LRV2dh0bQGfCpTTH41xEo99oWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747183708; c=relaxed/simple;
	bh=nebtNUxZN64vXAmOcj+Ei4HKQFUfbf1YC71begzx3aM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8+uyLt2DfZhx8gYmHLgn40jBF/JXO6qUOyueupSMRPCJJkT+Q/7RBis+vHOo04O5q65gzmXR37kTzThAnwz1rBDozm8DY9HIdBMVSkkgbp6+eb+HHJb69Nd8n1Hwmku2gOyFO8UqiP9iOXZru5ccFGcyUsNkfhYa9hrSK0jeT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZcc/OKl; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a206845eadso1966085f8f.3
        for <bpf@vger.kernel.org>; Tue, 13 May 2025 17:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747183705; x=1747788505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRt0jnb73EGQukNKq7HT8GjizOYZT7WjIYqRvUclqtE=;
        b=jZcc/OKl4tOEbDTqedt261DdpiqvuyoUk7Oc961a78qrd0MmI7kZOCdb6cn/4mBbKX
         zIxsYHyG69hRxHnB3USbsgJREBj9If+UosDU08UQqCKdmg2ploPH8kIfsp6m2t478l1U
         ct52gamUAuXnf+PCbTvUu9xPjA5gvQalJ879McJn+tr+aoSsY3y0Aqw7s/nIDEa/vDv4
         zxK8AuYzcXxwQcFoY0/Qa9o/pDl9ZaDY5kumIHrsr30tA8oKqMVrp/UyCxNZG96tRsGT
         s73KpU/AsJjqbmDaZ9P0cpfUGS/8rmumukJfRCoM8SIoOjJkhuoQxecrcZDeEjts+LPj
         FQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747183705; x=1747788505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XRt0jnb73EGQukNKq7HT8GjizOYZT7WjIYqRvUclqtE=;
        b=drAstoxGX/HQINOta23SGBlIDzyauQoOxwpYMFciC7YgugjbrL6jjIjnov640YTq+4
         nAH+yGOg7RvkWOunGdDfY55p3VCbymIsxtxKDo/vJV0IaA98gyO8VVO1kcjV3be3sz7+
         V45Y2dN6RlOxxZ7CLsykq0kO22BKgI9TIjNTtIqomgj04kQCY1RDqwQOeRRuXbWl74nc
         s7ol6TmfByivDjFhjhl2GRj9lV5GDQF9/ctDTbCrpalGr5HLcQmK6lDf9/QqUc+ROPsm
         ls5os8u93QpQK34ee22HwYKQN8NtJ+yWwrcInKwPOOCNxx8VNoZuWxE7nnlS07ITWpVD
         jYHQ==
X-Gm-Message-State: AOJu0Ywsh35zxyFZhjhGhmBia1+Z9it6vvguTdEuftpPmyDtQi/+VYsv
	uPVF16Go/CM/CdwL+mDIHqHkBgQfOQvUffNe9CgQ5rw4KRsKpfAZpnsnuleXz2Z9rqJWLFxizs/
	7HbecHLSXIxy2UiUpn7maoVpveqo=
X-Gm-Gg: ASbGnctCq4dNvnzG1AJvQbBMMsh03uu50S+PLOR7YYd5g0mNJN1C/oKADRQj0M91AqM
	8dyh5kh41zVWcx4Lc0yEszgpuZnlSl0eOA79WgIH6G3w7mzDdkfZlYmaj2zn9g5urUXgsgBaaBb
	/99IHzt9M5pWU1TV0G8VtzPjNCmIg/3xOTAYnsZWf6Zik3BDG8z1c/UkN1VRD5rw==
X-Google-Smtp-Source: AGHT+IG4QIJXjy2aCiCPcl4ON9uQP1tyyGF+ObJMzYf2dnq29p5Dao3xm1ehjj2PUjLEY/ZxuQe+pZIFZmIiDQm9fn4=
X-Received: by 2002:a5d:64cb:0:b0:3a1:fe77:9e0b with SMTP id
 ffacd0b85a97d-3a3496b79f5mr862724f8f.16.1747183704714; Tue, 13 May 2025
 17:48:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509194956.1635207-1-memxor@gmail.com>
In-Reply-To: <20250509194956.1635207-1-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 May 2025 17:48:13 -0700
X-Gm-Features: AX0GCFtwSTrAMA-6ff2oPeWcW4FAH_Vmi68RPhzL-xwmQi8kaR4FeaxZ8GQCaw0
Message-ID: <CAADnVQJapSxncMwQwjRweau9a=r6FtRC5V2WZ0DHJ+ojoi9=Lg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf, x86: Add support for signed arena loads
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 12:50=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
>
> +/* unused opcode to mark special ldsx instruction. Same as BPF_NOSPEC */
> +#define BPF_PROBE_MEM32SX 0xc0

lgtm. should work.

> +
>  /* unused opcode to mark call to interpreter with arguments */
>  #define BPF_CALL_ARGS  0xe0
>
> @@ -1138,6 +1141,7 @@ bool bpf_jit_supports_arena(void);
>  bool bpf_jit_supports_insn(struct bpf_insn *insn, bool in_arena);
>  bool bpf_jit_supports_private_stack(void);
>  bool bpf_jit_supports_timed_may_goto(void);
> +bool bpf_jit_supports_signed_arena_load(void);
>  u64 bpf_arch_uaddress_limit(void);
>  void arch_bpf_stack_walk(bool (*consume_fn)(void *cookie, u64 ip, u64 sp=
, u64 bp), void *cookie);
>  u64 arch_bpf_timed_may_goto(void);
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index a3e571688421..2a0431a8741c 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -3076,6 +3076,11 @@ bool __weak bpf_jit_supports_insn(struct bpf_insn =
*insn, bool in_arena)
>         return false;
>  }
>
> +bool __weak bpf_jit_supports_signed_arena_load(void)
> +{
> +       return false;
> +}

Instead of introducing a new weak function, let's use bpf_jit_supports_insn=
() ?
We were planning to convert other weak functions to it,
but the work wasn't done.
At least let's not create more tech debt to clean up later.


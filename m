Return-Path: <bpf+bounces-50083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D370A22747
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 01:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5DB33A3C70
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 00:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9908F58;
	Thu, 30 Jan 2025 00:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQJvHlu4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4473526AD0;
	Thu, 30 Jan 2025 00:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738197706; cv=none; b=SoNFT9LalY8EzrdsQ+Eg5CpB8zspTamSqjHaGpfUQklDExpMvn80WQblE7hNJDD0RVeBUTFTEoOyxXVkeXF64esh1KMN9tbUCzyXj2+ehM5qg70k4e2ohvCGs6QZ3hOs0/ZWWt0yQRRN9MQtbRBjMkLKSJRoQg4HjSda5GOquxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738197706; c=relaxed/simple;
	bh=eaEJ7vaR9y76CVMYTCF3sleVUd6ylnUXEOfxpSbG+vc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mCfZh2+lNlhaqc/Kvbl1iGEbmXSuSstkDdn2S5e74TOBr7fNEpQDy0I+jD2XNeHXkPR8Nk1WQ68G7bji8umW5ON0Y5u8mPs3mD4zbEZL8256gsnj7nROPNIJM9ohOucxckU+lq+1M3tOW5CSS0S02d/cEV8Uk3alg2Vytqyzfnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQJvHlu4; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-436326dcb1cso1200275e9.0;
        Wed, 29 Jan 2025 16:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738197702; x=1738802502; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rInosp2NVM5wnXWfAnMbQV1Gw6ky5vVb+6V2AW92kzo=;
        b=NQJvHlu402l9L0Ov7n4SpAHlCt1UEChLC1R1Zyq1AZZNgaFG168GLDA3BjfXxcAbN+
         laGRJwIx9s5GoOGLEiqxSDsBrpxadqWhGr2Z20AG1aMMkX1U/jKIbtaZKMtAWyO54TE6
         ZkmqnR8+b81u3eiJdf7cVjLY6pe/qD0nWRVWvMB04heykTxptciuNBXUN6vIKDru98bw
         IEMe62ni/anr9ORy3ZPUrHJwhomHOvablWaHAZ/JcGtrCiHj37G4x7gnd0UcJ16gbSPG
         y1gw+r1AWbWsbc5uDNFuV/Rg1fAcBvL4kd3JiOnZ/dYhoQgV/nygadTZgZZ0YVd7C5E0
         bQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738197702; x=1738802502;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rInosp2NVM5wnXWfAnMbQV1Gw6ky5vVb+6V2AW92kzo=;
        b=dUYPCuFrEs7zZemfJazekPJRqCQyeNNrDc84e7hjXjLtREWuNweh9YAyPeRlNxKyd6
         BYV9a7RFabBST692vefLqPiuTuAqETf4SGDV2YvHHW3JN2Hq4XfDuiqg8N/gIlCpy8hw
         aSlqrLMX5f2FrwHCdsKyRwqU66lnYkZLUappvd2TOU4/avsefjQhFC+YjicrSten2Gcr
         ZAeG9C5GTqW41UbM9/EKUlbe56F6D8vbDZjTlSRc9Fzlp7t7dgGjEoCjZUZrUyNd5xPf
         9N94XAue3NWAKQuhzDIKF+e/YfZ/c2KmZLDZoHXR0lLl8DHxgEXyKOt6V04+8Qu9qnV8
         MWVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWBEhoUZwjkr5TM22bpkqYge+iL5jK1322xDSaEHDGepgOjw4p4OsJoTiNbH3rPe6E7NygZxnIdPg9T0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQb4+vtvc1cxZ80aYuJBhQ8xe1G9XPvrxzzSFITKxnhhmetZIZ
	HwExSEV7gw2kL6FE7uIUZqqcpaE/Fum7LDnPIYH4deEG86kEEkGtEv/1yNRBahvGbrRVQtjIKSS
	Y9ZBRkyYYaIm5PDOy94qmZZhV50U=
X-Gm-Gg: ASbGncs8OtyzGhRigzs91i8pfVaJYz4onqIrAiQUGf/VsHMlMP8gn3vDleqXodkHepA
	0koAdmgdfsBzWiLL4xlt8SML1QGerWiH6pR9CNplzRwHJn9HqbxtAkMLKaF6eGOtQzBiCWdkpQ9
	t853XN3WdQHpu+mofGCjIu5wUuKlWg
X-Google-Smtp-Source: AGHT+IFakXta0YUrPDaoAW39HXBtsSp792yT66oSE7DR1bgM8bLHLmF/Kpc4oac1rRkIqDnqCE70855yNkg5wHqD9m8=
X-Received: by 2002:a05:600c:4704:b0:431:54d9:da57 with SMTP id
 5b1f17b1804b1-438dc42a445mr48469715e9.30.1738197702373; Wed, 29 Jan 2025
 16:41:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1737763916.git.yepeilin@google.com> <e52e4ab7bea5b29475d70e164c4b07992afd6033.1737763916.git.yepeilin@google.com>
In-Reply-To: <e52e4ab7bea5b29475d70e164c4b07992afd6033.1737763916.git.yepeilin@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 29 Jan 2025 16:41:31 -0800
X-Gm-Features: AWEUYZnR1O34tW7s8Yp2f6hF-U05leRN407sB4GTvv3wxYUwU5sTTWv_OdxPe28
Message-ID: <CAADnVQ+5Ybu+rMBz5D-0GcZWemTwrzxy7vUfEiWpQ2CKugwwOA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/8] bpf: Introduce load-acquire and
 store-release instructions
To: Peilin Ye <yepeilin@google.com>
Cc: bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, bpf@ietf.org, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	David Vernet <void@manifault.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>, 
	Benjamin Segall <bsegall@google.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index da729cbbaeb9..ab082ab9d535 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1663,14 +1663,17 @@ EXPORT_SYMBOL_GPL(__bpf_call_base);
>         INSN_3(JMP, JSET, K),                   \
>         INSN_2(JMP, JA),                        \
>         INSN_2(JMP32, JA),                      \
> +       /* Atomic operations. */                \
> +       INSN_3(STX, ATOMIC, B),                 \
> +       INSN_3(STX, ATOMIC, H),                 \
> +       INSN_3(STX, ATOMIC, W),                 \
> +       INSN_3(STX, ATOMIC, DW),                \
>         /* Store instructions. */               \
>         /*   Register based. */                 \
>         INSN_3(STX, MEM,  B),                   \
>         INSN_3(STX, MEM,  H),                   \
>         INSN_3(STX, MEM,  W),                   \
>         INSN_3(STX, MEM,  DW),                  \
> -       INSN_3(STX, ATOMIC, W),                 \
> -       INSN_3(STX, ATOMIC, DW),                \
>         /*   Immediate based. */                \
>         INSN_3(ST, MEM, B),                     \
>         INSN_3(ST, MEM, H),                     \
> @@ -2169,6 +2172,8 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
>
>         STX_ATOMIC_DW:
>         STX_ATOMIC_W:
> +       STX_ATOMIC_H:
> +       STX_ATOMIC_B:
>                 switch (IMM) {
>                 ATOMIC_ALU_OP(BPF_ADD, add)
>                 ATOMIC_ALU_OP(BPF_AND, and)

STX_ATOMI_[BH] looks wrong.
It will do atomic64_*() ops in wrong size.
BPF_INSN_MAP() applies to bpf_opcode_in_insntable()
and the verifier will allow such new insns.


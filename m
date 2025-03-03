Return-Path: <bpf+bounces-53009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CB8A4B7A7
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 06:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01ADB3AF59B
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 05:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7139E1E7C16;
	Mon,  3 Mar 2025 05:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rW+7LmsL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AECC1E766F
	for <bpf@vger.kernel.org>; Mon,  3 Mar 2025 05:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740980270; cv=none; b=eNFWPCN4GJnW2BE7WesZM/63qMdUPOCfZfEf/Ih/JyGqP5lr10iAcFfNuB8sHznO9XfEwCXzR043Scr20S3A5gWoGxGHyH41ApG1kEo+zq3hWDit/U+fhCaMgxnLrhYoWjmwqJze+EjYCsxou8FAvcUn/L3QDWxDIXSr50zIE9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740980270; c=relaxed/simple;
	bh=WaoyZuEwsQ2p34OHEBdLIzMV0xIL1iFyXsJfdPLGXbA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gcQtNLpezLvMdOK39TDUrWC3XHeUWNfrLDEbJV9dwvclTn4CY1VFnkqB9MIqsrDSziDCrnZ43EmYxUyuPA8jFWQq1muoKS49ZdnC2NP3Uj9P6/uhn9PkeD6RSBVjF1Y8aK4VTZGDa0dx5coIDw48fcfVDpVbuaZaVPNCI3b/QhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rW+7LmsL; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fec3e38b60so4429368a91.0
        for <bpf@vger.kernel.org>; Sun, 02 Mar 2025 21:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740980268; x=1741585068; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xDRlPmyHtUNZ0yOQY1bkQ2kEbwvsRJ/+HMV3GdLKk6A=;
        b=rW+7LmsL8n0CUqZkmZId0q7khQRgBiywdiHaBvlh0jnrBRgE5D3g1b+iDQCIjDS7Su
         jDxs3bPbx7RpkWHrhh+CkS6BRuTF/g3T+IgLYlSslGI8xZM0jPrq3gwtdApAe4HOQFqe
         E9RuADjV8Qez4WgyZ2wcvdxJGjOcaKVFzbCUghELATX5txEVbMthD0iF1+9NCi6Pll3C
         rGW2hoKYojM7v3gbs9qZHO/8iBm0jG9ZtbLb1pZ/6VJvXxHcm2eREsYaLVCH+HzPMYnj
         7UwGaB2r6Zd74fvUiqk4cAdjPsm6ReZaYimu6JPRLtRKGFL79rwPfhVrXAs9haoJH6n7
         vP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740980268; x=1741585068;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xDRlPmyHtUNZ0yOQY1bkQ2kEbwvsRJ/+HMV3GdLKk6A=;
        b=SHWY51xhqvkwDynXNJDe7xS36UpRJzFazyzo2Pk7IHlgMLb6eOyApAMrUzpgujz80c
         uyVfdLrEIJENnneHmbJXvD6rZgzb+tIdK2GMfjCJIAnoWQf0EBSqTa2FpeF7V7FxRhrI
         UIyF1lKHwCRz6d2hfQsUSh1T7uGFgNuMJqlAV4RggB+oC9jXwWjHD9gf87bqHZiTn7La
         2y1gvhXZScz+U/bIePVAfHGheYdbUrP6+QQeZJWkIq2EZJHaebQkC73vmzHsIo6OfB6Q
         onpszyGDQAwF+MpSiEt9MyFprlBylftIh9l9jBqIIo9xAU1Y2DmaHbuYZzkKk2h5LjNX
         /Vcg==
X-Gm-Message-State: AOJu0Yxeyx1Leu/YRT5TlGzULry6ThK9aSKA8jEiTyDLPpSkLAsoOg2Q
	IIvwwpuMgPrf7RVr2HyWEq8V256i4u7XDxsO+KQDFf1czw0DxYiZdSANwYwDuPz/OeM1SdA7sMT
	M1MbwC6T8zYYD1pNZ6IPPKr3cYUUURyMG0u/gKzt/mZ/C6XVD6FNCkoXsgfxaqRw/dlR9sxDZrZ
	EwcrJOzudI1G/RxjzvofYyDVqhAebZQxur3/1PdBQ=
X-Google-Smtp-Source: AGHT+IEyeR4LjO07+giiIXLMHgTNqF3xV9ys5aBY0UaUCNsB7smdHPPbNq89GHq0OP7YKsBN/rIFz4H/QXqJzA==
X-Received: from pjbhl3.prod.google.com ([2002:a17:90b:1343:b0:2fa:2661:76ac])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3ec4:b0:2fa:15ab:4de7 with SMTP id 98e67ed59e1d1-2febab3df8cmr22652320a91.12.1740980267592;
 Sun, 02 Mar 2025 21:37:47 -0800 (PST)
Date: Mon,  3 Mar 2025 05:37:44 +0000
In-Reply-To: <cover.1740978603.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1740978603.git.yepeilin@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <03ceb882fa759f503b3f4b7f4ff2a5ce69a0eb05.1740978603.git.yepeilin@google.com>
Subject: [PATCH bpf-next v4 05/10] arm64: insn: Add BIT(23) to
 {load,store}_ex's mask
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Peilin Ye <yepeilin@google.com>, bpf@ietf.org, Alexei Starovoitov <ast@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	David Vernet <void@manifault.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Yingchi Long <longyingchi24s@ict.ac.cn>, 
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>, 
	Benjamin Segall <bsegall@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We are planning to add load-acquire (LDAR{,B,H}) and store-release
(STLR{,B,H}) instructions to insn.{c,h}; add BIT(23) to mask of load_ex
and store_ex to prevent aarch64_insn_is_{load,store}_ex() from returning
false-positives for load-acquire and store-release instructions.

Reference: Arm Architecture Reference Manual (ARM DDI 0487K.a,
           ID032224),

  * C6.2.228 LDXR
  * C6.2.165 LDAXR
  * C6.2.161 LDAR
  * C6.2.393 STXR
  * C6.2.360 STLXR
  * C6.2.353 STLR

Acked-by: Xu Kuohai <xukuohai@huawei.com>
Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 arch/arm64/include/asm/insn.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index e390c432f546..2d8316b3abaf 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -351,8 +351,8 @@ __AARCH64_INSN_FUNCS(ldr_imm,	0x3FC00000, 0x39400000)
 __AARCH64_INSN_FUNCS(ldr_lit,	0xBF000000, 0x18000000)
 __AARCH64_INSN_FUNCS(ldrsw_lit,	0xFF000000, 0x98000000)
 __AARCH64_INSN_FUNCS(exclusive,	0x3F800000, 0x08000000)
-__AARCH64_INSN_FUNCS(load_ex,	0x3F400000, 0x08400000)
-__AARCH64_INSN_FUNCS(store_ex,	0x3F400000, 0x08000000)
+__AARCH64_INSN_FUNCS(load_ex,	0x3FC00000, 0x08400000)
+__AARCH64_INSN_FUNCS(store_ex,	0x3FC00000, 0x08000000)
 __AARCH64_INSN_FUNCS(mops,	0x3B200C00, 0x19000400)
 __AARCH64_INSN_FUNCS(stp,	0x7FC00000, 0x29000000)
 __AARCH64_INSN_FUNCS(ldp,	0x7FC00000, 0x29400000)
-- 
2.48.1.711.g2feabab25a-goog



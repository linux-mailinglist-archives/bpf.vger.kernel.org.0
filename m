Return-Path: <bpf+bounces-49748-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC82A1C06D
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 03:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09C7316CC3B
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 02:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BEE2046A1;
	Sat, 25 Jan 2025 02:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lQSWpDew"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9841FC7F0
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 02:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737771528; cv=none; b=gM+GVg2KkPrp3H3sY11O1lQDqUbiUReF8QNiR4IdW5jiauhjOlgpn+TTmSNaUwak1RmhTKx5f54ZeHjjjLB+rvqSq3g7oTm6f7CPdeeyzGwpq0g0z5i//ah69qGo/rXL4Ft9lP5UKgbAYBDNPqjije3GlEeh4sAj4uTg32584zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737771528; c=relaxed/simple;
	bh=ocBZqN0GqL60R7TsMhLVWi35aZ/iydWqiZ5kHRtgCMU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jWi0KmCawcT1WScUkZYlOVaau0dgQRmWFCArucozNfUTW01AqhxBOAXmYvNt9QrdmFY54OZVCKvMPsL9ncZANpdbYZ5SB9zwRDjRevzUm8UODX7MD7VfR8qvAeBALY/bH8cg8etgX64ObJ8XFTh4S3ZNhnf+37+tb7pxEAnKL/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lQSWpDew; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-216430a88b0so52889695ad.0
        for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 18:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737771526; x=1738376326; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0jhO7BAME7t86oa1kVif63p2DnH3NcNv11+/BWAtyDY=;
        b=lQSWpDewlFPGoy05Ba3NZYpI56ehCxE4BhUH/luRcy3B1B+DF/oie7MQHcLuO7+2RT
         dWlQ2aVm2BROHfCe5KdbOtDPGcZq6iWWakaaVv5I4l6qQAlWkBHw27V0dJg/wfSyyF0M
         NiT1LzkhSkBPqDCfKHX7kzXOAczMMKh/Z8KSv0TIjMixQrRSbFLX08I3EBb/zgaUZ6Wk
         KjmjQHCV01weddAyh+P6moykQ7PI32xGJk8GNZe3a3OYEQRPouNx6rBnjt8WTxcWHjY6
         a7EDRhkfortdXHBG7WXbpwfSudhndKhuACtlHaV28XPOU68zT7sDX0tGqZgVOvfDPCAn
         0aBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737771526; x=1738376326;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0jhO7BAME7t86oa1kVif63p2DnH3NcNv11+/BWAtyDY=;
        b=NDhQOpRgFd2Mz/nBGsVP7wdfMzlaqhWG6pFo+i0nQfCaPTJPAz3dF2Z7vhV0riAo+u
         DyAOMnKEsZlk/Ku14EkrEWvN6WHQkOCKxLn9Uo04lu2aIPBxluilwFw80ZaeVnItdRvg
         eW1R1OJbm0H1Wu4ReVx3QQ2wrcWpgOHNk/WLHOb6+lU22gju7YN4iyO2KSswNE/jAuHw
         ExsFWZJlj8NHCkexknLJvmLGSOSiirJ2qLm9tOgWFA4+s83n689OhmTaF4aJWAEKlQ8w
         is/n/NlAQw3ZXVdKVdVJQnblLw9JX1nE/TY0+k6tjGSWHfYWMETnTHL1PtySGPiQ2ZtV
         4d3Q==
X-Gm-Message-State: AOJu0Yz1vtKR0UcE9gHzEhguZiAe4kRIckwJ8LU6snajQt2mVAWzIWFK
	DXrH3dVD2VYYgE4PeItfzb+e+I8nTSZnrLC8SELrXYgdTaWU8PH4gtRJQxccCPCHaowU32YCz4i
	2XD7NHexrJ1kblcvRu5uAWX9O9ror5EkIzk5VwIRtTdS54y9vW2TaCIPLUNSAe1Ns1BIe5nJahz
	c10HkoSu7B5v3VHyGSuFw8FjWOziya4bocr2I0hpQ=
X-Google-Smtp-Source: AGHT+IGOA2myrdjHdShHtNzy3sHhO4gQRnqhkbbsoC8Yq6DOPMUbkkwaNv2wF6MPelQcaIQVD67axVPVSm5LaA==
X-Received: from plnq11.prod.google.com ([2002:a17:902:f78b:b0:216:1543:196d])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ea10:b0:21a:8716:faab with SMTP id d9443c01a7336-21c352ec1f0mr490310075ad.16.1737771525995;
 Fri, 24 Jan 2025 18:18:45 -0800 (PST)
Date: Sat, 25 Jan 2025 02:18:40 +0000
In-Reply-To: <cover.1737763916.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1737763916.git.yepeilin@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <e003a69271782b91fafc07c7614becb4f5fe115b.1737763916.git.yepeilin@google.com>
Subject: [PATCH bpf-next v1 4/8] arm64: insn: Add BIT(23) to {load,store}_ex's mask
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Peilin Ye <yepeilin@google.com>, bpf@ietf.org, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, David Vernet <void@manifault.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
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
2.48.1.262.g85cc9f2d1e-goog



Return-Path: <bpf+bounces-53134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B63BA4CFC2
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 01:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC19F1711E2
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 00:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728E25223;
	Tue,  4 Mar 2025 00:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AM5wU7Yl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A6917555
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 00:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741047237; cv=none; b=ZI4luxpjck1jNcIVo8JPQk/Bi5QX15vOHkRvaoCEUsn9PLdNXGewztCBT+xk9hoN298rM4t661hrZg+0ThcEOM6vY+/IalySN5F3DIAp4t660R+895iJEzIM5NtyfT4aD1PMH0rBpprHsMyf3f6fZ+c89EYqw/lipgXxPNOM1t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741047237; c=relaxed/simple;
	bh=WaoyZuEwsQ2p34OHEBdLIzMV0xIL1iFyXsJfdPLGXbA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s49GXZCRaRGyrbdHMLy2hff/jJu3XMik45pNa25OrUzRSg9WNqGdUclULLS60pKOw5tkNxjF2Z0YI6NYfIfvQ9JaYJVQkOFrHyxjnLJUJwWrWSDRAOIFKB7rR+xBo9FJqnFdHfTFQQUe6Qbuui7nB2LN4b0Cba3kmpLqPeHuhL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AM5wU7Yl; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fecf10e559so9410903a91.2
        for <bpf@vger.kernel.org>; Mon, 03 Mar 2025 16:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741047235; x=1741652035; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xDRlPmyHtUNZ0yOQY1bkQ2kEbwvsRJ/+HMV3GdLKk6A=;
        b=AM5wU7YlYAqmAq1r0oaBA/et5eq5zrFQ2wDipwlboXVBha/cohT8LT7wf3+UiQYdw1
         O30uZ0AAtHdNilZiBcyVYHjN3Rg/JHCl1VDyp9jZ8c/6XMbQ2qOwk95Me5JEOhum809u
         Ljjp784MZ7sIYITag+cuaK5PJ4ytdyYSo5vxQmGWT1+T/rvM73W5ZJ3CMMAlx1s5GINd
         AhF3QD+wq5aB0UpCwvEYVwrjXfLcTWg9i49a/zJAcBK30NxeGtP3D6TClFd0e2bHcI39
         os4M85RnxD4Rlp+Aqf5Te/mkOODcN1zEcyimE3AkJStyLYZyoQYdXgW77SwfDoB8sCdK
         1l4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741047235; x=1741652035;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xDRlPmyHtUNZ0yOQY1bkQ2kEbwvsRJ/+HMV3GdLKk6A=;
        b=ZbEgBuDhLDv2BCzB3Ca7r7IE08RH0w8dd9hIbenLanVLFEY31W3txg4aiJXH8yekES
         UJDcUO/vU0QsRgtoft/B5nb15HDzA18FkIsYSiCeTWWq7MCcXjcvWN3TTceUdTKU5LE3
         MBF1LikwG1xr1Q7OLnBhtJF+9jCvbNviSbvJrm+eal+nnScCfLn+MqPSPLVCmeknb+9o
         /+78TA75miRqNuEFEu+qVKNDMt5YYH6DUD8JM9+O/HM0pXGLI5y6QaKnHV2KzoCjoKje
         CvM7SO1/GoteROO0PDD0jhUWQqSMPV4pvlvhPJVLJR0DMty9epAnSPekRO3vshLNbR8b
         /COg==
X-Gm-Message-State: AOJu0YzUNoHrtuVgSy78q+fzrM5HsY6pywWr1h9p562Boh5CR/P9gvHn
	36Hk41WQV94TQn/bUTorPhjCQvIcvegA58IZVRxZOCF4Jt+orJGKDH1pyeKFaNKJcUw129+cCYS
	MpUCtdffTjvi/CYVhjFkDfDXgX1Zmt/TJETzxpvW4VdIn1SsyKkgaDtY4+i4CR3doYSyavT7wb2
	H+/kdQsqcv7Rj25NlcFjT2MYBpGEz8D2a677ukigA=
X-Google-Smtp-Source: AGHT+IEdt4cHd77mRMPQGhwekDKbD+CN7Z/qOgmO85qt0Zhy9STzN/3oNCxHzMYfYpYk9NYtUNA1zbaLFqDQeQ==
X-Received: from pgbdo4.prod.google.com ([2002:a05:6a02:e84:b0:af2:37c4:2ad])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3a42:b0:1ee:efa5:6573 with SMTP id adf61e73a8af0-1f2f4c9c8d1mr28131587637.8.1741047234794;
 Mon, 03 Mar 2025 16:13:54 -0800 (PST)
Date: Tue,  4 Mar 2025 00:13:50 +0000
In-Reply-To: <cover.1741046028.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1741046028.git.yepeilin@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <e64f97503ec5b0e811ce7ed3534cd754ba81fbc3.1741046028.git.yepeilin@google.com>
Subject: [PATCH bpf-next v5 2/6] arm64: insn: Add BIT(23) to {load,store}_ex's mask
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



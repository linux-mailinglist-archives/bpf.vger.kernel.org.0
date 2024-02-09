Return-Path: <bpf+bounces-21600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5715484EF94
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 05:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9BBC1F21EAB
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 04:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68135221;
	Fri,  9 Feb 2024 04:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlXB01ti"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C80F522A
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 04:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707451642; cv=none; b=EcF+Eov0W9/4da2inIY5tzXoXvvLR4YzL+xDoXz/ijm4mY+xQlT22xEwHa3hzpIiLPhxc0DFS+TqJBiFiHrecGFcUdmpqyjxPW3yn/Iy7WD4Lis7sizm5272hhPJaBAGq0FmnFhw0xhdZDuh0u4ESWJKSsq3po5dc29H/Ak28c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707451642; c=relaxed/simple;
	bh=DpM4HzfqjDOit5k3hAkHFBsY8yXYvaZc7MIRe8CSyMA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=irs7NQ1T+KhoZpDrsxi1UPwdeFpGf2nOY9V7kSqurzzyJiqeS2IeKZomGHhA0hF8Jxx7At9No3YWZFhVMEoz2ffaWBLJ30E5Vjn+j9Qg9wC0qfE/7YadmsTtAITDTa96dFwVglcW1UbK2+kXaEEuSqWnAUkPuAxxnhp3Q4mKekI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlXB01ti; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e062fa6e00so327922b3a.1
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 20:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707451640; x=1708056440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsJBrUUPtruHWtQsS6zgKVxqPHg8IzuE7qrpmwhQpng=;
        b=GlXB01tix9tjTIMq0N2b8N2vKme8MCWePo/Wam6tsJwcDyw9f5srNeZvWWdBmYvp8v
         4KUEP4OQS1FV+tKVrD25r1FUcdgh7oCPxogtefyvcLHQc3F++mxc76Vyuoe3NcPFebPM
         xa6mM4Es4bGgwqggHcDlWrvWt7ibAtXUfCp7HUKfKdZcNRwV+GBrrJMcdhJOMZ4Elw6w
         Debk5ivea83F8X4orKpW1fo3r4xyPF6N1YLxGc8PEuQXpn8SUBcSMHNtLZ+gQCaxsvK5
         hxWZO0z4aKdhHJmrsarKGRovGf54mI8sWxGkRJ+I6Oq7ZErL2oDww7n7JReNUAW3hK3b
         CHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707451640; x=1708056440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MsJBrUUPtruHWtQsS6zgKVxqPHg8IzuE7qrpmwhQpng=;
        b=sa6WhMVaGpsYC3jDRkok8p6C4FnToWPbUmZvOT6DhZzJmQOS76ES1JmNiY5AaRRt7z
         YTopV0D58VHCwDOIO9lC+fhyCyk51x+Z+GbHQW5ZFBcziLEfo3x74qdnv60JyxG7ah8B
         Af73qZzpuuBeeM0FNzrCRTpeuFqxjvZB9/YfLD0G6PgWYDTde5Ehp1vWfQdzrx1F0uvm
         +naOWab4BAJ0abCrs8zoc3rC+Sz5i5xlQFOZcwUPQSLIcIqL8ZKmvIaMmb02ZiAVcpjo
         Dd3K4Bn3eW4BKGvLlpkdkajhlWzs105NpmzPtKAtmiAGeOclGEICcd/KjgufzvPg9b09
         mRkw==
X-Gm-Message-State: AOJu0Yx34xj0RE+qWf4ibYyKHzUPkqvbOIEfN4rH/9obdKL4gMVMhuso
	/VyOzneeOZvPQ/AZp/uCDBK0epo0iYPcW8eF5lzfxBCrfvjsZyQBImqbepHi
X-Google-Smtp-Source: AGHT+IFFu/goz1FrmbpZ66r+D/WoNAbblyTq352/gs8sP6e/6QY7jw8AvLvp16EdF9oF+hm9bcXL7A==
X-Received: by 2002:a17:902:ced1:b0:1d9:a2d3:8127 with SMTP id d17-20020a170902ced100b001d9a2d38127mr470046plg.52.1707451640097;
        Thu, 08 Feb 2024 20:07:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWP7HPoDU+RIV0hbhhVZtaTKZ52ozQSAI2pmi/5/+M4R+kofDRBWlviHowAmZf4KAFWB00xVtEVtRwexebBtYOr5AunnGUHJHavtyq1fO76hzOsbjlXb6ahRaPTVniCLqPQVTDLcmGtA+rqFV9qPMYDXBfd1cJ61lPC4OPXYwCm56ZKxVkulgzpnfoB2DhozBGuIbcQ/lmUZzREPwYFIWjmTN+9/y2JuUZspdbHfxqeXh60l+d35X6YqgaPJBYzRA+h7ETU6QLl1X17oZ7YJWJ35m4Mn4X9nbYlY0JqtdjgCe50tzxXbXK82HqDvWSALZFykpj6UqRgzuzDJqpHvP6D7mmZ/eNM3hPd+94XK6JgFgmhKcw1oA==
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::4:a894])
        by smtp.gmail.com with ESMTPSA id i19-20020a170902eb5300b001d8f3f91a23sm535557pli.258.2024.02.08.20.07.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Feb 2024 20:07:19 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	tj@kernel.org,
	brho@google.com,
	hannes@cmpxchg.org,
	lstoakes@gmail.com,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH v2 bpf-next 16/20] bpf: Add helper macro bpf_arena_cast()
Date: Thu,  8 Feb 2024 20:06:04 -0800
Message-Id: <20240209040608.98927-17-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Introduce helper macro bpf_arena_cast() that emits:
rX = rX
instruction with off = BPF_ARENA_CAST_KERN or off = BPF_ARENA_CAST_USER
and encodes address_space into imm32.

It's useful with older LLVM that doesn't emit this insn automatically.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../testing/selftests/bpf/bpf_experimental.h  | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 0d749006d107..e73b7d48439f 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -331,6 +331,47 @@ l_true:												\
 	asm volatile("%[reg]=%[reg]"::[reg]"r"((short)var))
 #endif
 
+/* emit instruction: rX=rX .off = mode .imm32 = address_space */
+#ifndef bpf_arena_cast
+#define bpf_arena_cast(var, mode, addr_space)	\
+	({					\
+	typeof(var) __var = var;		\
+	asm volatile(".byte 0xBF;		\
+		     .ifc %[reg], r0;		\
+		     .byte 0x00;		\
+		     .endif;			\
+		     .ifc %[reg], r1;		\
+		     .byte 0x11;		\
+		     .endif;			\
+		     .ifc %[reg], r2;		\
+		     .byte 0x22;		\
+		     .endif;			\
+		     .ifc %[reg], r3;		\
+		     .byte 0x33;		\
+		     .endif;			\
+		     .ifc %[reg], r4;		\
+		     .byte 0x44;		\
+		     .endif;			\
+		     .ifc %[reg], r5;		\
+		     .byte 0x55;		\
+		     .endif;			\
+		     .ifc %[reg], r6;		\
+		     .byte 0x66;		\
+		     .endif;			\
+		     .ifc %[reg], r7;		\
+		     .byte 0x77;		\
+		     .endif;			\
+		     .ifc %[reg], r8;		\
+		     .byte 0x88;		\
+		     .endif;			\
+		     .ifc %[reg], r9;		\
+		     .byte 0x99;		\
+		     .endif;			\
+		     .short %[off]; .long %[as]"	\
+		     :: [reg]"r"(__var), [off]"i"(mode), [as]"i"(addr_space)); __var; \
+	})
+#endif
+
 /* Description
  *	Assert that a conditional expression is true.
  * Returns
-- 
2.34.1



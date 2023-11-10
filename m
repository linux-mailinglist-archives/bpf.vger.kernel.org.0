Return-Path: <bpf+bounces-14789-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F8D7E7F74
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 18:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48961280F25
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 17:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0081438DCC;
	Fri, 10 Nov 2023 17:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5LfJeRD"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EF038DDE
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 17:53:59 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD8E2141A;
	Fri, 10 Nov 2023 09:52:41 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-32f78dcf036so2119170f8f.0;
        Fri, 10 Nov 2023 09:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699638758; x=1700243558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rjLgosbrIATqy9jCIRZQTn6hGbaoZOX0qQ5LZfhUZPU=;
        b=m5LfJeRD02RDsdwKcAMC/XOlKOZVdZkSihxXXU3Jyln05dBXO3csTvR26YU9wgVAcI
         hpBYgqnC7CpJfTfwPIjspcLbGS2HtsAkDAYN6ywTTuppNarTcFjt2SNkbV6ZurF8ptv5
         fR3bMdxNlEQETXXjJzmx+yLrlx6sET5jYPkMGDhr53DcTJuVZcqyNjGXBLtJuCT3KjBA
         O1x5GiEWlA17wYq2KSa9ImmrxINnq/e065UOGrBLB9AiI1xwLzW/rDUVpbDsR/oLJDio
         TuoDNfVnKMj4LE9+q+AiIEPjlrhrCrE+abcYOzYLsO+DONmoBF9n8/7z6Xcsgd4r+zn1
         YBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699638758; x=1700243558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rjLgosbrIATqy9jCIRZQTn6hGbaoZOX0qQ5LZfhUZPU=;
        b=qJqkMPxMj50YWDflqOPNyTUIi/JRrfPJQhICLPfIqMQuCxwV/h14BPwdHTV1SlNXVg
         lyTkMTrlag2mK3AgPiscXccxHgMUjcDCCYHlHoVRqHLPJQURgq+wY0XDW/zrUotKVVt0
         XSXAlvnQ4IgUOm4cnN/aJZuBa309SlY6GF0kaFdKm2iS+qIhNS2EPDlBr6he/S/BA6y6
         D6TURSu5DffvkMtWLj3loOAIRYh2rEzcnEigTCMVQU3ro6Nv8Yu0aiZUVQqcArckOGsX
         /4QNigEWW+yBAH+Qw8NxPFZ1wFdgj3L3Ga/CFshgM5JBasX+DJWubPxoHp580H0iaS0N
         yngQ==
X-Gm-Message-State: AOJu0YwgJpjo+tT3NOnrJsIHjA3klAbw/NRLb9W8WCIYmRiuhlhnbKVF
	Sacfun0juLQ6TIZ54Zkrrn4=
X-Google-Smtp-Source: AGHT+IGlrIv+1Zu/VM/CpLeTN7etNZZXa2Hx0vzIylwj8e3jyhc5QYaQ0mrrAQTAHKEwmzAiFiKB2A==
X-Received: by 2002:a05:6000:2ac:b0:32f:64f2:815 with SMTP id l12-20020a05600002ac00b0032f64f20815mr3404438wry.33.1699638758395;
        Fri, 10 Nov 2023 09:52:38 -0800 (PST)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id e19-20020a5d5953000000b0030647449730sm2362375wri.74.2023.11.10.09.52.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Nov 2023 09:52:38 -0800 (PST)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Puranjay Mohan <puranjay12@gmail.com>,
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf] bpf/tests: Remove test for MOVSX32 with offset=32
Date: Fri, 10 Nov 2023 17:51:50 +0000
Message-Id: <20231110175150.87803-1-puranjay12@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MOVSX32 only supports sign extending 8-bit and 16-bit operands into 32
bit operands. The "ALU_MOVSX | BPF_W" test tries to sign extend a 32 bit
operand into a 32 bit operand which is equivalent to a normal BPF_MOV.

Remove this test as it tries to run an invalid instruction.

Fixes: daabb2b098e0 ("bpf/tests: add tests for cpuv4 instructions")
Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202310111838.46ff5b6a-oliver.sang@intel.com
---
 lib/test_bpf.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index 7916503e6a6a..c148f8d1e564 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -5144,22 +5144,6 @@ static struct bpf_test tests[] = {
 		{ },
 		{ { 0, 0x1 } },
 	},
-	{
-		"ALU_MOVSX | BPF_W",
-		.u.insns_int = {
-			BPF_LD_IMM64(R2, 0x00000000deadbeefLL),
-			BPF_LD_IMM64(R3, 0xdeadbeefdeadbeefLL),
-			BPF_MOVSX32_REG(R1, R3, 32),
-			BPF_JMP_REG(BPF_JEQ, R2, R1, 2),
-			BPF_MOV32_IMM(R0, 2),
-			BPF_EXIT_INSN(),
-			BPF_MOV32_IMM(R0, 1),
-			BPF_EXIT_INSN(),
-		},
-		INTERNAL,
-		{ },
-		{ { 0, 0x1 } },
-	},
 	/* MOVSX64 REG */
 	{
 		"ALU64_MOVSX | BPF_B",
-- 
2.39.2



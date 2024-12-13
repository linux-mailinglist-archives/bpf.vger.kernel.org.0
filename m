Return-Path: <bpf+bounces-46903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B0F9F1803
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 22:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33852188A47B
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 21:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF4B1922E9;
	Fri, 13 Dec 2024 21:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="EFfEVTQi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F045C1DA5F
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 21:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734125276; cv=none; b=S6TTrpWsyZVyRBWO9amPmslkOqGxGSjFFWsgfl7VpQyTWc7VUkFFP2QfLuNufPk5GAB2L424DGI+dsGPnJWdm90OcnZMRyszvweu448t17IaaaLT9l+THoKxECnsKAlgXBYvG8Kjml0AatCa5rMYfOdvDF++vOpfPs+daJqAx3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734125276; c=relaxed/simple;
	bh=FH5wecbYl+SBkVJdCP6iPL3ZO2VtN/fws9QfzURGeyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u+eesYRl0mJhI+2qMmLU/61wmAtP+2ThRwdRNanR/3/SDR1AmckJBY0UdNaI8ZpOi/RkscD+E01eYdbrqxJ5bXCT8QnkWb5ME+gR0RXuHLbx0jwCUbI+FAQLl4Fd7eBWAcQOC/EJhFt8NvqBfSmHYMdu4XD2xXZ91wSnwAJPTlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=EFfEVTQi; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso15311835e9.0
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 13:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1734125273; x=1734730073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NWYYYsSdySmdSoRyJldPTJHo9RP8xRtXxjAe9bCJt4=;
        b=EFfEVTQiRm6oPwciaRhdTHn8t7at4dBkwH6sy2FoUYRi+gWQ+5zIE44Aruz12qVtW0
         jWx479wwg5m6GJE4uHsjbeeDuHiTqcE5OVrCt2x2Ra7Dzhpm4iJ8A2qDssqTk8OaAKAa
         uRIx+M2bOdoZDu+yecVwXQ37qms1hRzKWzqPifk7Xr4yLY8Kvoi0LoxM2i7J5DSzaawp
         XBPf+TWWQfoHPv3MLKYfOOWBeYutJQQEq2zK/riNwvZfRxDAVgWQUB/1Q2Nn5gi5gF89
         4ce49+vxcPfwRMLcnZdV2Bv3FWf0vGHvf3HsI2JArRFq64o9F70MRQ1uxdQqImz2FyHf
         tb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734125273; x=1734730073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NWYYYsSdySmdSoRyJldPTJHo9RP8xRtXxjAe9bCJt4=;
        b=PWcC2VZKeARNzetIxvr+uNAoLoKorUuZHnW9PTUUAx7Yned+dHEyUmf01tPcY7U71Q
         em90Iw+kWtQXUX3tuqTNXbV1qABOsWBFKh82psROTaohl1neJLEJthFnmSlc9vglMmE0
         S2vw0pJW8R2hv3g480t7m/ngL9EHaOn3pTmrU5tgjaIpIvxvH6oVT6ZEmb+X3B3493fJ
         2qMVCH711jxf+vobWw4UwKNa0DK99lPlYNwFtLNcuyPzKCAh1cBFVPVuobI+9JizSHeT
         oN2RkIhL2/dxGQrY2PB6UljXFZdPR2yHpZy86iITUh1HQWxywcOTE4CVO1d/ZTrxJZgh
         UEdA==
X-Gm-Message-State: AOJu0Yz4ERH9z4fRO2CQuHHKD4tWiyQ6pEx0NuwHAnWgyTY2e7qdGpYi
	ZPImYndkGvJYhPW8CdFweBV/vEl+yPxSNtcD04GJmlPqdPJUBsVDOsQalfklMLLKnm2/OWvvDYx
	I9bzsZA==
X-Gm-Gg: ASbGncs+VsIvxYUC7BO6PHoXxIvUdUAsChv7u2OaBqSIvubCvg6+8Dit9hL+8MDBS1n
	IPiWz20+hBx+JfAcUXD5o8FR1NvDVkstrdCUtzTCTuu/nkkpy64Fhm3BfLCPpoNSUQqfzJ+mVb5
	36wzpzVAhxZAwiMy5IVyezXsAI3x1ch90Sx3gGDor0Dxydhxb/XPKuHF4lh6d+tcpITnYRw/3hu
	ckZVfIIuxsOrYbMfEuuUlwNqrJ6bh6dinM698o=
X-Google-Smtp-Source: AGHT+IHVwtthb4P13yfNg5I5lWQSdv9CaBLZFOH1oijXk+SxuxlFhMvfC79/Vo7hFhXfZF6ISKNC6w==
X-Received: by 2002:a05:6000:18a7:b0:386:3272:ee68 with SMTP id ffacd0b85a97d-3888e0ae6ccmr3319148f8f.28.1734125273106;
        Fri, 13 Dec 2024 13:27:53 -0800 (PST)
Received: from bobby.. ([2a09:bac1:27c0:58::3b6:40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625706c5fsm60003975e9.31.2024.12.13.13.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 13:27:52 -0800 (PST)
From: Arthur Fabre <afabre@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	kernel-team@cloudflare.com,
	Arthur Fabre <afabre@cloudflare.com>
Subject: [PATCH bpf v2 2/2] selftests/bpf: Test r0 bounds after BPF to BPF call with abnormal return
Date: Fri, 13 Dec 2024 22:27:17 +0100
Message-Id: <20241213212717.1830565-3-afabre@cloudflare.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213212717.1830565-1-afabre@cloudflare.com>
References: <20241213212717.1830565-1-afabre@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test the bounds of r0 aren't known by the verifier in all three cases
where a callee can abnormally return.

Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../bpf/progs/verifier_abnormal_ret.c         | 88 +++++++++++++++++++
 2 files changed, 90 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_abnormal_ret.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 3ee40ee9413a..6bed606544e3 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -3,6 +3,7 @@
 #include <test_progs.h>
 
 #include "cap_helpers.h"
+#include "verifier_abnormal_ret.skel.h"
 #include "verifier_and.skel.h"
 #include "verifier_arena.skel.h"
 #include "verifier_arena_large.skel.h"
@@ -133,6 +134,7 @@ static void run_tests_aux(const char *skel_name,
 
 #define RUN(skel) run_tests_aux(#skel, skel##__elf_bytes, NULL)
 
+void test_verifier_abnormal_ret(void)         { RUN(verifier_abnormal_ret); }
 void test_verifier_and(void)                  { RUN(verifier_and); }
 void test_verifier_arena(void)                { RUN(verifier_arena); }
 void test_verifier_arena_large(void)          { RUN(verifier_arena_large); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_abnormal_ret.c b/tools/testing/selftests/bpf/progs/verifier_abnormal_ret.c
new file mode 100644
index 000000000000..5e246986945f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_abnormal_ret.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "../../../include/linux/filter.h"
+#include "bpf_misc.h"
+
+#define TEST(NAME, CALLEE) \
+	SEC("socket")					\
+	__description("abnormal_ret: " #NAME)		\
+	__failure __msg("math between ctx pointer and register with unbounded min value") \
+	__naked void check_abnormal_ret_##NAME(void)	\
+	{						\
+		asm volatile("				\
+		r6 = r1;				\
+		call " #CALLEE ";			\
+		r6 += r0;				\
+		r0 = 0;					\
+		exit;					\
+	"	:					\
+		:					\
+		: __clobber_all);			\
+	}
+
+TEST(ld_abs, callee_ld_abs);
+TEST(ld_ind, callee_ld_ind);
+TEST(tail_call, callee_tail_call);
+
+static __naked __noinline __used
+int callee_ld_abs(void)
+{
+	asm volatile("					\
+	r6 = r1;					\
+	.8byte %[ld_abs];				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_insn(ld_abs, BPF_LD_ABS(BPF_W, 0))
+	: __clobber_all);
+}
+
+static __naked __noinline __used
+int callee_ld_ind(void)
+{
+	asm volatile("					\
+	r6 = r1;					\
+	r7 = 1;						\
+	.8byte %[ld_ind];				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_insn(ld_ind, BPF_LD_IND(BPF_W, BPF_REG_7, 0))
+	: __clobber_all);
+}
+
+SEC("socket")
+__auxiliary __naked
+void dummy_prog(void)
+{
+	asm volatile("r0 = 1; exit;");
+}
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(int));
+	__array(values, void(void));
+} map_prog SEC(".maps") = {
+	.values = {
+		[0] = (void *)&dummy_prog,
+	},
+};
+
+static __naked __noinline __used
+int callee_tail_call(void)
+{
+	asm volatile("					\
+	r2 = %[map_prog] ll;				\
+	r3 = 0;						\
+	call %[bpf_tail_call];				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_tail_call), __imm_addr(map_prog)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.34.1



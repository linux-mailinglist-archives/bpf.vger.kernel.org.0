Return-Path: <bpf+bounces-43682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1159B8777
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 01:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09531C21114
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 00:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99051C82F0;
	Fri,  1 Nov 2024 00:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a29GzCw4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659D5146A72
	for <bpf@vger.kernel.org>; Fri,  1 Nov 2024 00:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730419229; cv=none; b=aX1k61n+3+BKZRRxEuyl0NDtruefaMGabYJ3X7Bihc9ETo3XgCwMNhrwAHhczgVohTsu/Yvvi9yN98Am37bYVFE/maFZ0EIUZkrG3Txuovgi7QfVcCv1Pqwnm7G/+GWKksReekwqD0eoSPNVqniISfk5vBS7c7YZj26NblifluY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730419229; c=relaxed/simple;
	bh=Uq+Pn5vKy24SYzPxuwtDF1UgFUVwDqGDt1giugo7kuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=njBFInXjo/h/w2BEfPKswgqO+fvYAwfUtu/qD+4te3YTvZBR831D/zXsEzdJYk9MP4usjukQiXcVlJeIS1en/aQP8iQnnU4FUezWweln1CL6SOxQY+1mfpf4alu5FIVyV83EFMXpqJgePQWDtk4zFbHQZQ6JhT8xAoESpCO22oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a29GzCw4; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-37d4fd00574so963860f8f.0
        for <bpf@vger.kernel.org>; Thu, 31 Oct 2024 17:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730419221; x=1731024021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7lQiyZkMcWLLUDaPPwVYcS9dCepEdQ2iTgComXuCEE=;
        b=a29GzCw4Abbj+UE6el/V6iz7tCC63pib0/RQzxXn3H5hWqFzS4GZRerdHedmOyaNxh
         SdwD5gw7o/KsP9Qe06xwiJX7xdLI0f4Ma5YuPONLwp7YeGxl5yDGvPpAU0VQt6+1Sslz
         6OWIz1MEBv8mpItfcQopV84pIi5gC/sPlfKQSzAyo6rlx6kNkv1S79/+UJeoqnk9Lmvm
         eCiuR2ZiZPWnKcIQ0xRDHYg/ERWtUJGCDzefJ9dKxZzXVCUgolQqQo822pakXj0lbPOs
         PUqZQ6b9jW3fNQMu8c/M/GazPjd5kb0A6tYyUBZCfr+BtuJmfglFzKRumEAkoy1zAPf1
         4TZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730419221; x=1731024021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7lQiyZkMcWLLUDaPPwVYcS9dCepEdQ2iTgComXuCEE=;
        b=YcX1IcqYD7qOvJ7lLDef0yKDqrgnQfxDjSUjBlOpFLNJGbc33axofcZ0L5W033K0of
         wOlYywFiKRjbv4FZ1Kt8MOm6NjIgfmmbH8Pn0m+mu1n6gSKJHYECG3haRbXgZuvRAmcM
         QnpqAEl1db4Ke4FfrmM4eM/NxinmB0HPY2UTqiBfKrsAQqM3tpIOqJ6wGClD8JTgWpqh
         xOJqLCUrJJXKdn443ktmCNPaXgLkvIFUXkzc35xB+0LBWB7e6rXOgoppOf1FqD0+KMxS
         LV5ysCm2qwwuFgPpD+4PNQePbyDxzMuVe3/CHKMAzW06EPNBARXGT+3TEAtg7ZrZAJWM
         I0mg==
X-Gm-Message-State: AOJu0Yw2vGs2mdOzEoHcrfSd0JCD47stp4P2DPGSg6oCecRy1/RutxlW
	TmqeX4R6/WaD7VPl1w+M9feAKY68MytL13fvtEoazbvUtHqyd0064GnP9wq50VI=
X-Google-Smtp-Source: AGHT+IHodFoSVi6ULSvcY8480KnR1uAlkBVtWexxcLxqqBJX/460fXZtf6mHGtyZUp9lcs/90u0wBw==
X-Received: by 2002:a5d:59a6:0:b0:37e:d92f:c24a with SMTP id ffacd0b85a97d-381c1305499mr4169113f8f.7.1730419221267;
        Thu, 31 Oct 2024 17:00:21 -0700 (PDT)
Received: from localhost (fwdproxy-cln-029.fbsv.net. [2a03:2880:31ff:1d::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d49c9sm3444484f8f.37.2024.10.31.17.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 17:00:20 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jiri Olsa <olsajiri@gmail.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: Add tests for raw_tp null handling
Date: Thu, 31 Oct 2024 17:00:17 -0700
Message-ID: <20241101000017.3424165-3-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241101000017.3424165-1-memxor@gmail.com>
References: <20241101000017.3424165-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3908; h=from:subject; bh=Uq+Pn5vKy24SYzPxuwtDF1UgFUVwDqGDt1giugo7kuA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnJBns09hGLe8+BqX/ctJSH4xRSBc6LCA3OdQQz+Zu LDtLW32JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZyQZ7AAKCRBM4MiGSL8Ryi5MD/ 4pQNrA59GpfYlakEp27dYOv09KJzwqmFa5UZlmfQ4trhJG6l1iCxkixz3+t8VLXcMPgV3yX4bZUbk7 pRI0H7/8RbJV41Tu7+F9z5vgapIo3JontweNK3wxqqX/aVdCngpccppUj65J9HgZhuEHnRWLzPGoUZ L5QjC7NOh/h2ZpZEz7yOsz0RSFj3jeqXqofMNfriymBXuKRRkAR3+y+V0COMDJdFFSIpB7Bw468Nge /o3o4vU1af72DwN0l6+m3r6ugD9RLaFW3Cni72tIciHueu/oME2UcQeLcDlGfxyn/PDc9UQpPMi6pY jp2s7C0q39wx+VbnHZkxcRLkDZzXmlB38EeCooKSxY9yspyxhnVfJFIME8TVm04oSIkCm0KmtOdvZp lZe76Qjx1gRCvMB/5NGjTLGTgDMPhYA6+6DGRtO2v34PmS+RgTD2/V/SMQbSYeQJOM2oP9d7CmnAms 8z29X9MRrjjFzu2tCS7pARXFs5t86aBc174yIIDyd5oDyQ2/tRCdSurex+Jpun7NDrGAwdyVqnw4DK kLpMoFepJK6AGCAysWAppYW1R6frqAdFz8BXx5yktL5FRPn76wgNyKSXDDaFwk0j0MIp6ttIDLNMKC s5nyjgg1uzvbNwT4fq0J0qYNeS2QaGyevG8CiBR5Xa+us51hvJ3zLDxsLK7Q==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Ensure that trusted PTR_TO_BTF_ID accesses perform PROBE_MEM handling in
raw_tp program. Without the previous fix, this selftest crashes the
kernel due to a NULL-pointer dereference. Also ensure that dead code
elimination does not kick in for checks on the pointer.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/bpf_testmod/bpf_testmod-events.h      |  8 ++++++
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  2 ++
 .../selftests/bpf/prog_tests/raw_tp_null.c    | 25 +++++++++++++++++
 .../testing/selftests/bpf/progs/raw_tp_null.c | 27 +++++++++++++++++++
 4 files changed, 62 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/raw_tp_null.c
 create mode 100644 tools/testing/selftests/bpf/progs/raw_tp_null.c

diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h
index 6c3b4d4f173a..aeef86b3da74 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod-events.h
@@ -40,6 +40,14 @@ DECLARE_TRACE(bpf_testmod_test_nullable_bare,
 	TP_ARGS(ctx__nullable)
 );
 
+struct sk_buff;
+
+DECLARE_TRACE(bpf_testmod_test_raw_tp_null,
+	TP_PROTO(struct sk_buff *skb),
+	TP_ARGS(skb)
+);
+
+
 #undef BPF_TESTMOD_DECLARE_TRACE
 #ifdef DECLARE_TRACE_WRITABLE
 #define BPF_TESTMOD_DECLARE_TRACE(call, proto, args, size) \
diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
index 8835761d9a12..4e6a9e9c0368 100644
--- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
@@ -380,6 +380,8 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 
 	(void)bpf_testmod_test_arg_ptr_to_struct(&struct_arg1_2);
 
+	(void)trace_bpf_testmod_test_raw_tp_null(NULL);
+
 	struct_arg3 = kmalloc((sizeof(struct bpf_testmod_struct_arg_3) +
 				sizeof(int)), GFP_KERNEL);
 	if (struct_arg3 != NULL) {
diff --git a/tools/testing/selftests/bpf/prog_tests/raw_tp_null.c b/tools/testing/selftests/bpf/prog_tests/raw_tp_null.c
new file mode 100644
index 000000000000..b9068fee7d8a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/raw_tp_null.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include "raw_tp_null.skel.h"
+
+void test_raw_tp_null(void)
+{
+	struct raw_tp_null *skel;
+
+	skel = raw_tp_null__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "raw_tp_null__open_and_load"))
+		return;
+
+	skel->bss->tid = gettid();
+
+	if (!ASSERT_OK(raw_tp_null__attach(skel), "raw_tp_null__attach"))
+		goto end;
+
+	ASSERT_OK(trigger_module_test_read(2), "trigger testmod read");
+	ASSERT_EQ(skel->bss->i, 3, "invocations");
+
+end:
+	raw_tp_null__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/raw_tp_null.c b/tools/testing/selftests/bpf/progs/raw_tp_null.c
new file mode 100644
index 000000000000..c7c9ad4ec3b7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/raw_tp_null.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+int tid;
+int i;
+
+SEC("tp_btf/bpf_testmod_test_raw_tp_null")
+int BPF_PROG(test_raw_tp_null, struct sk_buff *skb)
+{
+	if (bpf_get_current_task_btf()->pid == tid) {
+		i = i + skb->mark + 1;
+
+		/* If dead code elimination kicks in, the increment below will
+		 * be removed. For raw_tp programs, we mark input arguments as
+		 * PTR_MAYBE_NULL, so branch prediction should never kick in.
+		 */
+		if (!skb)
+			i += 2;
+	}
+
+	return 0;
+}
-- 
2.43.5



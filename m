Return-Path: <bpf+bounces-53831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51172A5C892
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 16:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74E7E16C44E
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 15:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FB125E807;
	Tue, 11 Mar 2025 15:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6zmSPnc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18613EA76
	for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 15:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741707769; cv=none; b=O2GmzC/8RiuK2JG5ZBlEeNdRVnV/arpx3wh5sWLVGMdfjS0829wyzc3ecv4CXAdY1g/UKZJI/xmdtVnFC+5a1s29Z2gDMIoiOzSBk9S8i03KoBcYFY9kLztD0btuIGd9dbX5wDxAntapBiEgJNw4zPULuWLlO9Hno+vBK1oOMjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741707769; c=relaxed/simple;
	bh=NA3j69UoM0zf7XUPjuf6mHx8jf5yeosy4cIBp1N6a50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qv55HCu9FO4fSzTjYUjYpToevNEP6iWcXtBViRiPmUiefje9/RktfKXI+8OFvR/lX8kqUyBX9b3qHmvgj49tuI+dgwpTu2ep2CDxrBbpuRdD1j0pjoZdyerDCKgYcB4lUz34dr3bfXATxMQOoa9J5VKmeBHKeofnuye29mQAW88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6zmSPnc; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso19099235e9.3
        for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 08:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741707765; x=1742312565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n9TaAOf9lpISdBitGwmAXRjLjRNfS2eNmvZ8/ic6dwE=;
        b=G6zmSPnctyvVAuvQV0udlqqufnlH8VVYD+tuowPw97SiFudlQsmlvlYukD0z14NA+s
         AHFrOa+755Xsxim+ca1Hcx9W5aKrueQOY5SPatyBLdO+zAibDErgobT+ahY3qGbWahBT
         JuDXHTNxFV+RtvCK9ebQpndRNsTVsg2OequHkDKhZlAbxlU2mli7ZPPIg5BgeuRZ5JN/
         BkvL8UnWNmX5bf8QBYd4NYlDVU6SsTK6zUlmEsRVvEi4021LepVR7o6ChpSG9AlNeOuK
         rhxoIqyD7De+IaUuRUpXtLchz5tkY2M0J0SvfBBYDzk0S5l8nCbtKDqS+DboWV7pRmAP
         bhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741707765; x=1742312565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n9TaAOf9lpISdBitGwmAXRjLjRNfS2eNmvZ8/ic6dwE=;
        b=Yt+X/p4C55EfEBIhfoYv92KU/VcK5skEJrbp630iTHX5frZoK8hU/A51WS9A8YH+Dh
         Quc9yGCvn8AeyNN7nSjxp+v4hCIg401gj+aCcZ4nhdLWLBGQADlKFr1H/5DjAGPfUkZd
         AjkI/ErQFqx4uNTXFJyhpKjs1qH2+oploJnls8REeTfus7EjvgL/V6AalW0aZMKT23kq
         mCVORBqNyPXYx4+wx/KqCZG9lBR5tqd9nsJdhSl5GquKqk4mTO0KfFRxfrb7952g9n1s
         Lmj1t3SWn2QaBFP1rxV6Ny1EvZAgylGJiTfjAPnqStN1xw8wE6MPliXrODt4ccE5Ye0L
         jEFw==
X-Gm-Message-State: AOJu0Yxdpg96Vn0pvM7Aeb7fLK4X1mxlzp02GUGeI16uU+oJelD+ygB1
	rPs5t9Jeq5EmOl2Wfu3Wmzm28wxLNL8BJoTeCJpVe4OXX9O5Vta8iM5OpjsGTRE=
X-Gm-Gg: ASbGncvYwehCn9sO2sRTpUkeg9g7f9lr7Ffy2DaxSdsg1TF2JwzxCMsFXhKkFfQHKmx
	q6GP1RBoaZBa/rQmOuozf8b3IBKEPclusf5TAILrEQy8+yE4LVu5sLRQ6YQt+fOJ/Y383tAOGEK
	xS0murTMIQtG5ajEOUypuhcMezxWpBRBl1staWnBmpIrvDVD4uxtPOm8a5TY8Kkligl6+qx5Tfp
	ST9s5uf9RwzN7EYGamU+CnJ+IGqzVhaJxH2gC+u4SOIRt9wNZTpXH8ZQCzH7SQ34dQk0dzwgLIW
	2siII06E0W7brGNhFVVxuEek1TvS/4oRnA==
X-Google-Smtp-Source: AGHT+IHzTMFLDkVLbbS2rI3sC9SSSL6SxOMGJVmF60V1HKccCq6c5BoiBKEdFezwrQ7hh3WeA0VyMA==
X-Received: by 2002:a05:600c:1d26:b0:43c:f597:d565 with SMTP id 5b1f17b1804b1-43cf597d774mr89097045e9.12.1741707765337;
        Tue, 11 Mar 2025 08:42:45 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:a::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cec60d122sm108935955e9.18.2025.03.11.08.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 08:42:44 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1] selftests/bpf: Fix arena_spin_lock compilation on PowerPC
Date: Tue, 11 Mar 2025 08:42:44 -0700
Message-ID: <20250311154244.3775505-1-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2920; h=from:subject; bh=SZF4Lg2XwhoXT2Sd+AM9CNA7ZCWXBilWV3JGozFxNJw=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn0FCKcJ/MH63MCNvL1aPGz01Kr86c4as4knMAlLhA 2ZwJPz6JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ9BQigAKCRBM4MiGSL8RygBgD/ 90kppGa1yMLYUt4C855Gy95sPc3Et+k4mAqrawgTeJjb4Yv4nkxWdj2dMDC2iQu6K9/fXYr/IYtbXy tttIngHZPP8Pk1UcCya9VFvGhbjEkL3X0sHH9gr82UW/PSIK3X6zjavhCKX4Hqw3jyxrOIgR3JMqpr RgLwmEs7ZJjhNpg4k1luPqlj44nSJ9Hehju02uWtiHQ+5xqbWo78i/frmYDitzFLsI/4imcE+xhDEJ 3w9sN3cyDmzXceWImSFTeIlg3FzDW433c183M1r/yJaFzSQLEqbQ+yzDl3Rwa23UEHDQH5Na4mjgEr C3ALn2kUdxARJ9EXO8wzADibdyTFUd6T4gxL/+/6g62fcDR+uyR8/HeZfyMsppY2kHiEAimyCoUb7Z 0z/OrbJY0TPMfKMcRezEnOfj5KZIbcw20PRjqDpEiaAJSLiEmvauyMNU+aLePr5x9yj+ea60n8qJaB iQLsVQPo1O1GreMpCCMApf6JLGO1EkA6dai1kHBiypSI9V4oKAtrDoW3z6+5w1JubDrhMsi1qySjzg OVlumGxwwMGQ7Ib5fj9CLjvlXrSjWxPIGx2aHFCDE42k49o5doi9IkPV6lSRr6r2xO0jZJdwGhN+c9 6EcJuxbmn1C9SBFHuJpshi3idJ7xWQEr7onPPD6/TJUrho8jIssVm2W85/wg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Venkat reported a compilation error for BPF selftests on PowerPC [0].
The crux of the error is the following message:
  In file included from progs/arena_spin_lock.c:7:
  /root/bpf-next/tools/testing/selftests/bpf/bpf_arena_spin_lock.h:122:8:
  error: member reference base type '__attribute__((address_space(1)))
  u32' (aka '__attribute__((address_space(1))) unsigned int') is not a
  structure or union
     122 |         old = atomic_read(&lock->val);

This is because PowerPC overrides the qspinlock type changing the
lock->val member's type from atomic_t to u32.

To remedy this, import the asm-generic version in the arena spin lock
header, name it __qspinlock (since it's aliased to arena_spinlock_t, the
actual name hardly matters), and adjust the selftest to not depend on
the type in vmlinux.h.

  [0]: https://lore.kernel.org/bpf/7bc80a3b-d708-4735-aa3b-6a8c21720f9d@linux.ibm.com

Fixes: 0201027a026c ("selftests/bpf: Introduce arena spin lock")
Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/bpf_arena_spin_lock.h       | 23 ++++++++++++++++++-
 .../bpf/prog_tests/arena_spin_lock.c          |  4 ++--
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_arena_spin_lock.h b/tools/testing/selftests/bpf/bpf_arena_spin_lock.h
index 3aca389ce424..fb8dc0768999 100644
--- a/tools/testing/selftests/bpf/bpf_arena_spin_lock.h
+++ b/tools/testing/selftests/bpf/bpf_arena_spin_lock.h
@@ -22,7 +22,28 @@

 extern unsigned long CONFIG_NR_CPUS __kconfig;

-#define arena_spinlock_t struct qspinlock
+/*
+ * Typically, we'd just rely on the definition in vmlinux.h for qspinlock, but
+ * PowerPC overrides the definition to define lock->val as u32 instead of
+ * atomic_t, leading to compilation errors.  Import a local definition below so
+ * that we don't depend on the vmlinux.h version.
+ */
+
+struct __qspinlock {
+	union {
+		atomic_t val;
+		struct {
+			u8 locked;
+			u8 pending;
+		};
+		struct {
+			u16 locked_pending;
+			u16 tail;
+		};
+	};
+};
+
+#define arena_spinlock_t struct __qspinlock
 /* FIXME: Using typedef causes CO-RE relocation error */
 /* typedef struct qspinlock arena_spinlock_t; */

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c b/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
index bc3616ba891c..7565fc7690c2 100644
--- a/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
+++ b/tools/testing/selftests/bpf/prog_tests/arena_spin_lock.c
@@ -4,8 +4,8 @@
 #include <network_helpers.h>
 #include <sys/sysinfo.h>

-struct qspinlock { int val; };
-typedef struct qspinlock arena_spinlock_t;
+struct __qspinlock { int val; };
+typedef struct __qspinlock arena_spinlock_t;

 struct arena_qnode {
 	unsigned long next;
--
2.47.1



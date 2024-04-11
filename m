Return-Path: <bpf+bounces-26523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643F48A1555
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 15:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8844B1C212A9
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 13:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DDC14B088;
	Thu, 11 Apr 2024 13:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2BJiJXu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D2D22096
	for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 13:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712841119; cv=none; b=dNeR6cl1D2MZAczd12yW7keuGxS6WGwXfH9eygtxxkxyQ1w8VWWgrGaX4OzikWaX/4dn7BNYrcw4DdY023RTalqll7GKxZhUUkc1t+tmJ0w/QxKW9wp5gngVuTKC3I186x6N9Ta3lf69epCoqcqnZf7b91A2rTW9xfn/6fTTLiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712841119; c=relaxed/simple;
	bh=k0Ffitchxny3KSMuVX+wRx0w09VJiP9MjH6zXeOnyy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bjjMIJPsx/XJEx4DDZXp6D+IbtfJx9fDYTc6XG4XKGwtamqc22iRc/3RTl86R1frBFulLfXKGEaq+UXF7nx/BcuukhrAVxAP7sIHtzeGoJsODOHmv96PX7IMQpc4Wr4KbsR9imabysNmrbBxuGsjqo1GnxTVC/IC+8Tyy6+/GHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2BJiJXu; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-36b00070a33so1350705ab.2
        for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 06:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712841117; x=1713445917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4QqDB33pU2qMglZHrTjKR/GT5wpdLJLpa4sZ1O/DeM=;
        b=L2BJiJXuuG+ymjFF3MGlakIwD+YZ3lWy7sgukl7k9ZjVMVoW50AJ7DQAGFG4QkIQa6
         ZD1vyuEzYGymlmtfbMmU57O+Qk/seCXLp4Cia8iCWTGtBo3opUKY7e/e58mep1g3WZkl
         8IlvS9JaEiQLPhUIbvhAZDmYhfdfCULaXcG5BByr4FRFTAdI4nezjT2XVbK1xe3lkcRU
         M1TSHUCxjqk+CQcInBa5WTU0IYgPfJQSbZ2pbfluQXcwecm66clsuKEcg0wbQyUd6Kek
         QMJQq1vgafxk1yJdRaDHmwaKUZsJHQ7tc2Y7cKaMBnppo60xlNSW0aL3G2NHXBRWyzr2
         53OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712841117; x=1713445917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4QqDB33pU2qMglZHrTjKR/GT5wpdLJLpa4sZ1O/DeM=;
        b=s9ryimR8zEoHFj35pXRMIvL5eV7f16F8n2mkNFTKA1XxzhVPHk6eSzcYcWiZJNDYG0
         Lz+MX1Y/AsZw60Poaqf+tH9wSDInZozurYzPkYVKjiNu6TzH/NO7NHk4uJXTefWYYYJd
         jQpTL0KmSnfR/0Cvnvknn6MuNM9cUuKqmtmDmq9xduXgKdo+0Dnqk4kcrgL6Z1avx7K+
         QP+aAk+RxyQCayjtWaRrSbZcgb0ywiY2CsbB8ObaoPKXUldYZePoO7N9KtvABJEyTPXf
         hnYq9J3bbULYMe2HWSUHJsRMKOihkzOAmmlXrKkjcbZRHUKl5ICg1Zx6dlFEfn3Kg4Ex
         a6sw==
X-Gm-Message-State: AOJu0YxZ2RnQ3mScsn2pcfm1qHwroJLfieX+BzCGvgd0cYb0QQBNEm/U
	FWFpXcxHPvC/OOJOoRo+AK1gPehWM6fEaw4OTeIFr6msmmBhP8pe
X-Google-Smtp-Source: AGHT+IEmToTOcfELldZWxVZZusMy2SoIGTGJnekF30ficH5yOdimASGYjwKv0BZ6Ryqi0O+TI/Aqlw==
X-Received: by 2002:a05:6e02:156c:b0:36a:1f17:526c with SMTP id k12-20020a056e02156c00b0036a1f17526cmr6770052ilu.11.1712841117011;
        Thu, 11 Apr 2024 06:11:57 -0700 (PDT)
Received: from localhost.localdomain ([39.144.104.192])
        by smtp.gmail.com with ESMTPSA id e10-20020a63aa0a000000b005dc5129ba9dsm1047654pgf.72.2024.04.11.06.11.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2024 06:11:56 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v6 2/2] selftests/bpf: Add selftest for bits iter
Date: Thu, 11 Apr 2024 21:11:27 +0800
Message-Id: <20240411131127.73098-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240411131127.73098-1-laoar.shao@gmail.com>
References: <20240411131127.73098-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test cases for the bits iter:
- positive case
  - bit mask smaller than 8 bytes
  - a typical case of having 8-byte bit mask
  - another typical case where bit mask is > 8 bytes
  - the index of set bit

- nagative cases
  - bpf_iter_bits_destroy() is required after calling
    bpf_iter_bits_new()
  - bpf_iter_bits_destroy() can only destroy an initialized iter
  - bpf_iter_bits_next() must use an initialized iter

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_bits_iter.c  | 127 ++++++++++++++++++
 2 files changed, 129 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bits_iter.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index c4f9f306646e..7e04ecaaa20a 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -84,6 +84,7 @@
 #include "verifier_xadd.skel.h"
 #include "verifier_xdp.skel.h"
 #include "verifier_xdp_direct_packet_access.skel.h"
+#include "verifier_bits_iter.skel.h"
 
 #define MAX_ENTRIES 11
 
@@ -198,6 +199,7 @@ void test_verifier_var_off(void)              { RUN(verifier_var_off); }
 void test_verifier_xadd(void)                 { RUN(verifier_xadd); }
 void test_verifier_xdp(void)                  { RUN(verifier_xdp); }
 void test_verifier_xdp_direct_packet_access(void) { RUN(verifier_xdp_direct_packet_access); }
+void test_verifier_bits_iter(void) { RUN(verifier_bits_iter); }
 
 static int init_test_val_map(struct bpf_object *obj, char *map_name)
 {
diff --git a/tools/testing/selftests/bpf/progs/verifier_bits_iter.c b/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
new file mode 100644
index 000000000000..2a02540cfd26
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_bits_iter.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2024 Yafang Shao <laoar.shao@gmail.com> */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include "bpf_misc.h"
+#include "task_kfunc_common.h"
+
+char _license[] SEC("license") = "GPL";
+
+struct data_t {
+	u64 a;
+	u32 b;
+};
+
+int bpf_iter_bits_new(struct bpf_iter_bits *it, const void *unsafe_ptr__ign,
+		      u32 nr_bits) __ksym __weak;
+int *bpf_iter_bits_next(struct bpf_iter_bits *it) __ksym __weak;
+void bpf_iter_bits_destroy(struct bpf_iter_bits *it) __ksym __weak;
+
+SEC("iter.s/cgroup")
+__description("bits iter without destroy")
+__failure __msg("Unreleased reference")
+int BPF_PROG(no_destroy, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	struct bpf_iter_bits it;
+	struct task_struct *p;
+
+	p = bpf_task_from_pid(1);
+	if (!p)
+		return 1;
+
+	bpf_iter_bits_new(&it, p->cpus_ptr, 8192);
+
+	bpf_iter_bits_next(&it);
+	bpf_task_release(p);
+	return 0;
+}
+
+SEC("iter/cgroup")
+__description("bits iter with uninitialized iter in ->next()")
+__failure __msg("expected an initialized iter_bits as arg #1")
+int BPF_PROG(next_uninit, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	struct bpf_iter_bits *it = NULL;
+
+	bpf_iter_bits_next(it);
+	return 0;
+}
+
+SEC("iter/cgroup")
+__description("bits iter with uninitialized iter in ->destroy()")
+__failure __msg("expected an initialized iter_bits as arg #1")
+int BPF_PROG(destroy_uninit, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	struct bpf_iter_bits it = {};
+
+	bpf_iter_bits_destroy(&it);
+	return 0;
+}
+
+SEC("syscall")
+__description("bits copy 32")
+__success __retval(10)
+int bits_copy32(void)
+{
+	/* 21 bits:             --------------------- */
+	u32 data = 0b11111101111101111100001000100101U;
+	int nr = 0;
+	int *bit;
+
+	bpf_for_each(bits, bit, &data, 21)
+		nr++;
+	return nr;
+}
+
+SEC("syscall")
+__description("bits copy 64")
+__success __retval(18)
+int bits_copy64(void)
+{
+	/* 34 bits:         ~-------- */
+	u64 data = 0xffffefdf0f0f0f0fUL;
+	int nr = 0;
+	int *bit;
+
+	bpf_for_each(bits, bit, &data, 34)
+		nr++;
+	return nr;
+}
+
+SEC("syscall")
+__description("bits memalloc")
+__success __retval(56)
+int bits_memalloc(void)
+{
+	struct data_t data = {
+		.a = 0xaaaaaaaaaaaaaaaaUL, /* 32 bits are set */
+		.b = 0xbbbbbbbbU, /* 24 bits are set */
+	};
+	int nr = 0;
+	int *bit;
+
+	bpf_for_each(bits, bit, &data, 96)
+		nr++;
+	return nr;
+}
+
+SEC("syscall")
+__description("bit index")
+__success __retval(8)
+int bit_index(void)
+{
+	u64 data = 0x100;
+	int bit_idx = 0;
+	int *bit;
+
+	bpf_for_each(bits, bit, &data, 64) {
+		if (*bit == 0)
+			continue;
+		bit_idx = *bit;
+	}
+	return bit_idx;
+}
+
-- 
2.39.1



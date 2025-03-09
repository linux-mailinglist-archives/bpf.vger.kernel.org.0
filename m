Return-Path: <bpf+bounces-53694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD0EA5890F
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 00:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9D86169876
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 23:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECEC22173D;
	Sun,  9 Mar 2025 23:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="jR/1NXKI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827351AA1FE
	for <bpf@vger.kernel.org>; Sun,  9 Mar 2025 23:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741561488; cv=none; b=JMoPa+duVTK874MbiQsMLzYmS3W3yrcj7YaWD7+hN5+WhtDFPn/DSP9TVYRBf6ACAXgbLe34dpkgSgk4vSPloWLvyf3ZZlw7UPKSo7o2nKf5jme7aPiWZDayjl2H51JZIPn8BEpPSlMAzTIQJ3dtBbpEL6mbVMv/oR1drOUxBjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741561488; c=relaxed/simple;
	bh=+S5Vxutoa3QR+qRS6c++NVOYFAhizhNAhy2gdWEjKNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YxejYK0Ckeb10m2KDlP7mpWx2WzBsV/mhIJvkLNe5hVAGQmHO6JX+VT1Dto8nsItZ6XCVuzjqIkZGeXhNIRrcYB45GZar9HQkkTlw7gh0dDfmHqsON+5DuN34MO2fcB3LfrareuaDjCxoH1+nQUQzyoDRO89KlDamBO5GUdymlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=jR/1NXKI; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e8fca43972so31708586d6.1
        for <bpf@vger.kernel.org>; Sun, 09 Mar 2025 16:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1741561485; x=1742166285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2fDQI8yRES5T0CyJuyUh+sUimZlajJHcS+D2bNNu9jM=;
        b=jR/1NXKIeyA45QD1PGjMypiS0U1KeKQ5r3/t2iv+yjAXX7CV2ZvTu65/tiuknsR/FI
         u0ghLQIdTzxwN5CKfMSHN0zn/gYlDm7LMM0zSS5lN3ET1McbArajTYcVnOjOLvlZfw1n
         9mk6Hl+8idTeKBXl+m7nefUdZI+EM2V6GBHTNTgKI6xmH9LJgxLDJdjkNCaiccQc1iTm
         u5YbZuYCb6IMkSNANlaZjCvrmhSQrc2n5BGauVWdTWxUm1rqB8Top6O3kC5qupH3/Pm+
         WFdD3N83KK4iRISJzwSYLEHe5qAXlvYGGddK3xpA/LzRtaiErmFFSxNswqR18vzFLKnB
         tqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741561485; x=1742166285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2fDQI8yRES5T0CyJuyUh+sUimZlajJHcS+D2bNNu9jM=;
        b=EDy/knUXwIAfPuFVYTvezf9ceVmYx43PTuA6Dv+QL2xP3wJiV3GKODaCzwHJ7xY4eO
         Z+reiRjLlnGt6qFhdDSO1IY4GZEbswsEpGwjdKH9Lyre1yEAseo93J0WFyJkoYU/d2sJ
         J5TEg0nEgwfT10vPVNYE08DNzVlGZP33ZT7/VhIosWNOrIUZCQCHnkf82j9vEdXXEumA
         /dURFedbFWxtsm8bnBSmD2gdQOhHBFc5/k4qurvhQCYmYIWEaZ0m+FfVIGcN/p1oKKn9
         tnJzjfeiwfhRXpDQe1PAQrFXHz4902ZmxnfQeVbUTLi0c0l9yhvb834O48X4ILj2cc7i
         33tw==
X-Gm-Message-State: AOJu0YypziURf6cU04j61N5pooxG2sssuOyZHqCxyC9ia2PEkCViFbPl
	tBD0neyTnCG0c5d9tN9FW++WAudQy4V56Ny6TfMvkoaRBjc/UBim0gIp8h2n3CBH9nznJ/p5v5t
	qfU1AMw==
X-Gm-Gg: ASbGncuJFhre0SWhoFUVNYcMLyBZ6SzZOeHFVcAJHb8/idNOIz+oc5HK0ooJaWOK6pv
	6leDgMD2KuM0cBlcO1E8qjQLMnPz2/HIdVed2aGv6uYaGp3P1SgI0fYydYEmM/endk9URKXZots
	O8bioZe+Tr77PpzTXphtrO4kYks4z2naiaBhpJTeJGLbwD9CaVWrEWPBBBsc+SP51jKzg5YP4jL
	hmJP+25taIw1iyfk+cfpr60XbHyDITfpX+5rUdDeuGGXxw8yulFUH13W7gTjc/ACH+F0EYLVmoQ
	BU/P854onShBfwrttVkg+8+vggv7lr1aNum/58Czcw==
X-Google-Smtp-Source: AGHT+IEdIjWYj/mxFDLhFSAcBe7WCglCPU2ebhEStQA7CPE0Ssn8j7fQxfqXG23P2AZ+1YccBxas5w==
X-Received: by 2002:a05:6214:2584:b0:6e8:8791:54e5 with SMTP id 6a1803df08f44-6e90063625cmr144927826d6.26.1741561485269;
        Sun, 09 Mar 2025 16:04:45 -0700 (PDT)
Received: from boreas.. ([140.174.215.88])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e9146790casm14378406d6.55.2025.03.09.16.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 16:04:44 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	tj@kernel.org,
	memxor@gmail.com,
	houtao@huaweicloud.com,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Hou Tao <houtao1@huawei.com>
Subject: [PATCH v7 1/4] bpf: add kfunc for populating cpumask bits
Date: Sun,  9 Mar 2025 19:04:24 -0400
Message-ID: <20250309230427.26603-2-emil@etsalapatis.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250309230427.26603-1-emil@etsalapatis.com>
References: <20250309230427.26603-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a helper kfunc that sets the bitmap of a bpf_cpumask from BPF memory.

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
Acked-by: Hou Tao <houtao1@huawei.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 kernel/bpf/cpumask.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index cfa1c18e3a48..77900cbbbd75 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -420,6 +420,38 @@ __bpf_kfunc u32 bpf_cpumask_weight(const struct cpumask *cpumask)
 	return cpumask_weight(cpumask);
 }
 
+/**
+ * bpf_cpumask_populate() - Populate the CPU mask from the contents of
+ * a BPF memory region.
+ *
+ * @cpumask: The cpumask being populated.
+ * @src: The BPF memory holding the bit pattern.
+ * @src__sz: Length of the BPF memory region in bytes.
+ *
+ * Return:
+ * * 0 if the struct cpumask * instance was populated successfully.
+ * * -EACCES if the memory region is too small to populate the cpumask.
+ * * -EINVAL if the memory region is not aligned to the size of a long
+ *   and the architecture does not support efficient unaligned accesses.
+ */
+__bpf_kfunc int bpf_cpumask_populate(struct cpumask *cpumask, void *src, size_t src__sz)
+{
+	unsigned long source = (unsigned long)src;
+
+	/* The memory region must be large enough to populate the entire CPU mask. */
+	if (src__sz < bitmap_size(nr_cpu_ids))
+		return -EACCES;
+
+	/* If avoiding unaligned accesses, the input region must be aligned to the nearest long. */
+	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) &&
+		!IS_ALIGNED(source, sizeof(long)))
+		return -EINVAL;
+
+	bitmap_copy(cpumask_bits(cpumask), src, nr_cpu_ids);
+
+	return 0;
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(cpumask_kfunc_btf_ids)
@@ -448,6 +480,7 @@ BTF_ID_FLAGS(func, bpf_cpumask_copy, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_any_distribute, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_any_and_distribute, KF_RCU)
 BTF_ID_FLAGS(func, bpf_cpumask_weight, KF_RCU)
+BTF_ID_FLAGS(func, bpf_cpumask_populate, KF_RCU)
 BTF_KFUNCS_END(cpumask_kfunc_btf_ids)
 
 static const struct btf_kfunc_id_set cpumask_kfunc_set = {
-- 
2.47.1



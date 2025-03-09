Return-Path: <bpf+bounces-53696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B7CA58911
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 00:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F5616992C
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 23:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1BD221D93;
	Sun,  9 Mar 2025 23:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="abB+efjJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5682144AE
	for <bpf@vger.kernel.org>; Sun,  9 Mar 2025 23:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741561489; cv=none; b=O1HaYBVBieAiBO73aDbPZqJPuawNukHVTnhL/aohk+L5jjRAovEnV7Nle7m/4MDIuk7MVLs0LYPAcxYhDcTHznrJvWwCIJfoATfS5Qz9Y5ew5/taWPOIFDvAw/ncCMa+6EMyUD2ALWZlgZvehyKlKgHIDjegc75EBqWNvGDdyPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741561489; c=relaxed/simple;
	bh=pffXZtsvnmipo8zxunVckuQSInHRDVZnsOQw0ZSXVIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aM9jn7v8opuFGQ5C0iw992e2yiuxnRJfiW2HSWxpqbTWe0XVp5CMbUCTCKbpNVL7cWi0SnLl6et2+CxlDM0BlYgi6RXk+By1FEDZdul5sHZbFKKugFC3UBAFzfwUtHoMLkR5i8WUq161tWAueBCxJ1GjzufHePR3O+nH/TcNUtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=abB+efjJ; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c54b651310so107557485a.0
        for <bpf@vger.kernel.org>; Sun, 09 Mar 2025 16:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1741561487; x=1742166287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOjHJ/XEu8gnFlKw6M/pi/0WwNdhD20bEIw+Ix+DTXM=;
        b=abB+efjJ4MhT2Be0LQswXFD4LQTctZhcK9VCZF4fv9cxzOz4NKoJsyEMuWr3gMViDE
         FyA8fUYkaIPEXAxEIqlYtEDkuTyqemekId/4n+MlcDU9MWku9qob2v6pvVRQRjoHr8F7
         RH3x+Z0eCHbZYEo3t05bW7Ox87STMcAkJdpZ1cxDbVw4soZKCtbhUOdcnOcZH6c2wkF+
         qFpdDU7G8exLpsCawfAkfvNI1DH18/ZOiSgJlveGiNtgtThyr/1gP4td4epjMLAnKaZW
         HkprVuhCVQdDc4iVGEzTzoRlobrMaK+jVOyC0tFxLqOCryjIUTpEKyGIrQXaRCK8hFaG
         rHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741561487; x=1742166287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lOjHJ/XEu8gnFlKw6M/pi/0WwNdhD20bEIw+Ix+DTXM=;
        b=RR5DYpknXjFqx+m5FelAjbQuT2Hzy9TARJM1YByGATVILWVWXYvHIIfq1L87ephFT9
         6UuCrIpgPnQcsuWDBWA0posbhk7h2bS/iWmurFr4VjhS+oGxALPbLw1modzWUgQeDnti
         j/wH5WhWX4njzsE8/GFjTjarzOdcw7X1W22Ynyt9NI+CCGjQH25CH4UFzCN3EP8oyfQo
         /+Nh1kUnY+/v0HJgN0l7/bBSN0due2lYyQdcNzYZIXYq8CR77GmO4wc9KJF/EfNXdbsq
         +/aWHEN2vzTTLWdcaU6EpFrddS6XCngiYIROq9DINHcqDHhV80t074MV9zMOD0IAR/kA
         ED/A==
X-Gm-Message-State: AOJu0YwD+f21i389SUCH4DM3p8W24DWnsYjMhjphYGHGpZF+UHUtP16R
	X6C+eYC9kGMMx353ZFPXhHARPE/dNyDUqxulu+/KFt7v9SN6kv+LC0C5kr1iRDhz8ZKlbFhUczE
	tymQLPQ==
X-Gm-Gg: ASbGncvDjcH1IiK/aHLiwQC1r4PzZIyyMHbBKUI0f2zUZ8PwUjuMBXOfTWchesklDLM
	CgY8QxzxONNZxTJlPyiLfrhDeyCq5sPUSWdoJYlZnr+11Mp7T/sSvd+jiobKIpxGzLEz+DZ1tiX
	kQGBnelDdTeF/5a5KT/9PxnHZXfkylDYdbhfdPmiN4HlNJmDZ++QeSCYp8+Wx+V+hIHWDZrjBmS
	/4tTSunB4Shr0VgckRJk7Ebb/O7wyfEXSYrxtI81X5FYQQh388oC5phRsk5GUihx36j6R43MqqU
	MVesDi6al2SQITp3YyEPpyzf6DsNPk3qX+cWhk0WjA==
X-Google-Smtp-Source: AGHT+IH7Uov+Req7lF6GjpjU4SZjqYEvopsFZ4r9bgDM8WxdHpPGk3/pC5O4PZKd/Y2mpjAEdV7cZg==
X-Received: by 2002:a05:620a:650a:b0:7c5:5339:48cf with SMTP id af79cd13be357-7c553395066mr327910085a.30.1741561486658;
        Sun, 09 Mar 2025 16:04:46 -0700 (PDT)
Received: from boreas.. ([140.174.215.88])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e9146790casm14378406d6.55.2025.03.09.16.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 16:04:46 -0700 (PDT)
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
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v7 3/4] bpf: fix missing kdoc string fields in cpumask.c
Date: Sun,  9 Mar 2025 19:04:26 -0400
Message-ID: <20250309230427.26603-4-emil@etsalapatis.com>
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

Some bpf_cpumask-related kfuncs have kdoc strings that are missing
return values. Add a the missing descriptions for the return values.

Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>
---
 kernel/bpf/cpumask.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
index 77900cbbbd75..9876c5fe6c2a 100644
--- a/kernel/bpf/cpumask.c
+++ b/kernel/bpf/cpumask.c
@@ -45,6 +45,10 @@ __bpf_kfunc_start_defs();
  *
  * bpf_cpumask_create() allocates memory using the BPF memory allocator, and
  * will not block. It may return NULL if no memory is available.
+ *
+ * Return:
+ * * A pointer to a new struct bpf_cpumask instance on success.
+ * * NULL if the BPF memory allocator is out of memory.
  */
 __bpf_kfunc struct bpf_cpumask *bpf_cpumask_create(void)
 {
@@ -71,6 +75,10 @@ __bpf_kfunc struct bpf_cpumask *bpf_cpumask_create(void)
  * Acquires a reference to a BPF cpumask. The cpumask returned by this function
  * must either be embedded in a map as a kptr, or freed with
  * bpf_cpumask_release().
+ *
+ * Return:
+ * * The struct bpf_cpumask pointer passed to the function.
+ *
  */
 __bpf_kfunc struct bpf_cpumask *bpf_cpumask_acquire(struct bpf_cpumask *cpumask)
 {
@@ -106,6 +114,9 @@ CFI_NOSEAL(bpf_cpumask_release_dtor);
  *
  * Find the index of the first nonzero bit of the cpumask. A struct bpf_cpumask
  * pointer may be safely passed to this function.
+ *
+ * Return:
+ * * The index of the first nonzero bit in the struct cpumask.
  */
 __bpf_kfunc u32 bpf_cpumask_first(const struct cpumask *cpumask)
 {
@@ -119,6 +130,9 @@ __bpf_kfunc u32 bpf_cpumask_first(const struct cpumask *cpumask)
  *
  * Find the index of the first unset bit of the cpumask. A struct bpf_cpumask
  * pointer may be safely passed to this function.
+ *
+ * Return:
+ * * The index of the first zero bit in the struct cpumask.
  */
 __bpf_kfunc u32 bpf_cpumask_first_zero(const struct cpumask *cpumask)
 {
@@ -133,6 +147,9 @@ __bpf_kfunc u32 bpf_cpumask_first_zero(const struct cpumask *cpumask)
  *
  * Find the index of the first nonzero bit of the AND of two cpumasks.
  * struct bpf_cpumask pointers may be safely passed to @src1 and @src2.
+ *
+ * Return:
+ * * The index of the first bit that is nonzero in both cpumask instances.
  */
 __bpf_kfunc u32 bpf_cpumask_first_and(const struct cpumask *src1,
 				      const struct cpumask *src2)
@@ -414,6 +431,9 @@ __bpf_kfunc u32 bpf_cpumask_any_and_distribute(const struct cpumask *src1,
  * @cpumask: The cpumask being queried.
  *
  * Count the number of set bits in the given cpumask.
+ *
+ * Return:
+ * * The number of bits set in the mask.
  */
 __bpf_kfunc u32 bpf_cpumask_weight(const struct cpumask *cpumask)
 {
-- 
2.47.1



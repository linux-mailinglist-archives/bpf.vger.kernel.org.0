Return-Path: <bpf+bounces-53400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D53C0A50D20
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 22:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4CDE3ADDA7
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 21:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDCA1FC0F3;
	Wed,  5 Mar 2025 21:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="tpRMzpeO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040F1253330
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 21:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741209168; cv=none; b=l+HSJVOynnuMAUwD3Eypq+XW6xUxz5fKAbEcu+szfrp9gm2bMZSAuwlHtqHlCgrXjFoVtKH3abPO1LyvTZUujGY6OWfZOsZTFwMWSDsvM+BxRNtsdtUVX9ELdsvLm9md7M6xLJfdYT5PftAKl/Ga4RIhu3tzhfHrFhPFzOVJ8EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741209168; c=relaxed/simple;
	bh=mv+HCMVBbVmHqdUiugOOXjr5g7BLszR+Jps6EmD+8CI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qnorkHhSaOzYdYR9j0BcAbWUfkn+tYonDbOuPnDQ8sVadgNkbc4SJa+B58zT6vDhIk/rIaDkg2w8ejowA1SU9CUec2Ochk1cC9EykjBbcaNYZUlkMaSBbVbwZfsnnaMoi0qJlhRITE7V7UTviNruvnxfuOAVMabKIktj9OALiG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=tpRMzpeO; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-474f8d2f21aso13400471cf.1
        for <bpf@vger.kernel.org>; Wed, 05 Mar 2025 13:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1741209166; x=1741813966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+HdrhctNSRPqibWATjlfkSbi305qwbCuRWPmEde3E5Q=;
        b=tpRMzpeOoIUi05hpw4WE9JDnSB+yH69XaC73LpezlRFmRKHTa6WUo6fjIqw3PEmH9O
         ZcQAwuy/Rxa9Kym41OFavMyeSWgUMEcHkE6Oe8MggKHIujr8UaznmH8xcW7YwbOi7ZlV
         bVJgpz/SJIN4FrFCnvEInGNek/NP9vcy6HpLWWKLcC22sZ9rgeudkJ0PK7BCfyqUAAbt
         QyXkh9ZEbwFTWW0RD/cg0IefCy7c8JJzFhT1rjRjBN0K62fKC7JytzFv0R9jg0FyCWrl
         wWY8Wo7tiQX4H8O8CXWEJfym/uM5DWLQNsCM8bh97XHLjYyqffmurqI/cseUu+uOBFMB
         pCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741209166; x=1741813966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+HdrhctNSRPqibWATjlfkSbi305qwbCuRWPmEde3E5Q=;
        b=YLpPZ0axeJBGPNHOAZZY3okcrjeSgMxh6pvKlydZ8b7ApFI1ysjrE/hODWXJ1XtWCy
         5afd43LJymKwWTgsGt0GD5yzWfjlahME+jTwrYKC98qFLJU0i0I/UPmafdsbU+ANDxbi
         q0DrSVsYDuMldi2gQXl5Gym+gipE5ZHMrCa4ASQPyliPv6PRRl5thsyDtDU6UzjBz6o5
         tDFknmVYfYKyR0m62lZ29j0qm7egn+kcZXD48vQyX2nAswjqx0QWU+FjGAe3usPdZUdc
         Pn5KFJYC/omnm6aNESZE78kJ1T6VObPWQLCGMazyl6VM7zXKvvSzZ3OyiNIpM9ed6YkF
         B6NQ==
X-Gm-Message-State: AOJu0YwPhBvhfYkn4/W3Zfh0Ykxfn7FT1L7/RR19B3F+8zoLNCyTYVJa
	kOnZiqFyK29HRqhQxckL13sQRo9jWWDjIDO3b+P7PRFlMGMmTaEywbY/FqFAzzJa90Dc8voFKFH
	taC1ROA==
X-Gm-Gg: ASbGncvg861OMIyLO4y8qFMpD484NFMLj87RIP+fkji1Bnc4u6dvv51WZ8mP1Xhny2Y
	eWbM1vK38PHmoZdc9QSemX/TyEMg/ZqlWQVBxqyzCBosxwC85ZPY1E/7o2kwKHATaW6PNwSadXs
	DroTOVn4jBsyUNWXaty7RWfJ6R27ioc6iiz91Os5VSh9H4CorAv9TxQqTQYI1pA7wDcgL2vG0sB
	IHAAI96y7vUI/cVlTMOn/YQPaIkD7+p+xRWz/5kPJWHLyWWHkfWVQBOX+rrMsPS6CUMHhMQAv5r
	Uxx7bZsUa6OWyav1kTMRoupu5rb+/g7pW+iJeaxKsQ==
X-Google-Smtp-Source: AGHT+IH4foH7Cl+tvYD9TDDLPV/SyS8wxg3WAn2r8efZr6It58SvH5pWbC2zL/GPeFHltEJVLdYXWQ==
X-Received: by 2002:a05:622a:1ba1:b0:471:bd14:a783 with SMTP id d75a77b69052e-4751a65466emr13784881cf.25.1741209165896;
        Wed, 05 Mar 2025 13:12:45 -0800 (PST)
Received: from boreas.. ([140.174.215.88])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474eced9880sm43726851cf.17.2025.03.05.13.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 13:12:45 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	tj@kernel.org,
	memxor@gmail.com,
	houtao@huaweicloud.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v4 3/3] bpf: fix missing kdoc string fields in cpumask.c
Date: Wed,  5 Mar 2025 16:12:35 -0500
Message-ID: <20250305211235.368399-4-emil@etsalapatis.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305211235.368399-1-emil@etsalapatis.com>
References: <20250305211235.368399-1-emil@etsalapatis.com>
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
index 14080ca694b0..c6c1ec6d2b2c 100644
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



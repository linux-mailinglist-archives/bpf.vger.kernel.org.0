Return-Path: <bpf+bounces-61421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 673CCAE6F3A
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 21:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4559B3BCD48
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 19:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13962D5437;
	Tue, 24 Jun 2025 19:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLzqUMHz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E4E248898
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 19:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750792220; cv=none; b=NIzOWB3X1PopSI6LbMknpJqile4iE/4effQY/jWTd8bGFG2Xwuupt9HrfE9u+fpkHI8SiXsW5i/QI9O/o/wh3hQcgE4iiKmFUVm12KDeukZI1DRiozvPYLrcOQ1mM6Jjp/sGQnewtikWI5HvYGTHT28zUvFXQTGenfb60w4Ckew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750792220; c=relaxed/simple;
	bh=x1O/JA565UIX/K21ox6cxmMdMtZIUFW4tqLJZcfXPsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p6+X0e6VV46pPemBkaa26o5pAs/LUnIqWWR/4j6zq9t3Tw4ohfzzFCtWUCqaU+NNGf32gutXUDQBVYfC7sHUOGm47BozUmOXBQiU9or974pLIXdDpVoDLahwh9s75+I6O2RTQEiuIkT9c751+0VEc9cY4ZcPSx6mr42FTq5WQbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLzqUMHz; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-70a57a8ffc3so9702737b3.0
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 12:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750792217; x=1751397017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TX+oxwqVgIWivvv02YJc6IR9uahfAlKK8BZAEPmEt6c=;
        b=LLzqUMHzapllUAAIUWTZIT6gNwaZ1tNtaCvLBBKZz+31jq1n8vW7IZxFaqlPq21uhO
         f+w7DFJ2JSuJwG0bF/md2pJ35uoWiGlelL+/ZxyoP+nc7yDH8DUHFCLR5huzvO7Q4pT8
         4AonXAC1qFrvZRerJqiPb81vFPM76jp0o4Ifl2G2mxE3N6SNHsF6+DLb5SpE6d8J6SWt
         4WyL8WVcfhwp/D3e2P1hOJJbVsVRQC/f2DLXQ4uuOWWiM/moT4ZYceC978Am9SGwqqxm
         aaVq6V8UeYbCFRdJCzSov8jU4UdoSwt0yEP1ALOu3z5Nd5YrvkQ52tIOoawvdNSUoJIP
         OmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750792217; x=1751397017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TX+oxwqVgIWivvv02YJc6IR9uahfAlKK8BZAEPmEt6c=;
        b=KxRBnEqUoYpIlZMcFzeP42YZqj3lKtervryfceejAgtagoGS2zfSH85Ccgwe9d12hX
         E5AaZo9coMqw8kFtuK9qGmUErR4XX9k60NszhDuwBoyIQlCjGuMFujoNwbGkf8lbn7h7
         Ijf9SdggoVUdH8LV8p4sQIO+GWru41LhMXyFxM3Id8VuW+fInLvkM0ULlHVbL0cMvA7S
         040owYPQg/kOWdYswv/f0WtuLri5rrT4Zasxfa3Nvq4L5867eo1P1BJfonZL3YD2U5ov
         ft7N+RKuZ5axIcXQ9BeznCm1egt7HhqPoRiEnGuVIzpiHLxzLeg9+CodvIJwIQhsSLeB
         LW/A==
X-Gm-Message-State: AOJu0Yx7A4CfMBD9UZHtPzKc4axweW/PoVDTGLZBJhBPTRYqhEE7rPfJ
	Yh9jwV8YdQSIcaMl6uBJsSLyI9Jy0aIRPAL/YJVjBf0p3qfVHSh4yoqHn9hH5lsD
X-Gm-Gg: ASbGncuN09JUIyR1MWe/n4A1QzPKgXYr2TywtKYGX74GlN/5/97bFm2ouQsC0Z9v9Ye
	tJjGShGh0Ai41hHbgu/FOk1SHnr62zUn2kOEoKvQwN/1G7wjULmu6sPwe2hn6PvAy1y0UK8ZuCc
	5iabJsfFkFGUEpPKlb29WIG9v+ZGQUBD1dRLoTpaHMxfdqpIZQ2doaYtHY4lpn0JJrIt2j6gPUI
	NWhsroHGO8Q4x70D1NMny19w4ZVLX0rPbfqWC1nrHLKBMICeRcstdjX+RNNAYLn4zZDpDK5fV+l
	kVVP1xmLOxwxqucZm2wyi0BaktxeJEMWleu2As1MCn/BEe43QtD5ig==
X-Google-Smtp-Source: AGHT+IFCaIZEFH+Z/St7Bv9vinFPgJytp5gFadimker9jnN2+QpQKjRpb6mj41FDX1qodOE0hdJqQQ==
X-Received: by 2002:a05:690c:3391:b0:70e:2a0c:bc5 with SMTP id 00721157ae682-71406e1ba1fmr1155857b3.38.1750792217109;
        Tue, 24 Jun 2025 12:10:17 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:72::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-712c4bd6aecsm21223777b3.82.2025.06.24.12.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 12:10:16 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v1 2/4] bpf: add bpf_features enum
Date: Tue, 24 Jun 2025 12:10:07 -0700
Message-ID: <20250624191009.902874-3-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250624191009.902874-1-eddyz87@gmail.com>
References: <20250624191009.902874-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds a kernel side enum for use in conjucntion with BTF
CO-RE bpf_core_enum_value_exists. The goal of the enum is to assist
with available BPF features detection.

Support for bpf_rdonly_cast to void* is the first feature listed in
the enum. Here is an example usage:

  if (bpf_core_enum_value_exists(enum bpf_features,
                                 BPF_FEAT_RDONLY_CAST_TO_VOID))
     ... bpf_rdonly_cast(..., 0) ...

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8fd65eb74051..01050d1f7389 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -44,6 +44,11 @@ static const struct bpf_verifier_ops * const bpf_verifier_ops[] = {
 #undef BPF_LINK_TYPE
 };
 
+enum bpf_features {
+	BPF_FEAT_RDONLY_CAST_TO_VOID = 0,
+	BPF_FEAT_TOTAL,
+};
+
 struct bpf_mem_alloc bpf_global_percpu_ma;
 static bool bpf_global_percpu_ma_set;
 
@@ -24436,6 +24441,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	u32 log_true_size;
 	bool is_priv;
 
+	BTF_TYPE_EMIT(enum bpf_features);
+
 	/* no program is valid */
 	if (ARRAY_SIZE(bpf_verifier_ops) == 0)
 		return -EINVAL;
-- 
2.47.1



Return-Path: <bpf+bounces-37165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F273895180E
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 11:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3205C1C2129E
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 09:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8453C50269;
	Wed, 14 Aug 2024 09:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="abD175Gq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CC913CFAB
	for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 09:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723629055; cv=none; b=nh498KWDdCFhc4lHIsLYnLhP72krB0LlDGKIQcUweMP0IegLQaZn46TemroEXhY0H4FJZiQu+IF7WUdQVGlzffqnT76b0MthBQ9Cg0lGs2eYq8sFxL5Csm6sIuHNxrV4qO8yFHEctN0lFDaNHowoCofO7Lvs7Qel50Ai6BzBI+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723629055; c=relaxed/simple;
	bh=tvP+ymsnDMznZtXYdqtZp4WFdN7ZA4422EzK5EWIjIw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bVO0BOeoN9UivL5AI6QETYDE+QtThzcUgKMz+OKlz3mKq3BbJPM1kDn5YMyt4Z4cBbdEfdnkuGkju2Ju8O394csmGmJN5pdqkcUnL7g19jXvbEWT/g4G+XBMq90Ky9yLBRbnQZxY5NKlsEAb758+vdVljtRd4ZBvnRat8v86GcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=abD175Gq; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fd90c2fc68so44950625ad.1
        for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 02:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723629053; x=1724233853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B5EPTuGtOAwR22klO2g+2qxnDn7zedpJJVEUqzrIeGY=;
        b=abD175GqyMY0t5QRmLXMLxzDWEYVa+ZKtd3tiq2ZEKf3bAgQ6ZXrcADxQNHiLSN3AZ
         TvoWSCv1KdFXbvBXu7slzOr8yJwl28twFO8/ZRc8MFabibKWzF/S+HYs75rFo22+blbt
         /nF5ePo5OKe74eFewLG6U2Xyx/TDMUa/6Zf0LbpRFGKgopMofzuwP24h+kd00M/gFVF8
         1oN/pmkEWytauuOvlN67dqGTzamEeceYsrSIKVXbEY7cdAXYP/NYcE7bmJTVXC4hhPXT
         Mhp9AzSumgeG1lIbVD9N1qCSgwhqZW+BIXsS5b3mFJYTGqNiT2f/9/lOKAiNV7xNB4Q2
         rRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723629053; x=1724233853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B5EPTuGtOAwR22klO2g+2qxnDn7zedpJJVEUqzrIeGY=;
        b=JRKbIbK/bKYmYLn0cwTUcztsWLsXHxJm6HQSkncR8Ir1aYL1gKAvEbz2t+B2TNXu0U
         13m30fweBYdrNtzuOCx87pi1yx6RPWHJadDhpcl3LvamXY2AwskbqAZJ+dDQzTLIE+Sp
         AqfyzRV5DOgbte65Vg/MWwuYATyo5AjBg9JnhN675t+/ssKRvu9JIZ6vldJOKPJUx+vP
         1Xv7rQUMdFWHI+ElfOnBkZ6SqY+GU4qp1M6kMI7eX1SMpj18edSbBcAyNzQOKKI23ozL
         1nlL0kMc2G0Rrpr3T+aAHg2JKUrpFFJhV9FE7xZD/Cvl+5Gx2TcsEN8xtaDrj8auonD1
         Ddog==
X-Forwarded-Encrypted: i=1; AJvYcCV3+CcV3US2+9Or8cfK2k942SILg/b5sefI/ykoQPgSMKNCSo0i7OHIeKGSG2Wgq9+DBRe+vWKoQUbh3x+vnjsUWWis
X-Gm-Message-State: AOJu0Yy/cJ20zDj6xBODIZX39ly7mDhzUY3D5DvwIxEszJnsokPEOaIF
	5HZn+W6t6XG8E8IIBTK4dmS2dvzmcc7QxH4xIQw14vXRBegr6A7NN6GvxEAPaQE=
X-Google-Smtp-Source: AGHT+IGdZ9rws4GdM8SkTmW55HmU3KkZji+5J9etE7Vjg5UV/L+knVs1Dc9ulbn1Et86Fu/3Q6RnMA==
X-Received: by 2002:a17:903:234b:b0:201:df0b:2b5d with SMTP id d9443c01a7336-201df0b2f82mr5404845ad.64.1723629052914;
        Wed, 14 Aug 2024 02:50:52 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201e24b6a77sm3487765ad.92.2024.08.14.02.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 02:50:52 -0700 (PDT)
From: Feng zhou <zhoufeng.zf@bytedance.com>
To: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com,
	zhoufeng.zf@bytedance.com
Subject: [PATCH] bpf: cg_skb add get classid helper
Date: Wed, 14 Aug 2024 17:50:38 +0800
Message-Id: <20240814095038.64523-1-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Feng Zhou <zhoufeng.zf@bytedance.com>

At cg_skb hook point, can get classid for v1 or v2, allowing
users to do more functions such as acl.

Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
---
 net/core/filter.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 78a6f746ea0b..d69ba589882f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8111,6 +8111,12 @@ cg_skb_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_get_listener_sock_proto;
 	case BPF_FUNC_skb_ecn_set_ce:
 		return &bpf_skb_ecn_set_ce_proto;
+	case BPF_FUNC_get_cgroup_classid:
+		return &bpf_get_cgroup_classid_proto;
+#endif
+#ifdef CONFIG_CGROUP_NET_CLASSID
+	case BPF_FUNC_skb_cgroup_classid:
+		return &bpf_skb_cgroup_classid_proto;
 #endif
 	default:
 		return sk_filter_func_proto(func_id, prog);
-- 
2.30.2



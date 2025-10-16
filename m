Return-Path: <bpf+bounces-71079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A60BBE1C74
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 08:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DDF91350B30
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 06:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09BA2DECDF;
	Thu, 16 Oct 2025 06:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfFtJJ90"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5C3239562
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 06:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760596798; cv=none; b=bDg9S2I6zQuWilWosHxZAeLQ8Esy3LHF5Fgl7FANudYUkYDg+CkOXQlU8zU4v4I+xvYe0LIY+DyGh/7Jb/fdRfjQAivDb+nsx/c9sOo9/Ci7r5VYkSooY1L8mAEqgl80+WJ4hYCnQEbUBDpDPerModfmjf2L/WtZAt7AhvUOs+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760596798; c=relaxed/simple;
	bh=rwMZrFupH7F1ydkCApAca0Venwb0BA4MB47QpuAh19o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oHkf2CAPVb+frTJ7YqCD3nGk+k1UgPs7EbzPxyy8JdFGYJ1P9MnL3FMJ2jS+Ud6sIRt/Ah7LjzE7ovT9/2Zjodfp6uL64F8ZBAzf0q5H7961uWwxhGbCOGimt2Jy6TYIe0LAIfWfDb3UaBBoYhdDB0FAq1gGR6aT7RhZ4YnPoFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfFtJJ90; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b4fb8d3a2dbso237599a12.3
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 23:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760596796; x=1761201596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTTIy9g1iNjp7kgSKLGx+esxC1+Y8L6sCLUnwXUSZcg=;
        b=TfFtJJ90ATePjW5o8d2u4UdryU+66N3ajIqwLbdlEcaxngYB8aDveIUTgp8ba9qCad
         t+MEQX/3usjDZt2OQtJzWq7h/aLZnLUVk8S5yZ5Rd7aEfC33Eco9zhfJxVepz7SEDcN7
         Higkyw3lL1rRTpX5YK5SHAqgJvg+A/isIf5ieX5SyHJsQngD3yLVgi3JrOCAkpeugjlm
         bV8ay8VCVJpAByTexnSI1WvVSs7s726sRwd0a07Z2MqP+czwCgkmqPhs7WIFut5lcyyZ
         Y7gFpGXfkZD9hEunjeGag+g8xtLeG/84fgCo5M2EcrUEuL9e1nPxK92iHGlDul2Vinf7
         tILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760596796; x=1761201596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QTTIy9g1iNjp7kgSKLGx+esxC1+Y8L6sCLUnwXUSZcg=;
        b=od6ELlQ4WWx3xEzLYL05tGzGRSbPOYLJavMuh/tJBz8NXTpCwuwswR+nkTki9Vdndq
         Ae0y4Pqb7arcKmg46xD6CaN/kuH6OxR7fikTz9dV1DeW5qGt717dOCRMv7hPy2fQqxDK
         4apsHWH1rTosWGGr9+CAmUjN6Ai6YXBDaWBD6qMNVtZ6YXP8DoWvN+ReQkx8H5bAtRZ0
         bz4bVBJyUmjG2k6dOhowu+es+HmFyn0Am2x1Y4ndz4haahYp0Ku08MuzzXJMOpLhvPeu
         lb1GPpu+tvYTJMqqcrDVQp8H5sAw4LEApMnAwp4qWDmpbB6V5XR1K3jYGCXiS1Li+VX2
         Axuw==
X-Gm-Message-State: AOJu0Ywd2Us0NogHVjLh3ikL1cb5KIb8JYsd6KZd9Cd6wfbm6XiaDtKP
	s/YKOpPts+0kKYTxVGOBP1x7Oy547K7/Q7nAfY+nJEaFlbdx8h5/ZlqONZp5nZ3LWEKL0Q==
X-Gm-Gg: ASbGncsGIJpf0d6e7iQzKDTHxqu8/wihtAmRti06vBKGukY2syzesbLTH7VM1VK0LJu
	H5nuz0CtIGRRsApuNV6ZmUFFudqgQX9Gm4vZq6s4kKQR0XwoUUfSDpCqrJVeT+FtONrE9FxyPLb
	9iPR0e6Da6OXXkq2WbZ91Pu69/JMDusjVVsI6lBq/y+opbBzY17TL7jGTzCd6fd/6EMcDPP9syL
	cNzQtX7xurbDHI2ooFLmg7EAKJGu9PGP3mKQE8mxoRrjI69pk4qKVuc76+2zYbAkXEzdWd6APiq
	vuSWGtWdAntgIqz1YkmnSgU9oAjwOqdxSwuHuCM/G0sEPIaazjmhGr6vk98hdMVsIOm3MrNQMvr
	iQMiLUNbHJ6EpWbQiHG5w1gWyYQKXcnGJxqoKcDo6LVokWTjtSTTiWSYVqzwZzmjQN/knJgvQ+m
	a9UhpGsPglGoDGrSM2lMV0Z0bPffgKCl4DliEmFTGF2bplElmmnBQ=
X-Google-Smtp-Source: AGHT+IEhr/L8VPnGshJjxBj/9WCDm+DJHt+7rzQ5CfHD82xuLdTCKq57B2ez0nIcu0jWqSHeyGzjOQ==
X-Received: by 2002:a17:902:dac6:b0:290:ac36:2ecd with SMTP id d9443c01a7336-290ac36323emr16169675ad.14.1760596796060;
        Wed, 15 Oct 2025 23:39:56 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1d64:636e:f4f7:9293:7b0c:3078])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099b0215esm17555295ad.112.2025.10.15.23.39.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Oct 2025 23:39:55 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH bpf-next 1/2] bpf: mark mm->owner as __safe_rcu_or_null
Date: Thu, 16 Oct 2025 14:39:28 +0800
Message-Id: <20251016063929.13830-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20251016063929.13830-1-laoar.shao@gmail.com>
References: <20251016063929.13830-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_MEMCG is enabled, we can access mm->owner under RCU. The
owner can be NULL. With this change, BPF helpers can safely access
mm->owner to retrieve the associated task from the mm. We can then make
policy decision based on the task attribute.

The typical use case is as follows,

  bpf_rcu_read_lock(); // rcu lock must be held for rcu trusted field
  @owner = @mm->owner; // mm_struct::owner is rcu trusted or null
  if (!@owner)
      goto out;

  /* Do something based on the task attribute */

out:
  bpf_rcu_read_unlock();

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 kernel/bpf/verifier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c908015b2d34..d0adf5600c4d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7054,6 +7054,9 @@ BTF_TYPE_SAFE_RCU(struct cgroup_subsys_state) {
 /* RCU trusted: these fields are trusted in RCU CS and can be NULL */
 BTF_TYPE_SAFE_RCU_OR_NULL(struct mm_struct) {
 	struct file __rcu *exe_file;
+#ifdef CONFIG_MEMCG
+	struct task_struct __rcu *owner;
+#endif
 };
 
 /* skb->sk, req->sk are not RCU protected, but we mark them as such
-- 
2.47.3



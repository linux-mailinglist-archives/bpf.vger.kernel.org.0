Return-Path: <bpf+bounces-69389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AEDB959FA
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 13:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 584973AEA7F
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 11:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B0D321F2B;
	Tue, 23 Sep 2025 11:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTFOkwsT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04788321F21
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 11:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626657; cv=none; b=QDzPXCzUS+3oQjHqqYGX/JJ+SDx35mFjUs3G52Qd2GuGqPxEX7Uy1NaHV+1tai/mHL/pgjCVyJXvhItRlMDqKZJxkWVyYScm0Jz4N5O05bKJ92p11HdYxM7iJD+0ekfmH9IsgFuOvbrAvlOR4s+Sq5SbM06J5vkB66s3PQUpzK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626657; c=relaxed/simple;
	bh=gJ40Ba2EOrMdxIor3gRjcgDh98mc0wbM91RgbQ4J0yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A6I6wcutf4iKADNiraK5dJ5R1aQ2x1/hsTu3VroIrgIhxrqPzRlcGtisXc7MrwHqGPlM6lXkDIgx8fudjwfgKp15x5v9MirT3kQPEB00MqhSTb3xOKdkW9yaPoxXLSh9Bt9gpGDpt3jFfThf/Kiig1no0Bc+InbDIoioE1qnUIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTFOkwsT; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-62fbc90e6f6so7153799a12.3
        for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 04:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758626654; x=1759231454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0/R+U4aYwbZkJAXQawUVzfekRnCartWXVKjfml/QuY=;
        b=QTFOkwsTnTC937a8cQPa+YUS29ANZr7z30xUHyclszO/ikGLZvHGCYaXX/p/KJeBRS
         cqgDpgwHALptsl8dzb9AwhXvD2iGd7r6XvH9wQ4qLPCsiXSDxevtnL+owrkUjpSMzg5l
         l6PK9lyx36QeN7cwLfHlee2a2kDcby16rU44CZkj3735Zc1XRCkeJcYDmD2LVytxFGAT
         qFgQFk9s/3gzbt9v5ZhDwzNiEPCXTn0XpZSmIqxjIyDv6bp10NO3lZLFZPcBI7k+ftqL
         pObBins80t512aNyV55rGVOliYqlmTGhMy8Nvm+ybmrxiut5tAqoNnEzLBpND/JuOf6i
         pcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758626654; x=1759231454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0/R+U4aYwbZkJAXQawUVzfekRnCartWXVKjfml/QuY=;
        b=mtFxGrtl+63e4S2kPsJy9tk5iGvVtkFOsVDaMQU58kOuo9ZW1/vEQ5iQ87gpNKuFNe
         GOLBu543BYDEDDxFrmPiCDjDurVuY5s2/SVJSV5eEAV/XRhA7KKMOSKbHo2CT8vrDTks
         mSTz2Pso0jDmg74Dc1gWSbYj4WI+USxkln11ijlL88lYARwO3ZFF6Sa0ZXqaWChMxnPK
         wYv9ru3/s0pT6F3YSC03MrDF9WolgGCZ2ifUpQhvgdl7gdLOehWcnyZmeXw4nOaGJZfu
         XGAe4bZMCeKOxKzk1cBd5tsC7ezx7j8G2CLEfH7uFKXJEJoAvDJsRlQHBNyTwsEAC7Lu
         dd+A==
X-Gm-Message-State: AOJu0YzSqLcQKGhXfebjtJI+zYl7BV1hnJxEhKHqO8x7bg58KTZiuVSO
	oWrhg633Le+cDgeAnxsaay3yv6zjycZj/eYPNUcKNAHoQEx3oT/nXXZKV+AnaQ==
X-Gm-Gg: ASbGncuU8wGXQmFFnGkQiXWiM7D+N3cSx++eJVeOCiFNrOw55Gxw32RcfCDeJ2Aduwx
	nIsNSWZqVll0Ef3ymx/G0uwXWaRDj4q1kyvWvfTZWUxdPBYPyFxXtTgsIdvZXKuEtPCdnpiUW/N
	UpHby8a4z6TgO0JLJgNzmQ7TiRwuHR4N/PHXPXKG3fzNc6LpH/bdDww42onJDgKVvyFNKkfoOPm
	ae1OoVC+b/UCh0+hF9oTK6VZ3u+U9CcHTWZwWwzzWClTol5acSv+QVOJroMy7Jw+zZyhFpX/y+C
	Mmuf9GAsG3L+jc6Emb5LhgeXarjSlK08CQvhmbP3W7oVNnwRYXyiOGpE1c9TTQEj5sLL0GBQhpU
	8XTsXsAh9YjRhuTj75xOH
X-Google-Smtp-Source: AGHT+IFEwFuQdWNyRCsBw+qov+eP/tz/u6+5P71Fvc0YsKvWB9x6hfmAQihoInaX/pkLtgxe/TXzEg==
X-Received: by 2002:a05:6402:5111:b0:634:505c:fc96 with SMTP id 4fb4d7f45d1cf-63467796b9amr1940347a12.5.1758626654122;
        Tue, 23 Sep 2025 04:24:14 -0700 (PDT)
Received: from localhost ([2a02:8109:a307:d900:29a2:6d8:baf5:4284])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63437329a16sm3164734a12.21.2025.09.23.04.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 04:24:12 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v8 3/9] bpf: htab: extract helper for freeing special structs
Date: Tue, 23 Sep 2025 12:23:58 +0100
Message-ID: <20250923112404.668720-4-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923112404.668720-1-mykyta.yatsenko5@gmail.com>
References: <20250923112404.668720-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Extract the cleanup of known embedded structs into the dedicated helper.
Remove duplication and introduce a single source of truth for freeing
special embedded structs in hashtab.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/hashtab.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 71f9931ac64c..2319f8f8fa3e 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -215,6 +215,16 @@ static bool htab_has_extra_elems(struct bpf_htab *htab)
 	return !htab_is_percpu(htab) && !htab_is_lru(htab) && !is_fd_htab(htab);
 }
 
+static void htab_free_internal_structs(struct bpf_htab *htab, struct htab_elem *elem)
+{
+	if (btf_record_has_field(htab->map.record, BPF_TIMER))
+		bpf_obj_free_timer(htab->map.record,
+				   htab_elem_value(elem, htab->map.key_size));
+	if (btf_record_has_field(htab->map.record, BPF_WORKQUEUE))
+		bpf_obj_free_workqueue(htab->map.record,
+				       htab_elem_value(elem, htab->map.key_size));
+}
+
 static void htab_free_prealloced_timers_and_wq(struct bpf_htab *htab)
 {
 	u32 num_entries = htab->map.max_entries;
@@ -227,12 +237,7 @@ static void htab_free_prealloced_timers_and_wq(struct bpf_htab *htab)
 		struct htab_elem *elem;
 
 		elem = get_htab_elem(htab, i);
-		if (btf_record_has_field(htab->map.record, BPF_TIMER))
-			bpf_obj_free_timer(htab->map.record,
-					   htab_elem_value(elem, htab->map.key_size));
-		if (btf_record_has_field(htab->map.record, BPF_WORKQUEUE))
-			bpf_obj_free_workqueue(htab->map.record,
-					       htab_elem_value(elem, htab->map.key_size));
+		htab_free_internal_structs(htab, elem);
 		cond_resched();
 	}
 }
@@ -1502,12 +1507,7 @@ static void htab_free_malloced_timers_and_wq(struct bpf_htab *htab)
 
 		hlist_nulls_for_each_entry(l, n, head, hash_node) {
 			/* We only free timer on uref dropping to zero */
-			if (btf_record_has_field(htab->map.record, BPF_TIMER))
-				bpf_obj_free_timer(htab->map.record,
-						   htab_elem_value(l, htab->map.key_size));
-			if (btf_record_has_field(htab->map.record, BPF_WORKQUEUE))
-				bpf_obj_free_workqueue(htab->map.record,
-						       htab_elem_value(l, htab->map.key_size));
+			htab_free_internal_structs(htab, l);
 		}
 		cond_resched_rcu();
 	}
-- 
2.51.0



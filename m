Return-Path: <bpf+bounces-68786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4ED8B84CC1
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 15:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E53C87B686E
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 13:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E0930C372;
	Thu, 18 Sep 2025 13:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0ngcIo/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62432F3629
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 13:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758201998; cv=none; b=g5DXewnPLjUXE/QpK4brJHVZtXipffG8aY9gTQRoclQKg4uy8hvUEknpqBYA+FWI5Px375AoEtpQ726c5bczqN6Alytst7u+4kBP40IBpXwhhrxR+YV3QhhttwEMH4O5WqY3djyqsFvygIwTpbBz2eCYOdAHctqhEMdIMz0XwsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758201998; c=relaxed/simple;
	bh=gJ40Ba2EOrMdxIor3gRjcgDh98mc0wbM91RgbQ4J0yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b2fbYWb6E1j/ymBLlSQAPdfMDiPL4xvyvon5MdBxj8xvXlzXVHVSkLpamEETZ3NfYoXaCyIMkCL0T/6FjTysnEspPovTPx54PsvxmQ8tBG4PwyWDIgZbcT2gryf/3twEdiIdgNjik1a563kjpGwsIxpdDaayVKBfY4FsTcWPeik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0ngcIo/; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3dae49b1293so499843f8f.1
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 06:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758201995; x=1758806795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0/R+U4aYwbZkJAXQawUVzfekRnCartWXVKjfml/QuY=;
        b=Z0ngcIo/1DqROIi2mrJK3oc8BSN1WIzesiAiQbELei9GNUJJ4NrdAZeJERbya4PByU
         GpapunbFS3N2mj4nH2KRc7omnyxDk3ip33824YQ3jWoPlf3esJK1CS01JdYHqNqdVCPd
         hiQr+iD8uaWPWBlLANybIP6a44KUuxa87+gOTUQHQfQ7GXC5Y3xIEOMY7hEFgxMSWwQK
         gBmlaNV90DO5TqI31CzUtfCvghakidcs1EWFKd0bj6ZPltl3pXcUq7+T2RV5nl72Y1qu
         867+LWRO0toOXqx5i70Pk/0difV8IBUt1nCdj1JUImAJxeIQxJbrr+6rhjCzEKXlz1gq
         CAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758201995; x=1758806795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0/R+U4aYwbZkJAXQawUVzfekRnCartWXVKjfml/QuY=;
        b=B+qjG6ir7sXKxl2O+jHolP1z8dMZ0P8BIpT+b5PXwfpKm0T2x/gU6aeTkC3pIl3y1f
         4jQqJ+/O0myC5jTE7+VHYweAtfRD4XJW2mXUzaRwDxnE7fsQvJncMtPSUs2eIouhau4d
         mWqcvLCPlI7/WWiqZFg8ZTMD30j8J6ZSBisW/iK29A8oe5Lmwqcef4mF0AWTyGGsK3to
         qvzyNjBnYvutIsdo2Os2FVx6YwoDoluenDjGmI0SH35wTl3Lprlc0QpRTtMYnyZ9iRMe
         nCr1QSMPbSu+5OMXKwGiwjfSLzhDYZe/E4Y4Huyj3WRvZOaG2l+FtYydHLctbRM46IJS
         wTWQ==
X-Gm-Message-State: AOJu0YxnYPIrrJ85QNe5w1C1SSGsgzhz2eOT649qS9D4AgQ4NyWR5Uek
	eAZJEb/g1n5+tN/pOjfLNn5YHgMXEsg7xbS8eo9aEqVCHhm8UZxm8QzPOsAzMUN1
X-Gm-Gg: ASbGnctNuzdqjB898/ejgmJNhTuKaRfkwkG3Q1tQmSu0GeFRM6oKV5jjl5lrRAjSCEE
	7PnXJCfAUc0pjWJ9DZvMZJD5hkZSpA969zoN/Y4B67MgBzWvLY9ZvLRtfFD1iK1DGx+x7/0elDc
	qROskPCw9tITpmDA2IjNHqNcm4tJgeHWNFaLnmF4s6OysMJ1qeXL6gsJY1p7vdMOpLJm7FbcxY2
	c75rjf5ZamRlL69HCe7XQTqVx3jr70Lc2am3MizqYV+WDv8xzzN+AtFf3Ah0E7Tf08BNDDr8hPX
	aIHcEbnmJkXAan4qetCqlWJ0/2dBYtWEXB590RDWwZUjw81Th/fJCzjNTU83rtIGGmkmujQqZlv
	PZGlv+NA2VK7u7JG+Q4mr
X-Google-Smtp-Source: AGHT+IHpACeHIVM2B+FMTCi9fhvT4L833LnJxZLJhCr2SZU9rU+PzbFsWXO+4mUACFMPp5JaLEXOUg==
X-Received: by 2002:a05:6000:22c5:b0:3e7:6197:9947 with SMTP id ffacd0b85a97d-3ecdfa3fb2fmr5125893f8f.53.1758201995131;
        Thu, 18 Sep 2025 06:26:35 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:ce66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbfe9b3sm3564760f8f.61.2025.09.18.06.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 06:26:34 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 3/8] bpf: htab: extract helper for freeing special structs
Date: Thu, 18 Sep 2025 14:26:10 +0100
Message-ID: <20250918132615.193388-4-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918132615.193388-1-mykyta.yatsenko5@gmail.com>
References: <20250918132615.193388-1-mykyta.yatsenko5@gmail.com>
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



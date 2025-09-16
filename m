Return-Path: <bpf+bounces-68577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3700BB7DC97
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 570A51BC4B70
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 23:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74B62F28FD;
	Tue, 16 Sep 2025 23:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="betAkQv2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B112F28E6
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 23:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758065830; cv=none; b=ZSxUJ/ihf8IivvgQGjOmtvXnYiipX8cxsTGwmRMvOs8rxrFg7cBAWhSo/QiYsetsAU6UQcxoy3tR4zkFkl06ryHh6KSLdPdfq0lYMic0M7g/gg+fHsW3C4CISqXI9cvY072ZViWH9JPY4PlNnXSh723fpNU5J3tN8WOAYVWUMyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758065830; c=relaxed/simple;
	bh=gJ40Ba2EOrMdxIor3gRjcgDh98mc0wbM91RgbQ4J0yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8l79H+oW5mrqTR0y6XnbIdRgWmP2MB+GuZ6G5QGen+cfsOvNyd6uq9/ByhMfSK5slgftJVbczFMfxgEdMpyGNVWEWqPFbCbiSywJO/dQGN1j8jFRUmXB8gEufSQnCb0Pyv6b0kCOgKcxmuIdjMii46JpOXT/7xFzXWyRF9p97g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=betAkQv2; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45dcfecdc0fso60370905e9.1
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 16:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758065827; x=1758670627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0/R+U4aYwbZkJAXQawUVzfekRnCartWXVKjfml/QuY=;
        b=betAkQv2joSEF3MhCEksDvZppbP3KTqY6tesLsYt4UfkgUNvmgO8/ACLLOBTgDOKia
         AHx1/5ITgzSayYGYePj+hfwHUl/49mF2U/slNAD8PMA2HJBlC0XtlbI0UO3HF9EdJHgT
         /3Sx7oZ9SHU77/Oa8gEi8RfEaGUYUqHmlcE1SDIVuLdUUDQVpmaV1nvkhJcIV/Lt8AfC
         Rq9PhcupqNhfKShJ8QLAPv5J+PZ3Uuf6AV9lRMo75/pkq3Zk4ktbkR420flq+grb6bZ5
         vIwX9PzbLq+kvA0Prr4k196vvM15TRSvWHUN97WXnwegarByVpH6H0jvrkbFLC8pWP75
         CO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758065827; x=1758670627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0/R+U4aYwbZkJAXQawUVzfekRnCartWXVKjfml/QuY=;
        b=i3Epe8fQfbTm5yLnkJMmwABJdcY5dJu1I5t9yRNBGyw9v2U5GJufPZcbw94bn2djVt
         OMvhPwf6f8v2VRpdsq+v7Rg75MWceLf2V1aKMT1FZgChWSa0mUFdNQjX7xWnKrkCFMBG
         ULsQXjTzbPFm57mNG62wU7HBQAF6A4lcyj50Nwv1Uq+dJszuhM9fHfBnJVPqRZ1bSbPG
         z7BxrbHmyWrifHPVs8scXSYb8ONoSXvm4aLlMCoYeNRTSmTlvHjCDVFG6dLVVbcjof2d
         RlHmPi+iCEYD0y4lFPgQ00kqPcknPrGFkah2MDuCQfYPYp9rGQigO4u3WMhVFYJvjY/6
         +E8Q==
X-Gm-Message-State: AOJu0YynJv4Amjv2PZq7zTHmBs0bAEjOWX310jvIFg0tuyJtmHu2sjGu
	FowYLl3vjsSJ5ehB3dp1UYegSnzvV4uAO0Qok5fx0lAw754bCM6Z++K7PS1I4g==
X-Gm-Gg: ASbGncvgrwY7BSyaZzY8T97ulxE2fcJ+FENAhT7THXxU6bC9s2XD2KJn8fIaUJS5LY2
	nJKKBusY5dh0uWu5bIuBMi26XHT057UCxvU4yR2ZfufCSz1iw0IN27xDRLcOJElQVfTHPLYgurC
	nO0kfHM+P9dcG6Dr+rPG17OuE7/qBJXs5XY/No2TfdqIqdPDuewefVee+ohVr1mjsL0rrM/M6pB
	cUHDKHFLJCycjHdH7QVvK7Y88BtyrIT8WhUS4wH+Ju9BxKSO7TIo8da8Ev1FX1q+g7MkCyColZf
	XT2lXqhUB7T9fLF5wYOFd2Khkl65aicNK290Xnhgv2iOomTXhbSCoTiKyGshCZyF0dsH6ZdlTll
	ojm3R+SnbMg9Px9GPeiTVhQ==
X-Google-Smtp-Source: AGHT+IHnjdQb2CUXAYgiFajoSFfEveLJDb82cPpOdeKxwpW4f7CkajKFDDO7v6uXiLk5MVFJAb/oOQ==
X-Received: by 2002:a05:600c:630e:b0:45f:2cd5:507c with SMTP id 5b1f17b1804b1-462074c6857mr507635e9.36.1758065826839;
        Tue, 16 Sep 2025 16:37:06 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f32086d09sm31033055e9.0.2025.09.16.16.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:37:06 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 3/8] bpf: htab: extract helper for freeing special structs
Date: Wed, 17 Sep 2025 00:36:46 +0100
Message-ID: <20250916233651.258458-4-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916233651.258458-1-mykyta.yatsenko5@gmail.com>
References: <20250916233651.258458-1-mykyta.yatsenko5@gmail.com>
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



Return-Path: <bpf+bounces-68429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94933B585EE
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 22:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D91D1AA7F7F
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 20:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A76296BB6;
	Mon, 15 Sep 2025 20:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAAdBk/a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F364E27B356
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 20:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757967511; cv=none; b=NorMBrB4viwdKRxzEEv4krn/gbJgCfHyq2rp3uPnAJKOk/j0TbwgpiCJD0OTkPnUxWZxPqfgkiAfH/b0hxg/9J4vQNjbp/KEQbpSk4EVMB5av6Oh+qGZPe55Xy1oEGbnvQF7jMS3d7c/z8derud7lhkQgsZBucugHHYOz26pU7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757967511; c=relaxed/simple;
	bh=gJ40Ba2EOrMdxIor3gRjcgDh98mc0wbM91RgbQ4J0yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VargpyY5S02rYxC3VlX7BfM/3wAzXqLLxjxJuC2TDzZ1hD0pr+PHzxYVYtT1Ax68ww0XgUlRVkMkic1VxUuW5xDHNoq81f7p51JbR+DB+m/tTHmv1JuM45miI+jp8cgku0FQ10bbWYixju4Cwl9vj3IIk/MpVvY6GXn0rjW6RdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAAdBk/a; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45dcff2f313so29287515e9.0
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 13:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757967508; x=1758572308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0/R+U4aYwbZkJAXQawUVzfekRnCartWXVKjfml/QuY=;
        b=cAAdBk/aUPBV6awEnsdvG25yvni7wYGg7eVt6yAtdoIf0ms1bZTK3GezN/xSTGlLN1
         mi4znpzfYnzAJMGWFT41UI9En75Vl3WruuZS0oortoiyijN/4aJwOyyRWuVy0HO/OPiy
         mwteJmWhWEguquDnY9keyBd+B0g9pDMRdgH0yZ/ydNj/ZSSa+ZbfV/b1w3LTEMta2uWQ
         88XSEBDo5xQSUzqEaER2UsJE2ZGbTrxGGFcULmh099SUvNze8Dfupc7KV2vJuri+XJB5
         5ksLPgBYrCulf/YfYcEMoa2PfdbXTuObz92XN+qBZh5PBxp+d3RvUR85A1DpQWj05O8r
         J+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757967508; x=1758572308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0/R+U4aYwbZkJAXQawUVzfekRnCartWXVKjfml/QuY=;
        b=Cw8UYVJxPOXzhWb8bDMwxbVu1ttxh6SlqPYF+ttiMeW7McXpmI3m0aIvfPQzgfSoQj
         vvQnW29ND9QTuV0Iq5mF/Wdod63XbSZZuVvJbPHcgKotkGbx5vTKp1MUTePoaQqSyHkt
         609ppTAG+H1EwjsvU/6ojYgViKFEJ/8EvFJCX6yRrJnR5YG053eApmJsP9ULxeucQH9Y
         TqgUbtnGaU010fkgLOlAl7Q1F+WWofE5gFpKOru0Ds8FqsvSHAPkqC4jXF3cX9JPS6zb
         K1zPWiZwWW1u5FG/Y7UA3Om/paQJKt9Bp6jUYbE6z4m/cdTgVrgAv0S3fOSjqxTubG+l
         fj3A==
X-Gm-Message-State: AOJu0Yy/tvKQuXVZ2ppB3G/yimYDSL/+lw2x4bTYLtOIC1cfTy/g0Pma
	SPXmC5z+4B53JUF7tCkb45tw4Wff1Viwg8afFkzr07PG2XyJ6yNUium0/Xmnhg==
X-Gm-Gg: ASbGncv3rPLC4w/deFoiRpsP/wb8Sg2uM/dfv4gXDOMSPKYO0bxqmtSJi1Ihm0SKa8b
	IapeliuyTe5NSpA8TY0PptSqnahET3YVsjsDvBsFpiJGN2gcVbGcUJClJb3uOlFl7csP1/92FZB
	X7Ohzi0bRuHmf5IMHqo2CCia2iuw3ynBxaDkEqfudWPzHHW6okXlV7EXYlA22nutsm/rXGhom90
	y8YNuYkUcPL1v06qPv8El15/fzPhUA0+6lDMxwVdL6h9i4Lc40uYHoZxadXJe5dh03JB+UrYmz2
	c69BC6Uq2MUiDZOqjlk+cW46tsn1ZS6lOSM0utTpPXESmMfBfa39YboTQ2nqQuc24M1FkQUfU3W
	T2A11rnQOQD3PxQ==
X-Google-Smtp-Source: AGHT+IFx72L4ReH65mc2OIJSwy4+3hvwa3NfRl0dM7vM3OJUXsUNJpf83WD/UR6W1zBQCIP9IwhNTA==
X-Received: by 2002:a05:600c:45d1:b0:45b:47e1:ef6d with SMTP id 5b1f17b1804b1-45f212253f8mr121265245e9.36.1757967507866;
        Mon, 15 Sep 2025 13:18:27 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::6:388e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f32086d09sm3776045e9.0.2025.09.15.13.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 13:18:27 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 3/8] bpf: htab: extract helper for freeing special structs
Date: Mon, 15 Sep 2025 21:18:11 +0100
Message-ID: <20250915201820.248977-4-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915201820.248977-1-mykyta.yatsenko5@gmail.com>
References: <20250915201820.248977-1-mykyta.yatsenko5@gmail.com>
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



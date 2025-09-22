Return-Path: <bpf+bounces-69281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF97FB9392B
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 01:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8A019074AF
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 23:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0650F313260;
	Mon, 22 Sep 2025 23:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyIz+rdo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5042FD7BA
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 23:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758583585; cv=none; b=maXGzIUVnN+2LANnOoSrTsQ7WjKcwuIy+G6u9LPqoRfpWTUdTUXKTYR++Yn0jSsX+pkB5eQlyM0q21PSI//L1wn753/0X85Ohu2xNQZmh3Q8dDFxAemJkdocOZL+GXW0bPeTmyZUDS7aNxWxYbbpapvjK3gbu7sGUC6LIBV7fnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758583585; c=relaxed/simple;
	bh=gJ40Ba2EOrMdxIor3gRjcgDh98mc0wbM91RgbQ4J0yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lb4JfzgeHHTqMf8aEgAQvs+oLIVggKv0PoW9OWAeIbEPV9qUHNheRFA0zrQf9ZTN+NfA6aej74MbVAQKv176CJCzCgDiv2VAVYctzlN2qH/pfSsOiKD+Bsawyv5QIQvviCxmN+AJEzwzzDYFMsNNrPhqPf5ekunwNMKN6l/bzwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyIz+rdo; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62fa0653cd1so5787093a12.0
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 16:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758583582; x=1759188382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0/R+U4aYwbZkJAXQawUVzfekRnCartWXVKjfml/QuY=;
        b=NyIz+rdoJLERhE6yEGYSU5kzHnUKmEeSxeymcBYTrxz6MGeytWgi64YkyWUWK/t6qr
         T/88tq14ppb/VMqET+4SkRrdnynMGgLI7H3K8i2UM9z12utGSQHT7g2/GJOnOvNv4Kvn
         MBcOpi9PCWsFj4YTDDii6UAWBnKSU18ydBiiiRX7tvuHjyUGx4FVgyfvUAQC22b3ekiL
         TFsX+pIxwJbbp0mpcVniw2dQl+n/mdP9/KUjOjdIz49VlQsj3L1P+SrnclsuRWpZxtmh
         g7DWRmdQkDEx4kjD0iMAze1pirW6Yfcv1fobJijKBg7Re0r0z8g0S63E1AtB03baD5+r
         vnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758583582; x=1759188382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0/R+U4aYwbZkJAXQawUVzfekRnCartWXVKjfml/QuY=;
        b=grO5YYZ5E1e/RN4Hd8JKTg+EgCy4ijZ6JkRae/RH/w6ZilgRuSeoFOIlSmSVqqqpRe
         Bowlv7LPNr+c8tod1rITcWF8B6G49AOLPIDS5iU1u1FKguOipzWeY2jnzIrfHtoAfxll
         zae1JDov/vJsgI4PIxss/ndMSSegEIlvfk1+3i1lNxMyB3QNkeePyeN3G2U+m/MRIYoU
         GQ17Q8USHLIkTI/HhNstegnLu4tE+T1KyVMdD+Hap8z32bTpNy0YBaB1DecOacK1MPnI
         k4hpdGc/BZQsKI+ARcFQOPEAtQKQ4ZfJcNDszqQ6Nux5y0LswqiEZJDNvJsnfI0kwC1N
         APqA==
X-Gm-Message-State: AOJu0YwrhMQsPOIoK34aL8YtFmBMqG3i6qC6mzCKpyBOUy3Xhuqd6Acg
	Wh2QSSnNvs8VFb+bjQLnA3a3MU1raCm+ckqUUT+bxAbTIyyX0tt5Hj62Pxm8eA==
X-Gm-Gg: ASbGncsNQDFasm2cAiAxJ/A70mrt/7ywM1qn7Blx+EknwAdgOkdNOi35rPVoichmgHu
	gPHpdin77cDyyrK4q8zgrfxzVsDIixTu9olw8pWM7BWSlPhhrPGjfovdbqmUW35adEOHhq18AUM
	9YdRpTDqMql4ZLIMNKzrU63I37mSu28cKAbGw6hQiy4v0g1+CNaGuKUP4R0cftS3wwZ45m5wb/v
	7XUjZKiZlS+oQRQC/A8dAWBaWEKPrJQMoyIGRKpGuRQqib9FtWLt+kfvJMB/IUj3NT5vllA36Fn
	E3qmTj26v3oBGcrVqeEGec8pBUTH8isbiZ4G4GPOwwRMlMlPj66tluIKruOiJfVOimfHRhZX4Jh
	z+Kk0yRzC1vm6KckyvipI
X-Google-Smtp-Source: AGHT+IEKEdx4XUKu92pW2A3Ufpot2dBOtQmVzBTyAvXpDyfF06SsQyeGNvhS+gR/ZGiOlQJmQpMagg==
X-Received: by 2002:a17:907:9703:b0:b30:880:8d4f with SMTP id a640c23a62f3a-b30263b2f75mr32874866b.2.1758583582072;
        Mon, 22 Sep 2025 16:26:22 -0700 (PDT)
Received: from localhost ([2a02:8109:a307:d900:29a2:6d8:baf5:4284])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2eca89e388sm134953766b.106.2025.09.22.16.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 16:26:21 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 3/9] bpf: htab: extract helper for freeing special structs
Date: Tue, 23 Sep 2025 00:26:04 +0100
Message-ID: <20250922232611.614512-4-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922232611.614512-1-mykyta.yatsenko5@gmail.com>
References: <20250922232611.614512-1-mykyta.yatsenko5@gmail.com>
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



Return-Path: <bpf+bounces-50383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA65BA26D4A
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 09:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B6661888ECD
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 08:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AD5207658;
	Tue,  4 Feb 2025 08:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/8vuvAl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20125206F15;
	Tue,  4 Feb 2025 08:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738657780; cv=none; b=BWZJMWZd1y35nu9Ubwpd6kYDlBhzODKMlgcINxOQcHatVi0F+OFXASKioSpYuE70AO4gDAzlVLo+wVTq0dGGGV/XQRt4tjnrIuER8T4DK4vhZW01EHRrsPnb+cDFKv2wI8KayFKf2pOP+AuGxjK/xNwUnIs89aTQ/F1CcNz7UxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738657780; c=relaxed/simple;
	bh=jXxRWf1PvMNCt9hiDjml0Obuom1TPrr9kqKoAouMtjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tbfbdTi+qrf18NyhmKdNi4ozm2W1kj9vTUgn4fsO5pFRuAmomglJw9HZ2Rs15AWRzUd6KF3nHBPlA/1MZz+ZQXZJaV3E8+VvlJgvW5FWk8wV2KIXRD4iq2ZH28GFZoFmd4oSt+dbJYInyXM1dqCca2yks91iQv7jp0EWsBF2mLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/8vuvAl; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2163dc5155fso93179475ad.0;
        Tue, 04 Feb 2025 00:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738657778; x=1739262578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Al2UwxdPrWH7ftc+zw3s2BSjj6h4sMz+uJ0myT5iwZ0=;
        b=C/8vuvAlZjGzH+pQQ7q4k9e+1JRUA0rU5D5x24nuCLYDn1UBXih/ywwL1bR6lmbCIk
         s8PBopV6Gp7O7S+C3jTooJ4SAFM8gnqdJnYIb/lnKSymMGn1NCc3pTWIbZ90+D8cesEK
         B4bChnj4AN3M0VnHJ5fzpEIsvmF4X9FI6Pmv+vm1uTP0G1WMopxGJNywM1+48yjUaYyr
         qySpb3bBOwPHM4Q1q/oEZvEBmXc90EroAuC2tweZqZw9DETrbZ51olOCFcbyGr+ClIKu
         sjcKYfMZnq6iNp8xhM/J8exIwtTbDEMaEZCw+WnFgdp33LFRjK1VlVilA4EZ8X2iIPmW
         sEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738657778; x=1739262578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Al2UwxdPrWH7ftc+zw3s2BSjj6h4sMz+uJ0myT5iwZ0=;
        b=O0KHWqc6wKGF282U+zDTo1s/GMW1aAOYwXPaSfZT8bCFRgop9BHU/vk6YWklExZC1p
         akwT36LCupyAALiWz94QyDkDc+xO9G92xPtxpQB1nJ9yWT9JE0ua2kEvdAoVOLsgcNhM
         XRKsTghmQLtfdCanaGTRbWLP1+H7KxFH2XXzJ1vX/WvrLcwAyr4zDPwJZTRMAVh1Qo4E
         ME1YthAcz6tAVlGgOKUcErAfmNnb0ffoOdn60SN4wsK6XcEfxASP5yJxVatjc8a4+d8E
         N2uBxywGgUv8VyOlteEoBgfurblA7boBxLlROMc9PLUeM9KXnF4jtlqj678OA7moqtip
         HCfA==
X-Forwarded-Encrypted: i=1; AJvYcCUlMuTMpT7XSuOJI/6J+cMgrPX32qbuV0BBUOw0Rs3WJyJ0cQEqYQsMBvViQzS/rZ2Ehqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQpJtTPG2ySufiLaxQtDXH5/VFFHTm8DUnCbUd4swJAEJ8Ztqx
	3409h1R+XPjHFh+VpbcacrJG8hufTTllTs1ueC+jEOALHf1fZZCOOgWg0sY0HjPSOw==
X-Gm-Gg: ASbGncsfWzkM0aj0P8YQ7GZdyBZSJ2YH1hTnPZ5+ozPWqmUjeh/cyY4uLYgfCeibaH2
	JJU9NAgasumwZsbBD0uV/I8z/90Alvd3NSxVOONey1Ga82I9kkVuQR7NvlrVDd0ApnQyyhJiJfN
	a4urVlQ+IcAqVO8IIp+nYxtlMuj0Kbgc/DgRF/qrDvqSS25bI3s/OMA4ULmZxaNxJPVsr1yq+eZ
	60ucrK7j1wYEcdfMYFJQw8Dw1JuEnW4wYenVxojOCAwXNKw/B+7CgabsAqUSbMVnLhXj9Zt7ZkM
	F65DhjaX2bk3
X-Google-Smtp-Source: AGHT+IG9qpgFmb2lq3UNf7NazYCkUucb+7qrWn+jhvOdGlArOEToLfvGl3I8pTQ7gUmZymF33lhJBw==
X-Received: by 2002:a17:902:d549:b0:215:8847:435c with SMTP id d9443c01a7336-21dd7c55d18mr408480055ad.12.1738657776369;
        Tue, 04 Feb 2025 00:29:36 -0800 (PST)
Received: from fedora.. ([183.156.115.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de32ea80csm90826685ad.140.2025.02.04.00.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 00:29:35 -0800 (PST)
From: Hou Tao <hotforest@gmail.com>
To: bpf@vger.kernel.org,
	rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	houtao1@huawei.com,
	hotforest@gmail.com
Subject: [PATCH bpf-next 2/3] bpf: Overwrite the element in hash map atomically
Date: Tue,  4 Feb 2025 16:28:47 +0800
Message-ID: <20250204082848.13471-3-hotforest@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204082848.13471-1-hotforest@gmail.com>
References: <20250204082848.13471-1-hotforest@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the update of existing element in hash map involves two
steps:
1) insert the new element at the head of the hash list
2) remove the old element

It is possible that the concurrent lookup operation may fail to find
either the old element or the new element if the lookup operation starts
before the addition and continues after the removal.

Therefore, replacing the two-step update with an atomic update. After
the change, the update will be atomic in the perspective of the lookup
operation: it will either find the old element or the new element.

Signed-off-by: Hou Tao <hotforest@gmail.com>
---
 kernel/bpf/hashtab.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 4a9eeb7aef85..a28b11ce74c6 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1179,12 +1179,14 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 		goto err;
 	}
 
-	/* add new element to the head of the list, so that
-	 * concurrent search will find it before old elem
-	 */
-	hlist_nulls_add_head_rcu(&l_new->hash_node, head);
-	if (l_old) {
-		hlist_nulls_del_rcu(&l_old->hash_node);
+	if (!l_old) {
+		hlist_nulls_add_head_rcu(&l_new->hash_node, head);
+	} else {
+		/* Replace the old element atomically, so that
+		 * concurrent search will find either the new element or
+		 * the old element.
+		 */
+		hlist_nulls_replace_rcu(&l_new->hash_node, &l_old->hash_node);
 
 		/* l_old has already been stashed in htab->extra_elems, free
 		 * its special fields before it is available for reuse. Also
-- 
2.48.1



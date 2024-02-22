Return-Path: <bpf+bounces-22532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 853988605A8
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 23:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24B321F2159E
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 22:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7E9137913;
	Thu, 22 Feb 2024 22:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/5rSjnP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695EA137902
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 22:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708640792; cv=none; b=WXjeMRdnj1QQvKWVQQkQoIEYJu0Vq/kkmVJLqCb7pN295/js5ZWi+zaeUHIn39KDmNkPM2a0TaPZuQlqFCxgB8emWb/xS216207zAs0AGxPu+zVBbTVuTqn5pHZCN2jDP8aRHuIS/gyJa49eZNrs4wZGXxe5IIyufAGKIODbkm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708640792; c=relaxed/simple;
	bh=9pgDJRa9T/5a4i1vhMmQqOlMwwmbYYmxCovw23ewryU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d+dol9KRv/yA9cqiDZMQSySHIkApz3ZwFOsIe3eul7CZ5+Z58E8DOfvIYedR2FeuXuWRP9lFVSdCBqJ6LKgpgmVloX0e0CVXlmA31zlz0vxJR6zEvps4SZ9oc4nGP62Ry5PDVPlTXp/KAt8U+X/vn7iEhukOyka86D7yPWWSLsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/5rSjnP; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcc71031680so209774276.2
        for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 14:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708640790; x=1709245590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBHML36fUv9H+qGSqsoz0y17RtRNnl1DXEIzsGFdTTM=;
        b=a/5rSjnPKAgfydS/BzbQReo6WyWVnawuMZvxJUy6m2LgcGlEqrqhdNU8f+CKuCE1de
         bm4l7Z3FdtZiGnUxVBb4/F7JZ+HYAJEtQuI2bQ6TrZ95MjtnMrlFubAi5ytx2MQwWtJw
         qtNqYubC/v2+ZaDog8yMsaU8FZVfp+16g0BdngPe+auH91lmuqiRd+RjEta3aK2ctg7h
         MwCeBvoB9GZvkM5xvG7y47bDZMep9FXxObtRSeXyxS1OcL3PlHLIBVKUH2R6bFSzrgQh
         MTEVio8RIBC8BhgR1LSGrc4vZEoHZ57HZFNRXLhuCHECtWYwr7aaWQHZlxrgMmmb210/
         3Uvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708640790; x=1709245590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pBHML36fUv9H+qGSqsoz0y17RtRNnl1DXEIzsGFdTTM=;
        b=glOP1dqnjwrns4ZfJ8TbTiIVdPOyv+utOZcekwPVBlZqBNnkMkC/TiZg8eAFjusTQw
         9PILyvSy6zYV7R6K1KSsJ7Z5S3ELsyzmifGXvN0V63W+r/sfke3Ev0IriG5clr+y2fqm
         wUXnVvxoL9Co6Zryo36bOEQco2rSSxCDwNE9SttZ6iG0dZtafsSxRRqzwr3B8g2PS/Jd
         yPBykKZTzezVqRREQeji3vB+rQBIxmP24c7LDNezFcyct5HbDJlAyWDC2Gqa2trDW0sc
         HL4M19UWJWzJPM77mSKsTpJmCOcaSmdQyg488CYhxgpFQo/uTPyMBhZxdMYamLasE0di
         XQTQ==
X-Gm-Message-State: AOJu0YzLXlKMM1CSEcRn9dk2VJtaPI4E9BFHBvy/hyw5FqaAwJA8yKrZ
	A8s7ImhKWYa/MOSyo3xJR3exuvBR3mKjcb/0O/7GhM55DJQ2Hz76o1A9bF6s
X-Google-Smtp-Source: AGHT+IHHIdzDN+CVUPDndcYpcPFOgxyfPjZt46lXR1xqN5AejIM0gMTGiWe3fuJfYxirXBmg/j62uQ==
X-Received: by 2002:a05:690c:6:b0:608:922:4001 with SMTP id bc6-20020a05690c000600b0060809224001mr568920ywb.5.1708640789895;
        Thu, 22 Feb 2024 14:26:29 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:34d2:7236:710a:117c])
        by smtp.gmail.com with ESMTPSA id e129-20020a0df587000000b00604a2e45cf2sm3280666ywf.140.2024.02.22.14.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 14:26:29 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	quentin@isovalent.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v4 2/6] libbpf: set btf_value_type_id of struct bpf_map for struct_ops.
Date: Thu, 22 Feb 2024 14:26:20 -0800
Message-Id: <20240222222624.1163754-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222222624.1163754-1-thinker.li@gmail.com>
References: <20240222222624.1163754-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

For a struct_ops map, btf_value_type_id is the type ID of it's struct
type. This value is required by bpftool to generate skeleton including
pointers of shadow types. The code generator gets the type ID from
bpf_map__btf_vaule_type_id() in order to get the type information of the
struct type of a map.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/lib/bpf/libbpf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ef8fd20f33ca..465b50235a01 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1229,6 +1229,7 @@ static int init_struct_ops_maps(struct bpf_object *obj, const char *sec_name,
 		map->name = strdup(var_name);
 		if (!map->name)
 			return -ENOMEM;
+		map->btf_value_type_id = type_id;
 
 		map->def.type = BPF_MAP_TYPE_STRUCT_OPS;
 		map->def.key_size = sizeof(int);
@@ -4818,7 +4819,9 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 	if (obj->btf && btf__fd(obj->btf) >= 0) {
 		create_attr.btf_fd = btf__fd(obj->btf);
 		create_attr.btf_key_type_id = map->btf_key_type_id;
-		create_attr.btf_value_type_id = map->btf_value_type_id;
+		create_attr.btf_value_type_id =
+			def->type != BPF_MAP_TYPE_STRUCT_OPS ?
+			map->btf_value_type_id : 0;
 	}
 
 	if (bpf_map_type__is_map_in_map(def->type)) {
-- 
2.34.1



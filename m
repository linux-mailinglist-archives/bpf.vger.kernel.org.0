Return-Path: <bpf+bounces-22751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1C4868580
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 02:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56B1A287194
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 01:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728344C6D;
	Tue, 27 Feb 2024 01:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esBo7zzH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847EB46BA
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 01:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708995883; cv=none; b=hyoHylR5ouE3soGoFEsVQZN+Vdz9UiICTgWxlozv7liOYUUPbJPvwuAS6m5FXcft0Drctx3NNdv7/mO9j3Dc9yankvKrxH6JV8FYdZzUrm4tOyA3BqjCO4RxivBPxRydyH6akIvr3SSwNuU2ncXs2a3xqUFeG+qcrH1JcWELIkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708995883; c=relaxed/simple;
	bh=CeAyJrK+gvmBgfV2+YuZ++lyP03MR25D8rBYHwFOxcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Iy2iYszgrZ2Jg4KFz1K+4Lx870hGVDEYSvCIfeIntZT3yBfII63LTm9cCutlV4b/o/he3Y3E07/ggS0h5pPS7PHtdA9/ECpMcH7pa1NtzR5/WM3dt85Sd1YeicbeRr/+gfOZafP+blV5EkeG+edkyPVLeOFHQfYsSTwHmiiNNKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esBo7zzH; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-608cf2e08f9so31116767b3.0
        for <bpf@vger.kernel.org>; Mon, 26 Feb 2024 17:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708995880; x=1709600680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mE/3uqBHMWR8C9gy7FsW/eYUhdQf9C2bfAKUbxEVGxw=;
        b=esBo7zzHllRtVjMOw2GvS9s6b1UxD7ExCFnKjfOFQUjrzmo7ouxL5THeNaz5eOC0nd
         ufoDtpTtu9G5c3856sfIZh6cjDEglNdf0KOnjr00XQSvEGkefkBObgWZWwLu1SE3Npyp
         Pip1fOm0tlHbdTUFUoWjYHxBiTsuldFW9A6xIpl2+UTYL67+oAkZW8GIWHNMHGbyEtB3
         Hg9hUjahkuU2v4+CLUWq+Uj8SMIBJyzvrZTLyiAVZ6mW2VKDr/3Nf5xsuCtx4q8MD8gA
         yAa0rOycFDsJbZaDIGdPaAbyu0tkgRHAVrWNwI61i3ipgx1p3f6WpzmwQpHgknMEukYW
         pM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708995880; x=1709600680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mE/3uqBHMWR8C9gy7FsW/eYUhdQf9C2bfAKUbxEVGxw=;
        b=MbXIAwDJIRIeQ9gDN0+dF3zzAC+CKdgWlUgRUlBpPKdvViPep091/CpxpjqESl+MM4
         rPbWsMn+G0PZ/x1TU4Yu44v4KkKHOQsT/ldYpLx2z4mzjdy4CVmfs3OU4Na74rIESv4f
         2kOdm47RjLcX1DhzJzkqVgBZdCZDG3cKiYqqnV+ZI/AjriHsXOpi5Vb/BaPZqiB+bRwp
         Uq8cLoWt8vHO9XNZrxMIqbon24weIOq3TBlMlBA11tAoclKfYumhD63EQDOWSGPD1Z7b
         C982mqH+B0JEJPbgnS+26EMl2QOsB6uvtxkQ+mmnDXuaT3nqmkVVoHps4As4u9mhQDwq
         exCA==
X-Gm-Message-State: AOJu0Yxhmaxvl1wnhAkR8rTJYBEUHmWVrh2Khd9R4Gw2eNCjq/1D3kB3
	elHJdbt6HcFMxAwsR0JQ/dxWyHBnlDnoyoRnFXvUMb0L+UgYuamSnh28uD1I
X-Google-Smtp-Source: AGHT+IHVKtVFVvBl+AxNQcoc4I+j5rzuOu4UvCAsB0LMxVwXLaKX1/O9cMw/Dhf6Mux0ETIJCfnmNA==
X-Received: by 2002:a81:9842:0:b0:609:60b:5e46 with SMTP id p63-20020a819842000000b00609060b5e46mr690822ywg.9.1708995880393;
        Mon, 26 Feb 2024 17:04:40 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:5f7:55e:ea3a:9865])
        by smtp.gmail.com with ESMTPSA id l141-20020a0de293000000b00607f8df2097sm1458818ywe.104.2024.02.26.17.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 17:04:40 -0800 (PST)
From: Kui-Feng Lee <thinker.li@gmail.com>
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
Subject: [PATCH bpf-next v5 2/6] libbpf: set btf_value_type_id of struct bpf_map for struct_ops.
Date: Mon, 26 Feb 2024 17:04:28 -0800
Message-Id: <20240227010432.714127-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227010432.714127-1-thinker.li@gmail.com>
References: <20240227010432.714127-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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



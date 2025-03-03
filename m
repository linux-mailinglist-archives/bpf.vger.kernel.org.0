Return-Path: <bpf+bounces-53062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 430ADA4C298
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 14:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF2A37A78EF
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 13:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AA421322F;
	Mon,  3 Mar 2025 13:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdXsiN8R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41033211A28
	for <bpf@vger.kernel.org>; Mon,  3 Mar 2025 13:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741010282; cv=none; b=nG7uUQKO04vIjhm4RDgCPC5rSD2xaM+zSi3wMsgQeMURrvepux7SaNZPoWwe1dqjUxriY6mJaYJ5lEf5JVwZW2qGNM8dERzG4wb5fIt0NQZNiJioWNFfvGdSdoI8zKA4sDvuUifJcEK3/h2q1epqDegg9PWVPxpA6UqQY64/8nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741010282; c=relaxed/simple;
	bh=4byWutfDyvfpiMe/FlGqyXF0m/AYX6H4k1jjDiOpUsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCYO3YJA9NF7fwHAbvSFboEzZ8K+IJt9QG63tygw+cUMPZGuba3rXhsUzE4aG69B2NPVoDMdpXl5QWWva3dF/TQKg7PI8x85d5DXtRO/FX/0MSKRAcY85yd1qAXoXApVNyy1MlTudXfYzOaxB27FM5m+52dHmnQztwCvqyYxF9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BdXsiN8R; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac0b6e8d96cso134503566b.0
        for <bpf@vger.kernel.org>; Mon, 03 Mar 2025 05:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741010278; x=1741615078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vqM9J8169o6NQSyCfH8jigUz0e8mT0uCBXC2otFVc0=;
        b=BdXsiN8RfvwqJZzqHOAehHwfPwLDL23lMgwf3dx2IIGhgiU7AAzbdV1j6dYpzzvKG+
         IHSdc1HhcU1TMUcKf73cuAEfy90dDQlaqJPLU7YFUorlMrunc2nufFktrK9TCO7CkKqd
         b1c0ztMEPUSEQGGdJdfdpYETmlIOLPozddl3pfuTgIggHmCh+8xvU2t1wRlxFyt8CdlH
         SZxnxEyMuCfgfLveY894C7QD/lGYz0b2N3LFaZAJCQBAQu/Kdk9PAvN+2mCx4Avvl91E
         K8DgFpLW/dMbrK4ZB0eVA9p6HC/ZAdoPEFxaPPzi+PyDfyOLREb5vrFMNW3HbDfFpdWc
         WKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741010278; x=1741615078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4vqM9J8169o6NQSyCfH8jigUz0e8mT0uCBXC2otFVc0=;
        b=CVSNHtyD5zX+f+JthF/AxcZMImxphuQXTMXJ0HwFXshDRD2pKHeAzYfnq+LU/5Mbj3
         +20p+ZpnfYBBNu/+uy8Gxu7B9y309NeMvZ8A1sIVpzmdkulWojAyjh/yENTWyg66ar6C
         r4V3cqXK/sUNcIkQOfqh+lw/2VJqH4HpcEG66psDbGolNM9+kcww8Gu7L2tEHZ53en3c
         mUW4T2kTszQc7s6UGjBZvDtzRJow0lfJ+k30ScUHctTY5pnYq9e0ilp9lLRYZfZpey2A
         udzUI0fOMAzD/+aS1y222b3j00phy+CHta4kbDwCs5L8IHbd+CFNLOgMfGKeyiWF7gMG
         cAUQ==
X-Gm-Message-State: AOJu0Yyyy3YhBdFq5imP4W0PsE7hCJQE9AznkeiS5iLoO1ItEvDylmIs
	hoWsQqYOTQJYRCX8NOV239glgXmaO8KZ3uc57EmMKYush5DC8hFq9Kyz5w==
X-Gm-Gg: ASbGncsx08/7+4z7lXur7HB1VGcCz6fvIbUSZkaBgTgTE5bmIQcLp4LjA4tYi7Qd/LA
	DvWIGRtRifYTfJhBTs1w4T2pZCqQnycYNKaOGTQ8mpWtE3m/FlT3xlRqTkRJ1vizQuZ3UpYYN18
	z4BRVdE773c8MZQVW78TOhC6fP2kUwGN7FuhxKuggoSuNw53xsiZRmLYo+plbYbV86sIk1Bq0Ob
	zd6hBo3rWZ92e5Vvg/UfuqfA0zywbBY4TPAvoO0JiLcu8H8Tmo13K5wJuP1xEF9HdN8KtBY75Aw
	bhDIKHm+yvjELaj5agx07ibbYXOJ8s/9lgeK6dEHtVi0vFR1brL9i1nr3EM=
X-Google-Smtp-Source: AGHT+IF5fj6vOeiyyhvwRcfiDqYsruQdgRZ1+1oa2PfajtUsxjd33w/6olQD3nWEWrzTp/z5w4xZCQ==
X-Received: by 2002:a17:907:7f89:b0:abf:7776:7e0c with SMTP id a640c23a62f3a-abf77768840mr463794766b.33.1741010278085;
        Mon, 03 Mar 2025 05:57:58 -0800 (PST)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:500::6:7e2d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c75bfd7sm817975366b.148.2025.03.03.05.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:57:57 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2 1/4] libbpf: use map_is_created helper in map setters
Date: Mon,  3 Mar 2025 13:57:49 +0000
Message-ID: <20250303135752.158343-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303135752.158343-1-mykyta.yatsenko5@gmail.com>
References: <20250303135752.158343-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Refactoring: use map_is_created helper in map setters that need to check
the state of the map. This helps to reduce the number of the places that
depend explicitly on the loaded flag, simplifying refactoring in the
next patch of this set.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/lib/bpf/libbpf.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 899e98225f3b..4895c7ae6422 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4845,6 +4845,11 @@ static int bpf_get_map_info_from_fdinfo(int fd, struct bpf_map_info *info)
 	return 0;
 }
 
+static bool map_is_created(const struct bpf_map *map)
+{
+	return map->obj->loaded || map->reused;
+}
+
 bool bpf_map__autocreate(const struct bpf_map *map)
 {
 	return map->autocreate;
@@ -4852,7 +4857,7 @@ bool bpf_map__autocreate(const struct bpf_map *map)
 
 int bpf_map__set_autocreate(struct bpf_map *map, bool autocreate)
 {
-	if (map->obj->loaded)
+	if (map_is_created(map))
 		return libbpf_err(-EBUSY);
 
 	map->autocreate = autocreate;
@@ -4946,7 +4951,7 @@ struct bpf_map *bpf_map__inner_map(struct bpf_map *map)
 
 int bpf_map__set_max_entries(struct bpf_map *map, __u32 max_entries)
 {
-	if (map->obj->loaded)
+	if (map_is_created(map))
 		return libbpf_err(-EBUSY);
 
 	map->def.max_entries = max_entries;
@@ -5191,11 +5196,6 @@ bpf_object__populate_internal_map(struct bpf_object *obj, struct bpf_map *map)
 
 static void bpf_map__destroy(struct bpf_map *map);
 
-static bool map_is_created(const struct bpf_map *map)
-{
-	return map->obj->loaded || map->reused;
-}
-
 static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, bool is_inner)
 {
 	LIBBPF_OPTS(bpf_map_create_opts, create_attr);
@@ -10299,7 +10299,7 @@ static int map_btf_datasec_resize(struct bpf_map *map, __u32 size)
 
 int bpf_map__set_value_size(struct bpf_map *map, __u32 size)
 {
-	if (map->obj->loaded || map->reused)
+	if (map_is_created(map))
 		return libbpf_err(-EBUSY);
 
 	if (map->mmaped) {
@@ -10345,7 +10345,7 @@ int bpf_map__set_initial_value(struct bpf_map *map,
 {
 	size_t actual_sz;
 
-	if (map->obj->loaded || map->reused)
+	if (map_is_created(map))
 		return libbpf_err(-EBUSY);
 
 	if (!map->mmaped || map->libbpf_type == LIBBPF_MAP_KCONFIG)
-- 
2.48.1



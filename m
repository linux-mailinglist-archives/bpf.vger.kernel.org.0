Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD81D357C3E
	for <lists+bpf@lfdr.de>; Thu,  8 Apr 2021 08:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhDHGO3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Apr 2021 02:14:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52635 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229937AbhDHGOZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 8 Apr 2021 02:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617862454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W23Y3aAsVtxogHIdhlTt5oC2n1pclPZ43lAMZ9IFIWw=;
        b=fTY7/0VYYdXPX5Wbdj+BUiyYxf5lpWtiJmjksyFFSfx89sEqncmCYx7m7PNUyrobnR0WBs
        XqZpXsCoEoUn/yWfwlX/CriOg5hAVqY+nrqyIg1gN5c87ZxSK89gS50J+dFGEP8FDZ+OQ6
        7uY3udx2UaTBKown1w8pAMiNWqgCJSQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-sDa9lW8gPDCB2vrjcR37-Q-1; Thu, 08 Apr 2021 02:14:12 -0400
X-MC-Unique: sDa9lW8gPDCB2vrjcR37-Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FA61A6863;
        Thu,  8 Apr 2021 06:14:11 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-182.ams2.redhat.com [10.36.112.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1ABF87A39E;
        Thu,  8 Apr 2021 06:13:26 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, jolsa@redhat.com,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH bpf-next v4 7/9] libbpf: add bpf_map__inner_map API
Date:   Thu,  8 Apr 2021 09:13:08 +0300
Message-Id: <20210408061310.95877-7-yauheni.kaliuta@redhat.com>
In-Reply-To: <20210408061310.95877-1-yauheni.kaliuta@redhat.com>
References: <20210408061238.95803-1-yauheni.kaliuta@redhat.com>
 <20210408061310.95877-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andrii Nakryiko <andrii.nakryiko@gmail.com>

The API gives access to inner map for map in map types (array or
hash of map). It will be used to dynamically set max_entries in it.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 tools/lib/bpf/libbpf.c   | 10 ++++++++++
 tools/lib/bpf/libbpf.h   |  1 +
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 12 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 7aad78dbb4b4..ed5586cce227 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2194,6 +2194,7 @@ static int parse_btf_map_def(struct bpf_object *obj,
 			map->inner_map = calloc(1, sizeof(*map->inner_map));
 			if (!map->inner_map)
 				return -ENOMEM;
+			map->inner_map->fd = -1;
 			map->inner_map->sec_idx = obj->efile.btf_maps_shndx;
 			map->inner_map->name = malloc(strlen(map->name) +
 						      sizeof(".inner") + 1);
@@ -3845,6 +3846,14 @@ __u32 bpf_map__max_entries(const struct bpf_map *map)
 	return map->def.max_entries;
 }
 
+struct bpf_map *bpf_map__inner_map(struct bpf_map *map)
+{
+	if (!bpf_map_type__is_map_in_map(map->def.type))
+		return NULL;
+
+	return map->inner_map;
+}
+
 int bpf_map__set_max_entries(struct bpf_map *map, __u32 max_entries)
 {
 	if (map->fd >= 0)
@@ -9476,6 +9485,7 @@ int bpf_map__set_inner_map_fd(struct bpf_map *map, int fd)
 		pr_warn("error: inner_map_fd already specified\n");
 		return -EINVAL;
 	}
+	zfree(&map->inner_map);
 	map->inner_map_fd = fd;
 	return 0;
 }
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index f500621d28e5..bec4e6a6e31d 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -480,6 +480,7 @@ LIBBPF_API int bpf_map__pin(struct bpf_map *map, const char *path);
 LIBBPF_API int bpf_map__unpin(struct bpf_map *map, const char *path);
 
 LIBBPF_API int bpf_map__set_inner_map_fd(struct bpf_map *map, int fd);
+LIBBPF_API struct bpf_map *bpf_map__inner_map(struct bpf_map *map);
 
 LIBBPF_API long libbpf_get_error(const void *ptr);
 
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index f5990f7208ce..9768daa75415 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -349,6 +349,7 @@ LIBBPF_0.3.0 {
 		ring_buffer__epoll_fd;
 		xsk_setup_xdp_prog;
 		xsk_socket__update_xskmap;
+		bpf_map__inner_map;
 } LIBBPF_0.2.0;
 
 LIBBPF_0.4.0 {
-- 
2.31.1


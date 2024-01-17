Return-Path: <bpf+bounces-19728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AE7830693
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 14:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 967781C219E1
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 13:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1091EB35;
	Wed, 17 Jan 2024 13:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="c6Sjz0eY"
X-Original-To: bpf@vger.kernel.org
Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30A31EB2F
	for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705496792; cv=none; b=cNaHWmSAyXJiMbbzVyGqEONuF5XKCNI+t57SIZV5QYdosTGgP9Gbpu8Fxyj7MrezrgtwDgDXtQTAncGC3JgNLQBTeWSU8j2UWAngKRgtTTKskfzrvKsVwZjHkUg603LRQ0aTjhBXsJ93bFGLyYJOVuxeOgSgTJ3zJthLuOHg++A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705496792; c=relaxed/simple;
	bh=wmrisYsjPBLTjFIJPSOSjLR+2Z+bJUTHVeJWAbwNXEg=;
	h=Received:Received:X-Yandex-Fwd:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:Content-Transfer-Encoding; b=XMClO3hAlag5IYdpx5Ab0OHA3c2WbCYc4anJ9Jl+BLVbWMC6bqoE6HVoPpHMiHtItMh6TRTsx28LiS5Ky6/eX0/eztkMtjRFBzTcvUMLnSNvgRIUZ0HfIncGRw3EI2ntefaGyD12R5sLG199UErhHyabPZJdYbzYc6ANkKCvjJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=c6Sjz0eY; arc=none smtp.client-ip=178.154.239.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:750a:0:640:e46:0])
	by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id D222862102;
	Wed, 17 Jan 2024 16:06:25 +0300 (MSK)
Received: from conquistador.yandex.net (unknown [2a02:6b8:0:40c:d80d:e04a:8a36:b2e9])
	by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id L6ppF00IYuQ0-GCtZj78d;
	Wed, 17 Jan 2024 16:06:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1705496785;
	bh=29N/qxELE0uZBQtPa+k60MgVyqpW/zO7cFXFlZv4rSQ=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=c6Sjz0eYdtau0/3DGoftZfbY1TrJ8vU2rhnpnwmAmez1hNi6Tui6g19+47O6Ru2K4
	 9fmCVFromfGvLnEGdMmd23VpmUxihK5d65MPW/zYBM6GaPdjj0Z75jfvs/NRn+UkHR
	 8qUpszTLoEfkO+KLYx+x/mVFGzI2OqEXYiF/YtkU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Andrey Grafin <conquistador@yandex-team.ru>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org
Subject: [PATCH bpf v5 1/2] libbpf: Apply map_set_def_max_entries() for inner_maps on creation
Date: Wed, 17 Jan 2024 16:06:18 +0300
Message-ID: <20240117130619.9403-1-conquistador@yandex-team.ru>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch allows to auto create BPF_MAP_TYPE_ARRAY_OF_MAPS and
BPF_MAP_TYPE_HASH_OF_MAPS with values of BPF_MAP_TYPE_PERF_EVENT_ARRAY
by bpf_object__load().

Previous behaviour created a zero filled btf_map_def for inner maps and
tried to use it for a map creation but the linux kernel forbids to create
a BPF_MAP_TYPE_PERF_EVENT_ARRAY map with max_entries=0.

Fixes: 646f02ffdd49 ("libbpf: Add BTF-defined map-in-map support")
Signed-off-by: Andrey Grafin <conquistador@yandex-team.ru>
---
 tools/lib/bpf/libbpf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e067be95da3c..8f4d580187aa 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -70,6 +70,7 @@
 
 static struct bpf_map *bpf_object__add_map(struct bpf_object *obj);
 static bool prog_is_subprog(const struct bpf_object *obj, const struct bpf_program *prog);
+static int map_set_def_max_entries(struct bpf_map *map);
 
 static const char * const attach_type_name[] = {
 	[BPF_CGROUP_INET_INGRESS]	= "cgroup_inet_ingress",
@@ -5212,6 +5213,9 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 
 	if (bpf_map_type__is_map_in_map(def->type)) {
 		if (map->inner_map) {
+			err = map_set_def_max_entries(map->inner_map);
+			if (err)
+				return err;
 			err = bpf_object__create_map(obj, map->inner_map, true);
 			if (err) {
 				pr_warn("map '%s': failed to create inner map: %d\n",
-- 
2.41.0



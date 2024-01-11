Return-Path: <bpf+bounces-19380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3029A82B5AE
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 21:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D41F928629B
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 20:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67AC25676A;
	Thu, 11 Jan 2024 20:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="UTQvh4VE"
X-Original-To: bpf@vger.kernel.org
Received: from forwardcorp1a.mail.yandex.net (forwardcorp1a.mail.yandex.net [178.154.239.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E95556742
	for <bpf@vger.kernel.org>; Thu, 11 Jan 2024 20:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net [IPv6:2a02:6b8:c29:fcc6:0:640:eb21:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 1FF6460914;
	Thu, 11 Jan 2024 23:05:29 +0300 (MSK)
Received: from conquistador.yandex.net (unknown [2a02:6b8:0:40c:d80d:e04a:8a36:b2e9])
	by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id O5qiBlYIW8c0-RiUbuYKj;
	Thu, 11 Jan 2024 23:05:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1705003528;
	bh=3je4lo/RuetL6S/DDrbTaWQnuCH8qimsCfA0nYqMcGs=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=UTQvh4VEFxLdJhKemQ+GWSzPDqNvRNdHJAHitBQG9ynjmUh2x+r0D0TVW8lctX1LN
	 NsbCIvPPZDRAbjsR0Nqdl1rjg1IKldi2gfdgIexuEDMRu7gnVSk5R66Fz4roLHH2GR
	 wucQn4snLpU33ih3NrE9iH32Sa6Bqo0VZGwKJShM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Andrey Grafin <conquistador@yandex-team.ru>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org
Subject: [PATCH bpf] bpf: apply map_set_def_max_entries() for inner_maps on creation
Date: Thu, 11 Jan 2024 23:05:13 +0300
Message-ID: <20240111200513.9254-1-conquistador@yandex-team.ru>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch allows to create BPF_MAP_TYPE_ARRAY_OF_MAPS and
BPF_MAP_TYPE_HASH_OF_MAPS with values of BPF_MAP_TYPE_PERF_EVENT_ARRAY.

Previous behaviour created a zero filled btf_map_def for inner maps and
tried to use it for a map creation but the linux kernel forbids to create
a BPF_MAP_TYPE_PERF_EVENT_ARRAY map with max_entries=0.

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



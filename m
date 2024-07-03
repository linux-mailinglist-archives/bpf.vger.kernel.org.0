Return-Path: <bpf+bounces-33735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C063925577
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 10:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4882D1C22AF8
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 08:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8828F13A24A;
	Wed,  3 Jul 2024 08:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=ziegler.andreas@siemens.com header.b="L7L57DzH"
X-Original-To: bpf@vger.kernel.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FB013BAF1
	for <bpf@vger.kernel.org>; Wed,  3 Jul 2024 08:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719995718; cv=none; b=ZbRtlqBLGfNFiTAExr4pgj5UIYAgsVO/xCmQN1pQv1Zs1pi4DBBhagnZlLDfBALljNxMFR1i6Tg24Tv7GHJDYK9mwze41rByEMkF8VhK3B3jyJYUQDVUi8eSy5BPeMv0IfnsDKJfog/dGn2HlGeM/ZwE2B9sQeNYxVnn7m1NVrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719995718; c=relaxed/simple;
	bh=NE4mcokORx8nzprECoDhl/NIF8E+UJxpNKhON4U3ad0=;
	h=From:Cc:Subject:Date:Message-Id:MIME-Version; b=o0ENqFfOdSJm6+AZgeKFHLGGKurKUUqwdJp4Pa/gQlgSxA20ymTDP3MKd1UU8do9WUY5wlcprpDQhUEhfGZRFpD00b+iY34DC1b15AxoGh5Jfo7fVcDPm47M7eReF2vw+dVpiK3fP5gsJ1a1+DAD4B+rfpGBBAme3DleYrz0eXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=ziegler.andreas@siemens.com header.b=L7L57DzH; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202407030835063302afe4dfe1965a8f
        for <bpf@vger.kernel.org>;
        Wed, 03 Jul 2024 10:35:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=ziegler.andreas@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=UHaxMOTp3hJaKOa/viZsy6vWL1hwPuU7YOxyKbA6WLo=;
 b=L7L57DzHFeX15AzeEnjrqgT42DUvRC/p9S2Wt105lRC9zUWApVFMGKLwDDl2BMZoIYXO3T
 YLaSvtCOQEQ/j/sC4TahuaigGYGmhAaAUzxMw6TRZzNwK7UTBq31+8mjoKXB/ivJ7t4Sn3uY
 dMq1/Ht87EY3QztB47sPLJmpNsZa4=;
From: Andreas Ziegler <ziegler.andreas@siemens.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Ziegler <ziegler.andreas@siemens.com>
Subject: [PATCH] libbpf: add NULL checks to bpf_object__{prev_map,next_map}
Date: Wed,  3 Jul 2024 10:34:36 +0200
Message-Id: <20240703083436.505124-1-ziegler.andreas@siemens.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1326705:519-21489:flowmailer

In the current state, an erroneous call to
bpf_object__find_map_by_name(NULL, ...) leads to a segmentation fault
through the following call chain:

bpf_object__find_map_by_name(obj = NULL, ...)
-> bpf_object__for_each_map(pos, obj = NULL)
-> bpf_object__next_map((obj = NULL), NULL)
-> return (obj = NULL)->maps

While calling bpf_object__find_map_by_name with obj = NULL is
obviously incorrect, this should not lead to a segmentation
fault but rather be handled gracefully.

As __bpf_map__iter already handles this situation correctly,
we can delegate the check for the regular case there and only
add a check in case the prev or next parameter is NULL.

Signed-off-by: Andreas Ziegler <ziegler.andreas@siemens.com>
---
 tools/lib/bpf/libbpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4a28fac4908a..30f121754d83 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10375,7 +10375,7 @@ __bpf_map__iter(const struct bpf_map *m, const struct bpf_object *obj, int i)
 struct bpf_map *
 bpf_object__next_map(const struct bpf_object *obj, const struct bpf_map *prev)
 {
-	if (prev == NULL)
+	if (prev == NULL && obj != NULL)
 		return obj->maps;
 
 	return __bpf_map__iter(prev, obj, 1);
@@ -10384,7 +10384,7 @@ bpf_object__next_map(const struct bpf_object *obj, const struct bpf_map *prev)
 struct bpf_map *
 bpf_object__prev_map(const struct bpf_object *obj, const struct bpf_map *next)
 {
-	if (next == NULL) {
+	if (next == NULL && obj != NULL) {
 		if (!obj->nr_maps)
 			return NULL;
 		return obj->maps + obj->nr_maps - 1;
-- 
2.39.2



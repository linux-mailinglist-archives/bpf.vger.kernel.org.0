Return-Path: <bpf+bounces-19605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF17482EFCE
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 14:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 322211F2402B
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 13:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBE21BDC5;
	Tue, 16 Jan 2024 13:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Tm/etXvw"
X-Original-To: bpf@vger.kernel.org
Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1821E1BC4E
	for <bpf@vger.kernel.org>; Tue, 16 Jan 2024 13:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:291a:0:640:e5df:0])
	by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id CFBB162091;
	Tue, 16 Jan 2024 16:34:55 +0300 (MSK)
Received: from conquistador.yandex.net (unknown [2a02:6b8:0:40c:d80d:e04a:8a36:b2e9])
	by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id pYobUg0iCW20-1EIpaDn8;
	Tue, 16 Jan 2024 16:34:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1705412095;
	bh=I4pF+1IBkMkwOZulreOBxgZPfdP+MHdaESgx0GX0eq0=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=Tm/etXvwT5IUaQQ72u5fjIbLPAzXhctOkWz5pOBHO/0zCLpdraRdnp2komi19gZbv
	 SBURIk8OB1khp0DOM/1+eF0Ag2wDVMRbEFeb3bwx/zy0nls2Awmt0TmcZ3Px09NdX1
	 iDipEA+i5psJ/vZpYdgjkQPK7R3wE8HyDwvokmKU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Andrey Grafin <conquistador@yandex-team.ru>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org
Subject: [PATCH bpf v4 2/2] selftest/bpf: Add map_in_maps with BPF_MAP_TYPE_PERF_EVENT_ARRAY values
Date: Tue, 16 Jan 2024 16:34:43 +0300
Message-ID: <20240116133443.21164-2-conquistador@yandex-team.ru>
In-Reply-To: <20240116133443.21164-1-conquistador@yandex-team.ru>
References: <20240116133443.21164-1-conquistador@yandex-team.ru>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check that bpf_object__load() successfully creates map_in_maps
with BPF_MAP_TYPE_PERF_EVENT_ARRAY values.
This changes cover fix in the commit 912884275669
("libbpf: Apply map_set_def_max_entries() for inner_maps on creation").

A command line output is:
- w/o fix
$ sudo ./test_maps
libbpf: map 'mim_array_pe': failed to create inner map: -22
libbpf: map 'mim_array_pe': failed to create: Invalid argument(-22)
libbpf: failed to load object './test_map_in_map.bpf.o'
Failed to load test prog

- with fix
$ sudo ./test_maps
...
test_maps: OK, 0 SKIPPED

Signed-off-by: Andrey Grafin <conquistador@yandex-team.ru>
---
 .../selftests/bpf/progs/test_map_in_map.c     | 23 +++++++++++++++++++
 tools/testing/selftests/bpf/test_maps.c       |  6 ++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_map_in_map.c b/tools/testing/selftests/bpf/progs/test_map_in_map.c
index f416032ba858..54ce1f4bdc7b 100644
--- a/tools/testing/selftests/bpf/progs/test_map_in_map.c
+++ b/tools/testing/selftests/bpf/progs/test_map_in_map.c
@@ -21,6 +21,29 @@ struct {
 	__type(value, __u32);
 } mim_hash SEC(".maps");
 
+struct perf_event_array {
+	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
+	__type(key, __u32);
+	__type(value, __u32);
+} inner_map0 SEC(".maps"), inner_map1 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(max_entries, 2);
+	__type(key, __u32);
+	__array(values, struct perf_event_array);
+} mim_array_pe SEC(".maps") = {
+	.values = {&inner_map0, &inner_map1}};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__array(values, struct perf_event_array);
+} mim_hash_pe SEC(".maps") = {
+	.values = {&inner_map0}};
+
+
 SEC("xdp")
 int xdp_mimtest0(struct xdp_md *ctx)
 {
diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index 7fc00e423e4d..e0dd101c9f2b 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -1190,7 +1190,11 @@ static void test_map_in_map(void)
 		goto out_map_in_map;
 	}
 
-	bpf_object__load(obj);
+	err = bpf_object__load(obj);
+	if (err) {
+		printf("Failed to load test prog\n");
+		goto out_map_in_map;
+	}
 
 	map = bpf_object__find_map_by_name(obj, "mim_array");
 	if (!map) {
-- 
2.41.0



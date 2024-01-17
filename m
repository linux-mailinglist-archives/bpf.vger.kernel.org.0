Return-Path: <bpf+bounces-19729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2898A830694
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 14:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07011F23AB2
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 13:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B501EB38;
	Wed, 17 Jan 2024 13:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="MmjVKgzG"
X-Original-To: bpf@vger.kernel.org
Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E306F1EB2B
	for <bpf@vger.kernel.org>; Wed, 17 Jan 2024 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705496793; cv=none; b=YcgTlljP2ECcFaghNXDaz1XOiEfR8jX1zrgjrEd9n+1fjR5kVceIQy/DbKUvvWB3HbfJ86oC2GgkUC4e1V85xH7tHkXFFekr/y0I1EwhDLY6dYrne8CnnagqNYYvvwsAb77TP8QZcn2f9K08aLzdgNJe2L2X3z0PLXeDRJeOa1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705496793; c=relaxed/simple;
	bh=BR0GASpQlt3UFZXFKGhJXUFeGJ8f7XkqXljQ8vd/Ejg=;
	h=Received:Received:X-Yandex-Fwd:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=uiPbxCH8nnxCrA/fHPZl2fIhIlavqQPUejyf3uQTHBQCku0I2ENyixlLANQ9Nqkihift8i9g5hLP84r75S2wI+hVW4lHOlm5PBAuBNXO91VSUD+Tu9OZ4TxS3Hg3yXbzdPqfFDFzUD4RwB01TfAl9/t1zirEDGA1sxqfNHObOFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=MmjVKgzG; arc=none smtp.client-ip=178.154.239.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:750a:0:640:e46:0])
	by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 48F88620EA;
	Wed, 17 Jan 2024 16:06:26 +0300 (MSK)
Received: from conquistador.yandex.net (unknown [2a02:6b8:0:40c:d80d:e04a:8a36:b2e9])
	by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id L6ppF00IYuQ0-vcIe4Z30;
	Wed, 17 Jan 2024 16:06:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1705496786;
	bh=ggB0rCvQlQp2KQS3GccFnh46B0oR6bChOvK0Qyp75o4=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=MmjVKgzGko3MuZACKJuMdDcfV1g6BU6c27ds9IP7C1PNKey2yZxsTamu3G/ImCI+Y
	 tXC+2a8Cr4PDM9Xd8j8Nlm1PRIjHV+xhWNbPJCMhwGSXcgtpVhtRu3XpWoPnPOUGJi
	 DP9G7PQ0twBg608d2qAkTnwZfjDndHpl4YHB2QTc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Andrey Grafin <conquistador@yandex-team.ru>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org
Subject: [PATCH bpf v5 2/2] selftest/bpf: Add map_in_maps with BPF_MAP_TYPE_PERF_EVENT_ARRAY values
Date: Wed, 17 Jan 2024 16:06:19 +0300
Message-ID: <20240117130619.9403-2-conquistador@yandex-team.ru>
In-Reply-To: <20240117130619.9403-1-conquistador@yandex-team.ru>
References: <20240117130619.9403-1-conquistador@yandex-team.ru>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check that bpf_object__load() successfully creates map_in_maps
with BPF_MAP_TYPE_PERF_EVENT_ARRAY values.
These changes cover fix in the previous patch
"libbpf: Apply map_set_def_max_entries() for inner_maps on creation".

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

Fixes: 646f02ffdd49 ("libbpf: Add BTF-defined map-in-map support")
Signed-off-by: Andrey Grafin <conquistador@yandex-team.ru>
---
 .../selftests/bpf/progs/test_map_in_map.c     | 26 +++++++++++++++++++
 tools/testing/selftests/bpf/test_maps.c       |  6 ++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_map_in_map.c b/tools/testing/selftests/bpf/progs/test_map_in_map.c
index f416032ba858..b295f9b721bf 100644
--- a/tools/testing/selftests/bpf/progs/test_map_in_map.c
+++ b/tools/testing/selftests/bpf/progs/test_map_in_map.c
@@ -21,6 +21,32 @@ struct {
 	__type(value, __u32);
 } mim_hash SEC(".maps");
 
+/* The following three maps are used to test
+ * perf_event_array map can be an inner
+ * map of hash/array_of_maps.
+ */
+struct perf_event_array {
+	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
+	__type(key, __u32);
+	__type(value, __u32);
+} inner_map0 SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__array(values, struct perf_event_array);
+} mim_array_pe SEC(".maps") = {
+	.values = {&inner_map0}};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__array(values, struct perf_event_array);
+} mim_hash_pe SEC(".maps") = {
+	.values = {&inner_map0}};
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



Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446696AFA85
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 00:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjCGXeb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 18:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjCGXeS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 18:34:18 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE15A908F
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 15:33:32 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 327Kg4CA011891
        for <bpf@vger.kernel.org>; Tue, 7 Mar 2023 15:33:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=WFTCn6Q6FqRumAiZIBE1HanUzPq3kOIim0WlTMFLxqI=;
 b=PnUw8VlXC/oSHMRRKxo1PoFoMbjnEo1+1q5qZrZdojdYGwA3UiK7JIqSBj63sZiMaMwT
 BNEAXg91K5Iw2nQJRNxm3TnQBcDG+TPebjK/dn3n7sy94j5E9wWQTSfcRUKbRmJYVq09
 IkUzJZ4jJz3z8EamVCL+mH40M5wK0e+Oh7K9rpm1ur2+9K5a2E3Bp87DWK8TMtadLp4U
 aMkxZorFAnzROnVKqY8PiuKvYLqcYRFMv9y3SVggnJGuaLhTsS54bGTNokm/j7PvE1KQ
 g0TocBxcR7vzIXtpmFv9gfM/et2SOl54p3g3yskKbAcMYzMbw4ocKYHsoQWdbpBjkxj+ 3Q== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3p6bu8scnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 15:33:31 -0800
Received: from twshared52565.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 7 Mar 2023 15:33:30 -0800
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 597A76C7C9C3; Tue,  7 Mar 2023 15:33:13 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <song@kernel.org>, <kernel-team@meta.com>, <andrii@kernel.org>,
        <sdf@google.com>
CC:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v4 7/9] libbpf: Update a bpf_link with another struct_ops.
Date:   Tue, 7 Mar 2023 15:33:05 -0800
Message-ID: <20230307233307.3626875-8-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307233307.3626875-1-kuifeng@meta.com>
References: <20230307233307.3626875-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: cWZ4OHC3F0imTBTriscK3865-ltBarzy
X-Proofpoint-ORIG-GUID: cWZ4OHC3F0imTBTriscK3865-ltBarzy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_16,2023-03-07_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce bpf_link__update_struct_ops(), which will allow you to
effortlessly transition the struct_ops map of any given bpf_link into
an alternative.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 tools/lib/bpf/libbpf.c   | 36 ++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   |  1 +
 tools/lib/bpf/libbpf.map |  2 ++
 3 files changed, 39 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a67efc3b3763..247de39d136f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11520,6 +11520,42 @@ struct bpf_link *bpf_map__attach_struct_ops(cons=
t struct bpf_map *map)
 	return &link->link;
 }
=20
+/*
+ * Swap the back struct_ops of a link with a new struct_ops map.
+ */
+int bpf_link__update_map(struct bpf_link *link, const struct bpf_map *ma=
p)
+{
+	struct bpf_link_struct_ops *st_ops_link;
+	__u32 zero =3D 0;
+	int err, fd;
+
+	if (!bpf_map__is_struct_ops(map) || map->fd =3D=3D -1)
+		return -EINVAL;
+
+	st_ops_link =3D container_of(link, struct bpf_link_struct_ops, link);
+	/* Ensure the type of a link is correct */
+	if (st_ops_link->map_fd < 0)
+		return -EINVAL;
+
+	err =3D bpf_map_update_elem(map->fd, &zero, map->st_ops->kern_vdata, 0)=
;
+	if (err && errno !=3D EBUSY) {
+		err =3D -errno;
+		free(link);
+		return err;
+	}
+
+	fd =3D bpf_link_update(link->fd, map->fd, NULL);
+	if (fd < 0) {
+		err =3D -errno;
+		free(link);
+		return err;
+	}
+
+	st_ops_link->map_fd =3D map->fd;
+
+	return 0;
+}
+
 typedef enum bpf_perf_event_ret (*bpf_perf_event_print_t)(struct perf_ev=
ent_header *hdr,
 							  void *private_data);
=20
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 2efd80f6f7b9..5e62878d184c 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -695,6 +695,7 @@ bpf_program__attach_freplace(const struct bpf_program=
 *prog,
 struct bpf_map;
=20
 LIBBPF_API struct bpf_link *bpf_map__attach_struct_ops(const struct bpf_=
map *map);
+LIBBPF_API int bpf_link__update_map(struct bpf_link *link, const struct =
bpf_map *map);
=20
 struct bpf_iter_attach_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 11c36a3c1a9f..e83571b04c19 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -384,4 +384,6 @@ LIBBPF_1.1.0 {
 } LIBBPF_1.0.0;
=20
 LIBBPF_1.2.0 {
+	global:
+		bpf_link__update_map;
 } LIBBPF_1.1.0;
--=20
2.34.1


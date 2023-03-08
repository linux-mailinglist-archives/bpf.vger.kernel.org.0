Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C265A6AFB94
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 01:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjCHAxm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 19:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjCHAxm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 19:53:42 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9BB99245
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 16:53:41 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32803UuC006025
        for <bpf@vger.kernel.org>; Tue, 7 Mar 2023 16:53:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=xGyFyd+lQUC+ifSexXOhvgCJY1riQKqULnjP5jvfkeY=;
 b=cSSiHGpn2hClql9nz4tm7lfs82Kd8xgCZrRnHepK6LJnAQlFV5bIgFMSCOl4aVYpi0Fg
 xvTj4xG4KXzjTqNblzMQNu0qsaFiq2IAZTIQycRP2F9KGeEekNLdeb/9CyqJJUuZZuw7
 h4LrCXNfuF5523xJRbymiokQct8GrrcztmYYUIIx65L6R+x6x2dcsagVZiKJFiAQo8Ha
 KSiKU4K9tVN/iqxJ6XS30s3KkNMq5EdvjKL4KGUKVVIquQAB93iChcFshqSRWReSi5/c
 r8oRAvKCsAKe/LSoU0MN0NUlWgAE42s/VdeK+2kYIpwidLX63FCxuTqBVsZ2VIgWAGDl 2w== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p6fft87v5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 16:53:40 -0800
Received: from twshared24004.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 7 Mar 2023 16:53:39 -0800
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id A6C6C6C92E1E; Tue,  7 Mar 2023 16:50:54 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <martin.lau@linux.dev>,
        <song@kernel.org>, <kernel-team@meta.com>, <andrii@kernel.org>,
        <sdf@google.com>
CC:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v5 6/8] libbpf: Update a bpf_link with another struct_ops.
Date:   Tue, 7 Mar 2023 16:50:48 -0800
Message-ID: <20230308005050.255859-7-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230308005050.255859-1-kuifeng@meta.com>
References: <20230308005050.255859-1-kuifeng@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ckTmwa2L7ajxZy-SmLOEpTugHT2I4JNA
X-Proofpoint-ORIG-GUID: ckTmwa2L7ajxZy-SmLOEpTugHT2I4JNA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_18,2023-03-07_01,2023-02-09_01
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
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 38 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index f70b55c0f40e..0406d0e00e1f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11657,6 +11657,42 @@ struct bpf_link *bpf_map__attach_struct_ops(cons=
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
index db4992a036f8..1615e55e2e79 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -719,6 +719,7 @@ bpf_program__attach_freplace(const struct bpf_program=
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
index 50dde1f6521e..cc05be376257 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -387,6 +387,7 @@ LIBBPF_1.2.0 {
 	global:
 		bpf_btf_get_info_by_fd;
 		bpf_link_get_info_by_fd;
+		bpf_link__update_map;
 		bpf_map_get_info_by_fd;
 		bpf_prog_get_info_by_fd;
 } LIBBPF_1.1.0;
--=20
2.34.1


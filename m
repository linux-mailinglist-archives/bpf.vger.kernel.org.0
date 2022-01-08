Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB332487FFB
	for <lists+bpf@lfdr.de>; Sat,  8 Jan 2022 01:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbiAHAmy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Jan 2022 19:42:54 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38456 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232027AbiAHAmy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 7 Jan 2022 19:42:54 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 207NNuDm032653
        for <bpf@vger.kernel.org>; Fri, 7 Jan 2022 16:42:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=OGNOMDT6dIgIyXZXX4M4ISGKgyHwPXHMscSOviIqbmg=;
 b=ZnY7LXQOEQ1fATMe0YpjJqbRhQRoIT8Acg6jifpTQROeRU9wyQK2Q+IC4VJjTkzzillx
 VvYrZq7xEk4hJnufasY7NzRYmNzX6zRn9J4NHPOOPe5wKTHD5hkG+cMX+brDFw+03lY0
 Hmhr7YK2EyliVih3EzjpP7o2VzS7Bss+/ug= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dey530aps-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 07 Jan 2022 16:42:53 -0800
Received: from twshared5363.25.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 7 Jan 2022 16:42:52 -0800
Received: by devbig921.prn2.facebook.com (Postfix, from userid 132113)
        id 7B7861694BC5; Fri,  7 Jan 2022 16:42:39 -0800 (PST)
From:   Christy Lee <christylee@fb.com>
To:     <andrii@kernel.org>, <acme@kernel.org>
CC:     <christyc.y.lee@gmail.com>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-perf-users@vger.kernel.org>,
        Christy Lee <christylee@fb.com>
Subject: [PATCH bpf-next v2 1/5] samples/bpf: stop using bpf_map__def() API
Date:   Fri, 7 Jan 2022 16:42:14 -0800
Message-ID: <20220108004218.355761-2-christylee@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220108004218.355761-1-christylee@fb.com>
References: <20220108004218.355761-1-christylee@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: XaBBmRFNTv5ACeX4qv3ISLR5sYDKq--c
X-Proofpoint-GUID: XaBBmRFNTv5ACeX4qv3ISLR5sYDKq--c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-07_10,2022-01-07_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201080001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

libbpf bpf_map__def() API is being deprecated, replace samples/bpf's
usage with the appropriate getters and setters.

Signed-off-by: Christy Lee <christylee@fb.com>
---
 samples/bpf/xdp_rxq_info_user.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/samples/bpf/xdp_rxq_info_user.c b/samples/bpf/xdp_rxq_info_u=
ser.c
index 74a2926eba08..4033f345aa29 100644
--- a/samples/bpf/xdp_rxq_info_user.c
+++ b/samples/bpf/xdp_rxq_info_user.c
@@ -209,7 +209,7 @@ static struct datarec *alloc_record_per_cpu(void)
=20
 static struct record *alloc_record_per_rxq(void)
 {
-	unsigned int nr_rxqs =3D bpf_map__def(rx_queue_index_map)->max_entries;
+	unsigned int nr_rxqs =3D bpf_map__max_entries(rx_queue_index_map);
 	struct record *array;
=20
 	array =3D calloc(nr_rxqs, sizeof(struct record));
@@ -222,7 +222,7 @@ static struct record *alloc_record_per_rxq(void)
=20
 static struct stats_record *alloc_stats_record(void)
 {
-	unsigned int nr_rxqs =3D bpf_map__def(rx_queue_index_map)->max_entries;
+	unsigned int nr_rxqs =3D bpf_map__max_entries(rx_queue_index_map);
 	struct stats_record *rec;
 	int i;
=20
@@ -241,7 +241,7 @@ static struct stats_record *alloc_stats_record(void)
=20
 static void free_stats_record(struct stats_record *r)
 {
-	unsigned int nr_rxqs =3D bpf_map__def(rx_queue_index_map)->max_entries;
+	unsigned int nr_rxqs =3D bpf_map__max_entries(rx_queue_index_map);
 	int i;
=20
 	for (i =3D 0; i < nr_rxqs; i++)
@@ -289,7 +289,7 @@ static void stats_collect(struct stats_record *rec)
 	map_collect_percpu(fd, 0, &rec->stats);
=20
 	fd =3D bpf_map__fd(rx_queue_index_map);
-	max_rxqs =3D bpf_map__def(rx_queue_index_map)->max_entries;
+	max_rxqs =3D bpf_map__max_entries(rx_queue_index_map);
 	for (i =3D 0; i < max_rxqs; i++)
 		map_collect_percpu(fd, i, &rec->rxq[i]);
 }
@@ -335,7 +335,7 @@ static void stats_print(struct stats_record *stats_re=
c,
 			struct stats_record *stats_prev,
 			int action, __u32 cfg_opt)
 {
-	unsigned int nr_rxqs =3D bpf_map__def(rx_queue_index_map)->max_entries;
+	unsigned int nr_rxqs =3D bpf_map__max_entries(rx_queue_index_map);
 	unsigned int nr_cpus =3D bpf_num_possible_cpus();
 	double pps =3D 0, err =3D 0;
 	struct record *rec, *prev;
--=20
2.30.2


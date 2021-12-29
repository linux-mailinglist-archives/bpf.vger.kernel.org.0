Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE5E4816B8
	for <lists+bpf@lfdr.de>; Wed, 29 Dec 2021 21:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhL2UmP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Dec 2021 15:42:15 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56918 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229461AbhL2UmP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 29 Dec 2021 15:42:15 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BTHDsqX020636
        for <bpf@vger.kernel.org>; Wed, 29 Dec 2021 12:42:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=rID7Udps9KAh42PGkqtFj+L+4VbpqpdcScsKc3khfCo=;
 b=rsVze+LU9S1FoJZRwtAwPlBuILgWzBI5jPuiiuj19WdVpz1kg/GwULORVldHpj1wvTnD
 mK3ExyPATGNPUf3zgx/47cOKcey11n8Ga/11iE/Mu7CbEQ+xYzb4jVRI5SywOcjkvzdl
 p+3KS/9t02qZj4W2tXrZpGC3h0TCUr/iAZc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3d84vwywrr-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 29 Dec 2021 12:42:15 -0800
Received: from twshared5363.25.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 29 Dec 2021 12:42:13 -0800
Received: by devbig921.prn2.facebook.com (Postfix, from userid 132113)
        id AE2061005BD5; Wed, 29 Dec 2021 12:42:09 -0800 (PST)
From:   Christy Lee <christylee@fb.com>
To:     <andrii@kernel.org>, <acme@kernel.org>
CC:     <christyc.y.lee@gmail.com>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>, <ast@kernel.org>,
        Christy Lee <christylee@fb.com>
Subject: [PATCH bpf-next] libbpf: deprecate bpf_perf_event_read_simple() API
Date:   Wed, 29 Dec 2021 12:41:56 -0800
Message-ID: <20211229204156.13569-1-christylee@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Gy5-t6etCkHUpgjstVxVj1Qu4HLTJ85a
X-Proofpoint-ORIG-GUID: Gy5-t6etCkHUpgjstVxVj1Qu4HLTJ85a
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-29_06,2021-12-29_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112290111
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With perf_buffer__poll() and perf_buffer__consume() APIs available,
there is no reason to expose bpf_perf_event_read_simple() API to
users. If users need custom perf buffer, they could re-implement
the function.

Mark bpf_perf_event_read_simple() and move the logic to a new
static function so it can still be called by other functions in the
same file.

[0] Closes: https://github.com/libbpf/libbpf/issues/310

Signed-off-by: Christy Lee <christylee@fb.com>
---
 tools/lib/bpf/libbpf.c | 15 ++++++++++++---
 tools/lib/bpf/libbpf.h |  1 +
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 9cb99d1e2385..8a8020985db1 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10676,8 +10676,8 @@ struct bpf_link *bpf_map__attach_struct_ops(const s=
truct bpf_map *map)
 	return link;
 }
=20
-enum bpf_perf_event_ret
-bpf_perf_event_read_simple(void *mmap_mem, size_t mmap_size, size_t page_s=
ize,
+static enum bpf_perf_event_ret
+perf_event_read_simple(void *mmap_mem, size_t mmap_size, size_t page_size,
 			   void **copy_mem, size_t *copy_size,
 			   bpf_perf_event_print_t fn, void *private_data)
 {
@@ -10724,6 +10724,15 @@ bpf_perf_event_read_simple(void *mmap_mem, size_t =
mmap_size, size_t page_size,
 	return libbpf_err(ret);
 }
=20
+enum bpf_perf_event_ret
+bpf_perf_event_read_simple(void *mmap_mem, size_t mmap_size, size_t page_s=
ize,
+			   void **copy_mem, size_t *copy_size,
+			   bpf_perf_event_print_t fn, void *private_data)
+{
+	return perf_event_read_simple(mmap_mem, mmap_size, page_size, copy_mem,
+				      copy_size, fn, private_data);
+}
+
 struct perf_buffer;
=20
 struct perf_buffer_params {
@@ -11132,7 +11141,7 @@ static int perf_buffer__process_records(struct perf=
_buffer *pb,
 {
 	enum bpf_perf_event_ret ret;
=20
-	ret =3D bpf_perf_event_read_simple(cpu_buf->base, pb->mmap_size,
+	ret =3D perf_event_read_simple(cpu_buf->base, pb->mmap_size,
 					 pb->page_size, &cpu_buf->buf,
 					 &cpu_buf->buf_size,
 					 perf_buffer__process_record, cpu_buf);
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 85dfef88b3d2..ddf1cc9e7803 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1026,6 +1026,7 @@ LIBBPF_API int perf_buffer__buffer_fd(const struct pe=
rf_buffer *pb, size_t buf_i
 typedef enum bpf_perf_event_ret
 	(*bpf_perf_event_print_t)(struct perf_event_header *hdr,
 				  void *private_data);
+LIBBPF_DEPRECATED_SINCE(0, 8, "use perf_buffer__poll() or  perf_buffer__co=
nsume() instead")
 LIBBPF_API enum bpf_perf_event_ret
 bpf_perf_event_read_simple(void *mmap_mem, size_t mmap_size, size_t page_s=
ize,
 			   void **copy_mem, size_t *copy_size,
--=20
2.30.2


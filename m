Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB1C48A30B
	for <lists+bpf@lfdr.de>; Mon, 10 Jan 2022 23:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242548AbiAJWhF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Jan 2022 17:37:05 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:63398 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242574AbiAJWhE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 10 Jan 2022 17:37:04 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20AJZ4tf014102
        for <bpf@vger.kernel.org>; Mon, 10 Jan 2022 14:37:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=8Elfquv8gIKLJ9pS4xhge8Z4FoNVsH8ZvYc69ub2co0=;
 b=Sb7aLh3Y28IbYV0tBVGsrt+/ypQC0tO/rAwyukznNEsD+UQUTQMFU37jNJUeg2FM/qSj
 354uhdfVjqYSVJiFQIoypxk5tj5nWakFSk9zyu/YQtlQwIZkp1Jz7s2xWoNXDHaZoXRp
 NflJ3qyuhvy1q5pcekLbsCmunsvpVWKECR4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dgtps1e55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 10 Jan 2022 14:37:04 -0800
Received: from twshared4941.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 10 Jan 2022 14:37:03 -0800
Received: by devvm1744.ftw0.facebook.com (Postfix, from userid 460691)
        id 6EE632124D80; Mon, 10 Jan 2022 14:36:54 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next] libbpf: Improve btf__add_btf() with an additional hashmap for strings.
Date:   Mon, 10 Jan 2022 14:36:44 -0800
Message-ID: <20220110223644.364987-1-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: SzBHyustm3iF26Mmbgb57V-_5mqDRErp
X-Proofpoint-GUID: SzBHyustm3iF26Mmbgb57V-_5mqDRErp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-10_10,2022-01-10_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=837
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201100146
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a hashmap to map the string offsets from a source btf to the
string offsets from a target btf to reduce overheads.

btf__add_btf() calls btf__add_str() to add strings from a source to a
target btf.  It causes many string comparisons, and it is a major
hotspot when adding a big btf.  btf__add_str() uses strcmp() to check
if a hash entry is the right one.  The extra hashmap here compares
offsets of strings, that are much cheaper.  It remembers the results
of btf__add_str() for later uses to reduce the cost.

We are parallelizing BTF encoding for pahole by creating separated btf
instances for worker threads.  These per-thread btf instances will be
added to the btf instance of the main thread by calling btf__add_str()
to deduplicate and write out.  With this patch and -j4, the running
time of pahole drops to about 6.0s from 6.6s.

The following lines are the summary of 'perf stat' w/o the change.

       6.668126396 seconds time elapsed

      13.451054000 seconds user
       0.715520000 seconds sys

The following lines are the summary w/ the change.

       5.986973919 seconds time elapsed

      12.939903000 seconds user
       0.724152000 seconds sys

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
---
 tools/lib/bpf/btf.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 9aa19c89f758..cd1e92c17261 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1620,20 +1620,35 @@ static int btf_commit_type(struct btf *btf, int d=
ata_sz)
 struct btf_pipe {
 	const struct btf *src;
 	struct btf *dst;
+	struct hashmap str_off_map; /* map string offsets from src to dst */
 };
=20
 static int btf_rewrite_str(__u32 *str_off, void *ctx)
 {
 	struct btf_pipe *p =3D ctx;
+	void *mapped_off;
 	int off;
+	int err;
=20
 	if (!*str_off) /* nothing to do for empty strings */
 		return 0;
=20
+	if (hashmap__find(&p->str_off_map, (void *)(long)*str_off, &mapped_off)=
) {
+		*str_off =3D (__u32)(long)mapped_off;
+		return 0;
+	}
+
 	off =3D btf__add_str(p->dst, btf__str_by_offset(p->src, *str_off));
 	if (off < 0)
 		return off;
=20
+	/* Remember string mapping from src to dst.  It avoids
+	 * performing expensive string comparisons.
+	 */
+	err =3D hashmap__append(&p->str_off_map, (void *)(long)*str_off, (void =
*)(long)off);
+	if (err)
+		return err;
+
 	*str_off =3D off;
 	return 0;
 }
@@ -1680,6 +1695,9 @@ static int btf_rewrite_type_ids(__u32 *type_id, voi=
d *ctx)
 	return 0;
 }
=20
+static size_t btf_dedup_identity_hash_fn(const void *key, void *ctx);
+static bool btf_dedup_equal_fn(const void *k1, const void *k2, void *ctx=
);
+
 int btf__add_btf(struct btf *btf, const struct btf *src_btf)
 {
 	struct btf_pipe p =3D { .src =3D src_btf, .dst =3D btf };
@@ -1687,6 +1705,9 @@ int btf__add_btf(struct btf *btf, const struct btf =
*src_btf)
 	__u32 *off;
 	void *t;
=20
+	/* Map the string offsets from src_btf to the offsets from btf to impro=
ve performance */
+	hashmap__init(&p.str_off_map, btf_dedup_identity_hash_fn, btf_dedup_equ=
al_fn, NULL);
+
 	/* appending split BTF isn't supported yet */
 	if (src_btf->base_btf)
 		return libbpf_err(-ENOTSUP);
@@ -1754,6 +1775,8 @@ int btf__add_btf(struct btf *btf, const struct btf =
*src_btf)
 	btf->hdr->str_off +=3D data_sz;
 	btf->nr_types +=3D cnt;
=20
+	hashmap__clear(&p.str_off_map);
+
 	/* return type ID of the first added BTF type */
 	return btf->start_id + btf->nr_types - cnt;
 err_out:
@@ -1767,6 +1790,8 @@ int btf__add_btf(struct btf *btf, const struct btf =
*src_btf)
 	 * wasn't modified, so doesn't need restoring, see big comment above */
 	btf->hdr->str_len =3D old_strs_len;
=20
+	hashmap__clear(&p.str_off_map);
+
 	return libbpf_err(err);
 }
=20
--=20
2.30.2


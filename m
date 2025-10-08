Return-Path: <bpf+bounces-70604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A55BC6279
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 19:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7514E1899E16
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 17:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03542BF002;
	Wed,  8 Oct 2025 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="afgTfeIN"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DBE2BEFF8
	for <bpf@vger.kernel.org>; Wed,  8 Oct 2025 17:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759944955; cv=none; b=CdVs3TpTeywsy2wHmPhfSLQutLDyjEwWYZUXcx3XewvBqZdBDQfXidMcJILvls1Q7F6j1GiljZQi4lhmGvh7sMB7LefGQvfmDuCy1DuiCyAWdlp+UlS6F+4pCgnqtbEKHuh0KMObm6d71jdgu8+ukxEvSCWl9mrBmJuLRLu2jXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759944955; c=relaxed/simple;
	bh=L2cWYRzaubGqLKWLSZyJP8IbiSVCB9H4qzxwijh1cZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F18CeYJKyK/gNb7Yuz+8BvqXl8PjCKrlV9ESNoRxjZXGXVPZPqvRmag8+9CAogVweMh778WNzLE7i3OxC6Xov7DcpCry+7sey6ozN+fEpKmcMFgXnO3niB2cwe38Q7N5LbKiQPWlN4/c00Po/pvQiIipqIxtKLjfVJ5bp+VHH38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=afgTfeIN; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598HJQ7m018480;
	Wed, 8 Oct 2025 17:35:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=K3M8Y
	q7iFVuMyrEMK0NEuMMofI6UTRU3YJRcsofDF+A=; b=afgTfeINQ/yHOLuMsebPs
	pbNPkDZ48iQ2XQhO6vkvPlmiEPqqMosezZsvqYkf47wocOZ3aQ5bfO8YC2C5FptW
	QP8Bx59Or05bmVFOZ70hUcsvicktpqNa3wqwpoq5ycYRl6J7N6Kzfi8bdlxfteDC
	yO7i6KAbq3WAz8emZNs+PPKL1lTyqDDHuvLKZMV7n9F2ZoRk3ET73zQXrHugoscU
	bfe4OXdby+yoMPkgFizpAFuqoaql8aMCpbh1+6MBRYkMwZ8wI2HcTiShPswRZ37F
	Ac/dbi72EAESBuE9YM/iBUkiaGjNz+ti3fXKMMHENLwVHK1oFzw91CBaUNxVB2tP
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv8pr0wh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Oct 2025 17:35:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 598HDtMV037058;
	Wed, 8 Oct 2025 17:35:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49nv62rptx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Oct 2025 17:35:23 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 598HZFUm031138;
	Wed, 8 Oct 2025 17:35:23 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-53-90.vpn.oracle.com [10.154.53.90])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49nv62rpmb-4;
	Wed, 08 Oct 2025 17:35:23 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        david.faust@oracle.com, jose.marchesi@oracle.com, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 03/15] libbpf: Add option to retrieve map from old->new ids from btf__dedup()
Date: Wed,  8 Oct 2025 18:34:59 +0100
Message-ID: <20251008173512.731801-4-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251008173512.731801-1-alan.maguire@oracle.com>
References: <20251008173512.731801-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_05,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510080123
X-Proofpoint-GUID: URnl0XlpqhXefgNaamGzMWo-Z75NvvCF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMiBTYWx0ZWRfX+aMuQgL1NgB+
 Hs5IbuGH217i/ug+TIYkVcnyTriPo276L8LPqfbGgUbttBQ28VW/vllewmvSZ0UchH68u0QVCTE
 z+xhRC/21YFA91h5Gxo4AbWuWpfX/knDGvq/+HhL78iUj71W+VPXYKVVixBhv6IBgmnX0AWpqLd
 96PLmhdwndAaG5zikwIN8bdSttWBkexIsVSZMNNKlW9rqE+wJKRvynZW9vsT5TJtMmXTXGzbiaF
 WuEtthtmOXoIMNJMfPTsi3w10rtDgTiTGRvl89enUjARQFp/YpMarOteX3Fzivalqu/Yc4M/FOh
 r0bkvBlEdkgIqI+bSltBn2VBblMG4Sx8mdRiZpbThlag4Qx1lGkeckpKIz7s05lZu9rtrTRDsHo
 BKG+Mqwt5Fz3/XrRvH+Gpr0VO85VGuigteTSn2o1S0FKobg14ic=
X-Proofpoint-ORIG-GUID: URnl0XlpqhXefgNaamGzMWo-Z75NvvCF
X-Authority-Analysis: v=2.4 cv=U6SfzOru c=1 sm=1 tr=0 ts=68e6a0dd b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=x6icFKpwvdMA:10 a=yPCof4ZbAAAA:8 a=UVjqitbAw_J0JPDCJggA:9 cc=ntf
 awl=host:13625

When creating split BTF for the .BTF.extra section to record location
information, we need to add function prototypes that refer to base BTF
(vmlinux) types.  However since .BTF.extra is split BTF we have a
problem; since collecting those type ids for the parameters, the base
vmlinux BTF has been deduplicated so the type ids are stale.  As a
result it is valuable to be able to access the map from old->new type
ids that is constructed as part of deduplication.  This allows us to
update the out-of-date type ids in the FUNC_PROTOs.

In order to pass the map back, we need to fill out all of the hypot
map mappings; as an optimization normal dedup only computes type id
mappings needed in existing BTF type id references.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 35 ++++++++++++++++++++++++++++++++++-
 tools/lib/bpf/btf.h |  5 ++++-
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 0abd7831d6b4..6b06fb60d39a 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -3650,6 +3650,8 @@ static int btf_dedup_ref_types(struct btf_dedup *d);
 static int btf_dedup_resolve_fwds(struct btf_dedup *d);
 static int btf_dedup_compact_types(struct btf_dedup *d);
 static int btf_dedup_remap_types(struct btf_dedup *d);
+static int btf_dedup_remap_type_id(__u32 *type_id, void *ctx);
+static int btf_dedup_save_map(struct btf_dedup *d, __u32 **save_map);
 
 /*
  * Deduplicate BTF types and strings.
@@ -3850,6 +3852,15 @@ int btf__dedup(struct btf *btf, const struct btf_dedup_opts *opts)
 	}
 
 done:
+	if (!err) {
+		if (opts && opts->dedup_map && opts->dedup_map_sz) {
+			err = btf_dedup_save_map(d, opts->dedup_map);
+			if (err >= 0) {
+				*opts->dedup_map_sz = err;
+				err = 0;
+			}
+		}
+	}
 	btf_dedup_free(d);
 	return libbpf_err(err);
 }
@@ -3880,6 +3891,7 @@ struct btf_dedup {
 	__u32 *hypot_list;
 	size_t hypot_cnt;
 	size_t hypot_cap;
+	size_t hypot_map_cnt;
 	/* Whether hypothetical mapping, if successful, would need to adjust
 	 * already canonicalized types (due to a new forward declaration to
 	 * concrete type resolution). In such case, during split BTF dedup
@@ -4010,6 +4022,7 @@ static struct btf_dedup *btf_dedup_new(struct btf *btf, const struct btf_dedup_o
 		err = -ENOMEM;
 		goto done;
 	}
+	d->hypot_map_cnt = type_cnt;
 	for (i = 0; i < type_cnt; i++)
 		d->hypot_map[i] = BTF_UNPROCESSED_ID;
 
@@ -5628,7 +5641,6 @@ static int btf_dedup_remap_type_id(__u32 *type_id, void *ctx)
 	new_type_id = d->hypot_map[resolved_type_id];
 	if (new_type_id > BTF_MAX_NR_TYPES)
 		return -EINVAL;
-
 	*type_id = new_type_id;
 	return 0;
 }
@@ -5678,6 +5690,27 @@ static int btf_dedup_remap_types(struct btf_dedup *d)
 	return 0;
 }
 
+/* retrieve a copy of map and avoid it being freed during btf_dedup_free(). */
+static int btf_dedup_save_map(struct btf_dedup *d, __u32 **save_map)
+{
+	__u32 i, resolved_id;
+
+	/* only existing references in BTF that needed to be adjusted are
+	 * mapped in the hypot map; fill in the rest.
+	 */
+	for (i = 0; i < d->hypot_map_cnt; i++) {
+		if (d->hypot_map[i] <= BTF_MAX_NR_TYPES)
+			continue;
+		resolved_id = resolve_type_id(d, i);
+		d->hypot_map[i] = d->hypot_map[resolved_id];
+	}
+	*save_map = d->hypot_map;
+	/* ensure btf_dedup_free() will not free hypot map; it belongs to caller */
+	d->hypot_map = NULL;
+
+	return d->hypot_map_cnt;
+}
+
 /*
  * Probe few well-known locations for vmlinux kernel image and try to load BTF
  * data out of it to use for target BTF.
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 0f55518a2be0..082b010c0228 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -265,9 +265,12 @@ struct btf_dedup_opts {
 	struct btf_ext *btf_ext;
 	/* force hash collisions (used for testing) */
 	bool force_collisions;
+	/* return dedup mapping array (from original -> new id) */
+	__u32 **dedup_map;
+	size_t *dedup_map_sz;
 	size_t :0;
 };
-#define btf_dedup_opts__last_field force_collisions
+#define btf_dedup_opts__last_field dedup_map_sz
 
 LIBBPF_API int btf__dedup(struct btf *btf, const struct btf_dedup_opts *opts);
 
-- 
2.39.3



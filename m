Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC914A8B15
	for <lists+bpf@lfdr.de>; Thu,  3 Feb 2022 19:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbiBCSA7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Feb 2022 13:00:59 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:6186 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1353231AbiBCSAr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 3 Feb 2022 13:00:47 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 213HKtk4011513
        for <bpf@vger.kernel.org>; Thu, 3 Feb 2022 10:00:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=HJoO6JkEqnUHuvdqq738pTAp6J9kfNTfpWl1pIquAps=;
 b=I8OenNremoBS+UpejPMrnqqcvRw8K5H6P7cMJMYD2r1aBu18bXBaS5xb9iHBCb62XaBK
 wGNOu0Qw+egHnqkbO/mY6E5VnC9TSPEVAbVbbCTEsTmzd1+38a1QpcvKl8WTpti7L+Jp
 /SKPsSnJ6WGuGHXThoMGMfooIuRLZGAOkgE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3e04phd6ap-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 03 Feb 2022 10:00:46 -0800
Received: from twshared19733.18.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Feb 2022 10:00:44 -0800
Received: by devvm3278.frc0.facebook.com (Postfix, from userid 8598)
        id 337401C6C03B8; Thu,  3 Feb 2022 10:00:40 -0800 (PST)
From:   Delyan Kratunov <delyank@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     Delyan Kratunov <delyank@fb.com>
Subject: [PATCH bpf-next] libbpf: deprecate priv/set_priv storage
Date:   Thu, 3 Feb 2022 10:00:32 -0800
Message-ID: <20220203180032.1921580-1-delyank@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: tCBjqWsGcN8irWFSxRrFhGG4enVtuXfG
X-Proofpoint-GUID: tCBjqWsGcN8irWFSxRrFhGG4enVtuXfG
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-03_06,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202030109
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Arbitrary storage via bpf_*__set_priv/__priv is being deprecated
without a replacement ([1]). perf uses this capability, but most of
that is going away with the removal of prologue generation ([2]).
perf is already suppressing deprecation warnings, so the remaining
cleanup will happen separately.

  [1]: Closes: https://github.com/libbpf/libbpf/issues/294
  [2]: https://lore.kernel.org/bpf/20220123221932.537060-1-jolsa@kernel.org/

Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 tools/lib/bpf/libbpf.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 5762b57aecfc..c8d8daad212e 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -246,8 +246,10 @@ struct bpf_object *bpf_object__next(struct bpf_object =
*prev);
 	     (pos) =3D (tmp), (tmp) =3D bpf_object__next(tmp))

 typedef void (*bpf_object_clear_priv_t)(struct bpf_object *, void *);
+LIBBPF_DEPRECATED_SINCE(0, 7, "storage via set_priv/priv is deprecated")
 LIBBPF_API int bpf_object__set_priv(struct bpf_object *obj, void *priv,
 				    bpf_object_clear_priv_t clear_priv);
+LIBBPF_DEPRECATED_SINCE(0, 7, "storage via set_priv/priv is deprecated")
 LIBBPF_API void *bpf_object__priv(const struct bpf_object *prog);

 LIBBPF_API int
@@ -279,9 +281,10 @@ bpf_object__prev_program(const struct bpf_object *obj,=
 struct bpf_program *prog)

 typedef void (*bpf_program_clear_priv_t)(struct bpf_program *, void *);

+LIBBPF_DEPRECATED_SINCE(0, 7, "storage via set_priv/priv is deprecated")
 LIBBPF_API int bpf_program__set_priv(struct bpf_program *prog, void *priv,
 				     bpf_program_clear_priv_t clear_priv);
-
+LIBBPF_DEPRECATED_SINCE(0, 7, "storage via set_priv/priv is deprecated")
 LIBBPF_API void *bpf_program__priv(const struct bpf_program *prog);
 LIBBPF_API void bpf_program__set_ifindex(struct bpf_program *prog,
 					 __u32 ifindex);
@@ -769,8 +772,10 @@ LIBBPF_API __u64 bpf_map__map_extra(const struct bpf_m=
ap *map);
 LIBBPF_API int bpf_map__set_map_extra(struct bpf_map *map, __u64 map_extra=
);

 typedef void (*bpf_map_clear_priv_t)(struct bpf_map *, void *);
+LIBBPF_DEPRECATED_SINCE(0, 7, "storage via set_priv/priv is deprecated")
 LIBBPF_API int bpf_map__set_priv(struct bpf_map *map, void *priv,
 				 bpf_map_clear_priv_t clear_priv);
+LIBBPF_DEPRECATED_SINCE(0, 7, "storage via set_priv/priv is deprecated")
 LIBBPF_API void *bpf_map__priv(const struct bpf_map *map);
 LIBBPF_API int bpf_map__set_initial_value(struct bpf_map *map,
 					  const void *data, size_t size);
--
2.30.2

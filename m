Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 433C2484B7C
	for <lists+bpf@lfdr.de>; Wed,  5 Jan 2022 01:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbiAEAGZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Jan 2022 19:06:25 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50596 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236651AbiAEAGY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 4 Jan 2022 19:06:24 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 204KIJ80032166
        for <bpf@vger.kernel.org>; Tue, 4 Jan 2022 16:06:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=1S+ryCQ0P+BSbd90lC/kgjAewfUh7OKqcMNl7h14x2M=;
 b=lxpMgEfJJrFTELxvJ3NFt7//Wj4MgTYmn5CZGkIgmNLl9A0VfjXoR4ztfbbOwNU6BgAn
 dXUJmYFMO3Ky5USS4v7HiHBcRykRHEL6BNy0gHp7GNxg6S9AU97ic8jumWuLxUHKzFfI
 oMe+REoLb63SpC7rP7qZjlWg93JxPzRGGgI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dct1a2jka-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 04 Jan 2022 16:06:23 -0800
Received: from twshared10140.39.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 16:06:20 -0800
Received: by devbig921.prn2.facebook.com (Postfix, from userid 132113)
        id A6E2A145209F; Tue,  4 Jan 2022 16:06:14 -0800 (PST)
From:   Christy Lee <christylee@fb.com>
To:     <andrii@kernel.org>, <acme@kernel.org>
CC:     <christyc.y.lee@gmail.com>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>, Christy Lee <christylee@fb.com>
Subject: [PATCH bpf-next] libbpf 1.0: deprecate bpf_map__is_offload_neutral()
Date:   Tue, 4 Jan 2022 16:06:01 -0800
Message-ID: <20220105000601.2090044-1-christylee@fb.com>
X-Mailer: git-send-email 2.30.2
Content-Type: text/plain; charset="UTF-8"
X-FB-Internal: Safe
X-Proofpoint-GUID: aWHDfRvMbLWEisG1ziBC8ztABKMfhyai
X-Proofpoint-ORIG-GUID: aWHDfRvMbLWEisG1ziBC8ztABKMfhyai
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-04_11,2022-01-04_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201040154
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Deprecate bpf_map__is_offload_neutral(). It=E2=80=99s most probably broken
already. PERF_EVENT_ARRAY isn=E2=80=99t the only map that=E2=80=99s not sui=
table
for hardware offloading. Applications can directly check map type
instead.

[0] Closes: https://github.com/libbpf/libbpf/issues/306

Signed-off-by: Christy Lee <christylee@fb.com>
---
 tools/bpf/bpftool/prog.c | 2 +-
 tools/lib/bpf/libbpf.h   | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index f874896c4154..2a21d50516bc 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1655,7 +1655,7 @@ static int load_with_options(int argc, char **argv, b=
ool first_prog_only)
 	j =3D 0;
 	idx =3D 0;
 	bpf_object__for_each_map(map, obj) {
-		if (!bpf_map__is_offload_neutral(map))
+		if (bpf_map__type(map) !=3D BPF_MAP_TYPE_PERF_EVENT_ARRAY)
 			bpf_map__set_ifindex(map, ifindex);
=20
 		if (j < old_map_fds && idx =3D=3D map_replace[j].idx) {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 85dfef88b3d2..ec4309cb9771 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -744,6 +744,7 @@ LIBBPF_API void *bpf_map__priv(const struct bpf_map *ma=
p);
 LIBBPF_API int bpf_map__set_initial_value(struct bpf_map *map,
 					  const void *data, size_t size);
 LIBBPF_API const void *bpf_map__initial_value(struct bpf_map *map, size_t =
*psize);
+LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_map__type() instead")
 LIBBPF_API bool bpf_map__is_offload_neutral(const struct bpf_map *map);
=20
 /**
--=20
2.30.2


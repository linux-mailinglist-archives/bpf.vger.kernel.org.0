Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9248748204C
	for <lists+bpf@lfdr.de>; Thu, 30 Dec 2021 21:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242088AbhL3Ukj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Dec 2021 15:40:39 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48176 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242114AbhL3Ukj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 30 Dec 2021 15:40:39 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BUJfrZd008040
        for <bpf@vger.kernel.org>; Thu, 30 Dec 2021 12:40:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=/+liL+xQ1HBNuvOhtb3BAS6/Qdw5wiAn9zk9/W6e0M0=;
 b=pwoTiO5YYdFX3fMLDjDCX+22B00eUvPfrTIDGMxhQkxMXJN5d73MMsIFzW9IY5Ts+rpD
 m6Mp7mjSmQK8o0rqgFjNDSbM88mTWSmI7bJ6JPkb+Pu0k1sGnEBZwlm49Z0jl4V5bXex
 ztiPXlGFIPs5uEq0mGp5OzLljDl+2e0pV9Y= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3d9hubsv8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 30 Dec 2021 12:40:38 -0800
Received: from twshared13833.42.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 30 Dec 2021 12:40:37 -0800
Received: by devbig921.prn2.facebook.com (Postfix, from userid 132113)
        id ACB5E10BC03B; Thu, 30 Dec 2021 12:40:31 -0800 (PST)
From:   Christy Lee <christylee@fb.com>
To:     <andrii@kernel.org>, <acme@kernel.org>
CC:     <christyc.y.lee@gmail.com>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>, <ast@kernel.org>,
        Christy Lee <christylee@fb.com>
Subject: [PATCH bpf-next 2/3] libbpf: deprecate bpf_object__open_buffer() API
Date:   Thu, 30 Dec 2021 12:40:07 -0800
Message-ID: <20211230204008.3136565-3-christylee@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211230204008.3136565-1-christylee@fb.com>
References: <20211230204008.3136565-1-christylee@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: VuTtWTMBE1ouAgDsInxdGJJcnFmqQ5Y3
X-Proofpoint-GUID: VuTtWTMBE1ouAgDsInxdGJJcnFmqQ5Y3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-30_08,2021-12-30_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112300117
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Deprecate bpf_object__open_buffer() API in favor of
bpf_object__open_mem() instead.

Signed-off-by: Christy Lee <christylee@fb.com>
---
 tools/lib/bpf/libbpf.h       | 1 +
 tools/perf/tests/llvm.c      | 2 +-
 tools/perf/util/bpf-loader.c | 5 ++++-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 2c8767706f8e..063639a109aa 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -181,6 +181,7 @@ bpf_object__open_mem(const void *obj_buf, size_t obj_=
buf_sz,
 		     const struct bpf_object_open_opts *opts);
=20
 /* deprecated bpf_object__open variants */
+LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_object__open_mem() instead")
 LIBBPF_API struct bpf_object *
 bpf_object__open_buffer(const void *obj_buf, size_t obj_buf_sz,
 			const char *name);
diff --git a/tools/perf/tests/llvm.c b/tools/perf/tests/llvm.c
index 8ac0a3a457ef..0bc25a56cfef 100644
--- a/tools/perf/tests/llvm.c
+++ b/tools/perf/tests/llvm.c
@@ -13,7 +13,7 @@ static int test__bpf_parsing(void *obj_buf, size_t obj_=
buf_sz)
 {
 	struct bpf_object *obj;
=20
-	obj =3D bpf_object__open_buffer(obj_buf, obj_buf_sz, NULL);
+	obj =3D bpf_object__open_mem(obj_buf, obj_buf_sz, NULL);
 	if (libbpf_get_error(obj))
 		return TEST_FAIL;
 	bpf_object__close(obj);
diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 75694703d638..48deb05a9726 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -72,6 +72,9 @@ bpf__prepare_load_buffer(void *obj_buf, size_t obj_buf_=
sz, const char *name)
=20
 struct bpf_object *bpf__prepare_load(const char *filename, bool source)
 {
+	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts,
+		.object_name =3D filename
+	);
 	struct bpf_object *obj;
=20
 	if (!libbpf_initialized) {
@@ -94,7 +97,7 @@ struct bpf_object *bpf__prepare_load(const char *filena=
me, bool source)
 				return ERR_PTR(-BPF_LOADER_ERRNO__COMPILE);
 		} else
 			pr_debug("bpf: successful builtin compilation\n");
-		obj =3D bpf_object__open_buffer(obj_buf, obj_buf_sz, filename);
+		obj =3D bpf_object__open_mem(obj_buf, obj_buf_sz, &opts);
=20
 		if (!IS_ERR_OR_NULL(obj) && llvm_param.dump_obj)
 			llvm__dump_obj(filename, obj_buf, obj_buf_sz);
--=20
2.30.2


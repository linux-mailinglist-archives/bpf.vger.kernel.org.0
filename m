Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B346486E04
	for <lists+bpf@lfdr.de>; Fri,  7 Jan 2022 00:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245650AbiAFXq6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 18:46:58 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35906 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S245667AbiAFXq5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 Jan 2022 18:46:57 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 206M460u014035
        for <bpf@vger.kernel.org>; Thu, 6 Jan 2022 15:46:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=gmhCAq7FfYwaiqXOF2Cw1Wf0HvY36Ehjl4K+f2rQjqU=;
 b=MYbJ2QBzK3Zcot12f8VwiiF7Hc/CYgDsrm6KsXK//3wiAXA46Hr1RjKgzwpL766VPcuE
 OQoB1JhGbH2eRfD8hlRwW6Kukg4sY+xFZFZpfGaMFipfmDwpYNhKI1G2aERRsu2UaLiu
 kq7H3IaVT0PFPvmK07Hg/Au0enQyupBTHDE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3de4w2t87b-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 06 Jan 2022 15:46:57 -0800
Received: from twshared13036.24.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 6 Jan 2022 15:46:54 -0800
Received: by devbig921.prn2.facebook.com (Postfix, from userid 132113)
        id 84C7615CB718; Thu,  6 Jan 2022 15:46:44 -0800 (PST)
From:   Christy Lee <christylee@fb.com>
To:     <andrii@kernel.org>, <acme@kernel.org>
CC:     <christylee@fb.com>, <christyc.y.lee@gmail.com>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 1/2] libbpf: rename bpf_prog_attach_xattr() to bpf_prog_attach_opts()
Date:   Thu, 6 Jan 2022 15:46:38 -0800
Message-ID: <20220106234639.1418484-2-christylee@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220106234639.1418484-1-christylee@fb.com>
References: <20220106234639.1418484-1-christylee@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: I5gHShcV_PfLG4_5wVBHsbLcOrZtlGL7
X-Proofpoint-ORIG-GUID: I5gHShcV_PfLG4_5wVBHsbLcOrZtlGL7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-06_10,2022-01-06_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201060144
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

All xattr APIs are being dropped, let's converge to the convention used i=
n
high-level APIs and rename bpf_prog_attach_xattr to bpf_prog_attach_opts.

Signed-off-by: Christy Lee <christylee@fb.com>
---
 tools/lib/bpf/bpf.c      | 9 +++++++--
 tools/lib/bpf/bpf.h      | 4 ++++
 tools/lib/bpf/libbpf.map | 1 +
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 9b64eed2b003..f0b3f6cc317b 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -754,10 +754,10 @@ int bpf_prog_attach(int prog_fd, int target_fd, enu=
m bpf_attach_type type,
 		.flags =3D flags,
 	);
=20
-	return bpf_prog_attach_xattr(prog_fd, target_fd, type, &opts);
+	return bpf_prog_attach_opts(prog_fd, target_fd, type, &opts);
 }
=20
-int bpf_prog_attach_xattr(int prog_fd, int target_fd,
+int bpf_prog_attach_opts(int prog_fd, int target_fd,
 			  enum bpf_attach_type type,
 			  const struct bpf_prog_attach_opts *opts)
 {
@@ -778,6 +778,11 @@ int bpf_prog_attach_xattr(int prog_fd, int target_fd=
,
 	return libbpf_err_errno(ret);
 }
=20
+__alias("bpf_prog_attach_opts")
+int bpf_prog_attach_xattr(int prog_fd, int target_fd,
+			  enum bpf_attach_type type,
+			  const struct bpf_prog_attach_opts *opts);
+
 int bpf_prog_detach(int target_fd, enum bpf_attach_type type)
 {
 	union bpf_attr attr;
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 00619f64a040..5dc9fefe73f3 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -280,6 +280,10 @@ struct bpf_prog_attach_opts {
=20
 LIBBPF_API int bpf_prog_attach(int prog_fd, int attachable_fd,
 			       enum bpf_attach_type type, unsigned int flags);
+LIBBPF_API int bpf_prog_attach_opts(int prog_fd, int attachable_fd,
+				     enum bpf_attach_type type,
+				     const struct bpf_prog_attach_opts *opts);
+LIBBPF_DEPRECATED_SINCE(0, 8, "use bpf_prog_attach_opts() instead")
 LIBBPF_API int bpf_prog_attach_xattr(int prog_fd, int attachable_fd,
 				     enum bpf_attach_type type,
 				     const struct bpf_prog_attach_opts *opts);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 529783967793..8262cfca2240 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -247,6 +247,7 @@ LIBBPF_0.0.8 {
 		bpf_link_create;
 		bpf_link_update;
 		bpf_map__set_initial_value;
+		bpf_prog_attach_opts;
 		bpf_program__attach_cgroup;
 		bpf_program__attach_lsm;
 		bpf_program__is_lsm;
--=20
2.30.2


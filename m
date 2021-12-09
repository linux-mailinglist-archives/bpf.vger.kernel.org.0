Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCA146DFCA
	for <lists+bpf@lfdr.de>; Thu,  9 Dec 2021 01:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241540AbhLIAz0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 8 Dec 2021 19:55:26 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:5562 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233448AbhLIAz0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 8 Dec 2021 19:55:26 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B8I2MAF008960
        for <bpf@vger.kernel.org>; Wed, 8 Dec 2021 16:51:53 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3ctqvtpcfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 08 Dec 2021 16:51:53 -0800
Received: from intmgw002.46.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 8 Dec 2021 16:51:52 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 49110C523F54; Wed,  8 Dec 2021 16:49:25 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 01/12] libbpf: fix bpf_prog_load() log_buf logic for log_level 0
Date:   Wed, 8 Dec 2021 16:49:09 -0800
Message-ID: <20211209004920.4085377-2-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211209004920.4085377-1-andrii@kernel.org>
References: <20211209004920.4085377-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: K0B_PWNK6yBqnoaoi7oZiF_6HiLtbFPt
X-Proofpoint-ORIG-GUID: K0B_PWNK6yBqnoaoi7oZiF_6HiLtbFPt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-08_08,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 priorityscore=1501 spamscore=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112090002
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

To unify libbpf APIs behavior w.r.t. log_buf and log_level, fix
bpf_prog_load() to follow the same logic as bpf_btf_load() and
high-level bpf_object__load() API will follow in the subsequent patches:
  - if log_level is 0 and non-NULL log_buf is provided by a user, attempt
    load operation initially with no log_buf and log_level set;
  - if successful, we are done, return new FD;
  - on error, retry the load operation with log_level bumped to 1 and
    log_buf set; this way verbose logging will be requested only when we
    are sure that there is a failure, but will be fast in the
    common/expected success case.

Of course, user can still specify log_level > 0 from the very beginning
to force log collection.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 4e7836e1a7b5..c7627fc18952 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -303,10 +303,6 @@ int bpf_prog_load_v0_6_0(enum bpf_prog_type prog_type,
 	if (log_level && !log_buf)
 		return libbpf_err(-EINVAL);
 
-	attr.log_level = log_level;
-	attr.log_buf = ptr_to_u64(log_buf);
-	attr.log_size = log_size;
-
 	func_info_rec_size = OPTS_GET(opts, func_info_rec_size, 0);
 	func_info = OPTS_GET(opts, func_info, NULL);
 	attr.func_info_rec_size = func_info_rec_size;
@@ -321,6 +317,12 @@ int bpf_prog_load_v0_6_0(enum bpf_prog_type prog_type,
 
 	attr.fd_array = ptr_to_u64(OPTS_GET(opts, fd_array, NULL));
 
+	if (log_level) {
+		attr.log_buf = ptr_to_u64(log_buf);
+		attr.log_size = log_size;
+		attr.log_level = log_level;
+	}
+
 	fd = sys_bpf_prog_load(&attr, sizeof(attr), attempts);
 	if (fd >= 0)
 		return fd;
@@ -366,16 +368,17 @@ int bpf_prog_load_v0_6_0(enum bpf_prog_type prog_type,
 			goto done;
 	}
 
-	if (log_level || !log_buf)
-		goto done;
+	if (log_level == 0 && !log_buf) {
+		/* log_level == 0 with non-NULL log_buf requires retrying on error
+		 * with log_level == 1 and log_buf/log_buf_size set, to get details of
+		 * failure
+		 */
+		attr.log_buf = ptr_to_u64(log_buf);
+		attr.log_size = log_size;
+		attr.log_level = 1;
 
-	/* Try again with log */
-	log_buf[0] = 0;
-	attr.log_buf = ptr_to_u64(log_buf);
-	attr.log_size = log_size;
-	attr.log_level = 1;
-
-	fd = sys_bpf_prog_load(&attr, sizeof(attr), attempts);
+		fd = sys_bpf_prog_load(&attr, sizeof(attr), attempts);
+	}
 done:
 	/* free() doesn't affect errno, so we don't need to restore it */
 	free(finfo);
-- 
2.30.2


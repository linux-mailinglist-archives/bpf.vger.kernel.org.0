Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542D14A7C00
	for <lists+bpf@lfdr.de>; Thu,  3 Feb 2022 00:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244399AbiBBX4p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Feb 2022 18:56:45 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58046 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348195AbiBBX4o (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 2 Feb 2022 18:56:44 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 212L3SuX005724
        for <bpf@vger.kernel.org>; Wed, 2 Feb 2022 15:56:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=loGUYXn8VbO90T2xXOmIZV699rPgOPGkKB3HF7jBuH0=;
 b=nC0YtbRFPLJA9eeVSWLAJCLYwVqMDMkHwIouxU7UGUwu1iDxuNAdYW+bTuINSMX9EW/P
 OFcbJLDFRWYnJMjteHUwwGSxuU3nRoN5/p3Gzd4Y6sgBAqufzGZttiGWPBKYcXrnWQ/2
 sEyX2g+8t3gn9hlLhxNFNWh+vqR3T3OnbIA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dyutd3u7p-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 02 Feb 2022 15:56:44 -0800
Received: from twshared11487.23.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Feb 2022 15:56:39 -0800
Received: by devvm3278.frc0.facebook.com (Postfix, from userid 8598)
        id 6CB951C61C230; Wed,  2 Feb 2022 15:56:37 -0800 (PST)
From:   Delyan Kratunov <delyank@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>
CC:     Delyan Kratunov <delyank@fb.com>
Subject: [PATCH bpf-next v3 4/4] libbpf: Deprecate bpf_prog_test_run_xattr and bpf_prog_test_run
Date:   Wed, 2 Feb 2022 15:54:23 -0800
Message-ID: <20220202235423.1097270-5-delyank@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220202235423.1097270-1-delyank@fb.com>
References: <20220202235423.1097270-1-delyank@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: xv-f7wr4l281uRkl0qPI1WruBnLxiRBg
X-Proofpoint-ORIG-GUID: xv-f7wr4l281uRkl0qPI1WruBnLxiRBg
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-02_11,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 mlxlogscore=655 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020130
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Deprecate non-extendable bpf_prog_test_run{,_xattr} in favor of
OPTS-based bpf_prog_test_run_opts ([0]).

  [0] Closes: https://github.com/libbpf/libbpf/issues/286

Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 tools/lib/bpf/bpf.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index c2e8327010f9..16b21757b8bf 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -453,12 +453,14 @@ struct bpf_prog_test_run_attr {
 			     * out: length of cxt_out */
 };
=20
+LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_prog_test_run_opts() instead")
 LIBBPF_API int bpf_prog_test_run_xattr(struct bpf_prog_test_run_attr *test=
_attr);
=20
 /*
  * bpf_prog_test_run does not check that data_out is large enough. Consider
- * using bpf_prog_test_run_xattr instead.
+ * using bpf_prog_test_run_opts instead.
  */
+LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_prog_test_run_opts() instead")
 LIBBPF_API int bpf_prog_test_run(int prog_fd, int repeat, void *data,
 				 __u32 size, void *data_out, __u32 *size_out,
 				 __u32 *retval, __u32 *duration);
--=20
2.30.2


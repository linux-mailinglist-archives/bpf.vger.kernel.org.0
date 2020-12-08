Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579AC2D23BB
	for <lists+bpf@lfdr.de>; Tue,  8 Dec 2020 07:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725208AbgLHGoN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 8 Dec 2020 01:44:13 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36842 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725768AbgLHGoN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 8 Dec 2020 01:44:13 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B86OFBi001690
        for <bpf@vger.kernel.org>; Mon, 7 Dec 2020 22:43:31 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 35a2t48g01-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 07 Dec 2020 22:43:31 -0800
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 7 Dec 2020 22:43:30 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id F284F2ECAE85; Mon,  7 Dec 2020 22:43:27 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v2 bpf-next] bpf: return -ENOTSUPP when attaching to non-kernel BTF
Date:   Mon, 7 Dec 2020 22:43:26 -0800
Message-ID: <20201208064326.667389-1-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-08_03:2020-12-04,2020-12-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=8 phishscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=985 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012080039
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Return -ENOTSUPP if tracing BPF program is attempted to be attached with
specified attach_btf_obj_fd pointing to non-kernel (neither vmlinux nor
module) BTF object. This scenario might be supported in the future and isn't
outright invalid, so -EINVAL isn't the most appropriate error code.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/syscall.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0cd3cc2af9c1..287be337d5f6 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2121,8 +2121,11 @@ static int bpf_prog_load(union bpf_attr *attr, union bpf_attr __user *uattr)
 			if (IS_ERR(attach_btf))
 				return -EINVAL;
 			if (!btf_is_kernel(attach_btf)) {
+				/* attaching through specifying bpf_prog's BTF
+				 * objects directly might be supported eventually
+				 */
 				btf_put(attach_btf);
-				return -EINVAL;
+				return -ENOTSUPP;
 			}
 		}
 	} else if (attr->attach_btf_id) {
-- 
2.24.1


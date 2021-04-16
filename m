Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F713617E0
	for <lists+bpf@lfdr.de>; Fri, 16 Apr 2021 04:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbhDPC4g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Apr 2021 22:56:36 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:9284 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234751AbhDPC4g (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 15 Apr 2021 22:56:36 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13G2uCsY022654
        for <bpf@vger.kernel.org>; Thu, 15 Apr 2021 19:56:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=aLyr9rw7bFY9QZ+y3NJ9jMrUlHMAfR8/GWPj3dsBN2w=;
 b=WGpl1HiaQX21yuVQzvaF85Ng4Fpv4udilxabovKJ2kEwQlY9d/XPhtSpHuQPx5E6kqO2
 uhzguay3Hf11cUzkf+T1sXJ7bSKegr2h4viz9Epf7Ll+XIhN201P4tTqVQEiAavy8KdQ
 9rRj4Eo1hENFsNFs+bVycmYFtbIJanL9dJc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37xr303g18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 15 Apr 2021 19:56:12 -0700
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Apr 2021 19:56:11 -0700
Received: by devbig030.frc3.facebook.com (Postfix, from userid 158236)
        id 8E208A2A643; Thu, 15 Apr 2021 19:56:04 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <kernel-team@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next 1/3] bpf: refine retval for bpf_get_task_stack helper
Date:   Thu, 15 Apr 2021 19:55:35 -0700
Message-ID: <20210416025537.2352753-2-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210416025537.2352753-1-davemarchevsky@fb.com>
References: <20210416025537.2352753-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 8Rbn4b0YJrJM-L42Ln0MCMp-rx2YDNQf
X-Proofpoint-GUID: 8Rbn4b0YJrJM-L42Ln0MCMp-rx2YDNQf
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-15_11:2021-04-15,2021-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104160023
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Verifier can constrain the min/max bounds of bpf_get_task_stack's return
value more tightly than the default tnum_unknown. Like bpf_get_stack,
return value is num bytes written into a caller-supplied buf, or error,
so do_refine_retval_range will work.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 kernel/bpf/verifier.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 852541a435ef..348e97f77003 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5767,6 +5767,7 @@ static void do_refine_retval_range(struct bpf_reg_s=
tate *regs, int ret_type,
=20
 	if (ret_type !=3D RET_INTEGER ||
 	    (func_id !=3D BPF_FUNC_get_stack &&
+	     func_id !=3D BPF_FUNC_get_task_stack &&
 	     func_id !=3D BPF_FUNC_probe_read_str &&
 	     func_id !=3D BPF_FUNC_probe_read_kernel_str &&
 	     func_id !=3D BPF_FUNC_probe_read_user_str))
--=20
2.30.2


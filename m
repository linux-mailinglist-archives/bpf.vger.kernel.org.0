Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCED468D3E
	for <lists+bpf@lfdr.de>; Sun,  5 Dec 2021 21:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238568AbhLEUgS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 5 Dec 2021 15:36:18 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:1296 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238456AbhLEUgS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 5 Dec 2021 15:36:18 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B57OqAB006054
        for <bpf@vger.kernel.org>; Sun, 5 Dec 2021 12:32:51 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3crs0m2fjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 05 Dec 2021 12:32:50 -0800
Received: from intmgw002.48.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 5 Dec 2021 12:32:49 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 5352CBFD77AC; Sun,  5 Dec 2021 12:32:48 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 05/11] libbpf: preserve kernel error code and remove kprobe prog type guessing
Date:   Sun, 5 Dec 2021 12:32:28 -0800
Message-ID: <20211205203234.1322242-6-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211205203234.1322242-1-andrii@kernel.org>
References: <20211205203234.1322242-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: V3PdVNtDONXWtUjp0mJeKSLGkEuyVieC
X-Proofpoint-GUID: V3PdVNtDONXWtUjp0mJeKSLGkEuyVieC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-05_11,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 spamscore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999 suspectscore=0
 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112050124
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Instead of rewriting error code returned by the kernel of prog load with
libbpf-sepcific variants pass through the original error.

There is now also no need to have a backup generic -LIBBPF_ERRNO__LOAD
fallback error as bpf_prog_load() guarantees that errno will be properly
set no matter what.

Also drop a completely outdated and pretty useless BPF_PROG_TYPE_KPROBE
guess logic. It's not necessary and neither it's helpful in modern BPF
applications.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index f07ff39a9d20..3fd4e3d5a11f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6696,34 +6696,19 @@ static int bpf_object_load_prog_instance(struct bpf_object *obj, struct bpf_prog
 		free(log_buf);
 		goto retry_load;
 	}
-	ret = errno ? -errno : -LIBBPF_ERRNO__LOAD;
+
+	ret = -errno;
 	cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
 	pr_warn("prog '%s': BPF program load failed: %s\n", prog->name, cp);
 	pr_perm_msg(ret);
 
 	if (log_buf && log_buf[0] != '\0') {
-		ret = -LIBBPF_ERRNO__VERIFY;
 		pr_warn("prog '%s': -- BEGIN PROG LOAD LOG --\n%s-- END PROG LOAD LOG --\n",
 			prog->name, log_buf);
 	}
 	if (insns_cnt >= BPF_MAXINSNS) {
 		pr_warn("prog '%s': program too large (%d insns), at most %d insns\n",
 			prog->name, insns_cnt, BPF_MAXINSNS);
-		ret = -LIBBPF_ERRNO__PROG2BIG;
-	} else if (prog->type != BPF_PROG_TYPE_KPROBE) {
-		/* Wrong program type? */
-		int fd;
-
-		load_attr.expected_attach_type = 0;
-		load_attr.log_buf = NULL;
-		load_attr.log_size = 0;
-		fd = bpf_prog_load(BPF_PROG_TYPE_KPROBE, prog_name, license,
-				   insns, insns_cnt, &load_attr);
-		if (fd >= 0) {
-			close(fd);
-			ret = -LIBBPF_ERRNO__PROGTYPE;
-			goto out;
-		}
 	}
 
 out:
-- 
2.30.2


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAB0444AAD
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 23:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhKCWLo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 3 Nov 2021 18:11:44 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:4768 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230301AbhKCWLn (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Nov 2021 18:11:43 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1A3KAjOv001369
        for <bpf@vger.kernel.org>; Wed, 3 Nov 2021 15:09:06 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3c3ves38hg-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 03 Nov 2021 15:09:06 -0700
Received: from intmgw001.27.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 3 Nov 2021 15:08:59 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id AF98F7D65E48; Wed,  3 Nov 2021 15:08:51 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH v2 bpf-next 02/12] libbpf: pass number of prog load attempts explicitly
Date:   Wed, 3 Nov 2021 15:08:35 -0700
Message-ID: <20211103220845.2676888-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211103220845.2676888-1-andrii@kernel.org>
References: <20211103220845.2676888-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: sj6D_YnHfi__ugWWgbGASVVl_t9MIunN
X-Proofpoint-ORIG-GUID: sj6D_YnHfi__ugWWgbGASVVl_t9MIunN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-03_06,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 mlxlogscore=956 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111030116
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allow to control number of BPF_PROG_LOAD attempts from outside the
sys_bpf_prog_load() helper.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index c09cbb868c9f..8e6a23c42560 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -74,14 +74,15 @@ static inline int sys_bpf_fd(enum bpf_cmd cmd, union bpf_attr *attr,
 	return ensure_good_fd(fd);
 }
 
-static inline int sys_bpf_prog_load(union bpf_attr *attr, unsigned int size)
+#define PROG_LOAD_ATTEMPTS 5
+
+static inline int sys_bpf_prog_load(union bpf_attr *attr, unsigned int size, int attempts)
 {
-	int retries = 5;
 	int fd;
 
 	do {
 		fd = sys_bpf_fd(BPF_PROG_LOAD, attr, size);
-	} while (fd < 0 && errno == EAGAIN && retries-- > 0);
+	} while (fd < 0 && errno == EAGAIN && --attempts > 0);
 
 	return fd;
 }
@@ -304,7 +305,7 @@ int libbpf__bpf_prog_load(const struct bpf_prog_load_params *load_attr)
 		memcpy(attr.prog_name, load_attr->name,
 		       min(strlen(load_attr->name), (size_t)BPF_OBJ_NAME_LEN - 1));
 
-	fd = sys_bpf_prog_load(&attr, sizeof(attr));
+	fd = sys_bpf_prog_load(&attr, sizeof(attr), PROG_LOAD_ATTEMPTS);
 	if (fd >= 0)
 		return fd;
 
@@ -345,7 +346,7 @@ int libbpf__bpf_prog_load(const struct bpf_prog_load_params *load_attr)
 			break;
 		}
 
-		fd = sys_bpf_prog_load(&attr, sizeof(attr));
+		fd = sys_bpf_prog_load(&attr, sizeof(attr), PROG_LOAD_ATTEMPTS);
 		if (fd >= 0)
 			goto done;
 	}
@@ -359,7 +360,7 @@ int libbpf__bpf_prog_load(const struct bpf_prog_load_params *load_attr)
 	attr.log_level = 1;
 	load_attr->log_buf[0] = 0;
 
-	fd = sys_bpf_prog_load(&attr, sizeof(attr));
+	fd = sys_bpf_prog_load(&attr, sizeof(attr), PROG_LOAD_ATTEMPTS);
 done:
 	/* free() doesn't affect errno, so we don't need to restore it */
 	free(finfo);
@@ -449,7 +450,7 @@ int bpf_verify_program(enum bpf_prog_type type, const struct bpf_insn *insns,
 	attr.kern_version = kern_version;
 	attr.prog_flags = prog_flags;
 
-	fd = sys_bpf_prog_load(&attr, sizeof(attr));
+	fd = sys_bpf_prog_load(&attr, sizeof(attr), PROG_LOAD_ATTEMPTS);
 	return libbpf_err_errno(fd);
 }
 
-- 
2.30.2


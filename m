Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5291E17698A
	for <lists+bpf@lfdr.de>; Tue,  3 Mar 2020 01:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbgCCAvS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Mar 2020 19:51:18 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:12274 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727401AbgCCAvS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 2 Mar 2020 19:51:18 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0230jds6016569
        for <bpf@vger.kernel.org>; Mon, 2 Mar 2020 16:51:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=c/QX5W/r2mwr9/SDP1vw/TZfdqkWHOQPMXu2BQAiUy8=;
 b=RL2XkPBhtS801fLgQOvZxYphpiUpddZR6MHiV4t1eJ+eve0nggxGN20bl4fVNq3PubpU
 OjN+SAYBw+DNqVw4zRWD/etc9JOizMprgq2L70HZeaM3QRoCdZO6X5+pXstjtTq1ZdTO
 5jZ6V0v9mkbUpn74THdtN3MyectlI1FSctA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2yg8du7utr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 02 Mar 2020 16:51:17 -0800
Received: from intmgw002.03.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 2 Mar 2020 16:51:17 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id D6D3E2EC2E79; Mon,  2 Mar 2020 16:51:15 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Hostname: devbig012.ftw2.facebook.com
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>
CC:     <andrii.nakryiko@gmail.com>, <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v3 bpf-next 3/3] tools/runqslower: drop copy/pasted BPF_F_CURRENT_CPU definiton
Date:   Mon, 2 Mar 2020 16:32:33 -0800
Message-ID: <20200303003233.3496043-4-andriin@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200303003233.3496043-1-andriin@fb.com>
References: <20200303003233.3496043-1-andriin@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-02_09:2020-03-02,2020-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 suspectscore=8 phishscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 spamscore=0 mlxlogscore=761 priorityscore=1501 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003030002
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With BPF_F_CURRENT_CPU being an enum, it is now captured in vmlinux.h and is
readily usable by runqslower. So drop local copy/pasted definition in favor of
the one coming from vmlinux.h.

Signed-off-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/bpf/runqslower/runqslower.bpf.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/bpf/runqslower/runqslower.bpf.c b/tools/bpf/runqslower/runqslower.bpf.c
index 48a39f72fadf..0ba501305bad 100644
--- a/tools/bpf/runqslower/runqslower.bpf.c
+++ b/tools/bpf/runqslower/runqslower.bpf.c
@@ -6,9 +6,6 @@
 
 #define TASK_RUNNING 0
 
-#define BPF_F_INDEX_MASK		0xffffffffULL
-#define BPF_F_CURRENT_CPU		BPF_F_INDEX_MASK
-
 const volatile __u64 min_us = 0;
 const volatile pid_t targ_pid = 0;
 
-- 
2.17.1


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35A1913389D
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2020 02:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgAHBkX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Jan 2020 20:40:23 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:62170 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726313AbgAHBkX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 7 Jan 2020 20:40:23 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0081ZJLc010046
        for <bpf@vger.kernel.org>; Tue, 7 Jan 2020 17:40:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=9Mmgem05j6f6Nr0jhMMXWk0BUO7urRKCtMtzYeRm0hE=;
 b=LyAQumEsARv9eCLHfP9AxYbB9iy1neve30mrmmQuHiXXF7CaIh3moyZsnxpd7q0dKAYU
 OfqN22X/BSyPsrk8tZpE/lRF3QYEHucISLpn1jJ8YfTP4F3fvrcOf/KBhDfVibWiC9dp
 oJKRnuRRs9KKS9wtkkHOoExSIZPm2xgxbyI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 2xcerhemdx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 07 Jan 2020 17:40:21 -0800
Received: from intmgw004.06.prn3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 7 Jan 2020 17:40:20 -0800
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id 1E7FA3714FB9; Tue,  7 Jan 2020 17:40:17 -0800 (PST)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next] bpf: Document BPF_F_QUERY_EFFECTIVE flag
Date:   Tue, 7 Jan 2020 17:40:06 -0800
Message-ID: <20200108014006.938363-1-rdna@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-07_08:2020-01-07,2020-01-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 suspectscore=13 spamscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 mlxlogscore=411 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001080013
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Document BPF_F_QUERY_EFFECTIVE flag, mostly to clarify how it affects
attach_flags what may not be obvious and what may lead to confision.

Specifically attach_flags is returned only for target_fd but if programs
are inherited from an ancestor cgroup then returned attach_flags for
current cgroup may be confusing. For example, two effective programs of
same attach_type can be returned but w/o BPF_F_ALLOW_MULTI in
attach_flags.

Simple repro:
  # bpftool c s /sys/fs/cgroup/path/to/task
  ID       AttachType      AttachFlags     Name
  # bpftool c s /sys/fs/cgroup/path/to/task effective
  ID       AttachType      AttachFlags     Name
  95043    ingress                         tw_ipt_ingress
  95048    ingress                         tw_ingress

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 include/uapi/linux/bpf.h       | 7 ++++++-
 tools/include/uapi/linux/bpf.h | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 7df436da542d..dc4b8a2d2a86 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -357,7 +357,12 @@ enum bpf_attach_type {
 /* Enable memory-mapping BPF map */
 #define BPF_F_MMAPABLE		(1U << 10)
 
-/* flags for BPF_PROG_QUERY */
+/* Flags for BPF_PROG_QUERY. */
+
+/* Query effective (directly attached + inherited from ancestor cgroups)
+ * programs that will be executed for events within a cgroup.
+ * attach_flags with this flag are returned only for directly attached programs.
+ */
 #define BPF_F_QUERY_EFFECTIVE	(1U << 0)
 
 enum bpf_stack_build_id_status {
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 7df436da542d..dc4b8a2d2a86 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -357,7 +357,12 @@ enum bpf_attach_type {
 /* Enable memory-mapping BPF map */
 #define BPF_F_MMAPABLE		(1U << 10)
 
-/* flags for BPF_PROG_QUERY */
+/* Flags for BPF_PROG_QUERY. */
+
+/* Query effective (directly attached + inherited from ancestor cgroups)
+ * programs that will be executed for events within a cgroup.
+ * attach_flags with this flag are returned only for directly attached programs.
+ */
 #define BPF_F_QUERY_EFFECTIVE	(1U << 0)
 
 enum bpf_stack_build_id_status {
-- 
2.17.1


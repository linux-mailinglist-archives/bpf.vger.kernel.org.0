Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3C45B3FAA
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 21:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiIITbU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 9 Sep 2022 15:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiIITbS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 15:31:18 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2B4D99F4
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 12:31:16 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 289Er5kA026411
        for <bpf@vger.kernel.org>; Fri, 9 Sep 2022 12:31:15 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jfqedf3xk-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 12:31:15 -0700
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub102.TheFacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 9 Sep 2022 12:31:13 -0700
Received: from twshared6447.05.prn5.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 9 Sep 2022 12:31:13 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 318D71EB4F6F6; Fri,  9 Sep 2022 12:30:59 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 2/3] libbpf: fix crash if SEC("freplace") programs don't have attach_prog_fd set
Date:   Fri, 9 Sep 2022 12:30:52 -0700
Message-ID: <20220909193053.577111-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220909193053.577111-1-andrii@kernel.org>
References: <20220909193053.577111-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: WHzCJ1LF5NgQHCC5X7TfGjpzMPqxquCD
X-Proofpoint-ORIG-GUID: WHzCJ1LF5NgQHCC5X7TfGjpzMPqxquCD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_10,2022-09-09_01,2022-06-22_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix SIGSEGV caused by libbpf trying to find attach type in vmlinux BTF
for freplace programs. It's wrong to search in vmlinux BTF and libbpf
doesn't even mark vmlinux BTF as required for freplace programs. So
trying to search anything in obj->vmlinux_btf might cause NULL
dereference if nothing else in BPF object requires vmlinux BTF.

Instead, error out if freplace (EXT) program doesn't specify
attach_prog_fd during at the load time.

Fixes: 91abb4a6d79d ("libbpf: Support attachment of BPF tracing programs to kernel modules")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 3ad139285fad..2ca30ccc774c 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9084,11 +9084,15 @@ static int libbpf_find_attach_btf_id(struct bpf_program *prog, const char *attac
 	int err = 0;
 
 	/* BPF program's BTF ID */
-	if (attach_prog_fd) {
+	if (prog->type == BPF_PROG_TYPE_EXT || attach_prog_fd) {
+		if (!attach_prog_fd) {
+			pr_warn("prog '%s': attach program FD is not set\n", prog->name);
+			return -EINVAL;
+		}
 		err = libbpf_find_prog_btf_id(attach_name, attach_prog_fd);
 		if (err < 0) {
-			pr_warn("failed to find BPF program (FD %d) BTF ID for '%s': %d\n",
-				 attach_prog_fd, attach_name, err);
+			pr_warn("prog '%s': failed to find BPF program (FD %d) BTF ID for '%s': %d\n",
+				 prog->name, attach_prog_fd, attach_name, err);
 			return err;
 		}
 		*btf_obj_fd = 0;
@@ -9105,7 +9109,8 @@ static int libbpf_find_attach_btf_id(struct bpf_program *prog, const char *attac
 		err = find_kernel_btf_id(prog->obj, attach_name, attach_type, btf_obj_fd, btf_type_id);
 	}
 	if (err) {
-		pr_warn("failed to find kernel BTF type ID of '%s': %d\n", attach_name, err);
+		pr_warn("prog '%s': failed to find kernel BTF type ID of '%s': %d\n",
+			prog->name, attach_name, err);
 		return err;
 	}
 	return 0;
-- 
2.30.2


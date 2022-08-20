Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA7C59AD83
	for <lists+bpf@lfdr.de>; Sat, 20 Aug 2022 13:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345239AbiHTLdU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 20 Aug 2022 07:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345157AbiHTLdS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 20 Aug 2022 07:33:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694E010C0;
        Sat, 20 Aug 2022 04:33:12 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M8xHZ1y3YzlWLb;
        Sat, 20 Aug 2022 19:30:02 +0800 (CST)
Received: from dggpemm500019.china.huawei.com (7.185.36.180) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 20 Aug 2022 19:33:10 +0800
Received: from k04.huawei.com (10.67.174.115) by
 dggpemm500019.china.huawei.com (7.185.36.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 20 Aug 2022 19:33:10 +0800
From:   Pu Lehui <pulehui@huawei.com>
To:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>,
        Stanislav Fomichev <sdf@google.com>,
        "Hao Luo" <haoluo@goddogle.com>, Jiri Olsa <jolsa@kernel.org>,
        Pu Lehui <pulehui@huawei.com>
Subject: [PATCH bpf-next 2/2] bpftool: Fix cgroup attach flags being assigned to effective progs
Date:   Sat, 20 Aug 2022 20:02:34 +0800
Message-ID: <20220820120234.2121044-3-pulehui@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220820120234.2121044-1-pulehui@huawei.com>
References: <20220820120234.2121044-1-pulehui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.174.115]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500019.china.huawei.com (7.185.36.180)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When root-cgroup attach multi progs and sub-cgroup attach a
override prog, bpftool will display incorrectly for the attach
flags of the sub-cgroup’s effective progs:

$ bpftool c t /sys/fs/cgroup effective
CgroupPath
ID       AttachType      AttachFlags     Name
/sys/fs/cgroup
6        sysctl          multi           sysctl_tcp_mem
13       sysctl          multi           sysctl_tcp_mem
/sys/fs/cgroup/cg1
    20       sysctl          override        sysctl_tcp_mem
    6        sysctl          override        sysctl_tcp_mem
    13       sysctl          override        sysctl_tcp_mem

Attach flags is only valid for attached progs of this layer
cgroup, but not for effective progs. Since prog_attach_flags
array is already bypass the effective progs, so we can just
use it.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 tools/bpf/bpftool/cgroup.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
index cced668fb2a3..fa3eef0ff860 100644
--- a/tools/bpf/bpftool/cgroup.c
+++ b/tools/bpf/bpftool/cgroup.c
@@ -219,11 +219,7 @@ static int show_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type,
 		return 0;
 
 	for (iter = 0; iter < p.prog_cnt; iter++) {
-		__u32 attach_flags;
-
-		attach_flags = prog_attach_flags[iter] ?: p.attach_flags;
-
-		switch (attach_flags) {
+		switch (prog_attach_flags[iter]) {
 		case BPF_F_ALLOW_MULTI:
 			attach_flags_str = "multi";
 			break;
@@ -234,7 +230,8 @@ static int show_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type,
 			attach_flags_str = "";
 			break;
 		default:
-			snprintf(buf, sizeof(buf), "unknown(%x)", attach_flags);
+			snprintf(buf, sizeof(buf), "unknown(%x)",
+				 prog_attach_flags[iter]);
 			attach_flags_str = buf;
 		}
 
-- 
2.25.1


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F4F59AD7F
	for <lists+bpf@lfdr.de>; Sat, 20 Aug 2022 13:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345215AbiHTLdU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 20 Aug 2022 07:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344899AbiHTLdS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 20 Aug 2022 07:33:18 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AF310B6;
        Sat, 20 Aug 2022 04:33:12 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M8xJb3PrsznTfD;
        Sat, 20 Aug 2022 19:30:55 +0800 (CST)
Received: from dggpemm500019.china.huawei.com (7.185.36.180) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
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
Subject: [PATCH bpf-next 1/2] bpf, cgroup: Fix attach flags being assigned to effective progs
Date:   Sat, 20 Aug 2022 20:02:33 +0800
Message-ID: <20220820120234.2121044-2-pulehui@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220820120234.2121044-1-pulehui@huawei.com>
References: <20220820120234.2121044-1-pulehui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
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

Attach flags is only valid for attached progs of this layer cgroup,
but not for effective progs. We know that the attached progs is at
the beginning of the effective progs array, so we can just populate
the elements in front of the prog_attach_flags array.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 kernel/bpf/cgroup.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 59b7eb60d5b4..9adf72e99907 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1091,11 +1091,14 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
 		}
 
 		if (prog_attach_flags) {
+			int progs_cnt = prog_list_length(&cgrp->bpf.progs[atype]);
 			flags = cgrp->bpf.flags[atype];
 
-			for (i = 0; i < cnt; i++)
+			/* attach flags only for attached progs, but not effective progs */
+			for (i = 0; i < progs_cnt; i++)
 				if (copy_to_user(prog_attach_flags + i, &flags, sizeof(flags)))
 					return -EFAULT;
+
 			prog_attach_flags += cnt;
 		}
 
-- 
2.25.1


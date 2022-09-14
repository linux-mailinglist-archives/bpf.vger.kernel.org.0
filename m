Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68B15B82C2
	for <lists+bpf@lfdr.de>; Wed, 14 Sep 2022 10:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiINIQR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Sep 2022 04:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiINIQN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Sep 2022 04:16:13 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510D356BAA;
        Wed, 14 Sep 2022 01:15:58 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MSClw5MlVz6S6Nc;
        Wed, 14 Sep 2022 16:14:04 +0800 (CST)
Received: from localhost.localdomain (unknown [10.67.175.61])
        by APP2 (Coremail) with SMTP id Syh0CgB3yXK6jSFjj9FPAw--.59270S4;
        Wed, 14 Sep 2022 16:15:56 +0800 (CST)
From:   Pu Lehui <pulehui@huaweicloud.com>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Pu Lehui <pulehui@huawei.com>
Subject: [PATCH bpf-next v3 2/2] bpftool: Fix wrong cgroup attach flags being assigned to effective progs
Date:   Wed, 14 Sep 2022 16:17:42 +0000
Message-Id: <20220914161742.3180731-3-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220914161742.3180731-1-pulehui@huaweicloud.com>
References: <20220914161742.3180731-1-pulehui@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgB3yXK6jSFjj9FPAw--.59270S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAFW7KrWktFy3AF4xCryDKFg_yoWrur4rpr
        s5Xa4UA3W5u3sxWF4rG3y5urWrGr4xXr1UC39xJw15uFyxG34vyr1IkFyF9r13GFWayw4I
        vF15ZryDW3WjvFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
        84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
        xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxV
        A2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
        x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
        43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
        7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
        WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU
        ImhFDUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        KHOP_HELO_FCRDNS,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Pu Lehui <pulehui@huawei.com>

When root-cgroup attach multi progs and sub-cgroup attach a override prog,
bpftool will display incorrectly for the attach flags of the sub-cgroup’s
effective progs:

$ bpftool cgroup tree /sys/fs/cgroup effective
CgroupPath
ID       AttachType      AttachFlags     Name
/sys/fs/cgroup
6        cgroup_sysctl   multi           sysctl_tcp_mem
13       cgroup_sysctl   multi           sysctl_tcp_mem
/sys/fs/cgroup/cg1
20       cgroup_sysctl   override        sysctl_tcp_mem
6        cgroup_sysctl   override        sysctl_tcp_mem <- wrong
13       cgroup_sysctl   override        sysctl_tcp_mem <- wrong
/sys/fs/cgroup/cg1/cg2
20       cgroup_sysctl                   sysctl_tcp_mem
6        cgroup_sysctl                   sysctl_tcp_mem
13       cgroup_sysctl                   sysctl_tcp_mem

Attach flags is only valid for attached progs of this layer cgroup,
but not for effective progs. For querying with EFFECTIVE flags,
exporting attach flags does not make sense. Since prog_attach_flags
array not being populated when effective query, so we can just remove
the corresponding attach flags logic.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 tools/bpf/bpftool/cgroup.c | 54 +++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 21 deletions(-)

diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
index cced668fb2a3..24cdb0b41f89 100644
--- a/tools/bpf/bpftool/cgroup.c
+++ b/tools/bpf/bpftool/cgroup.c
@@ -136,8 +136,8 @@ static int show_bpf_prog(int id, enum bpf_attach_type attach_type,
 			jsonw_string_field(json_wtr, "attach_type", attach_type_str);
 		else
 			jsonw_uint_field(json_wtr, "attach_type", attach_type);
-		jsonw_string_field(json_wtr, "attach_flags",
-				   attach_flags_str);
+		if (!(query_flags & BPF_F_QUERY_EFFECTIVE))
+			jsonw_string_field(json_wtr, "attach_flags", attach_flags_str);
 		jsonw_string_field(json_wtr, "name", prog_name);
 		if (attach_btf_name)
 			jsonw_string_field(json_wtr, "attach_btf_name", attach_btf_name);
@@ -150,7 +150,10 @@ static int show_bpf_prog(int id, enum bpf_attach_type attach_type,
 			printf("%-15s", attach_type_str);
 		else
 			printf("type %-10u", attach_type);
-		printf(" %-15s %-15s", attach_flags_str, prog_name);
+		if (query_flags & BPF_F_QUERY_EFFECTIVE)
+			printf(" %-15s", prog_name);
+		else
+			printf(" %-15s %-15s", attach_flags_str, prog_name);
 		if (attach_btf_name)
 			printf(" %-15s", attach_btf_name);
 		else if (info.attach_btf_id)
@@ -200,7 +203,7 @@ static int show_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type,
 {
 	LIBBPF_OPTS(bpf_prog_query_opts, p);
 	__u32 prog_attach_flags[1024] = {0};
-	const char *attach_flags_str;
+	const char *attach_flags_str = NULL;
 	__u32 prog_ids[1024] = {0};
 	char buf[32];
 	__u32 iter;
@@ -219,23 +222,25 @@ static int show_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type,
 		return 0;
 
 	for (iter = 0; iter < p.prog_cnt; iter++) {
-		__u32 attach_flags;
-
-		attach_flags = prog_attach_flags[iter] ?: p.attach_flags;
-
-		switch (attach_flags) {
-		case BPF_F_ALLOW_MULTI:
-			attach_flags_str = "multi";
-			break;
-		case BPF_F_ALLOW_OVERRIDE:
-			attach_flags_str = "override";
-			break;
-		case 0:
-			attach_flags_str = "";
-			break;
-		default:
-			snprintf(buf, sizeof(buf), "unknown(%x)", attach_flags);
-			attach_flags_str = buf;
+		if (!(query_flags & BPF_F_QUERY_EFFECTIVE)) {
+			__u32 attach_flags;
+
+			attach_flags = prog_attach_flags[iter] ?: p.attach_flags;
+
+			switch (attach_flags) {
+			case BPF_F_ALLOW_MULTI:
+				attach_flags_str = "multi";
+				break;
+			case BPF_F_ALLOW_OVERRIDE:
+				attach_flags_str = "override";
+				break;
+			case 0:
+				attach_flags_str = "";
+				break;
+			default:
+				snprintf(buf, sizeof(buf), "unknown(%x)", attach_flags);
+				attach_flags_str = buf;
+			}
 		}
 
 		show_bpf_prog(prog_ids[iter], type,
@@ -292,6 +297,8 @@ static int do_show(int argc, char **argv)
 
 	if (json_output)
 		jsonw_start_array(json_wtr);
+	else if (query_flags & BPF_F_QUERY_EFFECTIVE)
+		printf("%-8s %-15s %-15s\n", "ID", "AttachType", "Name");
 	else
 		printf("%-8s %-15s %-15s %-15s\n", "ID", "AttachType",
 		       "AttachFlags", "Name");
@@ -436,6 +443,11 @@ static int do_show_tree(int argc, char **argv)
 
 	if (json_output)
 		jsonw_start_array(json_wtr);
+	else if (query_flags & BPF_F_QUERY_EFFECTIVE)
+		printf("%s\n"
+		       "%-8s %-15s %-15s\n",
+		       "CgroupPath",
+		       "ID", "AttachType", "Name");
 	else
 		printf("%s\n"
 		       "%-8s %-15s %-15s %-15s\n",
-- 
2.25.1


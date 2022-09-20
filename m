Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CD55BDE95
	for <lists+bpf@lfdr.de>; Tue, 20 Sep 2022 09:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiITHnA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Sep 2022 03:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiITHmm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Sep 2022 03:42:42 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6BC399E1;
        Tue, 20 Sep 2022 00:41:11 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MWthg1vt9zlK5Z;
        Tue, 20 Sep 2022 15:38:59 +0800 (CST)
Received: from localhost.localdomain (unknown [10.67.175.61])
        by APP2 (Coremail) with SMTP id Syh0CgBH4mt1biljrIh4BA--.36206S4;
        Tue, 20 Sep 2022 15:40:39 +0800 (CST)
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
        Pu Lehui <pulehui@huawei.com>,
        Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf v4 2/2] bpftool: Fix wrong cgroup attach flags being assigned to effective progs
Date:   Tue, 20 Sep 2022 15:42:33 +0000
Message-Id: <20220920154233.1494352-3-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920154233.1494352-1-pulehui@huaweicloud.com>
References: <20220920154233.1494352-1-pulehui@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBH4mt1biljrIh4BA--.36206S4
X-Coremail-Antispam: 1UD129KBjvJXoWxuw4fAr4rGrykAF18CF1rZwb_yoW7CF4xpr
        4kZ34jy3WY9r9xXFsav3s0gFWrGr4xW342ya9xXr4ruF1xWryvyr1IkFy0vr13WFZ2yw4x
        Z3W5ZFZrGw4jva7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUm214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
        0E87I2jVAFwI0_Jryl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2
        F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjx
        v20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2
        z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
        AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1l
        Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
        IFxwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
        bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
        AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
        42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
        IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
        xhVjvjDU0xZFpf9x0pR9NVDUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        KHOP_HELO_FCRDNS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
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
exporting attach flags does not make sense. So let's remove the
AttachFlags field and the associated logic. After this patch, the
above effective cgroup tree will show as bellow:

$ bpftool cgroup tree /sys/fs/cgroup effective
CgroupPath
ID       AttachType      Name
/sys/fs/cgroup
6        cgroup_sysctl   sysctl_tcp_mem
13       cgroup_sysctl   sysctl_tcp_mem
/sys/fs/cgroup/cg1
20       cgroup_sysctl   sysctl_tcp_mem
6        cgroup_sysctl   sysctl_tcp_mem
13       cgroup_sysctl   sysctl_tcp_mem
/sys/fs/cgroup/cg1/cg2
20       cgroup_sysctl   sysctl_tcp_mem
6        cgroup_sysctl   sysctl_tcp_mem
13       cgroup_sysctl   sysctl_tcp_mem

Fixes: b79c9fc9551b ("bpf: implement BPF_PROG_QUERY for BPF_LSM_CGROUP")
Fixes: a98bf57391a2 ("tools: bpftool: add support for reporting the effective cgroup progs")
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 tools/bpf/bpftool/cgroup.c | 54 ++++++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
index cced668fb2a3..b46a998d8f8d 100644
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
@@ -195,6 +198,32 @@ static int cgroup_has_attached_progs(int cgroup_fd)
 
 	return no_prog ? 0 : 1;
 }
+
+static int show_effective_bpf_progs(int cgroup_fd, enum bpf_attach_type type,
+				    int level)
+{
+	LIBBPF_OPTS(bpf_prog_query_opts, p);
+	__u32 prog_ids[1024] = {0};
+	__u32 iter;
+	int ret;
+
+	p.query_flags = query_flags;
+	p.prog_cnt = ARRAY_SIZE(prog_ids);
+	p.prog_ids = prog_ids;
+
+	ret = bpf_prog_query_opts(cgroup_fd, type, &p);
+	if (ret)
+		return ret;
+
+	if (p.prog_cnt == 0)
+		return 0;
+
+	for (iter = 0; iter < p.prog_cnt; iter++)
+		show_bpf_prog(prog_ids[iter], type, NULL, level);
+
+	return 0;
+}
+
 static int show_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type,
 				   int level)
 {
@@ -245,6 +274,14 @@ static int show_attached_bpf_progs(int cgroup_fd, enum bpf_attach_type type,
 	return 0;
 }
 
+static int show_bpf_progs(int cgroup_fd, enum bpf_attach_type type,
+			  int level)
+{
+	return query_flags & BPF_F_QUERY_EFFECTIVE ?
+	       show_effective_bpf_progs(cgroup_fd, type, level) :
+	       show_attached_bpf_progs(cgroup_fd, type, level);
+}
+
 static int do_show(int argc, char **argv)
 {
 	enum bpf_attach_type type;
@@ -292,6 +329,8 @@ static int do_show(int argc, char **argv)
 
 	if (json_output)
 		jsonw_start_array(json_wtr);
+	else if (query_flags & BPF_F_QUERY_EFFECTIVE)
+		printf("%-8s %-15s %-15s\n", "ID", "AttachType", "Name");
 	else
 		printf("%-8s %-15s %-15s %-15s\n", "ID", "AttachType",
 		       "AttachFlags", "Name");
@@ -304,7 +343,7 @@ static int do_show(int argc, char **argv)
 		 * If we were able to get the show for at least one
 		 * attach type, let's return 0.
 		 */
-		if (show_attached_bpf_progs(cgroup_fd, type, 0) == 0)
+		if (show_bpf_progs(cgroup_fd, type, 0) == 0)
 			ret = 0;
 	}
 
@@ -362,7 +401,7 @@ static int do_show_tree_fn(const char *fpath, const struct stat *sb,
 
 	btf_vmlinux = libbpf_find_kernel_btf();
 	for (type = 0; type < __MAX_BPF_ATTACH_TYPE; type++)
-		show_attached_bpf_progs(cgroup_fd, type, ftw->level);
+		show_bpf_progs(cgroup_fd, type, ftw->level);
 
 	if (errno == EINVAL)
 		/* Last attach type does not support query.
@@ -436,6 +475,11 @@ static int do_show_tree(int argc, char **argv)
 
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


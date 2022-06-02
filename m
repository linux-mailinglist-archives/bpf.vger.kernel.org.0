Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D13A53B13F
	for <lists+bpf@lfdr.de>; Thu,  2 Jun 2022 03:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbiFBBNE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Jun 2022 21:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbiFBBNE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Jun 2022 21:13:04 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0065227B4A3;
        Wed,  1 Jun 2022 18:13:01 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LD7K46WVFzjXLQ;
        Thu,  2 Jun 2022 09:12:08 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 2 Jun
 2022 09:12:59 +0800
From:   Zhengchao Shao <shaozhengchao@huawei.com>
To:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <davem@davemloft.net>, <kuba@kernel.org>,
        <hawk@kernel.org>, <john.fastabend@gmail.com>, <andrii@kernel.org>,
        <kafai@fb.com>, <songliubraving@fb.com>, <yhs@fb.com>,
        <kpsingh@kernel.org>, <toke@kernel.org>
CC:     <weiyongjun1@huawei.com>, <shaozhengchao@huawei.com>,
        <yuehaibing@huawei.com>
Subject: [PATCH v5,bpf-next] samples/bpf: check detach prog exist or not in xdp_fwd
Date:   Thu, 2 Jun 2022 09:19:15 +0800
Message-ID: <20220602011915.264431-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Before detach the prog, we should check detach prog exist or not.

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 samples/bpf/xdp_fwd_user.c | 55 +++++++++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 6 deletions(-)

diff --git a/samples/bpf/xdp_fwd_user.c b/samples/bpf/xdp_fwd_user.c
index 1828487bae9a..d321e6aa9364 100644
--- a/samples/bpf/xdp_fwd_user.c
+++ b/samples/bpf/xdp_fwd_user.c
@@ -47,17 +47,60 @@ static int do_attach(int idx, int prog_fd, int map_fd, const char *name)
 	return err;
 }
 
-static int do_detach(int idx, const char *name)
+static int do_detach(int ifindex, const char *ifname, const char *app_name)
 {
-	int err;
+	LIBBPF_OPTS(bpf_xdp_attach_opts, opts);
+	struct bpf_prog_info prog_info = {};
+	char prog_name[BPF_OBJ_NAME_LEN];
+	__u32 info_len, curr_prog_id;
+	int prog_fd;
+	int err = 1;
+
+	if (bpf_xdp_query_id(ifindex, xdp_flags, &curr_prog_id)) {
+		printf("ERROR: bpf_xdp_query_id failed (%s)\n",
+		       strerror(errno));
+		return err;
+	}
 
-	err = bpf_xdp_detach(idx, xdp_flags, NULL);
-	if (err < 0)
-		printf("ERROR: failed to detach program from %s\n", name);
+	if (!curr_prog_id) {
+		printf("ERROR: flags(0x%x) xdp prog is not attached to %s\n",
+		       xdp_flags, ifname);
+		return err;
+	}
 
+	info_len = sizeof(prog_info);
+	prog_fd = bpf_prog_get_fd_by_id(curr_prog_id);
+	if (prog_fd < 0) {
+		printf("ERROR: bpf_prog_get_fd_by_id failed (%s)\n",
+		       strerror(errno));
+		return errno;
+	}
+
+	err = bpf_obj_get_info_by_fd(prog_fd, &prog_info, &info_len);
+	if (err) {
+		printf("ERROR: bpf_obj_get_info_by_fd failed (%s)\n",
+		       strerror(errno));
+		goto close_out;
+	}
+	snprintf(prog_name, sizeof(prog_name), "%s_prog", app_name);
+	prog_name[BPF_OBJ_NAME_LEN - 1] = '\0';
+
+	if (strcmp(prog_info.name, prog_name)) {
+		printf("ERROR: %s isn't attached to %s\n", app_name, ifname);
+		err = 1;
+		goto close_out;
+	}
+
+	opts.old_prog_fd = prog_fd;
+	err = bpf_xdp_detach(ifindex, xdp_flags, &opts);
+	if (err < 0)
+		printf("ERROR: failed to detach program from %s (%s)\n",
+		       ifname, strerror(errno));
 	/* TODO: Remember to cleanup map, when adding use of shared map
 	 *  bpf_map_delete_elem((map_fd, &idx);
 	 */
+close_out:
+	close(prog_fd);
 	return err;
 }
 
@@ -169,7 +212,7 @@ int main(int argc, char **argv)
 			return 1;
 		}
 		if (!attach) {
-			err = do_detach(idx, argv[i]);
+			err = do_detach(idx, argv[i], prog_name);
 			if (err)
 				ret = err;
 		} else {
-- 
2.17.1


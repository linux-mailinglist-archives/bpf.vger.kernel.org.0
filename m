Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A4E5B4EF0
	for <lists+bpf@lfdr.de>; Sun, 11 Sep 2022 15:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiIKNGH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Sep 2022 09:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiIKNGH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Sep 2022 09:06:07 -0400
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF11252B8;
        Sun, 11 Sep 2022 06:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1662901557;
        bh=isS2ysJweAKK83d4hIdupBj3xtoj8eHTEYjA8Ve6cBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VK6TEMU1CyJXCyPg+CUSLWtgsPSRnse7BCQCKeykuoivqnkQ4n9Ez6308+E8ZKmWp
         r0HgyZhaa3WZusvGyiQYQatGy6inkvzrEpsU4EYJV02Fh/SWlaGaJ83TjVkxtUW3hv
         6tWcNgfVloD/5WGDtggWfPKL4WSGX0Zotn+QtbiE=
Received: from localhost.localdomain ([111.199.187.40])
        by newxmesmtplogicsvrsza7.qq.com (NewEsmtp) with SMTP
        id 11F112D1; Sun, 11 Sep 2022 21:04:31 +0800
X-QQ-mid: xmsmtpt1662901471tmdm7m3bc
Message-ID: <tencent_1CC476835C219FACD84B6715F0D785517E07@qq.com>
X-QQ-XMAILINFO: Mwn5KFNmdVcm0DwdYrEhaFSfzpCJDZWVLZRdlnv09PRRkcONdL/+d7mQczy8iu
         r8JxbLGsvOC6Eew/ELcKs4xdnS0ROy0HZ+X5J6N50inmCyXyC02dQF4wVZbb1oVeWvdK5M25tvzA
         /MtUva7WV6NX0Vwz/ig0PZB3OtubgQJfwbrbaPtNTZXKaGwZf1ExuYZACeuTxVRATvOOUhjCO44B
         WhtHHIfhk3e56sgTWxIdpkray1acyZf4pmgBcu6fGmt6YQ4vXvdWPs3FNJ/gR/W6m+LPyB6y8jb2
         uBHQdwSYPYZVGFCheaIz26HIUNB+B1C/H+Wt8B9EwcIAV5E0XxGrGeuB4zDtQEnKbEjhXedZ6Iy6
         4FDZdYKhbvPd+Wj4znwCpH4lCZipK6hJ8WnD+7nKqdMuSsmRUPjZ39td8xji/Lul/rpZ3ubqpJ/w
         eUy+GHTrSITbES+mOQmA1yO11DdhKUK0M3Ky49Koe/aDEMWsskFPYcu1tviqGp1a6DQmMmIAS5Lx
         H1BM29RCIR9CQPLKP/IJ/iAeBfeimJyj6L4haybOn4w+DR7EuaFMnzbXTizyrl1jTQUTkskslqfR
         XjW63uPeImHESajK7QPPv4cxRwj9qHB764pMBOfTcVhamPx+vQpfijeYtNT/UJrDX9+n7TwxqTMs
         6WPEXovEU/jzh/0rJp421xaKHPMMevkb6Hobx2BjI/Ld5F7wbARYaVaaYcr6JolfCD/rX8PVK6wp
         nEbe4YHDkHtycFobq9jkscvGo+N97gPxnI42AQyR4xpgp2LrrwGjmm4QPma+mxo41Vpea9yKCaHL
         lma9lHxtj5vGfUEAC58uuBW29sJZHH7wGOZHhg2NgmDoIu1YXbjunWZEUjyE9PmIEJulXKv9en3u
         jXkm2OOxHcCA1CT7wtDiYSGSXSUkhg7qHET8WLwpcHbSt3TzQvnV5/1w5PXIzcRPHWJupEV44PVr
         TA1LEjsEfW+KH8UBYwdfHcrBy8lp9q
From:   Rong Tao <rtoax@foxmail.com>
To:     sdf@google.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, rongtao@cestc.cn, rtoax@foxmail.com,
        song@kernel.org, yhs@fb.com
Subject: [PATCH bpf-next] samples/bpf: Replace blk_account_io_done() with __blk_account_io_done()
Date:   Sun, 11 Sep 2022 21:03:30 +0800
X-OQ-MSGID: <20220911130330.9595-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <YxtuR6hWUkGfiWya@google.com>
References: <YxtuR6hWUkGfiWya@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

Since commit be6bfe36db17 ("block: inline hot paths of blk_account_io_*()")
blk_account_io_*() become inline functions.

Signed-off-by: Rong Tao <rtoax@foxmail.com>
---
 samples/bpf/task_fd_query_kern.c | 2 +-
 samples/bpf/task_fd_query_user.c | 2 +-
 samples/bpf/tracex3_kern.c       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/samples/bpf/task_fd_query_kern.c b/samples/bpf/task_fd_query_kern.c
index c821294e1774..186ac0a79c0a 100644
--- a/samples/bpf/task_fd_query_kern.c
+++ b/samples/bpf/task_fd_query_kern.c
@@ -10,7 +10,7 @@ int bpf_prog1(struct pt_regs *ctx)
 	return 0;
 }
 
-SEC("kretprobe/blk_account_io_done")
+SEC("kretprobe/__blk_account_io_done")
 int bpf_prog2(struct pt_regs *ctx)
 {
 	return 0;
diff --git a/samples/bpf/task_fd_query_user.c b/samples/bpf/task_fd_query_user.c
index 424718c0872c..a33d74bd3a4b 100644
--- a/samples/bpf/task_fd_query_user.c
+++ b/samples/bpf/task_fd_query_user.c
@@ -348,7 +348,7 @@ int main(int argc, char **argv)
 	/* test two functions in the corresponding *_kern.c file */
 	CHECK_AND_RET(test_debug_fs_kprobe(0, "blk_mq_start_request",
 					   BPF_FD_TYPE_KPROBE));
-	CHECK_AND_RET(test_debug_fs_kprobe(1, "blk_account_io_done",
+	CHECK_AND_RET(test_debug_fs_kprobe(1, "__blk_account_io_done",
 					   BPF_FD_TYPE_KRETPROBE));
 
 	/* test nondebug fs kprobe */
diff --git a/samples/bpf/tracex3_kern.c b/samples/bpf/tracex3_kern.c
index 710a4410b2fb..bde6591cb20c 100644
--- a/samples/bpf/tracex3_kern.c
+++ b/samples/bpf/tracex3_kern.c
@@ -49,7 +49,7 @@ struct {
 	__uint(max_entries, SLOTS);
 } lat_map SEC(".maps");
 
-SEC("kprobe/blk_account_io_done")
+SEC("kprobe/__blk_account_io_done")
 int bpf_prog2(struct pt_regs *ctx)
 {
 	long rq = PT_REGS_PARM1(ctx);
-- 
2.31.1


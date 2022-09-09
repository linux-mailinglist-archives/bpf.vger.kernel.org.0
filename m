Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BBE5B3151
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 10:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiIIIFG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 04:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiIIIFF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 04:05:05 -0400
X-Greylist: delayed 630 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 09 Sep 2022 01:04:58 PDT
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4F96172D
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 01:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1662710695;
        bh=isS2ysJweAKK83d4hIdupBj3xtoj8eHTEYjA8Ve6cBk=;
        h=From:To:Cc:Subject:Date;
        b=I3gwmOBCC42hLCrWaiO75X+riU/PBXyOFDFxOSMMwXq3b2JrcOQFHn4AXlCnWK9kO
         TM8fbwv4bScyFNdzAjAyzyZWGCV8cZNIwp0mWGZGe3sR0lgMu+8sKKc0Ba2JEejdFY
         QP+eO2ckuPoFDZlVvW0+GuCn22aJnvVvvSHwBVVM=
Received: from localhost.localdomain ([39.156.73.13])
        by newxmesmtplogicsvrszc10.qq.com (NewEsmtp) with SMTP
        id 1321D2DC; Fri, 09 Sep 2022 16:04:50 +0800
X-QQ-mid: xmsmtpt1662710690tgufuuhro
Message-ID: <tencent_6715F3D7DF513D441A835321FAACFFCB0907@qq.com>
X-QQ-XMAILINFO: MEi03zLH2FNOfwBidlbYsdG1dX0+QNukXPTg8smHnKYSTpAvmGjAdeoJPrNOLk
         Hr57kpKtKcHYyhfXH9lnzkpBX3posdX/2ekDeCIyj2g2Xplma1vNb6L7DZOztz6pN6VVZDQ+PveA
         4FTQlw6IpYpgV1B//6WXe1OYm6sCIMbSVPNsppfMcGCCKHm2fvdX7bB815h0X0OQzLZrg6ztjjI1
         DeraHMD2iZoDZyYo/zHbzKoTBj4ooy5Ovk3+VIUHyGqQVKxIlB03moNgAFZtggLH+NKXd6Dkf0DQ
         GUxJ1VAhsGgN9hHJ61XwYxQ6OIx4nSSQEXR0U2ItoQHT/VuD7GqgGW6YuWjQidwW/tCyGGNZ+KaK
         ajLCdWaE08Lhd/Mt37YCSki1aM4G4MCRdVc1cKlNNN/woZuHe2NzNCYVsFqrnG3JTf98YdU9vE7c
         WMxeAwnTXsb4O8F7EyegrCd9fRZ5cjxoG2ZOcT3Fu0Gf/1YIUEahAELyBuy7eKLjT3FuIJS03CIG
         8xbeFXZG5ajP8CL5PRs9XHMVImIe+dQM76yD4myt12TbA8UgyQiABZYsNgXpZPIFTDbdzDnJuxpT
         A+mke/gLgJ+ThzfFwoLKu6xL3aRZ3ZYjloneJpU3VXeeDQGEb0ZCaSIITH5rn+vI7rsxU6Mn2+8C
         lrEthOVXQsxFI3sSUBUr3EQxJuqiHVf0iOv6mUR1wW3dhKBVP0S0py2THyybX1AL/bYbN3BdAQLp
         25BO8xYV7C3RUYqjJZ9dy2b87LpNIbeEXVEue+W1rErtDKzydVICl7SOagVRg0kMel/NHJrAy5os
         RaxWk+VP5+XJU3W8mGcn4l7EPbza+Ow9vD6j/PtMktmZ4LYoJSGnzyRFphBtv2VpVz6Mi+B9fxYA
         SQv3oc4Xrd6aKMYf1VzRaeKktsZD0bBQ9dLh3EPg23i9yNbe3TP7aDJKhfBqGF1/krZgLI8Zi/Ym
         sAyQ08GP1G1d1Q0/a/D+m2DM0Xx1Qfbsl8rvNfMs0j+SPrBFOlOHm4x2ORR6WzTNb/GibrDI0NcQ
         vEcQfwMzqdRDqZM19b6ra1TWdY6y8Ypsw/78jPVQ==
From:   Rong Tao <rtoax@foxmail.com>
To:     bpf@vger.kernel.org
Cc:     Rong Tao <rongtao@cestc.cn>, Rong Tao <rtoax@foxmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf RESEND] samples/bpf: Replace blk_account_io_done() with __blk_account_io_done()
Date:   Fri,  9 Sep 2022 16:04:48 +0800
X-OQ-MSGID: <20220909080448.7728-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.31.1
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


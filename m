Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEF96121B0
	for <lists+bpf@lfdr.de>; Sat, 29 Oct 2022 11:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiJ2JLX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 29 Oct 2022 05:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiJ2JLW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 29 Oct 2022 05:11:22 -0400
Received: from out203-205-251-53.mail.qq.com (out203-205-251-53.mail.qq.com [203.205.251.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C021722BA;
        Sat, 29 Oct 2022 02:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1667034678;
        bh=fNynhBfsJSrVgxBStXqjE0ZsAFTRZO0C+KgRTcOOYzg=;
        h=From:To:Cc:Subject:Date;
        b=jvGea3SPzbqSHnnciehNxChg5qnB1B1mKggpUlsA4aMm0+Y+5r0NbXwRWJM6Q5nsV
         aWWW7ddau6EGAHCn5fCaM837tjU7Mj4JtH0BBrAlYrnGz1ItCF4ZJaLnbxCsfbcc+3
         WeNXrudqTsjSNWYtBVR1Elsn5q2Ff695Ai6DM46w=
Received: from localhost.localdomain ([111.199.189.86])
        by newxmesmtplogicsvrszc1-0.qq.com (NewEsmtp) with SMTP
        id 2CF31E82; Sat, 29 Oct 2022 17:11:15 +0800
X-QQ-mid: xmsmtpt1667034675tchmb4gsx
Message-ID: <tencent_0F0DAE84C0B3C42E0B550E5E9F47A9114D09@qq.com>
X-QQ-XMAILINFO: NC/J3CrDtaBb96H+BrL5KREHlHPKeuVYn+vbaEYhifPlYSliv3Bq0HJfjAFmRZ
         yyNtt4LOCsexUOzTzo18crotok5B7vl1+UR/PW3M+qP0eXvQPgtbBfRFjUEweukDwS0yIW/t6Oa5
         h9WqnN79EwDrxH653in/HqouOz2gT5nHDVb3Kxsezvitgw+/aB8zCQ9t7WsjAVQ5mv4qclp/Upnf
         z9SU0avAacg0OZ27cbNB6Gpf+irMx6wKmHbJYLX8y1OCHzU2wDj1J3Yd3JykRr/aOM400zLrtNZ/
         6zNbBmDHFEnwT3B8p3J1CSZVlG16BXQPcWw5f/jQnPxYunhsMCVjD1RiJw5bcQ1fSvZr0OQEhk5p
         3Dzo7K7lJV8HdtFNRHYJqD1BEz+/gJ6O+PczhVsTwFLoNP9onBKMhcJUJebdwdTKy8u/YE/uGQ20
         6C2aSpcwsNcDlJ7nl2OnNfQpS0kV42sv8g1oflJQ/6fzh5s3fbSVLMJnKuDPoqIpJghAVtMA/E0R
         m4g9vnbIsnxmQsa0WJcpeKHubzL690pPfgHoBksGK8PGpU+pogJhjWgsQ5HZoSRglNMDssdximOD
         kMPzY6R0DP6AavZxzddnCCgPz3s4IxPvfCXjPJxQdjAfcKANvvLu/wGgVA920P7chys9asB9zS8X
         h0MtJldGYGBFa+yd/GZLihXGKMUShFKc4kreLMhPvT4F5rsgTan+0e0VEariW38Gwc/xHLzGYyl7
         nexV/cv5qsAAAMYB5Bfb3YHaL0m4SIp16iyTEviFAfq56I42EN8XROG4j5is/Mh9Uy0zvp25+NWu
         1nINFdg7NpRKLdQAOCYE81RnnHqtM8taZDC16haP/ohw8hJxb6Q9omW++FKRBs2G5EH3hvEqWY31
         HG5Y7RELroHj4RHcppUFtgeetIM6rjLptAxzLpgr1GXZaoXVg37rqR080Z4HmEuywm0ulGlHmd91
         isHBniDi9jH9qZl+KWjQl9Yrf+S07keIW3DxbmCQ3bFr6wDehb6g==
From:   Rong Tao <rtoax@foxmail.com>
Cc:     Rong Tao <rongtao@cestc.cn>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and
        Tools)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf-next] samples/bpf: Fix tracex2 error: No such file or directory
Date:   Sat, 29 Oct 2022 17:11:13 +0800
X-OQ-MSGID: <20221029091113.62518-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

since commit c504e5c2f964("net: skb: introduce kfree_skb_reason()")
kfree_skb() is replaced by kfree_skb_reason() and kfree_skb() is set to
the inline function. So, we replace kprobe/kfree_skb with
kprobe/kfree_skb_reason to solve the tracex2 error.

 $ cd samples/bpf
 $ sudo ./tracex2
 libbpf: prog 'bpf_prog2': failed to create kprobe 'kfree_skb+0x0' perf event: No such file or directory
 ERROR: bpf_program__attach failed

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 samples/bpf/tracex2_kern.c | 4 ++--
 samples/bpf/tracex2_user.c | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/samples/bpf/tracex2_kern.c b/samples/bpf/tracex2_kern.c
index 5bc696bac27d..93e0b7680b4f 100644
--- a/samples/bpf/tracex2_kern.c
+++ b/samples/bpf/tracex2_kern.c
@@ -22,14 +22,14 @@ struct {
 /* kprobe is NOT a stable ABI. If kernel internals change this bpf+kprobe
  * example will no longer be meaningful
  */
-SEC("kprobe/kfree_skb")
+SEC("kprobe/kfree_skb_reason")
 int bpf_prog2(struct pt_regs *ctx)
 {
 	long loc = 0;
 	long init_val = 1;
 	long *value;
 
-	/* read ip of kfree_skb caller.
+	/* read ip of kfree_skb_reason caller.
 	 * non-portable version of __builtin_return_address(0)
 	 */
 	BPF_KPROBE_READ_RET_IP(loc, ctx);
diff --git a/samples/bpf/tracex2_user.c b/samples/bpf/tracex2_user.c
index dd6205c6b6a7..089e408abd7a 100644
--- a/samples/bpf/tracex2_user.c
+++ b/samples/bpf/tracex2_user.c
@@ -146,7 +146,8 @@ int main(int ac, char **argv)
 	signal(SIGINT, int_exit);
 	signal(SIGTERM, int_exit);
 
-	/* start 'ping' in the background to have some kfree_skb events */
+	/* start 'ping' in the background to have some kfree_skb_reason
+	 * events */
 	f = popen("ping -4 -c5 localhost", "r");
 	(void) f;
 
-- 
2.31.1


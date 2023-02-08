Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C2E68E538
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 02:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjBHBE5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Feb 2023 20:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjBHBEz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 20:04:55 -0500
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9BD41B42;
        Tue,  7 Feb 2023 17:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1675818287;
        bh=MRkcAp8pK4ymQc/nbRQALjF++AadPUnkWCIikb162cI=;
        h=From:To:Cc:Subject:Date;
        b=wQcpnKt9EuQQ5G40ezY+6ys1GAVsIys5ZymYickcV6VasefXIDzPMVwibsZS0dHZj
         qJiWDu2bbAnFf6HLyfBf6XRS6apGTzDqXIEA1mi+udSg7F1Q0kyxk7FrfcIDQkRtvP
         XK1tilefRpdLS2zhX8oNfb2VKrdOnX9N7VLmJFek=
Received: from localhost.localdomain ([39.156.73.13])
        by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
        id 12AA8441; Wed, 08 Feb 2023 09:04:42 +0800
X-QQ-mid: xmsmtpt1675818282tp3nlfsja
Message-ID: <tencent_9381CB1A158ED7ADD12C4406034E21A3AC07@qq.com>
X-QQ-XMAILINFO: Ms5xyImz3IR/e0Dwb1Dh6ob1kjp5CuRAYCq9BNwXrom+fq+rq6UkZhv5F0Ltr8
         SjF0hCfCZeU86tGgDEi2/PXtiM0xy9kAPFq11AfiT6mT/2qoBb1uGSZBJYH/Tk3rHZOJ7aF9mIqF
         BT8i7rGBHpPlnjOVVT/YbPHDNIn3Swyis+tKtIYbVHj9ltSTLg6pVwVJ8nbfd2AQXYFMY3s1qF1x
         BLkgq9wKHgn54vfTtgDt+DELrqv41Tp65q354lFMdyxspllTw7rQYpME7LQWbRBuXkIntGNwg03F
         2mW+jRkJUsUCatNlKs4w0rW4bW4sj7litzo9LAwyRh0MQShb3sQtOq2pBR4MBzt+ZVZQ7VVvWfzQ
         IGEvUFevYsXeMfgdS0ZCHuPjvnKpoydpSAf1Cr8MZd2FPrJqrxErWaYwlPvEZ+nuVkdxbO3LWB5J
         0uSLLBVI2pUBZv1UFpwr9pmJPBsxovsUfL161BDXogfhjdDoT7d2FzCphz14PKmlWAZshHUxJwwO
         1Ni3ldbZegCCtMmg1HgsgNaFi+UCy6tAY3uNxxIr6GschkksCxnSR2eEzjUnx8F41890CwEmyqO9
         4O7ZmhoLeDYJ35e4pz8SJypX8Q2d85YTFPvwlbiAQOWpq3uUMvgsWT7Ku9F4d7HIcgpwIFyyzidB
         J2qBtBlRup6WLHgTa+WgVL9kwo9aEgy8oubu/8XIvrz/1/I7C/I8T6RFSwmGos55jR3NrnC/lr0S
         WIO1qPzFhedOGL6XbPTxFSYqClFDPq0jqD/8AKxItWUlvYdeRcEf+qo9ikg2ecVUZU1wYIbA//7t
         Qm1zLFFVTPoQva3oVzcUVUSSD+nTOwqsMN6BrC4hBHflNlQldIr0oCWjR8KfM2KH5DCZqenU35xa
         XX6DVTzoknVxzP9pKw5nMnFtuFHh9p6krEJZsqAvthO8ykErmMYo9eCVhBHupoEVsHVFxfO44yOo
         s7/sBFJy9yAwd0M8rUf69ijr/pZs4gijvuewLri/A=
From:   Rong Tao <rtoax@foxmail.com>
To:     ast@kernel.org
Cc:     Rong Tao <rongtao@cestc.cn>,
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
Subject: [PATCH bpf-next v2] samples: bpf: syscall_tp: Add syscall openat2 enter/exit tracepoint
Date:   Wed,  8 Feb 2023 09:04:41 +0800
X-OQ-MSGID: <20230208010441.72447-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

commit fe3300897cbf("samples: bpf: fix syscall_tp due to unused syscall")
add openat() syscall trapoints, this submit support openat2().

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
v2: Add 'bpf-next' in Subject
v1: https://lore.kernel.org/lkml/tencent_FB3E886D062242FF59A997492A3BAF2BA308@qq.com/
---
 samples/bpf/syscall_tp_kern.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/samples/bpf/syscall_tp_kern.c b/samples/bpf/syscall_tp_kern.c
index 50231c2eff9c..e7121dd1ee37 100644
--- a/samples/bpf/syscall_tp_kern.c
+++ b/samples/bpf/syscall_tp_kern.c
@@ -58,6 +58,13 @@ int trace_enter_open_at(struct syscalls_enter_open_args *ctx)
 	return 0;
 }
 
+SEC("tracepoint/syscalls/sys_enter_openat2")
+int trace_enter_open_at2(struct syscalls_enter_open_args *ctx)
+{
+	count(&enter_open_map);
+	return 0;
+}
+
 SEC("tracepoint/syscalls/sys_exit_open")
 int trace_enter_exit(struct syscalls_exit_open_args *ctx)
 {
@@ -71,3 +78,10 @@ int trace_enter_exit_at(struct syscalls_exit_open_args *ctx)
 	count(&exit_open_map);
 	return 0;
 }
+
+SEC("tracepoint/syscalls/sys_exit_openat2")
+int trace_enter_exit_at2(struct syscalls_exit_open_args *ctx)
+{
+	count(&exit_open_map);
+	return 0;
+}
-- 
2.39.1


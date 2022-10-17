Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BB160110C
	for <lists+bpf@lfdr.de>; Mon, 17 Oct 2022 16:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiJQOXq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 10:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiJQOXZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 10:23:25 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9796765552;
        Mon, 17 Oct 2022 07:23:21 -0700 (PDT)
X-QQ-mid: bizesmtp86t1666016591tv8rwp4e
Received: from localhost.localdomain ( [182.148.15.91])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 17 Oct 2022 22:23:04 +0800 (CST)
X-QQ-SSF: 01000000002000C0D000B00A0000000
X-QQ-FEAT: F7g8sXqc8jLzsKJQOSoefmgIf+AB2IWispWu68gD4oysOX21IN0naGvyiCmM5
        6776pyBdH/FLzpNlB3RApAuwFXjhv56S+PJMEre8y7AoIsJgW4NMeNPLxYt/7eiq9M8gOKu
        QojMYI0txjtzNVRytXEy6g5/++MfT1vHmT3cGVY219vapgiK+1pgSjilMFMDNuRPNz4xTzL
        8KaXJHmY4An8VBPYl0Ox2GZB2T/hY6kJrhFeaag4oAOUo4O3UBCNXzkBhEOseLMEFJ9LCNR
        vH1rZSh/wu0aMGkEYU/nHvOf2AiZjmvnRWpfK5jGEvjIxxV/nOXseFhEu0EMlzytJQJ5w7B
        L5nFUKyo225B0vry8FmHEYj057igy/L6u0APc5CCH72p4cly1/dNg0Hitwogw==
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org
Cc:     Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] bpf: Fix double word in comments
Date:   Mon, 17 Oct 2022 10:23:03 -0400
Message-Id: <20221017142303.8299-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Remove the repeated word "by" in comments.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 samples/bpf/hbm_edt_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/hbm_edt_kern.c b/samples/bpf/hbm_edt_kern.c
index a65b677acdb0..6294f1d716c0 100644
--- a/samples/bpf/hbm_edt_kern.c
+++ b/samples/bpf/hbm_edt_kern.c
@@ -35,7 +35,7 @@
  *
  * If the credit is below the drop threshold, the packet is dropped. If it
  * is a TCP packet, then it also calls tcp_cwr since packets dropped by
- * by a cgroup skb BPF program do not automatically trigger a call to
+ * a cgroup skb BPF program do not automatically trigger a call to
  * tcp_cwr in the current kernel code.
  *
  * This BPF program actually uses 2 drop thresholds, one threshold
-- 
2.35.1


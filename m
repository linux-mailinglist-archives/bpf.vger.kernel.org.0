Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCC46AAAAA
	for <lists+bpf@lfdr.de>; Sat,  4 Mar 2023 16:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjCDPRW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Mar 2023 10:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCDPRU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Mar 2023 10:17:20 -0500
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E89193C9;
        Sat,  4 Mar 2023 07:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1677943030;
        bh=JMsbf9ZLix9AyM9weiwmLnsF41GTRmpxn6DPPSd8Woc=;
        h=From:To:Cc:Subject:Date;
        b=ptOP/3aiE5zJUne5IEIyt6/hXxzHQFi6JFHox5FJQEE2W9vjeI2fnws7OrPor7Mff
         oU90l4HRFPIW+kcyLL01dEybFmnLalPzATjMeY7v3qpPV3J0xgAsZGi3HLpvCOLpi2
         NXaren0BQXcw+bYuw5i2pWe228s6bt6Uh60Axte8=
Received: from rtoax.. ([111.199.184.38])
        by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
        id 44688C97; Sat, 04 Mar 2023 23:17:06 +0800
X-QQ-mid: xmsmtpt1677943026tzcaa8zm1
Message-ID: <tencent_F13D670D5D7AA9C4BD868D3220921AAC090A@qq.com>
X-QQ-XMAILINFO: NPS3ZrBWpSdg7stIkAWTf3qvZfsVgB13jKoWTFhlRIl5gTi1BUmHtGmEGYMMXs
         wLuFl9mB+wbToQPARpc0zrPSPPN3EF9V+cJAJaspwoCMW6z3WpF30CO/axblthPFUrSo/qIx11hs
         Df1BfZIim4PRMZyFVSTq/o7paxBFqVzBjw9RovF7RTGLIcNM/WTdkP1UzVbPLflinmptDAxYBL9n
         UO/8LV2ph20WSX3frwzfo5nlFV/EwBeV61DISyXIIDlIeftWbeyJkAx2oAOt7CB7LR3BsIufZHfv
         HhaPjs+RhtYFRMfD6KCTlze28jPG2BcXGCBV2Hg/xYJqlRM6DxCzaTRX3CyQBCXIC3UIduBeeX2B
         Ci6Wyht8W4yZ4kmh0V39GlfkxjeZ58OUQyutCU6K8JEVRMCCPo/gjx8hmmz174ICYzBPGGL7W5Xw
         HyZWhA2ijEih3L7mj7kGwWCh3i9teswZDEzSKK4Wl3TR8/VvE/grTK9wK3IASYeGyiWf6lH45+1p
         9MloywEuqkKe7TQ0mSb+09nqdwDhwLmqpHXUcO2Dt658By2ZJrXn+SFbsMlXmSgM4TrJTpkAdBJS
         CQdCLKacuUkhwwiygTALiVEog4uYbpkYO34JiFNNW44XSDlBqZFVO1G0y7IGsFZy/V4evwadv/Oa
         GeCSsfQ1kXnQ1brbLIwN9vjHvuYMsX8xlurR4RDH8yGkqlLmenttwd67j5ibadOioQaxvD5jFHvI
         B7OatdtTOTGXEXY2iKoF9Xto8Jgq7ZCPb+oB3XH6JsLDGbBratji1ZhPhAWTyjpRYCP9gxuKeJhT
         D9WFUltfTPd60itxYJOw13EZ7X40wluQ4IeftMbreLBTx9RjhvXUu3i7iU/Wk1FsdgvvW6X/5mb1
         GRpY21xV229ekElG9tjKZVcNmlnhuW720tATCgQmmP6ChsGkuUGOd4/saMs/BGsZrPrkyJWxgKXa
         6+zOMV7rESiR5+p82RVNv5SerMxrJo3VQNTP3nQsg=
From:   Rong Tao <rtoax@foxmail.com>
To:     rongtao@cestc.cn, ast@kernel.org
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and
        Tools)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf-next] tools/resolve_btfids: Add /libsubcmd to .gitignore
Date:   Sat,  4 Mar 2023 23:17:04 +0800
X-OQ-MSGID: <20230304151705.416627-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.2
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

After compiling the kernel:

    # bpf-next...bpf-next/master
    ?? tools/bpf/resolve_btfids/libsubcmd/

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/bpf/resolve_btfids/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/resolve_btfids/.gitignore b/tools/bpf/resolve_btfids/.gitignore
index 16913fffc985..52d5e9721d92 100644
--- a/tools/bpf/resolve_btfids/.gitignore
+++ b/tools/bpf/resolve_btfids/.gitignore
@@ -1,3 +1,4 @@
 /fixdep
 /resolve_btfids
 /libbpf/
+/libsubcmd/
-- 
2.39.2


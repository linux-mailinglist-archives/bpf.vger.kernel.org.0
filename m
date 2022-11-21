Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B40632508
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 15:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiKUOGN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 09:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiKUOFr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 09:05:47 -0500
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA07140C3
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 06:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1669039364;
        bh=bn5ka49hAzqtQFFXjHtkHtPJpqlVkHmbnMnYIoTX4yA=;
        h=From:To:Cc:Subject:Date;
        b=Y/4JtOCxY0PP5v4pUKbFon5NbjAePU+1zqhOC3sfbhxxAxVHNWwFoAriFEviVliiQ
         Ew2dgciSlzHZd5jfnnDbAEBYqXsch2ZtBVdjENKzmYJQHpqaqEglRhjGDf3Du0daKb
         MoJ8BssB7P6byfDrRmyV2uFrP+S3B4vkoq6sfOkI=
Received: from rtoax.. ([111.199.191.46])
        by newxmesmtplogicsvrszc2-1.qq.com (NewEsmtp) with SMTP
        id A828046; Mon, 21 Nov 2022 22:02:40 +0800
X-QQ-mid: xmsmtpt1669039360t57sjgdme
Message-ID: <tencent_C597352AB3AF24A35A88CC06A3421E590B08@qq.com>
X-QQ-XMAILINFO: MyIXMys/8kCtwFWBpoUX2Wahw3uwiRwEHkyhHuf+mnfOrjsqEs2AH751oanacY
         gE64ckivM/i3VrzshP/rzhwvUT4YSY7DbNCQwL9ICpHySiH+9nHdnZFpfHQv2T6uNL3Q9OFIcUet
         viybl6f/uTYoB7zvqty+/UfVbHxnURnB3fsTdo7Iz4/I4ljNmbIYHNAPWND3gXuamosPe8Idlr6e
         q4C/xqD0p3uMd3bIa4FsMbPtpfyuZbUc/wQeQ7s9KBZJNAc27cTaLdaauZi/vtKLbegWl/uU+aQS
         yOcR9MkYQiFr2htcZDxFflHwEFpBfr7iUY1M5FQZ47l15iQKxuhjmObrYFC+p0Jc7dpdGYo30jMy
         e5UymjKrjsGQrpxyRYBCqHkTxM2pOnJocsXAufNR3zq292aNnyagxXfC5kNFHIoursNgPZatlfsC
         XpFbdiP+jhUINg288ydBO7mMZAvmViQs9dHFDtKt8+VmbZPcVxmE3yl8xsohVJFIwrS/IeryvyPz
         ya4yvGeKEgWfHpZq7Se6CS5utMcNX7pR64R4yvzmNEekh9bvJ8NGP+ZGcKgpcLipez8w3U6JFVRy
         5zyToMH+/0yXNGWRXJFeiO0u43pbYin2yjgT0/xHBLXZVPau4sjA85oNzo2dHNTNP/CdryntkKo7
         k+h3wZtVdDsVh+VxS+KQd0z1UCeUb1L90V6AhJEL/La9Lctj2LICgFeFvnaU30l7hdaPjHAzCQj4
         ZEmnn98rFISwIL68dKvUsGsHbaD8D74ke/V4W4t+SLHsh3H63i/tpCQhn5COU0/hGuBWW4rvLRsm
         1OZvROJY7QTd28Cz5leHq4f9Mrbarm23NPfSjVOncXwEIdyhieS0ed+TsM4vVKLeQXabKOcx/Gy8
         /O9eW57iHwXpVEuOGGtBmgUXY9B7dmXsiYD3ZXCxdeytmg5yqBdI0n00NSUkgYls8rGTJEfbHN4P
         E/QRNEytUI/4qZTHc+J3CkUFNFhaksq5fS4/8Ty+zeOpv22WTU+W6mwIt45kOyhUD1uwW09rGZzR
         jyipb/AtOFPRIr/YCXaQUyRmiXKVk=
From:   Rong Tao <rtoax@foxmail.com>
To:     void@manifault.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        corbet@lwn.net, daniel@iogearbox.net, haoluo@google.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, rongtao@cestc.cn, rtoax@foxmail.com,
        sdf@google.com, song@kernel.org, yhs@fb.com
Subject: [PATCH bpf-next v3] docs/bpf: Update btf selftests program and add link
Date:   Mon, 21 Nov 2022 22:02:39 +0800
X-OQ-MSGID: <20221121140239.16469-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

commit c64779e24e88("selftests/bpf: Merge most of test_btf into
test_progs") rename selftests/bpf btf test from 'test_btf.c' to
'prog_tests/btf.c'.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
v3: v2 -> v3
    s/Kernel bpf selftest/The kernel BPF selftest
    s/provides extensive/provides an extensive
v2: https://lore.kernel.org/lkml/tencent_114656E8259D0AEA2BDB6810E29241995006@qq.com/
v1: https://lore.kernel.org/lkml/tencent_7F84D04F96EBE594CAD5EBD12815A2B00106@qq.com/
---
 Documentation/bpf/btf.rst | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index cf8722f96090..681416c86e81 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -1062,4 +1062,9 @@ format.::
 7. Testing
 ==========
 
-Kernel bpf selftest `test_btf.c` provides extensive set of BTF-related tests.
+The kernel bpf selftest `tools/testing/selftests/bpf/prog_tests/btf.c`_
+provides an extensive set of BTF-related tests.
+
+.. Links
+.. _tools/testing/selftests/bpf/prog_tests/btf.c:
+   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/testing/selftests/bpf/prog_tests/btf.c
-- 
2.38.1


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D6C63319D
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 01:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiKVAuz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 19:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiKVAuy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 19:50:54 -0500
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAEA6D961
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 16:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1669078249;
        bh=r7bV6NQJ0Wvg7aEH2rmGraNpQaJqHjO8I3T/UZsCtQ0=;
        h=From:To:Cc:Subject:Date;
        b=KVhhElW2KkbyuGg9cMxGeRqhum4PUlhQQHt5S4GwshJzOO6MqYIr9uSCDtZ2AymtK
         EO3pC/QkdBoHMMHdBhkZIrpeqYPDtp2d3f4g2DoA9nc6vGcWcJJUcntAYibBO452lE
         kkm9obY7CEE4XkfEhjYPk5uS1YEh/QVnNPFUSBUM=
Received: from rtoax.. ([111.199.191.46])
        by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
        id CAB98EC2; Tue, 22 Nov 2022 08:50:43 +0800
X-QQ-mid: xmsmtpt1669078243t4jp9xxjs
Message-ID: <tencent_1FA6904156E8E599CAE4ABDBE80F22830106@qq.com>
X-QQ-XMAILINFO: N+tZcXNNUKPO2gWmkXq1HkL3q4fP8lwxYooYr02spnchOJOorAbd4TuYfw6Ls+
         s3R0erl5Efn3NAC8Y4waUl9rpw9QHbf+SUQlQ7gVlwNdHFaQbGryYdg3QjFKvN9tKUV/RslECtmE
         0Dqh1F7Z4Eu23ro5RC+eUKbR5An4KJ0d7vR4uM2A7QxYFin8qgU6eCjJaSwu/hDNdEU2VTG8TJ/u
         mY6TAckoP6bPqbcJ9eQ6uBSrT5feJmWw3UJ+01M8qWs7jqQOI2oAlQtq+Ko+spta9AbGgK/YrZDY
         0KhCRnQCq3MHWA0KgGZhQfrqtDm7P8IXo2ncbMApanqguD1NwqX69Y1kkWqeujxm1oaFeTPo5HH1
         5fWHG58CJ35E97Ekq8DAKn/DSwijk+OVUeCn110+TuVo4e44NdH3321tFS0MfNX2AaS/Q1VVTvkq
         R1AR87gp6iYZ++GjLI4GhQfztU46o5btHS5ykS4rZjnXkiDXlVYEvj1eQKzvxgdT3f107zUwmmOD
         WObyf+rPH0yaXvmux78+3PJD/Gee9J73WeBf2DrR1DOdI3RxeUCMhxt2Ms57ee6P8ACcG8OoxJqL
         rZkG+2esXe3ILkS/Xn2m6jFnrC0f+bxfMsZ7lTHfn6W4ryqBVYPwrRKk83U6I8bRSERRKY5ZmMAs
         PbSu3yYMmI1CiHtk6mvL07yfwwxQmAec4GodELENWGCFmu8inRNLcKTsGQtl+o8+1hQ0RZ0itDeF
         dVkr4s3fPNNC/6D/LCKFKq9zPtzvqY5KVGrWXz9lznjgaJXn5ybslx4lMyjwcAoDLyhL7q3EPZIy
         jDG/CO5vk3NsQdrENLzV2lVb/OUCs0mY5O4txYYfsptWWuTwa1jWOcRJbL8+TwabsK3LRfY1vDcN
         AzV3oDQLpwk84yRDouGkUrLqP5YsbIniMLPEZpXIZgrm1jdTaJZzxXJYpXlDGgh+6HLP4tW0w6nP
         JxZEn4gkcZ9lQXremnFooZ+xMgyHBP9+RnfSnL9mcS3E9/XMgZiPS4ySq4op0CaNx6XJPZ9Lk8GQ
         YrO3zoUQ==
From:   Rong Tao <rtoax@foxmail.com>
To:     void@manifault.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        corbet@lwn.net, daniel@iogearbox.net, haoluo@google.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, rongtao@cestc.cn, rtoax@foxmail.com,
        sdf@google.com, song@kernel.org, yhs@fb.com
Subject: [PATCH bpf-next v4] docs/bpf: Update btf selftests program and add link
Date:   Tue, 22 Nov 2022 08:50:42 +0800
X-OQ-MSGID: <20221122005042.4712-1-rtoax@foxmail.com>
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
v4: v3 -> v4
    s/bpf/BPF
v3: v2 -> v3
    s/Kernel bpf selftest/The kernel BPF selftest
    s/provides extensive/provides an extensive
    https://lore.kernel.org/lkml/tencent_C597352AB3AF24A35A88CC06A3421E590B08@qq.com/
v2: https://lore.kernel.org/lkml/tencent_114656E8259D0AEA2BDB6810E29241995006@qq.com/
v1: https://lore.kernel.org/lkml/tencent_7F84D04F96EBE594CAD5EBD12815A2B00106@qq.com/
---
 Documentation/bpf/btf.rst | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index cf8722f96090..7cd7c5415a99 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -1062,4 +1062,9 @@ format.::
 7. Testing
 ==========
 
-Kernel bpf selftest `test_btf.c` provides extensive set of BTF-related tests.
+The kernel BPF selftest `tools/testing/selftests/bpf/prog_tests/btf.c`_
+provides an extensive set of BTF-related tests.
+
+.. Links
+.. _tools/testing/selftests/bpf/prog_tests/btf.c:
+   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/testing/selftests/bpf/prog_tests/btf.c
-- 
2.38.1


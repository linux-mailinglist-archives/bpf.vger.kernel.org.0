Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4CC631E65
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 11:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiKUKcS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 05:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiKUKcQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 05:32:16 -0500
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BCA165B1
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 02:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1669026729;
        bh=AVLSmtrjCex5981fOssTpM+1X687TZMwrJJVa8zPf+Y=;
        h=From:To:Cc:Subject:Date;
        b=OqQTowDBTeaboWgEWX/Zf2/IstnrQwAkvnw+8FVeOsz4Sig/iOQOrGlIUXFb4Va/X
         K/j5gWkNjCoYKnzL6aesQ11m7wQBARi9O6ANMQwH/RBlZp2ewCNQhgUmdkN+mdZH+m
         5znyp8y5o+8AX/9bGWPb8tMx6OEKoDfRMyfrPvOA=
Received: from rtoax.. ([111.199.191.46])
        by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
        id 8049C694; Mon, 21 Nov 2022 18:32:04 +0800
X-QQ-mid: xmsmtpt1669026724thn6meyib
Message-ID: <tencent_114656E8259D0AEA2BDB6810E29241995006@qq.com>
X-QQ-XMAILINFO: M/NR0wiIuy70UK1COhJ4T9gM9U9PRI3VM4fIHTdcHCiNdpx3Qjq9dvfYft+4mS
         zQaoK5Q3gq+Wo5jUAnQmzG1jKTdOx6amEwSprfR/r85kLELPu0eyzkEV+wuuAmcU37edmCptwEAf
         poNmFJCr6zJalzJ+UjgaEmmeZL46lY81WfCWcN8dVCfUOlfCW9l/O8tY60Px0du0faiRqzEK5M1n
         ixbR92gVTTbDtzPb/uqB1AnJVKQn9ygT/z51rsP5q0Txb5Ck8PSLZL77onIZKijr10Ut7yib2mPw
         Zzl5EYbv5fnhZVOHYOvFuFWhIEX3rhr3uV0X+SsfnWF2BI9Rdr7dkmZo36tEGBbUdLNAtU+NActM
         gMTgG8z76iKsT/TtUI+C+anPc+g/9uRQv5l0vnsMnd/HAYhi9P5S9rV8I6gxz9w8hWdyT51ca9k4
         POojbswHfm7ephHf9BZ+Gvd7cHRARQgNgQwuiawzSHczKNojM0U82XvaQBWpwbqEz/6p50DUCOiO
         YciRZ41DYl5QrZ0St5jChBA4ntLMcsgFDUtOrJkQhrQ9TKNEYl9O8FUU/NqdCt3jmGVXNfBpAqBi
         HvjRWyXBls5/DvhiNCTBKZRnOmMCAVBq7gib3wyi0rfAmGrg3AW2fBY5rbCZ0Q0dj11RTDG8uBjY
         78Ir9W9u7W/3UW+UVl0Vp0LbrncLDh43oxkycf0gthmNUHxqHWhiYhmqzjRZZMoRgyGWD/LTn9ju
         Gp1uc+VGFcygbGYbpeKz1zUYjtkhTPRjwN396Xoym1QVy0UjQi28nY1yY0jy9A3G+jSQOxmUBsi0
         axDyb4j/DwzM8dpTIL1dv3mNMJxo23S76hJgi1y9NmBJAfnneXq5ZyexdTSQvygRbLdLtmtD87qh
         C3WgQNmfH79gUA4gKpCudvLTRFJfRScaTNvJas7qbDqhuVshSUYjSn3nNBx6gxO6N7mXUFlEuayQ
         CGVD0pBmsGaeSSL9Bo8XObu9/0Ow+/LlqedVpQD+3e82+GNWI2j0UD4rTtqeBUqxe7JdQteXnKG8
         7zoxUBVA==
From:   Rong Tao <rtoax@foxmail.com>
To:     void@manifault.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        corbet@lwn.net, daniel@iogearbox.net, haoluo@google.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, rongtao@cestc.cn, rtoax@foxmail.com,
        sdf@google.com, song@kernel.org, yhs@fb.com
Subject: [PATCH bpf-next v2] docs/bpf: Update btf selftests program and add link
Date:   Mon, 21 Nov 2022 18:32:03 +0800
X-OQ-MSGID: <20221121103203.3935-1-rtoax@foxmail.com>
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
v2: Update btf selftests program and add link
v1: https://lore.kernel.org/lkml/tencent_7F84D04F96EBE594CAD5EBD12815A2B00106@qq.com/
---
 Documentation/bpf/btf.rst | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index cf8722f96090..dca0b0e9dd35 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -1062,4 +1062,9 @@ format.::
 7. Testing
 ==========
 
-Kernel bpf selftest `test_btf.c` provides extensive set of BTF-related tests.
+Kernel bpf selftest `tools/testing/selftests/bpf/prog_tests/btf.c`_ provides
+extensive set of BTF-related tests.
+
+.. Links
+.. _tools/testing/selftests/bpf/prog_tests/btf.c:
+   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/testing/selftests/bpf/prog_tests/btf.c
-- 
2.38.1


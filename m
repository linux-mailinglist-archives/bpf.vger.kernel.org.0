Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4463B69ED4B
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 04:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjBVDKw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 22:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjBVDKb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 22:10:31 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C510226CFE;
        Tue, 21 Feb 2023 19:10:28 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Axz_+ch_VjvW4DAA--.1526S3;
        Wed, 22 Feb 2023 11:10:20 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxXL6Jh_VjEV84AA--.37896S2;
        Wed, 22 Feb 2023 11:10:01 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] docs/bpf: Fix invalid link of "Documentation/bpf/btf.rst"
Date:   Wed, 22 Feb 2023 11:10:01 +0800
Message-Id: <1677035401-3628-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8CxXL6Jh_VjEV84AA--.37896S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvdXoWrZw13Zr4xtF4kXryUAw4xWFg_yoWDurcEkF
        18GFZ3Jay8JFWrKr48CrnxCFWfurWFkF1xZ3WUtr47Gw1ay398JFZxWryYka4UZr4xury7
        KFZ7Xr93AF43tjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY
        g7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3w
        AFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK
        6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7
        xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAa
        w2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2
        jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20x
        vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s02
        6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF
        0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvE
        c7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
        v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7I
        U8hiSPUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

"Documentation/bpf/btf.rst" is linked to the following invalid web page:

https://www.kernel.org/doc/html/latest/bpf/btf.rst

The correct link should be:

https://www.kernel.org/doc/html/latest/bpf/btf.html

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 Documentation/bpf/bpf_devel_QA.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/bpf_devel_QA.rst b/Documentation/bpf/bpf_devel_QA.rst
index 03d4993..f54c328 100644
--- a/Documentation/bpf/bpf_devel_QA.rst
+++ b/Documentation/bpf/bpf_devel_QA.rst
@@ -690,6 +690,7 @@ when:
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/selftests/bpf/
 .. _Documentation/dev-tools/kselftest.rst:
    https://www.kernel.org/doc/html/latest/dev-tools/kselftest.html
-.. _Documentation/bpf/btf.rst: btf.rst
+.. _Documentation/bpf/btf.rst:
+   https://www.kernel.org/doc/html/latest/bpf/btf.html
 
 Happy BPF hacking!
-- 
2.1.0


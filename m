Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E564D6274EA
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 04:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbiKND2J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 13 Nov 2022 22:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbiKND2J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 13 Nov 2022 22:28:09 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E812DECF;
        Sun, 13 Nov 2022 19:28:07 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Dxu9jGtXFj0skGAA--.20398S3;
        Mon, 14 Nov 2022 11:28:06 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxn+DFtXFj3j0SAA--.49444S3;
        Mon, 14 Nov 2022 11:28:05 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 1/2] bpftool: Use strcmp() instead of is_prefix() to check parameters
Date:   Mon, 14 Nov 2022 11:28:03 +0800
Message-Id: <1668396484-4596-2-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1668396484-4596-1-git-send-email-yangtiezhu@loongson.cn>
References: <1668396484-4596-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8Cxn+DFtXFj3j0SAA--.49444S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvdXoWrZrW3AF1DuFWUWr1xZrWUurg_yoWktwc_WF
        ZxXrnavrZ5Jry7CFW09398uFy8Ka15X3Z7Cw4avr15AFW8Xay7Ar48Ca95Z3y5ZFyqv3Wa
        yF9xZr1fGF47CjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
        xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY
        g7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3w
        AFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK
        6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7
        xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAa
        w2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2
        jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20x
        vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s02
        6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF
        0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvE
        c7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
        v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7I
        U8q2NtUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In the current code, the parameters check of bpftool seems not correct,
for example, "bpftool batch file FILE" is the expected command format,
but "bpftool b f FILE" is recognized as valid, so use strcmp() instead
of is_prefix() to check parameters.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/bpf/bpftool/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index 741e50e..4ef87c2 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -200,7 +200,7 @@ int cmd_select(const struct cmd *cmds, int argc, char **argv,
 		return cmds[0].func(argc, argv);
 
 	for (i = 0; cmds[i].cmd; i++) {
-		if (is_prefix(*argv, cmds[i].cmd)) {
+		if (!strcmp(*argv, cmds[i].cmd)) {
 			if (!cmds[i].func) {
 				p_err("command '%s' is not supported in bootstrap mode",
 				      cmds[i].cmd);
@@ -337,7 +337,7 @@ static int do_batch(int argc, char **argv)
 	if (argc < 2) {
 		p_err("too few parameters for batch");
 		return -1;
-	} else if (!is_prefix(*argv, "file")) {
+	} else if (strcmp(*argv, "file")) {
 		p_err("expected 'file', got: %s", *argv);
 		return -1;
 	} else if (argc > 2) {
-- 
2.1.0


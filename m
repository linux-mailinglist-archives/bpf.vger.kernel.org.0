Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2141580FF8
	for <lists+bpf@lfdr.de>; Tue, 26 Jul 2022 11:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbiGZJcK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jul 2022 05:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbiGZJcJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jul 2022 05:32:09 -0400
Received: from m12-12.163.com (m12-12.163.com [220.181.12.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A2675248D0
        for <bpf@vger.kernel.org>; Tue, 26 Jul 2022 02:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=CmjPQ
        30/ahJmZy+5MCR5qEyEr4nVQSYwdCNdNq9erE0=; b=OkbfsHzVo2aLgWNIW55Nq
        JOm8D22kViJ1EYJdiOaA6Z045Y9rEtEoyFQBVv1dm0KOPOWHO1Y6QuUUEfupb0mY
        7Ofs5UQfNvpcpuZwaNulqbhgO4RyO0wlmtebqCKpn1JNF4bV3mxRJVrup84vU8pO
        ET35yx7Bqmv+Kl2yo+PFms=
Received: from localhost.localdomain (unknown [111.48.58.12])
        by smtp8 (Coremail) with SMTP id DMCowAAnPydGtN9iH3omPw--.33187S2;
        Tue, 26 Jul 2022 17:30:47 +0800 (CST)
From:   Rongguang Wei <clementwei90@163.com>
To:     quentin@isovalent.com, ast@kernel.org
Cc:     bpf@vger.kernel.org, Rongguang Wei <weirongguang@kylinos.cn>
Subject: [PATCH] bpftool: replace sizeof(arr)/sizeof(arr[0]) with ARRAY_SIZE macro
Date:   Tue, 26 Jul 2022 17:30:45 +0800
Message-Id: <20220726093045.3374026-1-clementwei90@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowAAnPydGtN9iH3omPw--.33187S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruw17Cr1rKFW3Xw18Ar15twb_yoW3JrgE9r
        1fXw4v9r95JFyxKF4xC3yFg348Jay5WFZ7uF4DJryfX3yUJws8XrZ5CwsYv34YgryqgFWa
        vas3XrnxJF43CjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU80dgJUUUUU==
X-Originating-IP: [111.48.58.12]
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/1tbiXAdKa1Xl30TWngAAsZ
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Rongguang Wei <weirongguang@kylinos.cn>

Use the ARRAY_SIZE macro and make the code more compact.

Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
---
 tools/bpf/bpftool/prog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 5c2c63df92e8..1e7768aa7a0e 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1974,7 +1974,7 @@ static int profile_parse_metrics(int argc, char **argv)
 	int selected_cnt = 0;
 	unsigned int i;
 
-	metric_cnt = sizeof(metrics) / sizeof(struct profile_metric);
+	metric_cnt = ARRAY_SIZE(metrics);
 
 	while (argc > 0) {
 		for (i = 0; i < metric_cnt; i++) {
-- 
2.25.1


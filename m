Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A424E4D6A
	for <lists+bpf@lfdr.de>; Wed, 23 Mar 2022 08:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242248AbiCWHhF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Mar 2022 03:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242247AbiCWHhE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Mar 2022 03:37:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B320650B3B;
        Wed, 23 Mar 2022 00:35:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D420B81DC9;
        Wed, 23 Mar 2022 07:35:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD71FC340E8;
        Wed, 23 Mar 2022 07:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648020931;
        bh=xg2LKyfJIt1HConR63HWpTzukqqZmS0RPHcMQ4kZgqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AUb2ABHyZQqMFnfkQwUtP38uq9xjcLNGpoRVg7wUSlg8Kk3C8i30krEXO/5EpiEjo
         Xaei29SmRlq5k7JTp0sLSI46nC+E4q6eFIU9z+/0GROVXv2e7DvI7sWbUsFKLY3Xai
         78A9xVrQgTaMkORAeLq8Hfk+GEesRpbHbtgmO4553kRFvwRIvz3LDrp/9FaJjmR2m1
         XCNGKNzoXRHLKz0U9xFOweC9sIZ9q9fhQ1qv8mpw5t3N/fL1LlEHxp0ZabfCEuMEPf
         YA2XP3Np7uuKE0G3PlUvWK/6QBhk5O0RJPHtLySoN4FAqo9XeAyNmwPOGwmY08Dlg1
         IQcI+vo9sDmxQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        kernel-janitors@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 1/2] fprobe: Fix smatch type mismatch warning
Date:   Wed, 23 Mar 2022 16:35:26 +0900
Message-Id: <164802092611.1732982.12268174743437084619.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <164802091567.1732982.1242854551611267542.stgit@devnote2>
References: <164802091567.1732982.1242854551611267542.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix the type mismatching warning of 'rethook_node vs fprobe_rethook_node'
found by Smatch.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/fprobe.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 8b2dd5b9dcd1..63b2321b22a0 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -150,15 +150,15 @@ static int fprobe_init_rethook(struct fprobe *fp, int num)
 
 	fp->rethook = rethook_alloc((void *)fp, fprobe_exit_handler);
 	for (i = 0; i < size; i++) {
-		struct rethook_node *node;
+		struct fprobe_rethook_node *node;
 
-		node = kzalloc(sizeof(struct fprobe_rethook_node), GFP_KERNEL);
+		node = kzalloc(sizeof(*node), GFP_KERNEL);
 		if (!node) {
 			rethook_free(fp->rethook);
 			fp->rethook = NULL;
 			return -ENOMEM;
 		}
-		rethook_add_node(fp->rethook, node);
+		rethook_add_node(fp->rethook, &node->node);
 	}
 	return 0;
 }


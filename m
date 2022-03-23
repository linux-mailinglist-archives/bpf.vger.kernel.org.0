Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097244E4D6E
	for <lists+bpf@lfdr.de>; Wed, 23 Mar 2022 08:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242252AbiCWHhL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Mar 2022 03:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242260AbiCWHhK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Mar 2022 03:37:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0250552E4F;
        Wed, 23 Mar 2022 00:35:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 914B0616C2;
        Wed, 23 Mar 2022 07:35:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6B6C340E8;
        Wed, 23 Mar 2022 07:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648020941;
        bh=VwRDMPlvyAW4+7bI8rwSaS3Cr1jEgSKAbPz996YPCOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EvYnmcL8BLIwWtsoMbZhQjCeaq7Grko4V1DERaMRMvp67WHDlMxcdAijkJkvOW4EV
         x9Cztwc9U2Wg1kNj+iHfOYN/MbxWKO9xe83v11Z2MtQTDRPAp3lJKPyxgmFQaMW9UH
         KsH8S01qERUdTbAU2k18m6Sq0iFhK7SrIpcyVPR1hMO+2m351Et1kpRUip7C2WEjlA
         ta5nESOJIIe3gpEVK1Pr7/vjj4NgTRD15OtUgyC7xl0MQlXp6i69D0AUceq3MuOAeW
         gbImUSFOOebjfWl2f3TL/U5MTUDBfz3tPNvnvxya0Vbu43HjRvXjXdJthKexrJfVmb
         SO1BknyyI4ZiQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        kernel-janitors@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 2/2] fprobe: Fix sparse warning for acccessing __rcu ftrace_hash
Date:   Wed, 23 Mar 2022 16:35:36 +0900
Message-Id: <164802093635.1732982.4938094876018890866.stgit@devnote2>
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

Since ftrace_ops::local_hash::filter_hash field is an __rcu pointer,
we have to use rcu_access_pointer() to access it.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/fprobe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 63b2321b22a0..89d9f994ebb0 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -215,7 +215,7 @@ int register_fprobe(struct fprobe *fp, const char *filter, const char *notfilter
 	 * correctly calculate the total number of filtered symbols
 	 * from both filter and notfilter.
 	 */
-	hash = fp->ops.local_hash.filter_hash;
+	hash = rcu_access_pointer(fp->ops.local_hash.filter_hash);
 	if (WARN_ON_ONCE(!hash))
 		goto out;
 


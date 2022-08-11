Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D980958F9D8
	for <lists+bpf@lfdr.de>; Thu, 11 Aug 2022 11:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234944AbiHKJQB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Aug 2022 05:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234945AbiHKJQA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Aug 2022 05:16:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC6C43310
        for <bpf@vger.kernel.org>; Thu, 11 Aug 2022 02:15:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 918B9B81E64
        for <bpf@vger.kernel.org>; Thu, 11 Aug 2022 09:15:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EAF2C433C1;
        Thu, 11 Aug 2022 09:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660209357;
        bh=693tbY193LLO0nBUMVDq3HIRyx8M2ZmuZe2rq5xdBck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BRb4EnpiLHm1jh1V477qWjPy22/nVCXMdJ4aQfTKsBrJOsiBlW9sKBN248LMQpogy
         aah8rKU6uPT8v9aLJn/6N3rR1S/bYGnHEhQo2ybOoz2ME4/Dco1eTy47428my2HYeD
         n98EkowEY4UMemH4X+XJINxnlKD6ULc4lw5/utKEaUthQQ4qNHhAL4ltgAOmtay4jf
         Butd5hp72IxPfIbdZMVxy1R8/IRDuK77CELw3N0TBqocBW2xt6T1W8GYr9DFaXr4kq
         v3kncc9EXv1xzx+B8vLiCny4WBerJcPL0y+vQ0aMMi4amFDyyaGZQuDulKSE9GObVX
         +xJvCN6rqvLHA==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: [PATCHv2 bpf-next 2/6] ftrace: Keep the resolved addr in kallsyms_callback
Date:   Thu, 11 Aug 2022 11:15:22 +0200
Message-Id: <20220811091526.172610-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220811091526.172610-1-jolsa@kernel.org>
References: <20220811091526.172610-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Keeping the resolved 'addr' in kallsyms_callback, instead of taking
ftrace_location value, because we depend on symbol address in the
cookie related code.

With CONFIG_X86_KERNEL_IBT option the ftrace_location value differs
from symbol address, which screwes the symbol address cookies matching.

There are 2 users of this function:
- bpf_kprobe_multi_link_attach
    for which this fix is for

- get_ftrace_locations
    which is used by register_fprobe_syms

    this function needs to get symbols resolved to addresses,
    but does not need 'ftrace location addresses' at this point
    there's another ftrace location translation in the path done
    by ftrace_set_filter_ips call:

     register_fprobe_syms
       addrs = get_ftrace_locations

       register_fprobe_ips(addrs)
         ...
         ftrace_set_filter_ips
           ...
             __ftrace_match_addr
               ip = ftrace_location(ip);
               ...

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/ftrace.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index bc921a3f7ea8..8a8c90d1a387 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -8268,8 +8268,7 @@ static int kallsyms_callback(void *data, const char *name,
 	if (args->addrs[idx])
 		return 0;
 
-	addr = ftrace_location(addr);
-	if (!addr)
+	if (!ftrace_location(addr))
 		return 0;
 
 	args->addrs[idx] = addr;
-- 
2.37.1


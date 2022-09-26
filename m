Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6313B5EACE4
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 18:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiIZQpx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 12:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiIZQp1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 12:45:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054E54A83F
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 08:34:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10D2560DFC
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 15:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434ECC43140;
        Mon, 26 Sep 2022 15:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664206446;
        bh=2WnKXTXVQn0092eVlGqi0BKS7kLkBS0mXywwvISTgBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dc61V+LFmh20vJuTderh8H3kiKrohJx2NWvfLuwGACwdP9fr4OwOnLwbcGkqzwVdN
         J6t/yHvKAHF/3HqRLv08lyovsTJXJVOdZog0UQ9t2naYbvM1qbgwZkNFqIe4SYILt8
         bfa6EITvlkO0WxyW/1xgs8x4rVHkdYN9YJ6am6CB/MUZDpSmk/KEz8EtwagE2/nzRP
         2q0Av+rPTzaTkpZrn0jIkSbCUNReRZYeR7Bu5vtwEHXY0TcAdFFDKTeV0929V6DMiv
         qy/5BWFU7fYvUQl8Ckb7ZR999Ze1+MVv7nccUbMjnn5kt7u+Y6h+KTpt9VzHwFWjI9
         WGZqeXHQhJPow==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Martynas Pumputis <m@lambda.lt>
Subject: [PATCHv5 bpf-next 2/6] ftrace: Keep the resolved addr in kallsyms_callback
Date:   Mon, 26 Sep 2022 17:33:36 +0200
Message-Id: <20220926153340.1621984-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220926153340.1621984-1-jolsa@kernel.org>
References: <20220926153340.1621984-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/ftrace.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 439e2ab6905e..447d2e2a8549 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -8265,8 +8265,7 @@ static int kallsyms_callback(void *data, const char *name,
 	if (args->addrs[idx])
 		return 0;
 
-	addr = ftrace_location(addr);
-	if (!addr)
+	if (!ftrace_location(addr))
 		return 0;
 
 	args->addrs[idx] = addr;
-- 
2.37.3


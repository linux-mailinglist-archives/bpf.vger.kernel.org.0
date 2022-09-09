Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1545B34ED
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 12:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiIIKNQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 06:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiIIKNP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 06:13:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4D674BA8
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 03:13:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77A7F61F81
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 10:13:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469EFC433C1;
        Fri,  9 Sep 2022 10:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662718393;
        bh=2WnKXTXVQn0092eVlGqi0BKS7kLkBS0mXywwvISTgBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aaQaCwJ/Lq9rDSYDA+3yjoNwPOnoSgf7X0jNUNwsqvg68TnK9tTPGIBw7aBcSRINt
         FQzndu4mbYZQQuvHU4BEArdWVbzDqemY2W3h0oZQ52VRdnffMvX9/8ZRSPJg6e3EFM
         yt02kajK/k8GDRGmJQmsgngQNqwk1tHVIEZE00YbTtU67bQYiUJLhablkrgC4W7Lb6
         asQmqZ9dZlucZ+W7whwEw9xBpoaW0jbIFFxdxG+dHcNl0uUlh7lilDMUbg1X02wLEq
         uY9XQHu4Yf7q254YgeOha/ZlA2RNsZUKH08wBFpwcLZyRQL4yR2lq1KhlD+Ck0H8DF
         1gafEFHFEXeXA==
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
Subject: [PATCHv3 bpf-next 2/6] ftrace: Keep the resolved addr in kallsyms_callback
Date:   Fri,  9 Sep 2022 12:12:41 +0200
Message-Id: <20220909101245.347173-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220909101245.347173-1-jolsa@kernel.org>
References: <20220909101245.347173-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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


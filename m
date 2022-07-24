Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2545C57F72A
	for <lists+bpf@lfdr.de>; Sun, 24 Jul 2022 23:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiGXVWL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 24 Jul 2022 17:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiGXVWK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 24 Jul 2022 17:22:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F082DE90
        for <bpf@vger.kernel.org>; Sun, 24 Jul 2022 14:22:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD6E5611E1
        for <bpf@vger.kernel.org>; Sun, 24 Jul 2022 21:22:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E86C3411E;
        Sun, 24 Jul 2022 21:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658697729;
        bh=Mk9RmqUBeBHj/W3Hcl/7iDF9RcqpFkqPhb0Oo1GNieM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mxeZTyNK8NHc0RoAL6BWuC/NvO8Pe5RqvN0zlK2xLSpSu0x/D+hi+H611GcSFHRwY
         4W6wdTLF0DccrbtQpQZif0JHA6/2ehRcrmMsm3mGDK1izfdV7ECljNfs1VNutoW7Oj
         JlPUpLrV73GGS/8Lu00kMoRlIlg0jwD/EEWf2HHnYizgqEFagyocgLzrtTPeKKuBVl
         5GF2SmN//vok9YfFx1sEAPVqek2rk3VJ3GvtikhSJusWHl7a3QuKw870aw4YJnvicY
         T3udhC59SwyCOeZlx6hcIoVRqSiuQF792+ObYdCKNrDSPCPsDLSfEMUNDTEdYLpOew
         i5uanVkDLrRlQ==
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
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH bpf-next 1/5] ftrace: Keep the resolved addr in kallsyms_callback
Date:   Sun, 24 Jul 2022 23:21:42 +0200
Message-Id: <20220724212146.383680-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220724212146.383680-1-jolsa@kernel.org>
References: <20220724212146.383680-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/ftrace.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 601ccf1b2f09..3f3c98ee207a 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -8040,8 +8040,7 @@ static int kallsyms_callback(void *data, const char *name,
 	if (args->addrs[idx])
 		return 0;
 
-	addr = ftrace_location(addr);
-	if (!addr)
+	if (!ftrace_location(addr))
 		return 0;
 
 	args->addrs[idx] = addr;
-- 
2.35.3


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD2D6180B7
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 16:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbiKCPLK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 11:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbiKCPKk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 11:10:40 -0400
X-Greylist: delayed 378 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Nov 2022 08:09:48 PDT
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E6310FC5;
        Thu,  3 Nov 2022 08:09:48 -0700 (PDT)
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4N36TC5rTFz8svY;
        Thu,  3 Nov 2022 16:03:27 +0100 (CET)
Authentication-Results: mx-rz-1.rrze.uni-erlangen.de; dkim=none;
        dkim-atps=neutral
X-Virus-Scanned: amavisd-new at boeck5.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 10.188.34.179
Received: from uni-erlangen.de (i4laptop28.informatik.uni-erlangen.de [10.188.34.179])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX18CxjfIGbKY7LqpaFakzBHDNDrAmmghoCk=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4N36T92D2Lz8sgp;
        Thu,  3 Nov 2022 16:03:25 +0100 (CET)
From:   Jonas Rabenstein <rabenstein@cs.fau.de>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Jonas Rabenstein <rabenstein@cs.fau.de>,
        Song Liu <song@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: mark get_entry_ip as __maybe_unused
Date:   Thu,  3 Nov 2022 16:03:03 +0100
Message-Id: <20221103150303.974028-1-rabenstein@cs.fau.de>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit c09eb2e578eb1668bbc ("bpf: Adjust kprobe_multi entry_ip
for CONFIG_X86_KERNEL_IBT") introduced the get_entry_ip() function.
Depending on CONFIG_X86_KERNEL_IBT it is a static function or only
a macro definition. The only user of this symbol so far is in
kprobe_multi_link_handler() if CONFIG_FPROBE is enabled.
If CONFIG_FROBE is not set, the symbol is not used and - depending
on CONFIG_X86_KERNEL_IBT - a warning for get_entry_ip() is emitted.
To solve this, the function should be marked as __maybe_unused.

Signed-off-by: Jonas Rabenstein <rabenstein@cs.fau.de>
---
 kernel/trace/bpf_trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index f2d8d070d024..19131aae0bc3 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1032,7 +1032,7 @@ static const struct bpf_func_proto bpf_get_func_ip_proto_tracing = {
 };
 
 #ifdef CONFIG_X86_KERNEL_IBT
-static unsigned long get_entry_ip(unsigned long fentry_ip)
+static unsigned long __maybe_unused get_entry_ip(unsigned long fentry_ip)
 {
 	u32 instr;
 
-- 
2.37.4


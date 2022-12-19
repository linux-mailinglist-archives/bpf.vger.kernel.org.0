Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5838650D63
	for <lists+bpf@lfdr.de>; Mon, 19 Dec 2022 15:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbiLSOfO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Dec 2022 09:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbiLSOfI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Dec 2022 09:35:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E08AB07;
        Mon, 19 Dec 2022 06:35:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3356EB80D19;
        Mon, 19 Dec 2022 14:35:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D60DC433EF;
        Mon, 19 Dec 2022 14:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671460505;
        bh=ovmSOyXpdhZkVdvPTmi4MkzRm45TRy0WVB+TsJRSG+Y=;
        h=From:To:Cc:Subject:Date:From;
        b=q/YxNgFT996DZFPVp7bZFUV5THnnXuKC5RHDr7TDWh0gWkXV1UjCeq1a21/ejNk/a
         od/bJMmgWTabez6waaqfyOxkw+FjP15IhIYVKTuLzOxn9A8dynR77ilFq7FnCIZcuF
         QbzcU6+ylxTDNHHHJvMZOaHMPPN6Pgz8EgdDnR4yISA7wtULAH4ONxqSA88yQudSAd
         9DRpULDwxQmI5E7HsSYps/OI2LQcOO738gLx0R/2ousxikLRaefswpQEuLqrngzCuA
         3IYbNRxq3udkq2i4JkSkBOdQplOm03lnNREkP779jWIEm45euCocFDdwnpB/rZCey/
         bwM6rNPC2iPAA==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     x86@kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        bpf <bpf@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH -tip v4 0/2] x86/kprobes: Fix to check not-kprobe's int3 correctly
Date:   Mon, 19 Dec 2022 23:35:00 +0900
Message-Id: <167146050052.1374301.10407562178447545337.stgit@devnote3>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

Here is 4th version of the patches to fix kprobes and optprobe with
CONFIG_RETHUNK and CONFIG_SLS.
Previous version is here;

https://lore.kernel.org/all/166264927154.775585.16570756675363838701.stgit@devnote2/

I just ported the v3 on the latest -tip tree.

With CONFIG_RETHUNK/CONFIG_SLS and after many efforts, the kernel
functions may includes INT3 for stopping speculative execution in the
function code block (body) in addition to the gaps between functions.

Since kprobes on x86 has to ensure the probe address is an instruction
bondary, it decodes the instructions in the function until the address.
If it finds an INT3 which is not embedded by kprobe, it stops decoding
because usually the INT3 is used for debugging as a software breakpoint
and such INT3 will replace the first byte of an original instruction.
Thus the kprobes returns -EILSEQ as below.

 # echo 'p:probe/resched_curr_L21 resched_curr+98' >> dynamic_events 
 sh: write error: Invalid or incomplete multibyte or wide character

Actually, such INT3 can be ignored except the INT3 installed dynamically
by kgdb.
To avoid this issue, just check whether the INT3 is owned by kgdb
or not and if so, it just stopped and return failure.

With thses fixes, kprobe and optprobe can probe the kernel again with
CONFIG_RETHUNK=y.

Thank you,


---

Masami Hiramatsu (Google) (2):
      x86/kprobes: Fix kprobes instruction boudary check with CONFIG_RETHUNK
      x86/kprobes: Fix optprobe optimization check with CONFIG_RETHUNK


 arch/x86/kernel/kprobes/core.c |   10 +++++++---
 arch/x86/kernel/kprobes/opt.c  |   28 ++++++++--------------------
 2 files changed, 15 insertions(+), 23 deletions(-)

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157E95B2171
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 17:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbiIHPBT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 11:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbiIHPBS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 11:01:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10BD13D3B;
        Thu,  8 Sep 2022 08:01:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6756E61D24;
        Thu,  8 Sep 2022 15:01:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71967C433D6;
        Thu,  8 Sep 2022 15:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662649276;
        bh=E+RylFYtRy105gINSkbZbc4256IOR0QBpT/DYAb5i4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JW6pOaImsbmL6a5pkvrIiRMHAE5t/9wmUW0n2kEdSLNnL8mJQY6nVyyM0uNUSSxia
         JIqsk+byBbowq6YOxxufNotM1hIaInT+xq3RhB1alZr47c/fTzPvCsV0+8HTdJ55xo
         gneMZBnSluQW3N4iSwBD+Ge5ApFf4V7nrYGm0VdZUwP+Af2433rBubNFZUWmNxftq9
         aamKx5SnhOumkz7NevK/ynqejScKieFMf2h6RiJMKK29U7YrS473llY3FJNZPDVSOg
         xeaDDZhe+9uybMYz2A8PJTg0Dqz0c2l8ES+CC5nN9ZJvez5DD3D/Ke7iVtVv7VKqUB
         Sbzv0nmpOuXpQ==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        bpf <bpf@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>, x86@kernel.org
Subject: [PATCH v3 0/2] x86/kprobes: Fixes for CONFIG_RETHUNK
Date:   Fri,  9 Sep 2022 00:01:11 +0900
Message-Id: <166264927154.775585.16570756675363838701.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220908220354.28c196c8bbe4e83c83afcb59@kernel.org>
References: <20220908220354.28c196c8bbe4e83c83afcb59@kernel.org>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Hi Peter and Josh,

So here is 3rd version of the patches to fix kprobes and optprobe with
CONFIG_RETHUNK and CONFIG_SLS.
Previous version is here;

https://lore.kernel.org/all/166260087224.759381.4170102827490658262.stgit@devnote2/

In this version, I simplified all code and just checks the INT3 comes
from kgdb or not. Other INT3 are treated as one-byte instruction.

With CONFIG_RETHUNK/CONFIG_SLS, the kernel functions may includes INT3
for stopping speculative execution in the function code block (body) in
addition to the gaps between functions.

Since kprobes on x86 has to ensure the probe address is an instruction
bondary, it decodes the instructions in the function until the address.
If it finds an INT3 which is not embedded by kprobe, it stops decoding
because usually the INT3 is used for debugging as a software breakpoint
and such INT3 will replace the first byte of an original instruction.
Without recovering it, kprobes can not continue to decode it. Thus the
kprobes returns -EILSEQ as below.


 # echo "p:probe/vfs_truncate_L19 vfs_truncate+98" >> kprobe_events 
 sh: write error: Invalid or incomplete multibyte or wide character


Actually, such INT3 can be ignored except the INT3 installed by kgdb.

To avoid this issue, just check whether the INT3 is owned by kgdb
or not and if so, it just stopped and return failure.

With thses fixes, kprobe and optprobe can probe the kernel again with
CONFIG_RETHUNK=y.


 # echo "p:probe/vfs_truncate_L19 vfs_truncate+98" >> kprobe_events 
 # echo 1 > events/probe/vfs_truncate_L19/enable 
 # cat /sys/kernel/debug/kprobes/list 
 ffffffff81307b52  k  vfs_truncate+0x62    [OPTIMIZED]


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

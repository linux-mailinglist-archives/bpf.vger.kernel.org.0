Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928E65B121D
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 03:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiIHBen (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 21:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIHBel (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 21:34:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21822220F6;
        Wed,  7 Sep 2022 18:34:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 387F261B2A;
        Thu,  8 Sep 2022 01:34:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CCCC433C1;
        Thu,  8 Sep 2022 01:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662600877;
        bh=8g+ulJHSFrGSCitQa2VAEJjEhkdoJC7BJJgCiYqHlJg=;
        h=From:To:Cc:Subject:Date:From;
        b=U1BFkeMLJsXoeqAfoiD/OYiyqKX8QXkCJ2QxnEjPp5xRLC362LX9mxk/BIgMHhjce
         aDQO0NKHYYBWAG3X1fr0PS997p9aYLNF7dLN+vSUCWycwbVRz6V4ABvz+iwo6M/mqx
         VMSbrjYVW3iE1I5kOrwonKg8Hu62uOZwa7nX+IoUtu86TqBfr7b2sTwo/d9bSbINv7
         BRsiWPHWGyi7YSSsLmU7duAhLcsNSms7gIA1YZi/6WIVw4S1VZ+rtsrRmg4kuZXwlj
         W4P1I15LQlVoJkhJZvg52D+HmhAlRZ9Q3D9sISm7Fh+lPccTid2qowHIHEzVB6wXc7
         iAunSkFU583kg==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        bpf <bpf@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Subject: [PATCH v2 0/2] x86/kprobes: Fixes for CONFIG_RETHUNK
Date:   Thu,  8 Sep 2022 10:34:32 +0900
Message-Id: <166260087224.759381.4170102827490658262.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
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

Hi,

Here is the 2nd version of the patches to fix kprobes and optprobe with
CONFIG_RETHUNK and CONFIG_SLS.
Previous version is here;

https://lore.kernel.org/all/166251211081.632004.1842371136165709807.stgit@devnote2/

In this version, I updated the Fixed tag and the decoding function to
memorize all branch targets and decode those code blocks besed on 
Peter's idea. (Thanks!)

With these configs, the kernel functions may includes INT3 for stopping
speculative execution in the function code block (body) in addition to
the gaps between functions.

Since kprobes on x86 has to ensure the probe address is an instruction
bondary, it decodes the instructions in the function until the address.
If it finds an INT3 which is not embedded by kprobe, it stops decoding
because usually the INT3 is used for debugging as a software breakpoint
and such INT3 will replace the first byte of an original instruction.
Without recovering it, kprobes can not continue to decode it. Thus the
kprobes returns -EILSEQ as below.


 # echo "p:probe/vfs_truncate_L19 vfs_truncate+98" >> kprobe_events 
 sh: write error: Invalid or incomplete multibyte or wide character


Actually, those INT3s are just for padding and can be ignored.

To avoid this issue, memorize the branch target address during decoding
and if there is INT3, restart decoding from unchecked target address
so that this decodes all instructions in the kernel (in both kprobes
and optprobe.)

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


 arch/x86/kernel/kprobes/common.h |   28 +++++
 arch/x86/kernel/kprobes/core.c   |  227 +++++++++++++++++++++++++++++++++-----
 arch/x86/kernel/kprobes/opt.c    |   96 ++++------------
 3 files changed, 249 insertions(+), 102 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

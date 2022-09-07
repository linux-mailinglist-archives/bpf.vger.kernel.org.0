Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D545AF935
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 02:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiIGAzW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 20:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiIGAzU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 20:55:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC64D474FC;
        Tue,  6 Sep 2022 17:55:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C38BB81AD5;
        Wed,  7 Sep 2022 00:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6347EC433C1;
        Wed,  7 Sep 2022 00:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662512115;
        bh=0yIJr9LmrqrD3h0kQYQFIbV0sKxYlBgsxC6nOdGrKMo=;
        h=From:To:Cc:Subject:Date:From;
        b=NkhSECC2Lkq7vieZGbhdthZz2zSqXwLTS8PH6s09izpLx2X4bPL62m37qoik67CVT
         wyQTU329FW8eh8Fri50IUGllih79mosQntkfVqz1Aiwd+fmNokhShhSV/1brI5NTDl
         Q6hu1YWfRnRycfPXUMsj5ZDCEiRjCG3v+GA81ayt5EbPjE01Qwgg08HOTu1YJ4OCxO
         6j0ZzUVngAdOCuGWHLxq47Wbkrn72A5D+F1mT9Yw0eX7IQ1W1WsdtBmAz79DGTLiX+
         Ssb2AhChZ2ZQqH9bi7ON+H9k1BzxM1j8SMcmbopfw0YZelEnOZPdJgJTak/orf8uEL
         AL4PN33J+3Q2w==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        bpf <bpf@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Subject: [PATCH 0/2] x86/kprobes: Fixes for CONFIG_RETHUNK
Date:   Wed,  7 Sep 2022 09:55:11 +0900
Message-Id: <166251211081.632004.1842371136165709807.stgit@devnote2>
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

Here is a couple of patches to fix kprobes and optprobe to work
on the kernel with CONFIG_RETHUNK and CONFIG_SLS.

With these configs, the kernel functions may includes padding INT3 in
the function code block (body) in addition to the gaps between functions.

Since kprobes on x86 has to ensure the probe address is a function
bondary, it decodes the instructions in the function until the address.
If it finds an INT3 which is not embedded by kprobe, it stops decoding
because usually the INT3 is used for debugging as a software breakpoint
and such INT3 will replace the first byte of an original instruction.
Without recovering it, kprobes can not continue to decode it. Thus the
kprobes returns -EILSEQ as below.


 # echo "p:probe/vfs_truncate_L19 vfs_truncate+98" >> kprobe_events 
 sh: write error: Invalid or incomplete multibyte or wide character


Actually, those INT3s are just for padding and can be ignored.

To avoid this issue, if kprobe finds an INT3, it gets the address of
next non-INT3 byte, and search a branch which jumps to the address.
If there is the branch, these INT3 will be for padding, so it can be
skipped. [1/2]

Since the optprobe has similar issue, it also skips the padding INT3
in the same way. [2/2]

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


 arch/x86/kernel/kprobes/common.h |   67 +++++++++++++++++++++++++++
 arch/x86/kernel/kprobes/core.c   |   57 +++++++++++++----------
 arch/x86/kernel/kprobes/opt.c    |   93 ++++++++++++++------------------------
 3 files changed, 133 insertions(+), 84 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

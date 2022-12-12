Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006B6649806
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 03:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiLLCql (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Dec 2022 21:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiLLCqk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Dec 2022 21:46:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C81A44E;
        Sun, 11 Dec 2022 18:46:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E75D60EA4;
        Mon, 12 Dec 2022 02:46:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55368C433D2;
        Mon, 12 Dec 2022 02:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670813198;
        bh=0cSYutYmLiE4Dzs5PkSS2If4OMmjtOOGuQ3HzAfp/5M=;
        h=From:To:Cc:Subject:Date:From;
        b=H2mytzc1shzWuSFZbqJcGEHZLglq1xpRIZYm8ok8kcJzxwuFQaPBb4LMysIOmLksc
         nUUl0LEca4/JSXE7je/iY25W5MpgAZHcurk44TBYOPZRKEAdXM/mQnaWodLAiUmNVX
         NeWDwHquFugXqGgOYcsFw/FnJnuQm4jnP6QfAauyEYs0m7AGo82zFjpj8gze46nM0a
         2+vE+nG9O+okXCy1Hdm1uNiNuEJ7cfAoeI2apWSLd1XNrJ/xXodyST1fNNXI0PyOI4
         GmMTIjTYf/8u1riqk/Lni5Zc+fPjJgBa8iKsXkIFA1OXTAH6qlxXkE2Tmjahq2Ivzd
         8aivyNKzxG1Yg==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     bpf@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        KP Singh <kpsingh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Chris Mason <clm@meta.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [PATCH 0/2] error-injection: Clarify the requirements of error injectable functions
Date:   Mon, 12 Dec 2022 11:46:33 +0900
Message-Id: <167081319306.387937.10079195394503045678.stgit@devnote3>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
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

Here are the patches for clarifying the requirement of error injectable
functions and remove confusing EI_ETYPE_NONE.

Here is the thread of discussions which leads this series.

https://lore.kernel.org/all/167019256481.3792653.4369637751468386073.stgit@devnote3/T/#u

I agreed that NACK the taint flag itself, and I thought I need to update
the function error injection so that the developers understand the
requirements and carefully use the ALLOW_ERROR_INJECTION() macro.
So I removed the confusing EI_ETYPE_NONE (this should not be there,
use errno instead), and update the document about error injectable
functions.

Thank you,

---

Masami Hiramatsu (Google) (2):
      error-injection: Remove EI_ETYPE_NONE
      docs: fault-injection: Add requirements of error injectable functions


 Documentation/fault-injection/fault-injection.rst |   65 +++++++++++++++++++++
 include/asm-generic/error-injection.h             |    7 +-
 include/linux/error-injection.h                   |    2 -
 lib/error-inject.c                                |    2 -
 4 files changed, 71 insertions(+), 5 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

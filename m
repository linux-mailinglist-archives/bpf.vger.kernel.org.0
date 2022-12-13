Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC92C64B706
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 15:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbiLMOM7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 09:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235901AbiLMOM2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 09:12:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D26A63B0;
        Tue, 13 Dec 2022 06:11:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A77FD61536;
        Tue, 13 Dec 2022 14:11:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4399C433D2;
        Tue, 13 Dec 2022 14:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670940675;
        bh=hJEn/SyT7u4Ea+9kLZem5aYnwJxDKn16rRrjp1PMzuQ=;
        h=From:To:Cc:Subject:Date:From;
        b=lVhRbsKzj5sq7nUjIwdRL7l1GtF0DsBMd5E3EehvoiPEe4PzNWg6G1PazM95pIzff
         aLOqjzzsf87ZZ6ukB08hp1Umy209D5LEfNmCT6zT9j4HGSqIKatpYRSNamhrRFpfmM
         dsR3CqI90eNoq2rLwsJMa8WaQS2U+WmzorKrw9JxzGlBjl5a/DtsalsZC1x8LGC708
         qFQ3iocJdOzrI5/ozOub7d5IYYpkAkm64ueDvg+lpRVNDLXnJ6/CNfqn+R5Zi0BxrW
         Q74Jg0d3GInuq6ibPAeYn41iLVO3O1M8Hj0MwhmSe2W3NoA09lKrVxG2OCWxRTu8ma
         wI5Lbqh/M4pgw==
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
        linux-doc@vger.kernel.org, Akinobu Mita <akinobu.mita@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 0/2] error-injection: Clarify the requirements of error injectable functions
Date:   Tue, 13 Dec 2022 23:11:10 +0900
Message-Id: <167094067084.608798.11303550366840600235.stgit@devnote3>
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

Here is the 2nd version of the series to clarify the requirement of error
injectable functions and remove confusing EI_ETYPE_NONE.

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
 include/linux/error-injection.h                   |    3 +
 lib/error-inject.c                                |    2 -
 4 files changed, 72 insertions(+), 5 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

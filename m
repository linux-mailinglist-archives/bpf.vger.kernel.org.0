Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F7A6CF348
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 21:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjC2Tkr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Mar 2023 15:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjC2Tkm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Mar 2023 15:40:42 -0400
Received: from mx.der-flo.net (mx.der-flo.net [193.160.39.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E7C5252
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 12:40:31 -0700 (PDT)
From:   Florian Lehner <dev@der-flo.net>
To:     bpf@vger.kernel.org
Cc:     x86@kernel.org, davem@davemloft.net, daniel@iogearbox.net,
        andrii@kernel.org, peterz@infradead.org, keescook@chromium.org,
        tglx@linutronix.de, hsinweih@uci.edu, rostedt@goodmis.org,
        vegard.nossum@oracle.com, gregkh@linuxfoundation.org,
        alan.maguire@oracle.com, dylany@meta.com, riel@surriel.com,
        kernel-team@fb.com, Florian Lehner <dev@der-flo.net>
Subject: [RESUBMIT bpf-next 0/2] Fix copy_from_user_nofault()
Date:   Wed, 29 Mar 2023 21:39:30 +0200
Message-Id: <20230329193931.320642-1-dev@der-flo.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The original patch got submitted by Alexei Starovoitov with [0] and
fixes issues that got also reported in [1].

This resubmission adds !pagefault_disabled() to the check in
check_heap_object(). 

[0] https://lore.kernel.org/all/20230118051443.78988-1-alexei.starovoitov@gmail.com/
[1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1033398

Alexei Starovoitov (2):
  mm: Fix copy_from_user_nofault().
  perf: Fix arch_perf_out_copy_user().

 arch/x86/include/asm/perf_event.h |  2 --
 arch/x86/lib/Makefile             |  2 +-
 arch/x86/lib/usercopy.c           | 55 -------------------------------
 kernel/events/internal.h          | 16 +--------
 mm/maccess.c                      | 54 +++++++++++++++++++++++++-----
 mm/usercopy.c                     |  2 +-
 6 files changed, 49 insertions(+), 82 deletions(-)
 delete mode 100644 arch/x86/lib/usercopy.c

-- 
2.39.2


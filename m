Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B9654FAB9
	for <lists+bpf@lfdr.de>; Fri, 17 Jun 2022 18:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382646AbiFQQDB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jun 2022 12:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiFQQDA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Jun 2022 12:03:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B797BC16;
        Fri, 17 Jun 2022 09:02:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CADC6B8282A;
        Fri, 17 Jun 2022 16:02:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FDD2C3411B;
        Fri, 17 Jun 2022 16:02:55 +0000 (UTC)
Date:   Fri, 17 Jun 2022 12:02:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Yonghong Song <yhs@fb.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] tracing/kprobes: Check whether get_kretprobe() returns
 NULL in kretprobe_dispatcher()
Message-ID: <20220617120254.30bb0f15@gandalf.local.home>
In-Reply-To: <3d535ae1-69cd-dbae-32f6-7d571a88c2d8@iogearbox.net>
References: <165366693881.797669.16926184644089588731.stgit@devnote2>
        <0204f480-cdb0-e49f-9034-602eced02966@iogearbox.net>
        <7619DB57-C39B-4A49-808C-7ACF12D58592@goodmis.org>
        <d28e1548-98fb-a533-4fdc-ae4f4568fb75@iogearbox.net>
        <20220608091017.0596dade@gandalf.local.home>
        <3d535ae1-69cd-dbae-32f6-7d571a88c2d8@iogearbox.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 17 Jun 2022 10:26:40 +0200
Daniel Borkmann <daniel@iogearbox.net> wrote:

> Steven, we still have this in our patchwork for tracking so it doesn't fall
> off the radar. The patch is 3 weeks old by now. Has this been picked up yet,
> or do you want to Ack and we ship the fix via bpf tree? Just asking as I
> didn't see any further updates ever since.

Sorry, between traveling for conferences and PTO I fell behind. I'll pull
this into my urgent queue and start running my tests on it.

-- Steve

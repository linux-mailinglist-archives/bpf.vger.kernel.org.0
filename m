Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C729B64536D
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 06:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiLGF1A convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 7 Dec 2022 00:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiLGF06 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 00:26:58 -0500
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EFE4AF27
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 21:26:53 -0800 (PST)
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay04.hostedemail.com (Postfix) with ESMTP id 97EFD1A08DE;
        Wed,  7 Dec 2022 05:18:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 1E0EF2002D;
        Wed,  7 Dec 2022 05:17:58 +0000 (UTC)
Date:   Wed, 07 Dec 2022 00:18:17 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        KP Singh <kpsingh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florent Revest <revest@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Chris Mason <clm@meta.com>
Subject: Re: [PATCH v2] panic: Taint kernel if fault injection has been used
User-Agent: K-9 Mail for Android
In-Reply-To: <CAADnVQKDZfP51WeVOeY-6RNH=MHT2BhtW6F8PaJV5-RoJOtMkQ@mail.gmail.com>
References: <167019256481.3792653.4369637751468386073.stgit@devnote3> <20221204223001.6wea7cgkofjsiy2z@macbook-pro-6.dhcp.thefacebook.com> <20221205075921.02edfe6b54abc5c2f9831875@kernel.org> <20221206021700.oryt26otos7vpxjh@macbook-pro-6.dhcp.thefacebook.com> <20221206162035.97ae19674d6d17108bed1910@kernel.org> <20221207040146.zhm3kyduqp7kosqa@macbook-pro-6.dhcp.thefacebook.com> <20221206233947.4c27cc9d@gandalf.local.home> <CAADnVQKDZfP51WeVOeY-6RNH=MHT2BhtW6F8PaJV5-RoJOtMkQ@mail.gmail.com>
Message-ID: <2ED74AA5-B2A5-43FA-ADF9-B6752FE410C4@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Rspamd-Queue-Id: 1E0EF2002D
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Rspamd-Server: rspamout03
X-Stat-Signature: 6q5ataj4w1quggag3oa4ox39gd6km3rb
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/eMrmZsD4+Eahg02CQ10Y97AFleKyzqq0=
X-HE-Tag: 1670390278-928139
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On December 6, 2022 11:45:17 PM EST, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>On Tue, Dec 6, 2022 at 8:39 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>> >
>> > [   49.281382] general protection fault, probably for non-canonical address 0x57e006e00000000: 0000 [#1] PREEMPT SMP KASAN
>> > [   49.282226] CPU: 6 PID: 1688 Comm: test_progs Tainted: G    B      O       6.1.0-rc7-01508-gf0c5a2d9f234 #4343
>> > [   49.283751] RIP: 0010:rethook_trampoline_handler+0xff/0x1d0
>> > [   49.289900] Call Trace:
>> > [   49.290083]  <TASK>
>> > [   49.290248]  arch_rethook_trampoline_callback+0x6c/0xa0
>> > [   49.290631]  arch_rethook_trampoline+0x2c/0x50
>> > [   49.290964]  ? lock_release+0xad/0x3f0
>> > [   49.291245]  ? bpf_prog_test_run_tracing+0x235/0x380
>> > [   49.291609]  trace_clock_x86_tsc+0x10/0x10
>> >
>> > This is just running bpf selftests in parallel mode on 16-cpu VM on bpf-next.
>> > Notice 'Tained' flags.
>> > Please take a look.
>> >
>>
>> "G - Proprietary module" - "O - out of tree module"
>>
>> Can you reproduce this without those taints?
>
>Lol. That question is exactly the reason why my Nack stands.

I only said the above *because* of your comment ;-) 

-- Steve


-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity and top posting.

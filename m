Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5349693329
	for <lists+bpf@lfdr.de>; Sat, 11 Feb 2023 20:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjBKTAT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Feb 2023 14:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBKTAS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 11 Feb 2023 14:00:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0A2199E0;
        Sat, 11 Feb 2023 11:00:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4455860B63;
        Sat, 11 Feb 2023 19:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82C0C433EF;
        Sat, 11 Feb 2023 19:00:13 +0000 (UTC)
Date:   Sat, 11 Feb 2023 14:00:11 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     John Stultz <jstultz@google.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel test robot <oliver.sang@intel.com>,
        kbuild test robot <lkp@intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Michal Miroslaw <mirq-linux@rere.qmqm.pl>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Qais Yousef <qyousef@google.com>,
        Daniele Di Proietto <ddiproietto@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 7/7] tools/testing/selftests/bpf: replace open-coded
 16 with TASK_COMM_LEN
Message-ID: <20230211140011.4f15a633@gandalf.local.home>
In-Reply-To: <20230208213343.40ee15a5@gandalf.local.home>
References: <20211120112738.45980-1-laoar.shao@gmail.com>
        <20211120112738.45980-8-laoar.shao@gmail.com>
        <Y+QaZtz55LIirsUO@google.com>
        <CAADnVQ+nf8MmRWP+naWwZEKBFOYr7QkZugETgAVfjKcEVxmOtg@mail.gmail.com>
        <CANDhNCo_=Q3pWc7h=ruGyHdRVGpsMKRY=C2AtZgLDwtGzRz8Kw@mail.gmail.com>
        <20230208212858.477cd05e@gandalf.local.home>
        <20230208213343.40ee15a5@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 8 Feb 2023 21:33:43 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> OK, so it doesn't break perf, trace-cmd and rasdaemon, because the enum is
> only needed in the print_fmt part. It can handle it in the field portion.
> 
> That is:
> 
> 
> system: sched
> name: sched_switch
> ID: 285
> format:
> 	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
> 	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
> 	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
> 	field:int common_pid;	offset:4;	size:4;	signed:1;
> 
> 	field:char prev_comm[TASK_COMM_LEN];	offset:8;	size:16;	signed:0;
>                              ^^^^^^^^^^^^^^                          ^^
>                             is ignored                             is used
> 
> 
> 	field:pid_t prev_pid;	offset:24;	size:4;	signed:1;
> 	field:int prev_prio;	offset:28;	size:4;	signed:1;
> 	field:long prev_state;	offset:32;	size:8;	signed:1;
> 	field:char next_comm[TASK_COMM_LEN];	offset:40;	size:16;	signed:0;
> 	field:pid_t next_pid;	offset:56;	size:4;	signed:1;
> 	field:int next_prio;	offset:60;	size:4;	signed:1;
> 
> print fmt: "prev_comm=%s prev_pid=%d prev_prio=%d prev_state=%s%s ==> next_comm=%s next_pid=%d next_prio=%d", REC->prev_comm, REC->prev_pid, REC->prev_prio, (REC->prev_state & ((((0x00000000 | 0x00000001 | 0x00000002 | 0x00000004 | 0x00000008 | 0x00000010 | 0x00000020 | 0x00000040) + 1) << 1) - 1)) ? __print_flags(REC->prev_state & ((((0x00000000 | 0x00000001 | 0x00000002 | 0x00000004 | 0x00000008 | 0x00000010 | 0x00000020 | 0x00000040) + 1) << 1) - 1), "|", { 0x00000001, "S" }, { 0x00000002, "D" }, { 0x00000004, "T" }, { 0x00000008, "t" }, { 0x00000010, "X" }, { 0x00000020, "Z" }, { 0x00000040, "P" }, { 0x00000080, "I" }) : "R", REC->prev_state & (((0x00000000 | 0x00000001 | 0x00000002 | 0x00000004 | 0x00000008 | 0x00000010 | 0x00000020 | 0x00000040) + 1) << 1) ? "+" : "", REC->next_comm, REC->next_pid, REC->next_prio
> 
>    ^^^^^^^
> 
> Is what requires the conversions. So I take that back. It only breaks
> perfetto, and that's because it writes its own parser and doesn't use
> libtraceevent.

Actually, there are cases that this needs to be a number, as b3bc8547d3be6
("tracing: Have TRACE_DEFINE_ENUM affect trace event types as well") made
it update fields as well as the printk fmt.

I think because libtraceevent noticed that it was a "char" array, it just
defaults to "size". But this does have meaning for all other types, and I
can see other parsers requiring that.

-- Steve

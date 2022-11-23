Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799E0634E5C
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 04:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbiKWDdD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 22:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbiKWDdD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 22:33:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F48119C37;
        Tue, 22 Nov 2022 19:33:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4DED619FA;
        Wed, 23 Nov 2022 03:33:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A00DC433C1;
        Wed, 23 Nov 2022 03:33:00 +0000 (UTC)
Date:   Tue, 22 Nov 2022 22:32:58 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zheng Yejian <zhengyejian1@huawei.com>
Cc:     <mhiramat@kernel.org>, <yujie.liu@intel.com>,
        <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tracing: Optimize event type allocation with IDA
Message-ID: <20221122223258.10faaf4e@rorschach.local.home>
In-Reply-To: <20221123031806.735511-1-zhengyejian1@huawei.com>
References: <20221111234137.90d9ec624497a7e1f5cb5003@kernel.org>
        <20221123031806.735511-1-zhengyejian1@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 23 Nov 2022 11:18:06 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> But Yujie Liu <yujie.liu@intel.com> reported a problem that highly
> reproducible after applying this patch:
> Link: https://lore.kernel.org/lkml/54f23c9c-97ae-e326-5873-bfa5d2c81f52@intel.com/
> 
> So please DO NOT apply this patch before I find what happened about it.

I know what the issue is.

The current way of assigning types is to always increment. And not to
reuse until it fills up. And even then, it looks for the next available
number.

I'm guessing the IDA will reuse a number as soon as it is freed. This
may also have uncovered a bug, as in reality, we must actually clear
the tracing buffers every time a number is reused.

What happens is that the type number is associated to a print format.
That is, the raw data is tagged with the type. This type maps to how to
parse the raw data. If you have a kprobe, it creates a new type number.
If you free it, and create another one. With the IDA, it is likely to
reassign the previously freed number to a new probe.

To explain this better, let's look at the following scenario:

 echo 'p:foo val=$arg1:u64' > kprobe_events
 echo 1 > events/kprobes/foo/enable
 sleep 1
 echo 0 > events/kprobes/foo/enable

 echo 'p:bar val=+0($arg1):string' > kprobe_events

 # foo kprobe is deleted and bar is created and
 # with IDA, bar has the same number for type as foo

 cat trace

When you read the trace, it will see a binary blob representing an
event and marked with a type. Although the event was foo, it will now
map it to bar. And it will read foo's $arg1:u64 as bar's
+0($arg1):string, and will crash.

-- Steve

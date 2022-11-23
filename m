Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E746351C2
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 09:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiKWIBG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 03:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235733AbiKWIBE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 03:01:04 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C598F101F6;
        Wed, 23 Nov 2022 00:01:02 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NHD415fBJzqSdg;
        Wed, 23 Nov 2022 15:57:05 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 16:01:00 +0800
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml100012.china.huawei.com (7.185.36.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 16:01:00 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <rostedt@goodmis.org>
CC:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mhiramat@kernel.org>, <yujie.liu@intel.com>,
        <zhengyejian1@huawei.com>, <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tracing: Optimize event type allocation with IDA
Date:   Wed, 23 Nov 2022 16:01:33 +0800
Message-ID: <20221123080133.1128186-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221122223258.10faaf4e@rorschach.local.home>
References: <20221122223258.10faaf4e@rorschach.local.home>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.61]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 22 Nov 2022 22:32:58 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 23 Nov 2022 11:18:06 +0800
> Zheng Yejian <zhengyejian1@huawei.com> wrote:
>
> > But Yujie Liu <yujie.liu@intel.com> reported a problem that highly
> > reproducible after applying this patch:
> > Link: https://lore.kernel.org/lkml/54f23c9c-97ae-e326-5873-bfa5d2c81f52@intel.com/
> >
> > So please DO NOT apply this patch before I find what happened about it.
>
> I know what the issue is.
>
> The current way of assigning types is to always increment. And not to
> reuse until it fills up. And even then, it looks for the next available
> number.
>
> I'm guessing the IDA will reuse a number as soon as it is freed. This

Yes, it is.

> may also have uncovered a bug, as in reality, we must actually clear
> the tracing buffers every time a number is reused.

Thanks for your explanation!

It seems almost the case, and with current way of assigning types, this
problem maybe also happend when reuse type id, am I right?

But instead of clear tracing buffers, would it be better to just mark
that record invalid if we had a way of knowing that the format had changed?

>
> What happens is that the type number is associated to a print format.
> That is, the raw data is tagged with the type. This type maps to how to
> parse the raw data. If you have a kprobe, it creates a new type number.
> If you free it, and create another one. With the IDA, it is likely to
> reassign the previously freed number to a new probe.
>
> To explain this better, let's look at the following scenario:
>
>  echo 'p:foo val=$arg1:u64' > kprobe_events
>  echo 1 > events/kprobes/foo/enable
>  sleep 1
>  echo 0 > events/kprobes/foo/enable
>
>  echo 'p:bar val=+0($arg1):string' > kprobe_events
>
>  # foo kprobe is deleted and bar is created and
>  # with IDA, bar has the same number for type as foo
>
>  cat trace
>
> When you read the trace, it will see a binary blob representing an
> event and marked with a type. Although the event was foo, it will now
> map it to bar. And it will read foo's $arg1:u64 as bar's
> +0($arg1):string, and will crash.
>
> -- Steve

Return-Path: <bpf+bounces-9045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A39CB78EBFC
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 13:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E10A1C20A3F
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 11:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187909441;
	Thu, 31 Aug 2023 11:29:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02FC8C10
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 11:29:50 +0000 (UTC)
Received: from out-246.mta0.migadu.com (out-246.mta0.migadu.com [IPv6:2001:41d0:1004:224b::f6])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6970ECE4
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 04:29:48 -0700 (PDT)
Message-ID: <0261d27e-f9b5-c0fe-1bae-2b76062e7386@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1693481386; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dsNW9x8p5/MYaUYpuhJyG4wYF90x9MqL7y3yj9nXMaw=;
	b=rFYBUzi7n5za5aMrFhJ4GszeFjuiR8iEUoh2gz36MHNgVXaRvr6oKzSHzSa0TF8Yc1Y+C7
	4NdsAjh6NluDOmkeNKmBJ+O4kBBc7ai1mTpIr4qHujy6FQAkoq8UAKa7gHpcWJ3NImYl0D
	X+WckfDgDdRvciIjC/jh6wNZ8JADGGQ=
Date: Thu, 31 Aug 2023 07:29:38 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH 3/6] bpf: task_group_seq_get_next: fix the
 skip_if_dup_files check
Content-Language: en-US
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yonghong Song <yhs@fb.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Kui-Feng Lee <kuifeng@fb.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230825161842.GA16750@redhat.com>
 <20230825161947.GA16871@redhat.com> <20230825170406.GA16800@redhat.com>
 <e254a6db-66eb-8bfc-561f-464327a1005a@linux.dev>
 <20230827201909.GC28645@redhat.com>
 <ac60ff18-22b0-0291-256c-0e0c3abb7b62@linux.dev>
 <20230828105453.GB19186@redhat.com>
 <25be098a-dc41-7907-5590-1835308ebe28@linux.dev>
 <20230830235459.GA3570@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230830235459.GA3570@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/30/23 7:54 PM, Oleg Nesterov wrote:
> On 08/28, Yonghong Song wrote:
>>
>> On 8/28/23 3:54 AM, Oleg Nesterov wrote:
>>>
>>> Could you review 6/6 as well?
>>
>> I think we can wait patch 6/6 after
>>     https://lore.kernel.org/all/20230824143142.GA31222@redhat.com/
>> is merged.
> 
> OK.
> 
>>> Should I fold 1-5 into a single patch? I tried to document every change
>>> and simplify the review, but I do not want to blow the git history.
>>
>> Currently, because patch 6, the whole patch set cannot be tested by
>> bpf CI since it has a build failure:
>>    https://github.com/kernel-patches/bpf/pull/5580
> 
> Heh. I thought this is obvious. I thought you can test 1-5 without 6/6
> and _review_ 6/6.
> 
> I simply can't understand how can this pull/5580 come when I specially
> mentioned
> 
> 	> 6/6 obviously depends on
> 	>
> 	>	[PATCH 1/2] introduce __next_thread(), fix next_tid() vs exec() race
> 	>	https://lore.kernel.org/all/20230824143142.GA31222@redhat.com/
> 	>
> 	> which was not merged yet.
> 
> in 0/6.

The process in CI for testing is fully automated, and it does
not look at commit message. That is why it takes the whole
series. This is true for all other patch set.

> 
>> I suggest you get patch 1-5 and resubmit with tag like
>>    "bpf-next v2"
>>    [Patch bpf-next v2 x/5] ...
>> so CI can build with different architectures and compilers to
>> ensure everything builds and runs fine.
> 
> I think we can wait for
> 
> 	https://lore.kernel.org/all/20230824143142.GA31222@redhat.com/
> 
> as you suggest above, then I'll send the s/next_thread/__next_thread/
> oneliner without 1-5. I no longer think it makes sense to try to cleanup
> the poor task_group_seq_get_next() when IMHO the whole task_iter logic
> needs the complete rewrite. Yes, yes, I know, it is very easy to blame
> someone else's code, sorry can't resist ;)
> 
> The only "fix" in this series is 3/6, but this code has more serious
> bugs, so I guess we can forget it.
> 
> Oleg.
> 


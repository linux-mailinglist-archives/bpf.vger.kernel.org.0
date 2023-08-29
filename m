Return-Path: <bpf+bounces-8872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD6578BC20
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 02:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3ABE280F13
	for <lists+bpf@lfdr.de>; Tue, 29 Aug 2023 00:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8BF7F6;
	Tue, 29 Aug 2023 00:30:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C935366
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 00:30:41 +0000 (UTC)
Received: from out-245.mta1.migadu.com (out-245.mta1.migadu.com [IPv6:2001:41d0:203:375::f5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FCE109
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 17:30:39 -0700 (PDT)
Message-ID: <25be098a-dc41-7907-5590-1835308ebe28@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1693269037; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9IAzTTcmlJQyO6mSLflkzt3IVsbQUOThQfzVBiQYjgE=;
	b=DPm51MEZctaWaOJT9m6vaXzveCc8r6glQAgwpw6xebEcB1WEmJ9bY0NNlj6jtP3x0A1av0
	OY9WOggNlkslYwD2PCp/KWnBVRhsN2Kr5xPSrsQXEDKIm4Vz5vK6NwXV51YmDuaDFr7zcK
	7JFWShgPHfEPCgADkJJG0pQ6hBPEhcI=
Date: Mon, 28 Aug 2023 20:30:29 -0400
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230828105453.GB19186@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/28/23 3:54 AM, Oleg Nesterov wrote:
> On 08/27, Yonghong Song wrote:
>>
>> On 8/27/23 1:19 PM, Oleg Nesterov wrote:
>>>
>>> But. if the group leader M exits then M->files == NULL. And in this case
>>> task_seq_get_next() will need to "inspect" all the sub-threads even if they all
>>> have the same ->files pointer.
>>
>> That is correct. I do not have practical experience on how much
>> possibility this scenario may happen. I assume it should be very low.
> 
> Yes. I just tried to explain why the ->files check looks confusing to me.
> Nevermind.
> 
> Could you review 6/6 as well?

I think we can wait patch 6/6 after
    https://lore.kernel.org/all/20230824143142.GA31222@redhat.com/
is merged.

> 
> Should I fold 1-5 into a single patch? I tried to document every change
> and simplify the review, but I do not want to blow the git history.

Currently, because patch 6, the whole patch set cannot be tested by
bpf CI since it has a build failure:
   https://github.com/kernel-patches/bpf/pull/5580
I suggest you get patch 1-5 and resubmit with tag like
   "bpf-next v2"
   [Patch bpf-next v2 x/5] ...
so CI can build with different architectures and compilers to
ensure everything builds and runs fine.

> 
> Oleg.
> 


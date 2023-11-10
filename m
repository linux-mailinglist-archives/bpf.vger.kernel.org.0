Return-Path: <bpf+bounces-14689-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 536F67E77B8
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 03:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E166FB20F83
	for <lists+bpf@lfdr.de>; Fri, 10 Nov 2023 02:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E931374;
	Fri, 10 Nov 2023 02:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AYElCCxA"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBD47EB
	for <bpf@vger.kernel.org>; Fri, 10 Nov 2023 02:48:39 +0000 (UTC)
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D192D5E
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 18:48:38 -0800 (PST)
Message-ID: <23b55935-0ad4-5a0a-f19a-ba718793902b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699584517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DI0RjHhxJJQvE/86Xcv2shSwxnNPaoQGdfoeGPBB1oY=;
	b=AYElCCxASb/n+8oG3xEboOUISp9ZJmslmGhGLKy4sDXybIu0IG9XMB3GAdcKrqtO9K57V6
	UrMk5qB6mORuyxm6e0LuhooEHmmrLD/ZGDu2f/SlCOv3Z1gelQuGVK3zK7OCd1CB4zaDJI
	uTNT+d/m2ruAE/kZyIFB1Ozv3568Dqs=
Date: Thu, 9 Nov 2023 18:48:32 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 05/11] bpf: Add bpf_map_of_map_fd_{get,put}_ptr()
 helpers
Content-Language: en-US
To: Hou Tao <houtao@huaweicloud.com>, Hou Tao <houtao1@huawei.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, bpf <bpf@vger.kernel.org>,
 paulmck@kernel.org
References: <20231107140702.1891778-1-houtao@huaweicloud.com>
 <20231107140702.1891778-6-houtao@huaweicloud.com>
 <6125c508-82fe-37a4-3aa2-a6c2727c071b@linux.dev>
 <460844a9-a2e6-8cca-dfa1-9073bfffbb76@huaweicloud.com>
 <CAADnVQJJhjWJRvgdi3hTaCn8s1X1CJ5z1bUoKFXw32LTOjBWCg@mail.gmail.com>
 <64581135-5b99-4da7-9e19-e41122393d89@paulmck-laptop>
 <5aeecb90-e4fd-1a3e-b8e5-426c67d12cc6@huaweicloud.com>
 <5a4cd7db-4ef8-4033-aa9e-bf50e3560e46@paulmck-laptop>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <5a4cd7db-4ef8-4033-aa9e-bf50e3560e46@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/9/23 5:45 PM, Paul E. McKenney wrote:
>>>>>>> +void bpf_map_of_map_fd_put_ptr(void *ptr, bool need_defer)
>>>>>>> +{
>>>>>>> +    struct bpf_inner_map_element *element = ptr;
>>>>>>> +
>>>>>>> +    /* Do bpf_map_put() after a RCU grace period and a tasks trace
>>>>>>> +     * RCU grace period, so it is certain that the bpf program which is
>>>>>>> +     * manipulating the map now has exited when bpf_map_put() is
>>>>>>> called.
>>>>>>> +     */
>>>>>>> +    if (need_defer)
>>>>>> "need_defer" should only happen from the syscall cmd? Instead of
>>>>>> adding rcu_head to each element, how about
>>>>>> "synchronize_rcu_mult(call_rcu, call_rcu_tasks)" here?
>>>>> No. I have tried the method before, but it didn't work due to dead-lock
>>>>> (will mention that in commit message in v2). The reason is that bpf
>>>>> syscall program may also do map update through sys_bpf helper. Because
>>>>> bpf syscall program is running with sleep-able context and has
>>>>> rcu_read_lock_trace being held, so call synchronize_rcu_mult(call_rcu,
>>>>> call_rcu_tasks) will lead to dead-lock.

Need to think of a less intrusive solution instead of adding rcu_head to each 
element and lookup also needs an extra de-referencing.

May be the bpf_map_{update,delete}_elem(&outer_map, ....) should not be done by 
the syscall program? Which selftest does it?

Can the inner_map learn that it has been deleted from an outer map that is used 
in a sleepable prog->aux->used_maps? The bpf_map_free_deferred() will then wait 
for a task_trace gp?



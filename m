Return-Path: <bpf+bounces-12337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AEE7CB291
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 20:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAED21C20B22
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 18:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BA5341A7;
	Mon, 16 Oct 2023 18:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SKs2otoj"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2150634195
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 18:33:46 +0000 (UTC)
Received: from out-203.mta0.migadu.com (out-203.mta0.migadu.com [IPv6:2001:41d0:1004:224b::cb])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD55A2
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 11:33:45 -0700 (PDT)
Message-ID: <eb4bd204-17b1-f0cb-93dd-d74999ddb265@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1697481223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BmI76kh43dBmjzgMNopprOw8nRKDf8jqaWGHiQ+q6Pc=;
	b=SKs2otojdfa1Ss5Yhvc8WJYUoarN3sKus91YK8c4ny08xjgS8F89ElxpdtYds4AEzp95ci
	Li59hsdFNkJNszJF7SIuejM/uiciLIaU+atRxUOIkGfJtTHXgqWpUL2S8JHC5f77Vi7crU
	vLrvhUpZ4ga+rulYv61kh42EBP36Q4Y=
Date: Mon, 16 Oct 2023 11:33:36 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] Only run BPF cgroup unix sockaddr recvmsg()
 hooks on named sockets
Content-Language: en-US
To: Kuniyuki Iwashima <kuniyu@amazon.com>, daan.j.demeyer@gmail.com
Cc: bpf@vger.kernel.org, kernel-team@meta.com, netdev@vger.kernel.org
References: <20231012085216.219918-1-daan.j.demeyer@gmail.com>
 <20231012181142.60636-1-kuniyu@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231012181142.60636-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/12/23 11:11 AM, Kuniyuki Iwashima wrote:
> From: Daan De Meyer <daan.j.demeyer@gmail.com>
> Date: Thu, 12 Oct 2023 10:52:13 +0200
>> Changes since v1:
>>
>> * Added missing Signed-off-by tag
> 
> You can put these after --- so that it will disappear when merged.
> 
> 
>>
>> We should not run the recvmsg() hooks on unnamed sockets as we do
>> not run them on unnamed sockets in the other hooks either. We may
>> look into relaxing this later but for now let's make sure we are
>> consistent and not run the hooks on unnamed sockets anywhere.
>>
>> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
>> ---
>>   net/unix/af_unix.c | 14 ++++++++------
>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
>> index e10d07c76044..81fb8bddaff9 100644
>> --- a/net/unix/af_unix.c
>> +++ b/net/unix/af_unix.c
>> @@ -2416,9 +2416,10 @@ int __unix_dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t size,
>>   	if (msg->msg_name) {
>>   		unix_copy_addr(msg, skb->sk);
> 
> How is an unnamed socket set to skb->sk ?

I had a similar question. Most likely socketpair? Please add an explanation in 
the commit message in v3. Please also help to add a selftest for this case.

> 
> 
>>
>> -		BPF_CGROUP_RUN_PROG_UNIX_RECVMSG_LOCK(sk,
>> -						      msg->msg_name,
>> -						      &msg->msg_namelen);
>> +		if (msg->msg_namelen > 0)
>> +			BPF_CGROUP_RUN_PROG_UNIX_RECVMSG_LOCK(sk,
>> +							      msg->msg_name,
>> +							      &msg->msg_namelen);
>>   	}
>>
>>   	if (size > skb->len - skip)
>> @@ -2773,9 +2774,10 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
>>   					 state->msg->msg_name);
>>   			unix_copy_addr(state->msg, skb->sk);
>>
>> -			BPF_CGROUP_RUN_PROG_UNIX_RECVMSG_LOCK(sk,
>> -							      state->msg->msg_name,
>> -							      &state->msg->msg_namelen);
>> +			if (state->msg->msg_namelen > 0)
>> +				BPF_CGROUP_RUN_PROG_UNIX_RECVMSG_LOCK(sk,
>> +								      state->msg->msg_name,
>> +								      &state->msg->msg_namelen);
>>
>>   			sunaddr = NULL;
>>   		}
>> --
>> 2.41.0
>>



Return-Path: <bpf+bounces-41416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4501F996F11
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 17:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1509B275A4
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 15:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE321A2550;
	Wed,  9 Oct 2024 14:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ahjZLxT+"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F087F1A0BE3
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 14:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485994; cv=none; b=dunXF9OORyo2YjnMw84087pBWmER8z/e43/Wv4xKMgk1qdg2cWn9dN8B3cTDowCsNjmakpjoGcfBSbHOjiIrZkU6hxBCJtZXXph55VPC2FBsAn8mPMEBYSgD9jv6akEljST8jNRloRmeS+Braz0ZvPAhJMPtGqr2eqw96YB8+tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485994; c=relaxed/simple;
	bh=qyjfsJwfA1UWxpCp+hU05yXxehld8pBC2ECh6pLqgn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JdHYFzaBl3gVoIMaq4EkH9krh73jMS58FRO94StJfLWwVYd7CBMeM4INU5dLZJmo320408fZbrxgQ2V8o1tFOBUEWwEV/hcCj0vRBFM1b48Fb7zMT6PC1VzvIn/chRL8ZPKWGoI/GTFpPgl1ioGeGhHin0yYnUpHMw2igsZosp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ahjZLxT+; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <662873cb-a897-464e-bdb3-edf01363c3b2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728485989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aRwvrKIiasFpos0WTtiMfaYbqIxZ/meilCsw6pjSXtI=;
	b=ahjZLxT+zbUXkD8gLewZcfK3ubnjZg6WVBon0Ef06j+VLsiV6Np2uvl8YegvvRejtpljeD
	GAbMk1Z4I4Uv3WtucAosoa8BFCRx/PLAhtE2Wdhz6SNLAFS7EGhf3w2pPFVJVmgkjUvAkS
	ENruZci8GsjPwyW37h+VwLvOKbgXLAg=
Date: Wed, 9 Oct 2024 15:59:44 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 0/9] net-timestamp: bpf extension to equip
 applications transparently
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20241008095109.99918-1-kerneljasonxing@gmail.com>
 <67057d89796b_1a41992944c@willemb.c.googlers.com.notmuch>
 <CAL+tcoBGQZWZr3PU4Chn1YiN8XO_2UXGOh3yxbvymvojH3r13g@mail.gmail.com>
 <CAL+tcoC48XCmc3G7Xpb_0=maD1Gi0OLkNbUp4ugwtj69ANPaAw@mail.gmail.com>
 <6b10ed31-c53f-4f99-9c23-e1ba34aa0905@linux.dev>
 <CAL+tcoBL22WsUbooOv6XXcGGugNyogiDhOpszGR_yj-pCdvCkA@mail.gmail.com>
 <CAL+tcoD47VfZJFPJcQOgPsQuGA=jPfKU2548fJp2NBH14gEoHA@mail.gmail.com>
 <9c5b405c-9b3d-4c1f-b278-303fe24c7926@linux.dev>
 <CAL+tcoDDmcPQVUMN-AoGFC4SsmRwdVN+q0MAu+gAWY92Xy_zEA@mail.gmail.com>
 <fd159d60-fe59-4bfa-b143-2432671681b5@linux.dev>
 <CAL+tcoCX4ayowenaT9pBTqGzKQ=pH9BdRPa=1QB2PiJ=+yFxSg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CAL+tcoCX4ayowenaT9pBTqGzKQ=pH9BdRPa=1QB2PiJ=+yFxSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 09/10/2024 15:35, Jason Xing wrote:
> On Wed, Oct 9, 2024 at 9:58 PM Vadim Fedorenko
> <vadim.fedorenko@linux.dev> wrote:
>>
>> On 09/10/2024 14:47, Jason Xing wrote:
>>> On Wed, Oct 9, 2024 at 9:16 PM Vadim Fedorenko
>>> <vadim.fedorenko@linux.dev> wrote:
>>>>
>>>> On 09/10/2024 12:48, Jason Xing wrote:
>>>>> On Wed, Oct 9, 2024 at 7:12 PM Jason Xing <kerneljasonxing@gmail.com> wrote:
>>>>>>
>>>>>> On Wed, Oct 9, 2024 at 5:28 PM Vadim Fedorenko
>>>>>> <vadim.fedorenko@linux.dev> wrote:
>>>>>>>
>>>>>>> On 09/10/2024 02:05, Jason Xing wrote:
>>>>>>>> On Wed, Oct 9, 2024 at 7:22 AM Jason Xing <kerneljasonxing@gmail.com> wrote:
>>>>>>>>>
>>>>>>>>> On Wed, Oct 9, 2024 at 2:44 AM Willem de Bruijn
>>>>>>>>> <willemdebruijn.kernel@gmail.com> wrote:
>>>>>>>>>>
>>>>>>>>>> Jason Xing wrote:
>>>>>>>>>>> From: Jason Xing <kernelxing@tencent.com>
>>>>>>>>>>>
>>>>>>>>>>> A few weeks ago, I planned to extend SO_TIMESTMAMPING feature by using
>>>>>>>>>>> tracepoint to print information (say, tstamp) so that we can
>>>>>>>>>>> transparently equip applications with this feature and require no
>>>>>>>>>>> modification in user side.
>>>>>>>>>>>
>>>>>>>>>>> Later, we discussed at netconf and agreed that we can use bpf for better
>>>>>>>>>>> extension, which is mainly suggested by John Fastabend and Willem de
>>>>>>>>>>> Bruijn. Many thanks here! So I post this series to see if we have a
>>>>>>>>>>> better solution to extend.
>>>>>>>>>>>
>>>>>>>>>>> This approach relies on existing SO_TIMESTAMPING feature, for tx path,
>>>>>>>>>>> users only needs to pass certain flags through bpf program to make sure
>>>>>>>>>>> the last skb from each sendmsg() has timestamp related controlled flag.
>>>>>>>>>>> For rx path, we have to use bpf_setsockopt() to set the sk->sk_tsflags
>>>>>>>>>>> and wait for the moment when recvmsg() is called.
>>>>>>>>>>
>>>>>>>>>> As you mention, overall I am very supportive of having a way to add
>>>>>>>>>> timestamping by adminstrators, without having to rebuild applications.
>>>>>>>>>> BPF hooks seem to be the right place for this.
>>>>>>>>>>
>>>>>>>>>> There is existing kprobe/kretprobe/kfunc support. Supporting
>>>>>>>>>> SO_TIMESTAMPING directly may be useful due to its targeted feature
>>>>>>>>>> set, and correlation between measurements for the same data in the
>>>>>>>>>> stream.
>>>>>>>>>>
>>>>>>>>>>> After this series, we could step by step implement more advanced
>>>>>>>>>>> functions/flags already in SO_TIMESTAMPING feature for bpf extension.
>>>>>>>>>>
>>>>>>>>>> My main implementation concern is where this API overlaps with the
>>>>>>>>>> existing user API, and how they might conflict. A few questions in the
>>>>>>>>>> patches.
>>>>>>>>>
>>>>>>>>> Agreed. That's also what I'm concerned about. So I decided to ask for
>>>>>>>>> related experts' help.
>>>>>>>>>
>>>>>>>>> How to deal with it without interfering with the existing apps in the
>>>>>>>>> right way is the key problem.
>>>>>>>>
>>>>>>>> What I try to implement is let the bpf program have the highest
>>>>>>>> precedence. It's similar to RTO min, see the commit as an example:
>>>>>>>>
>>>>>>>> commit f086edef71be7174a16c1ed67ac65a085cda28b1
>>>>>>>> Author: Kevin Yang <yyd@google.com>
>>>>>>>> Date:   Mon Jun 3 21:30:54 2024 +0000
>>>>>>>>
>>>>>>>>         tcp: add sysctl_tcp_rto_min_us
>>>>>>>>
>>>>>>>>         Adding a sysctl knob to allow user to specify a default
>>>>>>>>         rto_min at socket init time, other than using the hard
>>>>>>>>         coded 200ms default rto_min.
>>>>>>>>
>>>>>>>>         Note that the rto_min route option has the highest precedence
>>>>>>>>         for configuring this setting, followed by the TCP_BPF_RTO_MIN
>>>>>>>>         socket option, followed by the tcp_rto_min_us sysctl.
>>>>>>>>
>>>>>>>> It includes three cases, 1) route option, 2) bpf option, 3) sysctl.
>>>>>>>> The first priority can override others. It doesn't have a good
>>>>>>>> chance/point to restore the icsk_rto_min field if users want to
>>>>>>>> shutdown the bpf program because it is set in
>>>>>>>> bpf_sol_tcp_setsockopt().
>>>>>>>
>>>>>>> rto_min example is slightly different. With tcp_rto_min the doesn't
>>>>>>> expect any data to come back to user space while for timestamping the
>>>>>>> app may be confused directly by providing more data, or by not providing
>>>>>>> expected data. I believe some hint about requestor of the data is needed
>>>>>>> here. It will also help to solve the problem of populating sk_err_queue
>>>>>>> mentioned by Martin.
>>>>>>
>>>>>> Sorry, I don't fully get it. In this patch series, this bpf extension
>>>>>> feature will not rely on sk_err_queue any more to report tx timestamps
>>>>>> to userspace. Bpf program can do that printing.
>>>>>>
>>>>>> Do you mean that it could be wrong if one skb carries the tsflags that
>>>>>> are previously set due to the bpf program and then suddenly users
>>>>>> detach the program? It indeed will put a new/cloned skb into the error
>>>>>> queue. Interesting corner case. It seems I have to re-implement a
>>>>>> totally independent tsflags for bpf extension feature. Do you have a
>>>>>> better idea on this?
>>>>>
>>>>> I feel that if I could introduce bpf new flags like
>>>>> SOF_TIMESTAMPING_TX_ACK_BPF for the last skb based on this patch
>>>>> series, then it will not populate skb in sk_err_queue even users
>>>>> remove the bpf program all of sudden. With this kind of specific bpf
>>>>> flags, we can also avoid conflicting with the apps using
>>>>> SO_TIEMSTAMPING feature. Let me give it a shot unless a better
>>>>> solution shows up.
>>>>
>>>> It doesn't look great to have duplicate flags just to indicate that this
>>>> particular timestamp was asked by a bpf program, even though it looks
>>>
>>> Or introduce a new field in struct sock or struct sk_buff so that
>>> existing SOF_TIMESTAMPING_* can be reused.
>>
>> Well, I was thinking about this way. We can potentially add an array of
>> tsflags meaning the index of the array is the requestor. That will be
>> more flexible in terms of adding new requestor (like scheduler or
>> congestion control algo) if needed. But it comes with increased memory
>> usage on hot path which might be a blocker.
> 
> Is the following code snippet what you expect? But I wonder why not
> just add a u32 field instead and then use each bit of it defined in
> include/uapi/linux/net_tstamp.h?
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index b32f1424ecc5..4677f53da75a 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -445,6 +445,7 @@ struct sock {
>          u32                     sk_reserved_mem;
>          int                     sk_forward_alloc;
>          u32                     sk_tsflags;
> +       u32                     new_tsflags[10];
>          __cacheline_group_end(sock_write_rxtx);
> 
>          __cacheline_group_begin(sock_write_tx);
> 
> I could be missing something. Sorry. If possible, could you show me
> some code snippets?
> 
> As for the new requestor, IIUC, do you want to add more tx timestamp
> generating points in the future?

It's more like this:

diff --git a/include/net/sock.h b/include/net/sock.h
index c58ca8dd561b..93f931dcc4cc 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -234,6 +234,14 @@ struct sock_common {
  struct bpf_local_storage;
  struct sk_filter;

+enum {
+       SOCKETOPT_TS_REQUESTOR = 0,
+       CMSG_TS_REQUESTOR,
+       BPFPROG_TS_REQUESTOR,
+
+       __MAX_TS_REQUESTOR,
+};
+
  /**
    *    struct sock - network layer representation of sockets
    *    @__sk_common: shared layout with inet_timewait_sock
@@ -444,7 +452,7 @@ struct sock {
         socket_lock_t           sk_lock;
         u32                     sk_reserved_mem;
         int                     sk_forward_alloc;
-       u32                     sk_tsflags;
+       u32                     sk_tsflags[__MAX_TS_REQUESTOR];
         __cacheline_group_end(sock_write_rxtx);

         __cacheline_group_begin(sock_write_tx);


And use existing SOF_TIMESTAMPING_* for each element in the array. Not
sure that struct sock is the best place though, as some timestamping
requests may be on per-packet basis for protocols other than TCP.

Again, I'm just thinking out loud, kinda wild idea.



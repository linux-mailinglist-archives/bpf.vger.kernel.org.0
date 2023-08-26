Return-Path: <bpf+bounces-8745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7906378965B
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 13:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DF3828187F
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 11:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CFCD539;
	Sat, 26 Aug 2023 11:54:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D2A2F30;
	Sat, 26 Aug 2023 11:54:08 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F03C2123;
	Sat, 26 Aug 2023 04:54:06 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RXw9h2q8zztRqF;
	Sat, 26 Aug 2023 19:50:16 +0800 (CST)
Received: from [10.174.176.93] (10.174.176.93) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 26 Aug 2023 19:54:03 +0800
Message-ID: <389e52fe-13e9-4ded-bfb0-fcffea9b1cbf@huawei.com>
Date: Sat, 26 Aug 2023 19:54:02 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH bpf-next v3 1/7] bpf, sockmap: add BPF_F_PERMANENT flag
 for skmsg redirect
To: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki
	<jakub@cloudflare.com>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
	<kpsingh@kernel.org>, <sdf@google.com>, <haoluo@google.com>,
	<jolsa@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <dsahern@kernel.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20230824143959.1134019-1-liujian56@huawei.com>
 <20230824143959.1134019-2-liujian56@huawei.com>
 <87r0nr5j0a.fsf@cloudflare.com> <64e95611f1b33_1d0032088c@john.notmuch>
From: "liujian (CE)" <liujian56@huawei.com>
In-Reply-To: <64e95611f1b33_1d0032088c@john.notmuch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.93]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/26 9:32, John Fastabend wrote:
> Jakub Sitnicki wrote:
>> On Thu, Aug 24, 2023 at 10:39 PM +08, Liu Jian wrote:
>>> If the sockmap msg redirection function is used only to forward packets
>>> and no other operation, the execution result of the BPF_SK_MSG_VERDICT
>>> program is the same each time. In this case, the BPF program only needs to
>>> be run once. Add BPF_F_PERMANENT flag to bpf_msg_redirect_map() and
>>> bpf_msg_redirect_hash() to implement this ability.
>>>
>>> Then we can enable this function in the bpf program as follows:
>>> bpf_msg_redirect_hash(xx, xx, xx, BPF_F_INGRESS | BPF_F_PERMANENT);
>>>
>>> Test results using netperf  TCP_STREAM mode:
>>> for i in 1 64 128 512 1k 2k 32k 64k 100k 500k 1m;then
>>> netperf -T 1,2 -t TCP_STREAM -H 127.0.0.1 -l 20 -- -m $i -s 100m,100m -S 100m,100m
>>> done
>>>
>>> before:
>>> 3.84 246.52 496.89 1885.03 3415.29 6375.03 40749.09 48764.40 51611.34 55678.26 55992.78
>>> after:
>>> 4.43 279.20 555.82 2080.79 3870.70 7105.44 41836.41 49709.75 51861.56 55211.00 54566.85
>>>
>>> Signed-off-by: Liu Jian <liujian56@huawei.com>
> 
> [...]
> 
>>>   /* BPF_FUNC_skb_set_tunnel_key and BPF_FUNC_skb_get_tunnel_key flags. */
>>> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
>>> index a29508e1ff35..df1443cf5fbd 100644
>>> --- a/net/core/skmsg.c
>>> +++ b/net/core/skmsg.c
>>> @@ -885,6 +885,11 @@ int sk_psock_msg_verdict(struct sock *sk, struct sk_psock *psock,
>>>   			goto out;
>>>   		}
>>>   		psock->redir_ingress = sk_msg_to_ingress(msg);
>>> +		if (!msg->apply_bytes && !msg->cork_bytes)
>>> +			psock->redir_permanent =
>>> +				msg->flags & BPF_F_PERMANENT;
>>> +		else
>>> +			psock->redir_permanent = false;
>>
>> Above can be rewritten as:
>>
>> 		psock->redir_permanent = !msg->apply_bytes &&
>> 					 !msg->cork_bytes &&
>> 					 (msg->flags & BPF_F_PERMANENT);
>>
>> But as I wrote earlier, I don't think it's a good idea to ignore the
>> flag. We can detect this conflict at the time the bpf_msg_sk_redirect_*
>> helper is called and return an error.
>>
>> Naturally that means that that bpf_msg_{cork,apply}_bytes helpers need
>> to be adjusted to return an error if BPF_F_PERMANENT has been set.
> 
> So far we've not really done much to protect a user from doing
> rather silly things. The following will all do something without
> errors,
> 
>    bpf_msg_apply_bytes()
>    bpf_msg_apply_bytes() <- reset apply bytes
> 
>    bpf_msg_cork_bytes()
>    bpf_msg_cork_bytes() <- resets cork byte
> 
> also,
> 
>    bpf_msg_redirect(..., BPF_F_INGRESS);
>    bpf_msg_redirect(..., 0); <- resets sk_redir and flags
> 
> maybe there is some valid reason to even do above if further parsing
> identifies some reason to redirect to a alert socket or something.
> 
> My original thinking was in the interest of not having a bunch of
> extra checks for performance reasons we shouldn't add guard rails
> unless something really unexpected might happen like a kernel
> panic or what not.
> 
> This does feel a bit different though because before we
> didn't have calls that could impact other calls. My best idea
> is to just create a precedence and follow it. I would propose,
> 
> 'If BPF_F_PERMANENT is set apply_bytes and cork_bytes are
>   ignored.'
> 
I think it's better.
Both low-priority or high-priority are ok for me. But I think it's 
better that BPF_F_PERMANENT has a low priority. Because BPF_F_PERMANEN 
is only for performance, and apply_bytes or cork_bytes may be used to a 
user logic function.

> The other direction (what is above?) has a bit of an inconsistency
> where these two flows are different?
> 
>    bpf_apply_bytes()
>    bpf_msg_redirect(..., BPF_F_PERMANENT)
> 
> and
> 
>    bpf_msg_redirect(..., BPF_F_PERMANENT)
>    bpf_apply_bytes()
> 
> It would be best if order of operations doesn't change the
> outcome because that starts to get really hard to reason about.
> 
> This avoids having to add checks all over the place and then
> if users want we could give some mechanisms to read apply
> and cork bytes so people could write macros over those if
> they really want the hard error.
> 
> WDYT?
> 
> [...]
> 
> Thanks!


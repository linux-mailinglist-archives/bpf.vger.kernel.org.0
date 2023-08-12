Return-Path: <bpf+bounces-7632-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76070779D02
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 05:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07989281604
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 03:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13111868;
	Sat, 12 Aug 2023 03:35:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2ED1849
	for <bpf@vger.kernel.org>; Sat, 12 Aug 2023 03:35:42 +0000 (UTC)
Received: from out-75.mta0.migadu.com (out-75.mta0.migadu.com [91.218.175.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5466130F9
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 20:35:40 -0700 (PDT)
Message-ID: <7e5ac25e-846e-65e6-4398-e125c3d879ee@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691811338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XAXYqhkH94NpjZtXkSjDVfUvFBXTPA6v1zJVdiQu3pI=;
	b=NT1IqBAIBAk5oJquJFJ53AGvlWGGI0GY5cEJ1uAkVnPzfvYcrTFRgRWLx+6jU20qu4H0Wc
	QHtCgkIj9HDd6VjX6yR5kieOQzpUOFWP1n2T/hmpn9iPNKzhzsMieEMMexSotD+tpxRO6K
	QE/mK0KyM1tb0EZGhxrCZGAPyJAeZdo=
Date: Fri, 11 Aug 2023 20:35:35 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] net: Fix slab-out-of-bounds in
 inet[6]_steal_sock
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: lmb@isovalent.com
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 martin.lau@kernel.org, memxor@gmail.com, netdev@vger.kernel.org,
 pabeni@redhat.com, Kuniyuki Iwashima <kuniyu@amazon.com>
References: <CAN+4W8hMpL3+vNOrBBRw01tD6OxQ-Yy8OWpq9nRtiyjm0GgE4g@mail.gmail.com>
 <20230809155538.67000-1-kuniyu@amazon.com>
 <7899f188-763a-662e-c725-4d89f17b2972@linux.dev>
In-Reply-To: <7899f188-763a-662e-c725-4d89f17b2972@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/9/23 10:12 AM, Martin KaFai Lau wrote:
> On 8/9/23 8:55 AM, Kuniyuki Iwashima wrote:
>> From: Lorenz Bauer <lmb@isovalent.com>
>> Date: Wed, 9 Aug 2023 16:08:31 +0100
>>> On Wed, Aug 9, 2023 at 3:39 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>>>
>>>> On 8/9/23 1:33 AM, Lorenz Bauer wrote:
>>>>> Kumar reported a KASAN splat in tcp_v6_rcv:
>>>>>
>>>>>     bash-5.2# ./test_progs -t btf_skc_cls_ingress
>>>>>     ...
>>>>>     [   51.810085] BUG: KASAN: slab-out-of-bounds in tcp_v6_rcv+0x2d7d/0x3440
>>>>>     [   51.810458] Read of size 2 at addr ffff8881053f038c by task 
>>>>> test_progs/226
>>>>>
>>>>> The problem is that inet[6]_steal_sock accesses sk->sk_protocol without
>>>>> accounting for request sockets. I added the check to ensure that we only
>>>>> every try to perform a reuseport lookup on a supported socket.
>>>>>
>>>>> It turns out that this isn't necessary at all. struct sock_common contains
>>>>> a skc_reuseport flag which indicates whether a socket is part of a
>>>>
>>>> Does it go back to the earlier discussion
>>>> (https://lore.kernel.org/bpf/7188429a-c380-14c8-57bb-9d05d3ba4e5e@linux.dev/)
>>>> that the sk->sk_reuseport is 1 from sk_clone for TCP_ESTABLISHED? It works
>>>> because there is sk->sk_reuseport"_cb" check going deeper into
>>>> reuseport_select_sock() but there is an extra inet6_ehashfn for all 
>>>> TCP_ESTABLISHED.
>>>
>>> Sigh, I'd forgotten about this...
>>>
>>> For the TPROXY TCP replacement use case we sk_assign the SYN to the
>>> listener, which creates the reqsk. We can let follow up packets pass
>>> without sk_assign since they will match the reqsk and convert to a
>>> fullsock via the usual route. At least that is what the test does. I'm
>>> not even sure what it means to redirect a random packet into an
>>> established TCP socket TBH. It'd probably be dropped?
> 
> It could act like an earlier early-demux for established sk? If the bpf prog has 
> already looked up an established sk for other needs (eg. reading the sk local 
> storage), it may as well bpf_sk_assign it to the skb. I don't have a use case 
> for that but I also don't see why it won't work also.
> 
>>>
>>> For UDP, I'm not sure whether we even get into this situation? Doesn't
>>> seem like UDP sockets are cloned from each other, so we also shouldn't
>>> end up with a reuseport flag set erroneously.
>>>
>>> Things we could do if necessary:
>>> 1. Reset the flag in inet_csk_clone_lock like we do for SOCK_RCU_FREE
>>
>> I think we can't do this as sk_reuseport is inherited to twsk and used
>> in inet_bind_conflict().
>>
>>
>>> 2. Duplicate the cb check into inet[6]_steal_sock
>>
>> or 3. Add sk_fullsock() test ?
> 
> yeah, probably adding sk_fullsock() is needed, may be something like(?):
> 
>      if (!prefetched || !sk_fullsock(sk))
>                  return sk;

Friendly ping. Thanks.



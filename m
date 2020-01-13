Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8B313952A
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2020 16:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgAMPsu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jan 2020 10:48:50 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39240 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgAMPsu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jan 2020 10:48:50 -0500
Received: by mail-lj1-f195.google.com with SMTP id l2so10608913lja.6
        for <bpf@vger.kernel.org>; Mon, 13 Jan 2020 07:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=51yD4BqU0bWqVd7ntuW6FnYah+NnBC6M9yv7K4akYVA=;
        b=XJFwoj52wly3jJcjqf7SiTLkYHTharJdMxLePTalVF8djqcUG95tORny36WSidwH7f
         j9EXfxV1euwyhx5ExXWL4DQbtm8o++EGsDsuMRgdH018gohVqUCs1/gKKGpXE970rTco
         M/tSO7SagFeU03/cJS7OVqRvBTcR2vacaWhCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=51yD4BqU0bWqVd7ntuW6FnYah+NnBC6M9yv7K4akYVA=;
        b=IgKm53gjPbwo5+Sz1YmWUlHoktUg77QHO2L8D4SUfvmZ+tuY6+EQr/1k9aDeh63DDE
         lVQa6rkdwvpdV87Oxtapo7s6cyM3baD1pWvxsasvgGlkQZBBBedrv6o9OTOnSaSqjX9Z
         cn51jD+dGrQAVjqzvJiVCzgGJC4GaHjhfiSRN0SJE/e2btp5kRTK3jHPllz0gIlqWkAG
         PRv3Vp3gIQAp7kjUYQoKXLQob7R61flG7QIVg/hUQNzBYCRTKKSBsai/2LiAMf6jSbGC
         Er1jUjzxM+jQJ5J0J4wogziWs/T6M0SvwIWXOvFe2/I6K1K0g9M7pdFJH/msa8H1ySFV
         ahig==
X-Gm-Message-State: APjAAAW+LGSk9n22tKxibwhw51zD3SZr5ag8FcrZMGGnQCrftR/Hz8t0
        Gfud6bpZqkGItDgZ8dAOUBgfFg==
X-Google-Smtp-Source: APXvYqwQYyi0Xo2b7UiFJ4L8MGTDZHWjzoOfMioSSKq+3kDzllwtsOIVk5rGXwkTR8StfHHujlFeJQ==
X-Received: by 2002:a2e:93c5:: with SMTP id p5mr10879289ljh.192.1578930527948;
        Mon, 13 Jan 2020 07:48:47 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id t27sm6178162ljd.26.2020.01.13.07.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 07:48:47 -0800 (PST)
References: <20200110105027.257877-1-jakub@cloudflare.com> <20200110105027.257877-6-jakub@cloudflare.com> <5e1a615bedf9c_1e7f2b0c859c45c01f@john-XPS-13-9370.notmuch>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@cloudflare.com, Eric Dumazet <edumazet@google.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: Re: [PATCH bpf-next v2 05/11] bpf, sockmap: Allow inserting listening TCP sockets into sockmap
In-reply-to: <5e1a615bedf9c_1e7f2b0c859c45c01f@john-XPS-13-9370.notmuch>
Date:   Mon, 13 Jan 2020 16:48:46 +0100
Message-ID: <87lfqbs6g1.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jan 12, 2020 at 12:59 AM CET, John Fastabend wrote:
> Jakub Sitnicki wrote:
>> In order for sockmap type to become a generic collection for storing TCP
>> sockets we need to loosen the checks during map update, while tightening
>> the checks in redirect helpers.
>>
>> Currently sockmap requires the TCP socket to be in established state (or
>> transitioning out of SYN_RECV into established state when done from BPF),
>> which prevents inserting listening sockets.
>>
>> Change the update pre-checks so that the socket can also be in listening
>> state. If the state is not white-listed, return -EINVAL to be consistent
>> with REUSEPORT_SOCKARRY map type.
>>
>> Since it doesn't make sense to redirect with sockmap to listening sockets,
>> add appropriate socket state checks to BPF redirect helpers too.
>>
>> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> ---
>>  net/core/sock_map.c                     | 46 ++++++++++++++++++++-----
>>  tools/testing/selftests/bpf/test_maps.c |  6 +---
>>  2 files changed, 39 insertions(+), 13 deletions(-)
>>
>> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
>> index eb114ee419b6..99daea502508 100644
>> --- a/net/core/sock_map.c
>> +++ b/net/core/sock_map.c
>> @@ -396,6 +396,23 @@ static bool sock_map_sk_is_suitable(const struct sock *sk)
>>  	       sk->sk_protocol == IPPROTO_TCP;
>>  }
>>
>> +/* Is sock in a state that allows inserting into the map?
>> + * SYN_RECV is needed for updates on BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB.
>> + */
>> +static bool sock_map_update_okay(const struct sock *sk)
>> +{
>> +	return (1 << sk->sk_state) & (TCPF_ESTABLISHED |
>> +				      TCPF_SYN_RECV |
>> +				      TCPF_LISTEN);
>> +}
>> +
>> +/* Is sock in a state that allows redirecting into it? */
>> +static bool sock_map_redirect_okay(const struct sock *sk)
>> +{
>> +	return (1 << sk->sk_state) & (TCPF_ESTABLISHED |
>> +				      TCPF_SYN_RECV);
>> +}
>> +
>>  static int sock_map_update_elem(struct bpf_map *map, void *key,
>>  				void *value, u64 flags)
>>  {
>> @@ -413,11 +430,14 @@ static int sock_map_update_elem(struct bpf_map *map, void *key,
>>  		ret = -EINVAL;
>>  		goto out;
>>  	}
>> -	if (!sock_map_sk_is_suitable(sk) ||
>> -	    sk->sk_state != TCP_ESTABLISHED) {
>> +	if (!sock_map_sk_is_suitable(sk)) {
>>  		ret = -EOPNOTSUPP;
>>  		goto out;
>>  	}
>> +	if (!sock_map_update_okay(sk)) {
>> +		ret = -EINVAL;
>> +		goto out;
>> +	}
>
> I nit but seeing we need a v3 anyways. How about consolidating
> this state checks into sock_map_sk_is_suitable() so we don't have
> multiple if branches or this '|| TCP_ESTABLISHED' like we do now.

Ah, I see the pattern now :-)

>>
>>  	sock_map_sk_acquire(sk);
>>  	ret = sock_map_update_common(map, idx, sk, flags);
>> @@ -433,6 +453,7 @@ BPF_CALL_4(bpf_sock_map_update, struct bpf_sock_ops_kern *, sops,
>>  	WARN_ON_ONCE(!rcu_read_lock_held());
>>
>>  	if (likely(sock_map_sk_is_suitable(sops->sk) &&
>> +		   sock_map_update_okay(sops->sk) &&
>>  		   sock_map_op_okay(sops)))
>>  		return sock_map_update_common(map, *(u32 *)key, sops->sk,
>>  					      flags);
>> @@ -454,13 +475,17 @@ BPF_CALL_4(bpf_sk_redirect_map, struct sk_buff *, skb,
>>  	   struct bpf_map *, map, u32, key, u64, flags)
>>  {
>>  	struct tcp_skb_cb *tcb = TCP_SKB_CB(skb);
>> +	struct sock *sk;
>>
>>  	if (unlikely(flags & ~(BPF_F_INGRESS)))
>>  		return SK_DROP;
>> -	tcb->bpf.flags = flags;
>> -	tcb->bpf.sk_redir = __sock_map_lookup_elem(map, key);
>> -	if (!tcb->bpf.sk_redir)
>> +
>> +	sk = __sock_map_lookup_elem(map, key);
>> +	if (!sk || !sock_map_redirect_okay(sk))
>>  		return SK_DROP;
>
> unlikely(!sock_map_redirect_okay)? Or perhaps unlikely the entire case,
> if (unlikely(!sk || !sock_map_redirect_okay(sk)). I think users should
> know if the sk is a valid sock or not and this is just catching the
> error case. Any opinion?
>
> Otherwise looks good.

Both ideas SGTM. Will incorporate into next version. Thanks!

-jkbs

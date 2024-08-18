Return-Path: <bpf+bounces-37464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F60955CEB
	for <lists+bpf@lfdr.de>; Sun, 18 Aug 2024 16:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BD32281860
	for <lists+bpf@lfdr.de>; Sun, 18 Aug 2024 14:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4FA12FB34;
	Sun, 18 Aug 2024 14:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUEo89sk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f196.google.com (mail-il1-f196.google.com [209.85.166.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935884204F;
	Sun, 18 Aug 2024 14:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723990665; cv=none; b=c2RuUGjIKZQYm45o1HGGx9bCdTzwwYGCgGDFsFqUixS0EfmETcLhwSdE8mKSJycL3VseYJzijHoi8HyNdUGsySY1n4BdN5B+6Z9A7tLq4jihxr6qHITO1ry0w7Tx5d/cN99LDGPsOTR8+J0UXqByqzDohw3nvJHbvOPq9N1k6kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723990665; c=relaxed/simple;
	bh=6nNVpF+Vm7NrX2gLY+hIQHBGaxPnNvn8o5yKk62Kfoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nc188HIyQtZcvGK7ULsz1i2o29RTeOZQkTHAoSO2GkNV77neMAlxjO4rueFnwtEFPh/dRkBF76Psaqun6nUC4wgj/ChhUj8Hb6mrpSzjHTvfGV39e2ecClP75cAFm4X3pdvaaUBI6PDl1pwkKiOhcCTXY8aSU+9dRsq6MOVdPSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUEo89sk; arc=none smtp.client-ip=209.85.166.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f196.google.com with SMTP id e9e14a558f8ab-39d3b89ded1so3080225ab.0;
        Sun, 18 Aug 2024 07:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723990663; x=1724595463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=igRESwxkkOYCmI3kk7WD91SgoIsrggD/4/FzQZ+toYw=;
        b=mUEo89ska7d50+qvMLQULDAQAv7OT5zHk4yC7iI5kEEUdRJ/s2Te92bnny09wSQaM8
         j8LUCxAav1k4r4SdJfj3iYpab6EnSOMG3U7kTwBqjaDPwEedHPmhSVc/jEucPP5CfhMu
         +6LBGUU83FtAkeUEu90HpbfHyuUV/OuaM2wOvr+H1s1OwjBre+an5Q60Ltpm6Zn2wNM/
         azulTxoCWBJ5x54DTAXJJqJSdjOurpVpPbUyGBoQuTpyC6PAp1gjSMAqZr7RLr3X6HCp
         V9HV85kgKkQnrrPDp9aRFKt+cNNWzLugq0k+m0Zx/4n4+ETninFzFZ5p0dR0d3SJjeN+
         vMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723990663; x=1724595463;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=igRESwxkkOYCmI3kk7WD91SgoIsrggD/4/FzQZ+toYw=;
        b=bkwT1cYoqZqZu0WH8Voj70xMUWaE/3Ps77RsQJSmkp1zZwlY46fNR65E0+eiBrtfLy
         gz7yWb7P3F2hvnkncCbkIKeuQA99vXVubCL6bMfdu+Ou6PAw5CQWOQvtu+mhWJYHoctQ
         if2ofYOJx1T9F+G3apRciXXWh6raOMulFI2rH/k8EssKhgMM2ndYIeyFVIkTBnCsMFxB
         ZujuGc1CL4FN8U8MY5lXavvjySVMTCeptlodp1jq3TCzPPPT2xz9Nkuj/AeZ2A94ztlb
         CylDLxmZDN85lsvyjcXEpKlAUZ9zpNaFR7d0FuAhvAp5makw2P1oc6l9kjEiuwrnZj9u
         zqbw==
X-Forwarded-Encrypted: i=1; AJvYcCWNMVSxvYbtczycRJcsgrMfy12V3ngNRm4VtcqeKZiW+5r/BjAUgwaQiGfCCUeyFpQMSOOk3XkULH2i16uqViTln+n+udQOQnkx8/5QnsnAyEuOhOZIyg7GcI2T0rfkSnsJ
X-Gm-Message-State: AOJu0YztJDff2WjiNNHb8EJtGFer/SLkEoum7Mh+jLY/0MhG0cLjqr2k
	lJknQnFJPH4VYrMll4h1Dq2gBFKQpf940qzPfd+ioROm1Gqxxg+F
X-Google-Smtp-Source: AGHT+IHyioT2jk/OQW01O/eWuR+x8X55zq5Du8Lhu10cdo/U1TODqK9dUMY+1RLU8GByVVmaZ+iatw==
X-Received: by 2002:a05:6e02:16cf:b0:39a:eb26:45f8 with SMTP id e9e14a558f8ab-39d26d5fbe5mr106031565ab.20.1723990662525;
        Sun, 18 Aug 2024 07:17:42 -0700 (PDT)
Received: from ?IPV6:2409:8a55:301b:e120:533:2ab:4b0c:63ec? ([2409:8a55:301b:e120:533:2ab:4b0c:63ec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae0756dsm5285882b3a.47.2024.08.18.07.17.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Aug 2024 07:17:42 -0700 (PDT)
Message-ID: <507890da-4fa8-4936-b856-f90d75b5ddfa@gmail.com>
Date: Sun, 18 Aug 2024 22:17:30 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 12/14] net: replace page_frag with
 page_frag_cache
To: Alexander H Duyck <alexander.duyck@gmail.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mat Martineau <martineau@kernel.org>, Ayush Sawal <ayush.sawal@chelsio.com>,
 Eric Dumazet <edumazet@google.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, David Ahern <dsahern@kernel.org>,
 Matthieu Baerts <matttbe@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, Boris Pismenny <borisp@nvidia.com>,
 bpf@vger.kernel.org, mptcp@lists.linux.dev
References: <20240808123714.462740-1-linyunsheng@huawei.com>
 <20240808123714.462740-13-linyunsheng@huawei.com>
 <4b0b48c30dbfa1f4bc35577552af414bc307717b.camel@gmail.com>
Content-Language: en-US
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <4b0b48c30dbfa1f4bc35577552af414bc307717b.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/2024 6:01 AM, Alexander H Duyck wrote:
> On Thu, 2024-08-08 at 20:37 +0800, Yunsheng Lin wrote:
>> Use the newly introduced prepare/probe/commit API to
>> replace page_frag with page_frag_cache for sk_page_frag().
>>
>> CC: Alexander Duyck <alexander.duyck@gmail.com>
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>> Acked-by: Mat Martineau <martineau@kernel.org>
>> ---
>>   .../chelsio/inline_crypto/chtls/chtls.h       |   3 -
>>   .../chelsio/inline_crypto/chtls/chtls_io.c    | 100 ++++---------
>>   .../chelsio/inline_crypto/chtls/chtls_main.c  |   3 -
>>   drivers/net/tun.c                             |  48 +++---
>>   include/linux/sched.h                         |   2 +-
>>   include/net/sock.h                            |  14 +-
>>   kernel/exit.c                                 |   3 +-
>>   kernel/fork.c                                 |   3 +-
>>   net/core/skbuff.c                             |  59 +++++---
>>   net/core/skmsg.c                              |  22 +--
>>   net/core/sock.c                               |  46 ++++--
>>   net/ipv4/ip_output.c                          |  33 +++--
>>   net/ipv4/tcp.c                                |  32 ++--
>>   net/ipv4/tcp_output.c                         |  28 ++--
>>   net/ipv6/ip6_output.c                         |  33 +++--
>>   net/kcm/kcmsock.c                             |  27 ++--
>>   net/mptcp/protocol.c                          |  67 +++++----
>>   net/sched/em_meta.c                           |   2 +-
>>   net/tls/tls_device.c                          | 137 ++++++++++--------
>>   19 files changed, 347 insertions(+), 315 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h
>> index 7ff82b6778ba..fe2b6a8ef718 100644
>> --- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h
>> +++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h
>> @@ -234,7 +234,6 @@ struct chtls_dev {
>>   	struct list_head list_node;
>>   	struct list_head rcu_node;
>>   	struct list_head na_node;
>> -	unsigned int send_page_order;
>>   	int max_host_sndbuf;
>>   	u32 round_robin_cnt;
>>   	struct key_map kmap;
>> @@ -453,8 +452,6 @@ enum {
>>   
>>   /* The ULP mode/submode of an skbuff */
>>   #define skb_ulp_mode(skb)  (ULP_SKB_CB(skb)->ulp_mode)
>> -#define TCP_PAGE(sk)   (sk->sk_frag.page)
>> -#define TCP_OFF(sk)    (sk->sk_frag.offset)
>>   
>>   static inline struct chtls_dev *to_chtls_dev(struct tls_toe_device *tlsdev)
>>   {
>> diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
>> index d567e42e1760..334381c1587f 100644
>> --- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
>> +++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
>> @@ -825,12 +825,6 @@ void skb_entail(struct sock *sk, struct sk_buff *skb, int flags)
>>   	ULP_SKB_CB(skb)->flags = flags;
>>   	__skb_queue_tail(&csk->txq, skb);
>>   	sk->sk_wmem_queued += skb->truesize;
>> -
>> -	if (TCP_PAGE(sk) && TCP_OFF(sk)) {
>> -		put_page(TCP_PAGE(sk));
>> -		TCP_PAGE(sk) = NULL;
>> -		TCP_OFF(sk) = 0;
>> -	}
>>   }
>>   
>>   static struct sk_buff *get_tx_skb(struct sock *sk, int size)
>> @@ -882,16 +876,12 @@ static void push_frames_if_head(struct sock *sk)
>>   		chtls_push_frames(csk, 1);
>>   }
>>   
>> -static int chtls_skb_copy_to_page_nocache(struct sock *sk,
>> -					  struct iov_iter *from,
>> -					  struct sk_buff *skb,
>> -					  struct page *page,
>> -					  int off, int copy)
>> +static int chtls_skb_copy_to_va_nocache(struct sock *sk, struct iov_iter *from,
>> +					struct sk_buff *skb, char *va, int copy)
>>   {
>>   	int err;
>>   
>> -	err = skb_do_copy_data_nocache(sk, skb, from, page_address(page) +
>> -				       off, copy, skb->len);
>> +	err = skb_do_copy_data_nocache(sk, skb, from, va, copy, skb->len);
>>   	if (err)
>>   		return err;
>>   
>> @@ -1114,82 +1104,44 @@ int chtls_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>>   			if (err)
>>   				goto do_fault;
>>   		} else {
>> +			struct page_frag_cache *pfrag = &sk->sk_frag;
> 
> Is this even valid? Shouldn't it be using sk_page_frag to get the

chtls_sendmsg() only use sk->sk_frag, see below.

> reference here? Seems like it might be trying to instantiate an unused
> cache.

I am not sure if I understand what you meant by "trying to instantiate
an unused cache". sk->sk_frag is supposed to be instantiated in
sock_init_data_uid() by calling page_frag_cache_init() in this patch.

> 
> As per my earlier suggestion this could be made very simple if we are
> just pulling a bio_vec out from the page cache at the start. With that
> we could essentially plug it into the TCP_PAGE/TCP_OFF block here and
> most of it would just function the same.

I am not sure if we had the same common understanding as why chtls had
more changing than other places when replacing page_frag with
page_frag_cache.

chtls_sendmsg() was duplicating its own implementation of page_frag
refilling instead of using skb_page_frag_refill(), we can remove that
implementation by using the new API, that is why there is more changing
for chtls than other places. Are you suggesting to keep chtls's own
implementation of page_frag refilling by 'plug it into the TCP_PAGE/
TCP_OFF block' here?

> 
>>   			int i = skb_shinfo(skb)->nr_frags;
>> -			struct page *page = TCP_PAGE(sk);

TCP_PAGE macro is defined as below, that is why sk->sk_frag is used
instead of sk_page_frag() for chtls case if I understand your question
correctly:

#define TCP_PAGE(sk)   (sk->sk_frag.page)
#define TCP_OFF(sk)    (sk->sk_frag.offset)

>> -			int pg_size = PAGE_SIZE;
>> -			int off = TCP_OFF(sk);
>> -			bool merge;
>> -
>> -			if (page)
>> -				pg_size = page_size(page);
>> -			if (off < pg_size &&
>> -			    skb_can_coalesce(skb, i, page, off)) {
>> +			unsigned int offset, fragsz;
>> +			bool merge = false;
>> +			struct page *page;
>> +			void *va;
>> +
>> +			fragsz = 32U;
>> +			page = page_frag_alloc_prepare(pfrag, &offset, &fragsz,
>> +						       &va, sk->sk_allocation);
>> +			if (unlikely(!page))
>> +				goto wait_for_memory;
>> +
>> +			if (skb_can_coalesce(skb, i, page, offset))
>>   				merge = true;
>> -				goto copy;
>> -			}
>> -			merge = false;
>> -			if (i == (is_tls_tx(csk) ? (MAX_SKB_FRAGS - 1) :
>> -			    MAX_SKB_FRAGS))
>> +			else if (i == (is_tls_tx(csk) ? (MAX_SKB_FRAGS - 1) :
>> +				       MAX_SKB_FRAGS))
>>   				goto new_buf;
>>   
>> -			if (page && off == pg_size) {
>> -				put_page(page);
>> -				TCP_PAGE(sk) = page = NULL;
>> -				pg_size = PAGE_SIZE;
>> -			}
>> -
>> -			if (!page) {
>> -				gfp_t gfp = sk->sk_allocation;
>> -				int order = cdev->send_page_order;
>> -
>> -				if (order) {
>> -					page = alloc_pages(gfp | __GFP_COMP |
>> -							   __GFP_NOWARN |
>> -							   __GFP_NORETRY,
>> -							   order);
>> -					if (page)
>> -						pg_size <<= order;
>> -				}
>> -				if (!page) {
>> -					page = alloc_page(gfp);
>> -					pg_size = PAGE_SIZE;
>> -				}
>> -				if (!page)
>> -					goto wait_for_memory;
>> -				off = 0;
>> -			}
>> -copy:
>> -			if (copy > pg_size - off)
>> -				copy = pg_size - off;
>> +			copy = min_t(int, copy, fragsz);
>>   			if (is_tls_tx(csk))
>>   				copy = min_t(int, copy, csk->tlshws.txleft);
>>   
>> -			err = chtls_skb_copy_to_page_nocache(sk, &msg->msg_iter,
>> -							     skb, page,
>> -							     off, copy);
>> -			if (unlikely(err)) {
>> -				if (!TCP_PAGE(sk)) {
>> -					TCP_PAGE(sk) = page;
>> -					TCP_OFF(sk) = 0;
>> -				}
>> +			err = chtls_skb_copy_to_va_nocache(sk, &msg->msg_iter,
>> +							   skb, va, copy);
>> +			if (unlikely(err))
>>   				goto do_fault;
>> -			}
>> +
>>   			/* Update the skb. */
>>   			if (merge) {
>>   				skb_frag_size_add(
>>   						&skb_shinfo(skb)->frags[i - 1],
>>   						copy);
>> +				page_frag_alloc_commit_noref(pfrag, copy);
>>   			} else {
>> -				skb_fill_page_desc(skb, i, page, off, copy);
>> -				if (off + copy < pg_size) {
>> -					/* space left keep page */
>> -					get_page(page);
>> -					TCP_PAGE(sk) = page;
>> -				} else {
>> -					TCP_PAGE(sk) = NULL;
>> -				}
>> +				skb_fill_page_desc(skb, i, page, offset, copy);
>> +				page_frag_alloc_commit(pfrag, copy);
>>   			}
>> -			TCP_OFF(sk) = off + copy;
>>   		}
>>   		if (unlikely(skb->len == mss))
>>   			tx_skb_finalize(skb);
> 
> Really there is so much refactor here it is hard to tell what is what.
> I would suggest just trying to plug in an intermediary value and you
> can save the refactor for later.

I am not sure if your above suggestion works, if it does work, I am not
sure if it is that simple enough to just plug in an intermediary value
as the the fields in 'struct page_frag_cache' is much different from the
fields in 'struct page_frag' as below when replacing page_frag with 
page_frag_cache for sk->sk_frag:

struct page_frag_cache {
	unsigned long encoded_va;

+#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE) && (BITS_PER_LONG <= 32)
  	__u16 remaining;
	__u16 pagecnt_bias;
  #else
  	__u32 remaining;
	__u32 pagecnt_bias;
  #endif
};

struct page_frag {
	struct page *page;
#if (BITS_PER_LONG > 32) || (PAGE_SIZE >= 65536)
	__u32 offset;
	__u32 size;
#else
	__u16 offset;
	__u16 size;
#endif
};


> 
>> diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
>> index 455a54708be4..ba88b2fc7cd8 100644
>> --- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
>> +++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
>> @@ -34,7 +34,6 @@ static DEFINE_MUTEX(notify_mutex);
>>   static RAW_NOTIFIER_HEAD(listen_notify_list);
>>   static struct proto chtls_cpl_prot, chtls_cpl_protv6;
>>   struct request_sock_ops chtls_rsk_ops, chtls_rsk_opsv6;
>> -static uint send_page_order = (14 - PAGE_SHIFT < 0) ? 0 : 14 - PAGE_SHIFT;
>>   
>>   static void register_listen_notifier(struct notifier_block *nb)
>>   {
>> @@ -273,8 +272,6 @@ static void *chtls_uld_add(const struct cxgb4_lld_info *info)
>>   	INIT_WORK(&cdev->deferq_task, process_deferq);
>>   	spin_lock_init(&cdev->listen_lock);
>>   	spin_lock_init(&cdev->idr_lock);
>> -	cdev->send_page_order = min_t(uint, get_order(32768),
>> -				      send_page_order);
>>   	cdev->max_host_sndbuf = 48 * 1024;
>>   
>>   	if (lldi->vr->key.size)
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>> index 1d06c560c5e6..51df92fd60db 100644
>> --- a/drivers/net/tun.c
>> +++ b/drivers/net/tun.c
>> @@ -1598,21 +1598,19 @@ static bool tun_can_build_skb(struct tun_struct *tun, struct tun_file *tfile,
>>   }
>>   
>>   static struct sk_buff *__tun_build_skb(struct tun_file *tfile,
>> -				       struct page_frag *alloc_frag, char *buf,
>> -				       int buflen, int len, int pad)
>> +				       char *buf, int buflen, int len, int pad)
>>   {
>>   	struct sk_buff *skb = build_skb(buf, buflen);
>>   
>> -	if (!skb)
>> +	if (!skb) {
>> +		page_frag_free_va(buf);
>>   		return ERR_PTR(-ENOMEM);
>> +	}
>>   
>>   	skb_reserve(skb, pad);
>>   	skb_put(skb, len);
>>   	skb_set_owner_w(skb, tfile->socket.sk);
>>   
>> -	get_page(alloc_frag->page);
>> -	alloc_frag->offset += buflen;
>> -
> 
> Rather than freeing the buf it would be better if you were to just
> stick to the existing pattern and commit the alloc_frag at the end here
> instead of calling get_page.
> 
>>   	return skb;
>>   }
>>   
>> @@ -1660,7 +1658,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>>   				     struct virtio_net_hdr *hdr,
>>   				     int len, int *skb_xdp)
>>   {
>> -	struct page_frag *alloc_frag = &current->task_frag;
>> +	struct page_frag_cache *alloc_frag = &current->task_frag;
>>   	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
>>   	struct bpf_prog *xdp_prog;
>>   	int buflen = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>> @@ -1676,16 +1674,16 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>>   	buflen += SKB_DATA_ALIGN(len + pad);
>>   	rcu_read_unlock();
>>   
>> -	alloc_frag->offset = ALIGN((u64)alloc_frag->offset, SMP_CACHE_BYTES);
>> -	if (unlikely(!skb_page_frag_refill(buflen, alloc_frag, GFP_KERNEL)))
>> +	buf = page_frag_alloc_va_align(alloc_frag, buflen, GFP_KERNEL,
>> +				       SMP_CACHE_BYTES);
>> +	if (unlikely(!buf))
>>   		return ERR_PTR(-ENOMEM);
>>   
>> -	buf = (char *)page_address(alloc_frag->page) + alloc_frag->offset;
>> -	copied = copy_page_from_iter(alloc_frag->page,
>> -				     alloc_frag->offset + pad,
>> -				     len, from);
>> -	if (copied != len)
>> +	copied = copy_from_iter(buf + pad, len, from);
>> +	if (copied != len) {
>> +		page_frag_alloc_abort(alloc_frag, buflen);
>>   		return ERR_PTR(-EFAULT);
>> +	}
>>   
>>   	/* There's a small window that XDP may be set after the check
>>   	 * of xdp_prog above, this should be rare and for simplicity
>> @@ -1693,8 +1691,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>>   	 */
>>   	if (hdr->gso_type || !xdp_prog) {
>>   		*skb_xdp = 1;
>> -		return __tun_build_skb(tfile, alloc_frag, buf, buflen, len,
>> -				       pad);
>> +		return __tun_build_skb(tfile, buf, buflen, len, pad);
>>   	}
>>   
>>   	*skb_xdp = 0;
>> @@ -1711,21 +1708,16 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>>   		xdp_prepare_buff(&xdp, buf, pad, len, false);
>>   
>>   		act = bpf_prog_run_xdp(xdp_prog, &xdp);
>> -		if (act == XDP_REDIRECT || act == XDP_TX) {
>> -			get_page(alloc_frag->page);
>> -			alloc_frag->offset += buflen;

the above is only executed for XDP_REDIRECT and XDP_TX cases.

>> -		}
>>   		err = tun_xdp_act(tun, xdp_prog, &xdp, act);
>> -		if (err < 0) {
>> -			if (act == XDP_REDIRECT || act == XDP_TX)
>> -				put_page(alloc_frag->page);

And there is a put_page() immediately when xdp_do_redirect() or
tun_xdp_tx() fails in tun_xdp_act(), so there is something else
might have taken a reference to the page and modified it in some way
even when tun_xdp_act() return error? Would you be more specific
about why above happens?

>> -			goto out;
>> -		}
>> -
>>   		if (err == XDP_REDIRECT)
>>   			xdp_do_flush();
>> -		if (err != XDP_PASS)
>> +
>> +		if (err == XDP_REDIRECT || err == XDP_TX) {
>> +			goto out;
>> +		} else if (err < 0 || err != XDP_PASS) {
>> +			page_frag_alloc_abort(alloc_frag, buflen);
>>   			goto out;
>> +		}
>>   
> 
> Your abort function here is not necessarily safe. It is assuming that
> nothing else might have taken a reference to the page or modified it in
> some way. Generally we shouldn't allow rewinding the pointer until we
> check the page count to guarantee nobody else is now working with a
> copy of the page.
> 
>>   		pad = xdp.data - xdp.data_hard_start;
>>   		len = xdp.data_end - xdp.data;
>> @@ -1734,7 +1726,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>>   	rcu_read_unlock();
>>   	local_bh_enable();
>>   
>> -	return __tun_build_skb(tfile, alloc_frag, buf, buflen, len, pad);
>> +	return __tun_build_skb(tfile, buf, buflen, len, pad);
>>   
>>   out:
>>   	bpf_net_ctx_clear(bpf_net_ctx);
>

...



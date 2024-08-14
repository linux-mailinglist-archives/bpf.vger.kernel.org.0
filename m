Return-Path: <bpf+bounces-37217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F29A095252D
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 00:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50D8EB22714
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 22:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7251494D4;
	Wed, 14 Aug 2024 22:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjJtPJSq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9A714389F;
	Wed, 14 Aug 2024 22:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723672910; cv=none; b=ro3gh9w29gXhYhKN5in8TLfOHvT6OxV4pLu320ouyGWN5EDPMo0oJatItjdzLZifYnCBHbzpOlB9F4T3KxuX6pX2+IK59r49EIVYTrPGWk8/zoMRQPFi3K5olAvMs7cAIbl0PjnoxUYvxKSmqDrzq7yF70jfsQgLOnEcG1YXczY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723672910; c=relaxed/simple;
	bh=JgR+5pUUFdEBu+CLEhc5Ct/mjo3k4E6z/0DU6sOfWEY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sdK+v/O+j+kiFZxVvz49A7anBov/hcsCdsjQ3FLBO6JtAd81ZXvvud789LGOnlPcmmcE69HkxepHQsSriM2rMlUZyqA8mVRGlhDj/xg975k37+NJBxNec9MnMyERjaSiodiuQknjdvwu5P2HeVaPc2yTCtLVDUkYrCBRdG7ZbjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjJtPJSq; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso330886a12.2;
        Wed, 14 Aug 2024 15:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723672906; x=1724277706; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v8bT9nQVgHrKlpDM0654oBIbzorki97BZwntPNW1GuQ=;
        b=TjJtPJSqcn5crgFpyT7ARtmT1vHbAqU0UvmntmoRv4mEh7DxLEJjOab+UGsNGIN0ZK
         A7yWOPlqLvOFfCka2ruAUcF9pHvSFG7QHwabsqhvRezE9maRgPRdNw4ch54wtnJmARVF
         unmRmrkdnfaAkOQsJ27IlnneqiJ8ZcdN7vbqLqsrmiHd3vhLPOYGKypYuwMlNkpKhvCx
         1RE0OXu6QvnpBlKvdgcc6XAUyZwGtiIbfqN37GGmIi5vcVq3vDjCpblgp75msQED/+HE
         xzBhCBMgbp4oxt9jDlbGsiCeRJsnizMQtVyJlhjI0eeI31pypuBPLhMHzYc8Pmqldt+B
         ha/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723672906; x=1724277706;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v8bT9nQVgHrKlpDM0654oBIbzorki97BZwntPNW1GuQ=;
        b=cZPy77VjieUxg4MFeqhPG2wSD63MSBXqH8KObfzW3MyZ+VZvHVmBfY6cTIlhqxE7QH
         so7yCrhi/MaLboV66wsWS+DG8l+EDWscfgCRiFnlG0e8mOs8BX6St5fqodBhTZ5PG1Z2
         2j3WUNvTVf69peaARqSwuKtN/CB70PQ2SxO5VZbIiDkn8a3Gs64ULOxVtiQ8ZpFKg9Hr
         gSpi5ncoWVb03FZBPLkAe0Ma8AClNsu1UIu9t6WWzI3ICw9aWUCpyR4PUCc9xP4AVWY1
         h2HVq1rDphhcUz33aV/lPtD/ol40Sc6HP7ujrcON6+wgazX9tUn7GEZqWa+TLP5lojqb
         SLBw==
X-Forwarded-Encrypted: i=1; AJvYcCU1nktky1DYHOiuGM3d2SPZF2VWLsT7bzR6jiTN2WCECOAcLqM8YIXlZAYedMKLc2LETfwVzaZ6/kBWix2g@vger.kernel.org, AJvYcCWzJBQbkKgjGF7Wo+mM3/7xqhrtCnVSbmx5e6BfHpf/raJX0QkjeUy/uArymjspT3GQvKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAMNQZUwavAVQMjixVTvtdceNJ82J3p/REmasjFyAspxaG2g8h
	RaTvZgtaIjmxNMzG1/tM1aCJi6QdaTZQawty8LGtbILMolayZuLC
X-Google-Smtp-Source: AGHT+IGP/sgTMlCcNUcO7pLU+9GygJIRYCWc03JOq27h+FyeDaXC/17UfPTQaoU7d2r7+KZjRaHRqg==
X-Received: by 2002:a17:90a:9318:b0:2cf:c9df:4cc8 with SMTP id 98e67ed59e1d1-2d3aab8a4ebmr4712159a91.38.1723672905573;
        Wed, 14 Aug 2024 15:01:45 -0700 (PDT)
Received: from ?IPv6:2605:59c8:829:4c00:82ee:73ff:fe41:9a02? ([2605:59c8:829:4c00:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2d3ac7ca442sm2314451a91.5.2024.08.14.15.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 15:01:45 -0700 (PDT)
Message-ID: <4b0b48c30dbfa1f4bc35577552af414bc307717b.camel@gmail.com>
Subject: Re: [PATCH net-next v13 12/14] net: replace page_frag with
 page_frag_cache
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org,  pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Mat Martineau
 <martineau@kernel.org>, Ayush Sawal <ayush.sawal@chelsio.com>, Eric Dumazet
 <edumazet@google.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>,  Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, David Ahern <dsahern@kernel.org>,
 Matthieu Baerts <matttbe@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, Boris Pismenny <borisp@nvidia.com>,
 bpf@vger.kernel.org,  mptcp@lists.linux.dev
Date: Wed, 14 Aug 2024 15:01:42 -0700
In-Reply-To: <20240808123714.462740-13-linyunsheng@huawei.com>
References: <20240808123714.462740-1-linyunsheng@huawei.com>
	 <20240808123714.462740-13-linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-08 at 20:37 +0800, Yunsheng Lin wrote:
> Use the newly introduced prepare/probe/commit API to
> replace page_frag with page_frag_cache for sk_page_frag().
>=20
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> Acked-by: Mat Martineau <martineau@kernel.org>
> ---
>  .../chelsio/inline_crypto/chtls/chtls.h       |   3 -
>  .../chelsio/inline_crypto/chtls/chtls_io.c    | 100 ++++---------
>  .../chelsio/inline_crypto/chtls/chtls_main.c  |   3 -
>  drivers/net/tun.c                             |  48 +++---
>  include/linux/sched.h                         |   2 +-
>  include/net/sock.h                            |  14 +-
>  kernel/exit.c                                 |   3 +-
>  kernel/fork.c                                 |   3 +-
>  net/core/skbuff.c                             |  59 +++++---
>  net/core/skmsg.c                              |  22 +--
>  net/core/sock.c                               |  46 ++++--
>  net/ipv4/ip_output.c                          |  33 +++--
>  net/ipv4/tcp.c                                |  32 ++--
>  net/ipv4/tcp_output.c                         |  28 ++--
>  net/ipv6/ip6_output.c                         |  33 +++--
>  net/kcm/kcmsock.c                             |  27 ++--
>  net/mptcp/protocol.c                          |  67 +++++----
>  net/sched/em_meta.c                           |   2 +-
>  net/tls/tls_device.c                          | 137 ++++++++++--------
>  19 files changed, 347 insertions(+), 315 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h b/d=
rivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h
> index 7ff82b6778ba..fe2b6a8ef718 100644
> --- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h
> +++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h
> @@ -234,7 +234,6 @@ struct chtls_dev {
>  	struct list_head list_node;
>  	struct list_head rcu_node;
>  	struct list_head na_node;
> -	unsigned int send_page_order;
>  	int max_host_sndbuf;
>  	u32 round_robin_cnt;
>  	struct key_map kmap;
> @@ -453,8 +452,6 @@ enum {
> =20
>  /* The ULP mode/submode of an skbuff */
>  #define skb_ulp_mode(skb)  (ULP_SKB_CB(skb)->ulp_mode)
> -#define TCP_PAGE(sk)   (sk->sk_frag.page)
> -#define TCP_OFF(sk)    (sk->sk_frag.offset)
> =20
>  static inline struct chtls_dev *to_chtls_dev(struct tls_toe_device *tlsd=
ev)
>  {
> diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c =
b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
> index d567e42e1760..334381c1587f 100644
> --- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
> +++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
> @@ -825,12 +825,6 @@ void skb_entail(struct sock *sk, struct sk_buff *skb=
, int flags)
>  	ULP_SKB_CB(skb)->flags =3D flags;
>  	__skb_queue_tail(&csk->txq, skb);
>  	sk->sk_wmem_queued +=3D skb->truesize;
> -
> -	if (TCP_PAGE(sk) && TCP_OFF(sk)) {
> -		put_page(TCP_PAGE(sk));
> -		TCP_PAGE(sk) =3D NULL;
> -		TCP_OFF(sk) =3D 0;
> -	}
>  }
> =20
>  static struct sk_buff *get_tx_skb(struct sock *sk, int size)
> @@ -882,16 +876,12 @@ static void push_frames_if_head(struct sock *sk)
>  		chtls_push_frames(csk, 1);
>  }
> =20
> -static int chtls_skb_copy_to_page_nocache(struct sock *sk,
> -					  struct iov_iter *from,
> -					  struct sk_buff *skb,
> -					  struct page *page,
> -					  int off, int copy)
> +static int chtls_skb_copy_to_va_nocache(struct sock *sk, struct iov_iter=
 *from,
> +					struct sk_buff *skb, char *va, int copy)
>  {
>  	int err;
> =20
> -	err =3D skb_do_copy_data_nocache(sk, skb, from, page_address(page) +
> -				       off, copy, skb->len);
> +	err =3D skb_do_copy_data_nocache(sk, skb, from, va, copy, skb->len);
>  	if (err)
>  		return err;
> =20
> @@ -1114,82 +1104,44 @@ int chtls_sendmsg(struct sock *sk, struct msghdr =
*msg, size_t size)
>  			if (err)
>  				goto do_fault;
>  		} else {
> +			struct page_frag_cache *pfrag =3D &sk->sk_frag;

Is this even valid? Shouldn't it be using sk_page_frag to get the
reference here? Seems like it might be trying to instantiate an unused
cache.

As per my earlier suggestion this could be made very simple if we are
just pulling a bio_vec out from the page cache at the start. With that
we could essentially plug it into the TCP_PAGE/TCP_OFF block here and
most of it would just function the same.

>  			int i =3D skb_shinfo(skb)->nr_frags;
> -			struct page *page =3D TCP_PAGE(sk);
> -			int pg_size =3D PAGE_SIZE;
> -			int off =3D TCP_OFF(sk);
> -			bool merge;
> -
> -			if (page)
> -				pg_size =3D page_size(page);
> -			if (off < pg_size &&
> -			    skb_can_coalesce(skb, i, page, off)) {
> +			unsigned int offset, fragsz;
> +			bool merge =3D false;
> +			struct page *page;
> +			void *va;
> +
> +			fragsz =3D 32U;
> +			page =3D page_frag_alloc_prepare(pfrag, &offset, &fragsz,
> +						       &va, sk->sk_allocation);
> +			if (unlikely(!page))
> +				goto wait_for_memory;
> +
> +			if (skb_can_coalesce(skb, i, page, offset))
>  				merge =3D true;
> -				goto copy;
> -			}
> -			merge =3D false;
> -			if (i =3D=3D (is_tls_tx(csk) ? (MAX_SKB_FRAGS - 1) :
> -			    MAX_SKB_FRAGS))
> +			else if (i =3D=3D (is_tls_tx(csk) ? (MAX_SKB_FRAGS - 1) :
> +				       MAX_SKB_FRAGS))
>  				goto new_buf;
> =20
> -			if (page && off =3D=3D pg_size) {
> -				put_page(page);
> -				TCP_PAGE(sk) =3D page =3D NULL;
> -				pg_size =3D PAGE_SIZE;
> -			}
> -
> -			if (!page) {
> -				gfp_t gfp =3D sk->sk_allocation;
> -				int order =3D cdev->send_page_order;
> -
> -				if (order) {
> -					page =3D alloc_pages(gfp | __GFP_COMP |
> -							   __GFP_NOWARN |
> -							   __GFP_NORETRY,
> -							   order);
> -					if (page)
> -						pg_size <<=3D order;
> -				}
> -				if (!page) {
> -					page =3D alloc_page(gfp);
> -					pg_size =3D PAGE_SIZE;
> -				}
> -				if (!page)
> -					goto wait_for_memory;
> -				off =3D 0;
> -			}
> -copy:
> -			if (copy > pg_size - off)
> -				copy =3D pg_size - off;
> +			copy =3D min_t(int, copy, fragsz);
>  			if (is_tls_tx(csk))
>  				copy =3D min_t(int, copy, csk->tlshws.txleft);
> =20
> -			err =3D chtls_skb_copy_to_page_nocache(sk, &msg->msg_iter,
> -							     skb, page,
> -							     off, copy);
> -			if (unlikely(err)) {
> -				if (!TCP_PAGE(sk)) {
> -					TCP_PAGE(sk) =3D page;
> -					TCP_OFF(sk) =3D 0;
> -				}
> +			err =3D chtls_skb_copy_to_va_nocache(sk, &msg->msg_iter,
> +							   skb, va, copy);
> +			if (unlikely(err))
>  				goto do_fault;
> -			}
> +
>  			/* Update the skb. */
>  			if (merge) {
>  				skb_frag_size_add(
>  						&skb_shinfo(skb)->frags[i - 1],
>  						copy);
> +				page_frag_alloc_commit_noref(pfrag, copy);
>  			} else {
> -				skb_fill_page_desc(skb, i, page, off, copy);
> -				if (off + copy < pg_size) {
> -					/* space left keep page */
> -					get_page(page);
> -					TCP_PAGE(sk) =3D page;
> -				} else {
> -					TCP_PAGE(sk) =3D NULL;
> -				}
> +				skb_fill_page_desc(skb, i, page, offset, copy);
> +				page_frag_alloc_commit(pfrag, copy);
>  			}
> -			TCP_OFF(sk) =3D off + copy;
>  		}
>  		if (unlikely(skb->len =3D=3D mss))
>  			tx_skb_finalize(skb);

Really there is so much refactor here it is hard to tell what is what.
I would suggest just trying to plug in an intermediary value and you
can save the refactor for later.

> diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.=
c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
> index 455a54708be4..ba88b2fc7cd8 100644
> --- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
> +++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
> @@ -34,7 +34,6 @@ static DEFINE_MUTEX(notify_mutex);
>  static RAW_NOTIFIER_HEAD(listen_notify_list);
>  static struct proto chtls_cpl_prot, chtls_cpl_protv6;
>  struct request_sock_ops chtls_rsk_ops, chtls_rsk_opsv6;
> -static uint send_page_order =3D (14 - PAGE_SHIFT < 0) ? 0 : 14 - PAGE_SH=
IFT;
> =20
>  static void register_listen_notifier(struct notifier_block *nb)
>  {
> @@ -273,8 +272,6 @@ static void *chtls_uld_add(const struct cxgb4_lld_inf=
o *info)
>  	INIT_WORK(&cdev->deferq_task, process_deferq);
>  	spin_lock_init(&cdev->listen_lock);
>  	spin_lock_init(&cdev->idr_lock);
> -	cdev->send_page_order =3D min_t(uint, get_order(32768),
> -				      send_page_order);
>  	cdev->max_host_sndbuf =3D 48 * 1024;
> =20
>  	if (lldi->vr->key.size)
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 1d06c560c5e6..51df92fd60db 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1598,21 +1598,19 @@ static bool tun_can_build_skb(struct tun_struct *=
tun, struct tun_file *tfile,
>  }
> =20
>  static struct sk_buff *__tun_build_skb(struct tun_file *tfile,
> -				       struct page_frag *alloc_frag, char *buf,
> -				       int buflen, int len, int pad)
> +				       char *buf, int buflen, int len, int pad)
>  {
>  	struct sk_buff *skb =3D build_skb(buf, buflen);
> =20
> -	if (!skb)
> +	if (!skb) {
> +		page_frag_free_va(buf);
>  		return ERR_PTR(-ENOMEM);
> +	}
> =20
>  	skb_reserve(skb, pad);
>  	skb_put(skb, len);
>  	skb_set_owner_w(skb, tfile->socket.sk);
> =20
> -	get_page(alloc_frag->page);
> -	alloc_frag->offset +=3D buflen;
> -

Rather than freeing the buf it would be better if you were to just
stick to the existing pattern and commit the alloc_frag at the end here
instead of calling get_page.

>  	return skb;
>  }
> =20
> @@ -1660,7 +1658,7 @@ static struct sk_buff *tun_build_skb(struct tun_str=
uct *tun,
>  				     struct virtio_net_hdr *hdr,
>  				     int len, int *skb_xdp)
>  {
> -	struct page_frag *alloc_frag =3D &current->task_frag;
> +	struct page_frag_cache *alloc_frag =3D &current->task_frag;
>  	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
>  	struct bpf_prog *xdp_prog;
>  	int buflen =3D SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> @@ -1676,16 +1674,16 @@ static struct sk_buff *tun_build_skb(struct tun_s=
truct *tun,
>  	buflen +=3D SKB_DATA_ALIGN(len + pad);
>  	rcu_read_unlock();
> =20
> -	alloc_frag->offset =3D ALIGN((u64)alloc_frag->offset, SMP_CACHE_BYTES);
> -	if (unlikely(!skb_page_frag_refill(buflen, alloc_frag, GFP_KERNEL)))
> +	buf =3D page_frag_alloc_va_align(alloc_frag, buflen, GFP_KERNEL,
> +				       SMP_CACHE_BYTES);
> +	if (unlikely(!buf))
>  		return ERR_PTR(-ENOMEM);
> =20
> -	buf =3D (char *)page_address(alloc_frag->page) + alloc_frag->offset;
> -	copied =3D copy_page_from_iter(alloc_frag->page,
> -				     alloc_frag->offset + pad,
> -				     len, from);
> -	if (copied !=3D len)
> +	copied =3D copy_from_iter(buf + pad, len, from);
> +	if (copied !=3D len) {
> +		page_frag_alloc_abort(alloc_frag, buflen);
>  		return ERR_PTR(-EFAULT);
> +	}
> =20
>  	/* There's a small window that XDP may be set after the check
>  	 * of xdp_prog above, this should be rare and for simplicity
> @@ -1693,8 +1691,7 @@ static struct sk_buff *tun_build_skb(struct tun_str=
uct *tun,
>  	 */
>  	if (hdr->gso_type || !xdp_prog) {
>  		*skb_xdp =3D 1;
> -		return __tun_build_skb(tfile, alloc_frag, buf, buflen, len,
> -				       pad);
> +		return __tun_build_skb(tfile, buf, buflen, len, pad);
>  	}
> =20
>  	*skb_xdp =3D 0;
> @@ -1711,21 +1708,16 @@ static struct sk_buff *tun_build_skb(struct tun_s=
truct *tun,
>  		xdp_prepare_buff(&xdp, buf, pad, len, false);
> =20
>  		act =3D bpf_prog_run_xdp(xdp_prog, &xdp);
> -		if (act =3D=3D XDP_REDIRECT || act =3D=3D XDP_TX) {
> -			get_page(alloc_frag->page);
> -			alloc_frag->offset +=3D buflen;
> -		}
>  		err =3D tun_xdp_act(tun, xdp_prog, &xdp, act);
> -		if (err < 0) {
> -			if (act =3D=3D XDP_REDIRECT || act =3D=3D XDP_TX)
> -				put_page(alloc_frag->page);
> -			goto out;
> -		}
> -
>  		if (err =3D=3D XDP_REDIRECT)
>  			xdp_do_flush();
> -		if (err !=3D XDP_PASS)
> +
> +		if (err =3D=3D XDP_REDIRECT || err =3D=3D XDP_TX) {
> +			goto out;
> +		} else if (err < 0 || err !=3D XDP_PASS) {
> +			page_frag_alloc_abort(alloc_frag, buflen);
>  			goto out;
> +		}
> =20

Your abort function here is not necessarily safe. It is assuming that
nothing else might have taken a reference to the page or modified it in
some way. Generally we shouldn't allow rewinding the pointer until we
check the page count to guarantee nobody else is now working with a
copy of the page.

>  		pad =3D xdp.data - xdp.data_hard_start;
>  		len =3D xdp.data_end - xdp.data;
> @@ -1734,7 +1726,7 @@ static struct sk_buff *tun_build_skb(struct tun_str=
uct *tun,
>  	rcu_read_unlock();
>  	local_bh_enable();
> =20
> -	return __tun_build_skb(tfile, alloc_frag, buf, buflen, len, pad);
> +	return __tun_build_skb(tfile, buf, buflen, len, pad);
> =20
>  out:
>  	bpf_net_ctx_clear(bpf_net_ctx);
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index f8d150343d42..bb9a8e9d6d2d 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1355,7 +1355,7 @@ struct task_struct {
>  	/* Cache last used pipe for splice(): */
>  	struct pipe_inode_info		*splice_pipe;
> =20
> -	struct page_frag		task_frag;
> +	struct page_frag_cache		task_frag;
> =20
>  #ifdef CONFIG_TASK_DELAY_ACCT
>  	struct task_delay_info		*delays;
> diff --git a/include/net/sock.h b/include/net/sock.h
> index b5e702298ab7..8f6cc0dd2f4f 100644
>=20

It occurs to me that bio_vec and page_frag are essentially the same
thing. Instead of having your functions pass a bio_vec it might make
more sense to work with just a page_frag as the unit to be probed and
committed with the page_frag_cache being what is borrowed from.

With that I think you could clean up a bunch of the change this code is
generating as there is too much refactor to make this easy to review.
If you were to change things though so that you maintain working with a
page_frag and are just probing it out of the page_frag_cache and
committing your change back in it would make the diff much more
readable in my opinion.

The general idea would be that the page and offset should not be
changed from probe to commit, and size would only be able to be reduced
vs remaining. It would help to make this more readable instead of
returning page while passing pointers to offset and length/size.

Also as I mentioned earlier we cannot be rolling the offset backwards.
It needs to always be making forward progress unless we own all
instances of the page as it is possible that a section may have been
shared out from underneath us when we showed some other entity the
memory.


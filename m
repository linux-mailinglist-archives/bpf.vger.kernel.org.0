Return-Path: <bpf+bounces-18174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2C2816814
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 09:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79F081F21D4A
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 08:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8600E6FCF;
	Mon, 18 Dec 2023 08:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HTevlBku"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D3D11188
	for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 08:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702888425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PZCyaG6jNmPR26J2KXgAzagBivkyvaOw3c3fQFDUPyw=;
	b=HTevlBku9u25Xe+YOSGxFbMJwYZF4kOhSzYl9k9ppMGRBqbwOt3rfAd+axCIpts3T6A37L
	2LN5ZYTPo3KJYxpA6P/lQNIEWca/rgSsjPBWCcZJUrZ3R0NXY8qOqgck5XibXIcFD0GpkV
	m2gDUX5/5IRWf1LLkzxuZuYuNKoVNzw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-Cz2aEIrQP5GoCAGsqpG_qw-1; Mon, 18 Dec 2023 03:33:43 -0500
X-MC-Unique: Cz2aEIrQP5GoCAGsqpG_qw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a2361f0eb73so1925466b.1
        for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 00:33:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702888423; x=1703493223;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PZCyaG6jNmPR26J2KXgAzagBivkyvaOw3c3fQFDUPyw=;
        b=azJU62EUvj89wYepaYtxCJxw5ALBAK7U0z52LJOHoU/+BBtDGH0byl7bkY0jKRf91D
         UULHhhD1bTnqYosn9zAqDNN8SaeZ8wKp/nMc7lK7cpDWWbDkhhWGaDJqYcm2Q6Jwxp33
         p+l89hFf+dGFTdnrl0I9TH4mtvf+ehzTXOwjrZM1fKRC4NwqA/EcpWbob+YwBLP2M9lL
         BRsYQI82XAQDMtpBEptn4YewtvQrRpZ9UFt04OJkwlekN/bk103Q5ddFaOqAX6qGIP5m
         SBfnXRJdmWACpWV2nQ4PBRbsmilREHRPv2utWicGAQrR9jmyWH0/MjqULzLxRibYai19
         L1WA==
X-Gm-Message-State: AOJu0YyxDBXjWKmx1993ZP6cCh5HArIf5n9ey+L/tMXkarogn95gyR5G
	n+2W4vSSo5g2TN26ccbFgnEezVUzCGOt24ALimGA6Jlg4rMZroq4Aozx08p+oSSnpUjFsNRZC8S
	pEuyKXeWokII3
X-Received: by 2002:a17:906:d9c8:b0:a23:58f9:e1c6 with SMTP id qk8-20020a170906d9c800b00a2358f9e1c6mr964570ejb.2.1702888422814;
        Mon, 18 Dec 2023 00:33:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQGBMWYTkky6iUzAdVFk/IT8+5vyhBj/peOAS45LyC7l2LbL4ZHsINHOLEzPcnUm2Z41gz1w==
X-Received: by 2002:a17:906:d9c8:b0:a23:58f9:e1c6 with SMTP id qk8-20020a170906d9c800b00a2358f9e1c6mr964532ejb.2.1702888422424;
        Mon, 18 Dec 2023 00:33:42 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-253-3.dyn.eolo.it. [146.241.253.3])
        by smtp.gmail.com with ESMTPSA id li18-20020a170907199200b00a1e4558e450sm13852424ejc.156.2023.12.18.00.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 00:33:41 -0800 (PST)
Message-ID: <a8d155ec7d43bf3308fcfa3387dc16d1723617c6.camel@redhat.com>
Subject: Re: [PATCH net-next 12/24] seg6: Use nested-BH locking for
 seg6_bpf_srh_states.
From: Paolo Abeni <pabeni@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Boqun Feng
 <boqun.feng@gmail.com>,  Daniel Borkmann <daniel@iogearbox.net>, Eric
 Dumazet <edumazet@google.com>, Frederic Weisbecker <frederic@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, David
 Ahern <dsahern@kernel.org>, Hao Luo <haoluo@google.com>,  Jiri Olsa
 <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@kernel.org>,  Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Stanislav Fomichev <sdf@google.com>, Yonghong Song
 <yonghong.song@linux.dev>, bpf@vger.kernel.org
Date: Mon, 18 Dec 2023 09:33:39 +0100
In-Reply-To: <20231215171020.687342-13-bigeasy@linutronix.de>
References: <20231215171020.687342-1-bigeasy@linutronix.de>
	 <20231215171020.687342-13-bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-12-15 at 18:07 +0100, Sebastian Andrzej Siewior wrote:
> The access to seg6_bpf_srh_states is protected by disabling preemption.
> Based on the code, the entry point is input_action_end_bpf() and
> every other function (the bpf helper functions bpf_lwt_seg6_*()), that
> is accessing seg6_bpf_srh_states, should be called from within
> input_action_end_bpf().
>=20
> input_action_end_bpf() accesses seg6_bpf_srh_states first at the top of
> the function and then disables preemption. This looks wrong because if
> preemption needs to be disabled as part of the locking mechanism then
> the variable shouldn't be accessed beforehand.
>=20
> Looking at how it is used via test_lwt_seg6local.sh then
> input_action_end_bpf() is always invoked from softirq context. If this
> is always the case then the preempt_disable() statement is superfluous.
> If this is not always invoked from softirq then disabling only
> preemption is not sufficient.
>=20
> Replace the preempt_disable() statement with nested-BH locking. This is
> not an equivalent replacement as it assumes that the invocation of
> input_action_end_bpf() always occurs in softirq context and thus the
> preempt_disable() is superfluous.
> Add a local_lock_t the data structure and use local_lock_nested_bh() in
> guard notation for locking. Add lockdep_assert_held() to ensure the lock
> is held while the per-CPU variable is referenced in the helper functions.
>=20
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Song Liu <song@kernel.org>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: bpf@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/net/seg6_local.h |  1 +
>  net/core/filter.c        |  3 ++
>  net/ipv6/seg6_local.c    | 59 ++++++++++++++++++++++------------------
>  3 files changed, 36 insertions(+), 27 deletions(-)
>=20
> diff --git a/include/net/seg6_local.h b/include/net/seg6_local.h
> index 3fab9dec2ec45..0f22771359f4c 100644
> --- a/include/net/seg6_local.h
> +++ b/include/net/seg6_local.h
> @@ -20,6 +20,7 @@ extern bool seg6_bpf_has_valid_srh(struct sk_buff *skb)=
;
> =20
>  struct seg6_bpf_srh_state {
>  	struct ipv6_sr_hdr *srh;
> +	local_lock_t bh_lock;
>  	u16 hdrlen;
>  	bool valid;
>  };
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 1737884be52f8..c8013f762524b 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -6384,6 +6384,7 @@ BPF_CALL_4(bpf_lwt_seg6_store_bytes, struct sk_buff=
 *, skb, u32, offset,
>  	void *srh_tlvs, *srh_end, *ptr;
>  	int srhoff =3D 0;
> =20
> +	lockdep_assert_held(&srh_state->bh_lock);
>  	if (srh =3D=3D NULL)
>  		return -EINVAL;
> =20
> @@ -6440,6 +6441,7 @@ BPF_CALL_4(bpf_lwt_seg6_action, struct sk_buff *, s=
kb,
>  	int hdroff =3D 0;
>  	int err;
> =20
> +	lockdep_assert_held(&srh_state->bh_lock);
>  	switch (action) {
>  	case SEG6_LOCAL_ACTION_END_X:
>  		if (!seg6_bpf_has_valid_srh(skb))
> @@ -6516,6 +6518,7 @@ BPF_CALL_3(bpf_lwt_seg6_adjust_srh, struct sk_buff =
*, skb, u32, offset,
>  	int srhoff =3D 0;
>  	int ret;
> =20
> +	lockdep_assert_held(&srh_state->bh_lock);
>  	if (unlikely(srh =3D=3D NULL))
>  		return -EINVAL;
> =20
> diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
> index 24e2b4b494cb0..ed7278af321a2 100644
> --- a/net/ipv6/seg6_local.c
> +++ b/net/ipv6/seg6_local.c
> @@ -1380,7 +1380,9 @@ static int input_action_end_b6_encap(struct sk_buff=
 *skb,
>  	return err;
>  }
> =20
> -DEFINE_PER_CPU(struct seg6_bpf_srh_state, seg6_bpf_srh_states);
> +DEFINE_PER_CPU(struct seg6_bpf_srh_state, seg6_bpf_srh_states) =3D {
> +	.bh_lock	=3D INIT_LOCAL_LOCK(bh_lock),
> +};
> =20
>  bool seg6_bpf_has_valid_srh(struct sk_buff *skb)
>  {
> @@ -1388,6 +1390,7 @@ bool seg6_bpf_has_valid_srh(struct sk_buff *skb)
>  		this_cpu_ptr(&seg6_bpf_srh_states);
>  	struct ipv6_sr_hdr *srh =3D srh_state->srh;
> =20
> +	lockdep_assert_held(&srh_state->bh_lock);
>  	if (unlikely(srh =3D=3D NULL))
>  		return false;
> =20
> @@ -1408,8 +1411,7 @@ bool seg6_bpf_has_valid_srh(struct sk_buff *skb)
>  static int input_action_end_bpf(struct sk_buff *skb,
>  				struct seg6_local_lwt *slwt)
>  {
> -	struct seg6_bpf_srh_state *srh_state =3D
> -		this_cpu_ptr(&seg6_bpf_srh_states);
> +	struct seg6_bpf_srh_state *srh_state;
>  	struct ipv6_sr_hdr *srh;
>  	int ret;
> =20
> @@ -1420,41 +1422,44 @@ static int input_action_end_bpf(struct sk_buff *s=
kb,
>  	}
>  	advance_nextseg(srh, &ipv6_hdr(skb)->daddr);
> =20
> -	/* preempt_disable is needed to protect the per-CPU buffer srh_state,
> -	 * which is also accessed by the bpf_lwt_seg6_* helpers
> +	/* The access to the per-CPU buffer srh_state is protected by running
> +	 * always in softirq context (with disabled BH). On PREEMPT_RT the
> +	 * required locking is provided by the following local_lock_nested_bh()
> +	 * statement. It is also accessed by the bpf_lwt_seg6_* helpers via
> +	 * bpf_prog_run_save_cb().
>  	 */
> -	preempt_disable();
> -	srh_state->srh =3D srh;
> -	srh_state->hdrlen =3D srh->hdrlen << 3;
> -	srh_state->valid =3D true;
> +	scoped_guard(local_lock_nested_bh, &seg6_bpf_srh_states.bh_lock) {
> +		srh_state =3D this_cpu_ptr(&seg6_bpf_srh_states);
> +		srh_state->srh =3D srh;
> +		srh_state->hdrlen =3D srh->hdrlen << 3;
> +		srh_state->valid =3D true;

Here the 'scoped_guard' usage adds a lot of noise to the patch, due to
the added indentation. What about using directly
local_lock_nested_bh()/local_unlock_nested_bh() ?

Cheers,

Paolo



Return-Path: <bpf+bounces-28711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF3D8BD586
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 21:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2C091F210EB
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 19:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533D215AD9C;
	Mon,  6 May 2024 19:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fChv2u3+"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E32E81207
	for <bpf@vger.kernel.org>; Mon,  6 May 2024 19:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715024505; cv=none; b=p/8hMbY9ZKcYxtcO2NTEouBhHRzFuRS9Nm4W0WPqLCIUsGS1n4GQijrpsXLlLBsTKBrscr1GYM88LiUjbGt51lS+VVrSOriXBSiSgNrleEYPWI50tWmukWmLLoHSHopNxUxf1BWsB5gq3xJWmWws7mANCYzXxoHHeKi3J+8DDFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715024505; c=relaxed/simple;
	bh=PrBhS5DyGnBu39z/bV+pMeXm6EsKEDKCW+dJYY8AEjI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sTUelVZnyoo9eAPRuPwTprlzrL8u+ixxmdUzQ5vRW7OHBf61MZPhXSBrPugOcf7cQIiN08bZ0j+00cJ5Hb/+P7OhdufFc4kMlTDpkF/H5gDklGp5xuC19lvyUMN3CsIxI6cuF9aClz154xk8aQ/AQMrzODmBB3ugYYb+SzKv/u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fChv2u3+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715024503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DY+sYZC8mturY+dnlOrnmUuxCVCJqkhdnmld3ulR81I=;
	b=fChv2u3+WpCAUw3DyLxnkgw/qgz7o0g9nlw9fUnTVqeiaWtCadr5hlX+m8ZopCpPL4zGMp
	DxZtvjk5YzOk8By+12MvQ0dYGRmaVvKKyGISZfis3HFIkyYPye2FYZxazQhymLky2NH7oa
	Tzo1z2s3fYVJRLiSs5+hNelLGDyrDyc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-nxr4KWjdMUKCc1bcs5GZYA-1; Mon, 06 May 2024 15:41:41 -0400
X-MC-Unique: nxr4KWjdMUKCc1bcs5GZYA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-34dcec2cbbbso1716739f8f.0
        for <bpf@vger.kernel.org>; Mon, 06 May 2024 12:41:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715024500; x=1715629300;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DY+sYZC8mturY+dnlOrnmUuxCVCJqkhdnmld3ulR81I=;
        b=URyyaKD/wM2IMevC3rHb4pGHXkhtzbnBOSmVUiAfYQYKT49nqEp4+vvQqh9Sk5ohOI
         RMsdPPd0j/SaoznboZ1BxYmY0BBG1zOI2egLVE5a17nmXtZf9/jJ1Pbg0D/ndRlOBBoY
         UPJf4qFuN+W8llQchqfBTQZ0YUQMJa0OLg3mMgHXXno9aTHCMVudQZodrVtQYWyXXRbK
         sQg5t6/qmwBamcQJI9lV5Cpt7D1BvR00lDjMrEdlPqDqc6uVz5QdPEGt/19PmOSmTOG/
         2f8d+YbgjQRphv5nfTpO9lGecQezMOplCcQJR/RVZpP2e1FicACXNjMflv3Xk7fYHdI9
         a7Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXENKGuFDZiMwFB0ZhJZbffUUdr23Zl2jRysHQ30MM+RKP1AfUf4GU9Q6auh244X5r3STk5lopThp9twR6e+HMxNJHK
X-Gm-Message-State: AOJu0YxuLSTJDFr63eAETozN2nxBoUXG9you+9GvN1mHTcwRKFJIq5v/
	kf3Asix/6mSyPgtjzLvpYcp/JTeAt/UazFKPVUPptn4Sv/xUMo410uAnF7FP2JqZ3SVZvAX4BFi
	wPta9qlpChnjgpgm3i4uDOBM7XB/fgJAb6aafTwfSjYUZXOuz3g==
X-Received: by 2002:a5d:4404:0:b0:34d:354:b9ba with SMTP id z4-20020a5d4404000000b0034d0354b9bamr7042496wrq.30.1715024500710;
        Mon, 06 May 2024 12:41:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaokgN4DJrI/5hz3+xQUzTXmGqJHdlwJ5Sbtxf1d7FO21ctPZPxyFm8wyqqr/TggXdaqWO3w==
X-Received: by 2002:a5d:4404:0:b0:34d:354:b9ba with SMTP id z4-20020a5d4404000000b0034d0354b9bamr7042472wrq.30.1715024500275;
        Mon, 06 May 2024 12:41:40 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id f6-20020a5d58e6000000b0034dd063e8dasm11301564wrd.86.2024.05.06.12.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 12:41:39 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id D92311275C73; Mon, 06 May 2024 21:41:38 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Boqun Feng
 <boqun.feng@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, Eric
 Dumazet <edumazet@google.com>, Frederic Weisbecker <frederic@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Waiman Long <longman@redhat.com>, Will
 Deacon <will@kernel.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Hao
 Luo <haoluo@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Stanislav Fomichev <sdf@google.com>, Yonghong Song
 <yonghong.song@linux.dev>, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 14/15] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
In-Reply-To: <20240503182957.1042122-15-bigeasy@linutronix.de>
References: <20240503182957.1042122-1-bigeasy@linutronix.de>
 <20240503182957.1042122-15-bigeasy@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 06 May 2024 21:41:38 +0200
Message-ID: <87y18mohhp.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> The XDP redirect process is two staged:
> - bpf_prog_run_xdp() is invoked to run a eBPF program which inspects the
>   packet and makes decisions. While doing that, the per-CPU variable
>   bpf_redirect_info is used.
>
> - Afterwards xdp_do_redirect() is invoked and accesses bpf_redirect_info
>   and it may also access other per-CPU variables like xskmap_flush_list.
>
> At the very end of the NAPI callback, xdp_do_flush() is invoked which
> does not access bpf_redirect_info but will touch the individual per-CPU
> lists.
>
> The per-CPU variables are only used in the NAPI callback hence disabling
> bottom halves is the only protection mechanism. Users from preemptible
> context (like cpu_map_kthread_run()) explicitly disable bottom halves
> for protections reasons.
> Without locking in local_bh_disable() on PREEMPT_RT this data structure
> requires explicit locking.
>
> PREEMPT_RT has forced-threaded interrupts enabled and every
> NAPI-callback runs in a thread. If each thread has its own data
> structure then locking can be avoided.
>
> Create a struct bpf_net_context which contains struct bpf_redirect_info.
> Define the variable on stack, use bpf_net_ctx_set() to save a pointer to
> it. Use the __free() annotation to automatically reset the pointer once
> function returns.
> The bpf_net_ctx_set() may nest. For instance a function can be used from
> within NET_RX_SOFTIRQ/ net_rx_action which uses bpf_net_ctx_set() and
> NET_TX_SOFTIRQ which does not. Therefore only the first invocations
> updates the pointer.
> Use bpf_net_ctx_get_ri() as a wrapper to retrieve the current struct
> bpf_redirect_info.
>
> On PREEMPT_RT the pointer to bpf_net_context is saved task's
> task_struct. On non-PREEMPT_RT builds the pointer saved in a per-CPU
> variable (which is always NODE-local memory). Using always the
> bpf_net_context approach has the advantage that there is almost zero
> differences between PREEMPT_RT and non-PREEMPT_RT builds.

Did you ever manage to get any performance data to see if this has an
impact?

[...]

> +static inline struct bpf_net_context *bpf_net_ctx_get(void)
> +{
> +	struct bpf_net_context *bpf_net_ctx = this_cpu_read(bpf_net_context);
> +
> +	WARN_ON_ONCE(!bpf_net_ctx);

If we have this WARN...

> +static inline struct bpf_redirect_info *bpf_net_ctx_get_ri(void)
> +{
> +	struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
> +
> +	if (!bpf_net_ctx)
> +		return NULL;

... do we really need all the NULL checks?

(not just here, but in the code below as well).

I'm a little concerned that we are introducing a bunch of new branches
in the XDP hot path. Which is also why I'm asking for benchmarks :)

[...]

> +	/* ri->map is assigned in __bpf_xdp_redirect_map() from within a eBPF
> +	 * program/ during NAPI callback. It is used during
> +	 * xdp_do_generic_redirect_map()/ __xdp_do_redirect_frame() from the
> +	 * redirect callback afterwards. ri->map is cleared after usage.
> +	 * The path has no explicit RCU read section but the local_bh_disable()
> +	 * is also a RCU read section which makes the complete softirq callback
> +	 * RCU protected. This in turn makes ri->map RCU protocted and it is

s/protocted/protected/

> +	 * sufficient to wait a grace period to ensure that no "ri->map == map"
> +	 * exist.  dev_map_free() removes the map from the list and then

s/exist/exists/


-Toke



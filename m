Return-Path: <bpf+bounces-30867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C66448D4014
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 23:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E92281C21E4A
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 21:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920BA1C8FDD;
	Wed, 29 May 2024 21:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfpoWjlx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A22415CD77;
	Wed, 29 May 2024 21:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717017008; cv=none; b=X6iWkSodRsA+H2lLhNaOd/7PSTjpf8eKllFmp1xDkWFebkqnrZAN3O99RaEV0pIg/wb7tftFrU9BbM2g8YBUVMc1GKEnuN/ws7ETb74vfQwbaOXufkWST9v0gQhkhSLzVABbIhj/6gbd2211GF1PsHVKYBkU+JjDVy8lgHfyHnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717017008; c=relaxed/simple;
	bh=nGQy73DAo3leSbrH36Ug7nwnjOODDwttCseobzHsCIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SBliNspBNfmN9D2/1uo72o1SqLhXLmp6dvWC8SSnXRh9extDDRnXxRQbkeTjId9497FC65iwQic+WWefPJEv1L6hzA8l1T1dON4yJxtKnDU2m567U1PK/ibFgMsczpx+fZnB42MtUX8u9xjFWep0n8SXaB2luhOMmgsqeCKtzQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfpoWjlx; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-35dc7d0387cso2537f8f.1;
        Wed, 29 May 2024 14:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717017005; x=1717621805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7C6JZl3C8DroVKk711JXPTj52xkuM6toBFf9Z9aPOBA=;
        b=jfpoWjlxovwiWgX0uF3sc1DO9LlzRuqlAqbzEXGWEnXdYKtXFiVKowhpdaS9YJwfwV
         PzATGdGi7zb9fY5Nl+gkI2kMdhJOL+fGP3EBwIpc8outZdClnKCN56MSxIfd/b8osJE8
         cltTCggJiToR2ebkWFW+oXBWee60XCqJauY8skglqqygBbkd21XGvKGRPjY8yPTBMDme
         B2YWCYcDO0jJ/rG3rya3jpBOav4GZrN1eDUWJ0WkozYmPsXUTlmrcFxinxUSOMBmnNyH
         eZBSi/fGpUUDUib00jaSc28LchpjSGJ87WV1ypfQveK0fPkZRWWUnUdavyhNNQyrccwX
         YogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717017005; x=1717621805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7C6JZl3C8DroVKk711JXPTj52xkuM6toBFf9Z9aPOBA=;
        b=LZP4kXClJWWI/vWPGPKNWTw/OWhwFIudwv6CWeiufOJN6tzytCo1c9qs3NJKrDRUES
         PaZZXeRLA4+YJnM2Okh/xWTTftHPHLoRkTpY9jG1HyiBAChDLhp5ftO2Oyab05/7XYCp
         RC2DQiqXllMTtFjNq0JS0UsYpTy5FPB+RaYa6AyQrbnRvBB3ofWqBwg2vQGOXXrwKJdQ
         bnfhshqyAL1LwTHtfncwiV3f2rqolsGnUkJym44i7vkdhhisMYWNDM42wNVbj1yh5W/t
         90JeRwYhvAgYjZ+Jt8mwxHBc3Edh/YDwipxwAg1iMzUcBCODs5vEyKRFndLmT2H8JbUB
         iQPQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6rcwKbt/uT7IZCRW9eH9X5MD+8psxryQ+MM4uquqBoQ8YMAM0LWjfL2vwlzEEXyDmK7KY8AoAzYOR1U7msxHSKPGa3QhkCRfoKYLMbL6wS9j5/7vWryZl6BA1
X-Gm-Message-State: AOJu0YwBy58ejzPHrGd9TwNFAc9VaaTAkKk5hMpDwiZGloGSuDRPZPu6
	p8wI/EyTEDlTi8zLmiNRc+W70J4zBrXKIHCe4TKLWVrKFNIAKNUo1nWop6W0BZv/wuC6Oc87gZa
	xsf6VG7BkkfcJ/Of8Z+16D/L6JCg=
X-Google-Smtp-Source: AGHT+IEq7fq4OW9x/wy52LRqJ7hU1NbQGIWaqLnwqTFnDA6Df5a+GDkRV3ynogRd29CbZ3vu7vZ4P0f8oX4fR1eyEQ8=
X-Received: by 2002:adf:e382:0:b0:355:7e4:3cfb with SMTP id
 ffacd0b85a97d-35dc008d9aemr246101f8f.23.1717017004596; Wed, 29 May 2024
 14:10:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529162927.403425-1-bigeasy@linutronix.de> <20240529162927.403425-15-bigeasy@linutronix.de>
In-Reply-To: <20240529162927.403425-15-bigeasy@linutronix.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 29 May 2024 14:09:52 -0700
Message-ID: <CAADnVQLvu-in6g9493vovq=RAtTyaV56CUYpNNbEMT9C++ehjg@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 14/15] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Boqun Feng <boqun.feng@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eric Dumazet <edumazet@google.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Hao Luo <haoluo@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 9:29=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
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
>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jesper Dangaard Brouer <hawk@kernel.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Song Liu <song@kernel.org>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: bpf@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

lgtm
Acked-by: Alexei Starovoitov <ast@kernel.org>


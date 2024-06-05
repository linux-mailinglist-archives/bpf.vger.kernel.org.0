Return-Path: <bpf+bounces-31426-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C14BD8FC8D5
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 12:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35F4E1F22D49
	for <lists+bpf@lfdr.de>; Wed,  5 Jun 2024 10:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728B919147B;
	Wed,  5 Jun 2024 10:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TcROZiQ8"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D720191471
	for <bpf@vger.kernel.org>; Wed,  5 Jun 2024 10:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717582845; cv=none; b=fqrvMj7JQvAN75bhcURWQJ22KgR5ofHxiYBpA0J+eCR1NGXwZhY4feXTsZhPmFhbwSyU/dYqkusQr1quHh5lu5ezmbY8awWO05d0+slFLP/W3p3RdVbjDUn5aK5t9c0z/FfyvOgvCj2tps/ko+TO5y1Wui50c2TtNk8NEtpyOhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717582845; c=relaxed/simple;
	bh=KchsD3JnU7DsaQ4R9YN5x/kCx7wa+/YGiI9tYcQcRYU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uLd3FU2MptUdpI1qcmgegWft59m/u0y5oO9NIkkf+ov2h6djD6iylt+6np2zDw20RC83MT8zoI5aPCUWeMCvZq4gyo5tjmK6C6ta9ekDKrKdymmIufUpveYvPUHLt12mXgZlDhE2h3N6GS+Iul2fP+UhtYBFaFTwSBkiINgN5qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TcROZiQ8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717582842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tjjkFcz5nt2P4PDLXs8EVX3oErPCvXtoE8dmYvaKaqI=;
	b=TcROZiQ8hOZXBoqwMk8p2UQcbds1EqKUeDx3pVoX4AiqravQLUIkhXmwGOtHBD9uxlEo1M
	btsDsENCFJ7aVXhtb5QLZMcQHM0x43aVx9BU8ZT1yBU4SvMDNI1nf6FCVfUq8fZSNxKB0H
	PWz9w9Ihk6tzQcgbMMlI293IgQdeLeo=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-MNuL-ukmNBWy5v4N8OKZYA-1; Wed, 05 Jun 2024 06:20:39 -0400
X-MC-Unique: MNuL-ukmNBWy5v4N8OKZYA-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-703e42340bcso612086b3a.1
        for <bpf@vger.kernel.org>; Wed, 05 Jun 2024 03:20:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717582838; x=1718187638;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjjkFcz5nt2P4PDLXs8EVX3oErPCvXtoE8dmYvaKaqI=;
        b=s2fvn6Dg/wES38QpqC6sB3zFFZk+Xy+38XkIrxYupBNtzzL2yoYpQnNN6VpS1/hilk
         L/+Hywba5EXl0EoiJBfE1jFcDrAoiJJyoqTxG9RX3QON1unZD9hTRnz+qqBSlm8ic9oW
         9vUnbw02q4G4/KKqOfF0mC97WU+rict/lnRPnGqUXXunDXmpO3UT9LlzRMN9r8MLtVda
         TqsfBFSalBDkIMq9b/Vq8pB2AwXW+3DHbsL35pNbxKwrx+BHPweCuoGnq3rUMBg9VymS
         6fQ7lhkIZamVCYF1wbIF2B6tlSgltmV7nGY2BK6ouub63j3w5m0AenqCKHFRviD70I9S
         bKRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRHklV8hQulGaAyAYr0wbyouzKuAODXbs5BibMl/roNqBot5kVDtC4Ua2//aaMiGpTzhQZjOMPZElgtGI3TBZ4qSXf
X-Gm-Message-State: AOJu0Yxd96zVZ3CLyi8HlIho3vtyGyWm5tBoqNsCRuoX5nC1QRYTrP8V
	ZcVw9anHhAWulsgMgPttNMJoFiBrA/8wWBHvjugm80COanr44m4e4WXHBAHEtbX/SgCmhkY0A7R
	P7T9Elk061IgglMuFJLlOfZVzJ2FqG9WcYKDjxqSQeGSEm92TkA==
X-Received: by 2002:a05:6a21:328d:b0:1af:fff9:1c59 with SMTP id adf61e73a8af0-1b2b6e2a25amr3331618637.2.1717582838326;
        Wed, 05 Jun 2024 03:20:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJfsc5Ha+Gm0UXE43JB22hMLFqLZJcDbQGdzxVIlVgK2HPL3ko4zVMM+J1PrkIsbsUAbmdpQ==
X-Received: by 2002:a05:6a21:328d:b0:1af:fff9:1c59 with SMTP id adf61e73a8af0-1b2b6e2a25amr3331590637.2.1717582837895;
        Wed, 05 Jun 2024 03:20:37 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242b2c586sm8356415b3a.188.2024.06.05.03.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 03:20:37 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4AE7C13854FA; Wed, 05 Jun 2024 12:20:32 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Daniel Bristot de Oliveira
 <bristot@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Daniel Borkmann
 <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, Frederic
 Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Jiri Olsa <jolsa@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Stanislav Fomichev
 <sdf@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 bpf@vger.kernel.org
Subject: Re: [PATCH v4 net-next 13/14] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
In-Reply-To: <20240604154425.878636-14-bigeasy@linutronix.de>
References: <20240604154425.878636-1-bigeasy@linutronix.de>
 <20240604154425.878636-14-bigeasy@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 05 Jun 2024 12:20:32 +0200
Message-ID: <87frtradxr.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

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
> Acked-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>



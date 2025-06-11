Return-Path: <bpf+bounces-60307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 964B4AD4F00
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 10:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48CF67AB71D
	for <lists+bpf@lfdr.de>; Wed, 11 Jun 2025 08:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976F5242D6D;
	Wed, 11 Jun 2025 08:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=datadoghq.com header.i=@datadoghq.com header.b="LoaQ6g0m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE34323F43C
	for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 08:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749632275; cv=none; b=Y9oHb+kst8ZxfwGgvlQiBwcwG8+wyxHQMU9ZUYeCLEXnqXSYI8HMN90UYjDxOjUmCatGHgNOJqLjHEnxRT+W3eG584q5sScPRNVUK1g9WtBberPAANxBnm+9eP2x4sfifWHkIlMiHkOQ7iZ6zxQdto90jHuQiS10CLCH+EgOGzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749632275; c=relaxed/simple;
	bh=PuA2ndzsf6qV8+DZjFJzpHjynq2dG7WznWmQHytru3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IYIl+ATWcOCMRQ1FIqp8pmIiqetE258c04OafSMhiRpb9LKUB40Y8+I2AgqFVnrivu8CZZoHgZNgvOFav9fq2CLbRP+FKj+6WBB++rDcJLI5qTZeUhtho230NKCYVC/amo6KyIIoFEef+fO5Sq7njhAHfx/U95hZRDXF8PVtwUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=datadoghq.com; spf=pass smtp.mailfrom=datadoghq.com; dkim=pass (1024-bit key) header.d=datadoghq.com header.i=@datadoghq.com header.b=LoaQ6g0m; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=datadoghq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=datadoghq.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71101efedabso288847b3.2
        for <bpf@vger.kernel.org>; Wed, 11 Jun 2025 01:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=datadoghq.com; s=google; t=1749632273; x=1750237073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjvJV8ZhcGRvupyFP8whmvE6fGj3kxjqSux4Bqr/JI4=;
        b=LoaQ6g0mPMhTb7fyzIU3bmntaTCp7CGdK/drhZbkPs/hRBJgjgce0mZWwYrPtYAhsJ
         OtwXhEVollwO1PWAYd2HxLyh2S38tSadJGED6CgS03qv9vZjTHStV4aX4uAfN4EO2x9h
         jqyBiNl6fba1d0LS+N3YUdQXh5M8WKvBK+VjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749632273; x=1750237073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jjvJV8ZhcGRvupyFP8whmvE6fGj3kxjqSux4Bqr/JI4=;
        b=WuthaynrWDAgarhNQmCqV7U3g7sAUkLahKDYXoXHx4ZdIgi1/oQFO4JVm9Qb2uHAf8
         qH/zxMNsYAUgwUmrtng4BKg1c40N8Chd2NLHSrfKOYN9yMB69MaJxgE3yCxoj8tzffNj
         IwCzUFeO1ENgXeyWVPFiLlds71DmezobPC5DfG9jY2uh5Fc8D8Af6gIX7EYJJ25ncUem
         2oj08araGYwY07lqj4/93bV0NsOv/Y1o2nONlbUdUAwum3k3WgE3bzkkmPxRYyqyAwmt
         6xbm6NWHvz0RDqaIL0PTVAacApq+/rA5yGUjRWIlydA2sJcfphq1w2ny9gno5Wd/sVsr
         Uauw==
X-Forwarded-Encrypted: i=1; AJvYcCX/03qCRkkIcNyrkQSlbaAKcHP7FIm+hmII8P7K7UcWk9V7+6i6jXmEuwzEAB97k5km2bQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvTaJiF26XM9xYExPXTYlhxelHOOA26pqen7jOx5q7Mz6QNYqW
	uIFlGO7pro/1rk9o9Gu86MqtTWCQVYSHv+7qbgWCe+uZtGJk2sQaRLrs7QZt1yKk3VGNHcKqf3U
	FSi+fx9PEadPSdayku3fUaX7i2YcII5Et9+h5YAS1LQ==
X-Gm-Gg: ASbGncttVnJj6+zjT5A0ZdNNRDhFNRQrq1oBSIsiACra9b6d885p0Ep6kn0WTVYfGcy
	Xd4ljQrgchbtEt1iOwGzvfFBaQr5a0k6DbktRnfEJUyR/mhcX9y0QmVmuvZ8NzsOrgG9QJYimU5
	Qm9SDy9SrCFYhu4nQZn6G3tmox4hruPN/ifGoT4Ol7+1mO/9ZsHLjxvYhK
X-Google-Smtp-Source: AGHT+IFFUX7swcm0JEVkBkoeXBxQqu33hMdHpH5TkNq62BrSmW92rmo/SE91S3zNAbTom0l5kxhyos7zTLCHUuzheJg=
X-Received: by 2002:a05:690c:3685:b0:70e:4cdc:6e7a with SMTP id
 00721157ae682-71140ae3679mr14818867b3.6.1749632272516; Wed, 11 Jun 2025
 01:57:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609-sockmap-splice-v2-0-9c50645cfa32@datadoghq.com>
 <20250609-sockmap-splice-v2-1-9c50645cfa32@datadoghq.com> <20250609122146.3e92eaef@kernel.org>
In-Reply-To: <20250609122146.3e92eaef@kernel.org>
From: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
Date: Wed, 11 Jun 2025 10:57:41 +0200
X-Gm-Features: AX0GCFthcjUN2-ZcbaCjBFu9eICTHSIis43T6ijos1tz5aAY4JHlgHWN205uMSw
Message-ID: <CALye=__1_5Zr99AEZhxXXBtzbTPDC_KEZz_WCDDavjwujECYtQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/5] net: Add splice_read to prot
To: Jakub Kicinski <kuba@kernel.org>
Cc: Vincent Whitchurch via B4 Relay <devnull+vincent.whitchurch.datadoghq.com@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 9:21=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
> Can we not override proto_ops in tcp_bpf for some specific reason?
> TLS does that, IIUC.

I see that TLS writes to sk->sk_socket->ops to override the proto_ops.
I added some prints to tcp_bpf_update_proto() but there I see that
sk->sk_socket is NULL in some code paths, like the one below.

 tcp_bpf_update_proto: restore 0 sk_prot 000000002cf13dcc sk_socket
0000000000000000
 CPU: 0 UID: 0 PID: 392 Comm: test_sockmap Not tainted
6.15.0-12313-g39e87f4ff7c3-dirty #77 PREEMPT(voluntary)
 Call Trace:
  <IRQ>
  dump_stack_lvl+0x83/0xa0
  tcp_bpf_update_proto+0x116/0x790
  sock_map_link+0x425/0xdd0
  sock_map_update_common+0xb8/0x6a0
  bpf_sock_map_update+0x102/0x190
  bpf_prog_4d9ceaf804942d01_bpf_sockmap+0x79/0x81
  __cgroup_bpf_run_filter_sock_ops+0x1db/0x4b0
  tcp_init_transfer+0x852/0xc00
  tcp_rcv_state_process+0x3147/0x4b30
  tcp_child_process+0x346/0x8b0
  tcp_v4_rcv+0x1616/0x3e10
  ip_protocol_deliver_rcu+0x93/0x370
  ip_local_deliver_finish+0x29c/0x420
  ip_local_deliver+0x193/0x450
  ip_rcv+0x497/0x710
  __netif_receive_skb_one_core+0x164/0x1b0
  process_backlog+0x3a7/0x12b0
  __napi_poll.constprop.0+0xa0/0x440
  net_rx_action+0x8ce/0xca0
  handle_softirqs+0x1c3/0x7b0
  do_softirq+0xa5/0xd0


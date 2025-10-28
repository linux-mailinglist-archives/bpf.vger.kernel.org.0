Return-Path: <bpf+bounces-72507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2215CC13B95
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 10:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B71273B2233
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 09:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D11E2BDC34;
	Tue, 28 Oct 2025 09:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H7yBZpRD"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ED62D77F5
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 09:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761642636; cv=none; b=hKkKttYQ/CVaVTxtW5aJqUekHBQabjokIth1OYeUqbVOJ0R+0XdCvhqDUe08f/k8dPzBRVMlaT9tzYjP4yL2hfUpBZ9CU/bGuTihMAg+S+SQaqO/a7QQJezVktzmvdNAa99qhUZbVTbp6CjHIsGSuLJ4+xrjJ1cfSueQZ+lNUrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761642636; c=relaxed/simple;
	bh=gsaXk6rPSnT3/htmS1wC1UxgQ9W8HC0fe87DUuj7boA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iF4I6hD7TgUU63qJR4OeNrx5J0d5jyDRLMPUnfnsf951LnZjSRUHrgFsZkglZRPVnMWhNVc/l0Dow83Iohbdo2l26R+ITCtVurAAjnc1+d82mdEH835XzdrSKkq5L7XhNW9/XhVP9sqGvsUsqN+Y7eoE3s8Tru7ge3+zHyjfCQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H7yBZpRD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761642633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9fC2VCoLVnfLvc+GVN6vMzms7DTor0VnmsdHYFXK6aw=;
	b=H7yBZpRDmG6FDvDNe1OUeNStN7meFo7sma3g0PNcS3W6GigR8K4PMCOX90Y4SobWXlnDXa
	/O4EjRe9ZvqXEfr/yyvLmyEG5bVdYkStdg8MFuzYjqvPrfKQPCHKCdNvGbXga3hGr3LUH4
	0OoSC1JOqCSpffsOmWT9mwrIfhONPic=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-aQnviCjIMi2j_bsSnZaEfg-1; Tue, 28 Oct 2025 05:10:31 -0400
X-MC-Unique: aQnviCjIMi2j_bsSnZaEfg-1
X-Mimecast-MFC-AGG-ID: aQnviCjIMi2j_bsSnZaEfg_1761642631
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b6d7ad47b58so336874466b.1
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 02:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761642631; x=1762247431;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fC2VCoLVnfLvc+GVN6vMzms7DTor0VnmsdHYFXK6aw=;
        b=F5I0oUU+0OGZsL3quvC1kyg93KXunV5zDlDNbRIha7u6zmEOqcG3A4T46JHdNcvMX4
         lUneOYWDuozqGPyzek+TTcNJQ8xFhdDhMMCzvDTqx98GDSkd9tgauHapO5BhEnG/B8GU
         LPlC/gcvdrUx0fi2vawWUjOQ9EryA/nUWOj54en/ZBGCHKOoo2UjaM7crognVavhIBI8
         IuY1vY7FKExMeY2MVTtRrv3+EQz0vJA5a4V1aTy8oMvD3Aw6QSNLH5OMXWLCMz3jIEIR
         63zu0JY9+OIxFJeEU+eV9WlftS3HkwVdFLe4ZfN992QD8CVSAweDqUL/Lz3yXZPKG4MX
         g2iA==
X-Forwarded-Encrypted: i=1; AJvYcCWZyDcPdVrtSL8CkMeJcA/YHHhrjhg13jOsGljFsNAfbM1ddBRoCl+jsdylUJjoSW+M4yI=@vger.kernel.org
X-Gm-Message-State: AOJu0YycMemGyXBcHtmAruNJqwZWXBeNYGokrf052oKfdmycrPiKxW1x
	fPOrU/dyFFLW6eVmvEVSZAVn9wi+J44AK1IOmNxF/bYAldHtmmwsH59lwDDqfGgnQziLEUBsPbK
	qMG9iflbiEytrU9CFSQFu+FjMfmHiNASDayZo/VOYrFWpbq19ajAj8g==
X-Gm-Gg: ASbGncvtgOt4CicZle8NaEi6JfVRHc/hi8/vuPp/QX4/RwkMB8R0l0nBSs8rglxp0ua
	m8mwVUTb85W/eN183PPpSPJLzdGauRERSxqtkdJviS1gkrSSJ3eqsX+FiQF7zqovMMcGdnIWnIg
	ZBJw7MnhnK+54SbCPhLY9E5OI3fWSaHfiv3PGlv2q9FjCq0gqx6l/l946+1l2tAT/tJcXTvmq/x
	pTHk5gONnuudtMa48d/frXr4kgwBeaJvXAjqKE1Qzf7v+WHfQGbALXcYF1f88RquN4XeBSLrkDO
	OEu9fby6qV85x/8IecWRvWdrJZyMksaqhBxGelYuM/mZIBSv8KqljaOnCPQdy4dOMSbx6MHDAe5
	ZTqMMEbljH+xjmTYRv3FhX40=
X-Received: by 2002:a17:906:7314:b0:b6d:5f02:51e1 with SMTP id a640c23a62f3a-b6dba48ed89mr308758366b.20.1761642630690;
        Tue, 28 Oct 2025 02:10:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp5fIM3h+FEyqEOS5MHMS5ieohkbVb2Z5rr/lbPP90LvTja8uJXC93IQE7iLbY3k1MDqtHAA==
X-Received: by 2002:a17:906:7314:b0:b6d:5f02:51e1 with SMTP id a640c23a62f3a-b6dba48ed89mr308756366b.20.1761642630332;
        Tue, 28 Oct 2025 02:10:30 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8548ed9asm1045251566b.74.2025.10.28.02.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 02:10:29 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C0E5E2EAC74; Tue, 28 Oct 2025 10:10:28 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Eric Dumazet
 <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 ihor.solodrai@linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 makita.toshiaki@lab.ntt.co.jp, toshiaki.makita1@gmail.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel-team@cloudflare.com
Subject: Re: [PATCH net V2 1/2] veth: enable dev_watchdog for detecting
 stalled TXQs
In-Reply-To: <176159553266.5396.10834647359497221596.stgit@firesoul>
References: <176159549627.5396.15971398227283515867.stgit@firesoul>
 <176159553266.5396.10834647359497221596.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 28 Oct 2025 10:10:28 +0100
Message-ID: <87ecqne6ij.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> The changes introduced in commit dc82a33297fc ("veth: apply qdisc
> backpressure on full ptr_ring to reduce TX drops") have been found to cau=
se
> a race condition in production environments.
>
> Under specific circumstances, observed exclusively on ARM64 (aarch64)
> systems with Ampere Altra Max CPUs, a transmit queue (TXQ) can become
> permanently stalled. This happens when the race condition leads to the TXQ
> entering the QUEUE_STATE_DRV_XOFF state without a corresponding queue wak=
e-up,
> preventing the attached qdisc from dequeueing packets and causing the
> network link to halt.
>
> As a first step towards resolving this issue, this patch introduces a
> failsafe mechanism. It enables the net device watchdog by setting a timeo=
ut
> value and implements the .ndo_tx_timeout callback.
>
> If a TXQ stalls, the watchdog will trigger the veth_tx_timeout() function,
> which logs a warning and calls netif_tx_wake_queue() to unstall the queue
> and allow traffic to resume.
>
> The log message will look like this:
>
>  veth42: NETDEV WATCHDOG: CPU: 34: transmit queue 0 timed out 5393 ms
>  veth42: veth backpressure stalled(n:1) TXQ(0) re-enable
>
> This provides a necessary recovery mechanism while the underlying race
> condition is investigated further. Subsequent patches will address the ro=
ot
> cause and add more robust state handling.
>
> Fixes: dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to =
reduce TX drops")
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>



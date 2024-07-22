Return-Path: <bpf+bounces-35222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D78938DBB
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 12:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72372281AAC
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 10:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454D816C87D;
	Mon, 22 Jul 2024 10:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xff0ZiAG"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C0816C864
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 10:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721645859; cv=none; b=fCyDTkPTK5ni1mV9fbaPdiQTLFex/juSx8yWi9aZYo/O+U80WjtRJs+S51W5gLKGniskZ/Sj3eWcxP0utYFdChoZeRjUOej/duM2ICe0bnQYlreFZGHGEBRPiJcWyRkw2dUMyaDWxPZkaJx85tjZt//nLeMptce9vkXFaLOZ3gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721645859; c=relaxed/simple;
	bh=7dDz9VbbdYDhI0hnukUQaik47Bs6vtx9w+tphDLQb/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I4w3vKm5RLL1FxPA7eYEQfp7g2mmVi+4Gm0DtLbsAAlkBAfTp7ctcH8qf+AUKzwly59qIhwgLMofkMsra51aEDbOTxGF47L4/LtFo0UPxPtHJ+YgukvazkpLH1kwfQCsZxSKI3qAE1yN/Xt5QP8AO3NBuRtTrQDAC2EYgPXeDbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xff0ZiAG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721645857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7dDz9VbbdYDhI0hnukUQaik47Bs6vtx9w+tphDLQb/E=;
	b=Xff0ZiAGZBSAr8yiJIe8+REp57dzXMgjg64ksssZ54atcMgFisik9jwBtwEofTvJ0dZ9wb
	7fnj5yFeL1fxVzERdTsX/oi8ETEl7wxpciW3XKK1Pop3SZHqbVIOixsuPnW7Am/idj1Qo1
	jedtsOGI9KjThzA75agZaVG8W14TqRs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-Xtdv1bdRN9OQmJ8QnbP5sg-1; Mon, 22 Jul 2024 06:57:35 -0400
X-MC-Unique: Xtdv1bdRN9OQmJ8QnbP5sg-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b798fa1812so81828136d6.2
        for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 03:57:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721645855; x=1722250655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7dDz9VbbdYDhI0hnukUQaik47Bs6vtx9w+tphDLQb/E=;
        b=vJYTAitscIYuy+V285GonYEuXzMps5kowi6iSB1e4z8yxYWilR/29A5qKLTq1Jl2J7
         qR/iPsWYKKZRXvFKVaQ0aoPQ0eCzfCFoK1RM8AUoUsHtVgmngI9nEdFq2xSPE2EK6vQT
         r1bmZ3/VYGOc5+jqHT50CMGBRN0S8ccAoK6MVZocnMQGrk4RHDqis0gU2wktZtYv1JRV
         g+cp7LlFusZTaPh2B0Ej1nKKWCbNZ3nyzNmhmz9RaaH6GUqd8fygETLedGFB+lh4B1/C
         c3/N6k64kbvLYMDFixU+/NvUzw/7hUKoM0mI94pKdnwttbEePkZQlJlhEh/8FUMb8nyE
         kp2g==
X-Forwarded-Encrypted: i=1; AJvYcCU4Fd8bQHqTCRSzklrHCiRWUYBDfxTk1tzPUq7pZ6+eQyR5pz9+LIfXZ0iBYpU0OknPE46lmxJpAF7rXpbD6qRu7Gqz
X-Gm-Message-State: AOJu0YzhP7YM2qmqT+EtcuE7TaImeYevIJyV4yWmEV418VlYMC0BTtrW
	CrQlLqj7uuUNpEc5BBM02PCOqFFQeCSJZGKLjEJFJcfN5GmNXaryCQDHuVTSS99UL1biQ3qOvwm
	TJk7lWp5iQzkKPJA86FjzMbPAF0UY0SYKPdGG+w+6oZkbaYuRdH2nXoSRhMNdAxmlRc6dp1KyHK
	mdqgMhMKd0Kfqe7ypWvvA+12eK
X-Received: by 2002:a05:6214:29c6:b0:6b5:d6da:fbfe with SMTP id 6a1803df08f44-6b96113814emr107769226d6.1.1721645855419;
        Mon, 22 Jul 2024 03:57:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhDkPy4xzeYlv5Bs/9snKzkh4KxgDdbbuGxf6Qx5CsRFMYq1KSkcwMPzP3f6fLyfuZB0iKL1TVnvB2kCz59u4=
X-Received: by 2002:a05:6214:29c6:b0:6b5:d6da:fbfe with SMTP id
 6a1803df08f44-6b96113814emr107769026d6.1.1721645855127; Mon, 22 Jul 2024
 03:57:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMENy5pb8ea+piKLg5q5yRTMZacQqYWAoVLE1FE9WhQPq92E0g@mail.gmail.com>
 <5b64c89f-4127-4e8f-b795-3cec8e7350b4@kernel.org> <87wmmkn3mq.fsf@toke.dk>
 <ff571dcf-0375-6684-b188-5c1278cd50ce@iogearbox.net> <CA+h3auMq5vnoyRLvJainG-AFA6f=ivRmu6RjKU4cBv_go975tw@mail.gmail.com>
 <87ed8mftra.fsf@toke.dk> <6fb46358-e92c-4264-9863-c011fa970478@nvidia.com>
In-Reply-To: <6fb46358-e92c-4264-9863-c011fa970478@nvidia.com>
From: Samuel Dobron <sdobron@redhat.com>
Date: Mon, 22 Jul 2024 12:57:24 +0200
Message-ID: <CA+h3auO1tkMTbAVbS_PkKxNUQhvdUNb5cD+jL3Cz9Zouf6ACzw@mail.gmail.com>
Subject: Re: XDP Performance Regression in recent kernel versions
To: Tariq Toukan <tariqt@nvidia.com>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, hawk@kernel.org, 
	Sebastiano Miano <mianosebastiano@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	saeedm@nvidia.com, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey,

Sorry for waiting.
I've started a discussion within our team, how to handle this since we
don't have reporting process defined. So it may take some time, I'll
let you know.

Thanks,
Sam.

On Sun, Jun 30, 2024 at 12:26=E2=80=AFPM Tariq Toukan <tariqt@nvidia.com> w=
rote:
>
>
>
> On 24/06/2024 14:46, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > Samuel Dobron <sdobron@redhat.com> writes:
> >
> >>> It looks like this is known since March, was this ever reported to Nv=
idia back
> >>> then? :/
> >>
> >> Not sure if that's a question for me, I was told, filling an issue in
> >> Bugzilla/Jira is where
> >> our competences end. Who is supposed to report it to them?
> >
> > I don't think we have a formal reporting procedure, but I was planning
> > to send this to the list, referencing the Bugzilla entry. Seems I
> > dropped the ball on that; sorry! :(
> >
> > Can we set up a better reporting procedure for this going forward? A
> > mailing list, or just a name we can put in reports? Or something else?
> > Tariq, any preferences?
> >
> > -Toke
> >
>
> Hi,
> Please add Dragos and me on XDP mailing list reports.
>
> Regards,
> Tariq
>



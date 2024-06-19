Return-Path: <bpf+bounces-32533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A6C90F6DA
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 21:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3741285469
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 19:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060AC158D7D;
	Wed, 19 Jun 2024 19:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLp+kxuy"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D8B8475
	for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 19:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718824676; cv=none; b=pVenprZ3nIk/1GFFI/IUzCgjLPzQqPqu7z6X7nN8LqDcCLoMTztsqrzXPPj4oIIqEPXSeaeWD7+0kr3ndGzlwanGAx+UuNRHvpwWgz3THcN9W6E87MFLwNywKeOpbpNZq6i5Qu5c0hCOcwDuW2SsaW6hk75Iw/elu1UOCJm7yYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718824676; c=relaxed/simple;
	bh=Uj49eKs4/aH/vQGPqOYhUBo+DBjEjfaEUa8IPmvAz3M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dx6vLuOPW3qxpgEeSliXsJ8OS169Q3skz2fD+tQ887eXY6gpLMXofZa+wfd0H5MVCC9/ZBfVyqDh7xu+rAC7v7XZa6slbzmDxAdAEhRpjcg6FLb+Pf+XLFQgTrhwq3f4iF8g8E+g3PmTvdu+lEZhJCOI8nyoReQRP6PvMHULkwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VLp+kxuy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718824674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l9dreDaHw4LwDZpQses9LLZsOKK/RpMulbBO3lTSR94=;
	b=VLp+kxuyIYwK33dBdalAq0eBkFvQVGdlcdxrDwhGiijVwlP5BTLCQ6UQu1+CQOxmLMlCSU
	HJjvp3MFEFJecsF4jIk4BYBclpGl4UIERTtYDvhpxFvJ5DZ/IDmxFQpbqtBLnTBDxYt+5y
	TncyZKoLuWiob5iD5uMyvr7ftryzD5M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-tdwzKLCGNUyEsZoWhjmw5Q-1; Wed, 19 Jun 2024 15:17:52 -0400
X-MC-Unique: tdwzKLCGNUyEsZoWhjmw5Q-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3648793ae51so58676f8f.2
        for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 12:17:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718824671; x=1719429471;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l9dreDaHw4LwDZpQses9LLZsOKK/RpMulbBO3lTSR94=;
        b=Pz/Hagjj2KPDsDCtM85t9FxB7rssG2mxbnajtKgGdhEFBcaasgBtQLane46bmozp1L
         iqCD/y8zdHnjCP4SC9WNmJyIkBTLg5mxgOixMR0A3nMM47tXp0rl5+9vJf1Skxaz/TZl
         wVU4V+sFi1A7KpDcyqBUvFNAhIrmGABqsGllU7L88JxYIItkCLxlcTpSG7YPr2iFsKx4
         usvYv/yCMAm+vnDhJOkDEk/RSSVUjNtDKUDGmBxyFWk9lJDkCMweVkK8n0c1sqswZRhi
         /aF8nRQusSf3duClG6oJWRKWitLkX2/CrW4/KBH15z4M5YFq+DihEB14+QZReOg21qTJ
         aJgg==
X-Forwarded-Encrypted: i=1; AJvYcCUteMF5PJkXnXV8D/k+n4oGUDRLTDr8ksCA6hXvCkbIAjJc/3zhSYreOKpC1jetwsQoXM7gQwxh+NYbYugDFu2b/IP/
X-Gm-Message-State: AOJu0Yz+rp1IoX4iTbTWOvxfTEAWaJIgcgaVDY+FHa/oyOBjXHQM/Jo6
	LafLReQ3YOBNUNPsdzb/WlsObeEXqguLVX7MTrIQT4K2dK+NJBK0kn5pD0BWMI0Ucy17c7WruYL
	HGyZ7odzAwsb7kkSrBPXxnpI3d7IypAEQR6o8JgBaqB+0vm9sSA==
X-Received: by 2002:adf:cc8f:0:b0:35f:d57:a698 with SMTP id ffacd0b85a97d-36317c79b07mr2511326f8f.31.1718824671391;
        Wed, 19 Jun 2024 12:17:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFryhNHxXPqBrlUMjzD7Unl9K0r0EjIW5NugD/ywGyBorAkR0U593R+b5+gKho57fKeTx5fEw==
X-Received: by 2002:adf:cc8f:0:b0:35f:d57:a698 with SMTP id ffacd0b85a97d-36317c79b07mr2511310f8f.31.1718824670912;
        Wed, 19 Jun 2024 12:17:50 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42286eef9c1sm277768855e9.7.2024.06.19.12.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 12:17:50 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 6CA841386124; Wed, 19 Jun 2024 21:17:49 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, Sebastiano Miano
 <mianosebastiano@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: saeedm@nvidia.com, tariqt@nvidia.com, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Samuel Dobron <sdobron@redhat.com>
Subject: Re: XDP Performance Regression in recent kernel versions
In-Reply-To: <5b64c89f-4127-4e8f-b795-3cec8e7350b4@kernel.org>
References: <CAMENy5pb8ea+piKLg5q5yRTMZacQqYWAoVLE1FE9WhQPq92E0g@mail.gmail.com>
 <5b64c89f-4127-4e8f-b795-3cec8e7350b4@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 19 Jun 2024 21:17:49 +0200
Message-ID: <87wmmkn3mq.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> On 18/06/2024 17.28, Sebastiano Miano wrote:
>> Hi folks,
>> 
>> I have been conducting some basic experiments with XDP and have
>> observed a significant performance regression in recent kernel
>> versions compared to v5.15.
>> 
>> My setup is the following:
>> - Hardware: Two machines connected back-to-back with 100G Mellanox
>> ConnectX-6 Dx.
>> - DUT: 2x16 core Intel(R) Xeon(R) Silver 4314 CPU @ 2.40GHz.
>> - Software: xdp-bench program from [1] running on the DUT in both DROP
>> and TX modes.
>> - Traffic generator: Pktgen-DPDK sending traffic with a single 64B UDP
>> flow at ~130Mpps.
>> - Tests: Single core, HT disabled
>> 
>> Results:
>> 
>> Kernel version |-------| XDP_DROP |--------|   XDP_TX  |
>> 5.15                      30Mpps               16.1Mpps
>> 6.2                       21.3Mpps             14.1Mpps
>> 6.5                       19.9Mpps              8.6Mpps
>> bpf-next (6.10-rc2)       22.1Mpps              9.2Mpps
>> 
>
> Around when I left Red Hat there were a project with [LNST] that used
> xdp-bench for tracking and finding regressions like this.
>
> Perhaps Toke can enlighten us, if that project have caught similar 
> regressions?
>
> [LNST] https://github.com/LNST-project/lnst

Yes, actually, we have! Here's the bugzilla for it:
https://bugzilla.redhat.com/show_bug.cgi?id=2270408

I'm on PTO for the rest of this week, but adding Samuel who ran the
tests to Cc, he should be able to provide more information if needed.

-Toke



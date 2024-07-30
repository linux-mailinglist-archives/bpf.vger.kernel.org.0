Return-Path: <bpf+bounces-36058-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5778794102B
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 13:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CDC61F23C87
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 11:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98481198E88;
	Tue, 30 Jul 2024 11:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G5qYAadg"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B7518EFE0
	for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 11:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722337471; cv=none; b=WKCMO29YTjsxtvDs3bHA/DpwvHHXKvKmBjs1jks7WOokwtQyxU0eREef3crmzUVU5My0StKoWC7BlSjvzuYwFKH0N3wDjgqvJADpcHKWx4h/sV8JPZx7R2CLWTPfQpQWo8hJ38ks35PCMxUxB7hLVGX6n/6e9h4gCrFh8v0mFcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722337471; c=relaxed/simple;
	bh=Ek7LZA5Adjm3ym/z9e5JoSavsfcTgjsWk6/6JIJ7t3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=INuVIsBbjWjE1JzsfX0SmxmtZ6qmj7zNgBKIXE+iNYpL9P5/Nwz1yRCWnCxtnHcky543/wVHDmG6/ZGJbLy/ZTmOpsk0eAeSgRaLrFDJ2iX9fnWYhyK+qGfLczTQB/P1PBwEx1KmMCmveHa++tu6kAzSehYxQKLDF9ZduCgjxNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G5qYAadg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722337468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ezFPTQ1WGSxucSjVp5951QXGyi8WZfLh5S7gZkt1lk4=;
	b=G5qYAadgcSKemdHrlhy+p8s2ETGzxsySuEQlt80gNDuT3FSXPaS1ju+SofUyckBabtjTWA
	joPQ+O1j5UmunwYLemnOVgrT2iB01SzIg3cLNrpzGqHc5i0h+SuqWosTBJd3ms7YmYnF6u
	j15+GGUrtRbS0CLW7MQmNAvWC/kL86A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-bFsEm0aeOfy6TPoxrgB9ww-1; Tue, 30 Jul 2024 07:04:26 -0400
X-MC-Unique: bFsEm0aeOfy6TPoxrgB9ww-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42808efc688so25850515e9.0
        for <bpf@vger.kernel.org>; Tue, 30 Jul 2024 04:04:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722337465; x=1722942265;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ezFPTQ1WGSxucSjVp5951QXGyi8WZfLh5S7gZkt1lk4=;
        b=hHc3eFI/gub5D9/i7dxc+y4PSiuSemGPbTgpwXAeGG/ox7no/QeXASTpxOxkK4o10J
         TamniVDP0q2bhwWD+RU19kZIkhCMiVWDwrf/QJn1UIVSctEitUDwW7Xj8O6EhXXPOP2q
         SMZJYniS0PPl5vz8d5/LqGSC2LA/uJxKWakrp8rW4+7KsudTC9W3agyHTm7qiVS5zXR6
         y0rRpF490VdQWUR17gcV4m9nLda8NteihokWU9Mbif0AP+LCih2Rs4nNUaDpCyQe2L37
         2zukiMyAxcC8bRcxeHmclXAH2QtbWNlbotCHayESQ4EoG4/LeDnSjlejXRVxnZrOl1eT
         8gZw==
X-Forwarded-Encrypted: i=1; AJvYcCWId2JYebhIm1ExXQgYAWzEjUxT5cwJLqDfq008tykOE/rcMPmiBCcCSjcxkMd4YSvvOuuRDaf4mPezHIfHVoxR70l4
X-Gm-Message-State: AOJu0YzsdkxvlrX//VKWWv9y+2Q4D4nOkFNoyp1xWEWfp5C3H5GJfIjx
	VR9klUQP0t2jtZuqv4tzW0AtUsQW8sXjtmL3Al/u+29wajogd4ng9DTAigi/BkvyOEz5ZvYAmNq
	OcjyVVHTk1eCugUIMNw7i7czrG7Ib58LyQFYBl9LUxu5jHnE3FA==
X-Received: by 2002:a05:600c:3153:b0:426:5e91:391e with SMTP id 5b1f17b1804b1-42811dcd2e1mr67798245e9.26.1722337464876;
        Tue, 30 Jul 2024 04:04:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE39v1pXN85w2qGztmjiUvkkGOPsZjbJmzMayqH+ReAnENY9kABuKyGJDrx7hXWY7gOyf34nA==
X-Received: by 2002:a05:600c:3153:b0:426:5e91:391e with SMTP id 5b1f17b1804b1-42811dcd2e1mr67797975e9.26.1722337464436;
        Tue, 30 Jul 2024 04:04:24 -0700 (PDT)
Received: from [192.168.88.254] ([213.175.51.194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4280f8da2f7sm143824605e9.10.2024.07.30.04.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 04:04:24 -0700 (PDT)
Message-ID: <03c24731-e56f-44b2-b0a3-6afd7f14f77b@redhat.com>
Date: Tue, 30 Jul 2024 13:04:22 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: XDP Performance Regression in recent kernel versions
To: Carolina Jubran <cjubran@nvidia.com>, Dragos Tatulea
 <dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "hawk@kernel.org" <hawk@kernel.org>,
 "mianosebastiano@gmail.com" <mianosebastiano@gmail.com>
Cc: "toke@redhat.com" <toke@redhat.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "edumazet@google.com" <edumazet@google.com>,
 Saeed Mahameed <saeedm@nvidia.com>, "bpf@vger.kernel.org"
 <bpf@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>
References: <CAMENy5pb8ea+piKLg5q5yRTMZacQqYWAoVLE1FE9WhQPq92E0g@mail.gmail.com>
 <5b64c89f-4127-4e8f-b795-3cec8e7350b4@kernel.org> <87wmmkn3mq.fsf@toke.dk>
 <ff571dcf-0375-6684-b188-5c1278cd50ce@iogearbox.net>
 <CA+h3auMq5vnoyRLvJainG-AFA6f=ivRmu6RjKU4cBv_go975tw@mail.gmail.com>
 <c97e0085-be67-415c-ae06-7ef38992fab1@nvidia.com>
 <2f8dfd0a25279f18f8f86867233f6d3ba0921f47.camel@nvidia.com>
 <b1148fab-ecf3-46c1-9039-597cc80f3d28@nvidia.com>
Content-Language: en-US
From: Samuel Dobron <sdobron@redhat.com>
In-Reply-To: <b1148fab-ecf3-46c1-9039-597cc80f3d28@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> Could you try adding the mentioned parameters to your kernel arguments
> and check if you still see the degradation? 

Hey,
So i tried multiple kernels around v5.15 as well as couple of previous
v6.xx and there is no difference with spectre v2 mitigations enabled
or disabled.

No difference on other drivers as well.


Sam.



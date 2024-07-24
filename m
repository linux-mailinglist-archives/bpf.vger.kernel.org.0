Return-Path: <bpf+bounces-35519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D454F93B3D5
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 17:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D9991F231B4
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 15:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4369615B551;
	Wed, 24 Jul 2024 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f3ck20Bp"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE6F1591EA
	for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 15:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721835372; cv=none; b=BuyqOTbNqW/cUEI8XBNqMcuTZZuAp6j5CwUN0+RqOEvZo5iJedJqjyMZjVMcn1es2S7cslSvurnvn4Gn74OGeZqduQBeUEwGwngmdEFDvIuTR60aXdX6EUK6b4KLmeF8yTGcvJeoRKL3gkiwEoKojZSILIRdDWY/ktN/LNtyJ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721835372; c=relaxed/simple;
	bh=ivN4qGySLbBx2DVFn5Nto2bOIjDicbFpNGNBOxiJ1Mc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fUiC7YTraEAzOM/ULNytJPJQELxd42t7j47/mCHxpawfoGgdvPh1sx6tDKQCcYHNOzzQlmR8nBlhiIuaVX4zjhME9XDIBhaCh52tk3vu9un9Rw+nkjnwyepmjEyAHwnPrhFNc+bzC+UDrEx6f3+fPPOq8+N/UZ0ELsKGr84iH64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f3ck20Bp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721835370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lF/AMpR1Ygg4R2uQ6NTZRASvjo4IH2w7npdis+to+PM=;
	b=f3ck20BpVCBxpjt8BQGyzTrSpGKHQR+2rdScsNSVt9XSnLYDmsrCpb60dvkGjdZ/b9dOJj
	jO2v4BiIdaSjmcLYD8hCgJw6MsV3rIFS36m9fU+2P8plz5POfnNw0o5p7RMhS7rD5gGjNY
	PZqGln+XGTK+whUgeZeZ5tC2K3sLy10=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-zJLwxdXSMqKey_fAERJqKg-1; Wed, 24 Jul 2024 11:36:07 -0400
X-MC-Unique: zJLwxdXSMqKey_fAERJqKg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2f01b9ae749so28159441fa.1
        for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 08:36:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721835366; x=1722440166;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lF/AMpR1Ygg4R2uQ6NTZRASvjo4IH2w7npdis+to+PM=;
        b=llhXDX1YzYaT/wz4fABFdvjXz6WWbf8zvchi2XsnyFyVhr8SBNxY295HAYf4YGve02
         guA2UdMN8oV41c+YGzqsznYImuT9L5R6+EavA/Z5QwkQYsOaN65i5ii9H/UqjkaEpeJ3
         Rta8Vqzza6ngsMl+QqVm1lELKXtFRZ7AOjCV5Ym4KL6rmxOFSHpzSbg9kRK70uwqrx10
         uHffyrhLOTQWCqS+lOfGu0YbCXunULDNQ/NR6mOdcAkRSGRENSLxhLxmedGoXrq/SiCO
         23HWhXu43Galj/IMqBtup2XJkqaIikJuvd3wj5Z33Zf+obVSMjn0iMl/E2pD9QSOvXWU
         XHLg==
X-Forwarded-Encrypted: i=1; AJvYcCXjQSYT+mxSITTQB0zW1K0BqOxuZbJUfwVVDfV9juJ0N/X63sjMN5vMPhq7BsUlzlJMq8OPDssilCedlTyj2IPyc4q5
X-Gm-Message-State: AOJu0YzCnWJPFZk80plz101gz5bNovcSNtzlBauIRhSlqxFAx80V0FWY
	xrbGoM++DE6yMbC8O/okEcwu6dqxoas56NCA1ZTmYRcC9Di8QAFm7V/8dxODd8KZuMzGkR4i7b0
	P/4h4DV9TLw4Eff/++UZDTse4jdufk+d7d+niNhKEziDclVItUw==
X-Received: by 2002:a2e:8ec8:0:b0:2f0:1a19:f3f1 with SMTP id 38308e7fff4ca-2f039e65e11mr1301541fa.7.1721835366323;
        Wed, 24 Jul 2024 08:36:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHclc5/mCahL3fMaBMWlobCGzxaGb7zHz4MovMccKIMjha043pZlukBqFdmwrTbmOMuScaqYg==
X-Received: by 2002:a2e:8ec8:0:b0:2f0:1a19:f3f1 with SMTP id 38308e7fff4ca-2f039e65e11mr1301341fa.7.1721835365797;
        Wed, 24 Jul 2024 08:36:05 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f937353dsm34469695e9.17.2024.07.24.08.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 08:36:05 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C539314733E9; Wed, 24 Jul 2024 17:36:04 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Carolina Jubran <cjubran@nvidia.com>, Dragos Tatulea
 <dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>, "sdobron@redhat.com"
 <sdobron@redhat.com>, "hawk@kernel.org" <hawk@kernel.org>,
 "mianosebastiano@gmail.com" <mianosebastiano@gmail.com>
Cc: "pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
 Saeed Mahameed <saeedm@nvidia.com>, "bpf@vger.kernel.org"
 <bpf@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: XDP Performance Regression in recent kernel versions
In-Reply-To: <b1148fab-ecf3-46c1-9039-597cc80f3d28@nvidia.com>
References: <CAMENy5pb8ea+piKLg5q5yRTMZacQqYWAoVLE1FE9WhQPq92E0g@mail.gmail.com>
 <5b64c89f-4127-4e8f-b795-3cec8e7350b4@kernel.org> <87wmmkn3mq.fsf@toke.dk>
 <ff571dcf-0375-6684-b188-5c1278cd50ce@iogearbox.net>
 <CA+h3auMq5vnoyRLvJainG-AFA6f=ivRmu6RjKU4cBv_go975tw@mail.gmail.com>
 <c97e0085-be67-415c-ae06-7ef38992fab1@nvidia.com>
 <2f8dfd0a25279f18f8f86867233f6d3ba0921f47.camel@nvidia.com>
 <b1148fab-ecf3-46c1-9039-597cc80f3d28@nvidia.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 24 Jul 2024 17:36:04 +0200
Message-ID: <87v80uol97.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Carolina Jubran <cjubran@nvidia.com> writes:

> On 22/07/2024 12:26, Dragos Tatulea wrote:
>> On Sun, 2024-06-30 at 14:43 +0300, Tariq Toukan wrote:
>>>
>>> On 21/06/2024 15:35, Samuel Dobron wrote:
>>>> Hey all,
>>>>
>>>> Yeah, we do tests for ELN kernels [1] on a regular basis. Since
>>>> ~January of this year.
>>>>
>>>> As already mentioned, mlx5 is the only driver affected by this regression.
>>>> Unfortunately, I think Jesper is actually hitting 2 regressions we noticed,
>>>> the one already mentioned by Toke, another one [0] has been reported
>>>> in early February.
>>>> Btw. issue mentioned by Toke has been moved to Jira, see [5].
>>>>
>>>> Not sure all of you are able to see the content of [0], Jira says it's
>>>> RH-confidental.
>>>> So, I am not sure how much I can share without being fired :D. Anyway,
>>>> affected kernels have been released a while ago, so anyone can find it
>>>> on its own.
>>>> Basically, we detected 5% regression on XDP_DROP+mlx5 (currently, we
>>>> don't have data for any other XDP mode) in kernel-5.14 compared to
>>>> previous builds.
>>>>
>>>>   From tests history, I can see (most likely) the same improvement
>>>> on 6.10rc2 (from 15Mpps to 17-18Mpps), so I'd say 20% drop has been
>>>> (partially) fixed?
>>>>
>>>> For earlier 6.10. kernels we don't have data due to [3] (there is regression on
>>>> XDP_DROP as well, but I believe it's turbo-boost issue, as I mentioned
>>>> in issue).
>>>> So if you want to run tests on 6.10. please see [3].
>>>>
>>>> Summary XDP_DROP+mlx5@25G:
>>>> kernel       pps
>>>> <5.14        20.5M        baseline
>>>>> =5.14      19M           [0]
>>>> <6.4          19-20M      baseline for ELN kernels
>>>>> =6.4        15M           [4 and 5] (mentioned by Toke)
>>>
>>> + @Dragos
>>>
>>> That's about when we added several changes to the RX datapath.
>>> Most relevant are:
>>> - Fully removing the in-driver RX page-cache.
>>> - Refactoring to support XDP multi-buffer.
>>>
>>> We tested XDP performance before submission, I don't recall we noticed
>>> such a degradation.
>> 
>> Adding Carolina to post her analysis on this.
>
> Hey everyone,
>
> After investigating the issue, it seems the performance degradation is 
> linked to the commit "x86/bugs: Report Intel retbleed vulnerability"
> (6ad0ad2bf8a67).

Hmm, that commit is from June 2022, and according to Samuel's tests,
this issue was introduced sometime between commits b6dad5178cea and
40f71e7cd3c6 (both of which are dated in June 2023). Besides, if it was
a retbleed mitigation issue, that would affect other drivers as well,
no? Our testing only shows this regression on mlx5, not on the intel
drivers.


>>> I'll check with Dragos as he probably has these reports.
>>>
>> We only noticed a 6% degradation for XDP_XDROP.
>> 
>> https://lore.kernel.org/netdev/b6fcfa8b-c2b3-8a92-fb6e-0760d5f6f5ff@redhat.com/T/

That message mentions that "This will be handled in a different patch
series by adding support for multi-packet per page." - did that ever go
in?

-Toke



Return-Path: <bpf+bounces-12704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D82A7CFE2B
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 17:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCF9A2821F2
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 15:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD83315B9;
	Thu, 19 Oct 2023 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="uzXkV7cj"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4AA315A5
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 15:40:57 +0000 (UTC)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A96182
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 08:40:55 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-357ac7cd08aso575895ab.1
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 08:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697730054; x=1698334854; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DEnVh39G2MAZ987aIaVUYRG5XCyY7oegMKrJw/1orDU=;
        b=uzXkV7cjvaVodluXe6r7PjchUiTcjp99p1vLRgfX1Dzlo5UusIbkIv348yTshly5QD
         F3GK1P4mEXkgFKDe25nh6g3wJYaRcLnNGsu2p1g2JLy/f+PB1NFXYaCYUVGa9vAt7xrG
         06gr3GfLyhkqwldgdGmxfV/DY4xUt3nnpRvP2UBSodyhEssPq76F0yvC6E9XXO+0m4dS
         2q5Fuh/1uHLzM3N20Fg74MFXVdkSs0XOaHibdGiINLyKsKBJDB9COCqmDVMVV7KoHyPQ
         UE6uxCVCtmmKLvBxTAzJXcWrzpFW4NmaSamdwbGUXQaVqnEVNHpLgDy8pxFY+nM1+/h7
         NvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697730054; x=1698334854;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DEnVh39G2MAZ987aIaVUYRG5XCyY7oegMKrJw/1orDU=;
        b=Zc4xDVbOn9aN25Igtm1XqMRgUVqp07HZCI4cvAwgO5RNYyiZZFkKiiZIAcK2tDjh7w
         YkdzR0JdyQgUxFWK2utNRYksHroeWtOel3+fxxhDVmrFth4zBemnYvYDmaNbHEFRLaUZ
         ADPxvT/Q/ERhfFh7z7hbmQKFNj16S4MHXO08IBnnMxaLTMXZjZX/VCwq2kioDvu+ntlb
         eDmTDZRtoBb+AN2N2KUx6CQgTUAr5hXUd+UoQCJUAEslOSdFZeAjg3GXnpMYAw4Vx6g+
         NCmmRK64tiCNpwGAUpdikmnM2Nu4c8OFQCVoowUulQBdAkj0fvCqPxPupb2BRnp2bnRd
         0deQ==
X-Gm-Message-State: AOJu0YxaFTRmXlLQyP8BotvbjeG2606mW3wLGGIEElnLyiT2iofzgEfp
	+ck8H5d3s2BXS9fi7B9xUpZCfg==
X-Google-Smtp-Source: AGHT+IFjQ3qpZyxj51SibTF8YykdYd4Gbz5spT1Xb9tdSDNeWvrpy8xIcdHmWjN10zegDqEeGeibwg==
X-Received: by 2002:a92:d686:0:b0:351:54db:c1bb with SMTP id p6-20020a92d686000000b0035154dbc1bbmr2603572iln.0.1697730054404;
        Thu, 19 Oct 2023 08:40:54 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id i22-20020a056638381600b0045bc0378faasm2000238jav.29.2023.10.19.08.40.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 08:40:53 -0700 (PDT)
Message-ID: <11debbc9-de33-4466-a997-c8f49d27fd18@kernel.dk>
Date: Thu, 19 Oct 2023 09:40:52 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/11] io_uring: Initial support for {s,g}etsockopt
 commands
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, sdf@google.com, asml.silence@gmail.com,
 willemdebruijn.kernel@gmail.com, pabeni@redhat.com, martin.lau@linux.dev,
 krisman@suse.de, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, io-uring@vger.kernel.org
References: <20231016134750.1381153-1-leitao@debian.org>
 <7bb74d5a-ebde-42fe-abec-5274982ce930@kernel.dk>
 <20231019083305.6d309f82@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231019083305.6d309f82@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/19/23 9:33 AM, Jakub Kicinski wrote:
> On Thu, 19 Oct 2023 08:58:59 -0600 Jens Axboe wrote:
>> On 10/16/23 7:47 AM, Breno Leitao wrote:
>>> This patchset adds support for getsockopt (SOCKET_URING_OP_GETSOCKOPT)
>>> and setsockopt (SOCKET_URING_OP_SETSOCKOPT) in io_uring commands.
>>> SOCKET_URING_OP_SETSOCKOPT implements generic case, covering all levels
>>> and optnames. SOCKET_URING_OP_GETSOCKOPT is limited, for now, to
>>> SOL_SOCKET level, which seems to be the most common level parameter for
>>> get/setsockopt(2).
>>>
>>> In order to keep the implementation (and tests) simple, some refactors
>>> were done prior to the changes, as follows:  
>>
>> Looks like folks are mostly happy with this now, so the next question is
>> how to stage it?
> 
> Would be good to get acks from BPF folks but AFAICT first four patches

Agree, those are still missing. BPF folks, do patches 1-2 look OK to
you?

> apply cleanly for us now. If they apply cleanly for you I reckon you
> can take them directly with io-uring. It's -rc7 time, with a bit of
> luck we'll get to the merge window without a conflict.

I'll tentatively setup a branch for this just to see if we run into
anything on the merge front. Depending on how the BPF side goes, I can
rebase/collect reviews/whatever as we go.

-- 
Jens Axboe



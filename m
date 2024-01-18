Return-Path: <bpf+bounces-19825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 431BD831EC5
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 18:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAC91289972
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 17:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2CC2D603;
	Thu, 18 Jan 2024 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="Qkvhf+wW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7367D2C1A2
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 17:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705600275; cv=none; b=X6P27HiXje+stxud82nW2Jv/Q+mAYnY7h5/ve1JF0czeFY0jhB7MnYkvc9bccHqYWMymOueF3r4gA0M3VQw/YCm9oFS79YhCenNRNH5fsJWvsPueM43ErXRgwTtpLHFoMH/JiOt1xk/kWgF8Agl4gsDVTIjFDUn9w8RsKeTGVtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705600275; c=relaxed/simple;
	bh=r3NNFqpG6cBgIwvUsj8Cd3Jzsbgl2b/jlmzy/elakIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q8BQGnVFDuem/0I+1oG8mHwt3HRHOlmfTcBoxN9OQOhy7h8eyQojCa54YlDN3hTrq/abTYP8MXW0TbjjYTPlsHEj542v+B02VSS2sySqXu9g9EHcZFVJlMgS6u+tDu8Ixw5Kr0M50Pdk12XM1RQnDFB09oxJRTTIpypPYfudkyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=Qkvhf+wW; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e586a62f7so107835355e9.2
        for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 09:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1705600271; x=1706205071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=37SPrtdtvqBssfEn99VDBy4tBcQwoorx2p5fMZEy9vo=;
        b=Qkvhf+wWywg+RQOcXA1tdEpw4VF5tG2Glq9KlLed2I5TrFDtywW2UjbLjFPaW1NSeE
         dNPQqqIF45K2c/ZX3YDQgLMmsZWAABGYl278f7XAqtSrROt1VS3JaPRyyVsORl7ej3Tn
         mV2R0Zo5G4NUXU9gK0sWgdeAinUVGXcRFYN3D8myVD8af9/nJbtZjkvNCHIasFln+qp+
         aELsU2bcnvRj3JYZ6esTzfRLY0vGSM28Z45FgsFO3sp8sgwv63PSM3lApu40yqu/hyMD
         mki323B4jBiqZo102JPAUrXtjyBp5hud/XtdXi1y8qft8KSb7/Ueujb552uqsr153tia
         5UZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705600271; x=1706205071;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=37SPrtdtvqBssfEn99VDBy4tBcQwoorx2p5fMZEy9vo=;
        b=FUST8ZDf1XU5aT/N2fZfMB3X9eH/ShyefWvsbnGlb385cf9QnS+HhQA+9RXf5B5X+5
         C68Llf4DkB4GVR0yQM6k9eXaVEMldaepjogyHVVtxFQP16CrzkEfVJMJRzybOFR7ApWU
         sWBPrGu0PXD/Gmhot3AAyzYj15D8NH5USbOZMCq2pdABtEFt/tjvJXRf4kLwS8nEWxqq
         D0rPCg7msHA6CIPXdLGNIS3qKxYfALzow60HR9xJV/KoVRtGDrZcs0SQCNoHlJa16aEm
         zDKbrf82QSTphbpUMy1ZEP01ORh/P9zRMFFb6gwiLa1fT9363FlxLjJqx7clJ0BqUmAL
         +2SQ==
X-Gm-Message-State: AOJu0YzUpGDVLEtT6CjXt/f8L6PHYLLGQfEEiiTlw+xDuGaVupQraMnn
	Hb0ho0lWTDAq3uFoaSbfR8yrVZe9nwE/2Hu4FbF+TEo+a0gmYYugxs+w0ry6psI=
X-Google-Smtp-Source: AGHT+IGjxUd/0zYNSSWGBPKvFbxovsefgo1tFmUm6sfbxsvG/Vf+RIV9f4euTWzVeBVxBIEyf6KS6A==
X-Received: by 2002:a7b:c414:0:b0:40d:6f89:a839 with SMTP id k20-20020a7bc414000000b0040d6f89a839mr840591wmi.30.1705600271510;
        Thu, 18 Jan 2024 09:51:11 -0800 (PST)
Received: from ?IPV6:2a02:8011:e80c:0:3e3f:a818:b0d3:50b7? ([2a02:8011:e80c:0:3e3f:a818:b0d3:50b7])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c469000b0040e39cbf2a4sm30805293wmo.42.2024.01.18.09.51.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 09:51:11 -0800 (PST)
Message-ID: <56c6613d-8907-4582-9ce8-d08dcbb995af@isovalent.com>
Date: Thu, 18 Jan 2024 17:51:10 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 7/8] bpftool: Display cookie for perf event link
 probes
Content-Language: en-GB
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Yafang Shao <laoar.shao@gmail.com>
References: <20240118095416.989152-1-jolsa@kernel.org>
 <20240118095416.989152-8-jolsa@kernel.org>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20240118095416.989152-8-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-01-18 09:55 UTC+0000 ~ Jiri Olsa <jolsa@kernel.org>
> Displaying cookie for perf event link probes, in plain mode:
> 
>   # bpftool link
>   17: perf_event  prog 90
>           kprobe ffffffff82b1c2b0 bpf_fentry_test1  cookie 3735928559
>   18: perf_event  prog 90
>           kretprobe ffffffff82b1c2b0 bpf_fentry_test1  cookie 3735928559
>   20: perf_event  prog 92
>           tracepoint sched_switch  cookie 3735928559
>   21: perf_event  prog 93
>           event software:page-faults  cookie 3735928559
>   22: perf_event  prog 91
>           uprobe /proc/self/exe+0xd703c  cookie 3735928559
> 
> And in json mode:
> 
>   # bpftool link -j | jq
> 
>   {
>     "id": 30,
>     "type": "perf_event",
>     "prog_id": 160,
>     "retprobe": false,
>     "addr": 18446744071607272112,
>     "func": "bpf_fentry_test1",
>     "offset": 0,
>     "missed": 0,
>     "cookie": 3735928559
>   }
> 
>   {
>     "id": 33,
>     "type": "perf_event",
>     "prog_id": 162,
>     "tracepoint": "sched_switch",
>     "cookie": 3735928559
>   }
> 
>   {
>     "id": 34,
>     "type": "perf_event",
>     "prog_id": 163,
>     "event_type": "software",
>     "event_config": "page-faults",
>     "cookie": 3735928559
>   }
> 
>   {
>     "id": 35,
>     "type": "perf_event",
>     "prog_id": 161,
>     "retprobe": false,
>     "file": "/proc/self/exe",
>     "offset": 880700,
>     "cookie": 3735928559
>   }
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Thanks!


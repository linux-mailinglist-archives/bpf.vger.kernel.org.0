Return-Path: <bpf+bounces-50019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE3CA217A7
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 07:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB7BC3A66A3
	for <lists+bpf@lfdr.de>; Wed, 29 Jan 2025 06:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68F719046E;
	Wed, 29 Jan 2025 06:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Hur03NHw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC9F18BC3F
	for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 06:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738131833; cv=none; b=AZx2b1+08UHZSbNsdFN/QpWuCVgRCRv83uEttO0khWDWyPkW4WTrWFOrUmJkJgs0C0ox0QrwRJz/VkKKafN6kAxzNOkl5jG3byCnsIIIDmwZeRN6xgj+nhDd1sBJCYwy/0l+MyDr0IfiqHMAfmoU6bO5duZrbjW8wfOKWBDa27w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738131833; c=relaxed/simple;
	bh=xWXtQO6ejJhdYcZSUsJTQgOGXCosraRk8qU6ALHB34o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WQN8/Cs1aIgg1+RdqgHqmJ/CCzw2JZZETcvHz+uONfPoUykbmJLydJOKUkKtSGoLN3MQdurITEHwAAacrUYiWApxAhRblW/QK5YHOLivkYOVf69PuYfmaO1XHxC6/Mz2ADBc6usD18/qYsyiYUbfKsH2gQue59Fcwd262JAWqPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Hur03NHw; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ef718cb473so1332903a91.1
        for <bpf@vger.kernel.org>; Tue, 28 Jan 2025 22:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1738131831; x=1738736631; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FT4YiGiwqsZx4A3xA0Jgu4xaXbLgIs3mIavjGUtBuu0=;
        b=Hur03NHwK69+uWA+v0nte6pPLWcjVCh3shiHZWLD2ZJOIvj66dsYotL27slpEXndjV
         kq9Vzj4r0dOrwBF40osefF2chOjit9/uYIqD+DzHTacIeLjtHXmZoTVjF3p5LtNnPaD/
         szYf7XGB3mQS5vn0VDu3DvBCc+f3TL3ixXpmoUGGtZ+Z/mzbaaFkP4ApqDnZLdYYssTt
         GtTfzL1s+JWFZyu5PTC/5HCb853jJG85iSriU3imTrfLHRq3meoOOjR5YeIYeA1LYeaZ
         ngph9vCPstiWZmDb0TkVAcFB/PqJnyKOynu64ZPz53Whp65pvVITRsg+/ECevCcJUo5r
         kZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738131831; x=1738736631;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FT4YiGiwqsZx4A3xA0Jgu4xaXbLgIs3mIavjGUtBuu0=;
        b=anz4XFULDJF8HP/TBW1PWfpXheO3zvMWTKNa7mLICrQklbNIBAiweZFf+xR91aBSv7
         grjjnx/DxsXwqjgGGEyhnS4WhXRe51yGFMF/DMwU6lwsZFzWhQzC3F6kpvrgX9wXyHCE
         N3V6MaKpT/eYglH04dTuVqmvqC2roNUxI7njf5QUg3gkSvMztKP7LR4zNR/Nb9db70UW
         o4ZyCx7JkdwydfG93FYrzkaOloFQiBZv4/YV6vylqkcHlfPDQgeY6Zz01dal35Mc7sTe
         rjICuAsw65X52ZHV8Q+P2u5vuCyznnhbS6RlRLnAYxmFbU4UqZYJ3S4fPqsbODo4mj6Q
         C7PQ==
X-Forwarded-Encrypted: i=1; AJvYcCVv+eZwslQkLrwLey9GhVRl09yLan098b30ksPqw1INWdEfxh5OLd5CgnxvoPiXZFbx5/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/iCpr3CCtYfY3Me1HlU2Sy2n3g+kpY/eE+qd9AcA+ILQsGU5E
	ACmBkQqJXvN6tXNaTUJkI5tc56BJVpCEB6tm6ibV9Gc6mIWv5mj0c25SWESbuAY=
X-Gm-Gg: ASbGncvwcilgpL1q39RsO6Qsr+CMwGWzXMrpXKli43LMmk7tUmhHk75nnZp2efGbqSG
	MeqoXlKplKfmbAw0Z5t+3DaxJlMKeg47ooCNBqjidIDlptvWZ78SuMAsxLRYbv5zPqDt/WFIHFH
	Tks+ycXA3/7Wmu/WiN9xtjzFOohK7JXNDLvArx98tuERde06ixzIY5eee2xD+WqFY98BP7Ny1Tm
	0EHE/HSMJh+PlZAql5die4jCZifItMxYORmt3JAmWliSMVi5BtQrUf5a/IU6WrgyVb5cF5xkQ2e
	LoLXp9VMp4ClXKym9Qkh3hrSbj3nqJ7gGPYwCXX0Vj72vg==
X-Google-Smtp-Source: AGHT+IFe7jZpjHWRfk6aX/J3wkZrCl3t538SBumWic13rF495gP0kVnxBB1UR2S2ugcRkjKHsQQ+Pg==
X-Received: by 2002:a05:6a00:3e13:b0:729:1ca2:c166 with SMTP id d2e1a72fcca58-72fd0bdcf89mr1174670b3a.2.1738131830621;
        Tue, 28 Jan 2025 22:23:50 -0800 (PST)
Received: from [10.254.209.208] ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a6d2cb1sm10506232b3a.84.2025.01.28.22.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2025 22:23:50 -0800 (PST)
Message-ID: <ee5da323-0ad8-4b74-971a-ffbd3eb2b61b@bytedance.com>
Date: Wed, 29 Jan 2025 14:23:42 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH bpf v2] bpf: Fix deadlock when freeing cgroup storage
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, David Vernet <void@manifault.com>,
 "open list:BPF [STORAGE & CGROUPS]" <bpf@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20241221061018.37717-1-wuyun.abel@bytedance.com>
 <02c69185-1477-485c-af4f-a46f7aadadab@linux.dev>
 <7139ed64-55be-4b70-a03f-8b2414fc93d3@bytedance.com>
 <CAADnVQ+ws4c=G02HjR7Oww_cSuoVFfkWMjP0BbnUrrDgo6tywQ@mail.gmail.com>
 <3c153542-079a-4566-9f32-8335bbb0456a@linux.dev>
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <3c153542-079a-4566-9f32-8335bbb0456a@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/28/25 7:05 AM, Martin KaFai Lau Wrote:
> On 1/27/25 2:15 PM, Alexei Starovoitov wrote:
>> On Sun, Jan 26, 2025 at 1:31 AM Abel Wu <wuyun.abel@bytedance.com> wrote:
>>>
>>> On 1/25/25 4:20 AM, Martin KaFai Lau Wrote:
>>>>
>>>> imo, that should be a better option instead of having more unnecessary failures in all other normal use cases which will not be interested in tracing cgroup_storage_ptr().
>>
>> Martin,
>>
>> task_storage_map_free() is doing this busy inc/dec already,
>> in that sense doing the same in cgroup_storage_map_free() fits.
> 
> sgtm. Agree to be consistent with the task_storage_map_free.
> 
> would be nice if the busy inc/dec usage can be revisited after the rqspinlock work.

Agree, and 1ms interval of deadlock dection seems acceptable
for most workloads.

> 
> Acked-by: Martin KaFai Lau <martin.lau@kernel.org>

Thanks Alexei, Martin.



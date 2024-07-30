Return-Path: <bpf+bounces-35990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D01FE9405F3
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 05:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 927ED283EE2
	for <lists+bpf@lfdr.de>; Tue, 30 Jul 2024 03:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B351E1474B8;
	Tue, 30 Jul 2024 03:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qt3rnFkl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75E033D5;
	Tue, 30 Jul 2024 03:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722310360; cv=none; b=uQj8Gi6scrKKaWyJ3B3sI4waK7z0Qk5Z+g2MP22YJfY96X0+cfOysJV7i0zn6PqS/AUKe89i2GqDeTIQtrLupgDNPzQQ9PrUfGTdljJbX6thdjOhl6bBiVlVAOWVxZerYzOju0fjfFY9mOeRGEi+FahGw9uT/VUKeDDNIBVen0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722310360; c=relaxed/simple;
	bh=3EtyHF7FUAvEoWVikDFNVoDFuzxauu0QvBnDE2HwHNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N0p9jZz9mDoKfePqf6fxkSgKE9wp7+g9Hh9+Yvi0Mz9ltT2/e2KtZhn8a8FOREDPJnQ+4PQW+AWmn1uuXn0E9LcMC8fVm82Q6+mXDh3rGqVgUz/5fWwFp724ZPkB2T7TxaVkdGzsgXnqNBEZOIuCZ/izAqR+p1fZUAaBzZ9875I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qt3rnFkl; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70eaf5874ddso2866918b3a.3;
        Mon, 29 Jul 2024 20:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722310358; x=1722915158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e3P09As5MQSwY8y2bucCdnUnoi0GP4z4GO/FtXgWzGU=;
        b=Qt3rnFkl4YvNX5AqAY/ObKXHR6e8R1FleejHmDF95t0DjSJ5Vhkz+DAklotJ4+YFUE
         RnccAXU2sYtqyV2X8nP9VAQgUgcA+8J+epFvdaVkP7LaUBCb6muy9rLsqkuGynqEjDJF
         FKF8uqgDyrRPDVF8HEo7glT1Hemlih4KA2kQ2NfyGsS2NY0B8Xwal1wCVHgijIr7NjIh
         m4zzOj1DqYGb8/dnoeHCmQgdEfC9rseZ1EUh0tjYEI4VYI6ToI4D09+/rKmR2TdIpmn/
         MEblbzhFugyBHyTRhZwV8LHyZvBI5v6/6MAt9YT/EsXQePAv1i5SxQnBMeECuPi59Y3h
         uXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722310358; x=1722915158;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e3P09As5MQSwY8y2bucCdnUnoi0GP4z4GO/FtXgWzGU=;
        b=w9JSMELOcY2V0kccjFs3kdAO4h6r88RP1R3sTrbLVVA2UKLDll123imcfxz0iGcr8C
         v9cROZBFcgdZspAfFMXHsNVgK8RQrIS7FCAcS828FfGykf3aPQwH0NfdKsGtuK3avqEy
         agU3goE/oh5VHbatwQntCyJfDtujfuhOBxvojDzcw8dHeX4ZOxOqclGmjVII4dq/LGqE
         S3X0bdcufD19hZ9TFElEpGKp7v5j/d1z9mwg89j9pH1rWLJE+5zWrGIo7Dc+S8D6BSJB
         7TU0rNfo7qkI9zVP4otR38ybv+lhIJhGhlpJ+nQNPOP+Z5Z+yRXD4rLv5RGvj0Eh6GiW
         k9HA==
X-Forwarded-Encrypted: i=1; AJvYcCXf8YBY/AIBthqkrgqJkurXGoN1bBD1opaygfYc9QxkIwevGSlL57zipt94mRm87MWa9wjxz3RkHyVCzJrL8wXvaB72Ne9j8MC22uez7L41zwnyKMuf4Rb77N1qOpZFmjGr
X-Gm-Message-State: AOJu0YwsQZgsYh+O1KF/mu+JmGUPE7bJgV9PrYky2mnOwZVpb0adSFEJ
	KUfnxc9RsH4KnQxdsnZJwW8YSEQ6CCWUrixVm+kvdObyGmgjx+QF
X-Google-Smtp-Source: AGHT+IHWlP9VsVBr0qLI9YwKnpbn8RL90SITHieWTNuyWRUz4SUetvgZoEYUtnjkmJ9b7SjqVYbOAg==
X-Received: by 2002:a05:6a20:3943:b0:1c0:f2d9:a44a with SMTP id adf61e73a8af0-1c4a12aee22mr7945273637.22.1722310358072;
        Mon, 29 Jul 2024 20:32:38 -0700 (PDT)
Received: from [10.22.68.119] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7cde45csm90656365ad.77.2024.07.29.20.32.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jul 2024 20:32:37 -0700 (PDT)
Message-ID: <9f68005d-511f-4223-af8f-69fb885024a1@gmail.com>
Date: Tue, 30 Jul 2024 11:32:32 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpf: Add bpf_check_attach_target_with_klog
 method to output failure logs to kernel
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Zheao Li <me@manjusaka.me>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240725051511.57112-1-me@manjusaka.me>
 <08e180da-e841-427d-bed6-3ba8d73e8519@linux.dev>
 <c7952df9-5830-45d3-89bb-b45f2b030e24@gmail.com>
 <6511ce2a-1c7d-497c-aeb6-d4f0b17271ed@linux.dev>
 <2c6b1737-0a96-44ed-afe9-655444121984@gmail.com>
 <CAEf4BzbL0xfdCEYmzfQ4qCWQxKJAK=TwsdS3k=L58AoVyObL3Q@mail.gmail.com>
 <0f5b7717-fad3-4c89-bacf-7a11baf7a9df@gmail.com>
 <CAEf4BzZCz+sLuAUF65SaHqPUemsUb0WBhAhLYoaAs54VfH1V2w@mail.gmail.com>
 <a1ba10df-b521-40f7-941f-ab94b1bf9890@gmail.com>
 <CAEf4BzZhsQeDn8biUnt9WXt6RVcW_PPX76YFyZo6CjEXGKTdDg@mail.gmail.com>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <CAEf4BzZhsQeDn8biUnt9WXt6RVcW_PPX76YFyZo6CjEXGKTdDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 30/7/24 05:01, Andrii Nakryiko wrote:
> On Fri, Jul 26, 2024 at 9:04 PM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>
>>
>>
>> On 2024/7/27 08:12, Andrii Nakryiko wrote:
>>> On Thu, Jul 25, 2024 at 7:57 PM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>>>
>>>>
>>>>

[...]

>>>>
>>>> Is it OK to add a tracepoint here? I think tracepoint is more generic
>>>> than retsnoop-like way.
>>>
>>> I personally don't see a problem with adding tracepoint, but how would
>>> it look like, given we are talking about vararg printf-style function
>>> calls? I'm not sure how that should be represented in such a way as to
>>> make it compatible with tracepoints and not cause any runtime
>>> overhead.
>>
>> The tracepoint is not about vararg printf-style function calls.
>>
>> It is to trace the reason why it fails to bpf_check_attach_target() at
>> attach time.
>>
> 
> Oh, that changes things. I don't think we can keep adding extra
> tracepoints for various potential reasons that BPF prog might be
> failing to verify.
> 
> But there is usually no need either. This particular code already
> supports emitting extra information into verifier log, you just have
> to provide that. This is done by libbpf automatically, can't your
> library of choice do the same (if BPF program failed).
> 
> Why go to all this trouble if we already have a facility to debug
> issues like this. Note every issue is logged into verifier log, but in
> this case it is.
> 

Yeah, it is unnecessary to add tracepoint here, as we are able to trace
the log message in bpf_log() arguments with retsnoop.

Thanks,
Leon


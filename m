Return-Path: <bpf+bounces-30432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C39608CDA87
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 21:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F461282DD7
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 19:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF6D8287D;
	Thu, 23 May 2024 19:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T/lHMsJE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A279782D6D
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 19:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716491468; cv=none; b=ocHcHPrfLY07PS9uOTJYveX06m2ef/oK0Uq2l25iq5VQRHnv98r9NuTz9IJXdEtxhJOv399kiq3cva7RvcnlI3u1dINPI0fTABPovyLV9NRv105rB8Efb31fz3ztUt8Kgc5LaMvHIp2gj4hPl2tqXWhR7dlIASdctxUGKBPHVEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716491468; c=relaxed/simple;
	bh=eoCnpmqq6nw3Fy1R7DEd4SHwvcgaixOSexpmOblrHGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XsPwAmChLG4PpPKwnvmraztlpJBLaKMJVoLMd7rfJdoeEzuTRG4gMXZHAJPgaSXA5hCcSOZv8LiUMA9OvvCJIcRckpIZtTu+IHj0h6/HQL5b7d+L4RQdNrEkAqNexV+6npvwMb5ViIrzQDNMOrEHlbeYEzZb7mjSC7F9+HCuSzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T/lHMsJE; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3737b3c6411so85575ab.2
        for <bpf@vger.kernel.org>; Thu, 23 May 2024 12:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716491466; x=1717096266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fC9kDW+kPeeEhu/sk0DK4Ea1cI30Dc81o1at+TwfLXw=;
        b=T/lHMsJEP9X2cam/KtMjqzD0ImnLF5V7ijmSPX8/CDtTWs+NOkFSZY17ATFJIocVrN
         2z3izIUAZyLluT9lmSJKcnB1i0mGAU4I+LzBMZVagRaxGGR/4omkB7dUV0bfKC4bIkEq
         BDsINTVzZ0h2Gm9FAqz/7EiTFMcuiHORBStiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716491466; x=1717096266;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fC9kDW+kPeeEhu/sk0DK4Ea1cI30Dc81o1at+TwfLXw=;
        b=nXg4xKpct4UjHrV18X2TXfhGJHNNYaUT505sCv51RmXm7JvB7oh92Z7BlztFl0IfzV
         VFc+mfLo7CgO3EViBc9lD130bgltkqPqT39dQRwV7sZVUtcVzZlH5DZuTDGZFNnkCouX
         UFfLcdnaX/+g8vkg6oixf28pDpl8q40uAl2V3kA8FpAxXM4hPeii2XYHTDS772sTVuVl
         gbGOD4ZKtVJn6DysLsj3KK3rcs8jHNEhnzFeV3Z3lS0abPMzROr+ZCkSuCgqeBRIFbnt
         OMHlRgqKNUYbLWFVgMR/eovTcjn5OfuGSRye1kJIz4KJbuPzMhzIfhzYeMuQ1z9PzRxU
         DyJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDATIaqONxMKrImPd9wEtrwK+vKhNl2BIYgMhOCdh7LdKpgWbGvuk3qRyorc1M59sbZyk0op9RfFSyAnxNWX6y6TmF
X-Gm-Message-State: AOJu0YzbdI3OJo79Xx3r8VLDXqOZamxHen944axzARudOW4ryQpkAQ+h
	yB4BbZmu/GXdOhIYNxyl8K+PdPq6PD5x3habuR1Y/j33upryJv1Z+XhGXHdM1Rs=
X-Google-Smtp-Source: AGHT+IGUJadL8tuWvotBY37jyLWH4W/NEbNhdUB06VeC+bbGevmqUO6z3gpToFd7ayYeeicIf3AIYA==
X-Received: by 2002:a05:6e02:1fc1:b0:36c:3856:4386 with SMTP id e9e14a558f8ab-3737b3cad00mr2165555ab.3.1716491465698;
        Thu, 23 May 2024 12:11:05 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b03ece4797sm1493173.170.2024.05.23.12.11.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 12:11:05 -0700 (PDT)
Message-ID: <b208df48-b909-4f2d-8bc2-80531c044470@linuxfoundation.org>
Date: Thu, 23 May 2024 13:11:04 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/68] kselftest: Desecalate reporting of missing
 _GNU_SOURCE
To: Edward Liaw <edliaw@google.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Mark Brown <broonie@kernel.org>,
 shuah@kernel.org, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Christian Brauner <brauner@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Kees Cook
 <keescook@chromium.org>, Andy Lutomirski <luto@amacapital.net>,
 Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-team@android.com,
 linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
 linux-riscv@lists.infradead.org, bpf@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240522005913.3540131-1-edliaw@google.com>
 <20240522005913.3540131-3-edliaw@google.com>
 <94b73291-5b8a-480d-942d-cfc72971c2f5@sirena.org.uk>
 <CAG4es9WAASaSG+Xgp31-kLT3G8wpeT5vAqbCA4r=Z8G_zAF73w@mail.gmail.com>
 <9e2677ec-1d54-4969-907b-112b71ef8dd3@nvidia.com>
 <d5471e30-227d-4e6d-9bbd-90a74bd9006b@linuxfoundation.org>
 <CAG4es9XU2fMo7hBv81vpn1JGKFWt9gExOhyAyRtOc-5OR5eiLQ@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAG4es9XU2fMo7hBv81vpn1JGKFWt9gExOhyAyRtOc-5OR5eiLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/23/24 12:12, Edward Liaw wrote:
> On Thu, May 23, 2024 at 11:02 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 5/22/24 20:28, John Hubbard wrote:
>>> On 5/22/24 10:46 AM, Edward Liaw wrote:
>>>> On Wed, May 22, 2024 at 4:21 AM Mark Brown <broonie@kernel.org> wrote:
>>>>> On Wed, May 22, 2024 at 12:56:48AM +0000, Edward Liaw wrote:
>>> ...
>>>>> You've not provided a Signed-off-by for this so people can't do anything
>>>>> with it, please see Documentation/process/submitting-patches.rst for
>>>>> details on what this is and why it's important.
>>>>
>>>> Sorry, my mistake, I forgot to add it after cherry-picking.  If added
>>>
>>> Adding this to your .gitconfig would cover you for cases like this, I think
>>> it's pretty common to do this:
>>>
>>> [format]
>>>       signoff = true
>>>
>>>
> 
> Thanks Mark, I'll add that.
> 
>>
>> Mark, Edward,
>>
>> Is this patch still necessary of the series is dropped?
>>
>> thanks,
>> -- Shuah
>>
> 
> No, it is not necessary anymore.

Thank you Edward.

thanks,
-- Shuah


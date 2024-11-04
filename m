Return-Path: <bpf+bounces-43885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DE19BB517
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 13:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D17DC281955
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 12:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AE01B6D04;
	Mon,  4 Nov 2024 12:52:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B5B469D;
	Mon,  4 Nov 2024 12:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730724767; cv=none; b=SeKgqUxN3nLAdQjl037is4iGZbMIGDBRX1wkD4KmpBxCQO1Dm3VDzRVuXiCv4sKC3Bte/juPk4KQwdjqPlTpMr+mMPEvMYuTGiKSjnstexX37qacZNYKYuchaLpq+jvsTr45WAp/ubR5gyX1pspiVLyht6kQcDXWH++bT+dR7lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730724767; c=relaxed/simple;
	bh=qfF7Se/dd2tJLYRgUK05fufd9D+Xh/Ma4qzF4RpFNsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sICVirdxaKW2gxbTRhk4AXRVn31qj0149xUcrJUugVJyj6089uRI38tuuSx1SqToAeGPdnlZJbMBxo6mHRUctYZzsrzv1HC08X1l07rNR27PSzMa5GP5t8UOG5u24WEH5IlcFMq+qPjHyDDQFRIb6hV9/Vt0WZ8qZpxtdIePtd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=geekplace.eu; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=geekplace.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539eb97f26aso1892404e87.2;
        Mon, 04 Nov 2024 04:52:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730724760; x=1731329560;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g6wdq/nEs/3WVwSaO3vA/OwRN/JMzXZwUfX2FbRlt7w=;
        b=MIxAu9ADRDRwOcTMvTegT3qp8qT1LZQxlwtF1kzjy9JZyyy8hgUSgvXmvTLRxzrcQ1
         bGFyAKeebXHTmfACGVa1AldtKjqiBCz30rTDzeBrgpTRxZ8LqQkIIrCG3RgXrLKJR1UO
         ohe2SUlHHKWF3qqCMtYR23IdwWJkSYH+qwXLuCv3Hr8oeruhhYqadMAvGPCUHrKkfYMO
         icQqMsk30vMsyUuxmbNseUblBtas8998SVgx4XU2DI+0vvLT51AWf6eh1iLliZV9Cg7V
         SpVzZyn6UNc7S4bR+yi0joSXzfEA/bIsfTyH2ELcaUko/7480S80uNXVwZB+6xq4R8pw
         0lIw==
X-Forwarded-Encrypted: i=1; AJvYcCV03lSJSPqHT/BZxjbsAU/cLYrBEpLSCgTeWIDAa3CEEKKVP/0bxKv6auEcRZM6zeOhl5KuQF7GtbuTw88K@vger.kernel.org, AJvYcCVioPzQ5ra1M0H+L828GKuQJCgh3FQ7ujUyiDVV4G79HwVn9lumT2nuQcHfWi/S6lEnI36XLaf49SfqAcI+@vger.kernel.org, AJvYcCXLnKXsGtTK8/2TmA7TdStu8c4ZstvR/Sgnt/5unGJVtFEZLyVAmIufbL2khaf1zRbqWWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkHMSwgEbKTUqwiOXSaXT/JSsyr2s7gYp9zby6GzSHHS7VvfX3
	dPJgA5PivcIfhpj+ogZHGmgTDSeKfIJMNX4rDaZM+1r8ugxbGl3T
X-Google-Smtp-Source: AGHT+IFOI2mOAhadRlqXRkvN3uIDMiTt4juDzrYLjOkTHI62hBYYH/cDc17MBb84TYiLbCI5lbkflw==
X-Received: by 2002:a05:6512:128a:b0:539:f2f6:c70f with SMTP id 2adb3069b0e04-53b7ecd58cdmr8550171e87.8.1730724758556;
        Mon, 04 Nov 2024 04:52:38 -0800 (PST)
Received: from ?IPV6:2001:638:a06:1028:af7d:c868:ce43:5ee1? ([2001:638:a06:1028:af7d:c868:ce43:5ee1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5e7c51sm151606305e9.25.2024.11.04.04.52.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 04:52:37 -0800 (PST)
Message-ID: <935ac01a-8a1b-4986-9802-d2d1fd6445c2@geekplace.eu>
Date: Mon, 4 Nov 2024 13:52:35 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kbuild,bpf: pass make jobs' value to pahole
To: Masahiro Yamada <masahiroy@kernel.org>,
 =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier
 <nicolas@fjasle.eu>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241102100452.793970-1-flo@geekplace.eu>
 <73398de9-620c-9fb9-8414-d0f5c85ac53a@applied-asynchrony.com>
 <CAK7LNATd0UNu8KsxeD-q2mDUTxQD3ATL1wF59B9K2pxzU08OQQ@mail.gmail.com>
Content-Language: en-US, de-DE
From: Florian Schmaus <flo@geekplace.eu>
In-Reply-To: <CAK7LNATd0UNu8KsxeD-q2mDUTxQD3ATL1wF59B9K2pxzU08OQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03/11/2024 14.22, Masahiro Yamada wrote:
> On Sun, Nov 3, 2024 at 9:04 PM Holger Hoffstätte
> <holger@applied-asynchrony.com> wrote:
>>
>> On 2024-11-02 11:04, Florian Schmaus wrote:
>>> Pass the value of make's -j/--jobs argument to pahole, to avoid out of
>>> memory errors and make pahole respect the "jobs" value of make.
>>>
>>> On systems with little memory but many cores, invoking pahole using -j
>>> without argument potentially creates too many pahole instances,
>>> causing an out-of-memory situation. Instead, we should pass make's
>>> "jobs" value as an argument to pahole's -j, which is likely configured
>>> to be (much) lower than the actual core count on such systems.
>>>
>>> If make was invoked without -j, either via cmdline or MAKEFLAGS, then
>>> JOBS will be simply empty, resulting in the existing behavior, as
>>> expected.
>>>
>>> Signed-off-by: Florian Schmaus <flo@geekplace.eu>
>>
>> As discussed on IRC:
> 
> Do not do this. Others do not see what was discussed.

Sorry, you are right. However, not much was discussed. Holger just 
pointed out that the memory usage of pahole was already reported as 
problematic in

https://lore.kernel.org/lkml/20240820085950.200358-1-jirislaby@kernel.org/

My patch would potentially help there as well, as it allows the user to 
limit the number of threads used by pahole.


> I guess the right thing to do is to join the jobserver.
> 
> https://www.gnu.org/software/make/manual/html_node/POSIX-Jobserver.html

Yes, this would be the ideal solution. Until it is implemented, the 
proposed patch is probably the next best thing.

- Florian


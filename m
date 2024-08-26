Return-Path: <bpf+bounces-38062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A83E95EC82
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 10:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 840CB1C2139D
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 08:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4856013DBA2;
	Mon, 26 Aug 2024 08:57:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DA385654;
	Mon, 26 Aug 2024 08:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724662648; cv=none; b=epVltMwd3IIzG6Fr9tSX9SN2OH1ayp8EstWsutZC7lqhI2GKBI+W7uelP0Zd5nTdnthcMpuw5QfaBUsiTfuuyIpvslUhsc4Yi1y3Yv/cNBh9uVFC9kNICQsF0Gx4Or9fRYcYpvQM+j3ErCjN1CMg98875dZah+sHhJ4hhgffNUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724662648; c=relaxed/simple;
	bh=XrYriGW7hCki8MPpbhl1xIAPRo0ddG7tjw6UZhYRj+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QlOHI01wCRUcZnGBrbpjFUCkbhYVyUdXEyJZ/nE4cIlfJcKnl7aekr7KWKyoH2Mdpdq7DJvAhddyt2qflJXmtSmzRiN8QuVt/bYKsQuja6vmjdxpBwFgZ0msVwcohp49iftqbmN91qGv+1149huvVRfBpkP2NZqg3a8unIEaj2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8695cc91c8so417810066b.3;
        Mon, 26 Aug 2024 01:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724662645; x=1725267445;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RYU1ehFfhoi30WJo5WXRuz0xLoKa7ug2eniB3wKPtsU=;
        b=YZyYD7vhbAHpcn4gDvqb+nAT37AzB1F4W9h+OEcDIfeLkwft9Ny4kF9x4Pc6hU2WpD
         jFyGMmUwDNHHNdGHQKUbAdm9YMp3okZwcAahjSqA2Vuty3Ofrr9AEf/BrhBkCJ7eyyao
         r5ALbh43qEsIcTxNwOIxza86oSWV9JRZd4cYIJPUHvTl5zbOacBOhxQsb0+eXQe2nbLd
         FKPywGYRnDxb5JRYIHbVRrH89kPP5DcdRR3tv8Fg1RUEwxfK6GuqSC4IYyhTV+hlCPDk
         qaJ+NuIuO42o59ajmVZ9BpyKkNM/BCW8GBRhJu9ANKEe01ZEg3tHeS7E8/e2Dw4kjqZO
         ZGPA==
X-Forwarded-Encrypted: i=1; AJvYcCV2c6a46zBsIZ7nkNrzp580xw2gtgiGYdNfFdtxhjcMnkbuiNAQi5LlgxWQv29YmO7H9254ARVWBasus5Ld@vger.kernel.org, AJvYcCXQN8BxapBGi0fDZ2KtCGtYltPOLRkhHleGC4WqEq/VUPeJCizG0KHreLjgktQHmQpO5Yg=@vger.kernel.org, AJvYcCXsvHXqj8RKZrKa3cAHfmrTJMJb4DNUKQQ+be7IwU7h5CAFRbyZiNF4/ZCSIPwxaqT1d6RGp1bd/M6RwKJg@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4fRVdQYkgAZSwHRVPXg1yqSXIB4l+11tlKJtpvJw326krfb6f
	9xQk8q9hbjgOUJHwwBZrwcaKI+0urBzr2YzKU6TdAN8s+e+77oMk
X-Google-Smtp-Source: AGHT+IGQ3Cf75nDmLqIIjuMPRFmqyG01KHw7YSDLdE6l4qlEI/WbzxVYv/tDZuSYVcLs5VV51aCovQ==
X-Received: by 2002:a17:907:7291:b0:a7a:ab1a:2d71 with SMTP id a640c23a62f3a-a86a54bfee4mr725160366b.59.1724662644411;
        Mon, 26 Aug 2024 01:57:24 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f433671sm634279266b.128.2024.08.26.01.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 01:57:23 -0700 (PDT)
Message-ID: <f170d7c2-2056-4f47-8847-af15b9a78b81@kernel.org>
Date: Mon, 26 Aug 2024 10:57:22 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] kbuild: bpf: Do not run pahole with -j on 32bit userspace
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: dwarves@vger.kernel.org, Jiri Olsa <olsajiri@gmail.com>,
 masahiroy@kernel.org, linux-kernel@vger.kernel.org,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, msuchanek@suse.com
References: <20240820085950.200358-1-jirislaby@kernel.org>
 <ZsSpU5DqT3sRDzZy@krava> <523c1afa-ed9d-4c76-baea-1c43b1b0c682@kernel.org>
 <c2086083-4378-4503-b3e2-08fb14f8ff37@kernel.org>
 <7ebee21d-058f-4f83-8959-bd7aaa4e7719@kernel.org>
 <a45nq7wustxrztjxmkqzevv3mkki5oizfik7b24gqiyldhlkhv@4rpy4tzwi52l>
 <ZsdYGOS7Yg9pS2BJ@x1>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <ZsdYGOS7Yg9pS2BJ@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22. 08. 24, 17:24, Arnaldo Carvalho de Melo wrote:
> On Thu, Aug 22, 2024 at 11:55:05AM +0800, Shung-Hsi Yu wrote:
> I stumbled on this limitation as well when trying to build the kernel on
> a Libre Computer rk3399-pc board with only 4GiB of RAM, there I just
> created a swapfile and it managed to proceed, a bit slowly, but worked
> as well.

Here, it hits the VM space limit (3 G).

> Please let me know if what is in the 'next' branch of:
> 
> https://git.kernel.org/pub/scm/devel/pahole/pahole.git
> 
> Works for you, that will be extra motivation to move it to the master
> branch and cut 1.28.

on 64bit (-j1):
* master: 3.706 GB
(* master + my changes: 3.559 GB)
* next: 3.157 GB 


on 32bit:
  * master-j1: 2.445 GB
  * master-j16: 2.608 GB
  * master-j32: 2.811 GB
  * next-j1: 2.256 GB
  * next-j16: 2.401 GB
  * next-j32: 2.613 GB

It's definitely better. So I think it could work now, if the thread 
count was limited to 1 on 32bit. As building with -j10, -j20 randomly 
fails on random machines (32bit processes only of course). Unlike -j1.

thanks,
-- 
js
suse labs



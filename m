Return-Path: <bpf+bounces-38866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A7496B0EC
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 08:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 755171F26663
	for <lists+bpf@lfdr.de>; Wed,  4 Sep 2024 06:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E5484A5C;
	Wed,  4 Sep 2024 06:06:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880D01EC00B;
	Wed,  4 Sep 2024 06:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725429983; cv=none; b=MTOTeo0BTj6HKBcnohNaItgYLj0UFKG+6pWMgr/L/DdYp+CusXaTCAbbwRCk6pygsMBavmbZYd21h1+ZfDFg9chkixLre6Pw6PJJ3Ild/QpoJnykvzYKxL2n0KHVat2ntgdzg5etCtNtUd92O7XWXvNTx1UvqDJDyhXlkto2XZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725429983; c=relaxed/simple;
	bh=L/lcCtW/A/yUlex5biT1ZNk88EfM10KZV6QOgrGtrOQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qcZc8L4DpYrVDseMn5haeOyLONiFWfnv2KbLfg9qUn4Nb+iGtaBYHOmnPAO537Xgu3v8IVA+f0HclqzZkVi3MgROo85hOLd+ztEXDITOR3JaapBJ3rW/kKsWMAz9tk4TYeJ3/Am7Yd7P8HrfOnY3/Sf1ek1m5RsdScCp0quca1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a86910caf9cso65933066b.1;
        Tue, 03 Sep 2024 23:06:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725429980; x=1726034780;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k+Zf+lEJKQenBqDmUw/VWfd5pnnN5JZy2+M/UTKScSo=;
        b=uQydeXeJVGaXasN5RygXovuR/K0B89YV2ATvlif3mDsQx4od7HUBe48JmY8QZPHklO
         +Kiv7r3/rR4wisHCjomGUBsjc2XbAf/7egfd0rOr7XpWtXzEJaZcjf1Gyw84x7I56/uy
         cO6OR/C/MHGjm4gP35C6athmbZEW3Dqi9goGeJ8ELz+pLO3hPBUch+uFfuX9PQXyBa7o
         wUzsMSUllmVeYwlI7jRIUcD0tqyJyD1+rhzOLhN/XXLldFYIAmertaFH/G9B2bN3lGJE
         gBxjpGsCHOLuKkyQAfOtIb9tGcRh2z41IRtQEbm8ZEQNoQiedNDM0bS0zARg4AEQSCBM
         KMTA==
X-Forwarded-Encrypted: i=1; AJvYcCU0ysaU2QEUrYpcmTnZTgBUlnnS4sN9Fz47LSW5idK2XGzU/6rVVq+ILF1YiW8PTH2+qlMQSiX5m5uiBbnu@vger.kernel.org, AJvYcCUn1CbKpxKdFQ6A3T6SHaBv/UNovmrBb7QA6Z6BFN/mW4+nM5Exqsc5YMWP0uj3s1s33VY=@vger.kernel.org, AJvYcCVhZSJrXgkasRhnnZskgz05aV7ffVC4y0mKoNZq11eSJVVi+vUWWIjt9SW/1pDfqLDZGYXgQi9g1WsIDfw/@vger.kernel.org, AJvYcCW+1S+CHTXZhBKdZa+oFUXVc+pvq9ylcA/OE9ee0Gd+DhVDwCqitrju4LtLSRNCG2hFpluwfB3/vA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1DPjS7bT0UyUllA5tb0AI9lskYtQQOSlt+3kkmnaSwY4xfUV5
	9ikZC1Pf2yeTGuqnAzFJxh55EkhNpSneuZsknbywnv/9Gea6OQOe
X-Google-Smtp-Source: AGHT+IEuXkAJesg6Oei3TFB6Rx5nhF5iwnJExLhZTsQ4wnnzRg+6aG9b/jM79KbORb+x9Cl3j4dy8g==
X-Received: by 2002:a17:907:3e21:b0:a77:dbf9:118f with SMTP id a640c23a62f3a-a8a42fdb993mr91002066b.13.1725429979737;
        Tue, 03 Sep 2024 23:06:19 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989196980sm763866666b.126.2024.09.03.23.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 23:06:19 -0700 (PDT)
Message-ID: <ac2e0f89-0aca-4038-877c-72b6ab8e53b9@kernel.org>
Date: Wed, 4 Sep 2024 08:06:17 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] kbuild: bpf: Do not run pahole with -j on 32bit userspace
From: Jiri Slaby <jirislaby@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>, dwarves@vger.kernel.org,
 Jiri Olsa <olsajiri@gmail.com>, masahiroy@kernel.org,
 linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas@fjasle.eu>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org, msuchanek@suse.com
References: <20240820085950.200358-1-jirislaby@kernel.org>
 <ZsSpU5DqT3sRDzZy@krava> <523c1afa-ed9d-4c76-baea-1c43b1b0c682@kernel.org>
 <c2086083-4378-4503-b3e2-08fb14f8ff37@kernel.org>
 <7ebee21d-058f-4f83-8959-bd7aaa4e7719@kernel.org>
 <a45nq7wustxrztjxmkqzevv3mkki5oizfik7b24gqiyldhlkhv@4rpy4tzwi52l>
 <ZsdYGOS7Yg9pS2BJ@x1> <f170d7c2-2056-4f47-8847-af15b9a78b81@kernel.org>
 <Zsy1blxRL9VV9DRg@x1> <7016b011-cab3-4fbd-9fa7-19dd0123c989@kernel.org>
Content-Language: en-US
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <7016b011-cab3-4fbd-9fa7-19dd0123c989@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 27. 08. 24, 10:37, Jiri Slaby wrote:
> On 26. 08. 24, 19:03, Arnaldo Carvalho de Melo wrote:
>> On Mon, Aug 26, 2024 at 10:57:22AM +0200, Jiri Slaby wrote:
>>> On 22. 08. 24, 17:24, Arnaldo Carvalho de Melo wrote:
>>>> On Thu, Aug 22, 2024 at 11:55:05AM +0800, Shung-Hsi Yu wrote:
>>>> I stumbled on this limitation as well when trying to build the 
>>>> kernel on
>>>> a Libre Computer rk3399-pc board with only 4GiB of RAM, there I just
>>>> created a swapfile and it managed to proceed, a bit slowly, but worked
>>>> as well.
>>>
>>> Here, it hits the VM space limit (3 G).
>>
>> right, in my case it was on a 64-bit system, so just not enough memory,
>> not address space.
>>>> Please let me know if what is in the 'next' branch of:
>>
>>>> https://git.kernel.org/pub/scm/devel/pahole/pahole.git
>>
>>>> Works for you, that will be extra motivation to move it to the master
>>>> branch and cut 1.28.
>>
>>> on 64bit (-j1):
>>> * master: 3.706 GB
>>> (* master + my changes: 3.559 GB)
>>> * next: 3.157 GB
>>> on 32bit:
>>>   * master-j1: 2.445 GB
>>>   * master-j16: 2.608 GB
>>>   * master-j32: 2.811 GB
>>>   * next-j1: 2.256 GB
>>>   * next-j16: 2.401 GB
>>>   * next-j32: 2.613 GB
>>>
>>> It's definitely better. So I think it could work now, if the thread 
>>> count
>>> was limited to 1 on 32bit. As building with -j10, -j20 randomly fails on
>>> random machines (32bit processes only of course). Unlike -j1.
>>
>> Cool, I just merged a patch from Alan Maguire that should help with the
>> parallel case, would be able to test it? It is in the 'next' branch:
> 
> Not much helping.
> 
> On my box (as all previous runs):
> next-j1 2.242
> next-j16 2.808
> next-j32 2.646
> 
> On a build host:
> next-j1: 2.242
> next-j16: 2.824
> next-j20: 2.902 (crash)
> next-j32: 2.902 (crash)

So I disabled BTF on all 32bits (arm+i586) in openSUSE Tumbleweed for 
now. Better kernel without BTF, than no kernel at all 8-).

If you have ideas to force -j1 on 32bit, I can reenable/retest...

thanks,
-- 
js
suse labs



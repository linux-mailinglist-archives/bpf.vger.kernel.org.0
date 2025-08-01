Return-Path: <bpf+bounces-64919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D1AB18627
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 19:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C76A1AA7665
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 17:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AD61DDC33;
	Fri,  1 Aug 2025 17:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRvC7u+V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754011A08CA;
	Fri,  1 Aug 2025 17:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754067718; cv=none; b=cruZnOMAenFP4gb25xfK9X9ZoBDiAq6wPZuYkzjSGByapY6p8rPvBI6kB5oCoCFlOwHVzpUzYrnfMLaSsk2d6W6GvQq77c4VsRPlv8h7RA94K1D7AwZJGYVIPwmwXVWbWMfclsRfaWJs0qEFiaTgozSgKO6aUheG7Nr6YM/U8zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754067718; c=relaxed/simple;
	bh=ybd1hdOfmu+k/0q+40MqTXYLdm2JU2+MFZ4lExThpwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AU46N/eE4znj/PLSweZJXoeMaVpt6EFPEZrNsN12epR7lrn2n/NXHA6CRq6wWCtf+za2r8VBDaFM26ACmdenQDlAcS/Y1bCLX2LNDiqz6lihl6tVCaSexk6+2GiOI/8uIlJ9IqZK4+bPcfK4s4VR+i+ZBwNA1VkFIapIB7NKz28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRvC7u+V; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-24099fade34so20222785ad.0;
        Fri, 01 Aug 2025 10:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754067717; x=1754672517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=l+TqFd5JW2V26db8nnu3OQ0u9AFb+6dpg3RTAvtNefs=;
        b=LRvC7u+VhMkYu46jGvZGplXf14JuOkQXxe9O4rA6BBNPCRHOUC+dVxOXbSuUDs/eZ7
         2484B9sO6CGu9e/8JO5REiYZ0p5XNgWeqJwUS1gpUC/ZSXWy7965hdHFP8hDR/R8IzFw
         DeULkx2Hsoi3okIgS0cOB5NPipPCkWhYfUDSAHcd+Y31Kw7/q4wFNXBjOYCLsmcK4vbp
         Q6WH+fRQ8ksxFAB/aDorIf8erzF0Axq2+UV647MdXAIN5toAupZNueDuxLROckC/iLLD
         2SdYjAFKjtILgmIfp5/pGHH8BhU/DK5cvnylQhupqomeY6y1MA576us9Gp9tdAeoFZLF
         SBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754067717; x=1754672517;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+TqFd5JW2V26db8nnu3OQ0u9AFb+6dpg3RTAvtNefs=;
        b=MI3A5e2C3C9gCXZ46UpxN8U/y7/RqmYvz5hVGfYpOg1NF+NvGsBntGq/PQLtusex/g
         b+C6rZKWdkMIPKbyiF8c+jfYfTe4CQPvWXSoBMXv73ZU45OGHQLR1pH4ESfa6YbpGSuF
         aLWgzaXbAnMMbasE+w+C42nmKF86t3+c9hmMHzy8FsdBSX5yxwd5X7qYCalxcD6PvshT
         b3xONWVS64xaabhYSPbK2MEpn9S/SLubbp0h+LVvu2H25/ZnBpPiiOSzT+0/8+OqymCu
         vRUg0DYXIk9qHby0KvS4Y7b/1OgfxwNuH79JlYQJAnC7wgC2uCM/L2YG/FiBMZ7mEtVA
         2SpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWi+1r7HkmN4f8sys5a6Rk5vqbAF1IZDW+LE/Vpf+AWE+WzZ58eTn8GA6qYdffDhHEGg0hzzlMVlDrFQWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV2dGgDV6/uFkXcgDRJCXcB5LGCvmEmAhzy0vqNiMiRWTslDOM
	uY8cnDYbgTQMjU/15wGVmLBbcf36/NtZT+sjDiESf9I6LDHpKspTVP+v
X-Gm-Gg: ASbGnctTNgZhiSIB5HTYoUepxriVWljvC8EZsPujxOrQO7Fm6RqIpJVAvYa0JycbG6s
	IjhC1dummE6D3DBf8c8FvccZVBs69G+zVxCxU5XcCGE67vYCq2jPYtPKismuxPfJxjc17Wa2rlx
	4kw6th8VuoPdXxt7Wwt412ysmQVzpxk8McLqCvsK+tlYHkWPpTpFA/BCQlc/IF80VY/DNLuq79q
	7AMlok8SS5/sPHGLOt60Vt0ZiUunfwQyLqCbMGA67CEnKlHTlMCAjxbE2ihtc3HE9+bYRdf+wZI
	bYcQItSRMSOHYe9gHBphMa9E5Nqin5K5JludU1wPVZ7xbobgiZUMubnqVXdc9IPRQpzJIIdNozr
	XR5zyiLgOU6bGtqKXS1mlVTLuR93fG6yv3Vzs8TGN9v/bTWc25IBL7NvJDBocnXtwDWi1/epJ
X-Google-Smtp-Source: AGHT+IGvdBySEKSqrE/yWJemU88LKcIWwCXldcS9HDj8fsHBR8XqzZaDj6RTIa1dgHUAnJjgesrMmg==
X-Received: by 2002:a17:902:c40b:b0:240:125:1010 with SMTP id d9443c01a7336-24246f65114mr3283825ad.14.1754067716404;
        Fri, 01 Aug 2025 10:01:56 -0700 (PDT)
Received: from ?IPV6:2405:201:8000:a149:4670:c55c:fe13:754d? ([2405:201:8000:a149:4670:c55c:fe13:754d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f2193bsm48374525ad.70.2025.08.01.10.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 10:01:54 -0700 (PDT)
Message-ID: <ce37ee5b-a743-40b3-9c0b-347d14d6d133@gmail.com>
Date: Fri, 1 Aug 2025 22:31:51 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: bpf: fix minor typos in BTF comments
To: Yonghong Song <yonghong.song@linux.dev>,
 Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <c08c2cb8-4760-4b21-9beb-2e9c204a62dc@gmail.com>
 <cb1f9bd8-02a2-446c-a22e-f5274d9cd080@linux.dev>
Content-Language: en-US
From: Ankan Biswas <spyjetfayed@gmail.com>
Autocrypt: addr=spyjetfayed@gmail.com; keydata=
 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
 TRpGew2ozniUMliyaLH9UH6/e9Us
In-Reply-To: <cb1f9bd8-02a2-446c-a22e-f5274d9cd080@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/1/25 10:09 PM, Yonghong Song wrote:
>
>
> On 8/1/25 6:29 AM, Ankan Biswas wrote:
>> From 85f5a63a12a8544440c0af47214ba5f55c348c7c Mon Sep 17 00:00:00 2001
>> From: Ankan Biswas <spyjetfayed@gmail.com>
>> Date: Fri, 1 Aug 2025 18:25:21 +0530
>> Subject: [PATCH] docs: bpf: fix minor typos in BTF comments
>>
>> Fix a couple of small typos in the BTF documentation comments:
>> * "focus" → "focuses"
>> * "F.e." → "For example,"
>>
>> Signed-off-by: Ankan Biswas <spyjetfayed@gmail.com>
>
> LGTM. I am wondering whether these are the only typo's or not.
> How did you find these, just with visual checking when you
> read the doc?
>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>
Was looking at some other stuff and happened to come across. There may 
be more, I did not go through the all the comments, will try to fix them 
if I notice.


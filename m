Return-Path: <bpf+bounces-64549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 775D3B141CF
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 20:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9295A17F253
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 18:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEA3275867;
	Mon, 28 Jul 2025 18:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjIlmfnF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5C22727E1;
	Mon, 28 Jul 2025 18:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753726674; cv=none; b=H+AdF0FVjYe7iBsrfXhhyBL+Cz8yZlwnLPm2tJd2UGVFKgvQbGHuDynayh6h1CDOcipA6SyRwKmsqUsBQMsQPHStn+fSsbCW9P8ExuAAhFVbdV7lbeH0hN7V/7Fh/npRC+ON4KWBf5ccbKpdYwruaVJhjHiNrKQIQw9ils1FGaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753726674; c=relaxed/simple;
	bh=PKmMSBbak+KMI9JOS1+iN1bZXrRdIRjoqfoUDhXdluo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lzu7f2Ge/hsk55b/VfDsGLnsv5+5GLtkx/eWhgolgBEmmTCqQgJUheY5A78L+bWwGGEZvfIx5zq2vCDNO7jBfDRK8Tlmjk0t2rStiAwOFr7Pk5lXnc8MuoFLq5+CzUwI5PPX59CNH/WDWnNE2KJ45fNN6hZTA//GxXI8MB/gt7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjIlmfnF; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60c4521ae2cso8417418a12.0;
        Mon, 28 Jul 2025 11:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753726671; x=1754331471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2XImG3RY7RQ20GriC3ThDwzyOsZ+ZnkQcvN3PF0GjwU=;
        b=EjIlmfnFOubpzFqZtkXglKKvffqkiOF1aBd01loywoYtQ0dcPNOxwlhSxkTQKCr8FZ
         ADkIDmYurx54pmz5Yo23mk4AT9zNPOhijNTC3XWI5DMrhEzyrS+KkCRLqhi41pm7Vo+i
         9ftkynNA0lqhFE88zXqIA/Q4FvSwLj1s4IrpY1AAj+oYFLCXdTRuEdd4lpTkH65/ipDc
         yo2DCHrLNchm6YOr2oY+lIhjKA//tmZg5vhVeB4FgGKYhaogAQtXR6FkKcAiDmVYv6Pn
         UWoXEw7K/bEgNvdcv7dSKloXkZ7TfpFiy+RkdBHYl2GkeU914R+cfj6+sbTtDUecrtc6
         Qtmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753726671; x=1754331471;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2XImG3RY7RQ20GriC3ThDwzyOsZ+ZnkQcvN3PF0GjwU=;
        b=rhj8qeWp47k1iP8YpU7a/EO59odDDwFBj6MmoJLyTSILZSnOg6G4ayuMrPJ84/PjLh
         rTuRB14b2HMydoX2tkBn0Q2QgLFsUAaeA7laT3wK0gI2pcLPWT+bYgaSUB90os+GRbPG
         AX3OoW+hEEfHf5CQ1irJMMFWDN94SrzRMUJ/X7S7t/uDdQrI2gqpd2en30wonCOwuMBR
         vVj+lL5HD0zKcr9xkbxwSmQjDEikb1JT7zW/7Fz6anTtcl63PXNLKnFFJPsiBYIeNl3r
         1bfqr8y8Rx32dNSIMV84Ib3zgmFxcqs/ntMdXMCX+AHn0huPDR+Ji/4o7P/qRcrsHDD/
         gk2A==
X-Forwarded-Encrypted: i=1; AJvYcCV+RQ4jUGcciy/LuVfg+8IIRlfIWi46oXIQBpxgOZMlcEu+dhi9jAlbGNfcLOsnsBM1Ifg=@vger.kernel.org, AJvYcCWYZGduEQlAaJWI8Qs7p3spy0wW4TiyySFfInD9E3wVbGBU/GF2KUEv8GvQ6MaJ2dfhcQrYcF39D6mong==@vger.kernel.org, AJvYcCXLVUiTxYQRvJO8IMaH933+yGTrGJox8v4xvGMrZnyoSUgCWVnkiF/mkoyCPcwzozW9YlXK8gPDHA4H3pYv@vger.kernel.org, AJvYcCXqwftA5XwxoYx3o+iAhc9ONvgSkpQ1fnYG4u1WE1zf8GzMMicwUZnTZ4DsJmu4z6Y/AaHpyMgr@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7W/QKTuwR0y6XlJvEWblYJMYCg03cP1ACWjrVVCNnbr5OCyP1
	y1VFdiEDfXyhm2H4CnmD0q/iiz23eHm5Dt7pVCD5U6vNG/toyFAOcAC1
X-Gm-Gg: ASbGncuSJ3moHgRb6yBeTQ+64csV1J+DvZmrdwp4HY5921vPLcfiP9aQVz1jYmW7OjT
	uz/tYcu7dQ7domh2qyNg5yztJMN14pCnmWFWeDoB0RRJNF5BY4v4yPx9pHupov4HKmnJZ3pyh4s
	VLF/qmwVZJZU+wQPUOdN76T3dQHjvCgozs2CWfZWtS5ovhDlz8PvlXsuusgm4n+Rlyp2uMjiSMX
	0rJ+nUJdBpsHylUChd8ltIbXU2jTeWfvlzhkGgFYkqSwa8OKmMAHsPpJm8XOICyMxzngoGoPbmB
	ieMAoALrYHImY1/WxMDeeHSa3J/JxDpoYCfJUSSWzgS4dll+cm00Dy926fHweRcm+tM3nl6tCiM
	BXZOKm2k+MnawQtaHubBFFL3VO1FPvLs=
X-Google-Smtp-Source: AGHT+IHE61hHXgBHYY7mn+Rm9n8UNepBWRf5ECBwt+Kj2Dy/Or/52jRxs31VW64wRWx15L3XVNwb2g==
X-Received: by 2002:a05:6402:524a:b0:602:1d01:286a with SMTP id 4fb4d7f45d1cf-614f1bdd941mr12122182a12.6.1753726671077;
        Mon, 28 Jul 2025 11:17:51 -0700 (PDT)
Received: from [192.168.8.100] ([185.69.144.164])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615400cebf0sm1481690a12.61.2025.07.28.11.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 11:17:50 -0700 (PDT)
Message-ID: <72861320-2b54-47da-993d-a82050cf56c2@gmail.com>
Date: Mon, 28 Jul 2025 19:19:11 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 3/8] page_pool: access ->pp_magic through
 struct netmem_desc in page_pool_page_is_pp()
To: Byungchul Park <byungchul@sk.com>
Cc: Mina Almasry <almasrymina@google.com>,
 David Hildenbrand <david@redhat.com>,
 "willy@infradead.org" <willy@infradead.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com,
 kuba@kernel.org, ilias.apalodimas@linaro.org, harry.yoo@oracle.com,
 hawk@kernel.org, akpm@linux-foundation.org, davem@davemloft.net,
 john.fastabend@gmail.com, andrew+netdev@lunn.ch, toke@redhat.com,
 tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com,
 hannes@cmpxchg.org, ziy@nvidia.com, jackmanb@google.com
References: <20250710082807.27402-1-byungchul@sk.com>
 <20250710082807.27402-4-byungchul@sk.com>
 <CAHS8izMXkyGvYmf1u6r_kMY_QGSOoSCECkF0QJC4pdKx+DOq0A@mail.gmail.com>
 <20250711011435.GC40145@system.software.com>
 <582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com>
 <20250717030858.GA26168@system.software.com>
 <20250722012324.GA63367@system.software.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250722012324.GA63367@system.software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/25 02:23, Byungchul Park wrote:
> On Thu, Jul 17, 2025 at 12:08:58PM +0900, Byungchul Park wrote:
>> On Sat, Jul 12, 2025 at 02:58:14PM +0100, Pavel Begunkov wrote:
>>> On 7/11/25 02:14, Byungchul Park wrote:
...>>> commit 8fc2347fb3ff4a3fc7929c70a5a21e1128935d4a
>>> Author: Pavel Begunkov <asml.silence@gmail.com>
>>> Date:   Sat Jul 12 14:29:52 2025 +0100
>>>
>>>      net/mm: use PGTY for tracking page pool pages
>>>
>>>      Currently, we use page->pp_magic to determine whether a page belongs to
>>>      a page pool. It's not ideal as the field is aliased with other page
>>>      types, and thus needs to to rely on elaborated rules to work. Add a new
>>>      page type for page pool.
>>
>> Hi Pavel,
>>
>> I need this work to be done to remove ->pp_magic in struct page.  Will
>> you let me work on this work?  Or can you please refine and post this
> 
> No response I got.  Thus, I started.  I hope you understand.
Missed the first message and then got busy. Anyway, sure, go ahead.

-- 
Pavel Begunkov



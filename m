Return-Path: <bpf+bounces-61308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 514DDAE4C9B
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 20:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4956165D02
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 18:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1252D3A66;
	Mon, 23 Jun 2025 18:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGwCYoTn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2322A1B0F17;
	Mon, 23 Jun 2025 18:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750702403; cv=none; b=aZtuz8lB4zv4kwGJhaJF2ToGDOdSPd6eLPaM1JZQwDWW03aPuvZ3qFoNQ954Mytbdg5ycMiM0SZMVPng2QpiNZHenwIv1aDwlQYPIjhnoEC9XSdmolcgki3x016F1ETf75lsuefQYWaB32FcQd2/U7eWZyAqXq6hngHkRfVaIFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750702403; c=relaxed/simple;
	bh=Uo+ppWQvPzP6LrgYN+xNCLmBStXyIfg+Xorm2LbHFyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AX1YxmIgBIOeZHLVMY5+f2wLFVL5riRLyrhMp5LTQf3xT+0o0Esupd2PdLFSZCEWDjLcXe3StrF+XeQdx6p8o+69eTEsYhg2J0ySeKYfAYsXzB+qPVXbjM1ZIeXl6J5+G93F6sp1X6hAwC9WwNPFWM3HplioOwYdHemizEdZTgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGwCYoTn; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6077d0b9bbeso7560276a12.3;
        Mon, 23 Jun 2025 11:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750702400; x=1751307200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6LrdwSWHeZun5Ikk+tm0V9xNzZKjhyaxpn+cvba2gWU=;
        b=UGwCYoTn8iYJL2u6a0yX5dkvZklsRXMYNv67DAZIMBDOKmhZTZZ5ZK40n0rCka1Gv+
         wSczGn1vtt1J2VqV+GMzSjhRaK3099ljkFwG5GyML0BSP64x2rXjnnUbLsBea3r0+CKD
         iSIwQOodSVCwOtN0uyeOW+3bAkDl5LNm1+o+lgV95/cahPdWvC3twlpGKggmeb7LiIiF
         0g6qB6sENhNkCexnPRag6xpgOeL2hv9DCCTCPorsZy8k1ug4OTQByPbuujUcw5aZYbXE
         UB8rSAnws1i6SIpVVNitHesvuMR9OXyPGpeb327b68f2i8aoQz6KcIDatEKISOm2qXD9
         Jj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750702400; x=1751307200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6LrdwSWHeZun5Ikk+tm0V9xNzZKjhyaxpn+cvba2gWU=;
        b=o9D1LMwMMs/XYnoip3DlAHwo7tyqZW7r3QeVu1gEWxbH1Vz0muBifibUEyVBXH1LxL
         me9nP389fJBFy2xS5cnfwt3VJhVg5vuNUv/C5IbL7l4lkztxxM9D/30R2/NVyay59CsV
         62TGRzhNmHyKQu8mRtw/DPy3UA00dVV4WNPO57qoHdPrcsx/mNBKNR8an1HpOOwCgxxh
         1pXUw/BduCOKlkrEYBo7+FuJxtQgNzFKOgn6NOwVvYULW4PvVDFEdUWxYhWaamnTCvny
         trCPcgXpKdYWT9nAdM6kGFWyRo2eoXpR4RF9PYD9qbvA+ahDSjYxkuemeZ0d33TxPPjj
         IlRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUho1B56kzLlAOv4zaf8wV2LyyIwle4vSWUa7AJrfaUxnTPjTAPuQjunR7Jsrm3ihwMQ3E=@vger.kernel.org, AJvYcCV+4DqtetC/uprUDa8Sy1azpJsDlYlNXkA6XjffjkerPs2K1kFkkBHF3Y98tAG5sbLPkv8A8WYsprYJXqd4@vger.kernel.org, AJvYcCVS+uGkbDC6FMbSYLUWQ9RP8snUgRinOSB1UqmrcUqyzGa40p4tsKnDvz8TfKIe5g4Y3VGOro4gH0sSkg==@vger.kernel.org, AJvYcCWEKaaRLDKzAUATKjmIOQhKRjvei8DCuMH7xIXjXkEhQePTyAQGWVNGayeVhn+udDLNxuU/ZvRA@vger.kernel.org
X-Gm-Message-State: AOJu0YxK6+yewh9TP5PJCjkNv/ojxYFSzfdSqBk8aGaBBuHaY2WnBp0f
	c8kji24ZeH+epXFxFz+b4pOsaXKAt+9qSvraEmpB+xzx/nMk3yEGG975
X-Gm-Gg: ASbGncs+oDXXiil0/bLOOUCrOwITb30yD1A0m1DOM4adfL5z8Z10DwlXypL9HezrH1S
	bHOjS97Se8Wb4A1uVbTfqCKS6nocppq3AIuy//lnhOWhGaDX9elTi0c+kmXIyExWJcGb8SXxIvV
	OhXAdFJ/Y9IMMIy8Trt/Py3L0cs0kqUn0a6ORjyHuit3h5NCntE1mQDz5kLdfHQCjVFIC3hNzOi
	NB05cqg7E7tIaOy2zi61mu8TZCnKpYS9oRZ4++5NceEVIelBbUdcVjj8ATwjy2ULHVIs5n3lCMn
	0eFBZgjhUJe6xNJrEwn1AV6ApuuxTQy0LgFsSP04sPuwQLjpWme5zKKP7j8ERiaUojzfvz8=
X-Google-Smtp-Source: AGHT+IGVyIbY5OnBTaikvnY7RLZc7XLvD71jN/UmphK8N4zgi8FEO251lgkOrd45uxn6HMs7wFE0aQ==
X-Received: by 2002:a05:6402:1d54:b0:607:1ebe:53a7 with SMTP id 4fb4d7f45d1cf-60a1d18eb77mr11113961a12.23.1750702400003;
        Mon, 23 Jun 2025 11:13:20 -0700 (PDT)
Received: from [192.168.8.100] ([148.252.128.65])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60a1857e8f9sm6414258a12.32.2025.06.23.11.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 11:13:19 -0700 (PDT)
Message-ID: <69762ce3-ead1-4324-ba33-9839efbe31e7@gmail.com>
Date: Mon, 23 Jun 2025 19:14:41 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 9/9] page_pool: access ->pp_magic through
 struct netmem_desc in page_pool_page_is_pp()
To: Mina Almasry <almasrymina@google.com>
Cc: David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, ilias.apalodimas@linaro.org,
 harry.yoo@oracle.com, hawk@kernel.org, akpm@linux-foundation.org,
 davem@davemloft.net, john.fastabend@gmail.com, andrew+netdev@lunn.ch,
 toke@redhat.com, tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com,
 hannes@cmpxchg.org, jackmanb@google.com
References: <20250620041224.46646-1-byungchul@sk.com>
 <20250620041224.46646-10-byungchul@sk.com>
 <ce5b4b18-9934-41e3-af04-c34653b4b5fa@redhat.com>
 <20250623101622.GB3199@system.software.com>
 <460ACE40-9E99-42B8-90F0-2B18D2D8C72C@nvidia.com>
 <a8d40a05-db4c-400f-839b-3c6159a1feab@redhat.com>
 <41e68e52-5747-4b18-810d-4b20ada01c9a@gmail.com>
 <CAHS8izPRVBhz+55DJQw1yjBdWqAUo7y4T6StsyD_dkL3X1wcGQ@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izPRVBhz+55DJQw1yjBdWqAUo7y4T6StsyD_dkL3X1wcGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/23/25 18:28, Mina Almasry wrote:
> On Mon, Jun 23, 2025 at 10:05 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
...>> As you said, it's just a sanity check, all page pool pages should
>> be freed by the networking code. It checks the ownership with
>> netmem_is_pp(), which is basically the same as page_pool_page_is_pp()
>> but done though some aliasing.
>>
>> static inline bool netmem_is_pp(netmem_ref netmem)
>> {
>>          return (netmem_get_pp_magic(netmem) & PP_MAGIC_MASK) == PP_SIGNATURE;
>> }
>>
>> I assume there is no point in moving the check to skbuff.c as it
>> already does exactly same test, but we can probably just kill it.
>>
> 
> Even if we do kill it, maybe lets do that in a separate patch, and
> maybe a separate series. I would recommend not complicating this one?
FWIW, the discussion somewhat mentioned "long term", but I'm not
suggesting actually removing it, it serves the purpose. And in
long term the helper will be converted to use page->type / etc.
without touching pp fields, that should reduce the degree of
ugliness and make it more acceptable for keeping in mm.

> Also, AFAIU, this is about removing/moving the checks in
> bad_page_reason() and page_expected_state()? I think this check does
> fire sometimes. I saw at least 1 report in the last year of a
> bad_page_reason() check firing because the page_pool got its
> accounting wrong and released a page to the buddy allocator early, so
> maybe that new patch that removes that check should explain why this
> check is no longer necessary.

-- 
Pavel Begunkov



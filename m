Return-Path: <bpf+bounces-59133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D13AC632A
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 09:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3587E7A1F88
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 07:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EAF24503C;
	Wed, 28 May 2025 07:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVhkY5BR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BA344C94;
	Wed, 28 May 2025 07:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748417867; cv=none; b=gOzy0mSeQPt0GeXC62m8AhypmGTeVgx5VzIhNO5UDUTxumfHn+8LzjS/0LKCPKg07w/M/xYgjd7ZEpSXe9jDqLU1BJFMLoEj1gIvTFfnZWPnda433yJ1DsLuxH18eIBcLYgULyDe7umCLnIfjpg437/KbTFsx1N3oSvXLl61kI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748417867; c=relaxed/simple;
	bh=XFnolhBWMpZsbRKYipyO+ZmWPeaLCtIGk3PDlvRwUU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FHOmtYg2T0kyRHptj5hH5ImuNxQNml0c6W73AWepaSv3pV05jYCl0YopXNb3cr3gErex/e8vlqNCWOIkYaHtsINPSX+g3wWvNxQakiNpz1EdLOj6D0x1/959Yvu9NqAR6wNPfx/sSk0Hpc44bPQnlMlVDYib5iRLtYnM+Z0AZNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVhkY5BR; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ad8a6c202ffso11076166b.3;
        Wed, 28 May 2025 00:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748417864; x=1749022664; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t1dSHMFfDFy764C5jJ4C2GRVs5CFaHPqL3t86S7wFV4=;
        b=JVhkY5BRx7qQmJx+/VBeOvSc/EUIaTc+Q54GeY996o482my7xqBcaZFib4CCNL3Cig
         qwXEs2ZrgOBMvQHr+uv8HVfUp5tAJIzOJVWdkue5dUJ3kd5JFjEh7sHWHILBKcMTJJt4
         CkejnLyH7Sl0lHlRQI16mK/B+xLkWWAqxSsNtCCb9cleegdCPlGho31M9t0dvbd23KSP
         iJjIRXp+QHm1UjOeHl621qPkCtJoMg8zbutCf0/HBz4AfJS1T3PEyWPw+l8S6j8O7yB8
         m4FPRmCeoCyq1QBsx1SxYSoJ4Jq8mPPI4m5vfkeFLllmeDUoUnV+ffobXyGz2HQqUDTV
         Owwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748417864; x=1749022664;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t1dSHMFfDFy764C5jJ4C2GRVs5CFaHPqL3t86S7wFV4=;
        b=HfjDug7pFAmBCBm6FNBZyFSfAJ4U35/9PmQOsJT09xmbmyutLVpEez9ufTii6vvMAe
         vAjDHdoCAPGcAM1EAHHqy49qS6Zyza3QfvFKeYawCI3SgVqAQ11ruZND+USSZ9xlhul3
         +/RL7LklMx7rH+1bsOBWmgaE+WsrDfiDp7qas0NSORXUAYyAfSmn1aewjVTtsdqsyhl3
         LN1RH8qxAGjUFM2WTRAb2dsaiGc2ZtJgr0WqfupF6kfaKmhwXp1DvtljFWH5+L3PWQv1
         b6CfnocQJi9bOnMdOJFJAjg6Wnn6oMvbxiyyhMRpiGbq+x4I8taoJW09j5LFVTAceo+W
         FfTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaJoSWp4s7+XhsuBODPYbfOzwewQyGnHhIABrqLk6eZEVodoYi4krWiSh6GAbocCzA98JOX28Ass+AvhRq@vger.kernel.org, AJvYcCUcLn4Wc0wc6cVB80TxO3JJSeBIhYN6OrsyRpoyIkcBppc9ayl5UK0E9qN0Po/UGjP9+kj9A+7S@vger.kernel.org, AJvYcCVGrUZ7t0eJ1w7jkI9cxLy7wJptOh6A472Q3uiUEMtLOEzzqzX/o6ycZVIfGLjCLnsbYpw=@vger.kernel.org, AJvYcCWW6BtUAJbNSfsUVJQy9s8wUt6KrFc3gcBw1tgZa9rrJhXUiIZZbbjwoW4tXFGO/E2WS9oyGaVxBRD0aQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw305KHftbZq7/R32iiy0BYAoJUSonOxg6uUR1tmkpQ29djxXiE
	k2M47c00+9DB0e8mHDs/zK/sksivwVGqMzJ8PZjxXwfP0feI9rcFWSDW
X-Gm-Gg: ASbGncusQrFTKW7K4Z336fEb8oHPPK699QcyYUZHpRckOfSNif0GIWIKQaWMUpLW6Nd
	8CKZOKk1b6sidRwLapKCrijUVHpFmI7cTMIGtXaVJAP+7f6+Q9UyVo5I6R8WE2sx/02BzGU8r9A
	7xG3735Blo+a0tMk7Ec6R96/ewJpY7QzSNMfbME4z1N8SlX0Yw4FQS0PxlPvH5Izmq+J5SeV+On
	bfUratGZu9ZcLoNK2J+R7QhYOoOUiVtXHrRcHwgn3AIy6byH0LvfC1hEQdPX2E/XGAASvyx5TIZ
	lJ7dqHw/h3uLpaUe7JpdEjnvIXZs+9HFih1QSv5asqETg6GEg9NBlLWC3WQjQ8s5KALL6qGRIA=
	=
X-Google-Smtp-Source: AGHT+IGVvc9x00EqEBp/+uRhBV0Xy1432qgXuuK+2L3w2LGJ/kw7OOqZ6bGFRPbEXoSuuCXV4u1knw==
X-Received: by 2002:a17:906:99c2:b0:ad2:4144:2329 with SMTP id a640c23a62f3a-ad85b1205c3mr1472269966b.7.1748417864109;
        Wed, 28 May 2025 00:37:44 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::6f? ([2620:10d:c092:600::1:c447])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad8a1b28a5fsm61572066b.90.2025.05.28.00.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 00:37:43 -0700 (PDT)
Message-ID: <6cf44bd6-325f-407a-aadb-74eb567974ef@gmail.com>
Date: Wed, 28 May 2025 08:38:49 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/18] netmem: introduce struct netmem_desc
 struct_group_tagged()'ed on struct net_iov
To: Byungchul Park <byungchul@sk.com>, Mina Almasry <almasrymina@google.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com,
 kuba@kernel.org, ilias.apalodimas@linaro.org, harry.yoo@oracle.com,
 hawk@kernel.org, akpm@linux-foundation.org, davem@davemloft.net,
 john.fastabend@gmail.com, andrew+netdev@lunn.ch, toke@redhat.com,
 tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 horms@kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
 vishal.moola@gmail.com
References: <20250523032609.16334-1-byungchul@sk.com>
 <20250523032609.16334-2-byungchul@sk.com>
 <20250527025047.GA71538@system.software.com>
 <CAHS8izOJ6BEhiY6ApKuUkKw8+_R_pZ7kKwE9NqzCyC=g_2JGcA@mail.gmail.com>
 <20250528012152.GA2986@system.software.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250528012152.GA2986@system.software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/28/25 02:21, Byungchul Park wrote:
>>> So..  For now, this is the best option we can pick.  We can do all that
>>> you told me once struct netmem_desc has it own instance from slab.
>>>
>>> Again, it's because the page pool fields (or netmem things) from struct
>>> page will be gone by this series.
>>>
>>> Mina, thoughts?
>>>
>>
>> Can you please post an updated series with the approach you have in
>> mind? I think this series as-is seems broken vis-a-vie the
>> _pp_padding_map param move that looks incorrect. Pavel and I have also
>> commented on patch 18 that removing the ASSERTS seems incorrect as
>> it's breaking the symmetry between struct page and struct net_iov.
> 
> I told you I will fix it.  I will send the updated series shortly for
> *review*.  However, it will be for review since we know this work can be
> completed once the next works have been done:

Please don't forget to tag it with "RFC", otherwise nobody will
assume it's for for review only.

-- 
Pavel Begunkov



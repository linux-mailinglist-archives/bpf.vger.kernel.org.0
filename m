Return-Path: <bpf+bounces-63311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00921B05719
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 11:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FF1D3BC1E3
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 09:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77342D5C74;
	Tue, 15 Jul 2025 09:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNved4Uu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE46C23C50C;
	Tue, 15 Jul 2025 09:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752573120; cv=none; b=LOXexVnxlHXnPhKwH77AgibCeZcbpZltnO/US3SCbgXY62hlrtTDPByKHKD+mtsiz4DXNyhLno/e4oetN45BOlmkEslStK/gZW09pahB3fIhCq1+YcnpUzXnB0pNK/LnC/qZoQv4TfuhojEaFN/an+dzEVB4DfrjnpoIc9i1nHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752573120; c=relaxed/simple;
	bh=k3CNpSgw96RBK8czQPmVQadqD4U/8VJrNaiW2Cv3fEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GbQbN5NQmvIg7PVHmBCfsYuKYk2vInC6hRZ3erkDEDJ8U3S0ARWNnQuMNEz/bhrvZayYafEjL029P61JuqsNVKmLCtnrW38JnBTXq2nWvWzdlMXvbFig52Hrj8SJkvrvCTzc35FUkG3CPa6T29W9YGStigjVHjsss5JXYC3gF2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNved4Uu; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60707b740a6so8066138a12.0;
        Tue, 15 Jul 2025 02:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752573117; x=1753177917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+JfCVmz7dmcyIZuFeXL/VPi/f+vUofPTsyu4Vo/HNV8=;
        b=eNved4Uu3gpthM18zIQOnbgo+JH8BygfgQjFTzmafl7Y8nA4oRTgQksKLCnTnFKlII
         mmIBx2ndZxI4Ep1K9rxXSx7wOg3uLfEvzBeZpQZwbPCguGUg7U6fP7Ml0DPTREKplowe
         KnPZNTo0g8xp2slnNlLWN9vZqZpiM1PYWFi0ywbO6YexEm9tJB4k/jeWyb6nxQP5bsWl
         n+IRsS7fvyChdxWtK7Hfq9y3+hU3r8MUiZeqCWQK+Baq9+bSlpgUzHMJCkkVnT50xlBV
         MHSU+0dpMkqZeBoG88pWesjSweBM33FwXBVBjjy2dKwp5Nkrk7WoiyE157Lo55Mx6JHN
         8ecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752573117; x=1753177917;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+JfCVmz7dmcyIZuFeXL/VPi/f+vUofPTsyu4Vo/HNV8=;
        b=s+aSh21xvIxxbFEWZaOs/joj9goQdOFIxPutVi24gWFKyDEvlbN0bKMPLzDBqsOCkI
         2kmJbl/gOEk5qNh1OmGABXWQKOC0wYSUtvtz25FGc6CyqlMVrTvfOb9hOkt/vyi6YxBj
         om+92LAahAozX5236wRzny+jhGaviUQpRxwDl+McI06StHfg1/uNR6IpwbMUTch7XX9V
         UzoJbhOnjCHon0jvSfUxBW5cOFC2e5NrWRiOz8pXjf9U6IcNLxGVjIa0Ot6BPju4cDRr
         t9GL/gjTf3lWNvyEnVkWZrTelnTQ7tSbGkKIGaGqCJ5buhVVwFeGSJlKKjNicwhDaMPU
         lRNg==
X-Forwarded-Encrypted: i=1; AJvYcCVlh9e5Y5hZZH6XiJR5ahXNfgrRgKVpaKoVRvZSzn8MMWmRL9+mXJOnKOH69Trq2HeRzFc=@vger.kernel.org, AJvYcCWbUG+/TyQ2G7JNdk8LMFV7EYTTzntBa8yQf0BOtUem3RFfVvPzs+dPbQfkgsWBTx7nhdz0ILskr73Jyg==@vger.kernel.org, AJvYcCXctGl2Fs4eZAyfD/dqrSExkO9xh9OPVROUVUVVN3NczQh33UM6zZtyftvIrG1VvkGu/ieaOtawMp1O93vv@vger.kernel.org, AJvYcCXomE5DZjDdOCiqZLT5C/Q0OIaep/22Dk2I2seoP7369Ap6uLl27/zv8ER3JvIOXFqJwDGkxEM2@vger.kernel.org
X-Gm-Message-State: AOJu0YzabtnDN+tujhk7wJbI8/SFoaQsfhqBSwyCeBgZF90irsQuFXxP
	wZuDTtJEgmTCprm1P06klZQp3dD0drED11OFXAttJ1nDphM68tddxkB4+WjTqCad
X-Gm-Gg: ASbGncsmae6QB14m7LOw1dH4LwStfCEUszMMQ7rpaubkQ3nVmap1uWmyDKGvGPebefn
	N0fzIJ9x4aFz0MT1Son/tWHG/dg+vnJGYioArwm4m8Pd7nt2GHuldGy2DXGYg+ThN7WfDFtw2c7
	jGKTSHWP5tSeVtcyckxz62NgbYUb4exxdSgRDhqGe12kVOk7mHtKb0bf4o64XGknSf5ey97SAMe
	ayD/iXRHoZrRIN4GW3qMklnF4Z7BXYkZXQWuFw3GojbgFhxSYkWzFZ3AZTkvXOvhu0UZsRCtT3X
	DmsNJ6yr/S61/osIMcLiv6KG13YmjI2+rBxhPvHdfVJWC7/T0bOnW9/mnOnKYDZeiFGbIrhDupu
	FQ4To4VWyXMSCECTKNbgRbjVx/4CmBCLOe7B97PO4r9adMQ==
X-Google-Smtp-Source: AGHT+IFtyv+behObgwuhkDzO4fwWTfcA9W4Bzf00R+XfXl6ZnDUgjY9rXODXpIsVAPEVnRVB4STm/Q==
X-Received: by 2002:a50:cd87:0:b0:5f3:857f:2b38 with SMTP id 4fb4d7f45d1cf-611e84aa0e9mr10404889a12.17.1752573116791;
        Tue, 15 Jul 2025 02:51:56 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::1ac? ([2620:10d:c092:600::1:a4c1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c94f3753sm7018754a12.16.2025.07.15.02.51.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 02:51:55 -0700 (PDT)
Message-ID: <ecb71c6f-9a9e-439f-b64c-2779ee5afdd8@gmail.com>
Date: Tue, 15 Jul 2025 10:53:24 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 3/8] page_pool: access ->pp_magic through
 struct netmem_desc in page_pool_page_is_pp()
To: Mina Almasry <almasrymina@google.com>, Byungchul Park <byungchul@sk.com>
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
 vishal.moola@gmail.com, hannes@cmpxchg.org, ziy@nvidia.com,
 jackmanb@google.com
References: <20250710082807.27402-1-byungchul@sk.com>
 <20250710082807.27402-4-byungchul@sk.com>
 <CAHS8izMXkyGvYmf1u6r_kMY_QGSOoSCECkF0QJC4pdKx+DOq0A@mail.gmail.com>
 <20250711011435.GC40145@system.software.com>
 <CAHS8izNbE+sb8U2Ws2_0C9H6Tf2DzJjh2beu04uyzxk7xFw4ng@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izNbE+sb8U2Ws2_0C9H6Tf2DzJjh2beu04uyzxk7xFw4ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/14/25 20:09, Mina Almasry wrote:
> On Thu, Jul 10, 2025 at 6:14 PM Byungchul Park <byungchul@sk.com> wrote:
...>> Both the mainline code and this patch can make sense *only if* it's
>> actually a pp page.  It's unevitable until mm provides a way to identify
>> the type of page for page pool.  Thoughts?
> 
> I don't see mainline having a problem. Mainline checks that the page
> is a pp page via the magic before using any of the pp fields. This is
> because a page* can be a pp page or a non-pp page.
> 
> With netmem_desc, having a netmem_desc* should imply that the
> underlying memory is a pp page. Having a netmem_desc* that is not
> valid because the pp_magic is not correct complicates the code for no
> reason. Every user of netmem_desc has to check pp_magic before
> actually using the fields. page_to_nmdesc should just refuse to return
> a netmem_desc* if the page is not a pp page.
> 
> Also, this patch has my Reviewed-by, even though I honestly don't see
> it as acceptable and I clearly have feedback (and Pavel seems too?).

I was fine with it as a transitory solution, but there is nothing
to argue about anymore since mm already got a nice way to type
check pages and we can use that.
  > __please__, when you make significant changes to a patch, you have to
> reset the Reviewed-by tags.
> 

-- 
Pavel Begunkov



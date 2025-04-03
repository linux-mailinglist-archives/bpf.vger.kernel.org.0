Return-Path: <bpf+bounces-55219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E83BCA7A1CC
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 13:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ADB818980DA
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 11:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879E324C068;
	Thu,  3 Apr 2025 11:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CLXKiPXV"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E46624BC15
	for <bpf@vger.kernel.org>; Thu,  3 Apr 2025 11:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743679542; cv=none; b=mJf/2AI0+rMYFmyNV1edLkRdOup5UG4ZVXsNd+XvFFJV0nQNT8ac7Ff7iCncyUySS0yKRtPnPrJkYQwI8yralADTSpgzin1WNDaX1Ix9ihqOt92I5gJ2P0MjsmTiG4yKsyBJjdH61xWEszPiBL5N1FB0+vGpyeImil/naxtFkGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743679542; c=relaxed/simple;
	bh=uJzeXkywSQw59n4/+BNNQlcbbq6h3WRlXGrN3bCMe1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z4UlV0qw6hYfhIJYir2DOCCXyF4zfTPiA4PCRJ6pPdRBOBOU7GIIkNd7WmPD2i4nAuEW66K3tjCHjsbHyXhkLORmDIGxKpnrTKTL9mpP7oRa7edTVf7U4lyd4JaOrXqUPH9j74boMUmFngpl984QeLjD7pbDeLy5zjcK5UC32g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CLXKiPXV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743679539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hV+9b+/x+gelznBEtZ/wkU6VCh9E1FOzg+skZ59VIBg=;
	b=CLXKiPXV6+NvKiTPH/bGnGmJiaqgHU6rHHvgqpvJo/QIEhGowqgE1YY2sAVSuHAfwml/7O
	8lRDheiNqBKeF6esAij8wGi3rYaWcdhJh/VsuoseYcn4fkfFa5M9TVoYGKvecqCh0jbS7/
	rGhye27SF3mRiDm9sLuz42tEDMmRQJA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-wB7f-o0pPia69eM_7M-fLQ-1; Thu, 03 Apr 2025 07:25:38 -0400
X-MC-Unique: wB7f-o0pPia69eM_7M-fLQ-1
X-Mimecast-MFC-AGG-ID: wB7f-o0pPia69eM_7M-fLQ_1743679537
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39131851046so408542f8f.0
        for <bpf@vger.kernel.org>; Thu, 03 Apr 2025 04:25:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743679537; x=1744284337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hV+9b+/x+gelznBEtZ/wkU6VCh9E1FOzg+skZ59VIBg=;
        b=hPJcodKTsUYIXmglft8xnhu5A3m1bzAAGgiWEzwVMiG63RA7ompqF2m2xO4aDQaHRX
         DcBjY1qBd4sni+D/breeuAoG9Ll/swB0AVFoxAth0pAfLj+MZd8kPoX5JntCvOLuaQKe
         fuZossWZ48TopD8toulGdzMDq+OL50apVntLi36N1wRWR5Eep8yHSs7UcS4B54tqMFQR
         S2G5SEY72iHfR9uOIm51NQHrKD0mS5j1Bkh/bpcsUMjtG1nRFAWLMvDc06XzThI7+PiN
         vrqJzYUuZCnog3LiDab/svYniPySj2tCVKt742CUaPRlJsYyyryhGY7YzjAfJavr4QAm
         sBwA==
X-Gm-Message-State: AOJu0YyloWHRfVKMi4hmP8Ap3kY1a1zCj2lGrqTcgutoqzNehIZJCviy
	eETnwJbg7J7TditMv9v+hs+hD27NlGSKsSX0vl0NJJNHK717BXBFqZVa8+o8lNsRU8B7Z1d2xPR
	vYBZZnUH/RuS6kMkczGN033D6R88z38ySD4uz8SSXLwW9J7tdfw==
X-Gm-Gg: ASbGncv9b34zrYdVIUG0B82nDXnqK5jUmB34XDNgFb/ndMaaqz3Hq80jsa383enKTOl
	MrT140xnmy+jU6XMV40NQQBfyJRyvwZKen/AjFcfet+/xzfhaLTBp4WEQCNAykcvYm98O/vN71/
	MO5ZknszEAyZui1cxIaz15fvhUvgP2biALBaZV7+EJjGw56nSaCNXDuz1xztWOd57Dsy6YyYwb/
	iE/C3i8+GVdH84HccCqR9OXC5M2CdvKpcXukpcdQbuX9nbBpzYZCeltah5vqpkQCtbVKt5dFAD9
	hsWL/k7z63m/jFQmByDSj3iJY57FbvWcLNTBUDxD8AciFQ==
X-Received: by 2002:a5d:598d:0:b0:391:3b70:2dab with SMTP id ffacd0b85a97d-39c120dc668mr18372152f8f.17.1743679536900;
        Thu, 03 Apr 2025 04:25:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgUyiwXd0iBaKJMkSQX6B1609ESCGRfex5vbqPGGdlcsOk42Ie119Ej9VIa8cCmWscFQJXiA==
X-Received: by 2002:a5d:598d:0:b0:391:3b70:2dab with SMTP id ffacd0b85a97d-39c120dc668mr18372105f8f.17.1743679536479;
        Thu, 03 Apr 2025 04:25:36 -0700 (PDT)
Received: from [192.168.88.253] (146-241-68-231.dyn.eolo.it. [146.241.68.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec17b3572sm18994295e9.39.2025.04.03.04.25.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 04:25:35 -0700 (PDT)
Message-ID: <469fd8d0-c72e-4ca6-87a9-2f42b180276b@redhat.com>
Date: Thu, 3 Apr 2025 13:25:34 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 3/3] net: ti: icss-iep: Fix possible NULL pointer
 dereference for perout request
To: "Malladi, Meghana" <m-malladi@ti.com>, Roger Quadros <rogerq@kernel.org>,
 dan.carpenter@linaro.org, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 namcao@linutronix.de, javier.carrasco.cruz@gmail.com, diogo.ivo@siemens.com,
 horms@kernel.org, jacob.e.keller@intel.com, john.fastabend@gmail.com,
 hawk@kernel.org, daniel@iogearbox.net, ast@kernel.org, srk@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>, danishanwar@ti.com
References: <20250328102403.2626974-1-m-malladi@ti.com>
 <20250328102403.2626974-4-m-malladi@ti.com>
 <0fb67fc2-4915-49af-aa20-8bdc9bed4226@kernel.org>
 <b0a099a6-33b2-49f9-9af7-580c60b98f55@ti.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <b0a099a6-33b2-49f9-9af7-580c60b98f55@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/2/25 2:37 PM, Malladi, Meghana wrote:
> On 4/2/2025 5:58 PM, Roger Quadros wrote:
>> On 28/03/2025 12:24, Meghana Malladi wrote:
>>> ICSS IEP driver has flags to check if perout or pps has been enabled
>>> at any given point of time. Whenever there is request to enable or
>>> disable the signal, the driver first checks its enabled or disabled
>>> and acts accordingly.
>>>
>>> After bringing the interface down and up, calling PPS/perout enable
>>> doesn't work as the driver believes PPS is already enabled,
>>
>> How? aren't we calling icss_iep_pps_enable(iep, false)?
>> wouldn't this disable the IEP and clear the iep->pps_enabled flag?
>>
> 
> The whole purpose of calling icss_iep_pps_enable(iep, false) is to clear 
> iep->pps_enabled flag, because if this flag is not cleared it hinders 
> generating new pps signal (with the newly loaded firmware) once any of 
> the interfaces are up (check icss_iep_perout_enable()), so instead of 
> calling icss_iep_pps_enable(iep, false) I am just clearing the 
> iep->pps_enabled flag.

IDK what Roger thinks, but the above is not clear to me. I read it as
you are stating that icss_iep_pps_enable() indeed clears the flag, so i
don't see/follow the reasoning behind this change.

Skimmir over the code, icss_iep_pps_enable() could indeed avoid clearing
the flag under some circumstances is that the reason?

Possibly a more describing commit message would help.

>> And, what if you brought 2 interfaces of the same ICSS instances up
>> but put only 1 interface down and up?
>>
> 
> Then the flag need not be disabled if only one interface is brought down 
> because the IEP is still alive and all the IEP configuration (including 
> pps/perout) is still valid.

I read the above as stating this fix is not correct in such scenario,
leading to the wrong final state.

I think it would be better to either give a better reasoning about this
change in the commit message or refactor it to handle even such scenario,

Thanks,

Paolo



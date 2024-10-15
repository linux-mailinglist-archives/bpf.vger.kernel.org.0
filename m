Return-Path: <bpf+bounces-42008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E08B699E4B5
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 12:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E7391C24D71
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 10:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29301EBA1F;
	Tue, 15 Oct 2024 10:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="FN/6EoI3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85701EABA8
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 10:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728989735; cv=none; b=dNZ1aZvuqIguKJEtnOezgcqEHOg+tPZT+REGAQquFUw3sRxyN+F6yx8ho6BASpcaqsNyKjV9ALjITGEjADutDfpl1qsfsdsMLCuv9qEtDL15sXJ6QPM73Ezru2fOUG2Z19ezfDPmFCsfTzB7dzI3sD2M/DMRB/Q59OBKlzPVinE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728989735; c=relaxed/simple;
	bh=dJZxNsHufyVnVkGZ7KBRcyWcePNegdl1XvkyiSwKVwI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=g3lwYdko3IJAoz2/qYjHxTYMd1VGDqdpZP199kkZUBHRHj8g2gig82vO5wEq2czVsM++q3cDPGRhbh75VCWVh7sY6duGZDWMp/CBPvZtlptthikg+fEhgc1hL/ZEJhSIINkTq/iRWuW41BRT9JDEO5SMryjDzc6Ijpn73w0ipCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=FN/6EoI3; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a99cc265e0aso545596666b.3
        for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 03:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1728989732; x=1729594532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qxWaIsUg6giBeZB/qFZgxvxYS8Q3WXg/pwadc9vI6U4=;
        b=FN/6EoI3dCHV7bU1thwTZfY1F7axilseOO6PvuCCFqIViQo7ynHcdA50Q1Veb2YF3e
         2SfW1VxpqGhfEvmUOwxhKlGDZJ/VoHa/hYEHIRvf0hQahpE6EsPY7V6alhxZSByTeucZ
         zuKfbO16bFoc1oIDbkjKRrr+/gFvCGruvI3vWfvDdch9ixAMrY37lozB7gzMzEhpQntI
         NP/0/vgQij5f0nbe6QfbHDa3+kmCnuOg8alnfmuBRKxd0Nkfnh0TWfzUb2xvmPjW9W1+
         4bjUyQsGQzkCUHOrbs3N40LPyGy681QIpXlYG+epZgluLeja4Hbk6yEH5Q1UaZEfBi22
         aXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728989732; x=1729594532;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qxWaIsUg6giBeZB/qFZgxvxYS8Q3WXg/pwadc9vI6U4=;
        b=L9+cTKhk0+o6u46OPDaVVliCjQ+vSol6Ovy1yWWc7QkaeVjk+0TkcyTqrHxkL7Ft2j
         wvCT3qiTio2rck2xzbZIG+ejLOq5tAh7D9zLhcX+3sUjpTErnVdRKPlsQY/ADnkUByLh
         ahO1r+SqQEUXTmfSEerCJdIJAdTweSyDUMlMBDi/+Z/ulTJGIxj5smUKIKjWQrjTid56
         0/Tfr0KqsX+JqDvDHgqBaYF0kHT/EXIcMhygs1O8Hq6voyWNffZPPNrIXrCmL6P7c9lw
         Fl20+AtflOJntKZ65QgyKzQY3etc+hPX5V+cinpe5aublxq1I2XM3c4GLh8Rbux66ZMj
         60rg==
X-Forwarded-Encrypted: i=1; AJvYcCUf8mb+SYEcacqyGAi8gi7uu+B1QxcE3fPNstb96E0Fur5Mq0W0vY8VH50d/aFUua3Oxzw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+cPcU2Mhn5YG08zNqJTTSNKjKePICQ1pi0o89+iQrh/hRN8iK
	1CyY1c0QZn29wFzk0M/QVwQIk7iVS3oJCtjtTx6yCkRJnn81EJPxg1Fxi9PCRCc=
X-Google-Smtp-Source: AGHT+IENngL8kUtvdGqBvfWOeT0HU3Jz0wnco8VTc5j19kviovROQUzgBtOacG8vxlSE5QNA5vJkkA==
X-Received: by 2002:a17:906:f59b:b0:a99:f7df:b20a with SMTP id a640c23a62f3a-a99f7dfb8ecmr782739366b.62.1728989731976;
        Tue, 15 Oct 2024 03:55:31 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a298232f4sm56459066b.117.2024.10.15.03.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 03:55:31 -0700 (PDT)
Message-ID: <7d4c49da-e071-4b74-85d8-f0b5efaa0cf3@blackwall.org>
Date: Tue, 15 Oct 2024 13:55:30 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bpf: xdp: fallback to SKB mode if DRV flag is absent.
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Jesper Dangaard Brouer
 <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrii Nakryiko <andriin@fb.com>,
 Jussi Maki <joamaki@gmail.com>, Jay Vosburgh <jv@jvosburgh.net>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Liang Li <liali@redhat.com>
References: <20241015033632.12120-1-liuhangbin@gmail.com>
 <8ef07e79-4812-4e02-a5d1-03a05726dd07@iogearbox.net>
 <2cdcad89-2677-4526-8ab5-3624d0300b7f@blackwall.org>
 <Zw5GNHSjgut12LEV@fedora>
 <8088f2a7-3ab1-4a1e-996d-c15703da13cc@blackwall.org>
Content-Language: en-US
In-Reply-To: <8088f2a7-3ab1-4a1e-996d-c15703da13cc@blackwall.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/10/2024 13:46, Nikolay Aleksandrov wrote:
> On 15/10/2024 13:38, Hangbin Liu wrote:
>> On Tue, Oct 15, 2024 at 12:53:08PM +0300, Nikolay Aleksandrov wrote:
>>> On 15/10/2024 11:17, Daniel Borkmann wrote:
>>>> On 10/15/24 5:36 AM, Hangbin Liu wrote:
>>>>> After commit c8a36f1945b2 ("bpf: xdp: Fix XDP mode when no mode flags
>>>>> specified"), the mode is automatically set to XDP_MODE_DRV if the driver
>>>>> implements the .ndo_bpf function. However, for drivers like bonding, which
>>>>> only support native XDP for specific modes, this may result in an
>>>>> "unsupported" response.
>>>>>
>>>>> In such cases, let's fall back to SKB mode if the user did not explicitly
>>>>> request DRV mode.
>>>>>
>>>
>>> So behaviour changed once, now it's changing again.. 
>>
>> This should not be a behaviour change, it just follow the fallback rules.
>>
> 
> hm, what fallback rules? I see dev_xdp_attach() exits on many errors
> with proper codes and extack messages, am I missing something, where's the
> fallback?
> 

Oh did you mean dev_xdp_mode()'s ndo_bpf check to decide which mode to use ?

So you'd like to do that for the unsupported bond modes as well, then I'd go
with Daniel's suggestion in that case and keep it in the bonding until
something else needs it.




Return-Path: <bpf+bounces-21250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A90E84A6EB
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 22:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 405A8291991
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 21:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18AD5B5BD;
	Mon,  5 Feb 2024 19:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqFdhdF1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A3A5B5BB
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 19:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707161163; cv=none; b=L69nMgXx5LJ0Aix9i5DVgk1AEbZXPIzbpaYrkMqZbJBWp0inYG217UnyTvJVRoiDcotR4TUIdLhHjP0IcBF9ksIoxhx+GN+zGlBGi+Iic65pI2deSA5MX2jFal0MkCJaG7INGKDB6B31AKejQWfawyxu3XY6W+iB6qm7UKM4Ylo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707161163; c=relaxed/simple;
	bh=f2aRudQ/B8RzJQqWkCaA+d7OPXEXPCZLCgVAmkRdK7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I0UKAAAqy0jhdgTl0+nDvwc03+qyvL6iGO+Rhlqwl9FxpSIgmhDN+gbdm1xWIoIvb9ByHrgdwE1OIUoVI7PRJMqxBUiS8BFeR5Gql4QQPrGi1hhMn8t+82omF3lHUXIm4Ja4URYbSBe45Y0qYxukChru2eCUU/PNWjgUYpFe1u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqFdhdF1; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-60412f65124so44230977b3.3
        for <bpf@vger.kernel.org>; Mon, 05 Feb 2024 11:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707161161; x=1707765961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NIg1YK6wsUmUELLzBLV0hX7nWmpSR8fVYvUDf0KeMu4=;
        b=PqFdhdF1bFBy3ktu7LB1R0hL2M/GdQNWGpS/CVKNdQBBttUAkMyQsO7yqYdMejcujK
         L0lOZNxlqR3WNgomTwoHgmTjp80j11GMRNBFN61tpBv8qP259bkq0socN0Ogj7u0avQ2
         i4APgiPJ+oaiFL5wICsTa7lAxc8AOEUJrjwBN53QWBQBC1BOiXegzJxydhWOTuVe9p+Q
         zQ2a/CLiXS6oTtaKrKom8jicsp1krhE99lul5ESJH+4zb/L+ZjpUPcs31KgRbB9fBHnL
         gNnHDjjFOnqGLR02E2WgNtn9RlYanu1dtee2jjUcV0f1ytErJsCgKryUcaVSk/YJQETV
         ycwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707161161; x=1707765961;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NIg1YK6wsUmUELLzBLV0hX7nWmpSR8fVYvUDf0KeMu4=;
        b=Q1iUcaWSRwMfj377oerG89lM2pFH8SZGqKGiOeSgtTndp6cAGDrPrFt5mr2sOyudhw
         ArZ7QgqucRCM3SbgNQNgnOvkbKlwz+auR3Yb47E0/B18ZeoxvB9j0dRmm5lSH69IXMk5
         Saas15KctuchWn+XFZPVMhDBIRPJ8fCpNv70Ae9qC8P1buGpWqDlJ15ll+oan0GrHBbX
         NjNPPdVazBc3cJF+RYhBWLgixHorzBM+XXZPgH9u1MfljXU0YcOz+gz7F1CD8sQ+4tbb
         x7k3IdU95fHOUfcwSR7a1a3sb2vzxJMcRS5v8EnU3xkIN6OhUs3fYseI9oi0WrF9aTGs
         m6SQ==
X-Gm-Message-State: AOJu0YyVEz/YwE9Ntdz+7tuxQ4yvTva5tHixQB4MBgc9W0QWvM08Rt4Q
	K/7RwxcdHmBGVbAiOzq6bSvhBaelM3tdrbskkUTOlSr0AzlYb1s/
X-Google-Smtp-Source: AGHT+IFJrTbs7PrjtMyeQ1A1SniAgW4UAdI1ptFY8rfcmcWhV7L7gz4qy8iEh4hErDD9HqtvEapd+Q==
X-Received: by 2002:a81:6c41:0:b0:5ff:81fa:16e6 with SMTP id h62-20020a816c41000000b005ff81fa16e6mr605531ywc.38.1707161160902;
        Mon, 05 Feb 2024 11:26:00 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU/YCAvKqDfIvCaFG+ey/ZgXqH+IZ4ePiwW5oHQzO36KFAH27zTyNNQfWHHv/RClOPvnZjdeB4e3REi9jY96+ozmR7qlyAb452T9yQxbwyGIlq7Fr1CfH6EI7XO5Tzzceq0IrM5nDkAiu7TXgrll5/UJhS28cQb2nr6r9/dYqFQ
Received: from ?IPV6:2600:1700:6cf8:1240:8b69:db05:cad3:f30f? ([2600:1700:6cf8:1240:8b69:db05:cad3:f30f])
        by smtp.gmail.com with ESMTPSA id g140-20020a0ddd92000000b006029cdd22cbsm91680ywe.97.2024.02.05.11.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 11:26:00 -0800 (PST)
Message-ID: <3230d5b6-dca3-4b41-bf04-479127628713@gmail.com>
Date: Mon, 5 Feb 2024 11:25:59 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master 1465/2825]
 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:557:13: warning:
 variable 'r' set but not used
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, Martin KaFai Lau <martin.lau@kernel.org>,
 kernel test robot <lkp@intel.com>, bpf <bpf@vger.kernel.org>
References: <202401300557.z5vzn8FM-lkp@intel.com>
 <79df5a1a-3d7d-4a6a-8ebb-aaf4d9e89aaf@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <79df5a1a-3d7d-4a6a-8ebb-aaf4d9e89aaf@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/1/24 12:36, Martin KaFai Lau wrote:
>> vim +/r +557 tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
>>
>>     553
>>     554    static int bpf_dummy_reg(void *kdata)
>>     555    {
>>     556        struct bpf_testmod_ops *ops = kdata;
>>   > 557        int r;
> 
> Kui-Feng, Please take a look. May be change the ".test_2" return type to 
> "void" since it is not used.
> 
>>     558
>>     559        r = ops->test_2(4, 3);
>>     560
>>     561        return 0;
>>     562    }
>>     563
>>
> 

The fix has been landed.  FYI!
https://lore.kernel.org/all/20240204061204.1864529-1-thinker.li@gmail.com/


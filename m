Return-Path: <bpf+bounces-58979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30276AC4B8B
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 11:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0362170B82
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 09:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF863253933;
	Tue, 27 May 2025 09:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GcnF3O2+"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72453248F73
	for <bpf@vger.kernel.org>; Tue, 27 May 2025 09:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748338139; cv=none; b=CFXa6wRMGJRMChsucm/de37hFry1cU6EOCMgZRHsvvhPbxkRZTUcluKlOL9EUwmqIeSLZ5FAKuhk4kQhbYPaL4rbXGSI8OFLrk1QobPsB2uw80yQNRwB+23aeWmJQkK0WhdQqk91TQ56jFGqd7zYCvO8FgmCTgVPXuTf4aR60YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748338139; c=relaxed/simple;
	bh=jYEhg75W17+LrrRp5ozft0smLaCDvCUlIDdgZkc8Maw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JhvNwvfhRIXFAauGQNR0SfFuuwuVkaNewVTIPIABOd3uQzIOyw4cXtUie1LwyTx3w0iEgTrDafeC8pARynWKPHVcI3Ytb2j5iI36CdWEJj5s5hhVJYQea+isKurT2oZEfq0fG1Hp2L0T1Z82gCfP+yiCkoDup4bjyRGt0sEFUV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GcnF3O2+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748338136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d2VX9MfL1HCTriT+S3B9Z1XwLwg3XDZQ+O6lDXv3bE4=;
	b=GcnF3O2+DhFxEc9GW8lAH0adS9eRHDdbK9qujz628jaSAOdvosEvbho12Xw395xCiZK7QJ
	ZuNvrRLEIXoPnMFelBvsL+tT5Epk9WZA2rq5QV+0bRaQpSPM57k+CDAgKIDNfHrL9rZLNk
	bbO6XtMt6TTIrBsKgyVLTUpUr6ZXJ8c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-xj_8hmOfN_OjWGYtlkwU3g-1; Tue, 27 May 2025 05:28:54 -0400
X-MC-Unique: xj_8hmOfN_OjWGYtlkwU3g-1
X-Mimecast-MFC-AGG-ID: xj_8hmOfN_OjWGYtlkwU3g_1748338134
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43ceeaf1524so14282915e9.1
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 02:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748338133; x=1748942933;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d2VX9MfL1HCTriT+S3B9Z1XwLwg3XDZQ+O6lDXv3bE4=;
        b=w2Ea5rmdTeYd1m+Iyq54WnYvXarxxBXAulBx07POO3eGk0jLxLYvxg+/cYHq8RDFk0
         v0aESFLmFeQN9VyDKBMwl3khS+Yq9c49QhSONOFpovN4WqhFwovIt0qABJDAbfbko5BQ
         1EIyF5viXlP5EQ26ZKha0ZdeI9ktg0UpUf7MfFLz1Ds2Lh3ioqdPoRDPHlwMUmxpojyT
         cbymTA1CS20Q3d5U4Z7+IH854O4qduEeUWQ8CD2wbMMckGuGn42lS969NMNMT2c64U/A
         /BAQDoDLXccvnB+tB0IuQVXHTPBVOpa+tyu/CHhclbnP9hUPTffslNaevsuDxJgKtW82
         ZoDA==
X-Forwarded-Encrypted: i=1; AJvYcCWBHxme80UZ+ARdalE2IT5TRf+qXtgF6xyagJKAJdlZJ6lAgzIi+bb5au/16mbnoq3rtew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc8347HGsq6TWTbLNQTgtEpFCLd6mzFDR1j1NRCPltsINQlObQ
	IHcHm8Vbuec0JcY2TZslJDJJh0jPZPuAAI7v+NLx++OhB/5gl2q2dA/vA71ZXN9gyyCKPo2ggcs
	NUiu4USdh6ciL8c/9VEpkm5JRlamPoUog3Rk8c8yJJ/+9UmVyQ8XF1g==
X-Gm-Gg: ASbGncvY6NoF++kXygujCOndBhD8PCg2SUPR555bvZ8/Nj6bOdKx4rlOcvomA5RrMg3
	FmAyjR9Cvv1hu0h6rvqPLtBDlDSehwLAt7eRsff2OKNoM3m2YUX1MPipM+wbs+VR6YcWcH+ad0D
	tu9NtJYdwFC62hrM99ZHXtTHNS/pU6XtuULxU0/YSDcpHVGYuZ0QGn8S5r077KmNTcFlKpruRm1
	FeJgFdRRPRz20e8rF6bRt6FNJUbO6iOrYWSnpksOpbjTLF5IA91vSbEsD/HaVtn+jh4h3bcYtgV
	Mzv4JXzfHbHiqZAsrqI=
X-Received: by 2002:a05:600c:1d0a:b0:43d:186d:a4bf with SMTP id 5b1f17b1804b1-44c77bf3aa2mr98283915e9.0.1748338133535;
        Tue, 27 May 2025 02:28:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFW/XvOutq354S3u3kVQy6maNZpndfNYmmZuqtvnQwyMkFCqY+qleAw2OpAQBAisEp90oBu4Q==
X-Received: by 2002:a05:600c:1d0a:b0:43d:186d:a4bf with SMTP id 5b1f17b1804b1-44c77bf3aa2mr98283485e9.0.1748338133127;
        Tue, 27 May 2025 02:28:53 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2728:e810::f39? ([2a0d:3344:2728:e810::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4e4c4739csm290454f8f.0.2025.05.27.02.28.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 02:28:52 -0700 (PDT)
Message-ID: <ea6b8065-76e4-45c8-a51f-858abab4d639@redhat.com>
Date: Tue, 27 May 2025 11:28:50 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next,v5] net: mana: Add handler for hardware servicing
 events
To: Haiyang Zhang <haiyangz@microsoft.com>, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org
Cc: decui@microsoft.com, stephen@networkplumber.org, kys@microsoft.com,
 paulros@microsoft.com, olaf@aepfle.de, vkuznets@redhat.com,
 davem@davemloft.net, wei.liu@kernel.org, edumazet@google.com,
 kuba@kernel.org, leon@kernel.org, longli@microsoft.com,
 ssengar@linux.microsoft.com, linux-rdma@vger.kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, bpf@vger.kernel.org,
 ast@kernel.org, hawk@kernel.org, tglx@linutronix.de,
 shradhagupta@linux.microsoft.com, andrew+netdev@lunn.ch,
 kotaranov@microsoft.com, horms@kernel.org, linux-kernel@vger.kernel.org
References: <1747873343-3118-1-git-send-email-haiyangz@microsoft.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1747873343-3118-1-git-send-email-haiyangz@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/25 2:22 AM, Haiyang Zhang wrote:
> @@ -400,6 +448,33 @@ static void mana_gd_process_eqe(struct gdma_queue *eq)
>  		eq->eq.callback(eq->eq.context, eq, &event);
>  		break;
>  
> +	case GDMA_EQE_HWC_FPGA_RECONFIG:
> +		dev_info(gc->dev, "Recv MANA service type:%d\n", type);
> +
> +		if (gc->in_service) {
> +			dev_info(gc->dev, "Already in service\n");
> +			break;
> +		}
> +
> +		if (!try_module_get(THIS_MODULE)) {
> +			dev_info(gc->dev, "Module is unloading\n");
> +			break;
> +		}
> +
> +		mns_wk = kzalloc(sizeof(*mns_wk), GFP_ATOMIC);
> +		if (!mns_wk) {
> +			module_put(THIS_MODULE);
> +			break;
> +		}
> +
> +		dev_info(gc->dev, "Start MANA service type:%d\n", type);
> +		gc->in_service = true;
> +		mns_wk->pdev = to_pci_dev(gc->dev);
> +		pci_dev_get(mns_wk->pdev);

Acquiring both the device and the module reference is confusing and
likely unnecessary. pci_dev_get() should suffice.

/P



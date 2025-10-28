Return-Path: <bpf+bounces-72638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 506FCC171AE
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 22:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA8BA3B6719
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 21:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4FC30100D;
	Tue, 28 Oct 2025 21:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="PaO5IVF6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35611255F28
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 21:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761688753; cv=none; b=mz+iZrYCFPMFMETq3/bxpq5IeIER1DhRa0ATyZ+gCTKCyZ+0NnIebWVCCSJM34FVjTj2RsLLgnMp8BZQS9NQ6hkMb0i1iny/P7c71FIX71mTEcy9OxbBwCBOeeD5g8QJmyiPHsmXh+hDMz/T6PTgJ7on6inwa7/BWrQ4MmGFOUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761688753; c=relaxed/simple;
	bh=C6g0A0cOE4AkGdUOdxz1HhnC5GCH/e/DvvgbquG05wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y+7ELZShKHr3MaQnr397Hi4ciZRflvaHR3OR255btbwMcPGOOKpkKleNPdWCKq6keLfsKotSWHotB4fr/I+wCIDVGmu7Cy3yVSzrkRA/X41d1ZfiY30gdqDY+LOup6hvfmO1PEYwvs6108TdqRcRbqIYs6yiUalH3oVKLsvSm2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=PaO5IVF6; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4fb8d3a2dbso4393528a12.3
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 14:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1761688747; x=1762293547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tij0vdBARhZU7Q7nZ9g6692s1qvrdH+ldHofNw13hX0=;
        b=PaO5IVF6MdVaCkJfbjB51J6cBTJxeU2ymdevJnTSN75mFzRSpxPptftTXVlugJJdz7
         juax61q9+HlD17loWXC7hKNHGNVxOSVOuoAxnkTv12rmOscDLaPNLctcv1f3TxBEBKuB
         iw1zPtGvy16Lliy0Lm7lb6c4gVs0de6YS06lV2DvAkkKaejpoOsDjG+mfngje7a4x7Op
         x1OnyVKer8EfQVaLuaW95EJ4aQSwplCzjKzw4p9zJIQ4GD0gmDyf4CeVC+Bccic1t/xI
         XgZAZ3G/Uo4eyal1kc4kZrOi41snUNH/iGkIbJIj6ZwryAA861YbUGtzdxT/xBLV85va
         7oig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761688747; x=1762293547;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tij0vdBARhZU7Q7nZ9g6692s1qvrdH+ldHofNw13hX0=;
        b=MTJfjp1phVcryTBqfMKphO+Uj7P9WEmRROOfNCXWTeCc1hl81O4x/ME7eul3aQytBc
         kLYNJRKuMACpW5v5pkd2tsz26Ls/L9cPbG7cttA2zZpPdcbkUMuRDZONv9eCCBYSscP4
         a7KMb7cdwQJsY2eKldx24Ym/Ir2EBPXgh/s8HMMQJJiqxHuTByh+43bbT+Nag4wlmFu0
         SaoWdw/IS9pRapCbdxRX2J1/1IKkEfaTdWMfXRq1fxpkrwt1xzRgPPvXYDmr4RqpP49Z
         /SAgZ76QFdiVSjJWy03+CHVGakgBEi1CaaKwnLSFQUy4kzdEbsT+a5j6Fz5IwO6yS1he
         viZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMhnVCEB7I3+A1jg5L6sM/0nimK64iH3WcNM0WczEUe+aPuTCgJc9MMnFHNEmPUTCr05A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVhGms8BMcJorT/JO8xtc4N5KyRX2N4Xp9ZsgffFXX9+acg9A0
	qpWP2GXL51m1xmp17dTORZ3Ku/1svDoOjDdfl3QABPF5QMmHHMCicUmYas8qLd6pApw=
X-Gm-Gg: ASbGnctwEEbRSomZOnS7RTlebnaQpmnsTnmEnhUNTQhbb0WpnIjSycMFoAkcEePhJUN
	SEADk8+qO8YEMkn8/lCwobepd1g6xC1eIOD5Ha3Sp7USZMtPNuX7RsxoO3jD7TFU8IHyRcx/gow
	z9BTrJZb93ajjCfgTV8N7ZLmQA+C/bpN5KmjQILjs6i8z6jWwfuJZNqCLW7rtwvhM1xe57cMMak
	VdyFpZn+ObW+mgiJJ1YYFCHit2x/c5aCk7sYZXSHkcDNuU8LyrorssPou39akm02uGTnnLicukv
	eYjIdVoEjFeSm+2vj4yY+47vpA74sTYkVfiqpoVWrFg6PHR1mA7mUOYK81vokQBQjzNXCEr7R47
	WfnXkM3qXwgIOKpvAXQH6/0FoNiZvMptsK2bjBYw+3Zk/SzAIJQdZcA1pct9W34nbDFQe6t/MNQ
	xg1/ogibuTSn8RoCep2oLGkBLL1ldanMX813f4V+YOCQWypG3jtJtGphxJqfyK0Z6fpTUnIuOga
	v59jM8=
X-Google-Smtp-Source: AGHT+IFm9U3smQa6+NdE28V6JGiqAx7ls0qtePHR+YPiXlASo8b2JGls0Au4/g3Ffd+thu3U7V938w==
X-Received: by 2002:a17:902:ea0f:b0:246:7a43:3f66 with SMTP id d9443c01a7336-294dedd214fmr7872585ad.7.1761688747430;
        Tue, 28 Oct 2025 14:59:07 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:c8f:b917:4342:fa09? ([2620:10d:c090:500::5:1375])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e45a4csm126965515ad.108.2025.10.28.14.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 14:59:06 -0700 (PDT)
Message-ID: <77a3eb52-b0e0-440e-80a0-6e89322e33e9@davidwei.uk>
Date: Tue, 28 Oct 2025 14:59:05 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 02/15] net: Implement
 netdev_nl_bind_queue_doit
To: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, davem@davemloft.net, razor@blackwall.org,
 willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
 martin.lau@kernel.org, jordan@jrife.io, maciej.fijalkowski@intel.com,
 magnus.karlsson@intel.com, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
References: <20251020162355.136118-1-daniel@iogearbox.net>
 <20251020162355.136118-3-daniel@iogearbox.net>
 <412f4b9a-61bb-4ac8-9069-16a62338bd87@redhat.com>
 <34c1e9d1-bfc1-48f9-a0ce-78762574fa10@iogearbox.net>
 <20251023190851.435e2afa@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20251023190851.435e2afa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-10-23 19:08, Jakub Kicinski wrote:
> On Thu, 23 Oct 2025 14:48:15 +0200 Daniel Borkmann wrote:
>> On 10/23/25 12:27 PM, Paolo Abeni wrote:
>>> On 10/20/25 6:23 PM, Daniel Borkmann wrote:
>>>> +	if (!src_dev->dev.parent) {
>>>> +		err = -EOPNOTSUPP;
>>>> +		NL_SET_ERR_MSG(info->extack,
>>>> +			       "Source device is a virtual device");
>>>> +		goto err_unlock_src_dev;
>>>> +	}
>>>
>>> Is this check strictly needed? I think that if we relax it, it could be
>>> simpler to create all-virtual selftests.
>> It is needed given we need to always ensure lock ordering for the two devices,
>> that is, the order is always from the virtual to the physical device.
> 
> You do seem to be taking the lock before you check if the device was
> the type you expected tho.

I believe this is okay. Let's say we have two netdevs, A that is real
and B that is virtual. User calls netdev_nl_bind_queue_doit() twice in
two different contexts, 1 with the correct order (A as src, B as dst)
and 2 with the incorrect order (B as src, A as dst). We always try to
lock dst first, then src.

         1                 2
lock(dst == B)
                   lock(dst == A)
                   is not virtual...
                   unlock(A)
lock(src == A)


         1                 2
                   lock(dst == A)
lock(dst == B)
                   is not virtual...
                   unlock(A)
lock(src == A)

The check will prevent ABBA by never taking that final lock to complete
the cycle. Please check and lmk if I'm off, stuff like this makes my
brain hurt.


Return-Path: <bpf+bounces-42159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8969A02EB
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 09:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 712E428863A
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 07:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D4C1C175C;
	Wed, 16 Oct 2024 07:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="O3Fag4bJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7B818D634
	for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 07:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729064763; cv=none; b=Q/2FnsRBaj6kqeFf8Ppxx2nnqau26u/vnVV6DIf4rOhGv/lu7QHMB+TjFXATfZvw7Jp+5OxzCLuPvP0FdIXz30WvJ7mS53fmfbh0FqaOZaopbFErtyIo12p0dwarDvVc7EOPpGlXQBkDUezxUMZWJRXAfHA7USh0Wd+JN6EMHIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729064763; c=relaxed/simple;
	bh=mpY4WNBJdwr0rbv/zBkoBWXD2Yhr/UefAopc/FUGOdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S0thPgrIAcLe0dZmYVK8EGH3idftR1I+b0LO9LSa/ioX23CAFCWl0Pw5XjvtrzqpYHI8eIYr4Qc04Qh2ZzPPJHo4Jk9Bo5/2ZL5MjFeZOaSvxqmKkb++3DG3TP6do18nwhUqZzFO9HmjAUxdxJexrPSWsFhI2q3y6rsGVS4Shis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=O3Fag4bJ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539f2b95775so4002478e87.1
        for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 00:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1729064760; x=1729669560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BJSjeLHtZE626TM7lIiJxnxd8+otXTytv2mtD/tkcos=;
        b=O3Fag4bJX9PKye2tFWz7QHf09odfjxWgtQ/I5APnh0eO3GkvyMtXMNusV7A5juAaau
         tGuKKyIuPROzcA+O287sOrC2vAgwsD7vFKLgecwotmi1odZHw9xHwx7EGfVL9XCRKE8A
         CURjB+5aZzmM8eJWUYqQA7vVFScmny3zkZgJhRO2n2dNp3MiZVTHFQuk7uuS+NL4FWJc
         99O33+UxUAo5q0nw9NQM26Aw0iSYOn6L3mi6CU3IKQMWjNM3S5juxg7XzghkLR9KnbKr
         lJi3iMiyL1ERxQp+6Fh1Au3NEEKIexhH9Xw2SjURiRg0JhjtEoKyjexI5neCqt/ayTaR
         r/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729064760; x=1729669560;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BJSjeLHtZE626TM7lIiJxnxd8+otXTytv2mtD/tkcos=;
        b=GPEoBx68Z9hpHl5bZTi0M6iTT9ZYNOff9LIBX/Fp2A2cZvGgnl+0Yseu9P9J//7bS6
         mPi5u3gSBhiR34Wnk6fLU0dhMaxgPP7a1tFI/AbvnCF3hyeoHPtQwD3yu0vXPH1JRSi0
         UVoe2cFOAw0b6fRytw0zgRqtTX+g3/NfvejrNcsbY8mE1XvRu7S9Egstphr5WrqNu9V2
         JCgtr9RcthwVAEuK7vVpIqDdVRSGGzFiJ0CD4oQNbQ2Rg+lk99FYAWsFg439+7on23ac
         nuunYbjhBkbQ0RWlmhviE8HDVCJGdyag3SHs9AnZ48U7jbhZpD7S1npyHOMq1VIs7vnh
         iMyA==
X-Forwarded-Encrypted: i=1; AJvYcCVK7kwLHvVgKMRr/kyr1SqLE8MR7nKMMpJfk4vQLMIoyTNfdwT8PjezEDhNiH7kBRUa2jQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzQ67voXB0pVA00zYuu0uw23NrTiAu+zV4/SQp6Ko0LNsVcVnj
	sAk/eLyg5pazIIt9i0c64iw1T7YLornGGpD0R2u5DMqb7nE94laVh0PllwqjwCBDGOI5Ww3c80b
	lacw=
X-Google-Smtp-Source: AGHT+IGCME5bXQdd/nD2M5Nvzzk42p7bqXT/x7isn5M/JA6Mx4W4hpR+wBn+KqEPTJVK6wGHonihpw==
X-Received: by 2002:ac2:5684:0:b0:53a:64:6818 with SMTP id 2adb3069b0e04-53a00646940mr4607931e87.47.1729064287257;
        Wed, 16 Oct 2024 00:38:07 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a29819afbsm148221566b.104.2024.10.16.00.38.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 00:38:06 -0700 (PDT)
Message-ID: <1e489737-fdd8-43a7-9abc-65599e1cfae1@blackwall.org>
Date: Wed, 16 Oct 2024 10:38:05 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] Documentation: bonding: add XDP support
 explanation
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrii Nakryiko <andriin@fb.com>,
 Jussi Maki <joamaki@gmail.com>, Jay Vosburgh <jv@jvosburgh.net>,
 Andy Gospodarek <andy@greyhouse.net>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20241016031649.880-1-liuhangbin@gmail.com>
 <20241016031649.880-4-liuhangbin@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241016031649.880-4-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/10/2024 06:16, Hangbin Liu wrote:
> Add document about which modes have native XDP support.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  Documentation/networking/bonding.rst | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst
> index e774b48de9f5..6a1a6293dd3a 100644
> --- a/Documentation/networking/bonding.rst
> +++ b/Documentation/networking/bonding.rst
> @@ -2916,6 +2916,18 @@ from the bond (``ifenslave -d bond0 eth0``). The bonding driver will
>  then restore the MAC addresses that the slaves had before they were
>  enslaved.
>  
> +9.  What modes does bonding have native XDP support?
TBH this sounds strange and to be correct it probably needs
to end with "for" (What modes does bonding have native XDP support for), but
how about something straight-forward like:

 What bonding modes have native XDP support?

or

 What bonding modes support native XDP?

> +----------------------------------------------------
> +
> +Currently, native XDP is supported only in the following bonding modes:
> +  * balance-rr (0)
> +  * active-backup (1)
> +  * balance-xor (2)
> +  * 802.3ad (4)
> +
> +Note that the vlan+srcmac hash policy is not supported with native XDP.
> +For other bonding modes, the XDP program must be loaded in generic mode.
> +
>  16. Resources and Links
>  =======================
>  



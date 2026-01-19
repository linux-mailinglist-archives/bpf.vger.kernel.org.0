Return-Path: <bpf+bounces-79461-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1950DD3ABE1
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 15:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B895930338E0
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 14:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9544638F927;
	Mon, 19 Jan 2026 14:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="GJEamvkY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EB638BDCC
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832592; cv=none; b=NMZ5A+L0BraTG3gB1y2hXiz5aveFTv7NStH9Lc8fqqRgU27oASdv2sXj7QV/OycznHLsnVUlXD4DMhEnto7EYjtgeO6DfjGMd4ktqJ55GQhOF+0qhGhCNRUFibdItfCY5vKmVmHK1Xa0EWAPVbKe8sYK9ENbLQpHKclESAQrmf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832592; c=relaxed/simple;
	bh=+vmfe/9RjubEkc/PWFw/MXV3lawEBti8yLsTrI2+qnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GxLA89ZGFFoy68jqwPBkqJP23jGZAJYrWSRMdtYKtVhX1rDt5YpMLi5TbN/RVwoFZ6qEte/906y/D0ACY4qzbbBUK2vDMZEtzzeqI9CNHG7V7N9aqtFmHbUvk8XZl3nU2QEa2kbx9VgQSHKWFQNTAIXzZvWazu+hgpp3DATDLK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=GJEamvkY; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso28503795e9.1
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 06:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1768832589; x=1769437389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f5onw7qfTHAR0LUkxhhircx4PkvIBzCwdRMgxoUA2IA=;
        b=GJEamvkY5ElGffmfX7AGgKj7YJUJvopPO2LaBtp9XRj37Y1pF4XsiUxwXL6W2aP/yh
         n3l5dQmBm4K1pDyAhmIlhFyBG7L7JIg2vYqwJ4W/JdoKDMAphxAtCQZDGPU/lfPNR9Uo
         YfV8QW9w6D06P/8MzsyNimrXOuyaREtEhEzFIFETKhOCEIroKOn5knM+Xyev6LumYGw+
         LS3fEWd51uxRjQpR3ZLllJaeRG9M2s2B/x8ytNeGl0lwVTZfcVS2u8EKUfTLLN6BYf4e
         n7+N0FXc58yXLszCguvfeI+/hvfpMdwqiNRh1e+jDtdjUlS3QN0vhMC2ZiDij9IZ4aw6
         QN8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768832589; x=1769437389;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f5onw7qfTHAR0LUkxhhircx4PkvIBzCwdRMgxoUA2IA=;
        b=WN3LCE19LybpaZQXhgHeqiqvQlpjnjMsCFhBkfvd5yyNOlsWMPMnvUSeL62DNNsVgW
         H+ATajupMPwhO5MUKdauxJriuiUbUtWTXzpET39KL0IlAiUqjNhr54UO13Z0XkdDQ6wY
         Spf78Mn/SRbTjQ9qW3AVlceeqX0aRUJuyLIaq09sKcXO/pySixcrIRL2PAiS7GCcsrto
         QKK+AgFYYtiIz/QNy+n3ZWZByEfQSzChmYliOlyKbzrpjOWDLyjEXzdV6zY7kV321UAt
         ncrWX5g/Kj7arx8WqfXWCH9c7Y0vxebrVgIy08FQ0T8WkrzCohFkFmFb/7WeC94hUmTZ
         1u6Q==
X-Gm-Message-State: AOJu0YxjsRSlDhmpFKdWxt4HWpNE1C0EdG5BIriD5f7mO8F0aLzZEV4T
	tK5nWgSMfoZP998yLGBgE+thhVsLjorRmowC3fI0E+sJISg6DtFpdTo2h+rsj4502n0=
X-Gm-Gg: AY/fxX6kH4cy3KVdjnLiVpjCWXdNJ3AcSpyVibGclwE8Pdgn04Y953zqb+8aRB4QYPg
	yLY6Z52VRKAiwMsvdO5A78SQTCTwZsU1eAQGo+68xbz+oq1OFPKMuUh0PwasxjILQXuBtHkIO6Q
	5wGbIaDAVObVYD+sNcetWklVdKoay1IR0RVg4hFrISwisYkI1piMJ6Q0hiOLF4fwHM3xvPW9eLB
	yOsK96yteYZQfT0ztHxLYxrO9K5ZF0lifzH6b1VNFHUJIRuAkMsUwLgzJ0bZbGI8r+4M4Vf+6LV
	pe82s4fUTNHyZaXfDaZM2Do9cqWFF1f7eRYAhU7wF6/8S/pDANSl+KpihVVpWmjSgTKZqAkorMq
	RB4d11gxRjAXazy9Sj55pBqlImC6RrElDlA2UqaI/6zDzuc9qGd8CAgeMZO918UQJdepzSS576b
	QZC7PwNvBCdsr/bfH/wslYpS+ucAkjWv6LUIMgAj2p46memjqkWQ9vG904p+XuNWe6jKBxqQ==
X-Received: by 2002:a05:600c:41ca:b0:477:991c:a17c with SMTP id 5b1f17b1804b1-47f428adf95mr122638725e9.6.1768832589084;
        Mon, 19 Jan 2026 06:23:09 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e9daaabsm82247255e9.4.2026.01.19.06.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 06:23:08 -0800 (PST)
Message-ID: <a9150463-0c82-4e22-ac2c-99c2336be1c1@blackwall.org>
Date: Mon, 19 Jan 2026 16:23:07 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 13/16] selftests/net: Add bpf skb forwarding
 program
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-14-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260115082603.219152-14-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/01/2026 10:26, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> Add nk_forward.bpf.c, a BPF program that forwards skbs matching some IPv6
> prefix received on eth0 ifindex to a specified netkit ifindex. This will
> be needed by netkit container tests.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>   .../selftests/drivers/net/hw/nk_forward.bpf.c | 49 +++++++++++++++++++
>   1 file changed, 49 insertions(+)
>   create mode 100644 tools/testing/selftests/drivers/net/hw/nk_forward.bpf.c
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>



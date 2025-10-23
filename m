Return-Path: <bpf+bounces-71887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8769FC006BB
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 12:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C32713AAF19
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 10:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9F12ED14B;
	Thu, 23 Oct 2025 10:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e1MlJuWm"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BE32F99AA
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 10:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761214648; cv=none; b=Oqs9HC4AdIeAtgi94gULFffA7Qe2qanEijgAqS8xwlI7yjn22dNCxNiiTsCVPQaLuaier+nUYsVQPe+kTtL/kHz1VQeXj0nB+WRrcbRMAJ1uzzBYdWrLqUTrhf2sNenJnkNG4DX/ULKzYwqUCGWNxgRwIlIQgZson2y5j+Vm+nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761214648; c=relaxed/simple;
	bh=SaXOkjj44KsPzP7FTIYWUkvqgupCP6+F02PzY45C/Ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GLsBPxVk/3PGvt5YGCxeQHe5Dkyc6BUeRP5i0i/yyzrQQsHMrk69BlhxuOaqk5Kv+6X5h13u+rlGdYdJxIAEHvVZPhRfvnBBA95DOnErhfoj0NLVWUmO7tAqGtTpnPx4Cc8JdlfU8GROxohO3zozR7LAh+FV5daQYBN8ZKcamrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e1MlJuWm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761214645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tTjTS7ITM5eNoZnzKqwLsP+1eY83cxIMzrNl1Nl1gq8=;
	b=e1MlJuWm3z1ZZv6TrlYFPrwBkOpgEL7KZ93X8fr90Dq42SsLMJo+263LjselWNZSs1+Nn+
	NonsJ9wk3HckqJZu3ByyQl28luryk11R9A1wOgRl/L0cTz4LbglnNiPTYvjQqzWcHUKJ1+
	WUmaUQbXdVyJG+kipD0faXRurUh+JCY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-Ft3dRh0_Pyu43zVSYL0Fqw-1; Thu, 23 Oct 2025 06:17:24 -0400
X-MC-Unique: Ft3dRh0_Pyu43zVSYL0Fqw-1
X-Mimecast-MFC-AGG-ID: Ft3dRh0_Pyu43zVSYL0Fqw_1761214643
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4284525aecbso474029f8f.1
        for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 03:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761214643; x=1761819443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tTjTS7ITM5eNoZnzKqwLsP+1eY83cxIMzrNl1Nl1gq8=;
        b=nZA6m13zkaJnF01raJ17FxsvfBtboucUZMZ6hAplfvCvJQzfCv3ZtkVHo9fgkr+Lqz
         xJLz728ymwbUfXqrMQxBvzFfP100Pf81TRUJ0yLuEbzqNeAJ2/eRNLXF1QK9MkY50Mhs
         SlCyLNpcxOmT/UxzH0hMTQV8+6qV5t8afATzV+yvxHdDFM2QtrhhdmOk+XZ49H2/Kvnx
         uYq86a+0Z0nGNk0lvIocTJZtoGd1uZHIGKGb7fu/hIC8Rg1nqrWZewnOidA87uS+kc1d
         hcJu+6d7Nk43PoGeRWg6KaWUK9auUldRaT+AUbJLYgrVhf9+Lqp0LxYj9TuLCgIW/9cy
         WWvg==
X-Gm-Message-State: AOJu0YyY0UhMsuSc1CsQVXyPSDgV9alwuykKf1iaK2NBsucBqz+Z5GMq
	6nTxKVNo/9zQ7bXpd6z8rWUQfdeLcepH2kdGnHXS9tMy3/jO+zECPj0ZTv6Hb9XlIOiqzm+P6y5
	eP4/rw9phac5aR9A/ZNdyW6meCJSu6SXbp+zwKb6gDqenwcK8EFCX+A==
X-Gm-Gg: ASbGncv9DD7iOS7CPaTJHKuwhBBow/b4imce2FsV7Qw/SKox57Yde/Zp4B3dIxTBOzk
	MrZqwU7XFOupUW7mcSp6zOpkPjAP8QsEUGH/A6bsKzKi1RUA5NyfwNQDscW9nV/J1SBlJFMkRoU
	pg/Pq5L9TGWTHmJBAq1smCmL/+SWJjOCYItYUf7w638jBI1JG4kRGojHBnhTnRJ/IjOEWgD3IRf
	BELvnCg0e1JTKaV0bmwasD/EGDyRjU9G/IYmj/Ryzs7h5pJ7VrwAG4hwxhuXoOkqFpZEl8QYoBy
	a4LtGBKAwQI4iCkv04ZX8W70WnQZPxR0KqDn07YK/CSzPH71WEy+szGcurPz6Ha1YywSLhHFZOx
	yQKrad/Eiry3fjKBEsqjfYIQQkzHOHb8WcQGfUojXB88L/Ho=
X-Received: by 2002:a05:6000:22c2:b0:3e1:2d70:673e with SMTP id ffacd0b85a97d-42704daeba1mr15624641f8f.37.1761214642757;
        Thu, 23 Oct 2025 03:17:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHy+UCM06cfKQOSnbHRidyNFTJpNDe1rcVCOoYg16ExjuarVIV3gX840vhikp4rbxjpMKykVg==
X-Received: by 2002:a05:6000:22c2:b0:3e1:2d70:673e with SMTP id ffacd0b85a97d-42704daeba1mr15624618f8f.37.1761214642336;
        Thu, 23 Oct 2025 03:17:22 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897ff371sm3129221f8f.21.2025.10.23.03.17.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 03:17:21 -0700 (PDT)
Message-ID: <3b091dc8-47ae-48c2-b7e9-ee3deea6d5e9@redhat.com>
Date: Thu, 23 Oct 2025 12:17:20 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 02/15] net: Implement
 netdev_nl_bind_queue_doit
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 razor@blackwall.org, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20251020162355.136118-1-daniel@iogearbox.net>
 <20251020162355.136118-3-daniel@iogearbox.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251020162355.136118-3-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 6:23 PM, Daniel Borkmann wrote:
> +	tmp_rxq = __netif_get_rx_queue(dst_dev, dst_dev->real_num_rx_queues - 1);
> +	if (tmp_rxq->peer && tmp_rxq->peer->dev != src_dev) {
> +		err = -EOPNOTSUPP;
> +		NL_SET_ERR_MSG(info->extack,
> +			       "Binding multiple queues from difference source devices not supported");
> +		goto err_unlock_src_dev;
> +	}

Why checking a single queue on dst/virtual device? Should the above
check be repeated for all the real_num_rx_queues?

/P



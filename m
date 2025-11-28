Return-Path: <bpf+bounces-75727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAB0C9247D
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 15:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0308E34F899
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 14:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F81258EDB;
	Fri, 28 Nov 2025 14:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YUy1WC6Y";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="guVJgbdS"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9C622652D
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 14:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339619; cv=none; b=OKS/gt3nWvk6Tc+pB6QiEXawvuxqwTct5aUyS5XHWOwpKyk8ivnC5ACdRylKjkAR36ByEj9lTx/bHNl/fMqk32YMQI3uZQm242ypYAcrk9V/4Cm3TI1zucqvpLH6ysfGWN123XEXNH5kDYYljugH4rhbcnpLlyVUpWTTp6lwMKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339619; c=relaxed/simple;
	bh=8ZG50ZqkqkDxqSfIjwekhMuh5XfBJIyhfIgk+C9P604=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kyZt6EO7AlF5YYbHOwdxMsJR11Pfn6y2CMZyKNF4eDunq13rnQVCMB5dcP/EKvx9yPFupvotkE9cdPD6Pyn1qnOs2MOLEDklerVV2qQx6gUheswkK/+IdHngIAPKu9TlEBPR00gUdNISuebo8ZQM7Bhm60EAAjHEM8mZkoaORqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YUy1WC6Y; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=guVJgbdS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764339615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kr44LRycnRrIIIsoZeGxJLnFhlm7tgfT91Z2PQUzwxE=;
	b=YUy1WC6YfaHNoBDe121oSfZo8fNW1hcLy0a89FDl3WMa7Ozj/rrWFO3K1KvD5EexPsYcDu
	TRRcaIbDTkSi6Qdpc9mDJDXtRlCIYLSh413moSEZJblAHYa6ZUmCLgSoiHGm2YLzm6BOJY
	GLjKCbx8s8KoiAAu2VlsC0GSajgzolg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-AbjpXv6jP1qOj2PFn3O0-g-1; Fri, 28 Nov 2025 09:20:14 -0500
X-MC-Unique: AbjpXv6jP1qOj2PFn3O0-g-1
X-Mimecast-MFC-AGG-ID: AbjpXv6jP1qOj2PFn3O0-g_1764339613
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-429c76c8a1bso1313188f8f.0
        for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 06:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764339613; x=1764944413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kr44LRycnRrIIIsoZeGxJLnFhlm7tgfT91Z2PQUzwxE=;
        b=guVJgbdS8a7JrPepNakwKo2/1mDwers4L/hgqQSo2kPjF4uX0ar8PM0txwZIww1Sh0
         QmyhT4tTanarAiqftubviqO75eQ+CyY1BjSjsMrsEEek6PQ1ywUXQdXh+WXHVK1/hU5W
         tD3Qx5RID2ScY9YfYHv0550zI1f6vqNmwj95/5pAsHzY37QKt7cUgKg+FwbKO2tc5iMw
         AaLEcQ1lHZBIHPyjdhzG82SS4SBRSIJa+FMSRLNhCjCwD1AGdZpi6N5iFsSFvDu+hQfS
         8JnsRQ3THXQCF9Xj9ydi/cJz0V3Mi/ngF2q44QhtgRm/H8g1HXaHLeER2ZoSCOl3IkIH
         FcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764339613; x=1764944413;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kr44LRycnRrIIIsoZeGxJLnFhlm7tgfT91Z2PQUzwxE=;
        b=D7EhoykP4kIjzT9Ytsj2qtOy0B1LBGqQYPEN20t6o0Pk756ENnrBmFKktQOnDAQnad
         QMjfdoLXgB1jfSgBMcRaezPU7jg+AE0sWqlNx30jJK7jAhM7/4SQIspNJiT1H409yjOo
         XnIjgixhlyI2TgUFGS5U3XdNac4LsBAZcXGQ3rs9VeEbmLt1flMdgl1X9/5ZW+nSzolJ
         CPmVlzpatPow5kXS+o+hYEZyIZBLgeHChEYMaIqecBd59YZ7IDSAF9iB9HMaTE/lXuLV
         nPD9qqvm6VE+O7xsbHW9TU9Ubdqy/6CP2VnYa9zoju89LjFPHgkzi+0b5BDhI+iKFLM8
         jV1g==
X-Gm-Message-State: AOJu0Yzrx0i6//d3K/C4gOsKCFBxHvUmRb2eHAOJkBtKoNZlJcsnemUs
	+sHfj9p+UcF1fgPajS/ZdoKYncMUIF27iKQpQpgfPMBn7pssAFZtoVBT4V8zdl7N1sGZ8CNhzu+
	c5DsgIBeMup1WXuJQ/QcJeSp4jGMKjHivf3cuf5wfPnS62OQ12L/10g==
X-Gm-Gg: ASbGncueWFWEuqRy/E/pRAe5GDb4niW7IAZ2mVonuj9ROpBhVOknI64Fvtizt8KBiGB
	++n/FKzaOr8HbIaIh0JA3mb8ncEJ0IovYlc5qoYXIyI9Ura/xPqhwyOE6VIq+IdAE43jMZYWRat
	o4w5DR4r9YAQduOpj8tA9FtqszIfMwSVwJGkQRju2Buwpuoy5gP+DScWt0s9Tt5pDACaKa6Cmy3
	PI47g2EuYw7tjpGXq0D8wkUFgO5ANTCGhw3LLCXsTdyKWOU3nWC1fhcXsCTJrahy7+CZypOHtm+
	Rs53BqjioGOWdLBUfpTOiHrqJKAHzdCSxWrexHmoyItOsbV7oes1DtRvUCkXla0zZouvsfMVMPv
	2haJNyu5qbitPfA==
X-Received: by 2002:a05:6000:1a8f:b0:42b:3c25:cd06 with SMTP id ffacd0b85a97d-42cc1cee419mr30438922f8f.22.1764339612534;
        Fri, 28 Nov 2025 06:20:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPEkA/LoZdallg49g1MUTRCeyrnm9WywP2P1KOTjKBH4y40uAcYN4UEnTmkp4kPiOrnajn8Q==
X-Received: by 2002:a05:6000:1a8f:b0:42b:3c25:cd06 with SMTP id ffacd0b85a97d-42cc1cee419mr30438877f8f.22.1764339612057;
        Fri, 28 Nov 2025 06:20:12 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5c304csm9948281f8f.8.2025.11.28.06.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Nov 2025 06:20:11 -0800 (PST)
Message-ID: <8fa70565-0f4a-4a73-a464-5530b2e29fa5@redhat.com>
Date: Fri, 28 Nov 2025 15:20:09 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/3] xsk: use atomic operations around
 cached_prod for copy mode
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, bjorn@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 horms@kernel.org, andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
References: <20251128134601.54678-1-kerneljasonxing@gmail.com>
 <20251128134601.54678-3-kerneljasonxing@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251128134601.54678-3-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/28/25 2:46 PM, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Use atomic_try_cmpxchg operations to replace spin lock. Technically
> CAS (Compare And Swap) is better than a coarse way like spin-lock
> especially when we only need to perform a few simple operations.
> Similar idea can also be found in the recent commit 100dfa74cad9
> ("net: dev_queue_xmit() llist adoption") that implements the lockless
> logic with the help of try_cmpxchg.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
> Paolo, sorry that I didn't try to move the lock to struct xsk_queue
> because after investigation I reckon try_cmpxchg can add less overhead
> when multiple xsks contend at this point. So I hope this approach
> can be adopted.

I still think that moving the lock would be preferable, because it makes
sense also from a maintenance perspective. Can you report the difference
you measure atomics vs moving the spin lock?

Have you tried moving cq_prod_lock, too?

/P



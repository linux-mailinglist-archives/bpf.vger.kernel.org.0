Return-Path: <bpf+bounces-59278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A6DAC7920
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 08:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1E7A189995B
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 06:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E3F255F57;
	Thu, 29 May 2025 06:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aXBHpeGP"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D310524EA9D
	for <bpf@vger.kernel.org>; Thu, 29 May 2025 06:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748500887; cv=none; b=tEsxu070YbnLAOyytmlwn9IHwCHvfArPPzyEcSRrzNwDErs2daqYYHensafZ4sFREFPgPCo8SivalbUs6yFse0soOgY0Kq/oDfDG1cf6nwEglWg6HqzTU4JnPFutdA/GlAw0Mr+qnNDr78LtHLEOfWskVw6eF9oQPOa/loqZfQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748500887; c=relaxed/simple;
	bh=uo6zWtMJAmsChlsFAzrq8E9fCgS8gXBxbYq/eth/kWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cEgQFQJDFHmPnrbrPj1zCME4ahH5ymEg7fIQ/tre2/B5JZlSb9m54ad8h9c7C/yRO/SVUqOw+ll8N47kZwu7YautUCCbJXRMnNThYhCcbzn/fKh4u2pQwAmNdwoTYc575XmmlSES7hFMFqgxRGfHGslhY+ddjw+FrbOGwPrU3Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aXBHpeGP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748500884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9gZ8u/vWknXqeMvhMYoZse25X6ebh82JRFp9N4VCxqk=;
	b=aXBHpeGPUdTDzNWyjiVeo6VcVGeDaNn63p5/0dikYfOdlNoKamlCkvPPtwLIr84jfCpj8Y
	Um18yxmBDZY6guuX2JPdJTtJGZ3hBYYW+zZa/L5YD1EuGHo0JgcjtySa9y394LGfv16Uur
	XoBnG9xYMjLY7WtLP0Nhl1I6CGPy6ak=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-ud0XaejAOMWcNbzkWDEKbA-1; Thu, 29 May 2025 02:41:23 -0400
X-MC-Unique: ud0XaejAOMWcNbzkWDEKbA-1
X-Mimecast-MFC-AGG-ID: ud0XaejAOMWcNbzkWDEKbA_1748500882
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4eee72969so345040f8f.3
        for <bpf@vger.kernel.org>; Wed, 28 May 2025 23:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748500882; x=1749105682;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9gZ8u/vWknXqeMvhMYoZse25X6ebh82JRFp9N4VCxqk=;
        b=gWRTI42Mvm7Q8PmQo8HSfmjCT7oDac7cyHMDTLQUL0S9GNXMMqnOVuyzWExCXkQSwm
         PEAmixALv7keU6h1WzeZv+PPpHJQUIDcz46NdybsttZW2pGn2iKQTD7E/wi+zQiDSkXN
         4vB2IeMSbOg0NXew0nOBnW+JigDP+jeS4EuzW5mBuhS8iX12IN4N/bm70DhYkFcjx68j
         f1GrfVlmDTTeG0ANLonEF4M2/+FIlebE91403GUDUtqtBY4L51pajWucjvnw2060KEUk
         sYdBewlU5IQ2ZpBHxJYsJsm5Mh/TDGqQXCecHW+yQVGaD0EUtL1VPCmLZmvagZQL1bcw
         6iwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlFJ9ctUOvIoxNer1K3tEvYPDnUr0jQEjl77Jjpds0B5l0hNhZIywawST0spspimqB7kg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVWWmOMRXeRmf4XJvlWmVVIcsgx6aRU8RMPyspLbd/hz51rHR5
	HFIYmL1LMDNtPQ+VK5H5g6fkhvU77undtCyL9wUaxS/FKX/A/evgNtJSXNepMVFe3omhd6Z21dK
	e5wpKTwTqYOPSI5Pn1cRjcZ833RevKxeHglS39czs9k6tyv6jFVg96Q==
X-Gm-Gg: ASbGncsrBtRvgc5rQM/Ti5/aF7/Shg5RFFf6m7X0hK8rrioUH1KI5E9SCgV6J0F/fTE
	BmZyQLvz6g6lokLxYnT7yGlTu0azf4UqO0EaPLwSkTnEWYzp6DOpFC6Bu8qIRszbDisNe0UUOd6
	hkKUOrwDKW09H+D/qPsUXxnK3ckhYFVnpcBUeLxkgiOX85nzMJ/GTDe8IOrTSe0T51PNxB8MukT
	RzCp2hDo+lu6uq3gCwVsDevptdgXn/R9Rwr6056EPIWvHt1DBN5mYBAuh61/zEcWHbJ35889Zr9
	hX4KndExgztjh4lvnjoeQv0lkfJZl5J5pm5MEPiNYgOoTu4FcDgkr84ExPQ=
X-Received: by 2002:a05:6000:381:b0:3a4:e4ee:4c7b with SMTP id ffacd0b85a97d-3a4f358f0camr603432f8f.15.1748500881769;
        Wed, 28 May 2025 23:41:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4WDum86fTnMvRYqch6MR+ztEYQ2eZPtIMANK31N5JRpHf3kQXQ5zQS9pHaQJE0QCeX7DRPw==
X-Received: by 2002:a05:6000:381:b0:3a4:e4ee:4c7b with SMTP id ffacd0b85a97d-3a4f358f0camr603408f8f.15.1748500881399;
        Wed, 28 May 2025 23:41:21 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cce5:2e10:5e9b:1ef6:e9f3:6bc4? ([2a0d:3341:cce5:2e10:5e9b:1ef6:e9f3:6bc4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00971efsm1015064f8f.62.2025.05.28.23.41.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 23:41:20 -0700 (PDT)
Message-ID: <21c1b2d9-1b94-4caa-aa68-8abbb6562446@redhat.com>
Date: Thu, 29 May 2025 08:41:18 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next,v6] net: mana: Add handler for hardware servicing
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
References: <1748382166-1886-1-git-send-email-haiyangz@microsoft.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1748382166-1886-1-git-send-email-haiyangz@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/27/25 11:42 PM, Haiyang Zhang wrote:
> To collaborate with hardware servicing events, upon receiving the special
> EQE notification from the HW channel, remove the devices on this bus.
> Then, after a waiting period based on the device specs, rescan the parent
> bus to recover the devices.
> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Simon Horman <horms@kernel.org>

## Form letter - net-next-closed

The merge window for v6.16 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations. We are
currently accepting bug fixes only.

Please repost when net-next reopens after June 8th.

RFC patches sent for review only are obviously welcome at any time.



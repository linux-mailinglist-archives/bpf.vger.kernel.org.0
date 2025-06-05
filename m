Return-Path: <bpf+bounces-59713-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0C4ACEDB2
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 12:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A38C816DC08
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 10:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37587216E26;
	Thu,  5 Jun 2025 10:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXainLeG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2051C18A93C;
	Thu,  5 Jun 2025 10:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749119605; cv=none; b=OK9G23X7WTVwtmxl6CjDk0dV+5l4QwuAHjp2R2LIeejOcKF0kiwm6tpcanK/FM/enlu1oznTODqim8x2N1uh0KJAlN3Urxkkr3aHEPHddV15Cbirb/QDe2Vhj8kf0qemVfzpMzg4Q27c80A48U4NEPbAm4r20+3/hQY3h9iFVDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749119605; c=relaxed/simple;
	bh=fEsCRwPMVYPWUNaghwXtinfknmKt4IyQv0wCv/OuI/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hoc7ZM12YEPbL2ZADLw9bgycugIYNaqbVe7V1XLawaRgsT4PmEBP/XMX4HnzdTI4HshZ0l0TqZnezDXac+Z7NPqu3Qj29lxS5UUynAzcDToiKcHRYTVBNpj1aceU6dGuHij8bFgwjMwe8Hjq4aSt0Ype9+OnJGgYcjxh+hbAfBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXainLeG; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6071ac9dc3eso1232814a12.1;
        Thu, 05 Jun 2025 03:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749119602; x=1749724402; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pvkL5BUeGrJoHhgcuCCQPpcR6LRmPz+8h4ofmutJ25Q=;
        b=ZXainLeGbiraQ6f1bdlMcmCF/sLcad/AAdy1Y+cse0tKXsPfzHjfkPX44yn19iio8W
         PFEKEhB0VFC/I9iKVEtmzw984FXOTgwBwgC5CBgbofmTnnjxftbM77y5pUqkTlEH92PA
         BrN7yswLh6jEVPsNVobR9cR4MJZbMt0lR1m86F9WEF042jT4nuzrLpiDN38znswC451Q
         hdiKaN+m72thDNCYnEzc1d2xW6EhbHo+2RKAj6JMDzKk5sZ9bTinIOb6t5hB+8llFDU3
         PRthqWSswMfV44nnOsA8ML8LovQNBC8QDsx3k9A7I4TCNOgsJJ64RCwzT4h4pFm4o97t
         bTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749119602; x=1749724402;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pvkL5BUeGrJoHhgcuCCQPpcR6LRmPz+8h4ofmutJ25Q=;
        b=idqewV1YtBr/d/aucJOwlYVFt8LCXLdk10JKFT2BiXE7Wgvi1qHmTyZhJcr8YvHOfp
         26iX4Fpwrj/A3UFbLHEiXtthui/yhjgl4h/qF1ydHkJSOVISu5tT/9OWQhtt63jWVJ1c
         IZUGox1KEBKK2S+IyGjD4pHuHUUJS2B1nWFtcRwx+ZBZG8VQbrq+FNZQ89wK4Wj0zE3B
         s+UtfAyaA/qw+AMoaSQDS9gCvOE2SD+s6Jmh8K3GsyP2Ts4tnN63dkvaVmRMAtRQCpa4
         wReBHULhFgv2wmSrSR1Nmkt5s+tk4c/zpCkwn9u+/qYyv2WjZH3+Po5YJ90itFIoKC2H
         Z+tA==
X-Forwarded-Encrypted: i=1; AJvYcCU//vSJ+HWauuOcMDajWNgEIBN5lpcCZUsVTniC+2k+TgP7EcxqptRSxk6ays8jOcJwMR8=@vger.kernel.org, AJvYcCUyqD3rfMaHB6zLAS/xnTTtKJ4ObR0/aLrEbG6B90iPs5+uTvNqMGBgH6qkap+C3CYFoptUV49T@vger.kernel.org, AJvYcCWgZk1Kws1MESt3eLXnzKI8UN+ngWJaA87zdV2TLzKeBrHTOoYJuRvn/LqNCGvZdix65uNQ+M10DF9jiw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFRvw4ABkpE0BnrwG6CrvkcBppfTrV0QU1N16ojEC4/mR954mE
	nupXKFo4Kp8WO+X5bT5wulFIY3C6LV9vfCEsh62+Y9d1y2GLlqhTk/Yq
X-Gm-Gg: ASbGncuI2lhaGa9ixaujJpX40xKHFqAYQlGHEYrs18D3pPJtu9o/MVZUFKUEm4kaSu7
	rzHN9oUd6ypRuHAAvR9ua9gdmgI/Lqg0kZmVn0j/y8wZE24DhDlu5OUHtLjdf4gU+32ujFaAhkd
	THaSkObVk1KhHWGcQ4cEz8r7iVvPMWhmi4GMenJLOtytAMDxI779qDnhOVU1aOconqy9C9/M0lG
	40PVjkqpD8kdBjd+hsBEzWFQEm/jZDONVyVnyv+4iotWrb3rFBBWOvrJIE+e6lOpQ1UOlA1dCul
	ELRvzqAPfy2OR3g8HqOE0m+r5SxqZAYf0g/u2Ejw/Z1CbN0gW9f6ATOpUl3KERqC
X-Google-Smtp-Source: AGHT+IEv6oIoayiFALrh6R3BYsml4mBtVK1tTkCc9XAcCjRB029YDmHadKK4jYnYmz9npj/BrRA/eQ==
X-Received: by 2002:a05:6402:27d0:b0:606:a99d:91d4 with SMTP id 4fb4d7f45d1cf-606ea16f586mr6355901a12.27.1749119602201;
        Thu, 05 Jun 2025 03:33:22 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::22f? ([2620:10d:c092:600::1:d66f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6071edf645asm1213803a12.14.2025.06.05.03.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 03:33:21 -0700 (PDT)
Message-ID: <e6f7a10e-e16a-4bd0-908d-31b9522ce096@gmail.com>
Date: Thu, 5 Jun 2025 11:34:41 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 08/18] page_pool: rename __page_pool_release_page_dma()
 to __page_pool_release_netmem_dma()
To: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, toke@redhat.com, tariqt@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-9-byungchul@sk.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250604025246.61616-9-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/25 03:52, Byungchul Park wrote:
> Now that __page_pool_release_page_dma() is for releasing netmem, not
> struct page, rename it to __page_pool_release_netmem_dma() to reflect
> what it does.

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

-- 
Pavel Begunkov



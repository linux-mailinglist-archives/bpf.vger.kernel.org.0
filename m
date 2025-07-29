Return-Path: <bpf+bounces-64603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB68B14B15
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 11:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64C9E3B733C
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 09:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D23327FD44;
	Tue, 29 Jul 2025 09:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVLW2e54"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C69122538F;
	Tue, 29 Jul 2025 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753780875; cv=none; b=E5FDpugDvc2Xa3y0PYyCBTgWSpl7YutBTtbY7dWvsAoZSIFjA4VH9SVd+dNgyeBdEwzpBb5qdwSBrTaIqt9mz1DXn2HLrzrLsGhsYXi9WICmr5O5BrlCTyBOJXj6vOpbZgbScpmndaQD4w3uOZBw+pbD9bQ4EDFgzi3G09hZ5Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753780875; c=relaxed/simple;
	bh=EpKjTlfw0kd8rON0v9QAxAUM6H8C5WKYIrqJkAcA4HY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FIG1qVberHboYdUkWtzczvua1WWPFMEDLPC+QmonuVQ4dDztOSxSlITPqOW+/UsyTnDsBDV6W/3izQ03aV2MtmiUTD1dr/0GG34QiCZ6zuIMzrU33742z7DXS6A2MqziSj6AEqbamnUOMk+GvU8IIB4CR18UN69iqJcGJmaroJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVLW2e54; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45618ddd62fso53230115e9.3;
        Tue, 29 Jul 2025 02:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753780872; x=1754385672; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2u4rjqAF5Zc7Kz0jelPex7W70gE8IrEqV1bRA0AwlWo=;
        b=RVLW2e54oJ/MtM8SI6uUORf1TmYGgy/WiLmhvd6oDr9D9rPtbsLdWE4qbiaHEGpArW
         t0OCYvYg1sviS30hOhV3/Np5rBIcJYOKSIzlpXsdyU4OEBIqClrw8MpjCil/+AGa77qV
         THfZA8I4fO5BWhYO0nxTJxE9iNETlX/E0uRFZrKlUR2PmBG5SckrWKUN7hA1WG9OIS1O
         NhqwUh5iDNBLS5ZLUXyCKt8d+zvF47ktFoMI+AB58dL+6GvTTcAmPqaOOFUbxR9BTFXI
         Vu5scKnFJjDTE71jsf1BJsyzWvGkxGBFjSynifVLf6nV19rOWkqcesX/mhMbcwE4M/tH
         Y3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753780872; x=1754385672;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2u4rjqAF5Zc7Kz0jelPex7W70gE8IrEqV1bRA0AwlWo=;
        b=ti/iLyKbD4ctQtpf3VqNy18f7YyZyX47xyhOgn2zy6xad9N47Ppxrw6Ow7oJcJbKEQ
         SEDHrLzTHM6aEt1Tof6N/wTw0ohMo10wrZbY4oANm43YLVpYwkeOFNBTIWeHq4hRwRyl
         epiGABWpMpmNtosI63zjHdprKW5sFYufptJe93LkZ040oBkTlN3fVNVyO0hXPHVFH/ln
         Z90JDRtnrkE3QRMhppZOgfCordpiZTT9ZbmpGJHlvE0bI0SH5n94t4HeCD+FxE7XZz4r
         u+4vNqRloZhpYSoG+CpQoZr/ZFrcwmGeZXCrLgzRr7ReHmgHSV3Q+UXqD1VE9tXXVEtL
         lqFw==
X-Forwarded-Encrypted: i=1; AJvYcCUmrQvGZV/QIHoYymb98JeRb03H4Me/Do0TOE0C6AJ2O5Qkvav+MdwWt04qJ4B+nVqhGjc0dmo5kbCevbsc@vger.kernel.org, AJvYcCUtnOXDZz61yt+zm7NZncpNUCXAqGB6q4QkiWKfUDhj+e31EGMmxvnE2GV/Oeewy85HVqPkFPTIiR+U6g==@vger.kernel.org, AJvYcCVp8xFG1Xph0KqrZl57CeZ2P7c3rxF+yOr2H+ObxZLXt5kXaz/D7Cnz+IK+EokADr1/IsLfiN6E@vger.kernel.org, AJvYcCVu3hKvcY3/wvIs77B0e/6lEDZz25fRXDSn3TSPS22xxyWJeuJsDzr3ySbH5TBzUaLQ94o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8hjTxESt/q/5nxJ8YlEDmnDATXEejeSY+dxEEC5Syjr1RCW4x
	GsuQ37jks4BZLEzwy0JXn16QCAcGXTcfFdLZwVc3S+o6+/Q4oDg4TQZX
X-Gm-Gg: ASbGnctBVjOAd0ji2xJs5HtWG5yO4102arSzW8SIUs8RB8a0FrCKicv6pis9lzHO410
	rbxfIVbikKkW+X1wlkAIaPR2e5SBO5DhWxUmPP2s34HjYL//W1eY1yTJgcuJmFTQMWH3uZQmZJ7
	rsuJJLj/Osl/1y+fyTLpfGrBNJ2CpawjGU/HkvkMxagI2PES495yylmu2R/ZcWw6jVv3uMTmIVU
	eWQFzC1cCbivu8bp1d2grHXiKEoCZHGnW7o9Ned1+l/xQy6+OIPYz08qeMlPo7hvGgk5a79sHSc
	40JNq48P2G2ug2BrsXZgoKYzDX/7pjxleW+V9AamqPikvM3UazhKhiDsSCb1VPy42PpBsAV13j2
	lTooNX8z6rEokXI/e4k55y8d74qhTzpexKt8=
X-Google-Smtp-Source: AGHT+IEMHicGGzOV7QARfXRDayyJkBXpLEq9lHyvKxQ609TVgvsTQ+QeaMTZZwxl6gjtb3oKoyYgXw==
X-Received: by 2002:a05:600c:4513:b0:43c:ee3f:2c3 with SMTP id 5b1f17b1804b1-4587630a123mr108515205e9.7.1753780871722;
        Tue, 29 Jul 2025 02:21:11 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::26f? ([2620:10d:c092:600::1:72ea])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588e5b7722sm17504375e9.3.2025.07.29.02.21.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 02:21:11 -0700 (PDT)
Message-ID: <18eb9e6c-1d60-4db1-81e1-6bce22425afe@gmail.com>
Date: Tue, 29 Jul 2025 10:22:30 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm, page_pool: introduce a new page type for page pool
 in page type
To: Byungchul Park <byungchul@sk.com>
Cc: linux-mm@kvack.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel_team@skhynix.com, harry.yoo@oracle.com, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org,
 ziy@nvidia.com, ilias.apalodimas@linaro.org, willy@infradead.org,
 brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
 usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
 almasrymina@google.com, toke@redhat.com, bpf@vger.kernel.org,
 linux-rdma@vger.kernel.org
References: <20250728052742.81294-1-byungchul@sk.com>
 <fc1ed731-33f8-4754-949f-2c7e3ed76c7b@gmail.com>
 <20250729011941.GA74655@system.software.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250729011941.GA74655@system.software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/25 02:19, Byungchul Park wrote:
> On Mon, Jul 28, 2025 at 07:36:54PM +0100, Pavel Begunkov wrote:
>> On 7/28/25 06:27, Byungchul Park wrote:
>>> Changes from v1:
>>>        1. Rebase on linux-next.
>>
>> net-next is closed, looks like until August 11.
> 
> Worth noting, this is based on linux-next, not net-next :-)

It doesn't matter, you're still sending it to be merged into
the net tree. Please read

https://docs.kernel.org/process/maintainer-netdev.html

Especially the "git-trees-and-patch-flow" section.

-- 
Pavel Begunkov



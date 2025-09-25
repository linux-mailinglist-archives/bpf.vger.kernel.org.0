Return-Path: <bpf+bounces-69667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27623B9E26D
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 10:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E20053B476B
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 08:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4016279DB1;
	Thu, 25 Sep 2025 08:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHDiEPeN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BF9E55A
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 08:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758790658; cv=none; b=g9qj40/qRn/DZ20mDK2USfHGLJW9C/bIKtWJzqGnc32n0ZsJMv/o9hpmkaixwqrF/fOFnIcRt1yTc1abD3SAQejfdELgKvzy2njO+dR0G8TyKVt+C3whBWOMGs2WKUxVdHrh8brjfPQ2GcUiDeGGl5IMsYWLjfJRMbmslMLCUus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758790658; c=relaxed/simple;
	bh=QQ2vjrQn/Zieqm61suYuD8VfLZgZWU8v8LJfcKU4ZZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JTY6ZHg7jgnO+LpXKb1ziumrEx6adoGgnHXkoVRMNjQgW5HKT0YNVoXJjVUNjBWADdfzSk6kw4lZZP5cGDNydEtH2K98BUyL6iEGdQUWSa7C7pXxdV5ThtkTbIJ1ywzh1NGbUPDjOzv/obPM2EH3QAAw8XHbJTWMdqrFAmBiFMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHDiEPeN; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b2b8b6a1429so10165266b.1
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 01:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758790654; x=1759395454; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J1ieKdh8ZnL9X5ENVHhQYpO7ehaHx1VKRXFWr/P98Bs=;
        b=BHDiEPeNjx7s5Cw3qnHAcG0G2+VJpqG7zkFKViiXqASTpsPj9NnKR0r2JoUMFJ1n1E
         talS9PQKEpCbAx3F0qNbbK08xrzMYWixi9M9YKcwA/LlLnAgklC7o+koibOOz6yU42ha
         yKaVew5HXBImky6/Uwobgbqx5XY0fuyfHmwwuX8wczaNVCQR16x4w8DPRKH4g4uqGAFa
         HpmQuLV9NDczZDLsKs+ksFLI+uXPZiawxPV9mrJYC66J6iezcY2hOyh6i+4t7Rdagnqs
         aWXtfl4qcia0yL4pF+yVYw9cgKBh4g2573Dmv1MIGsZt+qsEqp2maXMiUxiyEc63Otpy
         6Xug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758790654; x=1759395454;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J1ieKdh8ZnL9X5ENVHhQYpO7ehaHx1VKRXFWr/P98Bs=;
        b=n3BR3eteN5JhEsM4IxOQfVN7OmH+CaJ6LdZyJ7zFmcjvwV6rM+k2PCP0vhKY/ZVORV
         Icbt8PrD2uiBcigzq+KBb9P3RUDW+Ah2H+wvfU5DbCdjr8BVSQyRaQA4LlY6fzZicSES
         5ayz7392OkQJM2KSldGpNk2uJQKNXRbE5MzUn+y30O13CQXfJgJvgHvHnmEitg11Dp4h
         sIjrq2HsLCzZYDbPhpULqqlh3k1/981i9+wbmIQn37939oM63HYAORHxI8zGjNMd0sHc
         zjxxHvlh1zSxpZpemY9BZRSKpz3wwD3Y5w1cbC+bohR93pqvSNyJg8+a+trc6RDmmYcT
         zZTg==
X-Forwarded-Encrypted: i=1; AJvYcCXqfRAaub0kGgQFYMasN+wpduxiYFQt4JsfYQvH8DxfDCgAwp5bn4xrExRziBVXyUc7+3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyomZniff/GF+93iH8fG7zESrgAYmYZbL3/2PI+Z4sJcjnH1vAM
	/LB0dIIQzaSrTf1yaJzN8n88v753BcemI1/lArZMb+GlW/Be3u83To0R
X-Gm-Gg: ASbGncs4n1HkfWYOuo8W1AJYm6O0PO8oYzBAj8984Iq82O8jesqS7/vjsTTqvESkFyg
	GFZKNb/5CM/uZuO+VAFd/tM0R10cbosgQHTYlQFjfwgZ7QV7Y54bCKq5dXVYZlKgczYDgegwEV+
	XgmSMUsl7/z1xZyYr6Ay5NrhdtCJqvE5APfFPxSWEDOMrWYuLqwBMmPc6jP5nUhq5G2XPM8Prkf
	dGaQQyHxEuXaXTJI0teF8c66VmM2y98fDVnQ+Z7ZwTYhOKZfZbbG9YjMGNWctp7QpKzlhW0iryj
	AaRRYgF1qzspoaaZb2WVP+dIKpSDci7gOTaBUfJOxEnLrcBBB6te4P3gtu9NZ+QdAAd15OM0o9N
	zUNL8x2u4aHksEsfiosOdOMRZieEOXTHW9oy7YqfcLqU=
X-Google-Smtp-Source: AGHT+IHgxhg/8L0HWZrIRreMxlREkgm0qw2qxTqKaDyvZUongIqmZ+eF5XRwzrB4DjOfUfKpvkk3Ig==
X-Received: by 2002:a17:906:f599:b0:b0c:ac7d:474f with SMTP id a640c23a62f3a-b34bfe4619bmr131647766b.10.1758790653822;
        Thu, 25 Sep 2025 01:57:33 -0700 (PDT)
Received: from [192.168.1.105] ([165.50.112.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353efb8903sm123418466b.33.2025.09.25.01.57.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 01:57:33 -0700 (PDT)
Message-ID: <9773fb16-d497-4d67-804d-0c6e70def886@gmail.com>
Date: Thu, 25 Sep 2025 10:57:30 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/4] Add XDP RX queue index metadata via kfuncs
To: Stanislav Fomichev <stfomichev@gmail.com>, lorenzo@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, donald.hunter@gmail.com, andrew+netdev@lunn.ch,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, matttbe@kernel.org, chuck.lever@oracle.com,
 jdamato@fastly.com, skhawaja@google.com, dw@davidwei.uk,
 mkarsten@uwaterloo.ca, yoong.siang.song@intel.com,
 david.hunter.linux@gmail.com, skhan@linuxfoundation.org, horms@kernel.org,
 sdf@fomichev.me, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
References: <20250923210026.3870-1-mehdi.benhadjkhelifa@gmail.com>
 <aNMG2X2GLDLBIjzB@mini-arch> <f103da72-0973-4a45-af81-ec1537422433@gmail.com>
 <aNRxRRSfjOzSPNks@mini-arch>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <aNRxRRSfjOzSPNks@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/25 11:31 PM, Stanislav Fomichev wrote:
> On 09/24, Mehdi Ben Hadj Khelifa wrote:
>> On 9/23/25 9:45 PM, Stanislav Fomichev wrote:
>>> On 09/23, Mehdi Ben Hadj Khelifa wrote:
>>>> ---
>>>> Mehdi Ben Hadj Khelifa (4):
>>>>     netlink: specs: Add XDP RX queue index to XDP metadata
>>>>     net: xdp: Add xmo_rx_queue_index callback
>>>>     uapi: netdev: Add XDP RX queue index metadata flags
>>>>     net: veth: Implement RX queue index XDP hint
>>>>
>>>>    Documentation/netlink/specs/netdev.yaml |  5 +++++
>>>>    drivers/net/veth.c                      | 12 ++++++++++++
>>>>    include/net/xdp.h                       |  5 +++++
>>>>    include/uapi/linux/netdev.h             |  3 +++
>>>>    net/core/xdp.c                          | 15 +++++++++++++++
>>>>    tools/include/uapi/linux/netdev.h       |  3 +++
>>>>    6 files changed, 43 insertions(+)
>>>>    ---
>>>>    base-commit: 07e27ad16399afcd693be20211b0dfae63e0615f
>>>>    this is the commit of tag: v6.17-rc7 on the mainline.
>>>>    This patch series is intended to make a base for setting
>>>>    queue_index in the xdp_rxq_info struct in bpf/cpumap.c to
>>>>    the right index. Although that part I still didn't figure
>>>>    out yet,I m searching for my guidance to do that as well
>>>>    as for the correctness of the patches in this series.
>>
>>>
> I don't really understand what queue_index means for the cpu map. It is
> a kernel thread doing work, there is no queue. Maybe whoever added
> the todo can clarify?

Hi Lorenzo,
Can you help us clarify the todo added in cpu_map_bpf_prog_run_xdp() in 
this commit: 
github.com/torvalds/linux/commit/9216477449f33cdbc9c9a99d49f500b7fbb81702 ?

Regards,
Mehdi


Return-Path: <bpf+bounces-39809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C06C1977C02
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 11:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82015288676
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 09:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036201D6DD5;
	Fri, 13 Sep 2024 09:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="hcW6oCG7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754D7187350
	for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 09:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726218938; cv=none; b=dl/xZL0mgmtcv5QuWSLcK0fIU+oOYwpYsD/J4lkhcyzAhFtTzKK1mX8CQ96xxlrsPN0PgyeBcHKgCjjSFHS7VGzc2dLZAyusLz1gS8m3Kkyguh76FQ/yktC5pBxedJVycXNC0+2+PvO8Kq8hsdAUG78PSQNwpKCu3EfQptNT6eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726218938; c=relaxed/simple;
	bh=yjxj0FSJpzDqTDqbkb+Ys5lDxT533fcsCSKxOxLDXqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=czNilRDgTFjEKZcI4ETJB5mb7c6LxmMQbVa3LzjeSuCwcOIi8WkU5MiLuJsVoS0+NDBptgYyGXnbNI4AEWuEdshkwWG7aTK7u1WTNWUpTi1uoDCgPwouhNkiH1K+kEK2bFZ2Efj2pAS0TynaJmy8rkIK6GmyKR2l0ciCKnDMNrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=hcW6oCG7; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c255e3c327so2239337a12.1
        for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 02:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1726218935; x=1726823735; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zP7o2lXiLqDCW/l4Y6N12juw+Nevs/iHS84Bz9Lspa0=;
        b=hcW6oCG7UsWg8lqj1SfpbfEYgFYHzvc8MRSQFB/afVCmLbLYKL3MiCqkl0d2emVWYd
         nvRqV4ojd/+Jau6JFuxvGJQ/zAcn/TBhb30ud/kQU0eMb7Syuge/REB/v+24vztNWFQf
         oPaCyMD344Upcg6J8Hz/T0hGkfk0G423DJ6z3OEjZkU+UGNtPTgX8MxtjITkyWu8OByq
         ZJSitXmGPA08O1Z+lpNt3Qfkew2x93D1PmszK16drxktOqGBp3kKx4CzlqY/3o44X35c
         deotYhfUvTwHgmYn3VNqPtXGtRdfKuFoA6b/7OJ1O/aWJcJRNKrPSx1mVk/UtVnhEOF2
         eB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726218935; x=1726823735;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zP7o2lXiLqDCW/l4Y6N12juw+Nevs/iHS84Bz9Lspa0=;
        b=IxWFIz5AeeA53bmVNStcFGD075BdTifQxty9sR0RrP4CQT9M7x1+s4hjepUz87Uqx6
         O3jrL1xoA1qQgztu7/IBBjh11FRz+NdwsoYVXVx7spxOJqB8RuAb4gJlwBnPOu70GYpw
         gamddd1xTjx//S34S9fPGB6OunypZpu7hDgGMEdpbYxMxeCVulPzExlzLNIooVI+EB6p
         hzl2yR2Kn2y96tdU7pqgIduTeelISqgUvpFTzT5ieG0TLragPRF2VCRp1kHetd43Tk3Z
         sglUnZyIutgc6DLC94Y1ByDZD+ThUyiulgXW0p7E1Z7KyRbLaV+ojYYR7yheuuTF0teQ
         7izQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFtODDvV1bBT5xIQdH5psD8vDZEkJnpn9v/QrCZKS+le9xkgSBYF2O0fxfrroUzCQzJe4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1onVIarbZ12ifGzciZBy6pNv+AllZ77yCQ5Vk0q6INIAJjGze
	IT+GXYhqfRenueYMUO1aKrm6ft9oTkNXrq+8RHTMKD5egSMxL8nMpLJin2GeT/U=
X-Google-Smtp-Source: AGHT+IFVFni4KQY31tZpsekaGm1UaBb7ZpdiuaYbjs6baOy/7SSOoWK2lsopYFzaF0hFcAvrJOrKow==
X-Received: by 2002:a17:907:3e1d:b0:a83:8591:7505 with SMTP id a640c23a62f3a-a902966f459mr584642266b.59.1726218933949;
        Fri, 13 Sep 2024 02:15:33 -0700 (PDT)
Received: from [192.168.0.148] ([93.93.8.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c72e9asm849536866b.115.2024.09.13.02.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2024 02:15:33 -0700 (PDT)
Message-ID: <8cf0b25f-2b7f-478e-af14-b0ebd5905a79@blackwall.org>
Date: Fri, 13 Sep 2024 12:15:30 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] netkit: Assign missing bpf_net_context
To: Breno Leitao <leitao@debian.org>, kuba@kernel.org, bpf@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: vadim.fedorenko@linux.dev, andrii@kernel.org,
 "open list:BPF [NETKIT] (BPF-programmable network device)"
 <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20240912155620.1334587-1-leitao@debian.org>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240912155620.1334587-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/24 18:56, Breno Leitao wrote:
> During the introduction of struct bpf_net_context handling for
> XDP-redirect, the netkit driver has been missed, which also requires it
> because NETKIT_REDIRECT invokes skb_do_redirect() which is accessing the
> per-CPU variables. Otherwise we see the following crash:
> 
> 	BUG: kernel NULL pointer dereference, address: 0000000000000038
> 	bpf_redirect()
> 	netkit_xmit()
> 	dev_hard_start_xmit()
> 
> Set the bpf_net_context before invoking netkit_xmit() program within the
> netkit driver.
> 
> Fixes: 401cb7dae813 ("net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.")
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/net/netkit.c | 3 +++
>  1 file changed, 3 insertions(+)
> 


Acked-by: Nikolay Aleksandrov <razor@blackwall.org>




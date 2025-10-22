Return-Path: <bpf+bounces-71723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FB5BFC22B
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 15:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C568568C53
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 13:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF1034677B;
	Wed, 22 Oct 2025 13:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="KuoOIIWv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A465026ED3F
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 13:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761138799; cv=none; b=ZI8bYB3eg20XWjTC9N6kClDBCwUz4B6BI1fzfGg1ilpx2FyHmbAIgrkyHeksdTLa2rUgTZ0sJwuuYvheo0DppIzE9Xs2mQbpKtqXkk2yaEoJMH6098o7IWFZ+U48YdmjJneWQRtLfCldYu4gRh+vVZ9rSJVinB83KKOUcteIJ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761138799; c=relaxed/simple;
	bh=dV2v2nvJt4bSpXkLdGKI5N/kiZYlj5EWvCVnEaOV3U0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BuZYI+HyshpAdxmgYSJoZz+C+lmd7LW7JFbHdWkhpSXRzc+Wh4EBU6UMUCjPOaiVdWGh2haiVA0wTBfKWgYwB7RE+XDIWDnFPbYECKFBAWHpmr+pR9AXnh/xGOcI23caBMsWFyRKuqI6v3b7exQG6KUbUBRaXdW0wSIUWIx/q2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=KuoOIIWv; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63c4b41b38cso9926079a12.3
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 06:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1761138796; x=1761743596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A3FWtSfsXNEHVOfUrJKgEy3Vxzr+aNYEbiBsxgJNPt0=;
        b=KuoOIIWvBVloosX61y/tT4HFAJeV/QNXKfBvmszEV2EOUWY3ZI/8JLPTIN5h9RkefM
         obEMFGiQ2dMm898NtWS68zunhl3l69uW5GZDjvPlEveNzDHVF1kp6q0ymXx1lMDHwxMJ
         3qbKcjB2qZBVNnYGLKwGtVKa6+hDnFE1OPxPNJcgHX0no74fo3sljqFJyACyRsSnSHTQ
         Zmn99/3rZliZhIdAG0bd9xWjIQEj5QTeh3lfBS+ZgfNxHcSjXXIjMvOby/FLw+SwslPr
         eUgQv+0BMcSYmAIatSHiyez46yoY6sRnsPYEiKBD3A9W/AlsJACbjyYUQpyi50Tzu2IN
         AWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761138796; x=1761743596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A3FWtSfsXNEHVOfUrJKgEy3Vxzr+aNYEbiBsxgJNPt0=;
        b=eP0zq49Lk+G73mE/8s1zSih0adE9DvFELZdkvjlEgdMhS9h50QXCLeAa97pk0yomgn
         OhTwtjamqEodoT9fGFUWKIFgNASygGgg3cID0u6kbEYivkEFxpgMjboVTsnSGr72C0VZ
         Ap92AQ3UrAX6MEofVb64g0ctkRAY3dP4LAr7VBXoMK2inrpwf7vEIbNdzxSjw9o/qzGd
         +IDOZf9pQ96c1bqbAdZqydhcLw7aIto50p3HrPg0dP6jbjAHDtZwU2qSttaPUuJKKp20
         CiNk+ZnvT60wn6CVv8Keg+qu83WCpwLCtEvZNavQFIHWeiUbjBF7Aju3/sadguifLASl
         6czg==
X-Gm-Message-State: AOJu0Yx507Z0N1kRKZbXKzqh8j7kTvwBaPimPTbA6mnwkqHFtKnfVnKX
	iuvRpalPwB8NdK4M+M9DVI3InqxNdD1zTg/SDmaB3RgW7cLBTV5EK8Nm5tX/JQp8JD0=
X-Gm-Gg: ASbGncsYdb0kYyFD+1vfzzSESQJZB0sktm1ZsL+3Y6TgWfcfwEyJdMgyIUqNAb2nYgE
	7WKwzmV9Rw2XBR4TaukyqrJVYVOFYpNUVUOUku9xzileihAbyxho6qfc1si0lnzMiqCbRRuDC3l
	5ZeFlKM1RY9N8z1CNSTXxshodMIU/RER+drw1zYYMIoLkThNBc+fcxQjKqmOlWfMYitBUomYV+o
	OvH5Lcu/4oUkGer6ynZxGAnJG4ms3fm11FehPN+CZeM6WyNcUJO6g9Hn117YcwVfCaycHaHNjwL
	glq8iRcJ2Yf4RpeTB+3CmVnUQxndzo59yAphWNgzyPVmD0nm8epFrYRmTw+CGHxFK/jteCgbsKH
	91t12HFQk940zJBbqJKdSu6BufVw7rC6+17LlVOqVZ1K7djk34DQXiXb3iKnRFfupfgnDoc1d/G
	SqBSHm9az3wR/AuWx8NjI9ipbjmYy7Bna2s0Q49n9pggU=
X-Google-Smtp-Source: AGHT+IG7FlwpPgSQtYI7TuWDw1QmT9WYfpFdEVXKrwbg6V8/HarkHMVbTdIi7OP1z1qmm0bMiWOHhw==
X-Received: by 2002:a05:6402:5204:b0:626:4774:2420 with SMTP id 4fb4d7f45d1cf-63c1f6b53bcmr21739139a12.20.1761138795365;
        Wed, 22 Oct 2025 06:13:15 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c4949bf40sm12310240a12.39.2025.10.22.06.13.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 06:13:14 -0700 (PDT)
Message-ID: <6571a7f3-3900-44c9-8dcc-a7f3f34a888d@blackwall.org>
Date: Wed, 22 Oct 2025 16:13:13 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 11/15] netkit: Add single device mode for
 netkit
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20251020162355.136118-1-daniel@iogearbox.net>
 <20251020162355.136118-12-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20251020162355.136118-12-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 19:23, Daniel Borkmann wrote:
> Add a single device mode for netkit instead of netkit pairs. The primary
> target for the paired devices is to connect network namespaces, of course,
> and support has been implemented in projects like Cilium [0]. For the rxq
> binding the plan is to support two main scenarios related to single device
> mode:
> 
> * For the use-case of io_uring zero-copy, the control plane can either
>   set up a netkit pair where the peer device can perform rxq binding which
>   is then tied to the lifetime of the peer device, or the control plane
>   can use a regular netkit pair to connect the hostns to a Pod/container
>   and dynamically add/remove rxq bindings through a single device without
>   having to interrupt the device pair. In the case of io_uring, the memory
>   pool is used as skb non-linear pages, and thus the skb will go its way
>   through the regular stack into netkit. Things like the netkit policy when
>   no BPF is attached or skb scrubbing etc apply as-is in case the paired
>   devices are used, or if the backend memory is tied to the single device
>   and traffic goes through a paired device.
> 
> * For the use-case of AF_XDP, the control plane needs to use netkit in the
>   single device mode. The single device mode currently enforces only a
>   pass policy when no BPF is attached, and does not yet support BPF link
>   attachments for AF_XDP. skbs sent to that device get dropped at the
>   moment. Given AF_XDP operates at a lower layer of the stack tying this
>   to the netkit pair did not make sense. In future, the plan is to allow
>   BPF at the XDP layer which can: i) process traffic coming from the AF_XDP
>   application (e.g. QEMU with AF_XDP backend) to filter egress traffic or
>   to push selected egress traffic up to the single netkit device to the
>   local stack (e.g. DHCP requests), and ii) vice-versa skbs sent to the
>   single netkit into the AF_XDP application (e.g. DHCP replies). Also,
>   the control-plane can dynamically add/remove rxq bindings for the single
>   netkit device without having to interrupt (e.g. down/up cycle) the main
>   netkit pair for the Pod which has traffic going in and out.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>
> Reviewed-by: Jordan Rife <jordan@jrife.io>
> Link: https://docs.cilium.io/en/stable/operations/performance/tuning/#netkit-device-mode [0]
> ---
>  drivers/net/netkit.c         | 108 ++++++++++++++++++++++-------------
>  include/uapi/linux/if_link.h |   6 ++
>  2 files changed, 74 insertions(+), 40 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>



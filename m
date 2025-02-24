Return-Path: <bpf+bounces-52320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4E3A417D7
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 09:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BCF43A9CB8
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 08:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA6F242921;
	Mon, 24 Feb 2025 08:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="KgND/+Wf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81AB191F6D
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 08:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740387123; cv=none; b=prmUjmYN8e+tvJhBjRDrVNIWydgJ5mmZvXXH55W282AMhJizy9xE3fQ81mT2CYYUAO1zA6+yt0HKXqZZ5zn9EJ6WUl65QdUWN7XnPYym+N9ECc9+fgZo08y89xLwDthrcEdWrjUdwzfY1Wu6beKiaRFnzxWN7JUs9ABHvflFb/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740387123; c=relaxed/simple;
	bh=pkdfPmCYAq3VC0rhQCYyhBsC4VR5agaZCaHtCb+cRMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k0ZaqwSaxK4djwKWHsYqHKBkgqvBqdCKL+T+2pIRkRYZ3R6LTOcMRKotlPLLWDNicsFJ3RdQtyqpW1B9BQDk1OjYPXzEqnE4oHUZICZXP3o7dV5XaLnJy/6IiyzS/UCHVUPdDS9xd8+ufy+EWu6mssVVyORTebYT4QCP8P0NTOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=KgND/+Wf; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5df07041c24so6061396a12.0
        for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 00:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1740387120; x=1740991920; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HiYwi2yJiNX3i+6bGDvfot/+FNcFNjigij1gpeIwEWs=;
        b=KgND/+WfEavhjmIzwOMSWUeDVOzW9aj+iO/cx+ZKnx1XqL2yJOrguINkjsatRXKLJQ
         V4M+s0JBJddiw62Ou4gFgzLF3xxr8yp7tsq9Yh6nVuV2unHWYnUWF/AEuziNmChVcQWf
         BjZ5WPpQcL7MF6ABCQE3kWKHLmqdDiP49EBqZm7o5Q0pCHSoJtnquHvcE2sHX9yooisS
         yRpGh3UGayA6A6CZu0/3kgPhkWDmw9vTF5j3l4TXas/ClrL0PL2/KyMQFZrQ+YjBMqbv
         379m6H5GF5JVXynzYzedQWiV3zDZ05fG4eAjrnWmlaa4gALv8GwEr7qxY2q0FH9aO1fm
         WaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740387120; x=1740991920;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HiYwi2yJiNX3i+6bGDvfot/+FNcFNjigij1gpeIwEWs=;
        b=Jsy85FoX1BkLCkctTY45DsegHAJDpucbOZIsYJ8idtJFnhuYTUxllkjO7WXv5GVZcY
         oUcx1kXxHmo8a0Bq96cxMihFSEF4JUMQMoshsR0CfgJqu3ZTocc8NkuaBlhya7DpNrkl
         tq9UAC6dZ7xbhuFwmrFGkYRInKeGyCqXUta5JYswM8iNrwwsxpxtEn0ZDhbZA3H44Y44
         CREjkSqJn4u6PlpgQVODgMxeUwmBPli2riXFhuNED6O0pKTifbI040tGxWxTm3UTKzto
         S8nf9sUWtqLIOLCdMD0gt0voABqlQc9pr6U0mlBCMYJ+Jy7ibMzDv/dvqdVi9vnitFXt
         f3aQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJyhSW1gyYc3Eyi62eD/NApafn/dxqolHlnRAk6cQ9v0s9G+1YTu4LgAbX7XPC85QDioE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcZatTSUaEZRvIsbfnuCdnsrNBECo+HECbfr8005g3OMCN6/yn
	YPfzeKwfCmavizf6k0yPDPRbc1uaTF44cbOmgjKGOhnVd/OHgFRj0MURqDnvZwQ=
X-Gm-Gg: ASbGncsZ28990Eo4ffKyprQiGxSFfrWBrHR4LDTXI2fdho4DgE9ynR4xeSG9DH1ogXi
	yvhCdmjqDWVE5Ty8bqx1WEKMLV/6S8fuHVAx5nIuSRg8LqzBS11aXaPROsgyBnUKTcoIUFaV/PK
	YUb6qwsgfDp+iWOxNfFhurqLH/bu/09Qo5qFVhhfPRnEfoO7fwoPeX8ghUv9Qdp79sjWvFaupTN
	ZIHIlOJ2hjqe5HtK4iUuRey4ZjhFBYHH+sPv6N1bxt+mQPqPBzIbZZ0NsTOjiUk8qC6g9hHOvgB
	F9yhYofyLSyjdyUYPdlNa2QNe+SzaUDFJw69NvxOnH+AOiHXtfDlqVKwww==
X-Google-Smtp-Source: AGHT+IGB5JtdKPIVEJen3huIhdkjoaMsrv9/7uYlnptP+1yU8h9J88izDwTob+eD7q+JsIXXYdgtRQ==
X-Received: by 2002:a05:6402:40c6:b0:5df:a651:32ef with SMTP id 4fb4d7f45d1cf-5e0b7231cadmr11994412a12.27.1740387119650;
        Mon, 24 Feb 2025 00:51:59 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1b4e8dsm17898788a12.14.2025.02.24.00.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 00:51:58 -0800 (PST)
Message-ID: <1cb55499-f560-4296-a44c-e5af7a3d1758@blackwall.org>
Date: Mon, 24 Feb 2025 10:51:57 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2] ip: link: netkit: Support scrub options
To: Jordan Rife <jordan@jrife.io>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, stephen@networkplumber.org,
 dsahern@kernel.org
References: <20250222204151.1145706-1-jordan@jrife.io>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250222204151.1145706-1-jordan@jrife.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/22/25 22:41, Jordan Rife wrote:
> Add "scrub" option to configure IFLA_NETKIT_SCRUB and
> IFLA_NETKIT_PEER_SCRUB when setting up a link. Add "scrub" and
> "peer scrub" to device details as well when printing.
> 
> $ sudo ./ip/ip link add jordan type netkit scrub default peer scrub none
> $ ./ip/ip -details link show jordan
> 43: jordan@nk0: <BROADCAST,MULTICAST,NOARP,M-DOWN> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>     link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff promiscuity 0 allmulti 0 minmtu 68 maxmtu 65535
>     netkit mode l3 type primary policy forward peer policy forward scrub default peer scrub none numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size 524280 tso_max_segs 65535 gro_max_size 65536 gso_ipv4_max_size 65536 gro_ipv4_max_size 65536
> 
> Link: https://lore.kernel.org/netdev/20241004101335.117711-1-daniel@iogearbox.net/
> 
> Signed-off-by: Jordan Rife <jordan@jrife.io>
> ---
>  ip/iplink_netkit.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)
> 

Patch looks good to me, since this is a new feature perhaps it should
target iproute2-next. Thanks!

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



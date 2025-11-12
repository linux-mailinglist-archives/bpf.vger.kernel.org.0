Return-Path: <bpf+bounces-74287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9608C51FFA
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 12:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87272189441D
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 11:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2360A30E854;
	Wed, 12 Nov 2025 11:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InzW8DU0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5932D8DB1
	for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 11:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946891; cv=none; b=HM5+vduMay8iJ0vCe+JJ6ptn/3MPnblZB3IozGXc1x0MYyK22TK4e4Hjeog0oXesvNvnso+vbNu6ygbcqN0+ulKGXcSPUIUHSQXgRslRiKU6Ywpo71iJBKXWdtQX8gD6BeqJkH6rS11Ab+rsgckLVF+KAu47+zsl5x1+QssJRkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946891; c=relaxed/simple;
	bh=3yZy0mK7fi7h6dEgV7OqbQEEpOmuSBi+BOgpbLpu8Xo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dChLA3tP54STOHI+HuEsv9GonQRAaVoBDIt9DYTHvOcqAqaGymYwRG6966GqJ65iMnwrdoiAGVDCmycyfRm3hqfhib0dyHMd0SvnOU4ehPHHQrPba7rkPcfnusVGb3/d9OH/VkmPndBuXVGsiyw1t8DyBYpRE7CAhejP1yqHtuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InzW8DU0; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47789cd2083so2562845e9.2
        for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 03:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762946888; x=1763551688; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mmJ4jMrcViTktpRfcYtKz9oOeK7QX8lRd9IhgtDkEoo=;
        b=InzW8DU0QLvbnIx8lXgh/SZICb/2z8/shpDpoGlryNAdfLGQzNTchwxoIYyC9Eg+j8
         pk3+L/VUHgj8uz038kRnt/S0jKoE9PxNvpMegevwR52xijYY1ugkbo+s6uGygHrGgGSR
         wKWBa+o4JUqPOyk7MqM67EHj7Oxa1vDTF64X63A2sJkybiQ9lzRbx902Lyq7NUdZMa1r
         MK35WZ3ur901ELRLoepo+yDIatToXYLansuulph6pPIxm2R0dZ5n2c3e6F7vbQzlu30D
         j8Q+ZXSl226LpaNjVLkaf5e/Ao/p5F3Siup7e5KZseh/3MM5t6jnDOUg4KVOARtDWSji
         HueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762946888; x=1763551688;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mmJ4jMrcViTktpRfcYtKz9oOeK7QX8lRd9IhgtDkEoo=;
        b=aZ5lhLr4hThu1rRQUKpd4MExxN5ZbQ8B6oIsEuW9fZhKyeI5wTClHKFHsPoGW3HpkI
         DCL/otjqXiz488XlNeV1tm/JTE0gt9qL1tyrTLcSHfjlnt1s5vHN1dpfKIhs8s66Vq17
         v2vOahmdB0FPNKKS7lNqI0/vsIZAFf27sNTjIHnSa+3OYJ/RXWK8KzgeD1vIZKq7PH4H
         NydC/kStmfZNltGCCSxo3A7/60zGdr26HAeWd7mrlGtqvhgcBafsdarx73ZBO71csJx1
         Z6zMymptUL0pvo16EeUdTZgk0GehhgEKukbEP0bo0RMlfUEjSY94kpN6QnCP8y25Hrol
         LXeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwY7WStU0udNh3qZvxZ0eGPXC3DptgggUKJs4YNI5DzycxZDOiwmsGIADtuKs+cianOlw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+mEhqwg4XQSvCrGYwMD/VpVAECS7pevhcYERCt15xjwU45rxL
	52A9SPncYRabN0oF6PWZFVn+ccV36HMRD/59dTa4a4p11svuGq/K1m1M
X-Gm-Gg: ASbGncs3/tkJQ1whUAO97t13IfxxFE+Ls/vNYc4i2cua3/VVvd5wyYFNeV+MWK/FZNN
	HrBLjipuP4/nqNbZVU1aZC/vIoxbyMMPuMJqm6ppupDq+8WhZ/i+X3lthriR9pyHjoRuyZp8mR5
	5aJOsXE6ccTvm6yiubybLsLPdCQTneZs0fmzUTJ7U9KBNUJ26GO1tctfNby4Fn/4GtihSs0umlF
	ridchjQBT4qF/7r42Fhb3jXDZX5INVSUedUcWs9ImZBDzONBmnX9DOUJUiuyVqmgTl+/iT3XF+T
	MgRpByj7O7au76eOcGNiVHN4LQ7dECA8NH36YpwSeryBhZUE+xkkvD+C5IjdhWknAQGCqB1ydhq
	q5xF2J1YIRJ8N65foNYNvUMPCIUfSJH0P2r5nr4Qmlz8S5LT4D32cMLI1TyYcJ589hPNaagxQzl
	JKkd+ijvZOX5dOGKcGjdH28Z4=
X-Google-Smtp-Source: AGHT+IHUkDj9skJWx5O8Mgj0/LeNZAj9+4nbV8r5lwtFtUHPHAFFww+gS/qpBq+lZu7XXIyqqV4v1w==
X-Received: by 2002:a05:600c:4fd3:b0:46e:37a7:48d1 with SMTP id 5b1f17b1804b1-477871c588emr26721795e9.34.1762946887589;
        Wed, 12 Nov 2025 03:28:07 -0800 (PST)
Received: from [10.125.200.88] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787ea39ccsm29171795e9.15.2025.11.12.03.28.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 03:28:07 -0800 (PST)
Message-ID: <893e8d23-121b-43ef-90a9-370a745d4341@gmail.com>
Date: Wed, 12 Nov 2025 13:28:05 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 6/6] net/mlx5e: Support XDP target xmit with
 dummy program
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
 William Tu <witu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Nimrod Oren <noren@nvidia.com>, Alex Lazar <alazar@nvidia.com>
References: <1762939749-1165658-1-git-send-email-tariqt@nvidia.com>
 <1762939749-1165658-7-git-send-email-tariqt@nvidia.com>
 <877bvvlf19.fsf@toke.dk>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <877bvvlf19.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/11/2025 12:29, Toke Høiland-Jørgensen wrote:
> Tariq Toukan <tariqt@nvidia.com> writes:
> 
>> Save per-channel resources in default.
>>
>> As no better API exist, make the XDP-redirect-target SQ available by
>> loading a dummy XDP program.
> 
> This is a user-visible change, though, no? I.e., after this patch
> xdp_redirect mlx5 devices will no longer work as an xdp_redirect target
> out of the box?
> 

Right, we introduce an explicit behavior change here.
Due to the lack of a standard control, we're aligning to other drivers 
and use the dummy program trick.
Having the feature always on by default wastes HW and SW resources for 
users who are not interested in the feature (and cannot explicitly 
disable it), in addition to the significant extra latency it adds in 
configuration flow.

> We have userspace code listing the driver support in various places
> (e.g., here in xdp-tools:
> https://github.com/xdp-project/xdp-tools/commit/1dad1d6e0ccb086b8a31496931f21a165b42b700);
> I'm sure there will be other places. Since such code would up until now
> assume that mlx5 just works, this will end up being a regression in such
> cases, no?
> 
> -Toke
> 
> 

Yes, it is indeed a change in behavior.
Now the feature can be turned off, and actually defaults to off.
Now we should add "mlx5" to this list driver_pass_list[].


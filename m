Return-Path: <bpf+bounces-79468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F01DD3ABFE
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 15:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 50833304AC01
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 14:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B2738B98D;
	Mon, 19 Jan 2026 14:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="B9lrKQn9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E9E38B7D2
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 14:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832708; cv=none; b=EUopnXmywAQj4m+38qc/LUbqdPM43ZL8VOsWt29hGoAOvR2816BKm2HUcUbYu9Kmmm0nA71gIhwWMh0pOjNjx5aRm7Ye0t40hyE6NSiQNQ+8j0adzNg702Cdzfr1gu6PWdOgloec3vHOdPGTPVzVfJwcOBfkIbdBGjggLDVUpUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832708; c=relaxed/simple;
	bh=zwn3NR3J76TNO7a5x3I5mEraNJ6xIEdCoJx1uNDC8OI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Adnz8A+9WAxutEqW8r+2QF/JVg9zzr7lVs/HR+dKTNmS5jvjbWTmUFrX66W66HO5DSLeXkWjYUM16Gd2DgWSoSQMvG12u1IlKjXwk893V0O2+kSWDi1om8F3WCD795SzvRJuR2LtWVfljfhZpXVM0PtkAkS3wEOphjGDFFcjO2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=B9lrKQn9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47ee0291921so28749705e9.3
        for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 06:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1768832705; x=1769437505; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AfcTc9w2PtOaWI0cIvYy3fPlc4TK1Uxl3CmpJHp7XX0=;
        b=B9lrKQn9IdAzZq9UITfqjDk2rBdzmLM7EEvRHZoPzTZ8k2Bd2tCqeRmJwPaNZLBxKt
         OvZH/Zp5v/h7yhdXn8uO6ISIihAmvgBbOMzdjxmVZe6oZGVIGt+Bcn9cHfMXLbSupIX5
         ZKCq4LNFFTjP17xf3IoV3Ggehnt3YRJ6adxm9B+VisbWI2tj5kpQMj/9gK/jrXS+XoL9
         3ZYtb4A2okdpgxX76mSxAa2msaPp6+5sNBUodG53QKOmQKsAYYZHBD/MNpLraHa6QAfM
         RgP5uJ16iM5H95gofugRxj/PhPPPZ2ykbJIsPwksWKfDM9VN8d12VJibWk5+RH5MBil+
         L7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768832705; x=1769437505;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AfcTc9w2PtOaWI0cIvYy3fPlc4TK1Uxl3CmpJHp7XX0=;
        b=rwTPNMKX+lf58blIPfADbERCLg4+GiWH6FZpdAEBpcJgk5bu3rGVFQGMDfeIbsaeuw
         2h9xIMZF5ZxgA8xyCDajDKUWFyiREdSgD9bSFn7RhvaioFOc42bkXZ2Obfh+Oa4nnfQX
         2617PB8fGq5ca39fzxk5oV0pDtuqJHQ6asQcduIB5Uvkdim/0Wt5lTtC7P0cIGxptjSd
         CYgjDg1AKcrBxs0RI1aMInl3snLTt7ZzUw1aiBx3p3aDYZbyR8egz1mPCmyU2nnCxvd1
         O1Q35IQCggUxXkusLDwayfhLw6AIr4NwHGOiWfN27cValBCKvTmVKskkQ66KyznClsNm
         VnUQ==
X-Gm-Message-State: AOJu0Yxbwt5wX7Vghp24FLVojI39c7dW4HVgtvlbIdIciqYLLdb7AfzB
	qLNK5P8PRO9prBlUz+/vlyIJe3HZSSTlFX+ROCr/M1yS0XOCWQoPD68wkkBnIXK5svo=
X-Gm-Gg: AY/fxX6N24kehyeN9y9sEzAij8Uky3K+iHqW+IOjqj7qHboD8rdFDRKeHGZHdMVcJqT
	2Obi7mXdEdPMzfb0aqg0/wdbypbeUOvHSsD2yPz/McmaFtRy0ggtwdGWG07R1UicvNUkjSEy/tT
	QDNvUd6OP5cYdUNqA+MfLmLQhzY4ANm751llTdMsw8tVv0eKQDPk1StJcu52hSgdSC+Tce1RlG/
	eIA26OSOUN2M4noY683XMjyTSmY1Zfjr9pmGrdv/zVf5attHrOb3gdwxS43O4/699HxzapTs0oI
	FJoLSwatnK5R68jZEmJww49+uTLMZwH59gcrx5ERYkR50p7VvYjbbC8BR3JYwSmxXUVbUuqDucr
	Wi9l6I09phDpFqN9pSU9NZknAWBqF1BE846kbYuRdbANCs1U9JuJk7jsUnuhWcxvjCHx7jGmIPI
	CkZHEn84lIiG6YfsqWS+zJjjWCZzUIKsClAuFigdkdWOVkCPoe6/zbp1J3Faf9nglCn2k6TQ==
X-Received: by 2002:a05:600c:37cf:b0:471:1765:839c with SMTP id 5b1f17b1804b1-4801eb041f7mr130381575e9.20.1768832705467;
        Mon, 19 Jan 2026 06:25:05 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e86c197sm197649245e9.1.2026.01.19.06.25.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 06:25:04 -0800 (PST)
Message-ID: <eb4dc1e9-fdf6-4f33-b183-c02d77edeb2b@blackwall.org>
Date: Mon, 19 Jan 2026 16:25:03 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 16/16] selftests/net: Add netkit container
 tests
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-17-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260115082603.219152-17-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/01/2026 10:26, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> Add two tests using NetDrvContEnv. One basic test that sets up a netkit
> pair, with one end in a netns. Use LOCAL_PREFIX_V6 and nk_forward BPF
> program to ping from a remote host to the netkit in netns.
> 
> Second is a selftest for netkit queue leasing, using io_uring zero copy
> test binary inside of a netns with netkit. This checks that memory
> providers can be bound against virtual queues in a netkit within a
> netns that are leasing from a physical netdev in the default netns.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>   .../testing/selftests/drivers/net/hw/Makefile |  2 +
>   .../selftests/drivers/net/hw/nk_netns.py      | 23 ++++++++
>   .../selftests/drivers/net/hw/nk_qlease.py     | 55 +++++++++++++++++++
>   3 files changed, 80 insertions(+)
>   create mode 100755 tools/testing/selftests/drivers/net/hw/nk_netns.py
>   create mode 100755 tools/testing/selftests/drivers/net/hw/nk_qlease.py
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>



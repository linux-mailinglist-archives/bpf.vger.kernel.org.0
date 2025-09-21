Return-Path: <bpf+bounces-69129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2DCB8D9F3
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 13:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C88BD7A89C3
	for <lists+bpf@lfdr.de>; Sun, 21 Sep 2025 11:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568C825A651;
	Sun, 21 Sep 2025 11:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+BHYOAj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0F742048
	for <bpf@vger.kernel.org>; Sun, 21 Sep 2025 11:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758453898; cv=none; b=HaMFuXfIZGM6wGILRLDShABGFXmjkwLefhEF4ImCx7yYwNkBr6zWIT/Ujm0eSB60L1mGwmpD3kdrh+9ChUyK4/u7pAFaZfnBVeWJdgYEkqgwIqcKQzl5E/yd6PYZO3mpEQ4jsbQGI1AZTyrJGO5YnGcxCzZyve0dqrPvlvfuy2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758453898; c=relaxed/simple;
	bh=P2khDDn/G+6oVOugbUsDXxGtt+CufsbX6kA4FmUk7g0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cioZJIsvTMP8pp9PG0BNQOdfDETvL+uP0gnDfLiBFModBIj/G9BBpVECz70y68VS4Ttjrha5k8/NliNl6F10zPHIjZP85P0/uD+Jh1iqxZHGdZZIA6AToHRrh/zpGddSvVTqq1ja0tGgs3rnV02BWmG37nxlcRLebSgm9uvJEQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+BHYOAj; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso3749652f8f.2
        for <bpf@vger.kernel.org>; Sun, 21 Sep 2025 04:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758453895; x=1759058695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LpqXVMdBPXLDB8/wzui/VoVUAw42bntrHFhuBKSPIgQ=;
        b=O+BHYOAjfd0COWp47RYgNSsnsSuwDXyR9KY2rBvjH/W+ypgiYku+RT56XfiAuRVpnw
         v+W47X7cLzkPOyfUgcLIxV+6y4PnYC47fJEsncuu8Qcu0mCtLtj4ibUHBR7TbnoZNGa7
         c9tn6jnLQWkT/tqljs3On8SAAGtGc5lj39mRvheAjw9U39+Y9IYO9Vw+vxcYvynVwXqg
         xmoYj3al/Kfm7hb/sFRWXG1P7oCf6AmR7Yvb8uabmf04YD67eOcEc9APTqJNKEsdB15P
         7jN5IbX9oeLYC15kj2AMwwJQPn//ZKzEdcFXcoI7K/FQ45oeS7GAYd658M/spX846IG/
         NwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758453895; x=1759058695;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LpqXVMdBPXLDB8/wzui/VoVUAw42bntrHFhuBKSPIgQ=;
        b=RD7lMdMFhMUxSA5CHdaBm00fXbS+mr/Yzty6s4xueopVd7Y67ud3dhP57dxYuq0onz
         4IswN4MxUSuvarJVzaba0wmVqa7Xtk97kZMHPUuLy5EoEzvzcDm9/xISxtflDJzVWx2I
         4gZENvwofyymy7vpJnGOIU5xX2B6iMz2JUqA0psH1bLi0zc0e2GSk9TJuWHskjR5gOiu
         4fHJprun5HhJOB3HrENkKxyMiaP7mU1pvlqw6mNfJxzHjmr1tgHh4AF4cuqZ4EyBEFL4
         JqnjQzCVJdVery4/391CUbkhcjsnTNObry5NnNCfXR/QLj9GMgIVzwXQSBZVaC2tgVHH
         TXyg==
X-Gm-Message-State: AOJu0YyY0v2B+uF4TPrAzFldIaJPrC7DwxV2XCoYCAEB6h0fqKXJ4Z1B
	Zo9eBYk/+Kcqt4ETbs2p5W2nI6s0HAz1JErTBz59f8628dxP8kPQMmit
X-Gm-Gg: ASbGncvdtGo3tvK1BfE/pCBS9OtVUCmBUCBvFIc21eqeB8sFYGSHOJitFhPU95wRCRD
	ShxUONF5cLt4X3PPEONLFMUPSuZfHgOOl16Lf2Nm1clLZeWTC9d8Bi9biPCXcOAjm5yeEI80jFT
	d9JR2LV0PvWGCDDSriHdcLtgdKBXwrPYzDrnZ11uC9dppkP6PkJ8EMwPUGYeHVppOACm9f7tnrA
	H1aL60WyLPUEhL+r9fx+4mcwjHKoReB66KdilgUVUDm5cAOz06k0ZhjlU40rtw94i+vk4L91nKu
	Yqdhg0tP9Da/Sj6ZYAiKpVcPydhlEswuQTjiaLEeVl4V4UPBnHhTi4zxvOWfkxyix/mFc5LnlUy
	JrWjD0UaZaymrYIBqRMeZRXovdeXLh1VMi4oplymgCjja2e4=
X-Google-Smtp-Source: AGHT+IH0ZuZXXPjniEqaRqXv4QdY/ExU554pUIFqdmbqSw1xbaLHEJm2846zI5N46LR7fz3DTPaVRQ==
X-Received: by 2002:a5d:5c84:0:b0:3ec:db18:1695 with SMTP id ffacd0b85a97d-3ee85769a18mr9563158f8f.45.1758453895193;
        Sun, 21 Sep 2025 04:24:55 -0700 (PDT)
Received: from [10.221.198.215] ([165.85.126.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f527d6cdsm180429735e9.12.2025.09.21.04.24.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Sep 2025 04:24:54 -0700 (PDT)
Message-ID: <0eb722b9-bad9-43b4-a8a7-6f91f926e9f5@gmail.com>
Date: Sun, 21 Sep 2025 14:24:53 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/2] Fix generating skb from non-linear xdp_buff
 for mlx5
From: Tariq Toukan <ttoukan.linux@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, kuba@kernel.org,
 martin.lau@kernel.org, noren@nvidia.com, dtatulea@nvidia.com,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, cpaasch@openai.com,
 kernel-team@meta.com
References: <20250915225857.3024997-1-ameryhung@gmail.com>
 <b67f9d89-72e0-4c6d-b89b-87ac5443ba2e@gmail.com>
Content-Language: en-US
In-Reply-To: <b67f9d89-72e0-4c6d-b89b-87ac5443ba2e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16/09/2025 16:52, Tariq Toukan wrote:
> 
> 
> On 16/09/2025 1:58, Amery Hung wrote:
>> v1 -> v2
>>    - Simplify truesize calculation (Tariq)
>>    - Narrow the scope of local variables (Tariq)
>>    - Make truesize adjustment conditional (Tariq)
>>
>> v1
>>    - Separate the set from [0] (Dragos)
>>    - Split legacy RQ and striding RQ fixes (Dragos)
>>    - Drop conditional truesize and end frag ptr update (Dragos)
>>    - Fix truesize calculation in striding RQ (Dragos)
>>    - Fix the always zero headlen passed to __pskb_pull_tail() that
>>      causes kernel panic (Nimrod)
>>
>>    Link: https://lore.kernel.org/bpf/20250910034103.650342-1- 
>> ameryhung@gmail.com/
>>
>> ---
>>
>> Hi all,
>>
>> This patchset, separated from [0], contains fixes to mlx5 when handling
>> non-linear xdp_buff. The driver currently generates skb based on
>> information obtained before the XDP program runs, such as the number of
>> fragments and the size of the linear data. However, the XDP program can
>> actually change them through bpf_adjust_{head,tail}(). Fix the bugs
>> bygenerating skb according to xdp_buff after the XDP program runs.
>>
>> [0] https://lore.kernel.org/bpf/20250905173352.3759457-1- 
>> ameryhung@gmail.com/
>>
>> ---
>>
>> Amery Hung (2):
>>    net/mlx5e: RX, Fix generating skb from non-linear xdp_buff for legacy
>>      RQ
>>    net/mlx5e: RX, Fix generating skb from non-linear xdp_buff for
>>      striding RQ
>>
>>   .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 47 +++++++++++++++----
>>   1 file changed, 38 insertions(+), 9 deletions(-)
>>
> 
> Thanks for your patches.
> They LGTM.
> 
> As these are touching a sensitive area, I am taking them into internal 
> functional and perf testing.
> I'll update with results once completed.
> 

Initial testing passed.
Thanks for your patches.

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>



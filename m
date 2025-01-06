Return-Path: <bpf+bounces-47964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF937A02D76
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 17:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55A941887266
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 16:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E598155300;
	Mon,  6 Jan 2025 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vBqQbL3b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FA51482F5
	for <bpf@vger.kernel.org>; Mon,  6 Jan 2025 16:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736179949; cv=none; b=JKxgfOzReEkAlj7umvVL++Bm1C1DV5pXKcDUBCybMEI4oeCoeA2nh9EQQhrSmBXa9jAZLC1fYmHb+DyhT/S8hzxw6bWG/CSqHCRSfQe5FaipNeJf3MLCMIFJGvzRx0NqHXBPSMX1IYl6zm0MB8pAkrkzlB+R1CVLB+wdYNRCzEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736179949; c=relaxed/simple;
	bh=INjogMqw076rXDw9Kxa8PvC2oLwGr4OUpigpgNqO66o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JOlDpnwi2VFNNqnH9bQSy8RiuDeBSCZBQKGbVtdA5BQVrCaA9tVonarMuNHVkqNP8bqhUawTq+D3kDzTAZD3ft1Bs86l3vyLagoWDi0uoC9nNtFseXfNXG2q6efYBXurIO6vcaDTvDVk4nNfEWAzIKtmt9IouIIvDle1U+p+XxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vBqQbL3b; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-467abce2ef9so473771cf.0
        for <bpf@vger.kernel.org>; Mon, 06 Jan 2025 08:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736179944; x=1736784744; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=erAVFwaunZKkBff2AoPjlD7knQ5r/P3eO+xf9AXUrXw=;
        b=vBqQbL3b480/XbPaBjIIliuNKPZIxD1tKjgDwu2/E8Asv7MtDyj2Bx1P+rnGYg12Yf
         m9jreJv7fC3oLkUYACJI5C6a3PPDN4q6H0s2rwwqkmz619h6AJzcAZen1VfUAkBDkU+w
         0pfDmE0IEgiGWDsjRNkQwnicz+vYefoguUV/rBuuWEMNm/zPZgdTZKVLgDaFbOZHAgob
         q90lz/QSkq0Q99XRqcIFgcDSFiKsNXva4weisWdl79cTaiZ38+PU5VWfqn9Mt7bQFHgf
         P9yXUFOK4SDNmMQupTtM3LHlw+UPUMXk2GqzKjf7MpjhSkxpWF+4NMqHuVqR0FE8OLUy
         7oEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736179944; x=1736784744;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=erAVFwaunZKkBff2AoPjlD7knQ5r/P3eO+xf9AXUrXw=;
        b=CqAlw1oKxKm83Tv6atRzHOr9m/KVxrbigVF67AISk4VPzx/Le59rMLm6lM5oswUw9q
         KkFUs8myFM98FTdn+rV9wHr4KK+HTJdVWSU1DU7ULvo7lqBA7QbjTRcykE9j5uX9Gvlw
         MZoG+bzeDOvPBJC3d7YNBPgAazaomLXElgxaNWbnyqziEGHZw7FD3L3A8nQJEMfXnr8B
         UR3zIwqgZ/bA6fHT/mpSJ/vPhN49X9ktF5x+5g2ewP6QJMHX76wBGiMyxccz6AmE3ByT
         xbkcECkmiBxDLAjOZQCE3xvlHx6E0D1PE5Jt2z0K1jo5xCJsLQz8zo/7o7Oh3F+AGeKE
         QSwA==
X-Gm-Message-State: AOJu0Yz2c5YIQiwDCRoaBM1f5nTGyah8e5L/757+NPMLitS5uRewHtLH
	qnTzYQYG/OT5Nkytf19z4KHqoTXLL56/8Yu7kpJQAqRqYrSJXtbA/oUrdFnQ0g==
X-Gm-Gg: ASbGncs0Du/iXecCXRBnDOCjzisA7ihcbhtAEuJ3kJFwO9vSBo3sAG60e8g3A5F4O2x
	NcXqTmGeqTkYl95lV30Mz4Iqq9XW2CaYy7452HmDMypbn2LBgLj5X0KHJ6wcbRA5xRByJYc/I4e
	FD5CL1wQliz7muYPPNfMgFjIWYtJXW+svxxGic/AGQzRz4IXBU0EeOcGCVdKDhwo0kCZ8TL+u3v
	b5NbAM36KnyQHL1mry/ApnIF5mxUFNB92XK/hKKfTuvXNpQv8P8kkhWiKhc2cJKaYDJRxDKMxO/
	3Pe/mOVVX6yxhKEXrQQ=
X-Google-Smtp-Source: AGHT+IG0GmXVWZOJH/5Hyjn9Z3joXlkWb1wBSw88ml7sm5cCsEYUREYiFvlZQZjw/lsgThTw2uEIuw==
X-Received: by 2002:ac8:7d12:0:b0:447:e59b:54eb with SMTP id d75a77b69052e-46b1fbc1b9bmr7194841cf.26.1736179944512;
        Mon, 06 Jan 2025 08:12:24 -0800 (PST)
Received: from [192.168.1.31] (d-24-233-113-28.nh.cpe.atlanticbb.net. [24.233.113.28])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181d5adbsm171581526d6.115.2025.01.06.08.12.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 08:12:23 -0800 (PST)
Message-ID: <5fe34ecf-07df-49c2-b94e-36ee6cb21f8a@google.com>
Date: Mon, 6 Jan 2025 11:12:22 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpf: Introduce range_tree data structure and
 use it in bpf arena
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com,
 djwong@kernel.org, kernel-team@fb.com
References: <20241108025616.17625-1-alexei.starovoitov@gmail.com>
 <20241108025616.17625-2-alexei.starovoitov@gmail.com>
From: Barret Rhoden <brho@google.com>
Content-Language: en-US
In-Reply-To: <20241108025616.17625-2-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/24 9:56 PM, Alexei Starovoitov wrote:
> +/* Clear the range in this range tree */
> +int range_tree_clear(struct range_tree *rt, u32 start, u32 len)
> +{
> +	u32 last = start + len - 1;
> +	struct range_node *new_rn;
> +	struct range_node *rn;
> +
> +	while ((rn = range_it_iter_first(rt, start, last))) {
> +		if (rn->rn_start < start && rn->rn_last > last) {
> +			u32 old_last = rn->rn_last;
> +
> +			/* Overlaps with the entire clearing range */
> +			range_it_remove(rn, rt);
> +			rn->rn_last = start - 1;
> +			range_it_insert(rn, rt);
> +
> +			/* Add a range */
> +			new_rn = bpf_mem_alloc(&bpf_global_ma, sizeof(struct range_node));
> +			if (!new_rn)
> +				return -ENOMEM;
> +			new_rn->rn_start = last + 1;
> +			new_rn->rn_last = old_last;
> +			range_it_insert(new_rn, rt);
> +		} else if (rn->rn_start < start) {
> +			/* Overlaps with the left side of the clearing range */
> +			range_it_remove(rn, rt);
> +			rn->rn_last = start - 1;
> +			range_it_insert(rn, rt);
> +		} else if (rn->rn_last > last) {
> +			/* Overlaps with the right side of the clearing range */
> +			range_it_remove(rn, rt);
> +			rn->rn_start = last + 1;
> +			range_it_insert(rn, rt);
> +			break;
                         ^^^
did you mean to have the break here, but not in the "contains entire 
range" case?  for the arena use case, i think you never have overlapping 
intervals, so once you hit the last one, you can break.  (in both 
cases).  though TBH, i'd just never break in case you ever have 
intervals that overlap (i.e. two intervals containing 'last') - either 
for arenas or for someone who copies this code for another use of 
interval trees.

barret



> +		} else {
> +			/* in the middle of the clearing range */
> +			range_it_remove(rn, rt);
> +			bpf_mem_free(&bpf_global_ma, rn);
> +		}
> +	}
> +	return 0;
> +}



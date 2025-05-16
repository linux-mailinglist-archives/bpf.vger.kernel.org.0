Return-Path: <bpf+bounces-58398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B7EAB9DE3
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 15:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E776507EB9
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 13:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4182713A258;
	Fri, 16 May 2025 13:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROywHA2B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0954410785;
	Fri, 16 May 2025 13:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747403233; cv=none; b=JVjm5W6ciX/l7cf1IYLKSJ9x0qpnet6I81BDt03qoa0YHdMkRle7sqnGo6X03l0Cdc8JyD09QoMySmetN+R7Way2wggsAifRitqEFyFt+eb30ZTD/EVLlwhvP2LmC/65KqlRMNuYqCheyfL1sRqXNCDlJX7wCTWOlh0ir2MYWrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747403233; c=relaxed/simple;
	bh=gIPJ/iDLV/nl0ar/Tu/RiWPqiuZOy4ZKvq4zpmeDHGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W0xv3ssCJZxvXHTivsxzO3M+eXj7lrdzxywJaO24eVPEl9yZc15W5N3HbsNpDO4AOVVMM78AWYpo7UA4S7VFvUVNS7I+POkNw7Ijo0el8v863lrMR9dyCYe4W1EIFf5dTOhZwHeqn3oTXiSDB0yFswBr2yKV5ZqpFrKCu05VNr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROywHA2B; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-442ea95f738so16032815e9.3;
        Fri, 16 May 2025 06:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747403230; x=1748008030; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K7G2I5OKBPNva6umSCfzfSla912kgeAD12cq229nxjE=;
        b=ROywHA2Bz0qPWz915rPeI2DffZvy7h2Ggbpmgv/QPpOT+AEuGDTb+FYhSU/0cOa8qX
         XWCuQVyOkeft5CjLaPqzaQpMi5P7dIHtEWerVo4sh1QLdWDq0JO8r+oev/FPxhwIg0Md
         XWBBYW3vvZfSCSItU6k61XnDzGTxq741NY4renf2kqig7V34KonqshoOpJ3XkQxu2gJL
         T4x64X9oS+GU2CC7LZOvMzARti1R8/kdmetWej7KSTFLL1VNctbHRTRrgGvgj3RODVXH
         l2kpoLUcjqM1VR9OGJxqqnkxCztj2JKjNbyiJpma13bgetOFxds35zAbam9Vg9ykIxq4
         tazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747403230; x=1748008030;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K7G2I5OKBPNva6umSCfzfSla912kgeAD12cq229nxjE=;
        b=nu8FF6edKbWq4fDF03jLCceZNBJ9pxwy9OsqNn+RDfGqQUge4lT6Qq+vjF2Q3wxKrN
         /Ca/39IWsPtOiYDceDqbvU6peeYoon3uLBufp7/791GiOY9EACVB3pfdj7eI0HXKq2Wg
         txhiTbXBz2NiMVzc6VVCjbscjGJVBRO6sSkBjlQRTL9dSJf+LOLYch4Nbh68g9nRZzQ1
         PLtz24EP4A+aymBtbpk8YvhDqW+IMhiMeIYFTMqJrOLwhZCI5i3jjdZ7KUNgwDhWgve/
         /EWtBlL8ogdlR6ce7vL04ZadVzkIpnQMM+VX1e3TmJysKKfbQ3+zfxyR2RIANImjSY5R
         clDw==
X-Forwarded-Encrypted: i=1; AJvYcCUi2IqTRzFBbPAYSt1IHGHZXMBlubHeoq7TgfnWMfR+37aRjBKYH0Ue7gGf0KrqRq0H5yd5S5RB@vger.kernel.org, AJvYcCVHTL4m+LmDzEiYnOfm2F3XgYBreW+AcSwf0lSzBVT3CJeCsDStGzUZtOMS40GjM+IYmHo=@vger.kernel.org, AJvYcCWNjJecNN0752/4yKl7ZAVz/QHgLhPmECn8zP1BTy+QXYB+FTE2dxhjy2sT0kUrnBE6A/+RSAF5BD6JngPS@vger.kernel.org, AJvYcCXJqLDT1fA5onXX+yWXattiu25GWOh+apmKXuEkuQB7RMdCefypFyQ5UVZMT+ShHJDbcPY0y8Rd7JfCvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtwZr2lpULwo7eHGaGyF3jqY225jFAt+9fGDP2+fLfYEaBDiVZ
	eWa7BXi5g+B5LZzvhgHgGDg3TIvK5TYnLgqtZp72rGP8/CCHdmn/XiZy3/SaMA==
X-Gm-Gg: ASbGncu+Q7uEyfG3Jc05UckgAWjMtPPve2VtnAuLp8xk18QybXiCPnx+Qph+tj1yo1y
	Jm09Eamh8RM+renvboK34OYi7xHrMaiuoNlX3U+XYUGWaiE/7KfeLhhNykP7T8vmFj5vR4A9oba
	Uw8lpAYoEBJUVsyAqWIWyLd2e2hngcREBzU9yRY53bh16Hl+GDo36Jz++R7uE6UHmqEXBCInKPE
	cvWs3U8mk9warhuhfMiw64NHQMwYh6OdIGsqlGFTRtgDVndRnHxQVqyjsrDEXXXcPfQTIQzmK97
	knIu0MJANQ8ZPOhFCCh6rzHMMfQM948ShZ8Ci9dv+w/spotjty+sOJzDTG/tVXODKWM/rO80
X-Google-Smtp-Source: AGHT+IH10n1Y0Q2+MvM5BkTzLrgdGKnNQN0RCaqs65h7v/86P47GRzrVro52ZRHru7adaDoziP6tKw==
X-Received: by 2002:a5d:64e5:0:b0:3a0:a19f:2f47 with SMTP id ffacd0b85a97d-3a35c853278mr3674404f8f.42.1747403229917;
        Fri, 16 May 2025 06:47:09 -0700 (PDT)
Received: from [172.27.21.184] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35fa8c6d6sm2391336f8f.26.2025.05.16.06.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 06:47:09 -0700 (PDT)
Message-ID: <dcb3053f-6588-4c87-be42-a172dacb1828@gmail.com>
Date: Fri, 16 May 2025 16:47:06 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5e: Reuse per-RQ XDP buffer to avoid
 stack zeroing overhead
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Network Development <netdev@vger.kernel.org>, linux-rdma@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 Moshe Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
 Sebastiano Miano <mianosebastiano@gmail.com>,
 Samuel Dobron <sdobron@redhat.com>
References: <1747253032-663457-1-git-send-email-tariqt@nvidia.com>
 <CAADnVQLSMvk3uuzTCjqQKXs6hbZH9-_XeYo2Uvu2uHAiYrnkog@mail.gmail.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <CAADnVQLSMvk3uuzTCjqQKXs6hbZH9-_XeYo2Uvu2uHAiYrnkog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15/05/2025 3:26, Alexei Starovoitov wrote:
> On Wed, May 14, 2025 at 1:04 PM Tariq Toukan <tariqt@nvidia.com> wrote:
>>
>> From: Carolina Jubran <cjubran@nvidia.com>
>>
>> CONFIG_INIT_STACK_ALL_ZERO introduces a performance cost by
>> zero-initializing all stack variables on function entry. The mlx5 XDP
>> RX path previously allocated a struct mlx5e_xdp_buff on the stack per
>> received CQE, resulting in measurable performance degradation under
>> this config.
>>
>> This patch reuses a mlx5e_xdp_buff stored in the mlx5e_rq struct,
>> avoiding per-CQE stack allocations and repeated zeroing.
>>
>> With this change, XDP_DROP and XDP_TX performance matches that of
>> kernels built without CONFIG_INIT_STACK_ALL_ZERO.
>>
>> Performance was measured on a ConnectX-6Dx using a single RX channel
>> (1 CPU at 100% usage) at ~50 Mpps. The baseline results were taken from
>> net-next-6.15.
>>
>> Stack zeroing disabled:
>> - XDP_DROP:
>>      * baseline:                     31.47 Mpps
>>      * baseline + per-RQ allocation: 32.31 Mpps (+2.68%)
>>
>> - XDP_TX:
>>      * baseline:                     12.41 Mpps
>>      * baseline + per-RQ allocation: 12.95 Mpps (+4.30%)
> 
> Looks good, but where are these gains coming from ?
> The patch just moves mxbuf from stack to rq.
> The number of operations should really be the same.
> 

I guess it's cache related. Hot/cold areas, alignments, movement of 
other fields in the mlx5e_rq structure...

>> Stack zeroing enabled:
>> - XDP_DROP:
>>      * baseline:                     24.32 Mpps
>>      * baseline + per-RQ allocation: 32.27 Mpps (+32.7%)
> 
> This part makes sense.



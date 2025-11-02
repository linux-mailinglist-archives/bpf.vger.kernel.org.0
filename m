Return-Path: <bpf+bounces-73255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 187FFC28F0B
	for <lists+bpf@lfdr.de>; Sun, 02 Nov 2025 13:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3376C3B2AC5
	for <lists+bpf@lfdr.de>; Sun,  2 Nov 2025 12:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC29B2D9EEA;
	Sun,  2 Nov 2025 12:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ew1P6w8W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC27D27EFFA
	for <bpf@vger.kernel.org>; Sun,  2 Nov 2025 12:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762085693; cv=none; b=MIjPqLSam1KKmpYtMOsV4IAW2sjyMFgqZKOEmQ4DdUb9Antqt4Z/3l/kTiQ9I5bcwnYD7dVw5EkqCLdY5jN14Kg9I116gBYSuIztAYbFIOcNBmE78F+8OK4ROCDRHMwsAR3jkQHoGEmaeGWJ3+SmyLdaM3DTEm8PDwlsBhl8nKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762085693; c=relaxed/simple;
	bh=LMNeTSPwxETdBy0HzCt2lQzCrYmDYnoVXAlFu6pBI0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ayAxqQ7SmcLh0h8a0KuiaTHaRiOV15+lNM62QCA2b2BlqsshmNPktH1DTPuCEkgnelmLbc1vgnAOgjmLXplivxB0p/vnk6YW3iE9YvGgtddBuPUWfNOsDPnAxmHa3b+Z1s27Ah8w7r1X94JkfU/sgx2DeJlsPMHmv8GIk5COlWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ew1P6w8W; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-475dc6029b6so32538125e9.0
        for <bpf@vger.kernel.org>; Sun, 02 Nov 2025 04:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762085690; x=1762690490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GTHylYesgJBra3YugE8dFYJP8cm0/3QzxwX2tCmUu3A=;
        b=Ew1P6w8Wlypkp1BDo883I9Z3CaApYqjQpMNSAVAqsiG59AOtFCa+JGFdgdScdR1UHV
         xn7hWp36cVtEgbpok062AJwkKJRJOkEbezdk4/eTVPZh+68DM5eed98FwW4D5cWUl1Mg
         DWS4WwddQglE+FU6GC2T7LWq7whMQRvqjkzEqipBsWjspG8z8v1jE6XLUGijiAfuI86g
         6uUSAz+XTIUOHh/ZBnlxWPCrkfVj3QqYQE6uoaQ5kUm8SfQ/SgjQIL+OeD5tkcEb+TkP
         6eQ/w+TWCZqUZFOvSk0Xf3n21SVfKYrpr+ZtzlLWS6JxH5Fj5JeBsksMsiqYb3Sd0C1N
         sXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762085690; x=1762690490;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GTHylYesgJBra3YugE8dFYJP8cm0/3QzxwX2tCmUu3A=;
        b=eQlyFmGDiOshL0AGH0xg6ZAJnR2SJvXsMp6TKbvemG/1JE79rKLGgWeMSFhxgZj2V+
         2BoMDDqYvkgTULGqkbKPb0mQ763pFDkK2oq0BtL+BbR81TT4lO1X6sB2FEXgWte9Ywnr
         s1KQq4nnOmpB9gtA85ZAk6NPQ6mRUUxja83appzoQe8Y4oFqHc4zY7DfAofHrTk0S16z
         So5GIjfzP402qo/cR6Ug6xK28wXFkTMdbh/NtuVzoDpU1OjsP0QoTah+m07UfdAlFLoI
         rIMAMwhkAiz+oB5KG7az2Nr+XL1uYbil1BNAZG2O0M4BkTLisGiZmjtgTWSPh2OpLeEF
         gyRw==
X-Forwarded-Encrypted: i=1; AJvYcCUL3PqQw0LhYUwPD1XPbBLuIwT/N7LUT4Zg4kB6ucqc30ojAKXxz/qHj8OV6T57ofSBIIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaOc3ZfMhhhpP6LD2i7BFu2UDZ8uhnFjSn9I04v3CezJhTKXna
	oKkGerANjYG9/xkjAN7fDyTQY4wspppHcUupAFTgLmKrlMp6mgEulP2s
X-Gm-Gg: ASbGncsOVAb1gAUXNMyA1z9x4OKXb2hzFXHcvLrOdsY6zhWXdqFgk11VffNzcsCTfcF
	lcyRmwpGa0fXuC/qclgEyuHhjNzKde47G1xa6tnjrHFkugqYiVCz1IjSlZNZb6U4GHs9SW41lm6
	VrhG7qW/C6AlVD4z2p5HhrBfAzGWOkBY0B78sOMF0LLZ2HJ9r0R2WyF3BCOC4nyTrsQq9ztHWuO
	aGUOdg6mdgeMnhfka43HhgPFYt3baOJexwzcWYVKc+DkHeCwV5TaT7kC/QQOPbwBoZgtfca4g9u
	o4RLBarlUkCFJk8+l6eUSe1cAH7z5BQmaOrcSEWJulopLl9Ym6e5pAXTOw1XbWN/k6k4Wzy9PR+
	tNL8HFA39aWvNXMj4+4HFRIJPqmrkGIjvjdkTkil2ms9iKO9KmUU1u2kuXJGHnK2gelLHfVyWbw
	aJnYIVVVtt1WIiEHzp4fR9/x5B1N0dPJ5h
X-Google-Smtp-Source: AGHT+IH1p6Ca+IRbV9+qKgOA2mVZT+HdAJKOwMyPbywz/Oxjd+UMOv1XaOrufqQeUV4NaEMHxeB90w==
X-Received: by 2002:a05:600c:3e07:b0:471:a96:d1b6 with SMTP id 5b1f17b1804b1-4773b1f9db7mr62398135e9.7.1762085690093;
        Sun, 02 Nov 2025 04:14:50 -0800 (PST)
Received: from [10.221.203.8] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c102dfd2sm14345862f8f.0.2025.11.02.04.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Nov 2025 04:14:49 -0800 (PST)
Message-ID: <4d9a2c4c-373a-4ab5-af8d-474212e21762@gmail.com>
Date: Sun, 2 Nov 2025 14:14:47 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 6/6] net/mlx5e: Convert to new hwtstamp_get/set
 interface
To: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Mark Bloch <mbloch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
 Cosmin Ratiu <cratiu@nvidia.com>
References: <1761819910-1011051-1-git-send-email-tariqt@nvidia.com>
 <1761819910-1011051-7-git-send-email-tariqt@nvidia.com>
 <20251031164208.7917f929@kernel.org>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20251031164208.7917f929@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01/11/2025 1:42, Jakub Kicinski wrote:
> On Thu, 30 Oct 2025 12:25:10 +0200 Tariq Toukan wrote:
>> -		err = mlx5e_hwstamp_config_no_ptp_rx(priv,
>> -						     config.rx_filter != HWTSTAMP_FILTER_NONE);
>> +		err = mlx5e_hwstamp_config_no_ptp_rx(
>> +			priv, config->rx_filter != HWTSTAMP_FILTER_NONE);
> 
> FWIW I think this formatting is even worse than going over 80 :(
> 

I'm trying to minimize checkpatch warnings while preserving code 
readability.

IIRC, clang-format produces such open ended code lines, so I thought 
this would be more acceptable.

In any case, I don't mind going with the over 80 option next time.



Return-Path: <bpf+bounces-60008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85766AD11C7
	for <lists+bpf@lfdr.de>; Sun,  8 Jun 2025 12:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F008E3AADB0
	for <lists+bpf@lfdr.de>; Sun,  8 Jun 2025 10:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2743B20C469;
	Sun,  8 Jun 2025 10:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3yi5PhF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AE2A927;
	Sun,  8 Jun 2025 10:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749377367; cv=none; b=N1NmVCEeYG+YcCGxUrCDTX10FWOucHPMIiSJIdSQjp1Xi+msgqDSDByxmATkyKywOLYLMNqaRCNWNr+ks9o1DkR/BvZVcmj/suwcPAO/yAr9aB6Cdrjrzto8rrQ7a7BuAInbQCgjHW7c0lwQrvn9opVWG0WJYt229tZ6N91Sfts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749377367; c=relaxed/simple;
	bh=mw52m+pDqfoXz3jkWtw7E4/3TvjKzk+8qk4ny2CFayo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hVO/z0gXJ4QH1NjYe2aUruHdmqlgy2sNBd7MXQy1z5LyKnRWSIjn53gKdlfspL2EmsIKS8Ruu0wtSYnGy9loStbV+m09U/DguXSPPtLe2/wtZeHj/NSUCn5FWucHcu9n6RgqTsnPgoiKjsii3wrEWxradFMAcTyPDP39q6eWUxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3yi5PhF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45310223677so1367945e9.0;
        Sun, 08 Jun 2025 03:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749377364; x=1749982164; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5+2LvGJ+RQAGkJd/RVuC75PuOLPGNzsYlk9uL8LVulU=;
        b=O3yi5PhFlp5GRCB0HENFVwih6GehBBBtUQGXHmYy9FdKLXRWdT2KHcYN1S5VpzTpsS
         Hq8hSXhXyGVvx5nLBkVMnQSTDtvHX9pEO68ZEGzXuUgWvC2FuhCsvbam42GEood+yIMr
         gpnZzBei+5AyPZ9VZ1tw1W9v15iWs8vsoFpTayldQcRF9pvWW1Vpdyec+h7OM7R9KyS6
         rf/dpF2XmVWtSupRW/xg4ySun6Jm0VgbDsMytt1XDWjfAOtj4NQLGUfMDEQ+usCxY7Zp
         bAZTi4Jn+kU9/HluGRriPkzYJfhoX8J0HznROqmzmULy8Q7QGBkxzAarthDc/+pdG6Fn
         FDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749377364; x=1749982164;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5+2LvGJ+RQAGkJd/RVuC75PuOLPGNzsYlk9uL8LVulU=;
        b=E/e85kpJn3iPPd+URNyWWyZ4H+Qjf8wcf6hvUYKlqFMLVqKwenr8CHU1JW32Kd4dkj
         hsTVTBLAMzQTI4DxDrlxvFz+rFmjGYMwquQL/ZpEzZCTxCmAwWoQCjefxnAxu5rSBkHt
         8BNX2vEMWwFhLMJa7V4Ke5ZzYVxeT7fDLLyVF2ewPzUnaqFxWWDoVWNoAMUHqBHN2N2b
         9p+w0L4/q0iNUqVDCYpPFQ8bV2LM6X7oSkrRvSAZe13jTmPPKve6cOuLQx0VwCN1gSMD
         7pYvwm2QLPGcsxukguUZDEOBGBSHugBG2f2fpz7mKW5yGScCbxhIUyBum62x5rITWzk/
         yMPA==
X-Forwarded-Encrypted: i=1; AJvYcCURdqc4yzKMuDI9Rsz4ylYNdJvz8Ept+RuX+/cChoYSe+HARew8YCjXQmLlG3n31gVah5Ha1OWs@vger.kernel.org, AJvYcCVIYnBpz71PnFBXu1mb1W/Nt0qIuQ+VFovhVEpI6cemV9lvPiW3oqiWSCDLDEbSu3/28xI=@vger.kernel.org, AJvYcCXsMB0gpnevmA2RAN8P0+g8zBaIvR0B2jhMVwEL2bibJNXKBoVhD5C9p3nZS8ZXkM6QdgN8p/IxvgvCxTEm@vger.kernel.org, AJvYcCXxSB33xDVQi8ZIOgDN9c9o83Rclak5ACzcug7lJHGQtA7sMx/Dbg2pL7ByeaNMvm+Nvtpf+sGcGdCSIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ13xXhnMpadFETN7MLtNlTXC0wCtkKDilyLXTOEzYaBMBMK7S
	DLAJv4qLon2A3uU/1pXtxjjgi1vBhCHnBWKzkmT91XNEOBpCM0W5Bpml
X-Gm-Gg: ASbGncvz+Ule7EFCjs1YY1CxR4hnIK5o5Rxje0EsRc47HcVJl4rq4JYBYAuzX0rFUNw
	5HRtMmMJqOMaF9+RNjTxYKDBgb7E0vOsViq5CWMS1JD9Yz5zYFQ2PtXws7KBS5KBoVllg2xmh3V
	EEjX3xTt3bLtN/jcUJr2q3q2eosTTOhQP0e2roNAz1q2xS5HO7FOtwaYET+6jfX1LS8I/NaeAAL
	jKLg7MaW+7xxgA6O8SBEqBK/TzKxrevQMD8ck8oSeI372wvoMTwxJ4n6WZV0u8Pd/UBj62HNZM5
	4dOarLgWbjrh/j142kdj2Ukjh85NqHyOsMuZPEroyLjCuzxuaSMoAIgMKiZeEDZFtbnV7pyrz4T
	44B79uQY=
X-Google-Smtp-Source: AGHT+IHbeHUTLV+ijJ93umxha7U3N+Doc5TIXNx5qFgkM9Xzh1vqFqFHHXuDnm01fTZ3xIh2LwMSAg==
X-Received: by 2002:a05:600c:5396:b0:43c:f44c:72a6 with SMTP id 5b1f17b1804b1-45201364c47mr99899725e9.2.1749377364074;
        Sun, 08 Jun 2025 03:09:24 -0700 (PDT)
Received: from [172.27.58.200] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4526e05636dsm80089865e9.4.2025.06.08.03.09.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jun 2025 03:09:23 -0700 (PDT)
Message-ID: <c8196bc9-ea3d-4171-b99b-b38898081681@gmail.com>
Date: Sun, 8 Jun 2025 13:09:16 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 07/11] net/mlx5e: SHAMPO: Headers page pool
 stats
To: Cosmin Ratiu <cratiu@nvidia.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "saeed@kernel.org" <saeed@kernel.org>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "hawk@kernel.org" <hawk@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
 "leon@kernel.org" <leon@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "ast@kernel.org" <ast@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, Tariq Toukan
 <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Gal Pressman <gal@nvidia.com>, "daniel@iogearbox.net"
 <daniel@iogearbox.net>, Moshe Shemesh <moshe@nvidia.com>
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
 <1747950086-1246773-8-git-send-email-tariqt@nvidia.com>
 <20250522153142.11f329d3@kernel.org> <aC-sIWriYzWbQSxc@x130>
 <2c0dbde8d0e65678eeb0847db1710aaef3a8ce91.camel@nvidia.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <2c0dbde8d0e65678eeb0847db1710aaef3a8ce91.camel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/06/2025 13:43, Cosmin Ratiu wrote:
> On Thu, 2025-05-22 at 15:58 -0700, Saeed Mahameed wrote:
>> On 22 May 15:31, Jakub Kicinski wrote:
>>> On Fri, 23 May 2025 00:41:22 +0300 Tariq Toukan wrote:
>>>> Expose the stats of the new headers page pool.
>>>
>>> Nope. We have a netlink API for page pool stats.
>>>
>>
>> We already expose the stats of the main pool in ethtool.
>> So it will be an inconvenience to keep exposing half of the stats.
>> So either we delete both or keep both. Some of us rely on this for
>> debug
>>
> 
> What is the conclusion here?
> Do we keep this patch, to have all the stats in the same place?
> Or do we remove it, and then half of the stats will be accessible
> through both ethtool and netlink, and the other half only via netlink?
> 
> Cosmin.

IIRC, the netlink API shows only the overall/sum, right?

ethtool stats show you per-ring numbers, this is very helpful for system 
monitoring and perf debug.




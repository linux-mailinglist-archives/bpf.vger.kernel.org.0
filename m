Return-Path: <bpf+bounces-52163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE585A3F14E
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 11:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E130A17E9CA
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 10:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4251EE03C;
	Fri, 21 Feb 2025 10:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mElo3CJ+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B5F1FECA7;
	Fri, 21 Feb 2025 10:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740132235; cv=none; b=pjlSrhxR7AHqXYDIh2NXfJWTqntnQUI2ToOZMeXqpfi7j42XgoO65rwU3RtLQA1hm84CM12Sx7s9T7hYFJjrxVU1HbaQpGaaD5Di5s7ki4rFg4fxvindRipDbLgawJ646WB5jVs8T0UdTCnXVQD+Z2JbpReGUoxxu9EdjU9F7eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740132235; c=relaxed/simple;
	bh=kdDYrB6N6WvXiJWxvXdlROQD7OkyuM6+oQ6tfN8JvYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o69DU7IAySgjrqkbiWBAkwI/ZYduxX28ATxTrUlXqSIInBxVfPblKTE3m713LDPCn3chkgIQFZgzEMTx22xqxtU/O0REAd0AGCwTaAa65k7TGwf8GG37xpBFOIFexPh65hVAEP6Ut5q4Ip7r73CzLgSgx9Gn4OcgNi57EEqqlWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mElo3CJ+; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220c8f38febso39643875ad.2;
        Fri, 21 Feb 2025 02:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740132234; x=1740737034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PWSZrirQdj8aGkv2pYC6N6bxRY9wPrB8HX8oeQhEtQ=;
        b=mElo3CJ+NxiWcTxk1m9gzt3Gtxwim4dtcrUv1CLgfEVw+NhAqCxPGcyrfjueVFD5oK
         qSAcj2i+4ZEfPzocC37EirGG3c6kgZXLMY/UnX96wcvl95k1cAZizcRBuAlz0iQm0ZuZ
         v/in/l7EIMOEEo49JUVXsx3PTA+raW0RrDine0s9+QFnmzXpjuSo6QQTQbaWVhNU5CY/
         yvHPFERXemlytf8+wuoJC27VlaYq5HPJIU0toXL6qWuyN2MY17mFDfIsy5J4i/sFeat4
         Fd63biFfFF8WfMlSh5hRGVxg2MGp2N2vyR6lJ7QDi+C/KJKYSbK7cyhfniNNVYsXagCd
         YGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740132234; x=1740737034;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5PWSZrirQdj8aGkv2pYC6N6bxRY9wPrB8HX8oeQhEtQ=;
        b=E7Occ+7iqn32hAqOqEnbVrbJSeD3PPwVlvNyBMPEosbChDwfGU65+bzNZkfiFRYztQ
         /RNHsLFIcBuI/4RuoNXlxT1/3fyPfsDR372kBQdnjDqMX6w4tn9aiwzoSt340gWAxIP4
         T4wI+c6daq2CpdQ+GwQsy+xONdzQ8BDLSBKBwkOIoOLfCN/BW6EdbUC7HsrC5QFIhrgm
         uqoI+0a7iRxpwcKyKH0oAOZWjRH/6J6LcneJn7iULGm3eKqKyTlkRWFXw5JieAINnlLS
         rVd7VpoQ0SFB9NfPakuTNubS59a7zzM58rOczTG0eUgOyMdAVd0QeslM1Z3fjCrUX/Ma
         LCEg==
X-Forwarded-Encrypted: i=1; AJvYcCUjUjAf4bH8p+w8gKHqsv5RGKdzZeqrElHHWiigwF0CR/KX1rBeGKmPT1AYPbDf/QjovTolWb7OdT5kpxNk@vger.kernel.org, AJvYcCWjdEYkI2DPkSlWaUMKNBXzXDnKEJKcNx/4fA7slswIMBe/ICs9GcrGFYIlAIc+7t5EDfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWY/TUxymTPBD7ugc14vactbCie5t9babvP1SCc8vdvSL5BofC
	/o9e5GerIVc/xCIAi2e/LV58bdQxsH2Qt8VKrRwMcnxjGUTeUCXF
X-Gm-Gg: ASbGnct9GkoebwaXnJ9i9F4N+hixB5npl186rRsR+XQpke07Neuu6CnkV3wHOtdC7aZ
	jbpCehh3kKxzJs1stBLMR//ryfBky00wQD95EU6F8TiLQIE/goXFcQdxUnC9J4feaD95QIBtqKw
	CXpCSbSRIWJup+6LikYY9Kb80GHaHikK5ut/BxX4ndFfqm2QaqvtaUU4pPcq09Jae0p26Mwpotq
	ZL+hak5Qanfy/Xrp4+OhoC/1sqabbwzZLTlQPaUGQ8hWGcrdK18afA2pvSuwJ3hc0UNGy88B7kH
	+5WnqVoPsbEYGXOJy38KeAuhCyF63z4FtZ3vi7UC0aZI
X-Google-Smtp-Source: AGHT+IHcP/adC+b4mN4jC4IWtxIovv4qFvyLf8AWMB5KnZt3UQWVacgb2YqYxya3HyAbW1QZSWC42Q==
X-Received: by 2002:a17:902:ce0a:b0:21f:860:6d0d with SMTP id d9443c01a7336-2219ff8433dmr48435205ad.5.1740132233683;
        Fri, 21 Feb 2025 02:03:53 -0800 (PST)
Received: from [172.23.162.68] ([183.134.211.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556f97dsm133849185ad.172.2025.02.21.02.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 02:03:53 -0800 (PST)
Message-ID: <3305ee5d-167e-4e32-b33f-814f3a63c623@gmail.com>
Date: Fri, 21 Feb 2025 18:03:49 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND bpf-next v7 0/4] Add prog_kfunc feature probe
To: Eduard Zingerman <eddyz87@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250212153912.24116-1-chen.dylane@gmail.com>
 <2b025df3-144b-4909-a2b4-66356540f71c@gmail.com>
 <598a7d089936b18472937679d4131286f102cb18.camel@gmail.com>
 <CAEf4BzYsGnhmnhkHdUPN8yBfbv57R9h4N2R8RcqdjhmHWvJVkg@mail.gmail.com>
 <1fb198103e72d88c45caf6ef2dd8ebeb258ad48e.camel@gmail.com>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <1fb198103e72d88c45caf6ef2dd8ebeb258ad48e.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2025/2/21 09:11, Eduard Zingerman 写道:
> On Thu, 2025-02-20 at 17:07 -0800, Andrii Nakryiko wrote:
>> On Tue, Feb 18, 2025 at 2:51 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>>>
>>> On Mon, 2025-02-17 at 13:21 +0800, Tao Chen wrote:
> 
> [...]
> 
>>> I tried the test enumerating all kfuncs in BTF and doing
>>> libbpf_probe_bpf_kfunc for BPF_PROG_TYPE_{KPROBE,XDP}.
>>> (Source code at the end of the email).
>>>
>>> The set of kfuncs returned for XDP looks correct.
>>> The set of kfuncs returned for KPROBE contains a few incorrect entries:
>>> - bpf_xdp_metadata_rx_hash
>>> - bpf_xdp_metadata_rx_timestamp
>>> - bpf_xdp_metadata_rx_vlan_tag
>>>
>>> This is because of a different string reported by verifier for these
>>> three functions.
>>>
>>> Ideally, I'd write some script looking for
>>> register_btf_kfunc_id_set(BPF_PROG_TYPE_***, kfunc_set)
>>> calls in the kernel source code and extracting the prog type /
>>> functions in the set, and comparing results of this script with
>>> output of the test below for all program types.
>>> But up to you if you'd like to do such rigorous verification or not.
>>>
>>> Otherwise patch-set looks good to me, for all patch-set:
>>>
>>> Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
>>
>> Shouldn't we fix the issue with those bpf_xdp_metadata_* kfuncs? Do
> 
> I assume Tao would post a v8 with the fix.
> 

Sure, will fix it.

>> you have details on what different string verifier reports?
> 
> The string is "metadata kfuncs require device-bound program\n".
> 
> [...]
> 


-- 
Best Regards
Tao Chen


Return-Path: <bpf+bounces-65210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2A0B1DB1C
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 17:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4F10584906
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 15:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D92126A1B9;
	Thu,  7 Aug 2025 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQP2pARf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AD126A1AB
	for <bpf@vger.kernel.org>; Thu,  7 Aug 2025 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754582219; cv=none; b=OgTQjHbmm+27KuIrLla+aUeGpU04U0/C0JuEqdjQ3SIfHVgOULTX2NWlmK2RDO6bgWUuNdAQVmYOiKS0rz+Ibdqxx2lHC3WKFlPNVvlKerJ8R4OBgu4GTp1JEo+DHqi6wUPGlwFBWmZPm7G7FhS4T0eL9CD9Z4GkKB7Jb8IAcnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754582219; c=relaxed/simple;
	bh=Mod4sbppqJFW6I4Th85h6rMcZCKXtYNLapqIpCeppLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtN9akLXyunkLBHwC11Sn748IRpGM2VyJrvdAAFFEHRg+4X/4SH4h26LHaTHLqF3XCbcdD5Uq37/yTSTnPAeUY0Ib+HGCQ6tDaMxKmOtJHOJ4gFDLtaNTc1foWAY7fUYPOA+3bGFDJofTy3UzHkQnz0DHBpfUUOsb3ZnhGETkPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQP2pARf; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-455b00339c8so8027875e9.3
        for <bpf@vger.kernel.org>; Thu, 07 Aug 2025 08:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754582217; x=1755187017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ToAtNeoshwNX488L1ak59/KtK+qCXavZIc52w5zjBio=;
        b=fQP2pARfMpzuOBTD2sdqpGSIK0ZXQsTyKKWNpv/ckN8xRwJwd0qwTtM82IsiWsL5ew
         6H7PI6G0GZHSSS+yXnGY4jy53srbSKTZO3jJHD2oqVegZZ34C46PNcAoho4flXQqRdeh
         558qEDkfEte3bjF3Z+BVf2U35Z0bulhRW5ZHVWvbQstBnkLiu8aSTGJkhgmVXDv3q5L0
         1ccb+BKo7Yrik0u/bSjmnd/UdRWyz5fsC0M2cZmM9FkSHbnilwK+co9ZPd91gw4nW/MV
         YGqBhMetJRHhdNn2H6GQGlY3c9cdc213wdpWFDF+L5+HLc7tQrrYqZ73+NZSxriZc+Dr
         lSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754582217; x=1755187017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ToAtNeoshwNX488L1ak59/KtK+qCXavZIc52w5zjBio=;
        b=cJrWcNOlfOFekGZ83XvA38cuAuLLLvS+cQFz5ownKZRWncZ6wCiKnSqXCdaceZAFfM
         Om2lwlpKWWcALlvbUEJw28hPYxE9lwmnsZuij3iICDE8ALRUzKYU64dp+6sFM0Ish0QW
         ieRTH1AULEtzFoRnCdz4A6UPDRvZN9AAModjfkUEEG82vMr5UrfKembRlMxqv4tnrt3v
         /oAInpluv7TCL+/lLBwU7pdrPVQ379hSdZ5hL30It49ucDXC1YtJ4RGdhcaOX6THEeLU
         TGdZciw5buDJIQaWLY/nKsQF7Lb3dyrMo++2FeZhnqnbGGNFXKGPZmU6zQUHsjYHU5BG
         QOXA==
X-Gm-Message-State: AOJu0Yy/IiuDFiTKWeANJZBifEygsIQO7OSIN0Oe3DNygyI/ndqAD4ZG
	CiVtG7nQMd5w62AtOA5/VOdz39G53TEDdcGs3cgYyDwxsvfzOJ/3vhIT
X-Gm-Gg: ASbGncsIpax2lwlGGAZ31B2ily0hc0NWzYpHOemhjILAoH+DcmVAq2SgsFiw6iFiPM8
	Watp2phzoDPIiaWmjkdpEIQTgFkHmOSmDoC36gwlAjRlMW1cs/86jhwxH6lLmG4GQqxwiC9dtOS
	NHuLEpbtM5PX+ry5bEFBoX3D14wmzOHesWzePo25RGAah5oOv3NC4AuhxT1Wd8fa1FaENN//CSA
	zt1kce2EKpjhtmhkoY8D9/u/3xO/i/IMUaC29CvVbk7qBmyOKbtrLfiFQObjgI2B0IFjypUfd1N
	UvibKtLWh4Xg8eg0JeI4xnJsMjWjWcc93N00hNmn6fEsd0vc9rBrGtDTWD84ebpuYorz7rS4PyE
	01Eg1HROXcYdsU4y/ijboQLnfzFmkGOnwvQ==
X-Google-Smtp-Source: AGHT+IE260H90pexDPjq/KuVUuL8jhxAV+2VqoVIhAQZ8xuHynAb7QICKhfpRE1cOh0+tERd/7WGxA==
X-Received: by 2002:a05:600c:4506:b0:456:133f:a02d with SMTP id 5b1f17b1804b1-459e70ef03bmr75432095e9.17.1754582216431;
        Thu, 07 Aug 2025 08:56:56 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8fc28a7b0sm2571162f8f.63.2025.08.07.08.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 08:56:56 -0700 (PDT)
Date: Thu, 7 Aug 2025 16:02:06 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
	yonghong.song@linux.dev,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpf: use realloc in bpf_patch_insn_data
Message-ID: <aJTN/rQxfyr5BjVk@mail.gmail.com>
References: <20250807010205.3210608-1-eddyz87@gmail.com>
 <20250807010205.3210608-3-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807010205.3210608-3-eddyz87@gmail.com>

On 25/08/06 06:02PM, Eduard Zingerman wrote:
> Avoid excessive vzalloc/vfree calls when patching instructions in
> do_misc_fixups(). bpf_patch_insn_data() uses vzalloc to allocate new
> memory for env->insn_aux_data for each patch as follows:
> 
>   struct bpf_prog *bpf_patch_insn_data(env, ...)
>   {
>     ...
>     new_data = vzalloc(... O(program size) ...);
>     ...
>     adjust_insn_aux_data(env, new_data, ...);
>     ...
>   }
> 
>   void adjust_insn_aux_data(env, new_data, ...)
>   {
>     ...
>     memcpy(new_data, env->insn_aux_data);
>     vfree(env->insn_aux_data);
>     env->insn_aux_data = new_data;
>     ...
>   }
> 
> The vzalloc/vfree pair is hot in perf report collected for e.g.
> pyperf180 test case. It can be replaced with a call to vrealloc in
> order to reduce the number of actual memory allocations.

Given that I am in any case looking at the code around,
I've rebased on top of this change and tested it:

Tested-by: Anton Protopopov <a.s.protopopov@gmail.com>

> This is a stop-gap solution, as bpf_patch_insn_data is still hot in
> the profile. More comprehansive solutions had been discussed before
> e.g. as in [1].
> 
> [1] https://lore.kernel.org/bpf/CAEf4BzY_E8MSL4mD0UPuuiDcbJhh9e2xQo2=5w+ppRWWiYSGvQ@mail.gmail.com/
> 
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

[snip]


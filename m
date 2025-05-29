Return-Path: <bpf+bounces-59287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F79AC7D43
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 13:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BF5F4E3EEC
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 11:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558DC28F537;
	Thu, 29 May 2025 11:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O6Y3iUYD"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A508028E60A
	for <bpf@vger.kernel.org>; Thu, 29 May 2025 11:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748518563; cv=none; b=i+hd1nSStxBdxrS6y1qbe1AapBiz4hHwT9qkG2c0Cdv6UQXSlTfVUqwf0XAskM+mGp8k3rBLzxc3DC9yGeAA3WkkE4IebxquwyotWallGIlyrDD+jmHjyfyfz03VFtqVfa67OVFUQ1+Wv+LUUSb+Z1XCehc6UBixE1ER6/eVw7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748518563; c=relaxed/simple;
	bh=oVudUYe3FOIi84jTCtMJ8uBulEo+m2KLVU/niW5iNI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P/EYLi81sW/cmkVF1nu43Crv8kFlz7AWEFKWVssnGBRuEViK5nwHm2eMKjgJBkxJYigBMe5faH6xAFj925Ghvz6WQqpI/DldLskVmjQqkVRomnR69i6OEBYobwbPzi3Cn86yt9a9yOv754QjnDStKnV+hgGXwOGPStqqZDJ0Uk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O6Y3iUYD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748518560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uzu05Mxo+1QpUt+8vUm9Wkc8fJoW6BnlrR/DigvGQdU=;
	b=O6Y3iUYDe2/v4T8QSsccDxw71yqX1evuwEOgG7npfceqPExhj8XNGTi2g5GsZxcz38/YhH
	B3G82FKBEjuBZfLCAGevg9WrRseeM359lM8V7XQhcjcouzRzn/ryZ/f7OC/aEuKKdN4n2f
	VGp+LBc3eIvgsmbnudvXiycNWaRaZWk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-YRizF_47O3qwzkv7mA_MGA-1; Thu, 29 May 2025 07:35:59 -0400
X-MC-Unique: YRizF_47O3qwzkv7mA_MGA-1
X-Mimecast-MFC-AGG-ID: YRizF_47O3qwzkv7mA_MGA_1748518557
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-450cb902173so3819375e9.1
        for <bpf@vger.kernel.org>; Thu, 29 May 2025 04:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748518557; x=1749123357;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uzu05Mxo+1QpUt+8vUm9Wkc8fJoW6BnlrR/DigvGQdU=;
        b=LRdq075TwRRt49IuLFG+IA+QIMvgMvJaZzXt8I9Map8d1Uy6KA8sQTpJ9McwJuFXyJ
         bI7xMxx4vhJhq1dyz39dK8UT+JXjmJDSEHO7U+EeC/ZokgcYwyJ9HvJQtXMJi8QAdoR2
         NCBnH1+HBJ/Qd1BBDuL0q6RLUaTD6w5kJP1uCjAZOCd9ko14wemN5lSvaU+xPCDf3eiN
         ZS24FTn0WTReCmKbyU3fbfHrU3z0dLItwAPSoCduzcPe4AnEuK/oroCYxLt1fyl8htjy
         Q9PX3trBCv+QqBZLc7aUEqAenhefl7ABVpvm0JChLSZGL7PIE2dTDoBlwEMa8JYTzIzs
         1G9g==
X-Gm-Message-State: AOJu0YxhUQN2eKk8F1TIrQRadYqqWH2mVh6g9/TFiY6IYf1LfpG6ZCts
	5I+lXp7rnqaaJoPh4p7A420XMfr8Wvc83H7eMT0dchV7bbcNXakbe6SfbUpZjY+rgmXEosAQSXj
	i7mCn7mzFO61JYxSv2Sl34k87nsF3w5z7RsaTfHCmnT/JQCKIf9M8lOX42eUgUyXh
X-Gm-Gg: ASbGnctAdtlluAPqKpYGajhprTl3pcLJ2GKlLTGaq700UU1uIC8YReOsQ35o1bdEO3c
	V/Vh88eSOQBTtsmfCA7By9/GrE811BROSDetofTtEiFj6/NpfYP70x+IK/pXPqV3c4qMHGporXo
	TmvBVR7DeYFQCT+PWBQAFTAacKTQGcAe+WAXU7JcdUPjVDIAXCs+LrwSEUBL0qi2/3QUBGfHcKh
	Qc2S4cNO15xz1AxM5iXDg3IUcnHh0NS0HeQknx/egaCA6tSq2Dt6mvNm+jJSXLrvPsQo8IiPivl
	v1ViKEGGe8dFO1bSXePQKbvPVrhk336iHbL8BM9PPv2a+Qmt5ZQ=
X-Received: by 2002:a05:600c:9a3:b0:441:bbe5:f562 with SMTP id 5b1f17b1804b1-450ce897d17mr21074335e9.16.1748518556765;
        Thu, 29 May 2025 04:35:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1saTfp2/vBKshNA0ijt79U3HmcD2AFa5Dm2K5wO45KCx7WyAIct8E3zr0cRi1rjgelfWX9w==
X-Received: by 2002:a05:600c:9a3:b0:441:bbe5:f562 with SMTP id 5b1f17b1804b1-450ce897d17mr21074125e9.16.1748518556347;
        Thu, 29 May 2025 04:35:56 -0700 (PDT)
Received: from [192.168.0.227] (ip-89-103-124-216.bb.vodafone.cz. [89.103.124.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450cfc6795asm17375455e9.30.2025.05.29.04.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 04:35:55 -0700 (PDT)
Message-ID: <c97284b4-cac8-4dcc-991b-d535694f31c5@redhat.com>
Date: Thu, 29 May 2025 13:35:55 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: Specify access type of bpf_sysctl_get_name args
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
 Yonghong Song <yonghong.song@linux.dev>
References: <20250527165412.533335-1-jmarchan@redhat.com>
 <m2ecw97mxn.fsf@gmail.com> <2b5f6cd0-2b5f-4687-ad43-73a7be8fbfd0@redhat.com>
 <m24ix43cxd.fsf@gmail.com>
From: Jerome Marchand <jmarchan@redhat.com>
Content-Language: en-US
In-Reply-To: <m24ix43cxd.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/05/2025 18:41, Eduard Zingerman wrote:
> Jerome Marchand <jmarchan@redhat.com> writes:
> 
> [...]
> 
>>> Looks like we don't run bpf_sysctl_get_name tests on the CI.
>>> CI executes the following binaries:
>>> - test_progs{,-no_alu32,-cpuv4}
>>> - test_verifier
>>> - test_maps
>>> test_progs is what is actively developed.
>>> I agree with the reasoning behind this patch, however, could you
>>> please
>>> add a selftest demonstrating unsafe behaviour?
>>
>> Do you mean to write a selftest that demonstrate the current unsafe
>> behavior of the bpf_sysctl_get_name helper? I could write something
>> similar as the failing test_sysctl cases.
> 
> Yes, something like that, taking an unsafe action based on content of
> the buffer after the helper call.

Alright, I'll do that.

> 
>> I'm thinking that a more general test that would check that helpers
>> don't access memory in a different way than advertised in their
>> prototype would be more useful. But that's quite a different endeavor.
> 
> That would be interesting, I think.
> Depends on how much time you need to write such a test.

I might think about it, but ATM, I just don't have time to do that. If 
someone is interested in implementing it, be my guest.

> 
> [...]
> 



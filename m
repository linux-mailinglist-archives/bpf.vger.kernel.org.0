Return-Path: <bpf+bounces-34879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D026093208A
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 08:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B7D21F223E5
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 06:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1041CA9E;
	Tue, 16 Jul 2024 06:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndHF7piJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAFAE556
	for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 06:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721112381; cv=none; b=qbYX5YC85Ihse42uApSbCjrTCfvJYBgwuS9HFTzs2rKLIobaKGAYZ39v04MEYs0D7sQXLtwCKSBW7KG5nO35FeHkPWBtTOQTdGgu9Rv2Q3IRVCANjkJrCxU13eH/sXFBRPORgT25FuZXzZ4GIMGpgvlic97C0RirIFYDfXghrRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721112381; c=relaxed/simple;
	bh=6tDGVjIzmtBzHyugGLmnm4BHc/foSaOVq0EoQcYrGYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b6HnKBJZQtgic+ZObECiNqO6m2pqN7J7JCBJwHF3i3B5s5TNAXK7byYPctlTgDaUa+3N9bGOf7lOz091qsfExLYqYVhvCMDjL0Tq6+MZMP2gsERHsDDV/JjGe3W5m+sb6OhSWOyYrEBZlGx+aA0Mdy1+4doFocFO6xLcmFODhKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndHF7piJ; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-65fa21206b5so23605637b3.3
        for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 23:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721112379; x=1721717179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ENHQbO7KQAdaGaUXwYWNrzJUlsoljyfuz78VE6h8mTc=;
        b=ndHF7piJpl0vwsJ9biz7u5i0qt6U48clCnXguRCo5LjK0jbOEfiIbfdlp/9Kfkj57W
         QCij12DIxpidWQQL//BxreeIwzkZPohx2SCAmzOBcWE41sVLo3dGqQ2pGslrJDpn2Xc2
         j4OY6JyTMqTV4S1CDwsS+d9xnoYo5D/1pQRJWfs/W6X/z3E5caRG8V1eeDNaZC1yFoxw
         rZMAfK1Aj5cKIk0Kh1N88v76LzhKUC9mz6lIWl1KzB6Iun4gOzfkDfk7ZbfD4/wbcCXI
         upBSAe2W8wZtCrwKpCiFrU+MsOWc3LfZuCysiF0xQS9UkeP61kwR+yC8E4sxy92H23Cz
         GV4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721112379; x=1721717179;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ENHQbO7KQAdaGaUXwYWNrzJUlsoljyfuz78VE6h8mTc=;
        b=vFcBvpq9UkapO931nCSCtwzx5mJgCo1FoGH6/cAsaE+KUU2cZoxMzPzr3v5hSElWhZ
         IXXVv0sSuwi4uVRxqVPTR7ShdQBRavb97wfDwZ09fi0FoZVdM9hI1Wih508oivaGuThV
         WHgaVSF1qhxit4nwir+im6ue/FiOmSu9r14lpkeLsL97ffElrHioGHPPNnNlrujCfsFu
         Z11icVq3vFEE1IHdS4ucg/US4WICew3s2ktpuJnr0sMWIX+sqJ4hebLHthCqzqrh0C3q
         pMOgUsY3qijxYDxrHAUKoSU3v8gJV+qgGfDgLX1EEisCoVvi0TQeCpem24cTfVEnuL09
         sUyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUc0xWpic5J3qPs60v3E/nglJ1IgRO0p7nfVl3W4ixfViOZZ9/lvi5JWZGiiOBjeOkpdA5TgJgnapF/JIbH68LBxmKs
X-Gm-Message-State: AOJu0YzqGkN+chiOoBUqW4iR+SZy371nw/WVKccFyy/ORkh+fnLQeAnY
	TWFj5l3VIb3gjlKRFTanNU3StKrK4AGt8xV18Pm1QsWgrlsdYSTr
X-Google-Smtp-Source: AGHT+IGm8wJSmBg70zi60viyN/9EGKaXKlcDkMxYmqTGeS8pGaOPF/htTNSHzrX/3MAO6Dptqhxzww==
X-Received: by 2002:a05:690c:d8b:b0:65c:b1ef:2a14 with SMTP id 00721157ae682-663818cf422mr15440357b3.47.1721112378902;
        Mon, 15 Jul 2024 23:46:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:9e31:e627:eb50:ccf1? ([2600:1700:6cf8:1240:9e31:e627:eb50:ccf1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-65fc2af4232sm10559437b3.70.2024.07.15.23.46.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 23:46:18 -0700 (PDT)
Message-ID: <ce96aa60-bb14-498f-b996-ab906a3b9f0d@gmail.com>
Date: Mon, 15 Jul 2024 23:46:17 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/4] monitor network traffic for flaky test cases
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org, kuifeng@meta.com
References: <20240713055552.2482367-1-thinker.li@gmail.com>
 <ZpWVvo5ypevlt9AB@mini-arch> <4c658385-dc3c-46ff-a868-0159edf84dc1@gmail.com>
 <940fff33-ed2b-41e0-bac6-d388deda9446@linux.dev>
 <528a8c8c-159c-4fb2-9c4c-c9c9b2e585df@gmail.com> <ZpXoODGNDyhnyeO8@mini-arch>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <ZpXoODGNDyhnyeO8@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/15/24 20:25, Stanislav Fomichev wrote:
> On 07/15, Kui-Feng Lee wrote:
>>
>>
>> On 7/15/24 16:56, Martin KaFai Lau wrote:
>>> On 7/15/24 3:07 PM, Kui-Feng Lee wrote:
>>>>
>>>>
>>>> On 7/15/24 14:33, Stanislav Fomichev wrote:
>>>>> On 07/12, Kui-Feng Lee wrote:
>>>>>> Run tcpdump in the background for flaky test cases related to network
>>>>>> features.
>>>>>
>>>>> Have you considered linking against libpcap instead of shelling out
>>>>> to tcpdump? As long as we have this lib installed on the runners
>>>>> (likely?) that should be a bit cleaner than doing tcpdump.. WDYT?
>>>>
>>>> I just checked the script building the root image for vmtest. [1]
>>>> It doesn't install libpcap.
>>>>
>>>> If our approach is to capture the packets in a file, and let developers
>>>> download the file, it would be a simple and straight forward solution.
>>>> If we want a log in text, it would be more complicated to parse
>>>> packets.
>>>>
>>>> Martin & Stanislay,
>>>>
>>>> WDYT about capture packets in a file and using libpcap directly?
>>>> Developers can download the file and parse it with tcpdump locally.
>>>
>>> thinking out loud...
>>>
>>> Re: libpcap (instead of tcpdump) part. I am not very experienced in
>>> libpcap. I don't have a strong preference. I do hope patch 1 could be
>>> more straight forward that no need to use loops and artificial udp
>>> packets to ensure the tcpdump is fully ready to capture. I assume using
>>> libpcap can make this sync part easier/cleaner (pthread_cond?) and not
>>> too much code is needed to use libpcap?
>>
>> Yes, it would be easier and cleaner if we don't parse the payload
>> of packets.
> 
> Yeah, same, no strong preference; was just wondering whether you've
> made a conscious choice of not using it because it definitely makes things
> a bit easier wrt to the part where you try to sync with tcpdump..
> 
> Also +1 on saving the raw file (via libpcap or tcpdump -w).

I agree to do it with libpcap. And, will print a number to stdout/stderr
as an index to the packets in the raw file. However, I need to figure
out how to make the raw file available to developers at first.



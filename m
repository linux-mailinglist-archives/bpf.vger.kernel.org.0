Return-Path: <bpf+bounces-48685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FA3A0B992
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 15:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE33616276E
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 14:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767FC2451DB;
	Mon, 13 Jan 2025 14:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pl9v3cKR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8014D8CE
	for <bpf@vger.kernel.org>; Mon, 13 Jan 2025 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736778832; cv=none; b=qm9Al6WnGdj1QabeeYYPGU0F8qcnOZEW1fto4M0/6I8cPwPi5PaLGtAHt7SvBwhXp61Ip7Cku31TC2tEyq34XH+IB0bOVSbmsRCapje+4uHiSchDtg+EOJfXhorVa3LmYScGSPIErg5I9vgyttXpb0KS131eixnzneLqI5IldEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736778832; c=relaxed/simple;
	bh=UI5UyGHuHx/kdjWc1ifSNCtnWW7AKfhnT+stQLJgjJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W/09buYanJtg5FARQyrzRZgHm28ju/AfDFeKuLWOUsTAr7lz3iYXqS9QaZwa0w/vsPtkfUTlam9nci/IunmEz5oar3GXU9/vebPc/zzeNi6K+uVBnGEx7XUna0J9QYUFfBuxHgdE4jECRSp5E7S4HWh1s8KaU2G42paMuzjv9JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pl9v3cKR; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4361b0ec57aso42091955e9.0
        for <bpf@vger.kernel.org>; Mon, 13 Jan 2025 06:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736778829; x=1737383629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MqbC9h0hn607K4Ewdqlu+9qs+7+DikbnXyIiUIob8m8=;
        b=Pl9v3cKR/Y9zStQ0pSc57YUmGwD+yPW8ate390qUQivSveNhc1Z2qyIqcrdje8VNxm
         G2esWiHsHHKMHF5EGEfsIsfds4vmKxv8eth6Ef7wn8/LeW+ghaXr4qr1M+zaBAbjzsXd
         nYMXC3vapiaCatwGIqBd+JLPMxgZZXky+/xTWjFmdV0smDpvCRYxHx+pcyIZa9cyfur1
         Vibgq4xvvbooacmoBL/H6HgYnuiPl7NLW1nFvu2XMNasxYBuw80zGdamsIhQlhkPXKqa
         n7yv6zMB4yO3EEJE7jof3jpA9k79fJeDrSRU2Rq7jsSGw6I6FzsFepuJDzn9AJpPlR88
         XjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736778829; x=1737383629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MqbC9h0hn607K4Ewdqlu+9qs+7+DikbnXyIiUIob8m8=;
        b=ZmJH0I4o6875go0i+ZSuhsBrCkY1k8Yk34om/pd0NyGwRD9Y6GOFY354l5gMSVY8MC
         4CyyyL/Z+zt3XOikP0vXUoVaWuaDdtwvP2uOdS8mc+ElmS3CMoX7q4uFuHfb9yRt/KrN
         tA/XNITY3HPdsMJQ2OajUSy8SYEajE3zX3OJ4XCjNRTZWX41hf+nCnYcoHyveabYh44x
         AIvtqF5D5GjqQuzKwd3YVyxyeBORdcHtV/Eqg52+QAvm+kZqmKG2/Kkd5+wKxZt8Aqsg
         k2W4tBS++D4UjhA2j6e9KESYw1Pi+8rnj8naQOKR0BhNRBodKyizQLO0WQIE+iMNuHGz
         3UQA==
X-Forwarded-Encrypted: i=1; AJvYcCVk9K97vj4wTiJJR8B905TfZOE+oXYqcZ+vqRm/64V55JLlOifzn9l3g85RYBuH8uqB/FY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLmG4ypq0gLHn6QCbPDm/XB4BOnNYY1Vg7W4pQLi2+W1WksvFW
	J9oq1FcefQLx4pH5kMaCj8o9aeHG5+bYCkqsvbA6xgj0KkzCqzu+mdLZU8x+a1w=
X-Gm-Gg: ASbGnctONEvuIvyDFbi6EohUlcpGzlViDjJxro2JDNpAU1rh+eFjG1s83nS36hLnwiN
	c27t/63MH2jXNXR1jFEBLJC9JBGJEA3tq5mvlJHapY0d0RNBuWHPGr2J97nZzuzzq0dH4mZOjZe
	cGFxoknkxHj/7d4cNGBGa7yFXpLc5P3O8zr9cpMXcfALUM0VXUF/VSTDT7HZQlUQnpowhKureKR
	4IRppp7hLmPrqHyDXYOudyZk+VHmXeICjYNqt3u1gUcgOAKqjEYT9FxdE+j63+/7Jep
X-Google-Smtp-Source: AGHT+IH09rhSt7io4S7fN4A/EBvnW9x8LDmprwxYrp67xLY37+QhpKW/LvjLTHUaqq4ASbZ5AEkR2A==
X-Received: by 2002:a05:600c:4511:b0:436:5165:f1ec with SMTP id 5b1f17b1804b1-436e271d428mr208866655e9.30.1736778828577;
        Mon, 13 Jan 2025 06:33:48 -0800 (PST)
Received: from [192.168.68.163] ([212.105.145.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9e6263fsm149061365e9.39.2025.01.13.06.33.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 06:33:48 -0800 (PST)
Message-ID: <5ea201e5-6ab7-4935-a8ce-20f67f3193c1@linaro.org>
Date: Mon, 13 Jan 2025 14:33:46 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] perf: arm_spe: Add format option for discard mode
To: Will Deacon <will@kernel.org>, namhyung@kernel.org, acme@kernel.org
Cc: catalin.marinas@arm.com, kernel-team@android.com, robh@kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 John Garry <john.g.garry@oracle.com>, Mike Leach <mike.leach@linaro.org>,
 Leo Yan <leo.yan@linux.dev>, Graham Woodward <graham.woodward@arm.com>,
 Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova
 <vmolnaro@redhat.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, irogers@google.com, yeoreum.yun@arm.com,
 mark.rutland@arm.com
References: <20250108142904.401139-1-james.clark@linaro.org>
 <173652065683.3245172.11665292685923367751.b4-ty@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <173652065683.3245172.11665292685923367751.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/01/2025 4:22 pm, Will Deacon wrote:
> On Wed, 08 Jan 2025 14:28:55 +0000, James Clark wrote:
>> Discard mode (Armv8.6) is a way to enable SPE related PMU events without
>> the overhead of recording any data. Add a format option, tests and docs
>> for it.
>>
>> In theory we could make the driver drop calls to allocate the aux buffer
>> when discard mode is enabled. This would give a small memory saving,
>> but I think there is potential to interfere with any tools that don't
>> expect this so I left the aux allocation untouched. Even old tools that
>> don't know about discard mode will be able to use it because we publish
>> the format option. Not allocating the aux buffer will have to be added
>> to tools which I've done in Perf.
>>
>> [...]
> 
> Applied driver and docs patches to will (for-next/perf), thanks!
> 
> [1/5] perf: arm_spe: Add format option for discard mode
>        https://git.kernel.org/will/c/d28d95bc63cb
> [2/5] perf docs: arm_spe: Document new discard mode
>        https://git.kernel.org/will/c/ba113ecad81a
> 
> Cheers,

Thanks Will. Arnaldo and Namhyung, are you ok to take the Perf changes now?

Thanks
James



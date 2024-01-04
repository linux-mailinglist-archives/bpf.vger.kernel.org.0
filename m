Return-Path: <bpf+bounces-19071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 525BB824A5E
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 22:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E25621F233AB
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 21:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3AC2C847;
	Thu,  4 Jan 2024 21:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bZRT78KJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95BD2C6BA
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 21:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-67f9ace0006so4067846d6.0
        for <bpf@vger.kernel.org>; Thu, 04 Jan 2024 13:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704403960; x=1705008760; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DpIPI5Ed7cmWRlguExtM65PCJHH1IGt9s+3fOm8lXEg=;
        b=bZRT78KJmeVJ58+RVIE5bTTWT1ih5vDwWGJ37K+k6DNt/XzYGn/n9sejqnp5D2AJ/S
         hLNJRmJqEKm1ohPylp1A7ibN2PL5Befb9lcPas6Kr+e64huFSGGqi166yPhVUsUl49js
         5cQyZA4id3muw54tbzLQygADKOw4mOoBwjUFt3vpbChah86UtwHc77fEKUP58YS0BwXY
         OsTOEIfnuyTmrguLYjaQa1s6+lJZK0H8BoxYFZiZZEvF3j6by5AxbUPw0J/8H5rmWkzj
         YAdBkgfsphEcN33JAPwWRVDRz+TziT1/2vCzefuLKLw+UPrmFg3h2Gnbt/bjyh5/YHnZ
         hU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704403960; x=1705008760;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DpIPI5Ed7cmWRlguExtM65PCJHH1IGt9s+3fOm8lXEg=;
        b=GQbqyizBjlf0X7ophEMNPkm0nB7AfKNdDHCPBMwXw1QJSxQKKsehGK48wHuPKARIi1
         46RPKL7P0auxMy5qVVBl9IgdAYMIJVqbwYGCCJMF1DLg/8bC7xt8EvvFSLEmJ4hryP6T
         Vwjci3suFchfgG1XBvi0z60HhopcsF08D4bqAaFOPurX93UvOpQ69hsqmOPQ5RFqHrDn
         czrbKB2p6HckBffRSEwCMZeD35tXQ6m3dfg3Ww37OLY6SfNgreBTZ1q1eGZ/eo5iVAYs
         a4A2XCmIcwTOoG3OFKu42lU3XnkepEkKxSwtrUiNDM6vvtZsg+8WTgnrq4eIBubWXE3K
         xTHg==
X-Gm-Message-State: AOJu0YxRAuobljNauZ4Elxtv3zOaadkN6Un65VsyRFq/M4H26TDf0dWO
	EGaP838KiBcgFxUKHAEm9UfnvjYiTBQmaVc/oVw9HY7dat61
X-Google-Smtp-Source: AGHT+IHQ8kUX4NQIuMSORH9SxLZP7aB6AcltBfUpdUB7GHn56kb1zERlaKSnCAHr72huzFQcPKIR1g==
X-Received: by 2002:a05:6214:2266:b0:67f:2350:6d35 with SMTP id gs6-20020a056214226600b0067f23506d35mr1509512qvb.39.1704403960559;
        Thu, 04 Jan 2024 13:32:40 -0800 (PST)
Received: from [192.168.1.31] (d-65-175-157-166.nh.cpe.atlanticbb.net. [65.175.157.166])
        by smtp.gmail.com with ESMTPSA id a2-20020a0562140c2200b0067f24bd0afasm98136qvd.101.2024.01.04.13.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 13:32:40 -0800 (PST)
Message-ID: <d6bd59f0-ba79-4e76-9fb7-aa07f86e4043@google.com>
Date: Thu, 4 Jan 2024 16:32:39 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: add inline assembly helpers
 to access array elements
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, mattbobrowski@google.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240103153307.553838-1-brho@google.com>
 <20240103153307.553838-3-brho@google.com>
 <CAEf4BzbKT3LbHQSFwpAfoJuhyGy2NpHk7A6ivkFiutN_jnKHYg@mail.gmail.com>
 <bedf07d1-2cd5-4bc8-9e59-a96479a7ff14@google.com>
 <CAEf4BzauYF4DoQLV6AGfFcq3VgP2yi_Pd6pg2vj2Eb7Rt7j0Pg@mail.gmail.com>
From: Barret Rhoden <brho@google.com>
In-Reply-To: <CAEf4BzauYF4DoQLV6AGfFcq3VgP2yi_Pd6pg2vj2Eb7Rt7j0Pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/3/24 16:21, Andrii Nakryiko wrote:
> On Wed, Jan 3, 2024 at 12:06 PM Barret Rhoden<brho@google.com>  wrote:
>> On 1/3/24 14:51, Andrii Nakryiko wrote:
>>> I'm curious how bpf_cmp_likely/bpf_cmp_unlikely (just applied to
>>> bpf-next) compares to this?
>> these work great!
>>
>> e.g.
>>
>>           if (bpf_cmp_likely(idx, <, NR_MAP_ELEMS))
>>                   map_elems[idx] = i;
>>
>> works fine.  since that's essentially the code that bpf_array_elem() was
>> trying to replace, i'd rather just use the new bpf_cmp helpers than have
>> the special array_elem helpers.
> ok, cool, thanks for checking! The less special macros, the better.

sorry - turns out it only worked in testing.  in my actual program, i 
still run into issues.  the comparison is done, which is what bpf_cmp 
enforces.  but the compiler is discarding the comparison.  i have more 
info in the other thread, but figured i'd mention it here too.  =(


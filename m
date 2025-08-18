Return-Path: <bpf+bounces-65889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A797AB2A98F
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 16:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 783A41B6471E
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 14:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B023A32A3F6;
	Mon, 18 Aug 2025 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkOdVNId"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34ED32A3EC
	for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525630; cv=none; b=Xvxe1i1QAMjqAvB6d+zL7lRUVmcRjqg1Q6L1Gkt/H3IKvzGSWYnofPSkzsTbrRx753kmMAylvDGN6gOLbZ/x57gdc98ScI8RfSROLRXn7Y0vda9q/hicyCRA3Rhm9uQAMlz445lyEGc/0TbKP86aD/wDzkXV62+GWewVVzhwQx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525630; c=relaxed/simple;
	bh=+uJAEmceTUCyAfCj5XAu/MGpokYU1NryEbkAyS6n4cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VY8j63cFfARnO6dMR0EKyXZ1NbzS6o1+OHW0RiYhGh64N0Hq9KZyHymc3bqKhqnQpookAfc+L8JIE5KGvY7d/1IPb5ColqlGIYcudcQs82wSBL5UIbe1uuM2VfvlG/ko0If1+xyq+mJBgC2Nqi0p7xdveEdBfJxU+LQMKKdWp/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkOdVNId; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3bea24519c0so567703f8f.1
        for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 07:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755525627; x=1756130427; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VSDAQQs/eDf6jzs9vn0KXaA6FT+dFTM2VMLiI+QImw0=;
        b=GkOdVNId/GjqmBoweWZBkdfSo5kY2LdaLKIU5p5EwsVJvEiqcO9hrvCsbw0yJqZ7Qp
         VOWr08GQfJg8eCdtu/YPuz9Ogsk4WlWfpCEu71LOF2WCIFvBkd4YsTy/b/JYW/bZ66zq
         LMVT4ds1AFt7pWKAeRNVNxBYVRhJvIJE80ehX8yCSii0ipW6+C1cBAlj4EjZtFEqcaJq
         Q+KGy3NWuYVajCpAGWGkZhLSEyUBPdT0IASXk0OpyTFTCCFlxiHS16aO2YpKRlPvea5p
         kyHF8Bchjuk4yzqS3RzHEM9mJCDXMHayBGo//knqTN8Y+BfwOpLtpNJROmHfWCJTck3h
         X7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755525627; x=1756130427;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VSDAQQs/eDf6jzs9vn0KXaA6FT+dFTM2VMLiI+QImw0=;
        b=rWetwjqyvYqR5W0LHvaPQX/pZ0b/QzJC5T+zIkk4d3Aiu9FjICmfegkiw10eBeAZNl
         z9dNQJusurbeC2EwOKTBeyQa5lrW3UPm7hVQDxI0q4plresCWgPWmwqzveyNCAssRs6t
         JOpedUgMyw2jxVC7dsTebZGEkaMREcL1ZjBXW1dY0QruqKFvhEg4KkChKF3/lTo/w9e4
         9dOo1ZSzhexgq/qcW0cMwyzXh9Pujrlj9Q5rADJ8vftATV3GEd3AMzm4hx4o6zclaxJf
         uWHV6tQBhZqpuBjEPv0GvfJdCIgydxRSu46JNR83CXagrW7E/UqwH/wbnZ6f+mhhEn8h
         8Nfw==
X-Gm-Message-State: AOJu0Yxh1sX1TJ34MOXNdQzWXr3aaFby7aq+KOqagtyOM+l/U905thNr
	mGOmawfi32uc77Luz0D+6hTTeBQh1TB+Am2Y5lbeP+zEqoJBDwq4S/b9
X-Gm-Gg: ASbGnctqITZ7Kse/t7QDEN03iDC7IN2aZ5NtbTZDSG1WOdWDao0bwdH6MXugZWYK4uN
	s1Jzr1vywtbL6urhluMMBszDWjDtRzdaOGUH4tcj2KcgZhwIrXpcyhrJrc9DBmM8jPw2n4ryIoT
	1+24EdRjfkjoQ8YTI5hwCrISXZ4HFMb0gendjuq8HUDfDEkPlSmi4H+ulZhup8yMpadA3JZ7oUy
	PS8qMlgcPTB8Grts3pwHqwoDlHOmOFZLRO8Yny9gC4Xrd7y4GvaWz5H6Ka1LnBy66+ED4mG1Zx0
	+RB8Tuqh8T78nGOTrwcQhfKf/9/d/m1VFjuKMR2icsM6vlvuNVWR+emX3W7ZnbfOfx57xusdEsH
	0BRUfyypPHY0eMzp+jVLvUXhNR4MooQgwLScFpNahSFGmSGnEmDUWGK0I+YcGWVe58kd4T9g=
X-Google-Smtp-Source: AGHT+IGpI3MhtsraG8DZwmW1iNOMsdxlcvio/Sd6lXrtm9sglVY2G8/vJ1OgPmieTDzeNJ3ez4BAyQ==
X-Received: by 2002:a05:6000:2287:b0:3b8:d25e:f480 with SMTP id ffacd0b85a97d-3bb4d619c81mr10195865f8f.29.1755525626644;
        Mon, 18 Aug 2025 07:00:26 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:14f1:c189:9748:5e5a? ([2620:10d:c092:500::5:7223])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bc5e232534sm10617816f8f.24.2025.08.18.07.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 07:00:25 -0700 (PDT)
Message-ID: <8e1ed2ae-bc2b-4ffc-81cd-61ad6878ad0d@gmail.com>
Date: Mon, 18 Aug 2025 15:00:22 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 mm-new 5/5] selftest/bpf: add selftest for BPF
 based THP order seletection
To: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
 david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org,
 gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, ameryhung@gmail.com,
 rientjes@google.com
Cc: bpf@vger.kernel.org, linux-mm@kvack.org
References: <20250818055510.968-1-laoar.shao@gmail.com>
 <20250818055510.968-6-laoar.shao@gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250818055510.968-6-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 18/08/2025 06:55, Yafang Shao wrote:
> This self-test verifies that PMD-mapped THP allocation is restricted in
> page faults for tasks within a specific cgroup, while still permitting
> THP allocation via khugepaged.
> 
> Since THP allocation depends on various factors (e.g., system memory
> pressure), using the actual allocated THP size for validation is
> unreliable. Instead, we check the return value of get_suggested_order(),
> which indicates whether the system intends to allocate a THP, regardless of
> whether the allocation ultimately succeeds.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  tools/testing/selftests/bpf/config            |   3 +
>  .../selftests/bpf/prog_tests/thp_adjust.c     | 224 ++++++++++++++++++
>  .../selftests/bpf/progs/test_thp_adjust.c     |  76 ++++++
>  .../bpf/progs/test_thp_adjust_failure.c       |  25 ++
>  4 files changed, 328 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/thp_adjust.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust_failure.c
> 

I think would be good to add selftests to make sure the bpf programs are working
after fork/exec as intended.




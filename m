Return-Path: <bpf+bounces-63633-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E92BB091F7
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 18:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 023233A1212
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 16:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716A829B8DD;
	Thu, 17 Jul 2025 16:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxeGQaDs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657431DA62E
	for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 16:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752770159; cv=none; b=kjL7jA+WDLJcrXntRFZ/d8N2Upiq8QJtLK9WQhdPM8gwT79jLItQnElMLqEEx4DzQnC8lWryOknVNOhbpIpMP/hHwIcGA/I8+aYiLlcSiQjFQ6ynm1oH/xjyGBnykGoNM7dSF+E3m5vlEwXwdyWcW4meU0DZu3ub/zVZKFMnwqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752770159; c=relaxed/simple;
	bh=dTLnno1AhaKearUKhP90Ft84cOek/Y2VDFH1kOnOp4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YFTwx599hVtl655F8In5TWUqqlZffZepxOudyyR4OcytDdsOFUc5c4uYqdLDIyS5YhxKA4f3Cng/Cbneh4kku2IliW4cGkBbQjYcEuc/+XQhubqzaH+4nMcLNFUzKz8jrxyQ2PZokrxucd+drFNazpyANFeqJmV9WyZSZuDORhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxeGQaDs; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-60768f080d8so2161466a12.1
        for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 09:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752770156; x=1753374956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mud9ZW9D23VVGQysk0WZGrHgq+BLZ/Q4KecZKEcze9s=;
        b=gxeGQaDsAIM3EFYVuaapMKVOxkRP5W8x9mBqqMHqRsCbDx2bgUDWOEYYSlbHHja67N
         NJjk0lKvjBU/j6KIGFiUioqPpbo2Cn7RA/Qa7aEbCBhiGLUiwJSedUu8iU/ZCDzMeUsJ
         NG1emdxlVrd1NjVyqEohVlG7trv5XsWAazfe4kjuRR0jYnwys6rIjOy49VJ5mcQ5U3Nt
         +YkaD5pnD0z31wvM+MbT5DLvAqarUt4inCF/vDk57y6v7wYNhOaaCTfYVACd2El4Opi5
         RaOuk4Om/FOS5sbZfIZkyH2uffhEVDPH7ePd0P/Mst58RON5sox4aSGgINGL3SC7Py5d
         Yijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752770156; x=1753374956;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mud9ZW9D23VVGQysk0WZGrHgq+BLZ/Q4KecZKEcze9s=;
        b=fPFLZX/5yMEMJFFrD50Z7Xy5C4Tg/7TEih645WiBS6A8ckNmptSCrxuNshBi4V3xoy
         K9kvWAoupoN7EuiRuoQ00b1sj123MUe9rmf0FMhkekKbQPKZp7NIs/jMgxw855+fypM7
         afwaWI14pd0Uzt4LqscpK2NoFHSFdt4nNuPZoNq23DOEAuJy5GPmp9CqIP/VqVrgstVo
         OR1USVYlj4iDiJhe12ZYqn7i7qUlWJzG0fIXInXYyHatlaV9jS2jAHfIsi9bpKiPpF3B
         59Mzjmx69YF6VPJ2JWeognhq0qrSY9QP6CHEqwKZWS5jobvtY5wftKLkWirSDRSpPlkS
         /T8g==
X-Gm-Message-State: AOJu0YzbILNUBwwf9Xq5wz5Khm1/vkvCURA064tXR3smo4k5D29oCLXK
	ktzI3dmwKIxYtD/U2yA0ApS4s0FjicLGCX00mHgUOmtWP/DbmNsZZxec
X-Gm-Gg: ASbGnct+A2NuLWrIuf/GuLHDu7wXQN1697jepurYzpAykM7HoP8gYuXXYtDPzTJ1rWX
	PTRtH06R1jrps6drpt0m3MC8BD/ichC5owUG06KLIS3tjSouWgt2BABqeaipp2+2xbZ1a5t3Eid
	Makfcrj7feonlmZRww1mZ2CgooZzFAfl8Rfci1kYPugOA0THb4gfMtUY85tRv5BzHUI0DXg0uo9
	7oSaTciKddB3DDctBZuYy0g5fPIKNH+3U1lybC2kl6j9sK+6wDd6Mtbdv3D8zL13Ax4yUwL+5Z/
	de7Qb0ArMMijggOIcEHmGaeVtOnn+9fMUMViogD7QAzEQ2/XjiWoz2kpPEWdjZLvoN4KSwMCPlu
	n4yEV4K3RiLifJNnC3eCcOx7lfznarSvVisPJB8jhqOtsIHfF2TdefeftZthLe/vwhHKQYoA=
X-Google-Smtp-Source: AGHT+IFBgpO1dldhZ78qMizaVro/b9UcedwE8r15AkVlZ9NtgfGNbviK88SfiX1efsELChRL5sadng==
X-Received: by 2002:a17:906:8f05:b0:ae3:7b53:31bd with SMTP id a640c23a62f3a-ae9ce07df79mr729775566b.28.1752770155517;
        Thu, 17 Jul 2025 09:35:55 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:14f1:c189:9748:5e5a? ([2620:10d:c092:500::7:8a92])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7ee47a2sm1403683566b.58.2025.07.17.09.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 09:35:54 -0700 (PDT)
Message-ID: <e14b70a8-e49b-47e2-ad0c-f60c81363d3d@gmail.com>
Date: Thu, 17 Jul 2025 17:35:51 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/5] mm, bpf: BPF based THP adjustment
To: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
 david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org,
 gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Cc: bpf@vger.kernel.org, linux-mm@kvack.org
References: <20250608073516.22415-1-laoar.shao@gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250608073516.22415-1-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 08/06/2025 08:35, Yafang Shao wrote:
> Background
> ----------
> 
> We have consistently configured THP to "never" on our production servers
> due to past incidents caused by its behavior:
> 
> - Increased memory consumption
>   THP significantly raises overall memory usage.
> 
> - Latency spikes
>   Random latency spikes occur due to more frequent memory compaction
>   activity triggered by THP.
> 
> - Lack of Fine-Grained Control
>   THP tuning knobs are globally configured, making them unsuitable for
>   containerized environments. When different workloads run on the same
>   host, enabling THP globally (without per-workload control) can cause
>   unpredictable behavior.
> 
> Due to these issues, system administrators remain hesitant to switch to
> "madvise" or "always" modes—unless finer-grained control over THP
> behavior is implemented.
> 

Would this solution work and be carried over in fork+exec? As that is something
which is very common. How would that look like?


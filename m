Return-Path: <bpf+bounces-68909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D45B87EAD
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 07:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E2E1174690
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 05:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19B5239099;
	Fri, 19 Sep 2025 05:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="abBBmdIe"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D9F34BA4C
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 05:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758259535; cv=none; b=oiFspDHVfTY7H4fZDwS38s2Tcu7PNFTpPG/T/SH8GtO3SGZUzqohKkOd+zjRFbhZPE9hpwYaRT1MFWfjXW5WTPBuYMQuM1+lTM/adKl2JLuHvDl0VMfD1UIdZZ0+s2AMf88TbBjP4y8xqUqS6OeJUGyzCXSGj8a1fnW6fecwXQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758259535; c=relaxed/simple;
	bh=BbYJ6PNDDHE2hwVUSprLesgd4PkVaMsoJL0HbhTUxmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NsYe/0PMzxopLa2t62+54EQOtXqfFYvyC2g75zFxTBVoA6HTSFbU7otrDqQaGU7ZZeIHt+tvv/n7UgFi9Q0KohKKNJbUXR37L4JW0LKnhat7AkYFXnHi7zKnw2V5YKv6U1EILChFBv4B0n71HB1YL37O+o2/O4cshSLANcFUKz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=abBBmdIe; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <40840553-6c0a-494d-8429-863c4a6608f9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758259530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4TRmoiNiuEmpSXuYl72KqTFundN1vUHLl8vK/6rDD6M=;
	b=abBBmdIeH0vCjzOYVPsypt+ztCno+0jj6ZjZ6zahNFgUBjXqychuM/YxWhcEkThW9doYYN
	eTGmNTxE1rxbIQiyyCGZnrAhz2lHxyRIERRWwWrXKDC1bL3zSI/HMyimZS8jejuU4xZ6AW
	QiBynARm8gfAOrghMtSMZiSBnKHli7M=
Date: Fri, 19 Sep 2025 13:25:22 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 4/7] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS
 flags support for percpu_hash and lru_percpu_hash maps
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, jolsa@kernel.org, yonghong.song@linux.dev,
 song@kernel.org, eddyz87@gmail.com, dxu@dxuuu.xyz, deso@posteo.net,
 kernel-patches-bot@fb.com
References: <20250910162733.82534-1-leon.hwang@linux.dev>
 <20250910162733.82534-5-leon.hwang@linux.dev>
 <CAEf4BzZJ3fEd6EaBV5M8QX=bTtL7bx0OM1E3o5HAgCemfuFQEQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAEf4BzZJ3fEd6EaBV5M8QX=bTtL7bx0OM1E3o5HAgCemfuFQEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



>> @@ -1724,7 +1742,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
>>         value_size = htab->map.value_size;
>>         size = round_up(value_size, 8);
>>         if (is_percpu)
>> -               value_size = size * num_possible_cpus();
>> +               value_size = (elem_map_flags & BPF_F_CPU) ? size : size * num_possible_cpus();
>
> if (is_percpu && !(elem_map_flags & BPF_F_CPU))
>     value_size = size * num_possible_cpus();
>
> ?
>

After looking at it again, I’d like to keep my approach.

When 'elem_map_flags & BPF_F_CPU' is set, 'value_size' has to be
assigned to 'size' ('round_up(value_size, 8)') instead of keeping
'htab->map.value_size'.

Thanks,
Leon


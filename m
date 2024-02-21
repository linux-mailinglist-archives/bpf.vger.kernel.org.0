Return-Path: <bpf+bounces-22471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E8D85EC71
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 00:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 825A9B2537F
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 23:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFFC81726;
	Wed, 21 Feb 2024 23:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWBrcl9P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD633B2B6
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 23:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708556543; cv=none; b=dRT4ARHLUtJbpwvDH6SydSp9lYr4mPXLnM11hcUBDISf2FNyvfpqr+18eP2KJHeQla6E05frQmgrRJwVoZDzacVe8dFQqKJhA8obi+0QtT5OAJMG7+cuJDztyAodkYQsJryV6Sd8ZWvxkSk1qubYHh7oMpcqA0xNOSWAVKZOkPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708556543; c=relaxed/simple;
	bh=oxpSeprioo0zmM0nlMx8GdmIFKR9/mkecpD8z8RHno8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ayu6BUzlmdjl3PUYE7ix1ZjfgOd9iHRXuBhNIR5MjAmVizdG4W8RCUhV+35ok5fXppJBqv2NAboJ9mAGRVBPUY95u6JqVl1dZIZBOFialR77G+1f/Lou24vW/6CtdNOiQ4MAxieON2JMAivh/ZBfHK6ptrA+vCVpD9ZJHONOTUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWBrcl9P; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-607f8482b88so56300947b3.0
        for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 15:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708556541; x=1709161341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fivFSGkebmtaAuRaIOMjHbgM5sKXmOQmalHGbF19S2k=;
        b=HWBrcl9PdywkYwIOf/V9zgK9IprCqXqcheejOp2f9k10Xk6NaizuzjAa7lLdldWMlI
         M/3YSYkLdUR21k/O7CHOHiKvXOqoukxjeUIcpswSpROL8OQV7qVP7itxLDMvPDLqA1Me
         HlaRZRdgbWnOskZ4S7A7P3eAKwKaNRjFz+KToSk2HKPMxnxKMq44KWMpe37i4dSWoQyP
         ZZ89/LqIML348hpQMat7siW+jSXXE+0iJ+P3qXLU3+Ql73LygUq5E90iUrVMFH5oX+mI
         XjwsOQQyGEaCDgLKkSr16y6iS4V02kMelGOIEo+qewfCkhnr+L4ffo32/ysXlM25oSgr
         v3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708556541; x=1709161341;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fivFSGkebmtaAuRaIOMjHbgM5sKXmOQmalHGbF19S2k=;
        b=ktK3MqBY7IzRxHCTC0L6OSzexF5evbbLbHGS8JSLj/Kh0pbm1QH8G7CmwvKHk/ibr4
         9/44bptFVGEJfmkvS18pIOd4LTrjPIdP8SP/jagxlWUG0oFXKhnDrkdCzCVD5RDTbg2H
         0qHLTutqPpgMI4rNWE6Z7hg8A7iVBQ46YAs0IfoCfRn8Jd62blVDmzC20gH6pDGmoNjU
         mqnf0oroRD4Ht748L6qpnmSIYayPp1TxO5cgL++Ej7RTJrjpABL2gZr31SpEvcNfyavl
         A66Tfe4wZkvuELLsfULMHR6E1fdm80htnqBg1IDQrrzKWKf8UI57/PK84N5WDo7XX3kC
         SjqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUr9p8ckF1k5czrdYPsQuAoXqykcRdFuam9Maz/AWwtNpuNU/NmUqyFZYuG6do4zgKzqRuvNSib6JNpQAXpLRUx1Ho7
X-Gm-Message-State: AOJu0YzpRnO/JQ0poPUQ0UFjoe6u5Lvc08aFppp8kibz/EcNp/uuSbUB
	VtTyR8TX+6qKHjCDPBer9+P+snxFrIEAEhLbEg9pJ55+W91/H4Tk
X-Google-Smtp-Source: AGHT+IHorp06UTWDGEXcFdKc3uQcxIBvdjdu4GjHHnccT8FqCyMayxQimjWyuCcUg9MM2avH5Z7AKw==
X-Received: by 2002:a81:494b:0:b0:608:6e94:9855 with SMTP id w72-20020a81494b000000b006086e949855mr5401055ywa.26.1708556541147;
        Wed, 21 Feb 2024 15:02:21 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:bc3b:b762:a625:955f? ([2600:1700:6cf8:1240:bc3b:b762:a625:955f])
        by smtp.gmail.com with ESMTPSA id x1-20020a0dee01000000b0060499a24901sm2840217ywe.92.2024.02.21.15.02.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 15:02:20 -0800 (PST)
Message-ID: <4f02f4f5-7a28-4779-a9f9-6e16a99240e9@gmail.com>
Date: Wed, 21 Feb 2024 15:02:19 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 0/3] Allow struct_ops maps with a large number
 of programs
Content-Language: en-US
To: thinker.li@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org
Cc: kuifeng@meta.com
References: <20240221225911.757861-1-thinker.li@gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20240221225911.757861-1-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/21/24 14:59, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> The BPF struct_ops previously only allowed for one page to be used for
> the trampolines of all links in a map. However, we have recently run
> out of space due to the large number of BPF program links. By
> allocating additional pages when we exhaust an existing page, we can
> accommodate more links in a single map.
> 
> The variable st_map->image has been changed to st_map->image_pages,
> and its type has been changed to an array of pointers to buffers of
> PAGE_SIZE. The array is dynamically resized and additional pages are
> allocated when all existing pages are exhausted.

Sorry for not updating this part about resizing. The array is not
resized anymore. But, additional pages are allocated.

> 
> The test case loads a struct_ops maps having 40 programs. Their
> trampolines takes about 6.6k+ bytes over 1.5 pages on x86.
> 
> Kui-Feng Lee (3):
>    bpf, net: validate struct_ops when updating value.
>    bpf: struct_ops supports more than one page for trampolines.
>    selftests/bpf: Test struct_ops maps with a large number of program
>      links.
> 
>   kernel/bpf/bpf_struct_ops.c                   | 123 ++++++++++++------
>   net/ipv4/tcp_cong.c                           |   6 +-
>   .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  44 +++++++
>   .../prog_tests/test_struct_ops_multi_pages.c  |  31 +++++
>   .../bpf/progs/struct_ops_multi_pages.c        | 102 +++++++++++++++
>   5 files changed, 263 insertions(+), 43 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_multi_pages.c
>   create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_multi_pages.c
> 


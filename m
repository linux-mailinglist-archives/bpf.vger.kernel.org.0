Return-Path: <bpf+bounces-20558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74ABC840265
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 11:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039811F2256A
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 10:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA3B55E50;
	Mon, 29 Jan 2024 10:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="B4GzHVfH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D119958AAB
	for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706522877; cv=none; b=p74CBDgpPdftIfSIRslVgaLbwmjjXNu6zqHJHdJhzfk6Vqy22PfQJJf1uh4Tx6MuJpdy2PIKukkKPWNeBLxzggPY00OSrfoy+NIfC4TOJnqV+FfhxUVTHxAAg532HTmrCQgnxXNLgDa4RZTpbQD06Kw8bXGC4XuVgrwnikkO28c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706522877; c=relaxed/simple;
	bh=St64qBr8OBhyw+m034wse3G1EzsPqc2y3W+iz4Af1+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ilphTr4AV0JvMVStBuGVjdhsmX0ud07d9LKjpXzWmRPfM6eOuixL/z8FtPlrzw41dQAS07VsaluM1Q/LTS9BCvwwj3hsHq5PcbQ2tmu2kPXClexwKL87AoUVtsqoVIeE6DvEtNi2P5Y5ZfAGr7bfKgwBqMvd2t+519rcsBPuEeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=B4GzHVfH; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d04fb2f36bso4614071fa.2
        for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 02:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1706522874; x=1707127674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2rXZlsOe+udqax+UUntPGmEiCf2D1YJDQpM06ysrWNA=;
        b=B4GzHVfHDpvzKSUJXgMNADATcLebsIbIgkaHOd1vdvgtDfqzgTwcQ30f/lrUwEp7p+
         trNbgmN+orICzuw4N3IDFcANvbfsei7UGZrJfQK1/b5AtNDyOs0KZ4X3OqYo2CbtZzDM
         2g0nUkUSmAtbsras1I9cqEpaNA8aTidCsOX9Qr+BqTcINYti8M5N3SdlzGoF9y/5Rf4l
         YK3TGzoZUFHLEwolEj/yU5ToyCAZo3X0hpZXcAn0Plhb+cmyf+gSFHqBPSEwmyDqFosB
         BaDA4aqoHQ5GpozKes38j42vpB/W6/Shoh/kruq1FMBCgQ4TYtSXfxYLJ5xQVHbkRtZO
         D8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706522874; x=1707127674;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2rXZlsOe+udqax+UUntPGmEiCf2D1YJDQpM06ysrWNA=;
        b=AZG5189QZ4rtLXAe7HzDep6FsjrZr8N7bBDWC6uqy//0L9/nUL81eiWhVePXeLHIZF
         pf97ZbSGX0xHemI4uTwn37Acd+hzpyz9JofI+QLyZXnXICS8BTuXSQFseESQD3H9Zv04
         Pq0HhCsA1np4a/+RUCpmGoyzH9kLnbvOYZcxE2F4sOCJjAyNk691ETGKMm1r7Sf+cOpP
         0VyaKi6B1wbR8tkMbd1v5lrS2hGXGXG+E30Uhw4pLrCSkknncrcu9qIO8RjzX5BM4Lvh
         BtESlJIXxE7cEmAJWMk/oiXfRpO1lE6qS7ZGNGiQj+AO/PJXsrIkJbYq5caEIKi6Mqgj
         qH1A==
X-Gm-Message-State: AOJu0YwroRQAGX06nFwo//ltNPz6YscH7FRwe7r9ntcCE/YhjMHz8rpW
	mofCPlcRqzyKTMOOBVyGYPPDNwDVWP26wIuEr2FxPfYohj1TfDgoyOCWZuB8yDc=
X-Google-Smtp-Source: AGHT+IGBxUl/8W28Q82ya88NcAFs25+wvPG8Zv4KJcJbTtmgOPM3/pwUB0tRhWVOHzjraxhJOV9COQ==
X-Received: by 2002:a05:651c:c86:b0:2d0:4c65:f09a with SMTP id bz6-20020a05651c0c8600b002d04c65f09amr1663176ljb.0.1706522873640;
        Mon, 29 Jan 2024 02:07:53 -0800 (PST)
Received: from ?IPV6:2a02:8011:e80c:0:e71:7b68:d136:1898? ([2a02:8011:e80c:0:e71:7b68:d136:1898])
        by smtp.gmail.com with ESMTPSA id ch19-20020a5d5d13000000b00337b47ae539sm7713523wrb.42.2024.01.29.02.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 02:07:53 -0800 (PST)
Message-ID: <baaedcf3-1446-412c-b614-e417d691f2d2@isovalent.com>
Date: Mon, 29 Jan 2024 10:07:52 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpftool: Add missing libgen.h for basename()
Content-Language: en-GB
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org
References: <ZZYgMYmb_qE94PUB@kernel.org> <ZZZ7hgqlYjNJOynA@krava>
 <ZZakH8LluKodXql-@kernel.org> <ZZasL_pO09Zt3R4e@kernel.org>
 <ZZfCX7tcM0RnuHJT@krava> <ZZgZ0cxEa7HvSUF6@krava>
 <ZZhsPs00TI75RdAr@kernel.org> <ZbPVcsAwjE1Mtv7C@kernel.org>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <ZbPVcsAwjE1Mtv7C@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-01-26 15:53 UTC+0000 ~ Arnaldo Carvalho de Melo <acme@kernel.org>
> Em Fri, Jan 05, 2024 at 05:53:18PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Fri, Jan 05, 2024 at 04:01:37PM +0100, Jiri Olsa escreveu:
>>> On Fri, Jan 05, 2024 at 09:48:31AM +0100, Jiri Olsa wrote:
>>>> On Thu, Jan 04, 2024 at 10:01:35AM -0300, Arnaldo Carvalho de Melo wrote:
>>>>
>>>> SNIP
>>>>
>>>>>    9    51.66 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-17) , clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2) flex 2.5.37
>>>>>   10    60.77 amazonlinux:2023              : Ok   gcc (GCC) 11.4.1 20230605 (Red Hat 11.4.1-2) , clang version 15.0.7 (Amazon Linux 15.0.7-3.amzn2023.0.1) flex 2.6.4
>>>>>   11    61.29 amazonlinux:devel             : Ok   gcc (GCC) 11.3.1 20221121 (Red Hat 11.3.1-4) , clang version 15.0.6 (Amazon Linux 15.0.6-3.amzn2023.0.2) flex 2.6.4
>>>>>   12    74.72 archlinux:base                : Ok   gcc (GCC) 13.2.1 20230801 , clang version 16.0.6 flex 2.6.4
>>>>>
>>>>> / $ grep -B8 -A2 -w basename /usr/include/string.h
>>>>> #ifdef _GNU_SOURCE
>>>>> #define	strdupa(x)	strcpy(alloca(strlen(x)+1),x)
>>>>> int strverscmp (const char *, const char *);
>>>>> char *strchrnul(const char *, int);
>>>>> char *strcasestr(const char *, const char *);
>>>>> void *memrchr(const void *, int, size_t);
>>>>> void *mempcpy(void *, const void *, size_t);
>>>>> #ifndef __cplusplus
>>>>> char *basename();
>>>>> #endif
>>>>> #endif
>>>>> / $ cat /etc/os-release
>>>>> NAME="Alpine Linux"
>>>>> ID=alpine
>>>>> VERSION_ID=3.19.0
>>>>> PRETTY_NAME="Alpine Linux v3.19"
>>>>> HOME_URL="https://alpinelinux.org/"
>>>>> BUG_REPORT_URL="https://gitlab.alpinelinux.org/alpine/aports/-/issues"
>>>>> / $
>>>>>
>>>>> Weird, they had it and now removed the _GNU_SOURCE bits (edge is their
>>>>> devel distro, like rawhide is for fedora, tumbleweed for opensuse, etc).
>>>>
>>>> let's see, I asked them in here: https://gitlab.alpinelinux.org/alpine/aports/-/issues/15643
>>>
>>> it got removed in musl libc recently:
>>>   https://git.musl-libc.org/cgit/musl/commit/?id=725e17ed6dff4d0cd22487bb64470881e86a92e7
>>>
>>> so perhaps switching to POSIX version of basename is the easiest way out?
>>
>> I think so, in all of perf we use the POSIX one, strdup'ing the arg,
>> etc.
>>
>> Something like the patch below?
> 
> Quentin, are you ok with this? Then I can send a formal patch.

I'm not aware of any particular drawback about using the POSIX version
(Is there?), so the patch looks good as far as I'm concerned. Thanks
Arnaldo!

Quentin



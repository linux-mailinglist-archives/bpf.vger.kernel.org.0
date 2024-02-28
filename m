Return-Path: <bpf+bounces-22928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91ECA86B9C9
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 22:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209751F29135
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 21:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DEE13AF2;
	Wed, 28 Feb 2024 21:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="He47hXuF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF9C8624E
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 21:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709155315; cv=none; b=D5uW1f+3P3A/BOPNsyNLiM3/IPdqbSj/O8oR6Ws7nCO6yh3rX0C7yZWHIGfJ/To70I124m52Hr8Ei0jetYUemtpavJ/CauSgMv3ObMn6ijfnXqesnnHBmvWFHiE1UviBuPyav9GkVl+c3+p3jutctb+yZVnH9Y2jhhZ6R+wKM3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709155315; c=relaxed/simple;
	bh=LG3iEi3c5gxfm9L+EdP5cxl21/L0Zo8FQSrX3UvHfU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ecFyQ2wHVeB/E32MTcNWUwZp6SRVw8kmoEM3ySKIa2AnbZ/0z35dhlUZeb/TDAUkvAWwKTVAid/gGczwznMbeK+ImYE/5cOWFYlQG1Wwb5aePGacGj8iZQAitDc+2sSBpmSYkP2EJ0p6WS0cH7XUHLzoVuzYb5eNoBelpGWsDoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=He47hXuF; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-608e3530941so2405817b3.1
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 13:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709155313; x=1709760113; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r/toVCfXymfTgwl46fDfJXlmDsS72rqdnW3fYD8LTuw=;
        b=He47hXuFv+rMdUx93Z3JiZ5FwgxW/Gqv0aaGaGcUNp4jRtctxHdJlUYofGw+dM5mhP
         gVCm1qvIHhMZSAAbUnIlzi2xDYlUlKQ4IE8mCoBId1TQvFL1EbuW7A7y6btwlxnJndpW
         sYIVO4QmP5Tia/ZJzaMs3PKwukljo/rdjk9RW6CyhGTQkfQxmnB3oH4hEsFaPtcfe7uI
         lMf+IZa7TOj/+KKIQx1t2gBl2gE52PVKANdUbOvs7AzroixfHacNIyTUVnXssxe5pe+G
         816fRpq885t+uTZlfh97ogzYU9O995KY6i+BA8aIOsWtVQqfJXQb5kmTi0gv4uGaw6cC
         2hXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709155313; x=1709760113;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r/toVCfXymfTgwl46fDfJXlmDsS72rqdnW3fYD8LTuw=;
        b=DEywemAe7YfkxaFAfyOYgU2HrZIjETSq1xhyIX8vHBD4B/zBKpqUEIrMsDjQM4dKM2
         RP9j1NgQlSbW96Gz4qMaE5Nq8Q3vrfl/7G4UsC8dlbfS9eVapErz9EDUksJhM1NOYNNF
         CA9RLi3VnoZ0ddq128eDJFuwYS4kbcr7gg8rPrsw5Fwvur+kx5BWupXYaTRS8mNxVeCN
         aW6IE+zdWENqpahCqr6uzcJtQr6OIqzSuriinbJyJ0xQ04dYHwssGcIcgWABE+OXQQ2h
         5I8BphmC3XRg1d8WeLBHdhxle87lvM7pPjix4NbyuFMbAh4xcXaQ3Lf+Ig5ysd7rAecz
         piAg==
X-Gm-Message-State: AOJu0YzHvFycK4oijPGG8y8KAfax7gs8TGUmYYiwFfUG8hf7AdeE86gd
	+tSbEr0jCVUt/7zA9coPY/BFrgzbvUTlFh4AeIYD/pz8zNVmT1eJ
X-Google-Smtp-Source: AGHT+IG5sObSTtm6fXlZ9aImLux+uq+WxizADT3MsAdRsvscWsbNaU+HuttpYECgYihmwXVRd+XRpQ==
X-Received: by 2002:a81:93c7:0:b0:607:554f:9c25 with SMTP id k190-20020a8193c7000000b00607554f9c25mr265523ywg.51.1709155313072;
        Wed, 28 Feb 2024 13:21:53 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:8315:1f56:c755:e391? ([2600:1700:6cf8:1240:8315:1f56:c755:e391])
        by smtp.gmail.com with ESMTPSA id z141-20020a0dd793000000b00607ff905ed3sm72638ywd.58.2024.02.28.13.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 13:21:51 -0800 (PST)
Message-ID: <7c5359e7-737d-495b-b96b-22134776d3db@gmail.com>
Date: Wed, 28 Feb 2024 13:21:50 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 4/6] bpftool: generated shadow variables for
 struct_ops maps.
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 quentin@isovalent.com, kuifeng@meta.com
References: <20240227010432.714127-1-thinker.li@gmail.com>
 <20240227010432.714127-5-thinker.li@gmail.com>
 <CAEf4BzZFdyq1U2wNP4oZJy8MZrNPhp8zXFoC7mJwu=WYx_hCkg@mail.gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzZFdyq1U2wNP4oZJy8MZrNPhp8zXFoC7mJwu=WYx_hCkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Will fix most of issues.

On 2/28/24 10:25, Andrii Nakryiko wrote:
> On Mon, Feb 26, 2024 at 5:04 PM Kui-Feng Lee <thinker.li@gmail.com> wrote:
>>
>> + * type. Accessing them through the generated names may unintentionally
>> + * corrupt data.
>> + */
>> +static int gen_st_ops_shadow_type(struct btf *btf, const char *ident,
>> +                                 const struct bpf_map *map)
>> +{
>> +       int err;
>> +
>> +       printf("\t\tstruct {\n");
> 
> would it be useful to still name this type? E.g., if it is `struct
> bpf_struct_ops_tcp_congestion_ops in vmlinux BTF` we can name this one
> as <skeleton-name>__bpf_struct_ops_tcp_congestion_ops. We have a
> similar pattern for bss/data/rodata sections, having names is useful.

If a user defines several struct_ops maps with the same name and type in
different files, it can cause name conflicts. Unless we also prefix the
name with the name of the skeleton. I am not sure if it is a good idea
to generate such long names. If a user want to refer to the type, he
still can use typeof(). WDYT?

> 
>> +
>> +       err = walk_st_ops_shadow_vars(btf, ident, map);
>> +       if (err)
>> +               return err;
>> +
>> +       printf("\t\t} *%s;\n", ident);
>> +
>> +       return 0;
>> +}
>> +


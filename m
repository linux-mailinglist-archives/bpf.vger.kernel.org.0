Return-Path: <bpf+bounces-22821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C8486A36E
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 00:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71A2E1F23E8D
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 23:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EB855E50;
	Tue, 27 Feb 2024 23:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTInqHs9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ACC55E40
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 23:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709075790; cv=none; b=JHsbCs32pXO8uaEwuu3xw8/JY9F1owmSEBPwQkX5/8T6Z5swszToBdpS4hy3Uk+igdMVYm2UELAfQ5RPFFCV3OX8EZ8j1gM45A57JHgrexc+jJ79zZ+x5ugmebzjigP9eAZ/XzqmSO+AL1GUtMtAfjMW0jdzfUA9tIhVUM6B62U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709075790; c=relaxed/simple;
	bh=y+IZ5Y9UgSLD7wOiKc57k91zolbRYvkpCvwoaYQskn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ueGkwdd1CH+7TswuIvo++0oPrl41SaRIbOd2DBx3XExhOrdAzch1uaAJ/IdE4bBfdD7v6Xwvh1tVimaPPAFFu1P/Nd53ZXD8q0TaMnSb7xzRR7YihIltI5pVuDXtDHoA9DQi7W8x/osVH54oQs9H+qVLzgUo74yjbHxz7rFLHu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTInqHs9; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-607eefeea90so3162717b3.1
        for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 15:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709075788; x=1709680588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WXWkURj+A0cklHfYKdQP82fXncx8lUixB3fdKzK/Itk=;
        b=iTInqHs93tkBjT3HgU2Or0ZrbyCd3qLtrqjI/b74v3LysdC53kfwhoJ3C8UDd83OSn
         owQgIQSXKvVocn4Z+3aLaV9bhxNvN/F2s/0P3/eOQyqXMIsUHVP160tDOUpuEIgjfe7h
         5sUeNIYF29AsyqigZOaa9VQOZEMAe+cmdQPNaPTmF7uKCeS4lkBL5w8yQbqT2NFfIPhV
         LuUkeZJdJ7Gekh729U8Ko1jhh/HDSqeoHmsf34f6yaPWiToIr4Wc0scpioirJUGNTSjf
         /E+9oKqLyCyjeTzHKtTayUD3miyvPflsqzV79N2vTWDBgJDJKUNUdEACh7y4PI0twkqq
         Rvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709075788; x=1709680588;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WXWkURj+A0cklHfYKdQP82fXncx8lUixB3fdKzK/Itk=;
        b=QpvAYRXdiLFk8PUTsLhLxLMnWSFxN2ILUqDiURZX1vzhg/biMEsRWdYqnfdMeQ648H
         k9Bw4AselBchJBrJh2HbmPcA6Xjc7KtjN4NosToSoC894YI3UXi8ipZwciIw+Lcbz1oP
         PRZrJXyLdB1SlmEM/nM/qmuZk+JQOVd75fGxTZN6KN+mBoWQVFUjUj12j+3Agb/UKJIm
         soqfBOnFYEZlI8KVdV7L2ie+PH0tQ4AFq2V8cjbXpjrcv31VFcLx5Hx3i8CKVVBhTwfy
         9doetToSt0xvBqW5a5FoerGwm6ynzHoL4F3i62N4r78ihLiVtn6rntJ/6bRECUgMgz0x
         Mubw==
X-Forwarded-Encrypted: i=1; AJvYcCXnZXvEu41smLBKxsABdbBrC4SOQNDc79QcJemSg4tWnjtCac3KyHbRzUaeRzaf30mFnrY8Uq1zFyjwkFW92HytCO+F
X-Gm-Message-State: AOJu0Yx7MeEVslINGodTLRJ2nZSHwA3m8wgzhWFL0qBl10hkX2eUROAp
	lowpoI9UVArcBvqFh74dScFvvutqkg5ydkOzCeB5fKpfmZ6g8mYl
X-Google-Smtp-Source: AGHT+IGAMiXX+br1UTPTGjUtRtBeOurYrduTa5UtaHT7KYM3NyqcUq67D97VskYI4UUMhwtwn/qjPw==
X-Received: by 2002:a81:6dc2:0:b0:609:531:8550 with SMTP id i185-20020a816dc2000000b0060905318550mr657516ywc.21.1709075787664;
        Tue, 27 Feb 2024 15:16:27 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:76a2:1c3:c564:933e? ([2600:1700:6cf8:1240:76a2:1c3:c564:933e])
        by smtp.gmail.com with ESMTPSA id w140-20020a0dd492000000b00604ad97f2d9sm2059593ywd.110.2024.02.27.15.16.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 15:16:27 -0800 (PST)
Message-ID: <7adcc642-4dec-425a-b198-14bbc0416f21@gmail.com>
Date: Tue, 27 Feb 2024 15:16:25 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 7/8] libbpf: sync progs autoload with maps
 autocreate for struct_ops maps
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, yonghong.song@linux.dev, void@manifault.com
References: <20240227204556.17524-1-eddyz87@gmail.com>
 <20240227204556.17524-8-eddyz87@gmail.com>
 <ec9d8997-f5a2-44b6-9bc4-2caaf19df8a9@gmail.com>
 <c9395bfd3cbd27ec5280d2e55abc6a6186fc663a.camel@gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <c9395bfd3cbd27ec5280d2e55abc6a6186fc663a.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/27/24 15:09, Eduard Zingerman wrote:
> On Tue, 2024-02-27 at 14:55 -0800, Kui-Feng Lee wrote:
> [...]
> 
>>> @@ -4509,6 +4514,28 @@ static int bpf_get_map_info_from_fdinfo(int fd, struct bpf_map_info *info)
>>>    	return 0;
>>>    }
>>>    
>>> +/* Sync autoload and autocreate state between struct_ops map and
>>> + * referenced programs.
>>> + */
>>> +static void bpf_map__struct_ops_toggle_progs_autoload(struct bpf_map *map, bool autocreate)
>>> +{
>>> +	struct bpf_program *prog;
>>> +	int i;
>>> +
>>> +	for (i = 0; i < btf_vlen(map->st_ops->type); ++i) {
>>> +		prog = map->st_ops->progs[i];
>>> +
>>> +		if (!prog || prog->autoload_user_set)
>>> +			continue;
>>> +
>>> +		if (autocreate)
>>> +			prog->struct_ops_refs++;
>>> +		else
>>> +			prog->struct_ops_refs--;
>>> +		prog->autoload = prog->struct_ops_refs != 0;
>>> +	}
>>> +}
>>> +
>>
>> This part is related to the other patch [1], which allows
>> a user to change the value of a function pointer field. The behavior of
>> autocreate and autoload may suprise a user if the user call
>> bpf_map__set_autocreate() after changing the value of a function pointer
>> field.
>>
>> [1]
>> https://lore.kernel.org/all/20240227010432.714127-1-thinker.li@gmail.com/
> 
> So, it appears that with shadow types users would have more or less
> convenient way to disable / enable related BPF programs
> (the references to programs are available, but reference counting
>   would have to be implemented by user using some additional data
>   structure, if needed).
> 
> I don't see a way to reconcile shadow types with this autoload/autocreate toggling
> => my last two patches would have to be dropped.

How about to update autoload according to the value of autocreate of
maps before loading the programs? For example, update autoload in
bpf_map__init_kern_struct_ops()?

> 
> Wdyt?


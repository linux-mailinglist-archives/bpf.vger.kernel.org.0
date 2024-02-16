Return-Path: <bpf+bounces-22168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 982C98583C5
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 18:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53AA2283AC5
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 17:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222421339A6;
	Fri, 16 Feb 2024 17:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LsphVeDu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C19F1339A4
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 17:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103527; cv=none; b=pxx+khT1K5a9TWuxInoq9SNwnFPvAS2aRR4TTBUU7F2rtdowa1lsKbijoaK6AbO5G3gdbVhxOQnRj8j885tuf24J0HjxJVZnIAs0v0gIqU1sge8u7E/CCjcAJTGzo0PB76UGlDNvTrwf0YMhfpafO0ahgXrbGId+nbnpgZKeoWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103527; c=relaxed/simple;
	bh=2m/TzDDvZpBLS6Urc1YxECYV2f42tfE/VjA4nvu7ytM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WUmonx5pxA9iTFu1Cvutwum7oRpMK4bqpby1sWykBqtLh9hYe9HOPB4uHbZuK1dkK/NNBPfN4y6RLK7YkUbPRHpVnXc9NjHXG4nvkXMu8qOXzGoGRGd8FVSRsZMHtHe2/Z4NsO24PW1MIHBRLICMNlwcdHtfaaq1KS9UdCsu014=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LsphVeDu; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-607d9c4fa90so19971547b3.2
        for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 09:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708103525; x=1708708325; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kghpc+kD9MWWmsMKPoOsELO+4yyXoxlx2GDIck316Tc=;
        b=LsphVeDueW0UYSKlD08T6UCw6NTlfMPbKzmAgXxHFRNzhf30k960kkyAfKM7BmmrZp
         TMzMWHx+jjIATKXSeBKg70c7s9py3Ary/RzpUvuzglqpp5uaKbIkgO+in/5EpTDTB5tk
         A2bOBAKFRdtCNNwAYZbJw4rsjfCbrHBVe20CX7sGPVT3j20wM5K6g/cYPiZ+lchxgfmM
         Le90WFCiVAeXlnoekUskPvHX/vsyqQq7RvPKWNk1X8dYX/1NB9Eqtjmd2Ndcfq9DKdgb
         3lp/rrdszHdrVJfDhJXBmqWMzKgSWt1iNX3UPrGPJWFRhlJRb1/zzzFj/F4fUlpQ9Q04
         +nDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708103525; x=1708708325;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kghpc+kD9MWWmsMKPoOsELO+4yyXoxlx2GDIck316Tc=;
        b=aRs0cWDBt6r4avjUb8FuIx4iP5Zxv/QSt1T974VyqcVGE2/6u6SfEbouPoYf87aGBQ
         cBRhWiTErpxqJ74Of0pmOyi3tUnKBJWhWvB8b832AAailNkFiDVU4HcZl+irQI8FdInZ
         Ohe1NdcDtQmyyl/t/X6nSIOO8SyCLvj5bQqnjx2TsFa7597CT9e2RMZ+6g6rMK52gYIK
         xOk1o0hgroTz6jpmXlgMxXBfNYnZlvsUj2PzSnxZVucsgnldtrP1tN0wQCtckXzODoHg
         7m3/OC1i9FR4OcVntEeg0cFdRS1oWTxK0jAAxHpV3k3deenJwnPpFl1iI+SWdCRWldwW
         nh9g==
X-Forwarded-Encrypted: i=1; AJvYcCVfm/WkPIHT2NMZIkXFNkQ3GGED8c67FSDnTnTuMZbWxjFaKs7XLHv4InaMCpqotCCKm4thbWPdNpf0YIli0uP0moce
X-Gm-Message-State: AOJu0Yxic0EqTmN4CzWS8izyl/H7xBT4uqDXNRgcdOWzEbXuECnBuj9O
	wYwvJnPyk2/W4ri/DsWsbdrjO6g2v6F5Se7Nm+lO/W26h/jR6yqJ
X-Google-Smtp-Source: AGHT+IH32TF8iRWtUevnffRJuctG0BZIw/IHcy1RexoIg9j13xbtAP+NmnDw/O5IKvB9GKNS7dyzqA==
X-Received: by 2002:a81:9108:0:b0:607:dbd9:c368 with SMTP id i8-20020a819108000000b00607dbd9c368mr4388815ywg.35.1708103525007;
        Fri, 16 Feb 2024 09:12:05 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:6477:3a7d:9823:f253? ([2600:1700:6cf8:1240:6477:3a7d:9823:f253])
        by smtp.gmail.com with ESMTPSA id v63-20020a818542000000b0060784b3bba8sm422563ywf.35.2024.02.16.09.12.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 09:12:04 -0800 (PST)
Message-ID: <89506786-9efd-4d91-980d-a97ed170a02f@gmail.com>
Date: Fri, 16 Feb 2024 09:12:03 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next v2 1/3] libbpf: Create a shadow copy for each
 struct_ops map if necessary.
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: thinker.li@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org, kuifeng@meta.com
References: <20240214020836.1845354-1-thinker.li@gmail.com>
 <20240214020836.1845354-2-thinker.li@gmail.com>
 <CAEf4BzZBP=aV4j38+hqVgXoKa+DAZu5F-yeDVge+sLi5OBuRGw@mail.gmail.com>
 <da6aeb49-3d01-4729-8f01-8770ba69019f@gmail.com>
 <CAEf4BzYbyEPFOM3XXA31U3KVJpGmtEFoNOLNR4dV=n7nyb7Kgg@mail.gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzYbyEPFOM3XXA31U3KVJpGmtEFoNOLNR4dV=n7nyb7Kgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/16/24 08:52, Andrii Nakryiko wrote:
>>>> @@ -487,6 +487,14 @@ struct bpf_struct_ops {
>>>>            * from "data".
>>>>            */
>>>>           void *kern_vdata;
>>>> +       /* Description of the layout that a shadow copy should look like.
>>>> +        */
>>>> +       const struct bpf_struct_ops_map_info *shadow_info;
>>>> +       /* A shadow copy of the struct_ops data created according to the
>>>> +        * layout described by shadow_info.
>>>> +        */
>>>> +       void *shadow_data;
>>>> +       __u32 shadow_data_size;
>>> what I mentioned on cover letter, just a few lines above, before
>>> kern_vdata we have just `void *data` which initially contains whatever
>>> was set in ELF. Just expose that through bpf_map__initial_value() and
>>> teach bpftool to generate section with variables for that memory and
>>> that should be all we need, no?
>> I am not sure if read your question correctly.
>> Padding & alignments can vary in different platforms. BPF and
>> user space programs are supposed to be in different platforms.
>> So, I can not expect that the same struct has the same layout in
>> BPF/x86/and ARM, right?
> We can constraint this functionality to 64-bit host architectures, and
> then all these concerns will go away. It should be possible to make
> all this work even if the host architecture is 64-bit, but I'm not
> sure it's worth doing.
> 
> Either way, we need to keep this simple and minimal, no extra
> descriptors and stuff like that.
> 

Ok! I will make changes in the next version base on the assumption that
the host architecture is compatible with BPF.


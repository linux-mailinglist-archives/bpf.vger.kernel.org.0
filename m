Return-Path: <bpf+bounces-36921-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C893794F61B
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 19:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 009261C21CF2
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 17:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7E8188CB0;
	Mon, 12 Aug 2024 17:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9cE1aKu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0A9186E36
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 17:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723485090; cv=none; b=L7k57xgb0TB9dwPFSuklWLTEHMIx5eRNhKs3AcTfkxzWXND9iMCZhOC1aP1Qtjbey6qV52hGMK/Rnn1iMiR/ukZk+WNkzyvQZanP/tQO5RlzNh1l403hhw2L6wIPYXST5qdfEsuqSySUB5mLuyqgmk+juns+PF086ESunTv9/bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723485090; c=relaxed/simple;
	bh=EM/io6sP+6li4lvYvabTuce5Qa+v2T9RygQ8ymI6rbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UKyUUrIYdqNqV4DuCvW5d2+HqdLnCKhtpBs+MXe1b69FMrbBekHGdOyrtwrFFNaKCUCbzdL07NCaamamnH6+yzlS1t7fZPeUAeV+xsrZaWTbjUhPrXx/R7M+K+lzTIhOGkbRa1729WaAdKU6WJiWOFk05FKiu4VKBJRJW7YCB6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9cE1aKu; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-64b417e1511so42412937b3.3
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 10:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723485088; x=1724089888; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w3VdWir9GXGF+e3m+U832FlK9QbD8mhoWFFrkHX69HQ=;
        b=B9cE1aKu2aun7cUzjiwYV1YU6zGR0a6+TL5oOlWqK2OekSt/aRcyBmQQhRp9dolvxC
         m8TEtS0xxsOSQRMhcBbRdBb9DCqF+Ac469XCqrZJAFPz8HZFHUIkgEtq0XvPiQYRwjpP
         sc79ZlBdhDCNOdD7UYTl468TD3VWhWv72ZsyJ+PFVnusBTsl80LMmVIHtFvyohzv9h7g
         UcstoOapd1BIhPMoZnGdilRm+lXRMerVinwsozuzaF/u8grYCVZ/L0oOOUwgLMePW+ks
         YeTuuFuLz2jveBvXYAnuEcSk7Zcl5EIHH8nIfCGF5ROUG+UE9Z0V7U2JUadnUovytfAr
         a+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723485088; x=1724089888;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w3VdWir9GXGF+e3m+U832FlK9QbD8mhoWFFrkHX69HQ=;
        b=BYPHVos60kGCFDkDHIdtZCcy3fSOUSbmb6iyER6dOcmnEzBIdnfkUJF+1i+sZRREot
         5Lfb1JKsL7/vCy86q/WQAW6nfaXJwmUW9/B4mkU74UsSfXTGI/HTHy9VuNNd2JQFNQsL
         gj0lHjcWoAoTmjAnGt7duMxh+AmjeP9qdbLmKNnoWowCOpqGvN7BhnqgQOi9qs8s0DxJ
         8WzIhadVcLxvOPCVkrTe5kPdE3OfGjPJK8cHyRMlaPeSOPmDLvo1ArQ8D2GskkgjmxoW
         jk/giKdjlakq6NcwQkWPlcK1zzb93TUu3BLuYl9prp9P8ON9IC8F1IfHGh0+sBS6p0XK
         2bCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFMw4CT/cqnA7OhNhZX9O7ZtkEsxnWU+j4q2Y85GKqnj18oDzP1UtnB66gaJDIIXQ4x6dV/ORDTH/jc6tXsb3X3SVM
X-Gm-Message-State: AOJu0YylsoZGud5UlGypPgqWkBlv4HngmqExQmaZ4iJ27rUejr3WxVsL
	pepB5+gTc4B/AqOmZeki9GmJGWg8gAuh7sBGDWm/hyZDXXMj0Tku
X-Google-Smtp-Source: AGHT+IF7VGhJ+Xd5RKhMVC4Z3unUa3NitK1NVNXo+RijUPPpY81FsoXse4Fe6sCE8LFGpdsn1vX8aQ==
X-Received: by 2002:a05:690c:dc9:b0:63b:d711:e722 with SMTP id 00721157ae682-6a97151ca8amr13532577b3.1.1723485087682;
        Mon, 12 Aug 2024 10:51:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:9b6c:23b8:ec8:40fd? ([2600:1700:6cf8:1240:9b6c:23b8:ec8:40fd])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6a0a121a0basm9389517b3.64.2024.08.12.10.51.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 10:51:27 -0700 (PDT)
Message-ID: <03fa1e24-4d5c-4a48-a06f-dee2538927aa@gmail.com>
Date: Mon, 12 Aug 2024 10:51:25 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 3/5] bpf: pin, translate, and unpin __kptr_user
 from syscalls.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>,
 Kui-Feng Lee <kuifeng@meta.com>, linux-mm <linux-mm@kvack.org>
References: <20240807235755.1435806-1-thinker.li@gmail.com>
 <20240807235755.1435806-4-thinker.li@gmail.com>
 <CAADnVQLs8nZGmyJSdgb11NSsSe_ZH1Qbcu7dcb=60-+0p+k9fw@mail.gmail.com>
 <62ade560-dd46-4480-8595-250b0264d3a4@gmail.com>
 <CAADnVQK_DgzMEMFx67ihKxAyU+W0khmQA9wVsio1__XxnrDUgA@mail.gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAADnVQK_DgzMEMFx67ihKxAyU+W0khmQA9wVsio1__XxnrDUgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/12/24 10:36, Alexei Starovoitov wrote:
> On Mon, Aug 12, 2024 at 10:24 AM Kui-Feng Lee <sinquersw@gmail.com> wrote:
>>
>>
>>>> +static int bpf_map_update_value(struct bpf_map *map, struct file *map_file,
>>>> +                               void *key, void *value, __u64 flags)
>>>> +{
>>>> +       int err;
>>>> +
>>>> +       if (flags & BPF_FROM_USER) {
>>>
>>> there shouldn't be a need for this extra flag.
>>> map->record has the info whether uptr is present or not.
>>
>> The BPF_FROM_USER flag is used to support updating map values from BPF
>> programs as well. Although BPF programs can udpate map values, I
>> don't want the values of uptrs to be changed by the BPF programs.
>>
>> Should we just forbid the BPF programs to udpate the map values having
>> uptrs in them?
> 
> hmm. map_update_elem() is disallowed from bpf prog.
> 
>          case BPF_MAP_TYPE_TASK_STORAGE:
>                  if (func_id != BPF_FUNC_task_storage_get &&
>                      func_id != BPF_FUNC_task_storage_delete &&
>                      func_id != BPF_FUNC_kptr_xchg)
>                          goto error;

Thank you for the information!



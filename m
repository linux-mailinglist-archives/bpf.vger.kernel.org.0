Return-Path: <bpf+bounces-28530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E010B8BB22C
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 20:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2190B23A3C
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 18:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D581586C0;
	Fri,  3 May 2024 18:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipSWhtQ+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B488158210
	for <bpf@vger.kernel.org>; Fri,  3 May 2024 18:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714759772; cv=none; b=WV72U0gz5kxgSSB2hgbuKx1Cmn6miplw4J3OA5+PbJZK3mtuQkb344wK5Q9pcUUEJvlunBZb2xaXVX73bAzonPNjlHdOXRNd+LNSJt70iais5Dh8thL7ea5hTNTNDxXhpXVHJxthizDsVSfubLbBTzZreF3o6Yf5qFZnDavsiHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714759772; c=relaxed/simple;
	bh=utWxj7MiTE5H7DOZROQ/tCRBbTM7p/YnLZfYSYEpwXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hkqLR7al79TQiLWjjrX+MuJ8u2wJ4KMzU5OAGnIf0+ZsYwDlrxl6zDTRlvK5CsskLZIjl49+6Bl436fc6CwpSD/zr0J6S6YtwX0Q1+RfJvYuDsfJ9/TteeqqYrxujmg27vnpxbPnGiFRxjNNunrN7ZVR+M+ogGlF/7KbtYT/Vjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipSWhtQ+; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c861a87d6dso3933467b6e.0
        for <bpf@vger.kernel.org>; Fri, 03 May 2024 11:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714759770; x=1715364570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EUvOwTGOsqJ4GXXBhzY57utYjdWAjUxpMCGpvtxLk64=;
        b=ipSWhtQ+swyxg9CvjHVKizD0c52pU+wyS7xZrPf7tEPhVreKHJsYIQ9S86Dn1iFyAj
         5yCeO1KCv5JxlUufOtoVRQbB4KUZA99TBE448NAV04VqTJhrEDedXIxYxz0lR/ocj6lM
         mbTuEWfO/Kw3JrnCvELFEQBvmaYag83+vvWaqhCj69knzLYXL1OmXSNKlt8EMVuLiyGN
         pqoIwtK99jngAdJ3pFI3mYBVY/QaWJnot8rK7i8YJdpXYv9REwCblANntj0Io4zG7wlK
         3wte5SuyP2zEsDIBGeJDmNOK3MTegSRSn1/qnsgvLaYfxwUye32jZ5Qd++wOzQZjTi64
         RkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714759770; x=1715364570;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EUvOwTGOsqJ4GXXBhzY57utYjdWAjUxpMCGpvtxLk64=;
        b=pZ24BUH8SSkEgw15TrW+twbR20CeIDpG+i5hGAg/muaTZW85H2DY9lOiFlOqjQ9FbJ
         xFO9rV5RF8yYcAF8x3TVxjpdIKyCq9cTq2ndHQ+uLUyIsLN+TTIhF5Ob9aWHe618ipLk
         UjisZmHRj46DazzCxm+rY0LEv0NKn+vgFbAxQdf5qRKmljLlCfvmIeDcYwfX63z0seOQ
         S5KP5S/N01y7T317vjTcCPTnNd00MKBOGLSjaGc36lw6YGnNuzJvT/5hS5/SiuezJxEp
         NB+A8Tag9hqjiSC8wOXYDGiHFb+xcKWiWrLrJ62aU6f7zJskyorZkv01tEs11NZ/Q8Va
         82Xw==
X-Forwarded-Encrypted: i=1; AJvYcCWhTs2+I4QS1JUTkrc4MS2USEHglmJALtMomLd5dS5gf01KKoOzcadw8WTHaG6UPJg8Q6WaLhlbxwIOGC2W5qwcb1kf
X-Gm-Message-State: AOJu0YwYvbzsMXyCN+mSggcrjQQZ1rhdccpgHNIOvWEkTF/fS8bA2fVC
	x10VaC0bJZdPVMBbFgJQWrAaS0sBv1rn7zRXFbYRD6jBzOSBK7HD
X-Google-Smtp-Source: AGHT+IHg+8IGJbKCDqWGDr9kZezLufUVxfG4y2SaRVb7KA66ryDszwKf+1BfdUnCOX6EJj2o3UliJA==
X-Received: by 2002:a05:6808:d51:b0:3c8:64e6:b16f with SMTP id w17-20020a0568080d5100b003c864e6b16fmr4857847oik.3.1714759769965;
        Fri, 03 May 2024 11:09:29 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:248:d6ee:f0ae:bd46? ([2600:1700:6cf8:1240:248:d6ee:f0ae:bd46])
        by smtp.gmail.com with ESMTPSA id y24-20020a056808061800b003c5ed0d7d24sm573322oih.18.2024.05.03.11.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 11:09:29 -0700 (PDT)
Message-ID: <80a59f2c-e82b-427a-88eb-568301437b95@gmail.com>
Date: Fri, 3 May 2024 11:09:28 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 3/6] bpf: provide a function to unregister
 struct_ops objects from consumers.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
 Kui-Feng Lee <thinker.li@gmail.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>,
 Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>,
 Kui-Feng Lee <kuifeng@meta.com>
References: <20240429213609.487820-1-thinker.li@gmail.com>
 <20240429213609.487820-4-thinker.li@gmail.com>
 <f287c62f-628f-4201-ba34-03a7193212d8@linux.dev>
 <5c07376c-40b3-4dd3-ab2c-7659900914b3@linux.dev>
 <fb06e9a7-244a-421d-ae9e-8d6da9a25684@gmail.com>
 <CAADnVQK6NqyFrjW29m-02GuS0jFyxyWWNySp+82N2+oaVZNg8A@mail.gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAADnVQK6NqyFrjW29m-02GuS0jFyxyWWNySp+82N2+oaVZNg8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/3/24 09:19, Alexei Starovoitov wrote:
> On Thu, May 2, 2024 at 5:41 PM Kui-Feng Lee <sinquersw@gmail.com> wrote:
>>
>>
>>>>> +    prev_state = cmpxchg(&st_map->kvalue.common.state,
>>>>> +                 BPF_STRUCT_OPS_STATE_INUSE,
>>>>> +                 BPF_STRUCT_OPS_STATE_TOBEFREE);
> 
> All the uses of cmpxchg mean that there are races.
> I know there is already a case for it in the existing code
> and maybe it's justified.
> But I would very much prefer the whole code converted to
> clean locks without cmpxchg tricks.
> 
> 
>>>>> +    if (prev_state == BPF_STRUCT_OPS_STATE_INUSE) {
>>>>> +        st_map->st_ops_desc->st_ops->unreg(data);
>>>>> +        /* Pair with bpf_map_inc() for reg() */
>>>>> +        bpf_map_put(&st_map->map);
>>>>> +        /* Pair with bpf_map_inc_not_zero() above */
>>>>> +        bpf_map_put(&st_map->map);
>>>>> +        return true;
> 
> I haven't tried to follow the logic, but double bpf_map_put
> on the same map screams that this is broken.
> Do proper locks everywhere.
> inc_not_zero and cmpxchg shouldn't be needed.
> keep it simple.

Got it!


Return-Path: <bpf+bounces-40316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A0E986228
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 17:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A324288AFB
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 15:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EF2188CC7;
	Wed, 25 Sep 2024 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9D7285x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCB718455A;
	Wed, 25 Sep 2024 14:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276114; cv=none; b=krO/RcqgeuFW0WCW5RcL9VcctQ/4i69ImxqDHrGYp08PWvl1y/eEIIRFb/TLa/ja/mn25CfWHoaK/p3+FdL/iw+wJpkUtTEeI2eS8+K0fqRe6SEA84SBRrqvLb70MlJoj1H8jGc0YZ86/Ftk/T7L/zn5eaDRi/V+2bIoriTilSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276114; c=relaxed/simple;
	bh=mmtRiWz9Q+Py59z3Q6DAPlbdAQ0X3G+1ovoNyVQN8Ms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gliu0VQwSgTZGjiYy3IVet4s41Buzk7Vq+bjtrHZO4xLLnf6QSTHIw2viplNaiq0Uk+EYuhDROeUMAbrubOmcHX7CT+hjDXK2DEFeyvg+fwWBF6FdZcxK8TSuvwGkxnc5CPb8D95All3rdlhzB23QXcrpLNDPGPKIGGl/vaeBpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9D7285x; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2055a3f80a4so43352565ad.2;
        Wed, 25 Sep 2024 07:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727276112; x=1727880912; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlbDQsnCvB/FZmp4DNDzI/gUYmfcIsiNTu193rz6Dfw=;
        b=O9D7285xpAZtfNjmCmMhDYuw/bCpH5YyxH/pCPaJ1NA+xkMoBstrP3gK/K8dh2Nscv
         bdqa01axo3ERCQj+p5xwGEag61V9l6eETkIIdZqK+Q+pAwzYcAhidh2u0xFukTg3d/D3
         6jzPB6WYx4Ra1q8sup0wVJN72ZocH0wyKea0ocGMucjWR2wqjK2PnSrQgbnEQoTPzMMo
         lB/KacFABIuTMLdOXjM3HcTQZ8Xp0WUrIzZHzvXmFDTXehXEholtDkvZogq4MKm2hf4g
         7f+2TZPX284hLsosz8bob13V6BkO1fAPhUckUmkdVqs5p3+3LIQBRrLru0NkKC+CzUu3
         T0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727276112; x=1727880912;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BlbDQsnCvB/FZmp4DNDzI/gUYmfcIsiNTu193rz6Dfw=;
        b=kU5NU32E0DYqEp3WtCjK8atsxa1G/cWH/7D22ffQog7WCSP1ZgaSCr2d3kc7QSTdOJ
         w8qtfNv+fzzAmglrNFWX2oucX4yejwprnLPH5KjmqsWpwX8OrNvOlVJEkR/dVlm4ZKDe
         9Ulqc0fue1vlXZauJlTF1vpCEQqueICF7ILucBb9AYLtVZ6GJAVadZH8sXrZQn36eYh8
         V9e6KU+jt4r+fk1z+/PL1jBge1b51a4FFpezay3QkzDqGThHXxv6b//OXzl/l7G5N5j8
         pD9+P9Use69qISUCkd22BXSIl4I4QnNO5ZT6PT2aDx5WhxCJ4jzv8SDfNzE524wyd8ym
         KCfg==
X-Forwarded-Encrypted: i=1; AJvYcCUmZ92q6ISZ9XeP2Eldr2kxKkNZ3c+eebOiSaKaCrI30mG7SdYju8r+BnS4LN9M9+h0Qv0=@vger.kernel.org, AJvYcCW33+/g0n/NQA5D13kMhwDDxltSME4B+apliass626M+4NMTs9BnjpBsPtn7nyTXyr5pl5wwbLcNKUqVy3f@vger.kernel.org
X-Gm-Message-State: AOJu0YwAiEiud798+M+jKKUrTeGbaxJUEN9KAFuUss75IjNCOubhx4WO
	WFiketxK1F6KE7R6ELss7oOBl4nnUowZ5fd/qnhwgVExBvkjHfcE
X-Google-Smtp-Source: AGHT+IFTkM7vEB+MGzSsdhuaBNY0NdKahQnrmcu+j8ktodfXOVJZuMa82j94ZQ8aScDtgu4rTuWTlg==
X-Received: by 2002:a17:903:188:b0:206:b960:2e97 with SMTP id d9443c01a7336-20afc5e2c5amr33774985ad.45.1727276111587;
        Wed, 25 Sep 2024 07:55:11 -0700 (PDT)
Received: from [192.168.50.122] ([117.147.91.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af18584f4sm25361995ad.280.2024.09.25.07.55.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 07:55:11 -0700 (PDT)
Message-ID: <680bbf09-6939-4056-bfc2-27138a93efe6@gmail.com>
Date: Wed, 25 Sep 2024 22:55:00 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3] libbpf: Fix expected_attach_type set when
 kernel not support
To: Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240914154040.276933-1-chen.dylane@gmail.com>
 <ZvPl6Wo4cdihaQ0A@krava> <11e2ed15-b3a5-419a-9e9f-cbfe270d0fe8@iogearbox.net>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <11e2ed15-b3a5-419a-9e9f-cbfe270d0fe8@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2024/9/25 18:36, Daniel Borkmann 写道:
> On 9/25/24 12:28 PM, Jiri Olsa wrote:
>> On Sat, Sep 14, 2024 at 11:40:40PM +0800, Tao Chen wrote:
>>> The commit "5902da6d8a52" set expected_attach_type again with
>>> field of bpf_program after libpf_prepare_prog_load, which makes
>>> expected_attach_type = 0 no sense when kenrel not support the
>>> attach_type feature, so fix it.
>>>
>>> Fixes: 5902da6d8a52 ("libbpf: Add uprobe multi link support to 
>>> bpf_program__attach_usdt")
>>> Suggested-by: Jiri Olsa <jolsa@kernel.org>
>>> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
>>> ---
>>>   tools/lib/bpf/libbpf.c | 12 ++++++++----
>>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>>
>>> Change list:
>>> - v2 -> v3:
>>>      - update BPF_TRACE_UPROBE_MULTI both in prog and opts suggedted by
>>>        Andrri
>>> - v1 -> v2:
>>>      - restore the original initialization way suggested by Jiri
>>>
>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>>> index 219facd0e66e..a78e24ff354b 100644
>>> --- a/tools/lib/bpf/libbpf.c
>>> +++ b/tools/lib/bpf/libbpf.c
>>> @@ -7352,8 +7352,14 @@ static int libbpf_prepare_prog_load(struct 
>>> bpf_program *prog,
>>>           opts->prog_flags |= BPF_F_XDP_HAS_FRAGS;
>>>       /* special check for usdt to use uprobe_multi link */
>>> -    if ((def & SEC_USDT) && kernel_supports(prog->obj, 
>>> FEAT_UPROBE_MULTI_LINK))
>>> +    if ((def & SEC_USDT) && kernel_supports(prog->obj, 
>>> FEAT_UPROBE_MULTI_LINK)) {
>>> +        /* for BPF_TRACE_KPROBE_MULTI, user might want to query 
>>> exected_attach_type
>>> +         * in prog, and expected_attach_type we set in kenrel is 
>>> from opts, so we
>>> +         * update both.
>>> +         */
>> s/K/U/ in BPF_TRACE_KPROBE_MULTI in above comment and 'kenrel' typo
>>
>> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Same typo is also in commit desc, would be good to improve the commit
> desc a bit if you spin v4 anyway. Thanks!

Hi，Dnaiel，my bad，i will fix it in v4

-- 
Best Regards
Dylane Chen


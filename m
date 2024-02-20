Return-Path: <bpf+bounces-22350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A50885CAB3
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 23:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8A732840B8
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 22:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA2614F9CE;
	Tue, 20 Feb 2024 22:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X952lF2n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166E21534ED
	for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 22:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708468017; cv=none; b=Y8cwn/tOzgB90pAN8h/l36QLHvQ11q4v/euHo1bsAeuc7XW1nJQnA2tNzZUKLqvLcQ1CSKXYosyGvB9kU1AdUjz5NQaYNeMYIfmMLceFItxS2MNvMdv9BLJ2AU644OeKKBkODiDmoac4B/xJnKoXXf55B88jVGHA87bxpzLKb/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708468017; c=relaxed/simple;
	bh=fa1gxaF2YupH9nCgU5bffgcOm/SNWVuLrA998FalfFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IOXA4y2NXxkqQsSM1wsS2auPpRsz/x2u2ctmg1hfCjyG8VI1lsC+WTbpB9QFGxmuqYf7rxB1pNwZVP1uqxqql6Y8YD2SrhLyygKciwQrlKWRefdOz8HnLu0YarMxPwVrKgVCwm0Oc8Jp7ohdUhBdQFsEA9Q8G2OyzvJuWc6TGZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X952lF2n; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-607e54b6cf5so37713357b3.0
        for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 14:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708468015; x=1709072815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kEDZ8yfFjw6raNxSIPb+KvmDxqGQ+AE29hl3iBFCcxY=;
        b=X952lF2nf08JKasYDK/OmZItiMjjxvX7qF2cZ8wOYxNLOrLYwv80wLnp2FeN763aRE
         Vf00C4HO4F+s1j3YgskzJbLE6sGYiLMF4PuyYgy6lf1HAeQ+Cx4Vbmg2BN9ezeqrtbVE
         H8m3wlrvTqXwIGStRUKNfKBwqHYgtFXsvIqEXqM4lBG4ARwQAhI+IqXZrDxUehkBx3iP
         T2nnTlncvHZDu74b2bMU4HvazBwdz5C8EDqyJzGxUUGwggUYGPDqhyqztoDLKo8F79pf
         6gJCtaNgj9heht3HcIRoNdr/YkpRmZqehWCuGNinqI6ARwe3plMWTUBzcrHwU+KnKs6l
         rZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708468015; x=1709072815;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kEDZ8yfFjw6raNxSIPb+KvmDxqGQ+AE29hl3iBFCcxY=;
        b=OmP3IfIpAJ1K0JOLFAB917kJ8+tu83WqxAq5fEnMGlxyzacQAGRil/gqkL5/k7JFK1
         KyAFyY2PuNZynfiKO1WvPdI4PBjNbhOzdWiKkp/2F7wCEXxyRp3QuAM3S3mLcy4MsTJk
         njIMM8i5urTwCjoeBN5mVQALr5TgHX76kIjbvy4ui+Ddu2BLYlStjenhIHM5V+h6ea+e
         m7H1qX9KLDCWKNBXB1IV5nv7kqmy7CHGv5KHi2QdYNVWoqAT8xCNVo+4VohInwJtNzQk
         79Pmd+3WNPdJ4zglOMCoCN43hYtaxunpXqNer7ffbVqDyoP6fWkZ5qeVyi34fmqCfg6B
         OaVg==
X-Gm-Message-State: AOJu0YxmTF0FxzW+ISBlYV26JbCcmI5JscjGJ3aBq+FEOstXPFeZztvU
	8TZWFYNKONyxlOoboiSwig6T1jFgs6Y15htp0y6daPutj9KKcnspJjFvxZ79
X-Google-Smtp-Source: AGHT+IGIgQpB3jPjpiU8Bn4/PWRlMZlf8OTv9pIOAJWAgOOQb4iNfDR2P/rCHyR3pfAEbz7JnPfgRQ==
X-Received: by 2002:a0d:d410:0:b0:608:7b54:23e3 with SMTP id w16-20020a0dd410000000b006087b5423e3mr399951ywd.8.1708468014472;
        Tue, 20 Feb 2024 14:26:54 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:26eb:2942:8151:a089? ([2600:1700:6cf8:1240:26eb:2942:8151:a089])
        by smtp.gmail.com with ESMTPSA id e129-20020a0df587000000b00604a2e45cf2sm2300875ywf.140.2024.02.20.14.26.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 14:26:54 -0800 (PST)
Message-ID: <9e885f05-7aba-4b1b-803e-a092c9b9c0f8@gmail.com>
Date: Tue, 20 Feb 2024 14:26:52 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/3] x86/cfi,bpf: Add a stub function for
 get_info of struct tcp_congestion_ops.
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>,
 Kui-Feng Lee <kuifeng@meta.com>, Peter Zijlstra <peterz@infradead.org>
References: <20240216193434.735874-1-thinker.li@gmail.com>
 <20240216193434.735874-2-thinker.li@gmail.com>
 <CAADnVQ+hXmKGxHQopt8HF5d85sn2vvqZoJ1xNXWV9LzVTtjw1g@mail.gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAADnVQ+hXmKGxHQopt8HF5d85sn2vvqZoJ1xNXWV9LzVTtjw1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/20/24 09:38, Alexei Starovoitov wrote:
> On Fri, Feb 16, 2024 at 11:34 AM <thinker.li@gmail.com> wrote:
>>
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> struct tcp_congestion_ops is missing a stub function for get_info.  This is
>> required for checking the consistency of cfi_stubs of struct_ops.
>>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   net/ipv4/bpf_tcp_ca.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
>> index 7f518ea5f4ac..6ab5d9c36416 100644
>> --- a/net/ipv4/bpf_tcp_ca.c
>> +++ b/net/ipv4/bpf_tcp_ca.c
>> @@ -321,6 +321,12 @@ static u32 bpf_tcp_ca_sndbuf_expand(struct sock *sk)
>>          return 0;
>>   }
>>
>> +static size_t bpf_tcp_ca_get_info(struct sock *sk, u32 ext, int *attr,
>> +                                 union tcp_cc_info *info)
>> +{
>> +       return 0;
>> +}
>> +
>>   static void __bpf_tcp_ca_init(struct sock *sk)
>>   {
>>   }
>> @@ -340,6 +346,7 @@ static struct tcp_congestion_ops __bpf_ops_tcp_congestion_ops = {
>>          .cong_control = bpf_tcp_ca_cong_control,
>>          .undo_cwnd = bpf_tcp_ca_undo_cwnd,
>>          .sndbuf_expand = bpf_tcp_ca_sndbuf_expand,
>> +       .get_info = bpf_tcp_ca_get_info,
> 
> No. It was explicitly skipped.
> The plan is to use NULL in cfi_stubs to remove
> static u32 unsupported_ops[] = {
>          offsetof(struct tcp_congestion_ops, get_info),
> };
> and manual check of such fields in is_unsupported().


Ok! That means I have to check the result of st_ops->check() to skip
unsupported ops.


> NULL is cfi_stubs will be such an indication.
> 
> pw-bot: cr


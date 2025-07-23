Return-Path: <bpf+bounces-64154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2CDB0EDFB
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 11:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3414D188752E
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 09:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABF6281351;
	Wed, 23 Jul 2025 09:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="HzWSeog1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8E41DE3CA
	for <bpf@vger.kernel.org>; Wed, 23 Jul 2025 09:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753261369; cv=none; b=iaswoh5AaUEDNu25UogP6B5+XIroj2K2HYcuPMlbjMFftZdgeqRl8T3xSUJ8mV+ttANRcC6Qf2L/iTK0uxFcsIqnm+MvL/c1hdY1rvLjSJAplAynzG/gnVvncTPjHdSHTowCGl365X0aJjviSbg51pYqq/Y3lCWoKbWzwHveufA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753261369; c=relaxed/simple;
	bh=ygKB/3qV/yZcQeyHE3M5GxconkSriNyOxhJHjVlIEjc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=otrWc3uYaizCOD7/3cyWFKo8ygcWR6T6KSKC/NplTzCfJB3J6MJzCyFiuoorXwM3StG5ez6CcnhD01LET3PG0agClTixlPUZa+Lr40C0OwFDZrfKP8MzvmHOY/7guTAQYTsUaUzKpZbfJmZH+vpNLJkKx9FOmjCBow7dnPv2DKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=HzWSeog1; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae36dc91dc7so1036221366b.2
        for <bpf@vger.kernel.org>; Wed, 23 Jul 2025 02:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753261365; x=1753866165; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hytbl13aqp6nVCmL/eVfqPUZ9T67TEgc4air/Um7YUA=;
        b=HzWSeog1bAxl8zEaI1uinY9jxRTT+QAu644DT3q/jNvAMU1yEerUys4N8URrYEeiLh
         VHy1iM/5qudXvCWS2ukm1GmHYQNqGLhvJUGZBP08Hb3Gn5wKh4d5fOHwxefo9xMX6GOX
         PnAfIx4smF6cbzcxjcnG+ihtiRi1gku2YM7PD4EAElCFOK/ZNoYoL8nFo3S/weJbEs92
         WecCX5JNClEhLg+Q2ISm2DEYf6WTZLoXjr/BVNyC+R8ukgE0ndH5g3d4nd98v0BDAfSZ
         +syBwPln71+Yf1KzGaeNH/SlR17JF7EOysVbFqzPNKkM7GUhENhYt1JKhUYP1bU24S+b
         LDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753261365; x=1753866165;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hytbl13aqp6nVCmL/eVfqPUZ9T67TEgc4air/Um7YUA=;
        b=Zg2E9uxxHHHSmfTYSsVgFnXiU1GfgP1FjfD6hzCF8w19cutsBZNN9j//381A9IAYun
         LvyWbiOz0C3yLJ0jVJhXwj6SRzn5qq9jd/OR7g1/0Oy7MJGhQ/DkO2UZJhX3JkZUNF8t
         GALP8qoe3fnIINHTJRU4PEHCka2tzTTIw5PvFw9+S+MzdkDY3XlMTAp2vxcawRCp2im6
         zH5O4xpNRGmqyV7IcE95vLzne7oFeK6Nv721UXFOgLj3ZG+3o1hrhNlNnIBzIuQyGp+1
         DjJNzigBEycM1TCAM3ondecVIRS2D/Y8ifyK8XKDx7hNLtUAbtFdJ3ILX8ONH9LzUkxI
         tqUA==
X-Forwarded-Encrypted: i=1; AJvYcCVFvgf/Z8Zri8yJ/d08FHZPB9kjXiFTMG8wNfo+RLmx9hIBdKxtK/SX35tEDxgyZTUp66I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/v19JqpsLwHGyg47QbnWjL1322uZC9qPzfcKjrmXz3UxACWj0
	ZvS7Hccyx9KNqA4SsnmOrFUk1JukpNZIhdejSnxueG/klmwXTMYzj1pZdK3MI1uvzYM=
X-Gm-Gg: ASbGncuVNj8WmLOOta2MENWXy72GRehvnek6xk+VLN+UKDAxDwqdmHgPPd+Ohp0E4ZD
	Tf8NE++1BzXOUIpJXLZ4mllT3W91pWdBWR2Av4qpFvgV59IUfUzlKkATsjKLpfj9fMcPWlX6skN
	kz6xJaPIIMXpQ12YC9h+0g2z9gsqZfID3CLwV2Un4vtpsnI6/y5jgM0HBbquxlA3vjczV7/2e0y
	YDOPcP2ATeaTQy3WLJ0PqrW8+55bldgpQ4D++9giPkFexcd+VyrJB7yCux5PcvlEOzlddJ7G9+2
	d2WVW4up4KxrwkI/nuD6fscS0YwCQfheY9C6zw7+vY9IuwrHNLGQo0Ql04dEvmP6+va8E7V74g3
	SzVus5xyxzgM5r3s=
X-Google-Smtp-Source: AGHT+IEtmfosbL9HADnrTDM47eZxPqcaPYGnz5uE54cpkgA02QsDZ15GzaWfGfj2dkTKvvO6xws02g==
X-Received: by 2002:a17:907:788:b0:ade:450a:695a with SMTP id a640c23a62f3a-af2f9381584mr200492566b.61.1753261365414;
        Wed, 23 Jul 2025 02:02:45 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6cad3c4fsm1019228766b.153.2025.07.23.02.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 02:02:44 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,  Andrii Nakryiko
 <andrii@kernel.org>,  Arthur Fabre <arthur@arthurfabre.com>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Jesper Dangaard Brouer
 <hawk@kernel.org>,  Jesse Brandeburg <jbrandeburg@cloudflare.com>,  Joanne
 Koong <joannelkoong@gmail.com>,  Lorenzo Bianconi <lorenzo@kernel.org>,
  Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>,  Yan
 Zhai
 <yan@cloudflare.com>,  kernel-team@cloudflare.com,
  netdev@vger.kernel.org,  Stanislav Fomichev <sdf@fomichev.me>,
  bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 01/10] bpf: Add dynptr type for skb metadata
In-Reply-To: <5a43d42d-375d-4a90-b5ee-8e8ed239cefd@linux.dev> (Martin KaFai
	Lau's message of "Tue, 22 Jul 2025 17:37:03 -0700")
References: <20250721-skb-metadata-thru-dynptr-v3-0-e92be5534174@cloudflare.com>
	<20250721-skb-metadata-thru-dynptr-v3-1-e92be5534174@cloudflare.com>
	<5a43d42d-375d-4a90-b5ee-8e8ed239cefd@linux.dev>
Date: Wed, 23 Jul 2025 11:02:43 +0200
Message-ID: <87ecu7xoss.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 22, 2025 at 05:37 PM -07, Martin KaFai Lau wrote:
> On 7/21/25 3:52 AM, Jakub Sitnicki wrote:
>> @@ -21788,12 +21798,17 @@ static void specialize_kfunc(struct bpf_verifier_env *env,
>>   	if (offset)
>>   		return;
>>   -	if (func_id == special_kfunc_list[KF_bpf_dynptr_from_skb]) {
>> +	if (func_id == special_kfunc_list[KF_bpf_dynptr_from_skb] ||
>> +	    func_id == special_kfunc_list[KF_bpf_dynptr_from_skb_meta]) {
>
> I don't think this check is needed. The skb_meta is writable to tc.
>
>>   		seen_direct_write = env->seen_direct_write;
>>   		is_rdonly = !may_access_direct_pkt_data(env, NULL, BPF_WRITE);
>
> is_rdonly is always false here.
>
>>   -		if (is_rdonly)
>> -			*addr = (unsigned long)bpf_dynptr_from_skb_rdonly;
>> +		if (is_rdonly) {
>> +			if (func_id == special_kfunc_list[KF_bpf_dynptr_from_skb])
>> +				*addr = (unsigned long)bpf_dynptr_from_skb_rdonly;
>> +			else if (func_id == special_kfunc_list[KF_bpf_dynptr_from_skb_meta])
>> +				*addr = (unsigned long)bpf_dynptr_from_skb_meta_rdonly;
>> +		}
>
> [ ... ]
>
>> +int bpf_dynptr_from_skb_meta_rdonly(struct __sk_buff *skb, u64 flags,
>
> so I suspect this is never used and not needed now. Please check.
> It can be revisited in the future when other hooks are supported. It will be a
> useful comment in the commit message.

You're right. This is dead code ATM. I missed that. Will remove.

[...]


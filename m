Return-Path: <bpf+bounces-63704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C277B0A03F
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 12:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52E88175E6B
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 10:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B0529B78E;
	Fri, 18 Jul 2025 10:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Z5vAC6Wm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF991EEA55
	for <bpf@vger.kernel.org>; Fri, 18 Jul 2025 10:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752832925; cv=none; b=ezVZp+2a/LZXwcZYWsOvv8fAs4wHkAGWQ7kYW0inA+UKdRMrjnhfGx1Cf/7nWBi2fMl8zSvk1jihznCnvI7KFbnlFYxv2cwlyJvQEuymvF1xAYwhsSV1+4EAHWV3Bmjs18kemn52afVypgzN9CcYBAdxz6c6H7mDqMMM5551Pjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752832925; c=relaxed/simple;
	bh=/yRxMaBFbLjVXqz7GM9pN30yeoya9gtzSlwfdG4uCRY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n8ClLgZx9IahyY2s5bJ0VVa3VXacW+K6goirqvh28dMDiTMXkZ5V9qc/MWp9NUBJXHQma2nyAUmuA+0qT37I6NQcxQo1u8ZkawDVsYckJ/pPfBwnxlJqZh9kHQgj0eKW9/+ZAWQqX6Ykssw93H7Z776ayqg+Yvzve63tiBQwM5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Z5vAC6Wm; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60c60f7eeaaso3216563a12.0
        for <bpf@vger.kernel.org>; Fri, 18 Jul 2025 03:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1752832922; x=1753437722; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=y3dM5w5cLFSL0sY5rQUowY8lCUWz8H01o33zPOvel0s=;
        b=Z5vAC6Wm8gEpDAoCvB2XzpWKXcWASPBxOX2WHwonrfyFSkygkded0s9Ra9Qign/8Ld
         ERcrfGqnYZ1C0FfZEGbI2clm9o4i1yfO2gzWNtjmN2n4QyXiS79VqI7XVl0zxvw/jiTQ
         AtlofNYG0SEQ5cAFpGtJ1UsEkB30ZZQRWeTV6i9Jz+7XzkiNAEaeOA3TXcjX6mVJJHDF
         SsopFQMa6HPSwPkPP37G9oAHoyr2CCfeDmYyF0xbR0ISeftp9MybrRz1n4w0R1yGfsnx
         O8iDUP402qaTiTatYjL1ubGhi1nJttHN9Yu6pQbfWlfNmKeydmnrbNA020N4KCDzUzR/
         kmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752832922; x=1753437722;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y3dM5w5cLFSL0sY5rQUowY8lCUWz8H01o33zPOvel0s=;
        b=kbwP0Jrct810stT8yV9jhzERu45m9C+y/J5jqWN2Tt4c16url7726ggU7qR23ir3j3
         iqfKMqTHpOrDK7+lTcpwiWCFOmlH38qOizbAOQUuFXB5dcYzHlJiUCRKr/4GHUbkMAoR
         LfxNut88KCulgbT9OHUlT4yTAVNe9mAioRoVo+9tee4IskQm/1MwSq2SkxMGNZ2/JI96
         JSmvYZFdBSW1LDhvrMHCHuN3xuac3xngVRF37hKpfUjJNOzPK9NRg0WEucKI3chvvmUp
         Znn3tRic6lIudwaRRbAy2/oOlRf5zTd3npqyB1xz9rF950RjocmLUUALa30MzoNuVgKN
         KGqw==
X-Forwarded-Encrypted: i=1; AJvYcCXcbjM5q6U5IykyRT+Hftd564+SkwuaukR/KFSbdmpyveteV6+iFriB0hBCw0sWqwZBL2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXugukpwZzmbledmLwcgsej3WHzGkHh854/GpAjFSQPnJxssF5
	uxKJSdd1llRTyQbkg9qVinN8ioQ3ueNtYjHefCAdOZNgMEeHxErY7d1MfAl2cOyRr4Y=
X-Gm-Gg: ASbGnctn5FUdQb4+/SJIMIC6RocgPcDeP0WyF6O2UpYDtYcGzSShh03DWULbfL4jMSB
	6Sg/x2CexOMriFkaajiqy6c/teKGx2E/TkIQhotxHrfxOnaYGIRuqQEmu43D5H6MCxeeiQodgJ3
	PEZGxnGTr4kqHGRZ7nqmUOtEBshliunrMnOsGHxK5WpXA9fT/mS2KkzZRscVOWbfhOA9JKhxprv
	QhVSdDuFO7wQbIJjYM0lcC+u9KMpqljRzvZSb8/Hx9QJlU3O/g148sc54ieCfY3BH+LX/BS27hl
	s5SQW8ylhrkNNaRxJxFk0gBrgJ+8SeYa+47us5dQpQpVzaagOzoD9SiPEefS9OseHbkSjrWx12b
	QaBgI6SRZlcaG
X-Google-Smtp-Source: AGHT+IErQpP/f5UuJHDS5oYePExlcwMb0yScDJ9SoNB1SiWmqqp1PpQM31HlCg0sIE2WjdLkZZNZLg==
X-Received: by 2002:a05:6402:3510:b0:612:d5b9:bb41 with SMTP id 4fb4d7f45d1cf-612d5b9bca9mr797210a12.22.1752832921624;
        Fri, 18 Jul 2025 03:02:01 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:ca])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c8f36f49sm751077a12.22.2025.07.18.03.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 03:02:00 -0700 (PDT)
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
Subject: Re: [PATCH bpf-next v2 01/13] bpf: Add dynptr type for skb metadata
In-Reply-To: <9aa1f2b0-0f63-45e8-b787-e14d53cac75a@linux.dev> (Martin KaFai
	Lau's message of "Thu, 17 Jul 2025 17:06:21 -0700")
References: <20250716-skb-metadata-thru-dynptr-v2-0-5f580447e1df@cloudflare.com>
	<20250716-skb-metadata-thru-dynptr-v2-1-5f580447e1df@cloudflare.com>
	<9aa1f2b0-0f63-45e8-b787-e14d53cac75a@linux.dev>
Date: Fri, 18 Jul 2025 12:01:59 +0200
Message-ID: <875xfpes14.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 17, 2025 at 05:06 PM -07, Martin KaFai Lau wrote:
> On 7/16/25 9:16 AM, Jakub Sitnicki wrote:
>> +__bpf_kfunc int bpf_dynptr_from_skb_meta(struct __sk_buff *skb, u64 flags,
>> +					 struct bpf_dynptr *ptr__uninit)
>> +{
>> +	return dynptr_from_skb_meta(skb, flags, ptr__uninit, false);
>> +}
>> +
>>   __bpf_kfunc int bpf_dynptr_from_xdp(struct xdp_md *x, u64 flags,
>>   				    struct bpf_dynptr *ptr__uninit)
>>   {
>> @@ -12165,8 +12190,15 @@ int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
>>   	return 0;
>>   }
>>   +int bpf_dynptr_from_skb_meta_rdonly(struct __sk_buff *skb, u64 flags,
>> +				    struct bpf_dynptr *ptr__uninit)
>> +{
>> +	return dynptr_from_skb_meta(skb, flags, ptr__uninit, true);
>> +}
>> +
>>   BTF_KFUNCS_START(bpf_kfunc_check_set_skb)
>>   BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
>> +BTF_ID_FLAGS(func, bpf_dynptr_from_skb_meta, KF_TRUSTED_ARGS)
>
> I looked at the high level of the set. I have a quick question.
>
> Have you considered to create another bpf_kfunc_check_set_xxx that is only for
> the tc and tracing prog type? No need to expose this kfunc to other prog types
> if the skb_meta is not available now at those hooks.
>
> It seems patch 5 is to ensure other prog types has meta_len 0 and some of the
> tests are to ensure that the other prog types cannot do useful things with the
> new skb_meta kfunc. The tests will also be different eventually when the
> skb_meta can be preserved beyond tc.

That is a neat idea!

It will let me drop three patches from this series.  Let me do that.

Thanks for taking a look.


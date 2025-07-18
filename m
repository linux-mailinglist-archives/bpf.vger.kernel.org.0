Return-Path: <bpf+bounces-63760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D275B0AAAD
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 21:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E1171C46C8E
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 19:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2E82066F7;
	Fri, 18 Jul 2025 19:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="T6FjiKBb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A66C18E20
	for <bpf@vger.kernel.org>; Fri, 18 Jul 2025 19:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752866833; cv=none; b=RHdD2RyhI6nVWmWJVtL1riqUdkdm3Y3hF7eHio7kPz1djRq6OWKxF3Z5Ej6JusvvdYQFpiCkuMI3I2OQlXw1lKCA9tI1vJsmiDqT/sGViVcMqfSh0rXiXW2QNbEtsrJfdPNvwNV61TvoH3Kfff6W4JhhxFmKh7GIRyttcb+3CG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752866833; c=relaxed/simple;
	bh=25+to93ShQHSvOuoIexentfc5C2YcmA4FilaMDheiOo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CL3vqpmhsM7vu1DCNKW3kyUCIKsJ7DX4vGtkbbX6LKNDqqa7UgqroJBfbSBh1yIr72GzrDaQLcZfcceJQMnOuRpBHYhNw4eSWJ2QNztpWkStMmWNl45j/pekoIv4dfQC8Ge4OuqwhkKHPXdSDJAdBi0CWo3Zi7T0uEW+EEpQTpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=T6FjiKBb; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-611f74c1837so4520228a12.3
        for <bpf@vger.kernel.org>; Fri, 18 Jul 2025 12:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1752866830; x=1753471630; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=emAG3cpajcjjwK0jkPQTeWHCQ//4c8ADIC+eWWCB+tk=;
        b=T6FjiKBbwge+neZ/J5omMZdGrPV3C5Ici7bHUB7U+pcCGZXdRLqNnREkXDtcHUw0aF
         J7VuFXepo9U++hTAhbPV2B4Z8BUSHGb1jkaOS6Ck8I8p/1oBBbd3wqwZvBT/AHVncHPh
         2sHAuRaKB6hSzy7Ib8ku6h5X9orQaAXp8QvbABPYO0TVHW0z6uQgms3Z2UBpvcb/Haup
         ReErZvy6BzD4vjrV7eB6CIgvyrZ/ucfzi3RyUwgGvrA+K4undwTaHUjnJV1V85fBwOCf
         S3EISfFqlQXbXH+Gup3yZqSXN2oZEd9CxYwlRB1nAlcsZIKmdDZMBXyEd+/ZjARUm2el
         N/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752866830; x=1753471630;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=emAG3cpajcjjwK0jkPQTeWHCQ//4c8ADIC+eWWCB+tk=;
        b=Pwg7quvWw9HYbRnRs36p/Cf+5IiDbGKzZiOc3zh89LA62/TUE34fGviFiuXSD52JtL
         JAbXc5kd6bEI2hkJJgUvSPsFNDfoh/3KY/pVYtRK8j1uYGUfLNteUVdx7Akne3G2a3Ss
         W31x1w2rmQYRTbQgmw3CDKTgO2ixck9P7HwicED3JNqHd1g7bvJxH14w+5mhK9CDoYqw
         oOF2wuplyAmX0+nuawU5RXdzGOEZw2iCkMg5+Vb6D+wj7RVMnKvmon4a9kXsMvIiByPi
         rmdDDog8jlueWF3BL8DGByBjKLE0ZAqiJYQfXCE3PduHGiqIE+7dIPOXx7ssHdSwNxZF
         pFaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbv/X/kuYS/ea6L6A0aj2Pt+ABf9Gk20eDRgo1Cri11pPFkHGRmjrapYky1REaUyG31ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqHDq3CdRrJqRy2/xsCYn4S0EFzpSMab+t7PUzXuVrH6HvNVFd
	ilLC+m0RyYXDLq0yADQemghai5Pp7ad/iVbHNBZCI0vneFbzukT3DemH8hpbiNMzlZ43tk8YzQs
	PP+U1
X-Gm-Gg: ASbGnctEDHA6Jm/P1lxCYvZtDwkjnTpEc+x/opJUvW4n6/JvgPuu9Bkj18hVbDQLuqp
	QnYI3hd3jigStIcnh4mELmbjOUvKKgyZ3HwZkfsH3ibx/NwjCLDOmE38/cxBmNiwHI97dyQOF/z
	cC2wht0fJVrudoyCowKPff/CTlDNIYuaQ26xwLRpQi39kLJXGoC95US0vSOEiutfCG3rgt7eq4n
	EmURs8aMREfzdxjU8wW5NgXNIhp5ES1ybbOLX15DGRWWnc08Pms4u8i3aAPBOhZZIenhkxd3mCF
	GxE2LEjaqyT3lhyqIPUYFqF13xNMi5RWihiGhOacBWRDx3Agf0lSKk787avSrCVLPIetydoyde+
	9l88NXApReSXTloE=
X-Google-Smtp-Source: AGHT+IFHP79HD4JFd5kxhWz8FDhjOhMfmvGsZY7qNlS4B4/b4vmUL1UzgqjcbBlVKY//SsdR5LdM6Q==
X-Received: by 2002:a05:6402:13ca:b0:608:8204:c600 with SMTP id 4fb4d7f45d1cf-612c731f6c0mr3736800a12.3.1752866830529;
        Fri, 18 Jul 2025 12:27:10 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:cc])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c8f09db1sm1428133a12.8.2025.07.18.12.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 12:27:09 -0700 (PDT)
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
In-Reply-To: <1ae43248-189e-4765-b43c-b80e58160587@linux.dev> (Martin KaFai
	Lau's message of "Fri, 18 Jul 2025 12:19:44 -0700")
References: <20250716-skb-metadata-thru-dynptr-v2-0-5f580447e1df@cloudflare.com>
	<20250716-skb-metadata-thru-dynptr-v2-1-5f580447e1df@cloudflare.com>
	<9aa1f2b0-0f63-45e8-b787-e14d53cac75a@linux.dev>
	<875xfpes14.fsf@cloudflare.com>
	<1ae43248-189e-4765-b43c-b80e58160587@linux.dev>
Date: Fri, 18 Jul 2025 21:27:08 +0200
Message-ID: <87wm85cnar.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jul 18, 2025 at 12:19 PM -07, Martin KaFai Lau wrote:
> On 7/18/25 3:01 AM, Jakub Sitnicki wrote:
>> On Thu, Jul 17, 2025 at 05:06 PM -07, Martin KaFai Lau wrote:
>>> On 7/16/25 9:16 AM, Jakub Sitnicki wrote:
>>>> +__bpf_kfunc int bpf_dynptr_from_skb_meta(struct __sk_buff *skb, u64 flags,
>>>> +					 struct bpf_dynptr *ptr__uninit)
>>>> +{
>>>> +	return dynptr_from_skb_meta(skb, flags, ptr__uninit, false);
>>>> +}
>>>> +
>>>>    __bpf_kfunc int bpf_dynptr_from_xdp(struct xdp_md *x, u64 flags,
>>>>    				    struct bpf_dynptr *ptr__uninit)
>>>>    {
>>>> @@ -12165,8 +12190,15 @@ int bpf_dynptr_from_skb_rdonly(struct __sk_buff *skb, u64 flags,
>>>>    	return 0;
>>>>    }
>>>>    +int bpf_dynptr_from_skb_meta_rdonly(struct __sk_buff *skb, u64 flags,
>>>> +				    struct bpf_dynptr *ptr__uninit)
>>>> +{
>>>> +	return dynptr_from_skb_meta(skb, flags, ptr__uninit, true);
>>>> +}
>>>> +
>>>>    BTF_KFUNCS_START(bpf_kfunc_check_set_skb)
>>>>    BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
>>>> +BTF_ID_FLAGS(func, bpf_dynptr_from_skb_meta, KF_TRUSTED_ARGS)
>>>
>>> I looked at the high level of the set. I have a quick question.
>>>
>>> Have you considered to create another bpf_kfunc_check_set_xxx that is only for
>>> the tc and tracing prog type? No need to expose this kfunc to other prog types
>
> After some more thoughts, lets target it for tc only. I think skb_meta is not
> available in most of the tracepoints now. Lets wait until the skb_meta will be
> supported in other hooks/layers first.

Makes sense. I was planning to drop patch 5 ("net: Clear skb metadata on
handover from device to protocol"), which means
skb_shinfo(skb)->meta_len could be invalid at some tracepoints.


Return-Path: <bpf+bounces-59121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DA0AC6185
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 08:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 238E716F088
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 06:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95881D86F2;
	Wed, 28 May 2025 06:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdMuX1f2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071DD1F37C5
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 06:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748412192; cv=none; b=UpzS703U2BDROD605P/sBhcr5L1eV9ZCfVRPoLjyzCFGlvOr59ASOul/A45BXAskFnDizBifzCHEcYrQaOsghUdX5s8TPDvvkyvPYFHmZl6wRhdpyTgxeYap/ny5TW3VMDxVUFXAqEqUFMzCSPvS8bxC1ByF4jdUHm2eVoyzAlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748412192; c=relaxed/simple;
	bh=25C2ByMW38yBCKgWFqPLmKDvnuMtn7THQn9DYc/H9l8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C1WHFP+8taq70W9tbPERQqRHFr4yw9e7QBDhEosiSp8rIUHZMct6a2THwhNONzJkZbiUsFlpSxNLC0veidT9wIOrgH1ww78ApQkE7GgBwEBQ+YAaGLRtYovK7+uEu4NhDZJnJnhS0D2CSBm/zjqTCGgT2FEpiEEXh2Z3Q5DH3nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdMuX1f2; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-310e1f4627aso3873172a91.2
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 23:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748412190; x=1749016990; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rE5pIQdVScxtEl4XcmK3ZxQmS/2Y5VLSYTUJ62o/LCA=;
        b=ZdMuX1f2DhoLjtuHKjNmkyxyHQ6VHv0EHTOUjZgLIA3pE38yJ8wfi8ZSv2C5Blaesl
         9osBcatz2XMr76c6r720jiV8IIm3wdE74SVWJoFYG+LLz42oECUVgNN0yXF6Ah+HdtvG
         kp668sqr7tcXs3Beh/Eme8afi0TaxxA9h8ucrSIjVNVRObgWcIMbRk+9s9+FQ64Akg23
         Qiw1fU88Z8/jbvXubhsiEvyrpSpDRp/lFZaXyDeqq/8z24rlUxUM8FbrqKsTTwfC7oUG
         o8OFYBODCrW9st9TV7qL8IJLsxSjsB+EQkoCfA87GXR70m+GmTuRlZ1WN3mYYcTwr78M
         Aqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748412190; x=1749016990;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rE5pIQdVScxtEl4XcmK3ZxQmS/2Y5VLSYTUJ62o/LCA=;
        b=PWNCxHEoGEQ5hnT91wG8fvMDTZR5Re6lR2Jb3RoGDgFIU4Mkhagd2s1YJLAVdOzvVE
         1T8d7y+JH5kFT1dLaCZqrE5WyEPJ8DRp7q9x1B4EC0v2oyxQpph03r3desp+voQhB91Q
         Q0WIUi6t7LN+81WFeK6dUNXZG0nZFQMRBj/XfCMiDF3hD2XH4EO/2bc9iTc1MLAVursk
         2RMC1sRhh7CCuBfy6MsUNXrUKY1dLcTeAWzJhyWXfnqOaAJhnSZN/u7xVHYmsx530pla
         hljWxYYrtODOe1SP3MHeMloLY36KeVa4hTeJtcrXJdeK2t5FDyxlJ6/gh/VNE4vDDMw3
         tXew==
X-Gm-Message-State: AOJu0Yx6mRN66vE6fGo6p9Vl785jge14CIO5CZAWMv4GBY24qPOjDNeA
	sviRTNnVraP0Ul0e5N0D24kIANtbvVgruGn9mAnLt75DPCsaYD/d4iGh
X-Gm-Gg: ASbGncsDVGX6Wv02lO7hha/F26spPFsNZ7gUI6rpCL7slaT/WLF+U5l0ivhRyL9714/
	0RBKIXz7V4y0WBf53bW1LHIbajfKM7ttLU7qsnCTQgfFunPRVdcxc5G0ftG54ABNOLeQPZjfphL
	rnb7OvR+FjQEaAv8bW77CKcshW485iMsWmncHR+g/rbP3tIteiiGnGWscjf6gAY4FROjNiOLasr
	U4W+3I1Mt7RL+2dRDqXKQEo26u1FqGF13fT7RZXGwcxPT2kWhl7HJMUmCNsMdDqWceHgtZWGFRe
	428AmdFdJEV5FVDCmQScKoMeQZy5TZaHhdSoSOqR3Jv74BOsIldl/wlZTg==
X-Google-Smtp-Source: AGHT+IETNO8mtsOm7t6bYvN5zmmK4TpjDM7Eex+J/f3idsZUm5KJGZYbvI4wL4ypU/BYqeKbcH9TbQ==
X-Received: by 2002:a17:90a:e7ce:b0:2fe:a515:4a98 with SMTP id 98e67ed59e1d1-311108a0eb4mr21135160a91.31.1748412189931;
        Tue, 27 May 2025 23:03:09 -0700 (PDT)
Received: from ezingerman-mba ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-311e47e66c7sm571238a91.48.2025.05.27.23.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 23:03:09 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  Martin KaFai Lau <martin.lau@kernel.org>,  Emil Tsalapatis
 <emil@etsalapatis.com>,  Barret Rhoden <brho@google.com>,  Matt Bobrowski
 <mattbobrowski@google.com>,  kkd@meta.com,  kernel-team@meta.com
Subject: Re: [PATCH bpf-next v2 05/11] bpf: Add dump_stack() analogue to
 print to BPF stderr
In-Reply-To: <CAP01T74WSqhWPGVXrDfLRbtgM5Om0MiL4_x=1Od3QOPERj8BdA@mail.gmail.com>
	(Kumar Kartikeya Dwivedi's message of "Wed, 28 May 2025 02:58:15
	+0200")
References: <20250524011849.681425-1-memxor@gmail.com>
	<20250524011849.681425-6-memxor@gmail.com> <m2tt5536n8.fsf@gmail.com>
	<CAP01T74WSqhWPGVXrDfLRbtgM5Om0MiL4_x=1Od3QOPERj8BdA@mail.gmail.com>
Date: Tue, 27 May 2025 23:03:06 -0700
Message-ID: <m2jz612rxh.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

[...]

>> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> > index 6985e793e927..aab5ea17a329 100644
>> > --- a/include/linux/bpf.h
>> > +++ b/include/linux/bpf.h
>> > @@ -3613,8 +3613,10 @@ __printf(2, 3)
>> >  int bpf_stream_stage_printk(struct bpf_stream_stage *ss, const char *fmt, ...);
>> >  int bpf_stream_stage_commit(struct bpf_stream_stage *ss, struct bpf_prog *prog,
>> >                           enum bpf_stream_id stream_id);
>> > +int bpf_stream_stage_dump_stack(struct bpf_stream_stage *ss);
>> >
>> >  #define bpf_stream_printk(...) bpf_stream_stage_printk(&__ss, __VA_ARGS__)
>> > +#define bpf_stream_dump_stack() bpf_stream_stage_dump_stack(&__ss)
>>
>> I don't think we should add macro with hard-coded variable names (`__ss`)
>> in common headers.
>
> Hm, right. But this is supposed to be used within the stream stage
> block, and we have __i variables in macros that wrap around loops
> etc., hence the double / triple underscore to not conflict. Anyhow,
> I'm open to other suggestions.

I missed that this macro is supposed to be used only inside
`bpf_stream_stage`. Nothing pretty comes to mind, I thought about using
cleanup.h:DEFINE_CLASS, but that thing is ugly in its own way.


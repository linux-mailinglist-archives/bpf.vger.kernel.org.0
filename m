Return-Path: <bpf+bounces-65504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6B1B247BB
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 12:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56671173A41
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 10:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227772F531D;
	Wed, 13 Aug 2025 10:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="MMj7flaC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAB32EFDA9
	for <bpf@vger.kernel.org>; Wed, 13 Aug 2025 10:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755082266; cv=none; b=n7iNG4NTKf5FNk4M5Ot+q1rFpBVv3O9zz2YlYiivZ1Vx6XsM1LViYPumoEdvMMuSrBC5m4TJEokojobggFRd/3gdSrqNPdEMcOPSmkaNaY+sd+2oAyoKFxDi3NtV9aazRzbIHZHqKsFpWLUuGrGj2zl4tV1nwNCBRO6FNNqA2vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755082266; c=relaxed/simple;
	bh=wNK5lBJzwimNHmcXGboZZmgAmZaqShiy3WWQ+VHyvok=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mqkZ0X0HLNpXl1/tKBXe/1y4hECYRDrJtSmlBjFn2zATVkEjc23u6ADM9fm/dX4wJ2sL1IKJiLQ1mSjwtm5PJr5xDiS5Z4Q/yU3gOUm5yPqDNiB11ABHsTywljOPs6K/WzfYe4Em6uGGbcNl3RdDemAd5O2z83GvGWQv5mLhfPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=MMj7flaC; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61571192ba5so10057842a12.2
        for <bpf@vger.kernel.org>; Wed, 13 Aug 2025 03:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1755082263; x=1755687063; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5oAiMi3nnvltNkOnmAA+pFRA1Bt8cfGMzxHvnl7fWPg=;
        b=MMj7flaCsZQn8EHgCOzS3k5eDGl/vHpwncLHHBSQlW0YHEVaAJ/ZFBsEPvuIE4nySK
         BRvKx//elz60Desfk5j72y6XoUcCXguJn4r0lpvkP4EO94OCXZ0lJsvZUo4pJ+Wu8UF4
         R0HrrMVlwziwCUkdbn9sgpnpkK22NE7egd0lqcnZqcza2lP0riHBpTJcelnodQ4iWPlB
         Zp35W+EcUWEwHlRwPdIZSOrp1u/1PEIwBm5dZ9td3aEYFFpOo+TUC+Od5HUEDCrfW06+
         9hBVLzjkTHqnP+pK/y7l1NmWr2anILXXQ2xna3uKGlLp5S2kW3tZA6LuIlmZ5wq4OzXA
         HaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755082263; x=1755687063;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5oAiMi3nnvltNkOnmAA+pFRA1Bt8cfGMzxHvnl7fWPg=;
        b=xIYmxZbBV5kTIPnbjV7v7KKOIAYl/hGWUw7GFfkXVxu3UCqWPH3ObeAOD3g0INMXEj
         OCZTPgnKtzrGgh3vQ7h4A9yLYwCzV6Ik/SNO2qbATXTZviO1Geqgcxptv1lc99DoDMyT
         BDmZOicwxeuRVKxhKYzvBw34P0wVID8CWsPaxt2nelNKqh2KL1qMb41UoSugRB/xZag7
         7qFvOJitcP3D0ixPeh5hfTa/NG/qQmZyQIQhf3RgGJhm8iUzytjjtOmpnkC2Hg+Xdjj+
         Jv497boEeEJi4psb7ov3q+tGvqMvmXEG9WvG897lN8vawz3AaUt/HCPIwVIljvqfWIzv
         kjvw==
X-Forwarded-Encrypted: i=1; AJvYcCVtp8KO8WYsRH4AR34+DRNyb8sWGPEC6jqfDl0F21g8RDU/HTTk7oROrMOEMkSUsJQKbEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXlhK8PPonJYrRuu6rvIMvHNkGQKG6ZfOl5LF7gzToApl/YX5/
	16gS31/quqh0z7cSJpi3gh4OSwdkBCUajA9ew2Ey0P+RK5yj/D3mhEm0V8NKK0uwVv8=
X-Gm-Gg: ASbGncsQ/SOT3vxtm2U8yh09P3HCFpAn5uPuxoMc98z7QYPQ5PiGr0nFPOiRGB2WdlG
	AaOS5KODkafUCrZB2Z0eE7Al4N6GvpFxpnzvgeU6cuaQ7yDbT3pQnw5CPaeTMIKp6kNfqtKH486
	KU7DfFGM3P1Xg+SAGrOKR6GpCy94TdBUaWyxsICL/YnWtkk93HsDjFUYTHsksum2NIO5997tHlZ
	GrjL2LMANPVhwGyoATYNg6dyBhgmIMu7SezWjvUgMszotQmwpYQdpe7XZtWlK38OJsd26EHyDVK
	StSCq5CapYj2om4KCmm2GdgUPLNAMdDt90we/99t0Vr7xYs+ppIsQlVJ2aLO8bQVwUn9mI8W0x2
	a/INyPpYdq0kDfAmI0LctD88////7bGs=
X-Google-Smtp-Source: AGHT+IHXn8ZGpEgaNIv9TfD+n1v38FElmDllM3HbdYQuhuq+CPsrYjrA1BiA3xDaFDKkCPVB+44ctQ==
X-Received: by 2002:a17:907:d28:b0:af2:3c43:b104 with SMTP id a640c23a62f3a-afca4ef2446mr267215266b.54.1755082263167;
        Wed, 13 Aug 2025 03:51:03 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:6c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0df2e4sm2366000666b.62.2025.08.13.03.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 03:51:02 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,  Andrii Nakryiko
 <andrii@kernel.org>,  Arthur Fabre <arthur@arthurfabre.com>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Eduard Zingerman <eddyz87@gmail.com>,
  Eric Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,
  Jesper Dangaard Brouer <hawk@kernel.org>,  Jesse Brandeburg
 <jbrandeburg@cloudflare.com>,  Joanne Koong <joannelkoong@gmail.com>,
  Lorenzo Bianconi <lorenzo@kernel.org>,  Toke =?utf-8?Q?H=C3=B8iland-J?=
 =?utf-8?Q?=C3=B8rgensen?=
 <thoiland@redhat.com>,  Yan Zhai <yan@cloudflare.com>,
  kernel-team@cloudflare.com,  netdev@vger.kernel.org,
  bpf@vger.kernel.org,  Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH bpf-next v6 9/9] selftests/bpf: Cover metadata access
 from a modified skb clone
In-Reply-To: <ff37dd97-dde7-48a3-9bb6-7d424f94e345@linux.dev> (Martin KaFai
	Lau's message of "Tue, 12 Aug 2025 11:20:35 -0700")
References: <20250804-skb-metadata-thru-dynptr-v6-0-05da400bfa4b@cloudflare.com>
	<20250804-skb-metadata-thru-dynptr-v6-9-05da400bfa4b@cloudflare.com>
	<7a73fb00-9433-40d7-acb7-691f32f198ff@linux.dev>
	<87h5yi82gp.fsf@cloudflare.com>
	<e30d66a8-c4de-4d81-880d-36d996b67854@linux.dev>
	<87tt2cr8eb.fsf@cloudflare.com>
	<ff37dd97-dde7-48a3-9bb6-7d424f94e345@linux.dev>
Date: Wed, 13 Aug 2025 12:51:01 +0200
Message-ID: <87plczqyui.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Aug 12, 2025 at 11:20 AM -07, Martin KaFai Lau wrote:
> On 8/12/25 6:12 AM, Jakub Sitnicki wrote:
>>> No strong opinion to either copy the metadata on a clone or set the dynptr
>>> rdonly for a clone. I am ok with either way.
>>>
>>> A brain dump:
>>> On one hand, it is hard to comment without visibility on how will it look like
>>> when data_meta can be preserved in the future, e.g. what may be the overhead but
>>> there is flags in bpf_dynptr_from_skb_meta and bpf_dynptr_write, so there is
>>> some flexibility. On the other hand, having a copy will be less surprise on the
>>> clone skb like what we have discovered in this and the earlier email thread but
>>> I suspect there is actually no write use case on the skb data_meta now.
>> All makes sense.
>> To keep things simple and consistent, it would be best to have a single
>> unclone (bpf_try_make_writable) point caused by a write to metadata
>> through an skb clone.
>> Today, the unclone in the prologue can already be triggered by a write
>> to data_meta from a dead branch. Despite being useless, since
>> pskb_expand_head resets meta_len.
>> We also need the prologue unclone for bpf_dynptr_slice_rdwr created from
>> an skb_meta dynptr, because creating a slice does not invalidate packet
>> pointers by contract.
>> So I'm thinking it makes sense to unclone in the prologue if we see a
>> potential bpf_dynptr_write to skb_meta dynptr as well. This could be
>> done by tweaking check_helper_call to set the seen_direct_write flag:
>> static int check_helper_call(...)
>> {
>>          // ...
>>         	switch (func_id) {
>>          // ...
>> 	case BPF_FUNC_dynptr_write:
>> 	{
>>                  // ...
>> 		dynptr_type = dynptr_get_type(env, reg);
>>                  // ...
>> 		if (dynptr_type == BPF_DYNPTR_TYPE_SKB ||
>> 		    dynptr_type == BPF_DYNPTR_TYPE_SKB_META)
>> 			changes_data = true;
>
> This looks ok.
>
>> 		if (dynptr_type == BPF_DYNPTR_TYPE_SKB_META)
>> 			env->seen_direct_write = true;
>
> The "seen_direct_write = true;" addition will be gone from the verifier
> eventually when pskb_expand_head can keep the data_meta (?). Right, there are
> existing cases that the prologue call might be unnecessary. However, I don't
> think it should be the reason that it can set "seen_direct_write" on top of the
> "changes_data". I think it is confusing.
>
>> 		break;
>> 	}
>>          // ...
>> }
>> That would my the plan for the next iteration, if it sounds sensible.
>> As for keeping metadata intact past a pskb_expand_head call, on second
>> thought, I'd leave that for the next patch set, to keep the patch count
>> within single digits.
>
> If the plan is to make pskb_expand_head support the data_meta later, just set
> the rdonly bit in the bpf_dynptr_from_skb_meta now. Then the future
> pskb_expand_head change will be a clean change in netdev and filter.c, and no
> need to revert the "seen_direct_write" changes from the verifier.

I was planning to keep the "seen_direct_write" change once
pskb_expand_head is patched to preserve the metadata. That way
bpf_dynptr_write(&meta, ...) could remain just a memmove.

But to be fair, at this point I don't have the code worked out, so who
knows how things are going to eventually play out.

All right. Let me make the skb_meta dynptr read-only for skb clones for
now. That sounds like a clean cut compromise since it's a corner case
which we expect no one cares about at the moment.

Thanks for guidance.


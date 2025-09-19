Return-Path: <bpf+bounces-68929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F0BB89718
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 14:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E58B616C832
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 12:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0871A31062E;
	Fri, 19 Sep 2025 12:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVdtI97L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1B71E520F
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 12:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758284862; cv=none; b=Q4nKIx3ITzrRTnP2fX0WuVFriLdzYZ7vBIJ0TmEkJTyudo28GnSvdivFOeiWOVDe16vBj/YOLhhtWoVGrln9Gfhl/FipvCY0kKhPu1C+gwbZ+bpqKGK9gVnL9k4t1NgVnhR9MOCK8j5koBzEjK56LOJeASAy55OehBSF6anjyCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758284862; c=relaxed/simple;
	bh=Uwg7ExyhvmfyuF7k3yd1R7T278NCRH0bYBA3xhACBrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mr/7o4BlV4A4R56BZgwSjAJsehOCQQnXxm2t/YUJ2Rq4CKCAWF7KRMhbQgsWiuDEK8c7vnylaQn+7nE88HbzKDOYpmGktcWy4gVlbjpwKvnG0oBiRM/N+YZuqCoeYkrb0Ua1EBfEd+GQ/rpgXRG4E/hv3xYJy2M+GS+P1xTyp2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVdtI97L; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b07e081d852so402415766b.2
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 05:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758284859; x=1758889659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z7sU/kmv/r58SGMwvvrtGqIQ+H4uH2i+tgtPh6Ii9b4=;
        b=LVdtI97LGZsD9XVDjhDaHhTgIsnN0g0m5t6OoQIF3FxGbqg5dH4ih/EPfWZCD0q07f
         aFbbg/PfQhcCDRKuXQoKHmOSIBtfuwOs+nteT2zuOYimBhjVN6ITvCYWc4Il7oIr4EIj
         eQO7qpLwpQgKQd96YC69KPKUbB0R8EBa27ZCfbYite0OCwubrkNnrKBbA774HuRU6Kty
         fC39xN04Rn4IBBk4yCGkZpGVo+Wl7i1wK0ShPtHFc++E5KEapYLF0VeAE3Xq9/7JInXb
         6So4iIN0ZhwNo5zllkWYb6AR65DMOutBgdsGW6Vf77j82bloP/R1DQ0Xzi7RZo/yy5HB
         h6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758284859; x=1758889659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7sU/kmv/r58SGMwvvrtGqIQ+H4uH2i+tgtPh6Ii9b4=;
        b=vy4y/+JmHOwrz8g8jqpvsfmyVygSOJhn+cNyGXxorOka184jITuRzrRowtkLDcGq5I
         BeCVMF0+M3HJ1YZJkNXyyivWwdH/oH4aU/useZgAKmJBKqNr6oGWXrzFOOMl0kZiyojZ
         IdbpeUqbDKzwyUHctKAZUvstEB+MJZoWBcPjROdRWYst6XVKF6iMgPHNABp8O/13ijgp
         iL+xHAB7bmFznyhvxwPo5LeESqOw6le+llbmK7252gAxZiVxDnhPdMEVQwZlhH1oK8nD
         FM6LG+NvRHhdNLpxeshtX/Pmn2rSGn+/NrG66fNm0UWicNwLiDHG/zpClpFgiFmCDCi/
         YFgg==
X-Gm-Message-State: AOJu0Yx24FdRJBRdPdQZKAUHLw3Dr7tPy0f63QVd5Jvwl5mN/ABhRKFA
	Zl8H6tBbO3vlTZ/MlHk+Pn38Y2R2+0urH9q7GK9UmOxBJr8IMOD84yAM
X-Gm-Gg: ASbGnctCqtGfNE8jYftGeT1gYaV68cF1ck476LAWQHyXc1mr/ZvJ2WNNndCTjRpJ1V/
	kES0DMFVCXZ05eZxucjvdoHkxeJCRxmagM+AXjg7/6Ri2u2IsiCWSEuW4QqKbfts+tLy+eCtBiM
	Gs6HLE7zpsFc3t+TGYdtKzY+fSkXSlFf49N6DgMnkH/L5U2haf1g7hSc9LZbsYYyVg3ZQxyz1oC
	2cGBAT+ZtufT/qIc9lDQCdxv3tVg8gtazgFepg2wuNADmeRAV9yE7+qXUeNNgZgdSmbL1ObWUz9
	uDmS/W82eOGnET2xWEZJ7K5BNdXlmcfXPWOAqKjv5ZG5kCKyj00gP7jCbbvDaQ8YX7fLxTVU646
	yu8VILhFbXengCxiHVsVh3gk6YrWYtz4FI5gjP0p7l8qNj/UH2cpZHJdRfnbAezeVVl8zvKEdWf
	QdKck4New=
X-Google-Smtp-Source: AGHT+IGl0/ZucZG9Cc532uivb+ajKOwxJE6Tp7R1UdGLXMFb/bui1Y3Tg5IesDy78v+wLAEcoqYmAg==
X-Received: by 2002:a17:907:d649:b0:b04:2a50:3c13 with SMTP id a640c23a62f3a-b24eca00ebemr263861966b.6.1758284858798;
        Fri, 19 Sep 2025 05:27:38 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:f2f7:f955:bf36:2db2? ([2a02:8109:a307:d900:f2f7:f955:bf36:2db2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2636394d79sm104916866b.38.2025.09.19.05.27.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 05:27:38 -0700 (PDT)
Message-ID: <171ddd7f-a100-4800-b0f3-1ac8e25c13d8@gmail.com>
Date: Fri, 19 Sep 2025 13:27:37 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 7/8] bpf: task work scheduling kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin Lau <kafai@meta.com>, Kernel Team <kernel-team@meta.com>,
 Eduard <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Mykyta Yatsenko <yatsenko@meta.com>
References: <20250918132615.193388-1-mykyta.yatsenko5@gmail.com>
 <20250918132615.193388-8-mykyta.yatsenko5@gmail.com>
 <CAADnVQJfGqKpOhQpx_a-kKfv34XRE=hDZAN=u-=CVppUF5wfzA@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAADnVQJfGqKpOhQpx_a-kKfv34XRE=hDZAN=u-=CVppUF5wfzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/19/25 01:56, Alexei Starovoitov wrote:
> On Thu, Sep 18, 2025 at 6:26 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> +static struct bpf_task_work_ctx *bpf_task_work_acquire_ctx(struct bpf_task_work *tw,
>> +                                                          struct bpf_map *map)
>> +{
>> +       struct bpf_task_work_ctx *ctx;
>> +
>> +       /* early check to avoid any work, we'll double check at the end again */
>> +       if (!atomic64_read(&map->usercnt))
>> +               return ERR_PTR(-EBUSY);
>> +
>> +       ctx = bpf_task_work_fetch_ctx(tw, map);
>> +       if (IS_ERR(ctx))
>> +               return ctx;
>> +
>> +       /* try to get ref for task_work callback to hold */
>> +       if (!bpf_task_work_ctx_tryget(ctx))
>> +               return ERR_PTR(-EBUSY);
>> +
>> +       if (cmpxchg(&ctx->state, BPF_TW_STANDBY, BPF_TW_PENDING) != BPF_TW_STANDBY) {
>> +               /* lost acquiring race or map_release_uref() stole it from us, put ref and bail */
>> +               bpf_task_work_ctx_put(ctx);
>> +               return ERR_PTR(-EBUSY);
>> +       }
>> +
>> +       /*
>> +        * Double check that map->usercnt wasn't dropped while we were
>> +        * preparing context, and if it was, we need to clean up as if
>> +        * map_release_uref() was called; bpf_task_work_cancel_and_free()
>> +        * is safe to be called twice on the same task work
>> +        */
>> +       if (!atomic64_read(&map->usercnt)) {
>> +               /* drop ref we just got for task_work callback itself */
>> +               bpf_task_work_ctx_put(ctx);
>> +               /* transfer map's ref into cancel_and_free() */
>> +               bpf_task_work_cancel_and_free(tw);
>> +               return ERR_PTR(-EBUSY);
>> +       }
>> +
>> +       return ctx;
>> +}
> If I understood the logic correctly the usercnt handling
> is very much best effort: "let's try to detect usercnt==0
> and clean thing up, but if we don't detect it should be ok too".
> I think it distracts from the main state transition logic.
> I think it's better to remove both map->usercnt checks
> and comment how the race with release_uref() is handled
> through the state transitions.
>
> Why above usercnt==0 check is racy?
> Because usercnt could have become zero right after this atomic64_read().
> Then valid ctx (though maybe detached) would have been returned
> to bpf_task_work_schedule(), and it would proceed with
> irq_work_queue().
> tw->ctx either already xchg-ed to NULL or will be soon.
>
> The bpf_task_work_irq() callback would fire eventually it will do
>   + if (cmpxchg(&ctx->state, BPF_TW_PENDING, BPF_TW_SCHEDULING) !=
> BPF_TW_PENDING) {
>
> if releas_uref() already did bpf_task_work_cancel_and_free()
> then ctx->state == BPF_TW_FREED and
>    +   bpf_task_work_ctx_put(ctx);
>    +   return;
>    + }
> will be called on this detached ctx.
>
> but xchg(&ctx->state, BPF_TW_FREED) might not have been done.
> so the code will proceed...
> and further it looks correct when it comes to handling
> races with cancel_and_free().
>
> The point that usercnt==0 or not doesn't change thing.
> We don't check it in the steps after acquire_ctx().
> It looks to me these two checks in bpf_task_work_acquire_ctx()
> don't fix any race.
> It seems to me they can be removed without affecting correctness,
> and if so, let's remove them to avoid misleading
> readers and ourselves in the future that they matter.
>
> Note, similar usercnt checks in bpf_timer are not analogous,
> since they're done under lock with async->cb manipulations.
>
>
> Also I believe Eduard requested stess test to be part of patchset.
> Please include it. I'd like to see what kind of stress testing
> was done. Patch 8 is just basic sanity.
An example of race condition I'm handling is:
Imagine usercnt gets to 0, and then for some map value cancel_and_free()
(detach context) races with bpf_task_work_fetch_ctx() (attach context),
if this race resolves to context first being detached (by 
cancel_and_free())
and then new one attached (by scheduling codepath).
Detached context state is set to FREED and it's deallocated.
But newly attached context state is STANDBY (cancel_and_free() has never 
seen it)
and map holds the refcnt to it, which never go to 0, as cancel_and_free()
for the element has been already called, so we never free it.

It's not a problem if usercnt goes to 0 after we attached a context,
because cancel_and_free() will detach and
put the refcnt, and scheduling codepath will see the FREED state.

Other thing is checking usercnt == 0 before context initialization -
that's preventing allocation and attach a context to a map that has
already done cleanup. Cleanup won't happen again and this new context
is leaked.

Trying to summarize:
  1) First check for usercnt == 0 is needed so that we don't allocate 
contexts
for map that has already cleaned up.
  2) Second check is needed in case of clean up is triggered during context
initialization/attach, potentially leading to newly attached context leak,
as cancel_and_free() was called for old context and won't be called for 
new one.
  3) After context initialization/attach is done, we don't need checking 
for usercnt,
as cancel_and_free() will detach and transition to FREED. The state 
transition will
be seen by scheduling codepath.


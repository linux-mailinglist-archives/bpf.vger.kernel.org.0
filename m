Return-Path: <bpf+bounces-38292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16684962D2C
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 18:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF731C2197C
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 16:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954E81A4F0A;
	Wed, 28 Aug 2024 16:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFHqEVhO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8601A3BD5
	for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 16:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724860920; cv=none; b=lqCeG5mjI2CLNhIMiVyjnLToNHjWIwuOdyebdfL3g3zxEuAOoYxMcZokDJNH+Gu9SW3636SWsJhrfqEIthGPBceeBXYzbKBuNWD0PKaDvNtQeokuVjs5Ak/NaS7oPmqtyZQFrpuBQjnvlU4Y5nGNL+QsBENEUXvPbmMEB1NjAY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724860920; c=relaxed/simple;
	bh=/Wv2gJDH0RMVgu3HMNtBAKfWtLdp6g+vuAahbSdm6HA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KPKrYXYNQGpGfj11Oz5oH5zO5uHr/asqCNLNkAvnZcoee5WVJXb8gteOHsQenG1zgG4xPOQkNeWZicSJx4cMKo5IgVTfiwdQv70bERhstM47ZXpmrozYmjv6/WrWi/qFCSKxE1HQumpV4hMMgGAHjXittVprKjsWz1hcNg2DV10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFHqEVhO; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-371b97cfd6fso4447800f8f.2
        for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 09:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724860917; x=1725465717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMVbpycDoEy5kTHzK7ZIA6x0xjNY9EV8lGIbOvgPqZU=;
        b=IFHqEVhOnKVHMbf7CWboFAzFGXkpw1Hcq5VaM5rCVhOSmk2u0Jl4AGQT150G2x0e/h
         2zYkMseRlbL1Kib6TEmf5DxiYdHM6c4mPHt3zSYE7zaGrneOeoH/uqENPiNjFy/anu2e
         NYMbSY1OWhbWfQ22fZjL5WAZFWwm+/mw2cqbAZUkJufct1BcTFkT4MtrienNIj4Uvvrq
         0nbmtLYf1xzIhr/ElWojc3yNGWH0bgnb7cVkcfGyWmcHKA+ZOQqf5QK7B3dAGDTogPeR
         gwaHnQFp/LEbdkAxiPtERg6mP3V6VMSqCpwbj469AEV2+Oa3Ee4UR/0fbX8APRjTQKUX
         n7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724860917; x=1725465717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TMVbpycDoEy5kTHzK7ZIA6x0xjNY9EV8lGIbOvgPqZU=;
        b=iPNh5hq9t7ZIak89+zP8Q30NqRxPagb+EzVYdIIsWD/d95GmXwevIL4PrNrdVzAoiO
         FoGR2WnCHqza2zIO4gTGyI/g8pVB4gzq2wxtoITYvT8jQMk93O0dMs9HAVsPxKngFKSn
         3wOOorKgBMIrG8pk2MD5zsKiW+I91jHtTZIIXfTXKf1GErB/D/xBmGY/b1hWDaXUaPKq
         x0FZzKQ6eTAfiCIllTDvU6IV0Hrh/0zL2eCCFJbFK6rtsrvvsrKVnpDhqgDJb4u26fA+
         WcZA4jH/ygl6zCRtsN0IaifdF32omVlLi7RqliX/eA41aRvgpmP64mg6BAabarUyLGi/
         MWSw==
X-Forwarded-Encrypted: i=1; AJvYcCXHh/0waT2PNjD2OVMFzk3yQ6RC3v/a+XPjKcgDnJTh2HFXBXXYXbshF4hH59WETpQmexM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG/BuBuxw1uI94fQAd3ydfwQsmYzWgdATl2t1n7gTIJUe0hTsq
	jQGjvY1RIrWV9O0hGgtynAuGhyH+O7sQRQF7+9/2+r04VB9HITWZqNJQF3MZQv2GvHRFZ4kCw7c
	D0B366/JVC0/55eObcasc3UMWqnLQ8A==
X-Google-Smtp-Source: AGHT+IGyVXKNIruGN3PAOUJ5uKnNsVRmUS/cwra67TXOSlBSqiBG3p8z7JufXfWti9Js0VtrxgMJUUwz1I1nQbYlXzs=
X-Received: by 2002:adf:ee8f:0:b0:367:8fc3:a25b with SMTP id
 ffacd0b85a97d-3749b58087amr20245f8f.42.1724860916405; Wed, 28 Aug 2024
 09:01:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240825130943.7738-1-leon.hwang@linux.dev> <20240825130943.7738-2-leon.hwang@linux.dev>
 <699f5798e7d982baa2e6d4b6383ab6cd588ef5a9.camel@gmail.com>
 <dc2d2273-6bd7-4915-aa77-ad8f64b36218@linux.dev> <CAADnVQJZ_jyDzpW8rMuOH2jkiP6mAXMn21DDvF=PA9L8xYt3PQ@mail.gmail.com>
 <c63deed3-d5e5-4b1b-8cb5-ce9f92812e49@linux.dev>
In-Reply-To: <c63deed3-d5e5-4b1b-8cb5-ce9f92812e49@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 28 Aug 2024 09:01:45 -0700
Message-ID: <CAADnVQ+42X27_gv8EvoiBairsnHvjoodM4X9oxvAuuBooZyzMA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/4] bpf, x64: Fix tailcall infinite loop caused
 by freplace
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 7:36=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 28/8/24 04:50, Alexei Starovoitov wrote:
> > On Tue, Aug 27, 2024 at 5:48=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >>> I wonder if disallowing to freplace programs when
> >>> replacement.tail_call_reachable !=3D replaced.tail_call_reachable
> >>> would be a better option?
> >>>
> >>
> >> This idea is wonderful.
> >>
> >> We can disallow attaching tail_call_reachable freplace prog to
> >> not-tail_call_reachable bpf prog. So, the following 3 cases are allowe=
d.
> >>
> >> 1. attach tail_call_reachable freplace prog to tail_call_reachable bpf=
 prog.
> >> 2. attach not-tail_call_reachable freplace prog to tail_call_reachable
> >> bpf prog.
> >> 3. attach not-tail_call_reachable freplace prog to
> >> not-tail_call_reachable bpf prog.
> >
> > I think it's fine to disable freplace and tail_call combination altoget=
her.
>
> I don't think so.
>
> My XDP project heavily relies on freplace and tailcall combination.

Pls share the link to the code.

> >
> > And speaking of the patch. The following:
> > -                       if (tail_call_reachable) {
> > -
> > LOAD_TAIL_CALL_CNT_PTR(bpf_prog->aux->stack_depth);
> > -                               ip +=3D 7;
> > -                       }
> > +                       LOAD_TAIL_CALL_CNT_PTR(bpf_prog->aux->stack_dep=
th);
> > +                       ip +=3D 7;
> >
> > Is too high of a penalty for every call for freplace+tail_call combo.
> >
> > So disable it in the verifier.
> >
>
> I think, it's enough to disallow attaching tail_call_reachable freplace
> prog to not-tail_call_reachable prog in verifier.
>
> As for this code snippet in x64 JIT:
>
>                         func =3D (u8 *) __bpf_call_base + imm32;
>                         if (tail_call_reachable) {
>                                 LOAD_TAIL_CALL_CNT_PTR(bpf_prog->aux->sta=
ck_depth);
>                                 ip +=3D 7;
>                         }
>                         if (!imm32)
>                                 return -EINVAL;
>                         ip +=3D x86_call_depth_emit_accounting(&prog, fun=
c, ip);
>                         if (emit_call(&prog, func, ip))
>                                 return -EINVAL;
>
> when a subprog is tail_call_reachable, its caller has to propagate
> tail_call_cnt_ptr by rax. It's fine to attach tail_call_reachable
> freplace prog to this subprog as for this case.
>
> When the subprog is not tail_call_reachable, its caller is unnecessary
> to propagate tail_call_cnt_ptr by rax. Then it's disallowed to attach
> tail_call_reachable freplace prog to the subprog. However, it's fine to
> attach not-tail_call_reachable freplace prog to the subprog.
>
> In conclusion, if disallow attaching tail_call_reachable freplace prog
> to not-tail_call_reachable prog in verifier, the above code snippet
> won't be changed.

As long as there are no more JIT changes it's ok to go
with this partial verifier restriction,
but if more issues are found we'll have to restrict it further.


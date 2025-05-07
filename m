Return-Path: <bpf+bounces-57602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75900AAD2C8
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 03:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E11F5075EC
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 01:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616131519B9;
	Wed,  7 May 2025 01:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWdUrwPB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227D913D521
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 01:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746581107; cv=none; b=WqV/6ldPVUkfKdlTls1PlSrm0cW2F6wQpCwdL6k63D34NMSiBe9vFjuGJU8jWc6MyJf6rMskrScS57qJL3tskGq0+dsWL92wv+EQquIU+r6Vz5uAc4+aPqTKrA5z6ejYVnSY+sC6D/DK1BrcBOBmTcNQZHt1hj9GeBxuKvXUij0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746581107; c=relaxed/simple;
	bh=Uw/Uz41Zuo8BCaefCcz1CSlOspozER9fMrBhmNSzCOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6xMu6wIn0622ZF5wJrW6bo281Vl65I2sKs+H9GAAKuIuj4hosaiXaV8g8T6OF29h3c8257GJ08Sv5ny1BXuWcSqgUpaxzYDIi4pgxU95OKCaQqBrrcGF0oFbJLLO2lHm5ATd78uhhtQ/JwY72gE3lw+CcfuAqlNfbJvxN4fQC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWdUrwPB; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39c1efbefc6so4674776f8f.1
        for <bpf@vger.kernel.org>; Tue, 06 May 2025 18:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746581104; x=1747185904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STcJ7cz88Z2GYQxLWSGzIPgdGXpEDCNdJoPcyOyCD+8=;
        b=FWdUrwPBksdMKIM6kyZeUiNJ47In/5u4JeqR9fxTJscCDgpgJbZ+OXztAvsPcK80Qn
         v8ldLfJRlubDWht+9nTNQZX2yejXh2Np58tYlRFNIDdOqR5WKkvh5mNLVandM5XEqtTB
         sI1CO6my4qRNcaHmHV/VS6OqSa29ojitQy+h8/2+ZH18+tuhXKC3gXOGjQk7aA7toVBV
         Fb9jBu27NQlAbrJzwGvhOMZkhyOjkQGRWjpIrDPj1etdywlyhmWMmWopouzZ67Q1q5vt
         BGbpAAO0RZ5K07DXr/oFiaaKNBL3//UaMHRT4NpgSVon2KV71wHGgmhnSqOHDv9mIhKr
         D+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746581104; x=1747185904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STcJ7cz88Z2GYQxLWSGzIPgdGXpEDCNdJoPcyOyCD+8=;
        b=DTstV+kz78MkE2BUs/vcXdRvHowCuW6F9ANxW9dxzvJit0KtIIOb6Xujkh5eeZra7v
         yNUziXKYR7hr5lwcqMMwsjfCCqXZ3ibUVvBi0TlAQQewPjzz75jAdOjjLhvNd9H0rjzX
         FpnptvSHc7R8BwSEJblwRbowqEhXZjBKCZIE7t1M2jTAC12Xb3XM4JI0zBojmfzFftNQ
         uomk6sZfOCm7dbNP0/rkzu0LrWY9hxezt7RleQsYVY/2ovb0z2dQtLRuZKw85+LdC7Td
         fQQrJpxMm+CyFAFpdZovqSAKqXE+isNQvWPj5+NG6brruBXdX2jNHyEF+U59x2Zx2UPX
         krpQ==
X-Gm-Message-State: AOJu0YxFvm8xb/1emdVMrodUKuxtAtJ9cIysyF6dnjcosphieK//Zkf1
	69SUjz40QLr7jGh7sZCguQN91ADlhSTTL6JDrhw+LUlY69CChpxzRXVn16SZrX3NY5YqhqsOLoZ
	q/r5Ayz/Zwf1zWwz38R4/TNoJTF8=
X-Gm-Gg: ASbGnctrNealQ4mY/YlyPcHwsi4eJ867s/H9cow0jxFFGj1JFvw+fticN77/bL1JmX3
	cCDR8OCN0wL8tpxIEwZHL5n04hxLtt3je3fa9GvoDk9EquI7Wo/+5kX5CjukTY0bly9jsPLDlMq
	QwjmJmiKpTKAHxUjwCWhJ/wXPokOmEmmB5lQBWxfzAkMyomfr6m49fnNw1CeiH
X-Google-Smtp-Source: AGHT+IHkoZ+Uikl8UNLNFXXkUd0sWJcwO0/V6CvxNZWDBj0cTPFA02cryoDJ6aRf/DIBJ07uKI9aRdP9aP7QiPp03NA=
X-Received: by 2002:a05:6000:4310:b0:3a0:82d2:2c98 with SMTP id
 ffacd0b85a97d-3a0b4a17fcamr910372f8f.52.1746581104064; Tue, 06 May 2025
 18:25:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
 <20250501032718.65476-2-alexei.starovoitov@gmail.com> <441a3e7d-2000-47d2-ba13-6841eb392fe1@suse.cz>
In-Reply-To: <441a3e7d-2000-47d2-ba13-6841eb392fe1@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 6 May 2025 18:24:52 -0700
X-Gm-Features: ATxdqUE9LUw8lzsx8O5N9t-1arB5zxC0xrTbbBGJL1asY3vebdctTxb8M560wk0
Message-ID: <CAADnVQJS+sBks2qZ9tNt1hR375w+68GfZuTF+LoSveXR1hO2bQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] mm: Rename try_alloc_pages() to alloc_pages_nolock()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Harry Yoo <harry.yoo@oracle.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 6, 2025 at 1:26=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> On 5/1/25 05:27, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > The "try_" prefix is confusing, since it made people believe
> > that try_alloc_pages() is analogous to spin_trylock() and
> > NULL return means EAGAIN. This is not the case. If it returns
> > NULL there is no reason to call it again. It will most likely
> > return NULL again. Hence rename it to alloc_pages_nolock()
> > to make it symmetrical to free_pages_nolock() and document that
> > NULL means ENOMEM.
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>
> > @@ -7378,20 +7378,21 @@ static bool __free_unaccepted(struct page *page=
)
> >  #endif /* CONFIG_UNACCEPTED_MEMORY */
> >
> >  /**
> > - * try_alloc_pages - opportunistic reentrant allocation from any conte=
xt
> > + * alloc_pages_nolock - opportunistic reentrant allocation from any co=
ntext
> >   * @nid: node to allocate from
> >   * @order: allocation order size
> >   *
> >   * Allocates pages of a given order from the given node. This is safe =
to
> >   * call from any context (from atomic, NMI, and also reentrant
> > - * allocator -> tracepoint -> try_alloc_pages_noprof).
> > + * allocator -> tracepoint -> alloc_pages_nolock_noprof).
> >   * Allocation is best effort and to be expected to fail easily so nobo=
dy should
> >   * rely on the success. Failures are not reported via warn_alloc().
> >   * See always fail conditions below.
> >   *
> > - * Return: allocated page or NULL on failure.
> > + * Return: allocated page or NULL on failure. NULL does not mean EBUSY=
 or EAGAIN.
> > + * It means ENOMEM. There is no reason to call it again and expect !NU=
LL.
>
> Should we explain that the "ENOMEM" doesn't necessarily mean the system i=
s
> out of memory, but also that the calling context might be simply unlucky
> (preempted someone with the lock) and retrying in the same context can't
> help it?

Technically correct, but it opens the door for "retry" thinking:
"I called it and got unlucky, maybe I should retry once.. I promise
I won't loop forever".
So I really think the doc should say "ENOMEM. no reason to retry" like abov=
e.


Return-Path: <bpf+bounces-45853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BB99DBE37
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 01:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85428163C43
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 00:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F01279CD;
	Fri, 29 Nov 2024 00:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LejOqjCz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0065A1361
	for <bpf@vger.kernel.org>; Fri, 29 Nov 2024 00:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732839672; cv=none; b=O5rmu6ft/O5VmPDR4vauqQJoCiI+TLd0KAIPh/yvOMfp/8yudFxSiCdxK6ElbFv0EhwEUrhNkrrUNvYPfPeo4d53iovbKRwas+20SNberZn2v/iebMHJ8l22BJltz3ocaJfGFH8gZ8npVezbs2v27OKpup/17Mf0o0TXGfff81U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732839672; c=relaxed/simple;
	bh=t0g6TIUSQB+mEGv6AT+zPDuGEfPQiB/6eH8vbInLWw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pVL0qU5qdl7ruI+xkJUY2f8bjUjACnxSBWuiEBQEXSxSSYHA7bStuNdKzNl9rhXJhN1ek4WDS5t0IMWEGoNmAwyyKAWacSGFGmSSbp0UA6cxvmsbqNYdAmHZCqj89nX/NTPR0KiGskupZBx+U0i+ZsapBOQTuknMK8DDb9zpm8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LejOqjCz; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-53de8ecb39bso1585147e87.2
        for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 16:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732839668; x=1733444468; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9H1fXEbr/H6qXrhzPvxDjzNyR6r2a2NfBBYVGzWa/8I=;
        b=LejOqjCzHIyFwHCQ2BGRZXz2yCS5HU1yTBOmbNGBYDqNvzvEjHraBMSEI898opFKom
         bmvCXV2ez81L2A6vwAdFw/Gpcipu1p6KShJuukxhIfi/drJ8CXN9VC1zU+OPgk5SXrHp
         ruWgMCm4gDaZ9W4CXzf6z75G0PJb5lC2UQay9fe4gsAZ+mLTu6o90EcD+QL3jhQs4ZB8
         g+yR2wQqlBtdiVcmh1Z2UVg57JIPf8ai1Ir/ac65HhTd9g2i/XXY5WC0oELdyABTeNCm
         UNHEGCDKfJtIbKL/CEV3r+UJI6niKlf6dIGiXs7wdxjROdhaX3W3YJXYNGtg7nbASxFD
         k/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732839668; x=1733444468;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9H1fXEbr/H6qXrhzPvxDjzNyR6r2a2NfBBYVGzWa/8I=;
        b=Mgs9dwbLSyHUFL6OamTMiCWd3G9XPmMkuAomI1EeGHJbJyCavAZM6le3vQGCsno60+
         3NyGnizWTUIHMIL7ePAr4XEpzUyO/utf5u6uj6zcGafr2BV3QEuK+BUD6FFrszJ1r0bN
         rWZ8V4umT1xPqkH/mb94Wx71iWSvtWUOEtxnRB3ckv7K7us4LkfLb0a9NitKegXQESJN
         XjTKChH3mMb4bDOL6ir1r35Ax9Cx6+CELs1bHpQPztoElXEZ+VF7DyxC7OSTF2hn0761
         OeFIU4fOsTjCWe1tfeGBYt3edQaCoAWjVie+cGP7LQF/U7SvL7zP271ocSS4Ml78d4e2
         4AUg==
X-Gm-Message-State: AOJu0Yw6zCZg94RbRMgET4wt4myCZZj4zZim3in0/sT/Z7BDMklb+jzF
	xSME+Mv8RfWMXDM/n/hkq8ThzbS0A6BKVCPLyot+Sxizjuj/0onz/yQ/QvPLBQT2U01P7q1sU6U
	/AWkAyCyKvZOqUvcobABI5KVk9vzGrs0rmNw=
X-Gm-Gg: ASbGnctDieRmNj21n0+sHxXKeO3L+lPcQNngcpxLDnkJpsvXbleXcZ5uqDa9KvGx4Sz
	ywDeZfNVHGrD2Xc2/ib/DhHyZmMtxKDcrVA==
X-Google-Smtp-Source: AGHT+IEtqKHEr5Hg3NzGnTazSbECyaYnZLGqikcPEZ1U/Q3DF0aLKSET4xXnKSX5DewpgCGgm5I2q6sBmbtgJ1fBgkA=
X-Received: by 2002:a05:6512:b8e:b0:53d:d5d5:3b6c with SMTP id
 2adb3069b0e04-53df00aa1b3mr5729351e87.4.1732839668014; Thu, 28 Nov 2024
 16:21:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127230147.4158201-1-memxor@gmail.com> <20241127230147.4158201-3-memxor@gmail.com>
 <CAP01T7734jEchOaMVuUnovO5Nwzza8Y1D0K86M4zFrS7_8zegQ@mail.gmail.com>
In-Reply-To: <CAP01T7734jEchOaMVuUnovO5Nwzza8Y1D0K86M4zFrS7_8zegQ@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 29 Nov 2024 01:20:31 +0100
Message-ID: <CAP01T76mYvYpO4-5cCB89-XvTZ4KPkXm2ziKJRm=OWkez45R7A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/3] bpf: Zero index arg error string for
 dynptr and iter
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Tao Lyu <tao.lyu@epfl.ch>, 
	Mathias Payer <mathias.payer@nebelwelt.net>, Meng Xu <meng.xu.cs@uwaterloo.ca>, 
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Nov 2024 at 00:06, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Thu, 28 Nov 2024 at 00:01, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> >
> > Andrii spotted that process_dynptr_func's rejection of incorrect
> > argument register type will print an error string where argument numbers
> > are not zero-indexed, unlike elsewhere in the verifier.  Fix this by
> > subtracting 1 from regno. The same scenario exists for iterator
> > messages. Fix selftest error strings that match on the exact argument
> > number while we're at it to ensure clean bisection.
> >
> > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > --
>
> When working on this, I noticed the same situation exists in IRQ
> save/restore v4.
>
> There are several options:
> 1. If this lands after IRQ series, I can respin and fix regno use in
> process_irq_flag.
> 2. Maintainer landing IRQ series can s/regno/regno - 1/ in
> process_irq_flag, selftests don't match on argument number.
> 3. I can respin IRQ series v5 with this addressed now.
> 4. If this lands before IRQ series, I can respin IRQ series and make the fix.
> 5. It can be a follow up for IRQ series.
>
> Let me know whichever seems better.

Fixed in IRQ save/restore v5, so ignore.


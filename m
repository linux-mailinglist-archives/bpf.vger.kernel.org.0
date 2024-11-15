Return-Path: <bpf+bounces-44901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CD99CC7EB
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 01:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E6562840CB
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 00:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371291E531;
	Fri, 15 Nov 2024 00:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jK7pHEHk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367FD524C
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 00:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731630459; cv=none; b=RcL6QeD4rI4Gy9Fz+aor8oofFkM9cvhAMkNGu3gxywKh1wDnU1W0Ttki2V9QjhqrCFpkNifRwIcUMGNvcV7uG3zVxHb3jArCLunePAtHr5Xl5pBnJPywF8hugRqdlbt3czQEBspwLUAF8phHXgEWclTwh7MRlKOvl9RgRFHy3wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731630459; c=relaxed/simple;
	bh=+0yCuw4nLrW8Ha+r7FMwFgoL4gPX0gQoROS/E8wtoUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GP3UgUXVzRd1IEMc8n8tYlNUXQfid0YiAC6K+8gj/LTfA1b7zmTJlMsLR09CzccQIkoqRGgiFJeAAocsULd0f1lZSk2gPpsEkWmitwLaqj0puhGnc33VdAQUhv3yCwSb9ieVjFgx8WghMNilznbCrca9dTDPKwDAjzwqx9oFP9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jK7pHEHk; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d447de11dso122063f8f.1
        for <bpf@vger.kernel.org>; Thu, 14 Nov 2024 16:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731630456; x=1732235256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0yCuw4nLrW8Ha+r7FMwFgoL4gPX0gQoROS/E8wtoUI=;
        b=jK7pHEHkkX0QkbpqMH+Ux5ipRzK6tYrhXCGQTSXur+UMPgzK8QLpvHKH3OiEP5N+Jj
         dVEM5pICD2WGlAaRUZ45U/6yr5KRH5l58+igB8ZWJjWg96+jAgtMZ895mQIHqeN4vrdY
         o6AnvbR0l1BLUUbNSaO5NCD3Az4KOy0ORPEKpfyO41a1eG7Pv2Otr398JiJCfBaI/e+h
         H+cXe6DIf+tziAqtiq/RqkyxahBLNnqr9Lc+u1rz/FT/gwSJVvRTBy1LUU0Q+yMDZ1bP
         bxkacVfZYslIdOouAK4nfyyTtL88PjUjGckH6p4YYRMKoD7uyX2qIizAoaqBnEYLv9UK
         zPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731630456; x=1732235256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0yCuw4nLrW8Ha+r7FMwFgoL4gPX0gQoROS/E8wtoUI=;
        b=nnNLl0v9SqV0DsYeO0J5gssy7yopiji2CPNXGMz6nC41sT+j6icWxdzMjrnv8f6V8b
         Lv/zQHqh8fThyt1cv/cyiTGM+qqYOppf5g5ymcLpHSAI9Fe8CYNK8yQ1tJ9mYwL0yYH8
         zK+pjLKqhncdR41I2MaHMMnAQbqsjjwCyr+CmaSmsicyagQg5typfpd09rNiDd/nla9S
         nUAnAFJuYr94es5iLMjnXdDqiqMZCwr1LrF8Ys8+SVn/C0GRanaYNHps0XTYyp6OaZo6
         /1LTrhN0huEiG0uVmgYi/yBc7DqxOGuYnAf5bEr2WJvrXWujvwOAja+JNx3RJ/praVYR
         +6uA==
X-Forwarded-Encrypted: i=1; AJvYcCXi+brxY5v0Cf2CWVc9C8iiosIlFQBv25JhFGzDTWCofrWataGBCt7K7QyyTfBKULbL9js=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuJLuyWhkJRZWJUca6nrMxADoA6wN3GpiDDPdBSrRC/OXwFQCT
	ux+hKnQfSmjovsvuV4WeXuM5p0T6ycS4sHEDpoDW6t3ItjbWtZzfLxso2CVbm9GtQD4iaEOXjHT
	D4GHfCuOK2TYWPLCiWrfn95GM7zs=
X-Google-Smtp-Source: AGHT+IHenaWNwj++zV+BlTtWIlszUQpntafm4MVPeTWVuJJ/Vu9U867l//YwaSixNGEj5jBFTtAqlGDElEH56WeC6/4=
X-Received: by 2002:a05:6000:20c9:b0:381:f158:c6f with SMTP id
 ffacd0b85a97d-38225a0e207mr376118f8f.26.1731630456270; Thu, 14 Nov 2024
 16:27:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107175040.1659341-1-eddyz87@gmail.com> <20241107175040.1659341-2-eddyz87@gmail.com>
 <0f0cf220fa711f0bd376bdb167c035e53dd409f9.camel@gmail.com>
 <CAEf4BzYUMMOdfwsWovDqQMgDnd8eGQVEyJLVRvqzmSwsZoW-wA@mail.gmail.com> <d34cbd7bf86d01ecccd70220078a7279756c8ec6.camel@gmail.com>
In-Reply-To: <d34cbd7bf86d01ecccd70220078a7279756c8ec6.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 14 Nov 2024 16:27:25 -0800
Message-ID: <CAADnVQJoRiZXRgzJt6pMFKqsCh93caARjA0hGQ_-V-B0VZ-+-w@mail.gmail.com>
Subject: Re: [RFC bpf-next 01/11] bpf: use branch predictions in opt_hard_wire_dead_code_branches()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kernel Team <kernel-team@fb.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 4:20=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2024-11-14 at 16:17 -0800, Andrii Nakryiko wrote:
>
> [...]
>
> > This true/false logic seems generally useful not just for this use
> > case, is there anything wrong with landing it? Seems pretty
> > straightforward. I'd split it from the kfunc inlining and land
> > independently.
>
> I don't see anything wrong with it, but Alexei didn't like it.
> Agree with your comment about organizing flags as bit-fields.

Well, I asked whether it makes a difference.
And looks like your numbers show that this optimization adds 101m to 116m ?

If so, it's worth doing. I still don't like two bool flags though.


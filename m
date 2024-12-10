Return-Path: <bpf+bounces-46540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 527979EB95C
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 19:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8D851889FD8
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 18:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06988199951;
	Tue, 10 Dec 2024 18:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kH6vdRb5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF91154C15
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 18:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733855494; cv=none; b=lthQO3MrTYe/wRrMtezyvdNIyidIuh89LpCdm5OBKA9zuovUk9XjfHwaszWBKFrM3mYrVUCPeifVxe0b9U3XQxWWc0Lfeoar6M7DD+8i5NElqg0HGXVHW3NDrChNoFFcsD5stpb0bDaPlbD0WlwwDvfiynpGVBnDYyjPQG9/+R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733855494; c=relaxed/simple;
	bh=NwfjN95Ff38ph1QtUv1a8UusUaXWvBEZgekO2cZvcdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WLpKILXGCd6slW4L7iA4yOohHtIUgjzBnD9DEUTQYC6ROBdqeiWWt8qWH8YC94CryHNe14Ksut/pmAitKvz93ppertictvKG6QEYnw/A5cI8XqrFVPYoroqahAbP0jWIcdl6SYT62oco2eveza829d9yrehXeNjLL+IeibDZWGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kH6vdRb5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434a742481aso52695125e9.3
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 10:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733855491; x=1734460291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwfjN95Ff38ph1QtUv1a8UusUaXWvBEZgekO2cZvcdw=;
        b=kH6vdRb5akXq9ZJ4zGWI8ZzMFKDgrif62QPyg1ve+Fc69E1RUHYq6UQX9TcqyhRdI+
         SR76Huu8YMH4LIbnwGTANSHuYK7Tk7fykMMGxyg/YJrZaSI6xxPfHHWvFDNjoIz8DjvB
         hxTM0Y0YUXmEQxWoeJo0OznFO6+xSvu2QNIrxwbn9uZH6YDQvG6mxwAjD2la7cZyM9s2
         2RLayk3UP7l089j5B1PoLllp5ASvgTdKaCiphMn/yW65tlaeIyy3k8QC413wj/qwpi5s
         5Vky1WqdnGPfJnAGPwn/nwckJLBaXJ5iE1r7TrRqHiEOhs8VIUzSzbUqOdE5Fpq0GxsY
         8elQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733855491; x=1734460291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwfjN95Ff38ph1QtUv1a8UusUaXWvBEZgekO2cZvcdw=;
        b=EuVswoVQf9BtxexbFSAgS0+N2/BsAbkaiMlplGVrGPYOkXXoBYbamrAsFd0aCC2og5
         I0ksFm744tgt36mR8vlKmoZFTA3AwL0JRTadTtt+g7vgSIqtazcrJHerfnPcFs87hgMJ
         vXg7sBRrGryQR+SsVqkvV/NfmDj9zYN8Yo3LL5JJo4p8H5wcKJmNpqGe6NsVeRfBpJj4
         bTSkBM+0vMq1M8EkWOoFEElD8yoQ9BUTYU12J7wzT5M0PM6/a+WrApSDGsFcc464zEhp
         HhyfLDtdTDw1fajbBZAB8DeBNCV/4Cu6yGDrOQR/LXPcqsgBc83YMofZ9WXq6b/dI8oS
         P+eg==
X-Forwarded-Encrypted: i=1; AJvYcCUXJ9+UGF2M8wwZLy5yyfBNeyWgBvO+4N2Ti+PYhAWVWwGa0UqniuwkhA8HTNklJ7/67eU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN7rZqCxbylRo868alS9En8WNhpR98cT8ct+Psa4dvccln+cLV
	pwF/8oQR9jux3pTcV3JmGbw19hj9pW6Y3D3odAbeqeHe/C7kfEenhaIWPvvPkh0jxbFbE53Q0qM
	wUzMsaGVO9oO/GGWSUMRrxNtth2Y=
X-Gm-Gg: ASbGncsTgQI20HcQsFOEGYuQhz9tFOl/9qtkjfqoPdldDN065pNI72FJ1SA8o1PaiuD
	cnnMhwLMWtHtFUeQvz4KUp7eLkHgqs84haMfsBh5DBN3rQWo1Wmg=
X-Google-Smtp-Source: AGHT+IGMMGcZVy+TJowMp0s8ZiAi2sd/Rjx0IHZNrgZoh6mSZBVrXes3mfzJjZmfGrCKPloYRHP15oXIx2+0zHOH9bg=
X-Received: by 2002:a05:600c:1e0c:b0:434:f3a1:b210 with SMTP id
 5b1f17b1804b1-434f3a1b4f1mr74373015e9.32.1733855490632; Tue, 10 Dec 2024
 10:31:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210041100.1898468-1-eddyz87@gmail.com> <20241210041100.1898468-8-eddyz87@gmail.com>
 <EC7AA65F-13D1-4CA2-A575-44DA02332A4E@gmail.com> <CAADnVQKBmQrvnEYqqSpUL6xjmccBW9vnyzQKDktd3uvZUyY83A@mail.gmail.com>
 <82110da58b8ee834798791039155074a9aaba7a0.camel@gmail.com>
In-Reply-To: <82110da58b8ee834798791039155074a9aaba7a0.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 10 Dec 2024 10:31:19 -0800
Message-ID: <CAADnVQ+hsXZirUYJ6Dshn+K6XNJB7LC=cS5ZzHXiMQbot+SJ3w@mail.gmail.com>
Subject: Re: [PATCH bpf v2 7/8] bpf: consider that tail calls invalidate
 packet pointers
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Nick Zavaritsky <mejedi@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kernel Team <kernel-team@fb.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 10:29=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Tue, 2024-12-10 at 10:23 -0800, Alexei Starovoitov wrote:
> > On Tue, Dec 10, 2024 at 2:35=E2=80=AFAM Nick Zavaritsky <mejedi@gmail.c=
om> wrote:
> > >
> > >
> > > > Tail-called programs could execute any of the helpers that invalida=
te
> > > > packet pointers. Hence, conservatively assume that each tail call
> > > > invalidates packet pointers.
> > >
> > > Tail calls look like a clear limitation of "auto-infer packet
> > > invalidation effect" approach. Correct solution requires propagating
> > > effects in the dynamic callee-caller graph, unlikely to ever happen.
> > >
> > > I'm curious if assuming that every call to a global sub program
> > > invalidates packet pointers might be an option. Does it break too man=
y
> > > programs in the wild?
> >
> > It might. Assuming every global prog changes pkt data is too risky,
> > also it would diverge global vs static verification even further,
> > which is a bad user experience.
>
> I assume that freplace and tail calls are used much less often than
> global calls. If so, I think that some degree of inference, even with
> limitations, would be convenient more often than not.
>
> > > From an end-user perspective, the presented solution makes debugging
> > > verifier errors harder. An error message doesn't tell which call
> > > invalidated pointers. Whether verifier considers a particular sub
> > > program as pointer-invalidating is not revealed. I foresee exciting
> > > debugging sessions.
> >
> > There is such a risk.
>
> I can do a v4 and add a line in the log each time the packet pointers
> are invalidated. Such lines would be presented in verification failure
> logs. (Can also print every register/stack slot where packet pointer
> is invalidated, but this may be too verbose).

This is something to consider for bpf-next.
For bpf we need a minimal fix. So I applied as-is.


Return-Path: <bpf+bounces-20413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3E283DFF4
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 18:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FABAB213F4
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 17:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4CA1EB57;
	Fri, 26 Jan 2024 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caxHhe+S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16D91D6A6
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 17:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289892; cv=none; b=nh5L0wbr4BAo4XX+dGillx1Y6BwgdBTfWigdSUexTl/r+bYWKs1ymcQpjovA4rGvvvIlIsR2cFWfHGX4SUu5wg5AgL4NS1Q/hHy3LXwBXGsMz85mTursGcSl/DgMfvbGZ3gLcQ8r3emIJsY6jUq9V7cy5Ry5zKSRgphbaoPPz/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289892; c=relaxed/simple;
	bh=qfWsSJXWz0OtOxjaaNh+xtkBvH2o2QO5rQtSozW8wmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pvmKrZH/02i+2W1CnYuvzUwTMiosDOKPD+fzq9QDEvZwA5GR2TcCiyFmHAKkNPrmrRiHrp+TRotutdz8V98Cn2b6VMltiqL73kf8mH808WvJkSxnr7I+B9RoGA3LKaQ331/ktl7TQI0VEeD+I8U/eO7ukd+YrdSL0AZBHACwfS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caxHhe+S; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-290da27f597so403746a91.2
        for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 09:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706289890; x=1706894690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4WDXCVIK/w/QlHaGnp8hubBwtc97mYt6nbkhWYrKMY=;
        b=caxHhe+SyYWbYAtPP6+a4wXux/OXViD9kOQAHZtPF8VPRD4QP1eArroFQaBnIZbc8q
         zpBCE6zxv8SLeas6ZXOyaYVYtmMCjVXMQYgf6YQh9CHgc4RlwijOdw+RN35OFhre6CJx
         MmBQvHg42yunjzEDlgtWzpFhxdi1OZLO36tGfMeaZjsCAUCPpgCEaBd80ZkiSVA2a8IY
         eg1ZhEpoBGsaNkmi4C/9zIgcZNQcCAhG1YZ5KSe0rLvagqRHq6pjGlVrStBDn9tyTJMs
         g9Wu+CbXzeAnUuQi0ep2w7SlynVdaEFvuz/RIM3+zGOy9ndgc8ZgtB4Kzl5xItCrY7MJ
         mskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706289890; x=1706894690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4WDXCVIK/w/QlHaGnp8hubBwtc97mYt6nbkhWYrKMY=;
        b=XowbGT0bPHGrANxm5YZz8yVV5PdwSde3MRCruTujPA3eNhFR9gPz6BcHwBIZ8tjowx
         2/n5UugM8xvFMCxK74SsTGjh86plAVlyQhYDfs1mRANojVRROhOn0nca5i7tFI7hoYV0
         /2JVhU9q+pb5lG3zkY1aEHOVRf2XzYO3qzej+GVR8j3JMZ9O8OgCs8cOKuM31ZnIzjYu
         PIcgB66ifPpcVC5vrB5B7o2/UwYpoUo+0+38OcbNtwL7zacwj82nG6tkz27vEV6iMK+3
         HWjxJUI6ZpLoNZoDUpDT1efVjmMdlb4rzHErZVU4g0E3N6gLDDeecK8VJrkt4A60fRf8
         2qzA==
X-Gm-Message-State: AOJu0Yxa0xF/MR2dcXDzFKpIZl7XMo8nSqFbS3e/6MSPZaDuyOYyWWZF
	aGaM7FaWJvlRzJV541fpkc7SyLEhLNGfNIMmJp9IRmnAAJsJrBYyWegESGFN0KQw5Qe6UmvTky/
	haCC+J6KNI9eSnLXGnBAQu2etEhM=
X-Google-Smtp-Source: AGHT+IHoG5JWXwWnYsASrEQY41wvAttmErrjtl1jebfG+/h34CGNZA7EXHDjFRkHHY3YGt4WJd+/zPUR1TOXWO8IQo0=
X-Received: by 2002:a17:90a:1fcc:b0:290:1464:e994 with SMTP id
 z12-20020a17090a1fcc00b002901464e994mr172571pjz.46.1706289889282; Fri, 26 Jan
 2024 09:24:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126032554.9697-1-eddyz87@gmail.com> <CAADnVQKxOeXAQDjtwNJuSPXnXqFZzx6vaEfdM_u317X-V3n08A@mail.gmail.com>
In-Reply-To: <CAADnVQKxOeXAQDjtwNJuSPXnXqFZzx6vaEfdM_u317X-V3n08A@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Jan 2024 09:24:37 -0800
Message-ID: <CAEf4BzZWtJvNyrjoaFFVoDRTQ-srG6pr1nyZJWuowdT9rqVzsw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: One more maintainer for libbpf and BPF selftests
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Kernel Team <kernel-team@fb.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 8:03=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jan 25, 2024 at 7:26=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >
> > I've been working on BPF verifier, BPF selftests and, to some extent,
> > libbpf, for some time. As suggested by Andrii and Alexei,
> > I humbly ask to add me to maintainers list:
> > - As reviewer   for BPF [GENERAL]
> > - As maintainer for BPF [LIBRARY]
> > - As maintainer for BPF [SELFTESTS]
> >
> > This patch adds dedicated entries to MAINTAINERS.
> >
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
>
> Yes! Welcome to the club. Well deserved.

Yep, long overdue, welcome!


Return-Path: <bpf+bounces-43832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7994E9BA59A
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 14:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 277AA1F218AC
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 13:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0253D175D37;
	Sun,  3 Nov 2024 13:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1W0Ul1j"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711461E52D;
	Sun,  3 Nov 2024 13:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730640192; cv=none; b=mlFUWL6iQ5kcGARCq46UnrozcM3oPfz9dIUiFXVQyMgUcA89fL64qTSIQsLo6/PTUS0atXxEcn8mguMw7DTFelBel1rJj6bxxR/psThcjl5hfKszq2LC2nCAwGpa0bF00YhTx0SNVMNlKvyXNyM3QihhV9eaDGYOLWRDEBCz1l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730640192; c=relaxed/simple;
	bh=owxpUIA5JjJe1/GJIuWE5eHKEp3bhFDZLK8QfdI5UR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZArqvdk7RFJUHtagZkgAlkK7Nvwe2TtoXYDlUhIaxZaa1y7V625/scuIHDc7OGMjvmjAelDmD9X6GCdwFegHJVaALg8HKp5NBrY8JYuMod8DzinSrq9S9+8ZBIXTmQphDgwvJ7GQn0j8cv1wtmEn18nG/GAahRO5cshC+h4hP78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1W0Ul1j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D853EC4CED5;
	Sun,  3 Nov 2024 13:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730640191;
	bh=owxpUIA5JjJe1/GJIuWE5eHKEp3bhFDZLK8QfdI5UR4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=C1W0Ul1j171/CeC+sLp5WXwg3QJVkHfN7o8RA57ZdsEQLczGNhKRl1rdNKQWHrxgv
	 DPxsUrYt5M/mFMdaei68/33Dxpt/oalXNyo/8MTBKKqn02iiTZBc2aVKTzphM+I+5q
	 rDYl1N6iOlvONqCyOKbQg71PL7qM+jRDMLRhAlXoF7k9oVkHX9yfipZdam35qoUrW5
	 O/OyptcdPyX3sf/wFpp66teG2QhsfnEhTtLsuRuSUBv9kLYFo7gMiiMgIul3PlYbnd
	 Ckxa/Ou9w4qW7Yq2Y9f69TMwn9yCqT1BGtmcoa7stWa4n0KLSnfOpCv9ZgJc+a8pyD
	 KDl82IYumz/Zg==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53b34ed38easo3232848e87.0;
        Sun, 03 Nov 2024 05:23:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUMjJebpDfZBJHUFFiLmMPTf7tlw/y2PYb/yf0mqnoFaY1QBj1KfaafVYcdwtXG0oi/0rbg1vnLB9K4lt0D@vger.kernel.org, AJvYcCUQW7/CgQUgB+NpRQUAm639l2ZJcwceKeWrifKCI0p41sQ6RHJu6jF6xMvVBbgeh4XejmHXCPZ6HtVZlx97@vger.kernel.org, AJvYcCWNLl2yoXoMwLOVcAYyGcOINEYBTQQrH2DNbwWNQr65X70ZYHCGmbq1gn+xY+Ks3zsdIY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeITdgRunQg2tGPjTZxNNCEJ0SrddTTDeHW3qy2hRSczU/UuJC
	44leZH66PNVX+Gf1Uf2L9jfDQECgNeZXAiPHvg55sF6n0PVJ/5T3IeWxf0lldVbkNM6GmQrcrXj
	VVMjTTnK/q9Y6dc7RNjJCLAPeCIc=
X-Google-Smtp-Source: AGHT+IEif4j0LPoeyuBjQdEErGyNPy2EQiFuXAV+M+x8WHwNgn5Jfb7rCZmzdfW+NcQOCRzaURku+bbfBLN2jdd1drg=
X-Received: by 2002:a05:6512:2311:b0:539:edbe:ac86 with SMTP id
 2adb3069b0e04-53b348b7e1dmr14809315e87.10.1730640190560; Sun, 03 Nov 2024
 05:23:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241102100452.793970-1-flo@geekplace.eu> <73398de9-620c-9fb9-8414-d0f5c85ac53a@applied-asynchrony.com>
In-Reply-To: <73398de9-620c-9fb9-8414-d0f5c85ac53a@applied-asynchrony.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 3 Nov 2024 22:22:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNATd0UNu8KsxeD-q2mDUTxQD3ATL1wF59B9K2pxzU08OQQ@mail.gmail.com>
Message-ID: <CAK7LNATd0UNu8KsxeD-q2mDUTxQD3ATL1wF59B9K2pxzU08OQQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild,bpf: pass make jobs' value to pahole
To: =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
Cc: Florian Schmaus <flo@geekplace.eu>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 3, 2024 at 9:04=E2=80=AFPM Holger Hoffst=C3=A4tte
<holger@applied-asynchrony.com> wrote:
>
> On 2024-11-02 11:04, Florian Schmaus wrote:
> > Pass the value of make's -j/--jobs argument to pahole, to avoid out of
> > memory errors and make pahole respect the "jobs" value of make.
> >
> > On systems with little memory but many cores, invoking pahole using -j
> > without argument potentially creates too many pahole instances,
> > causing an out-of-memory situation. Instead, we should pass make's
> > "jobs" value as an argument to pahole's -j, which is likely configured
> > to be (much) lower than the actual core count on such systems.
> >
> > If make was invoked without -j, either via cmdline or MAKEFLAGS, then
> > JOBS will be simply empty, resulting in the existing behavior, as
> > expected.
> >
> > Signed-off-by: Florian Schmaus <flo@geekplace.eu>
>
> As discussed on IRC:

Do not do this. Others do not see what was discussed.




I guess the right thing to do is to join the jobserver.

https://www.gnu.org/software/make/manual/html_node/POSIX-Jobserver.html




--=20
Best Regards
Masahiro Yamada


Return-Path: <bpf+bounces-19953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4313483319E
	for <lists+bpf@lfdr.de>; Sat, 20 Jan 2024 00:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC4D41F248D4
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 23:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBE95915C;
	Fri, 19 Jan 2024 23:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxbXg+lf"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78385914A
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 23:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705707618; cv=none; b=tBB12weUbDmG6Syeuwf8NHHM77HxDsmhMSAyb09/qtSyS0KL2BbXv989J5KDxrTppHhI7U2LKQndAbgkmc1Oad3rc7OaSZFMKEylp/rzQKkCyp7BGU7e1WgtJcbCwGcj2zNzlCyR0VugnJchcqKzdN+yg1cX2GLzgzdu+vTvTf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705707618; c=relaxed/simple;
	bh=kbwIC9RprFYmmya7PY6hZ5jOtWruDraroEWeTIwkw0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=of7iLQoBaF0Lt+MrZHfNETmwFAJn/YiHAg37QlkZ1lY+np6QIvnPZRSUVfzOlz26yh8doPpuyk/6OD+bgAH+x6VoSiAQP8rJXNOQ6L6sKdzT2DEefc2v9vcroKNwRFVa/bEs+UC4nszvDtsUoHV3KUB3jyI7IQeIJmhSt88UxHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxbXg+lf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E17BC433F1
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 23:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705707618;
	bh=kbwIC9RprFYmmya7PY6hZ5jOtWruDraroEWeTIwkw0M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rxbXg+lfvlyysqt7xhOnXTz7/icn3kE+MGS0xG8vdRQfYhouTWOO/JGAcC+Vt48/j
	 bw0L4U839M4+V/KKMCKPH4gaZ1XG9zoNmbqVwmTYmzYo1wUZcpChmJuw7oiTLSP5/J
	 c27SAbkiGFkcaIKW1qG1n73W9PfOot3KwRv29tb0rn3XEly3QXKzad8NCxOqQ8jK7c
	 D9oGyka5ThO0mGAVOYOOC1ENBsaztrfagds8eswB30X/ODXiUtIsQw37jnGp2v6+tn
	 ri0veC0B1o5g6Lusm2ypn6AlFKjJXhHVop4BL9nLF9m5l22DeE7jbgZ1mJUDHVEcSy
	 WIdaKT+bwJxzg==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e80d14404so2065205e87.1
        for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 15:40:18 -0800 (PST)
X-Gm-Message-State: AOJu0YzZUIlHtCYVKZB42Rl1O1FdTmzhXIaT6QeQQKOt8cZaowxyZW9X
	XUNp1p3blBWDZ7TlO6Pjg7y2ImslzxQ3/5E5A5lbGrbUOZbQCj2cPibOpk0Do8WzDD4l04nrxbf
	Pjty/T0Ynfm134TJzchhSeJGH29Q=
X-Google-Smtp-Source: AGHT+IF6d4OYPrKnIuxQ8GKj1Om6xMT+WDD4dAYeaPCH2SjGndZnXeXQaI4ksVg6QgMM4QDH8eqUZv6bAkXbjdAxbD4=
X-Received: by 2002:a19:8c0e:0:b0:50f:1758:33dc with SMTP id
 o14-20020a198c0e000000b0050f175833dcmr250432lfd.21.1705707616407; Fri, 19 Jan
 2024 15:40:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119110505.400573-1-jolsa@kernel.org> <20240119110505.400573-6-jolsa@kernel.org>
In-Reply-To: <20240119110505.400573-6-jolsa@kernel.org>
From: Song Liu <song@kernel.org>
Date: Fri, 19 Jan 2024 15:40:04 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6d4HjQQH=neJeaJ0hdkoyq22h7UyvJHdSVBMtgQB4ZUg@mail.gmail.com>
Message-ID: <CAPhsuW6d4HjQQH=neJeaJ0hdkoyq22h7UyvJHdSVBMtgQB4ZUg@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 5/8] selftests/bpf: Add cookies check for
 perf_event fill_link_info test
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 3:06=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Now that we get cookies for perf_event probes, adding tests
> for cookie for kprobe/uprobe/tracepoint.
>
> The perf_event test needs to be added completely and is coming
> in following change.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Song Liu <song@kernel.org>


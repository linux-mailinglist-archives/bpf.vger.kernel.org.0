Return-Path: <bpf+bounces-59773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E2FACF497
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 18:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 434EE1727A1
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 16:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F315274FFE;
	Thu,  5 Jun 2025 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8sKKZYL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4C0275104;
	Thu,  5 Jun 2025 16:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749141916; cv=none; b=FBZxoVpL69dQPLy9DNXECFuN9jHWAhRxByPaD9oI8wj8ciHdqn6/WQXYrqDZyKKpEsMk33WYWb5FlVmMdfE6PYsqzzHiVH3nrqXg9bmZAIZOtWTi0kMMhMSQcU44cDclGouVRaeY38EIqa2M3MufuMAPA+wy7Ck4y1XBn2+8IhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749141916; c=relaxed/simple;
	bh=cs8nNqGOkKc5KF23qeBZqXkXm52UOfOdL548bZl+cO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UibGnttxCU/58PxMv7z8FZV4tO3bprZW4p/eVIgAQMFUacVTS3vKTk6wXL5gGctQOjtexl3sAc2db1wLapKOHAHkd5m5IiHI1mRRkuazeV41NFmQAO/4cZriZTFAP/axepwO2+5oMBQaupgS+jESQKOIurlljHhpRgE5p7ufRAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8sKKZYL; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-742c73f82dfso1039058b3a.2;
        Thu, 05 Jun 2025 09:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749141914; x=1749746714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DyO4YVzZiyix7rWKMrwQ+DqCwWD3Pg0BrvPcZe0H1+E=;
        b=b8sKKZYLVHplIWYk3oPeUfMYoDfV4C+2vgjaL7GoqHSKkf2pAoYWte8ns+mPuJLuvL
         +WueNt30ugY0fgb56sOiiwiqirnisbijWqPzw1EqCubP/GtIvi/TTMbmdlzQtVa58DCj
         uMTIJg5ox+cOrwFszSpOPerpfPJH+XSDeshHuAaQkzTlsvtPu3oXp7DjGeFfo/p7Pvgl
         6Oh3mbrnS5cA9gXxC2OUIj+U2XQnuNOnGYoM9DC1VYyiAnYaRN77QGP6KUr9DLLs6pjw
         7wi9BkmoTdKqwDQAerJS6W+OjUUBQgnTXoOi2rslDWldLMLbbSnOs1Q6yyFvh6qBv3dN
         3hHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749141914; x=1749746714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DyO4YVzZiyix7rWKMrwQ+DqCwWD3Pg0BrvPcZe0H1+E=;
        b=fZlXQE5ihANcU6CNo6Pkgoe+Ah6BF/cIbCEWEZ6qiK/fS0lHV8NunNL1bP5fljSKDS
         rSvyD9NpR42GG4eZweM96flXnMCYRX8LUvEHyyfbzmtJx6+TOQB2/9O+iKEmMXJwtnmI
         2FO5ZR9+gyRHD34Qe8COwZsHUkFrfIo+xu2mBAy3sMU4QC3kVVfr62KPTSzbZTHk/Kz3
         /UCNtJdO4xud5iGltc6Bu3sV73eaSu0SgwA8fexBtdf2GYRhpcfYQ3Yb/ggFe5pWgBCf
         jXE/2w3fuoKIMSVOxg5aX6F8vqhRw/D+x+jIUfX097pu9iIYtmYvAVp1Bl1WRhgtP3OC
         Ab9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW8A7F6mjrrGKVz2WRZ4CDYyWGBL9h1vVPHDwakNC8Z6aL0GYdTZxEgC5eWwzL0uTh8E0Mxz60+Sb0ItL/p@vger.kernel.org, AJvYcCWF1dBx+o/IwPQpv6mCTY3QyInNWmjbNfGX2Hk16DTXDE/LhhnMpZSfX9J8N389uoTLaO8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx488M1axGL7f/GRaNnGwXQ96bqnA6ydRDwx/QR4MXBoReNXzpR
	qGV0znVqOVt1RIsDjYrPc7JF46UqLDvsGvlAUK8c7qRx8ZAuAIwZQcyyjTOPBk0S4pTTQgzRy3V
	CMpyxaVvcj6mzVZZMVDR5itC9rr5QmUc=
X-Gm-Gg: ASbGnctVVp60XBSJxavBUPYoqH2C0Moj/5pCIClE129wuWnSkrHmkjFt2o+/a03wcXi
	yumLpfoYAakPMrQTEJvhHq1p/ZLhi81XCji3ZtdpLZNJkR23ev7LILYxk+tjn+968M5/sen3wlY
	EDqQB1GGU3SOB5A0YWNTUDgLevZAj+omF0WKKz0zmHkd3IJNgQhiK9PKluU4Q=
X-Google-Smtp-Source: AGHT+IE/1VOoP54w6CaInhP2vzYrEnD4HL34I8uxrT2isFJIssTg1Ot945fGRXjG3udeQJlUYtlD79YZR7l2ZHU39bg=
X-Received: by 2002:a05:6a00:848:b0:736:5f75:4a3b with SMTP id
 d2e1a72fcca58-74827e74aacmr544501b3a.7.1749141914320; Thu, 05 Jun 2025
 09:45:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1749109589.git.rongtao@cestc.cn> <tencent_FB1D31D70047E82DCBF3D257C5ED75653405@qq.com>
In-Reply-To: <tencent_FB1D31D70047E82DCBF3D257C5ED75653405@qq.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Jun 2025 09:45:02 -0700
X-Gm-Features: AX0GCFupxfjhPfFVvRvgR3lTmoPOnzGriosV9oUZh0r5bW4BEyla0rDE79EPUq4
Message-ID: <CAEf4BzYkyt-sXrxJFSHrJX_NS0nBK=NbfkTt71VLKsnXA7A56A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpftool: skel: Introduce NAME__open_and_load_opts()
To: Rong Tao <rtoax@foxmail.com>
Cc: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, 
	"open list:BPF [TOOLING] (bpftool)" <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, rongtao@cestc.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 5, 2025 at 12:57=E2=80=AFAM Rong Tao <rtoax@foxmail.com> wrote:
>
> From: Rong Tao <rongtao@cestc.cn>
>
> Introduce functions that support opts input parameters, Obviously, it is
> more convenient to use. for example, skel with name=3Dtc will include the

No, I don't see the need to add one extra variant just to add a bit
more convenience. If you need opts at open, then just do open_opts,
followed by load.

If we take this convenience to its logical conclusion, we'd need to
add open_and_load_and_attach() and open_and_load_and_attach_opts().
And yes, that would save a few lines of code here and there, but I
don't think we should do it.

pw-bot: cr

> following functions:
>
>     static inline struct tc_bpf *
>     tc_bpf__open_and_load_opts(const struct bpf_object_open_opts *opts)
>
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  tools/bpf/bpftool/gen.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>

[...]


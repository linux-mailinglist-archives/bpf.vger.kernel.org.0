Return-Path: <bpf+bounces-74089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B7EC47B81
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 16:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1BEAB4EFBE7
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 15:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E339726FD86;
	Mon, 10 Nov 2025 15:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5JUpHFn"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FB2224AE8
	for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 15:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789771; cv=none; b=n1p/WrVE9UftugbN5n5Mpc+UMxok0D1t9LLC6VJeWh+xgvMXyFYOVncy9+WWEzQN95Abq/XRWz5o3ierETFguXa1/wQEqEDxioZH24v+MQkpoUCLuymM/3eObrBj+9iNlummjN6VakcOObGH2HXx8LzFWlL39WgtjeYbx3gzA+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789771; c=relaxed/simple;
	bh=hGdO1gmyGy3Mjf/B3EyUkRcvknyUCE7lR5zjrkG/6Os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7NApDPkflUq7ERoynLs6NoZOSHh7lSLtAxrImvKZa7uif/LkNvHbvcaHbh6K6zloSPtEeLLJhU+RvLGKdpZqyHfT73EMh9rowaYrVASoRp10sOQEQXBLV/inMWeDWhdo+5KNiisJIUKNRdvC78gkLF4DoX4qvcw9Ds/irDArB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5JUpHFn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F216DC16AAE
	for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 15:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762789771;
	bh=hGdO1gmyGy3Mjf/B3EyUkRcvknyUCE7lR5zjrkG/6Os=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n5JUpHFnwn4HUIetGF+2nQui8NhsmjNy88d2eXYQoa7/zpdR/nyVLQcek968/b1po
	 VWCjvBF64431pWiiDwAlZH3lswaqmHdo79hqJPoNNkKgjr9VWemG2AtyUExOnnJwHh
	 5fsH5UFowdx9vt0ozNxpCDFJFCU1nIjl1bPfKONOH4kzM3ZaQBxNN29HwwR7aFR9aK
	 ZpSSyKg1XG21TiXYvIrUiO14c4ab180APV4s72aMTp8npQ0hyfnZ3IMJefFQ2frO2u
	 IRoKcO6US7vMSIJRhhfxT/YuIjmUhwjLw0JbnFsVczlnJqKh3Di8Gx/xa3wthoSiyX
	 dEIhywG04KFHg==
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7868b7b90b8so29679207b3.1
        for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 07:49:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXdUdhIaavhj/xr8liMxbw2r1sYQSr/Va3YPI/kFH7vGpP460hBDx5qYmBRyz0lxaYvCsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGDiTxRvPdt1TgxUxrGn94VFMT4GYd4aJYQsw5fge+fnwC6UAW
	EXlR6zSuUXy7BjBw1SBLAD9NT9S42NK6WKoRWKZLouCS6SXG1dpRNebs/JWHx0NpoCR2VoL1+yZ
	bcCchoEnYIHN6LT8dQ358Y7b80HdPJLg=
X-Google-Smtp-Source: AGHT+IFm7yZ3qguylHdoB7xjNQBy0bMKMjR02J1cRGt4ffC2O34eT91/wd8Mmx9ibXalI8LutBCMwAfMcAT7RBiagB4=
X-Received: by 2002:a05:690c:4681:b0:786:70d6:96bf with SMTP id
 00721157ae682-787d5435332mr92636977b3.32.1762789770167; Mon, 10 Nov 2025
 07:49:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110120705.1553694-1-dongml2@chinatelecom.cn>
In-Reply-To: <20251110120705.1553694-1-dongml2@chinatelecom.cn>
From: Song Liu <song@kernel.org>
Date: Mon, 10 Nov 2025 07:49:18 -0800
X-Gmail-Original-Message-ID: <CAHzjS_vj26p7SwVupAb0XyTZs__NProJ+CN6DKy+-E1R+Wk33Q@mail.gmail.com>
X-Gm-Features: AWmQ_bm1hQ3TeUIh6zBIsI2NAfUjz2s_DU0yIZ9d33dDtimQL_En8Q7O5Ah2cVo
Message-ID: <CAHzjS_vj26p7SwVupAb0XyTZs__NProJ+CN6DKy+-E1R+Wk33Q@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: handle the return of ftrace_set_filter_ip in register_fentry
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, song@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, yonghong.song@linux.dev, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, jiang.biao@linux.dev, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 4:07=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> The error that returned by ftrace_set_filter_ip() in register_fentry() is
> not handled properly. Just fix it.
>
> Fixes: 00963a2e75a8 ("bpf: Support bpf_trampoline on functions with IPMOD=
IFY (e.g. livepatch)")
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  kernel/bpf/trampoline.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

LGTM. Thanks for the fix!

Acked-by: Song Liu <song@kernel.org>

Can we add a test for this code path?

Song


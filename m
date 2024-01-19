Return-Path: <bpf+bounces-19955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF128331A9
	for <lists+bpf@lfdr.de>; Sat, 20 Jan 2024 00:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C81F1F24B30
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 23:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F79759165;
	Fri, 19 Jan 2024 23:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CC4Ark7+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867AA51C4B
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 23:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705707843; cv=none; b=A7jjx4ab8l8/OLwGmXR7+W6dHiuKzNXOYZfHCEAYArlWQzZ5GD3vsRDQiwSew5zjgPQ/r1dgvQpoKrH3007Mfl8jxQl2nm/xd9LCZGeJzyQC0G/8Pc8yF2n5Ar1kxPs8nTxICnMtXnRDJ16R6tMDh1WR73lpGBow8mCpwunhQwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705707843; c=relaxed/simple;
	bh=NJXhNjRGEXdTz/w+d2cRL9qaX/Z5cYqM8WTWMtJ0hrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fbVE188TnmVrvnMRozuUAHKREE9wH3eb87tEiACWDDh3YW8v+dOYaY3cW5rU/lWDJE15JqDZYKm+vdjB7a4reqvql6mTXi3FHhDkRrJDJb5iQnMvBM5BaaZemeLjnHYvUoz5XEv+hqGeEwPGxFcaacCtFJUfXAwYHyLNo0N8NJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CC4Ark7+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8338C43399
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 23:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705707842;
	bh=NJXhNjRGEXdTz/w+d2cRL9qaX/Z5cYqM8WTWMtJ0hrg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CC4Ark7+xgUkju2oCW/Xd4oLc7bjZudNDDREE+D9KsRR5byR79mEdyAOQAtRHY2iS
	 bYNFN0cJuwtWrRZF1lQa/8thBiDfNGIbK+mKWKv5VPUmHtyJaLtwSY0OvlMfzB8/5n
	 /d4paBXKsb1bVkSv+b2aWOvLDMTzXxINCftcrusZXJibIxdPEMRBrFrAkzPyhWtSzu
	 LgXHmQgVNUwr//w2pfigLpPdFMAgRhIJoqFDp12wSJCjYoTpb5+6Wymxic3HKQJetU
	 vbyBG0j2e3EYY1pdjwoG2bRFIq6/R/CezW1hYwN6FGUrrIye/Bowpjg/lc4dYJXQXX
	 uYsnjAeNiwarA==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50ea8fbf261so1657290e87.2
        for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 15:44:02 -0800 (PST)
X-Gm-Message-State: AOJu0YxvWD4gbwJQqpi0Q8z64CRp+H5jkxozcoVlOeipH8NVw2u13x5H
	u02NbOKdCse9rRR8H6et5PjkWFw0TP2pWjFQv534QHfns6aMa2WYBC2uUoILt1fx7wHLtDY+cKk
	yB0Q9Hb2CaD2FATEdKgd3P2c7LWg=
X-Google-Smtp-Source: AGHT+IFqZvdrd7mRaY9sqlQoSSqA+Dpx151QFOj9xurRI3/2Rdhm4UJ2pfDuDObdrfp8uKpMSHKdhU1hH1g8OsnIbu8=
X-Received: by 2002:a19:2d19:0:b0:50e:cd10:1768 with SMTP id
 k25-20020a192d19000000b0050ecd101768mr196039lfj.109.1705707841185; Fri, 19
 Jan 2024 15:44:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119110505.400573-1-jolsa@kernel.org> <20240119110505.400573-8-jolsa@kernel.org>
In-Reply-To: <20240119110505.400573-8-jolsa@kernel.org>
From: Song Liu <song@kernel.org>
Date: Fri, 19 Jan 2024 15:43:49 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4+Kfw5-T-63N3wHvGodVBzZ-ETJ5PsiVwUk8cALkMorw@mail.gmail.com>
Message-ID: <CAPhsuW4+Kfw5-T-63N3wHvGodVBzZ-ETJ5PsiVwUk8cALkMorw@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 7/8] bpftool: Display cookie for perf event
 link probes
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Quentin Monnet <quentin@isovalent.com>, bpf@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 3:06=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
[...]
>
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Song Liu <song@kernel.org>


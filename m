Return-Path: <bpf+bounces-19954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D4A8331A8
	for <lists+bpf@lfdr.de>; Sat, 20 Jan 2024 00:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52C52B23D25
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 23:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6835A0EA;
	Fri, 19 Jan 2024 23:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPHjoEQA"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E5959B7E
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 23:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705707742; cv=none; b=ezUYLGodjdHmtUEZvibFiUfsxEB/H3oFZhJkt5HECuj+ufa3pzkuOJSEEPP+PArEqczGbG2QSsdfV5ZCGGtD2oIXJ0jhRGBvPTsKNeHgC2xjFSkAiUyKcJD9HYy9fIHa1yyBtKR3tfoVO55rrBvzGltcyBNJrWrglxLbpzmJy8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705707742; c=relaxed/simple;
	bh=L288lNTVOy2AeaR48iql8B4c4gLC9Psl2OW/wNpbOGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=udrlm7cG4B3loCv61E/lSN9sarO9ySet7cDYa34wKUF/WvmYvDRauMaDvgNu+YOJEcZA7wY5vb10Lhf/NbcBMqo632rYDXMQVtsUYIrUAzGYmCcXtLcqRPrhNUcIMLkPRO8BzcoZHfr4rTvnPC7/ojBA2C8tia66BjwnPN4Aneg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPHjoEQA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DA6C433B2
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 23:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705707741;
	bh=L288lNTVOy2AeaR48iql8B4c4gLC9Psl2OW/wNpbOGE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bPHjoEQARPpiAz8C80WRQ0bLPLpiqrK24vpFLHZ9qSHO/UrGcUQpOe9uTFKlbCgRn
	 c36tqRUO5WL+BfSnSXDiFqzoZx4wuffB+ilbaI20PmRXybJCzC3L1i8L6TkCK28IDE
	 ua4ZZqXE5O/2cBW629mZRjKHDQCMbU/KScCYFKVtbDDdtl9uxMnlHXANDrkFk3YQvn
	 OjaDYIteHwAZ+xsvx3J+rKNaJcjGf0bmKa58yJURNseKABungWVkZH1g5K4OmkX+RS
	 avj5O+/1YKmUpFywbzz5aG7YxW+X72srv7yIGGjbWbADK/I3J1T2lZdVsRsPv3b5TG
	 cKpkpLMLJ+R8Q==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50eabbc3dccso1815397e87.2
        for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 15:42:21 -0800 (PST)
X-Gm-Message-State: AOJu0YySo6cmV6FumxvzK0i5TnX/zGYgPUEQVkR12i4tmFQ8IN1DAQim
	A1tJ0BXA18K2Psxd0pn5sgZSRsKahSyxqagzlR3QLQGlE/uZgvHR3k54fV64JaOkpS9B0sDP3TO
	4+bbgsMepSYUPZ24JosaWjYkQL70=
X-Google-Smtp-Source: AGHT+IGb7p2D41ojt5+LPeXy9JBYGrTxRa+qsnHrMEzeRE06wpa9nIm0pXyvPmLkCl/VSBXqVcdFg/W10CVWFTnoTq4=
X-Received: by 2002:a05:6512:6d4:b0:50e:7b46:307b with SMTP id
 u20-20020a05651206d400b0050e7b46307bmr105604lff.143.1705707739951; Fri, 19
 Jan 2024 15:42:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119110505.400573-1-jolsa@kernel.org> <20240119110505.400573-7-jolsa@kernel.org>
In-Reply-To: <20240119110505.400573-7-jolsa@kernel.org>
From: Song Liu <song@kernel.org>
Date: Fri, 19 Jan 2024 15:42:08 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6y=cy3_HYmpUVJFL+f3U2LC=ptNC8by0v+GYYFrK5XVg@mail.gmail.com>
Message-ID: <CAPhsuW6y=cy3_HYmpUVJFL+f3U2LC=ptNC8by0v+GYYFrK5XVg@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 6/8] selftests/bpf: Add fill_link_info test for
 perf event
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
> Adding fill_link_info test for perf event and testing we
> get its values back through the bpf_link_info interface.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Song Liu <song@kernel.org>


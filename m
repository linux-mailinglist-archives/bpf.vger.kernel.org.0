Return-Path: <bpf+bounces-19952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7809983319A
	for <lists+bpf@lfdr.de>; Sat, 20 Jan 2024 00:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28824283CCA
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 23:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D365917C;
	Fri, 19 Jan 2024 23:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t95EQjT+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1651A5916C
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 23:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705707430; cv=none; b=g+aV7fgl+ywvouwrtZ32sj/+TSWRzJa4BO72vyrvQBOVP5mfs+rWJ2LlqelesNQ7XdEVOYhRWOrIX9FggKQ9H7ieuTOh8whjKr+m0ajZc5nVefd8Qjss8gnJCB72AiDCMd5hereljUzXpWU1QfaGfamWUpld3mWtk1h0q81dYZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705707430; c=relaxed/simple;
	bh=7A1LAT+eVYdIOdxPMj0gElYjjUVTrSsETuVzmgALSKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=joL+HcF0Z+3dsIwI52/E5s0IQ/oHaPCtQj+TmKDFK1WjUj9iwcIJB65qQ1L97eHv4ggQbqCq5V/JGfegN/G2m/3ghY03IfsEhpLCWXnnDIwNSrXomWtMdqO3gno4jAxSx9Px1eFsdiH3jE/a3lXy7A+PcjoRv8905yMbblLK0mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t95EQjT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D904C433C7
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 23:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705707429;
	bh=7A1LAT+eVYdIOdxPMj0gElYjjUVTrSsETuVzmgALSKo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=t95EQjT+909frfD+IKkCaKGNqYwyTbAgKI5M7XlmJxo5hkLPyRNAy9RvQRtaOBzyg
	 BKrsjx81T+d2m0q32H3SwX5XCmxFAG+Fcy6839/AhY8OulTQDOIbHWNZR63UAnjtnj
	 im4t8nihABY01JbnrjE6zdxkmPjH6qz68eo70KRSQdtoUo81vgZByrOUv/mWkoa4dc
	 r70ozDvy9u7/QxniaVvG7wh5TwRdHxA1Ig9nlXUknJvEo3odUFzj2SmMy/k5EZiJcz
	 Ym9FQzSR7MgXwas1M72eV9SEca7RbHt0R65BXrg07Uiff3p7ePSpMM8bEWN+H0dlP+
	 HGur6XPJY7HVA==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2cdf69bb732so15316691fa.3
        for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 15:37:09 -0800 (PST)
X-Gm-Message-State: AOJu0YzofmtMafNJiaIwNSfSfuLj/qAlSsBuoOnkaF/E/NgE7MPxohNS
	yfyTrVUyBmwDRJ3kciE7NZNZ21Bp6MShPAQFAM2XML8P3RaRScygHppfb0V0U3b1uKJeQBtGxGp
	qIvVMN3W3cJKOSyeCCjG+9AWmQf8=
X-Google-Smtp-Source: AGHT+IFHJ32uoYC5aV7ZasUDcolfL3UX7GdbSSzaZVYVRwfEavZKnjFC7TSKzuZnlNAhxfyIS2qqN766kENtou7x2NE=
X-Received: by 2002:a2e:a275:0:b0:2cd:735a:2a7a with SMTP id
 k21-20020a2ea275000000b002cd735a2a7amr110094ljm.117.1705707427485; Fri, 19
 Jan 2024 15:37:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119110505.400573-1-jolsa@kernel.org> <20240119110505.400573-5-jolsa@kernel.org>
In-Reply-To: <20240119110505.400573-5-jolsa@kernel.org>
From: Song Liu <song@kernel.org>
Date: Fri, 19 Jan 2024 15:36:56 -0800
X-Gmail-Original-Message-ID: <CAPhsuW56LfPb6s-DpMDSGJLzTgn0FxUJmguP_nZoW8XRPgTu6g@mail.gmail.com>
Message-ID: <CAPhsuW56LfPb6s-DpMDSGJLzTgn0FxUJmguP_nZoW8XRPgTu6g@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 4/8] selftests/bpf: Add cookies check for
 kprobe_multi fill_link_info test
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
> Adding cookies check for kprobe_multi fill_link_info test,
> plus tests for invalid values related to cookies.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Song Liu <song@kernel.org>


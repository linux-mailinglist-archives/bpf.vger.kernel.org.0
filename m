Return-Path: <bpf+bounces-19936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 437AF833174
	for <lists+bpf@lfdr.de>; Sat, 20 Jan 2024 00:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F0DB1C235C5
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 23:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD59358AD6;
	Fri, 19 Jan 2024 23:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+bU1+fY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BAC5789B
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 23:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705706735; cv=none; b=LmarghH4wDe6vk2MgWbjb99tmbj8JJYa1eN3ced9ME25bF8ys6mBCZ4vLZOU9n613JNCubOy9d7/ye/NWZhdhoUObRLvPu4Jewn3/reFl3xIxfDoVqYYhsBY9NSiz9GihrSrP+8CaOOPmYUGHCKOwbqYoiE5lCVWz10Iw6jg4O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705706735; c=relaxed/simple;
	bh=O6DS758yv72ZBFWq4WdYvlJN/sbUbyPf1zHLiN1v54c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZf9g+rrYu8UODwxmn8jMRzCJPzeWRwQXetiaqPQ40S5DoQKSrzAsZWlvQ8RyCi8pPmFYybpXLxskavC4tdobCv7JSxEoQQid6i76c/DJBFwDIzVeAQrtXnkxe/no8n0p7eB0vUNPuUmGlxKP+XtsuNOTgip/K+mnn95kZKJi+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+bU1+fY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8827C43399
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 23:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705706734;
	bh=O6DS758yv72ZBFWq4WdYvlJN/sbUbyPf1zHLiN1v54c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J+bU1+fYFAyLB6w52Clc+QM+AZl15vWyNTi2JOqvKQCH2rPBQyCutsWY3bd3anzhP
	 E288UZQ3C4x77hrl3+YUvfmCcpgSGB64VT0ozd8ncZ77BzeP9CAvV3pnJb75x4rBop
	 4rXwT9CibJsaf1scZXHz0iTCQfUjYhSX/yxCKUOkPoeoAkJEPkBtyj2t++PQVKWx9g
	 zKWfZAt3zHasntk/RG3Xy//Hs/Cu0NxXnhFH/d7z1gBuCWxgBAxI+t6tDgr3CG1UUE
	 KTxnMzPqPaOQaxsWOtqp9lmhSsUkhZQyNvkA8SU/qLIPnBT97VrNk5acCujnU+8zm6
	 oZrwHPAKSTgpw==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50eabbc3dccso1804745e87.2
        for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 15:25:34 -0800 (PST)
X-Gm-Message-State: AOJu0YyXbyopf7ys+9su5JzR9F/Ul5IKG68yiGchPBNnWR4cRaJMvSZc
	rRbegt5Sd49w8phfJK6dtFQCemqhgNz4ZdgorvUt+NL1TahG5c/lNx5UxHHDdsgkLB8yC40fKxt
	/nSmpuaoetaCYSdSHjtUltEXLNGE=
X-Google-Smtp-Source: AGHT+IGPPIGLbVNMr4hw32Hl/v+R2Ko6J+snc04kg3pBYTzicDj2P7DFbur+2Soij03Vh2z0SNB5jBmFppqkmbQ03eE=
X-Received: by 2002:a05:6512:3d29:b0:50e:6b54:6a61 with SMTP id
 d41-20020a0565123d2900b0050e6b546a61mr131243lfv.118.1705706732942; Fri, 19
 Jan 2024 15:25:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119110505.400573-1-jolsa@kernel.org> <20240119110505.400573-2-jolsa@kernel.org>
In-Reply-To: <20240119110505.400573-2-jolsa@kernel.org>
From: Song Liu <song@kernel.org>
Date: Fri, 19 Jan 2024 15:25:21 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7gFMtyWPGpWFORX6pNXLUqYSj2Srv1pVtgKoNS7g3=rQ@mail.gmail.com>
Message-ID: <CAPhsuW7gFMtyWPGpWFORX6pNXLUqYSj2Srv1pVtgKoNS7g3=rQ@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 1/8] bpf: Add cookie to perf_event
 bpf_link_info records
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 3:05=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> At the moment we don't store cookie for perf_event probes,
> while we do that for the rest of the probes.
>
> Adding cookie fields to struct bpf_link_info perf event
> probe records:
>
>   perf_event.uprobe
>   perf_event.kprobe
>   perf_event.tracepoint
>   perf_event.perf_event
>
> And the code to store that in bpf_link_info struct.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Song Liu <song@kernel.org>


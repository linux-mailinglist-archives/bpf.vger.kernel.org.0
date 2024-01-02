Return-Path: <bpf+bounces-18808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C45822283
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 21:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A673C1C22AA4
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 20:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246B316413;
	Tue,  2 Jan 2024 20:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5CAi5hx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12EA1640B
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 20:26:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E750C433C8
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 20:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704227171;
	bh=pSKKHjudX6GgskwhtqrH/A+5i60seHaM9rXNFaVFwcc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J5CAi5hxdREgN6N/Z3mwoy1d7xk2D6sN9rMwAekKkMWsB98lEhLj1fRHiOzu7/fni
	 xxd7WkGFArUO7NtsZqjDnDmCncyZEteZ8/o8RWPLrkD+KG5oWl0GYunm9gBqUHaYdG
	 DanBhwATYVgZLO+so4z+9WjF3pKMvK/soX4Mme5fCEEBIS2yJyTJKMpToJ9Q7WKAhh
	 cne7pkjW7hywAk9H8uLJnwtxIBvhR6TJcdh/DjyUeAd3n/kaPgaxzHOBqleMTmF6jI
	 pTfEphaTBvgugIlaj4sKbRTrLcLpGWQK7kTS711TEh7DvPfhMvAACHlyuLHqPtgeAW
	 HSMfo1zYr3I0Q==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e7aed08f4so6280712e87.0
        for <bpf@vger.kernel.org>; Tue, 02 Jan 2024 12:26:11 -0800 (PST)
X-Gm-Message-State: AOJu0Yx+54dIwDcMBL38QGsLsfF8yusGLdAM5sc5/Rfk+4URZQ7izavX
	WEquQFdD/3WSCR3VTkFyPgJ4fh9eVKaAUrQ7/Ok=
X-Google-Smtp-Source: AGHT+IGhHasDilakkZVSd+o5fWoLt0MVGaAmpfbMjpPqD5fw+zqG4wBXH9aQ70jfhC7szMzUg5hj5NB8IbftDhgi7K8=
X-Received: by 2002:ac2:5198:0:b0:50e:9354:c36f with SMTP id
 u24-20020ac25198000000b0050e9354c36fmr2400lfi.19.1704227169485; Tue, 02 Jan
 2024 12:26:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222151153.31291-1-9erthalion6@gmail.com> <20231222151153.31291-5-9erthalion6@gmail.com>
In-Reply-To: <20231222151153.31291-5-9erthalion6@gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 2 Jan 2024 12:25:58 -0800
X-Gmail-Original-Message-ID: <CAPhsuW76yBCqu42RpsEJE_rth=BQLKB7e84QOS0L9E_VDL1qYw@mail.gmail.com>
Message-ID: <CAPhsuW76yBCqu42RpsEJE_rth=BQLKB7e84QOS0L9E_VDL1qYw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v11 4/4] selftests/bpf: Test re-attachment fix
 for bpf_tracing_prog_attach
To: Dmitrii Dolgov <9erthalion6@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, yonghong.song@linux.dev, 
	dan.carpenter@linaro.org, olsajiri@gmail.com, asavkov@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 7:12=E2=80=AFAM Dmitrii Dolgov <9erthalion6@gmail.c=
om> wrote:
>
> Add a test case to verify the fix for "prog->aux->dst_trampoline and
> tgt_prog is NULL" branch in bpf_tracing_prog_attach. The sequence of
> events:
>
> 1. load rawtp program
> 2. load fentry program with rawtp as target_fd
> 3. create tracing link for fentry program with target_fd =3D 0
> 4. repeat 3
>
> Acked-by: Jiri Olsa <olsajiri@gmail.com>
> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>

Acked-by: Song Liu <song@kernel.org>


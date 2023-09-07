Return-Path: <bpf+bounces-9447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5BC797C62
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 20:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8BB0281598
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 18:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E1C13FF3;
	Thu,  7 Sep 2023 18:52:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370F412B6E
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 18:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C7CC433C8
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 18:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694112760;
	bh=vB3Ms8LRAuJB/NC3E+dsrhw2RIa+/Dl/GRjAeKJNBYU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=t3gn3yDPc2fxLxm8lw2DaepQbCZPZ1xKzY+Celmtbl8DsAkNT1r6X0FD5pwY8bFHa
	 U71p64p+LDWm9BsOILW5IB2wPriESs8pLV3tnCaXndB/XMDHElOO0zuOT2Eu8QVxXT
	 MsbjRlNBcKzZvewCDOX0y+R6npTJKW//TQHZoARzVLJLNhfscCf0n/oiJ9quNADUlt
	 5D+eEyX120DNhvvA1SylkKwEUI3GXur8XIKR4SOLm46gLpSTql6aDeEX1GUTBgqKdJ
	 +7WjseudKLeUhl/tOJUGKCteZvUhtLREQpsHviqnK7dSVfwkgj3EN+LxkqD0BLzrlY
	 6426pZ44ThPpQ==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2bd6611873aso21493311fa.1
        for <bpf@vger.kernel.org>; Thu, 07 Sep 2023 11:52:40 -0700 (PDT)
X-Gm-Message-State: AOJu0YzlsBVkokgjAsno9eD62b1d7U2+yY+ecQj5suoOSH0FnR8iVCGA
	JbUdZ6hsB+7Ncg3YVd31GEbKF7nsBIVV8G68nWY=
X-Google-Smtp-Source: AGHT+IE5rk8GtbMuPg5xYH3r3Iub5Pg5Y0420IzWtPDnFydXxwSKlCB5CbK6pVq/9fvH9HtZz2g4dHr4QC5vqFtazB8=
X-Received: by 2002:a2e:9c0b:0:b0:2bc:be93:6d3c with SMTP id
 s11-20020a2e9c0b000000b002bcbe936d3cmr74960lji.32.1694112758774; Thu, 07 Sep
 2023 11:52:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230907071311.254313-1-jolsa@kernel.org> <20230907071311.254313-8-jolsa@kernel.org>
In-Reply-To: <20230907071311.254313-8-jolsa@kernel.org>
From: Song Liu <song@kernel.org>
Date: Thu, 7 Sep 2023 11:52:26 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7zVT9v2mLSVrkefcR_aFj2wDzW5-pjYakvW72HqcKfuw@mail.gmail.com>
Message-ID: <CAPhsuW7zVT9v2mLSVrkefcR_aFj2wDzW5-pjYakvW72HqcKfuw@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 7/9] selftests/bpf: Add test for missed counts
 of perf event link kprobe
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Hou Tao <houtao1@huawei.com>, bpf@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 7, 2023 at 12:14=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding test that puts kprobe on bpf_fentry_test1 that calls
> bpf_kfunc_common_test kfunc, which has also kprobe on.
>
> The latter won't get triggered due to kprobe recursion check
> and kprobe missed counter is incremented.
>
> Acked-by: Hou Tao <houtao1@huawei.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Reviewed-and-tested-by: Song Liu <song@kernel.org>


Return-Path: <bpf+bounces-75244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4DEC7AF67
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 17:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 33AC33457B2
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 16:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D8D2E6CAF;
	Fri, 21 Nov 2025 16:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTezDvk/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7431EB5CE
	for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 16:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763744061; cv=none; b=cjjhBHfqJ4dEdO1hw4zZEdEWwC6ILpjKoTwxLYZdVPaSw6er1pswnniwt8qkxTowuE7/pTtqOZRTEazdI7D6HX8lQiHpVrO5xOHX3P4tuZDP/z+PM7RBLDWYzcioolAAGq6v7mKqNPD69U8mvJzHMXkAW+tppp7B0fOYmDa3hRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763744061; c=relaxed/simple;
	bh=8REb4tAVhdcL4z8N3n2k2tUhUSMXPOQfkxIU+oDA6ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tf3vOsIyeHWpkSUqVvvlxooQAAER0+WAlNWm9np5S981xEanpxguJkjeUx/bX9LbS96Sz+sDJyw2wRWBdp0iUPcNw0S11abzDHYz0kp8ngV9je5WcrGlwPRPhom4h+lEB4KB/flFHRAVzOeAIxUWjkD8px0yR2QI9TAxQKirDf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTezDvk/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3216C2BCB1
	for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 16:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763744060;
	bh=8REb4tAVhdcL4z8N3n2k2tUhUSMXPOQfkxIU+oDA6ns=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HTezDvk/nvWJdmrvgh18lfKQstCKv0uuxSzmct6Keu3hJqAiKw+VsRLBStBWhsS0o
	 nAaOtoSStJ+ZVDBqS+sYM03PLYVIjsNWe/SuZwoJFyZUq9FatBjLX4cAanpIvkUS3N
	 bSIiTSSXvEyVI+QUaVQptwuSVlIp7IhGniI3EKqBjS6pUmqqO8ElUhCp/BLdEBu+rV
	 ZD88p4OQAE8iLzL6VFGRpruewtrTuTNIbs7vTMwTm8rhwheO3Iphmn2po2fsXUPI21
	 OVJcdpmKaomBcY1UOPQlBjV/iHPFsioHpZmDTWHw5fDfmNAfdeJdNxxvicbOvS10Fx
	 RiH0q8idOizAw==
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-640d4f2f13dso2066120d50.1
        for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 08:54:20 -0800 (PST)
X-Gm-Message-State: AOJu0YxvrNPaEmdEl+54RHbs0acX9K3fIEY6LCAIqy2sOUc38MXr7aBd
	piHJs3xo2/566sznuXheQVa17nacSnKyQEpvozc6USvc7JeK9FfOsDkKTmJxnU5x5/JR14UDy3i
	5X1q3zgtltDsI9lW6GsM+lwwiEMEqDaE=
X-Google-Smtp-Source: AGHT+IGMYVdgrPpuRw2Jt9kEHFZhG5Y+Pp8CV5tzUNYfZu9BLBcC1fgoZiJdF3xfabnMC36iQ1BHJugeFgXYq0kRT6U=
X-Received: by 2002:a05:690c:4c06:b0:786:4ed4:24ff with SMTP id
 00721157ae682-78a8b47de5bmr21432337b3.1.1763744059782; Fri, 21 Nov 2025
 08:54:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120142059.2836181-1-mattbobrowski@google.com>
In-Reply-To: <20251120142059.2836181-1-mattbobrowski@google.com>
From: Song Liu <song@kernel.org>
Date: Fri, 21 Nov 2025 08:54:08 -0800
X-Gmail-Original-Message-ID: <CAHzjS_vFMovAkKM+gBmQ5YkKpRx4-2ewK0hgHpOhCqVf2TTx9w@mail.gmail.com>
X-Gm-Features: AWmQ_blOmDRJES-UzwALCyyGHIpu3E8sbV1sp4h265ne6ofDQKLvYqns-O5bgUY
Message-ID: <CAHzjS_vFMovAkKM+gBmQ5YkKpRx4-2ewK0hgHpOhCqVf2TTx9w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: skip test_perf_branches_hw() on
 unsupported platforms
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, ohn Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 6:21=E2=80=AFAM Matt Bobrowski <mattbobrowski@googl=
e.com> wrote:
>
> Gracefully skip the test_perf_branches_hw subtest on platforms that
> do not support LBR or require specialized perf event attributes
> to enable branch sampling.
>
> For example, AMD's Milan (Zen 3) supports BRS rather than traditional
> LBR. This requires specific configurations (attr.type =3D PERF_TYPE_RAW,
> attr.config =3D RETIRED_TAKEN_BRANCH_INSTRUCTIONS) that differ from the
> generic setup used within this test. Notably, it also probably doesn't
> hold much value to special case perf event configurations for selected
> micro architectures.
>
> Fixes: 67306f84ca78c ("selftests/bpf: Add bpf_read_branch_records() selft=
est")
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>

Acked-by: Song Liu <song@kernel.org>

Thanks for the fix!


Return-Path: <bpf+bounces-38691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D30A8967DB7
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 04:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FA4E1C218E2
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 02:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742E22A1D3;
	Mon,  2 Sep 2024 02:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dl7DhFY7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75F6125DB;
	Mon,  2 Sep 2024 02:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725243356; cv=none; b=lCQ4zORbBweGm6tw6YvetHmubBjLfJn3C7wav3AW2DaWiM2HudU8XPbPcy8TW+WwE37wfZhnF8xrUZAqzXsPiT1C+3pPwtODceEBG5D0a+8TAQ/NZOD1C1l0SU+HXhhGJp8vjSarm0123inXEfbl1S88SQwTQNg9my5UaVDCRQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725243356; c=relaxed/simple;
	bh=6z77a/tm64j1l7gPWIFt1gWOncRUJVxSyOL6jV/krSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bMppnSuR3Y76mFxpN7f6DVx7r3RVW39xSfx5JWJg8KPVwlzd7eNFbFzco2qUWZAOSdHr1LpS8JQ5g1qRW3tIpec0OLUEJHBrMADqoqADRVBCnHCeWhooaxs/McDo8W7+gODffTa5Gx6U4YGG9NhxslkPrbwcv6wJXYQAoRK2ZhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dl7DhFY7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85EF5C4CEC3;
	Mon,  2 Sep 2024 02:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725243355;
	bh=6z77a/tm64j1l7gPWIFt1gWOncRUJVxSyOL6jV/krSY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dl7DhFY7EF0KTN0YUauxSwwDq5ak/HCu+Ecnss5k4OqtQYe/KD/0q+8zen9RBKsBC
	 u72KqeJOAjiCBk3FOhHbBT0kggqD9AeJuzqiLuI1n3sa8vC3pWzosdJ38B9Ag6JTsO
	 6CvS9Y7VuoJS3i4xFqc6Il1hHFb9HCdhpm5SapoULTNAFhDl/oAR+TfEqJ9VCw1rnT
	 3xayK0GYc93AH0pJmm/1G703GLvieSeWwN46CFjxVSR46OqQzYttx2DME8iFM/tQMB
	 YKy9QDi8bVdEsRUXOoIXiYKNvL4FIHCPQZPDbMP+R9ehsBBTm2XIF92IEzEA9uAjJR
	 TQYkYT7Yu3Nxg==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f50f1d864fso41922031fa.1;
        Sun, 01 Sep 2024 19:15:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUyBNtVjPFVZS/RbdUbf9JdBBc+WI0FSW9jTxIHJzd8j5mDXYq0vd/30oa3ifppecp9E8K0B1asDp4SDY6F@vger.kernel.org, AJvYcCVKGwX6hdyDhsv3RpQpNY72EpabtFkqmTHxMmdutJe0rBJWe4TPiCXzBRy6b/8b5570QCqCr5p5AXSZK+Sj@vger.kernel.org, AJvYcCXpJcrNp7kgv0yvCyqle3dKx95JRNw0bSwUkefyESq2Jtpn39s+CRkGnsm0BoVH2tGmCoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqXqQqhDCw8YNFVsZO/BI3bCzesmCAYKLOs5yUy1I/cZAIDZKP
	PuXnERxxXnhqsiPKcfMtcyGI9ZIOnhEyn1g+UOEv9WoYmUoYA+3QcjCQbtG0D5WVmYtTiAmRLrW
	jJiFzI7IsqWcG92H2sEZ2bRbQb80=
X-Google-Smtp-Source: AGHT+IERe6EqEnhkGMu2Dri3rExqJpscPFLnCvRKWhFr1SjF2sXzajyZ8dl2BetccFcd+pZ8aH8cVyPRoEBeJlZyJBA=
X-Received: by 2002:a2e:b88b:0:b0:2f0:1fd5:2f29 with SMTP id
 38308e7fff4ca-2f6290445femr32966531fa.19.1725243354204; Sun, 01 Sep 2024
 19:15:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240728125527.690726-1-ojeda@kernel.org> <CAK7LNARhR=GGZ2Vr-SSog1yjnjh6iT7cCEe4mpYg889GhJnO9g@mail.gmail.com>
 <ZsiV0V5-UYFGkxPE@bergen> <CANiq72khCDjCVbU=t+vpR+EfJucNBpYhZkW2VVjnXbD9S77C0A@mail.gmail.com>
In-Reply-To: <CANiq72khCDjCVbU=t+vpR+EfJucNBpYhZkW2VVjnXbD9S77C0A@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 2 Sep 2024 11:15:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNARJjM2t_sqE-MePzEEF3D3SznNYh99F5bM003N_xGFpug@mail.gmail.com>
Message-ID: <CAK7LNARJjM2t_sqE-MePzEEF3D3SznNYh99F5bM003N_xGFpug@mail.gmail.com>
Subject: Re: [PATCH] kbuild: pahole-version: avoid errors if executing fails
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 24, 2024 at 3:48=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Fri, Aug 23, 2024 at 4:00=E2=80=AFPM Nicolas Schier <nicolas@fjasle.eu=
> wrote:
> >
> > Do we have to catch all possibilities?  Then, what about this:
>
> Something like that sounds good to me too -- we do something similar
> in `rust_is_available.sh`. We also have a `1` in the beginning of
> (most of) the `sed` commands there to check only the first line.
>
> I guess it depends on whether Masahiro thinks the extra
> checks/complexity is worth it. Here I was aiming to catch the case he
> reported, i.e. non-successful programs.


My previous report was slightly different.

CONFIG_{RUSTC,BINDGEN}_VERSION_TEXT are string type symbols.
The shell command is allowed to return any string, including an empty strin=
g,
as long as the value is enclosed by double quotes.

In this case, CONFIG_PAHOLE_VERSION is an int type symbol,
hence the shell command must not return an empty string.

Ensuring this should be easy.
Why don't we fix it properly while we are here?




>
> Cheers,
> Miguel
>


--
Best Regards
Masahiro Yamada


Return-Path: <bpf+bounces-63863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D385DB0B827
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 22:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C1E83B7C17
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 20:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0925E21CFF4;
	Sun, 20 Jul 2025 20:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYKPPXng"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73228208A7;
	Sun, 20 Jul 2025 20:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753043874; cv=none; b=JVVRqEjX8DBKMU68tYTPCKDsSAkjn5oICLQK86KA1tHn0DfDC+uXksPScSJVpE/iQed8eOb4KxUTEWoXz+fZ5weBORjUp+qyn4bImJ5msrup/FoKAL3mB7w3kzkUWdut/h8mHkY9YcsR5cKl5IMZZXAla6VFkbxrZh/kInlav/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753043874; c=relaxed/simple;
	bh=fcbfoAX+qKBBt661MEouZNU/1XPJWU8ldRLY416DlZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svv0jg65Xczj439SqYZqud6CC93IAXl25/ZymfwDhb5GrkQOgBvgDrNxFO/qWKzWq2U2kmAYV3wVRzv5vD2WjgDen8TfC8SfcEHtvLy08MUcUG731vK8WGaLXBNFZQ7nlvmKS6soNe8D1EqxL7QE1/mjZQLRRSmtkqbFFU+G1IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYKPPXng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8012C4CEE7;
	Sun, 20 Jul 2025 20:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753043873;
	bh=fcbfoAX+qKBBt661MEouZNU/1XPJWU8ldRLY416DlZ4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RYKPPXngS9zSJZtbHin0azpivQGjdxDjP/vCJnRdvCoyhZTyYyF9SnZyLUSnHIKbE
	 u1eMGH2Zn4FCkx04xo76rQXA+Lb6D4A7TiDMeAGe9TnurLtRjnacSiP/GB5OLHGOIl
	 Vhi+tEkZjy8W9VEvJf8b0a0SU8MZxW9xeiR3Fc6ySWDPzaMNUai9AjYIhpg1xtarl5
	 Piwx1XTt7j9AFoaotfbbZDt7F/ioxip9Dj7DaLJnfIGjIWsymiZ+GEPOnDq/Yal8my
	 yMDAlsLo2uSBZ2geXJuzGJXLT8UYckJFIxdI+ftImiHJ798wgJNCpuZErh0w/QqHA3
	 UxFC5IkpFZyLg==
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4abd3627e7eso9298571cf.0;
        Sun, 20 Jul 2025 13:37:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUj/0AKBczLiG83j9ZWcYl0lOOraRwwziJJHukrrCD4QBtHKyoBW4BLfg6EACjtPPS9hrQRpRD5NQRadVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyKZ+Avg63eDIVtIzexvoBNWNjTEy4ag9RNpGamugS2cmdqS9p
	TRHoNSGZbY8TEzxeGU0Kl6jYcnnjRp/vYzIMkGw3GDFl0nYM2VZiXzRKg8R5fzrdxl+EF5oqypR
	+cyGhDi+QQAzYuSMerh/O7pHjafPPK0Y=
X-Google-Smtp-Source: AGHT+IGdGLwSGpb2nnTN7bsf+wE9IWEjiLxVEzfUAxu8au/YyN6jHDmhSzxg/RZdpGgWflj8cAZ/bbexCqbq2qiRqVE=
X-Received: by 2002:ad4:5b87:0:b0:705:15a6:3eef with SMTP id
 6a1803df08f44-70515a642bfmr132901766d6.47.1753043872933; Sun, 20 Jul 2025
 13:37:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250719091730.2660197-1-pulehui@huaweicloud.com>
In-Reply-To: <20250719091730.2660197-1-pulehui@huaweicloud.com>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date: Sun, 20 Jul 2025 22:37:41 +0200
X-Gmail-Original-Message-ID: <CAJ+HfNi-u0aYggUAUS5vc6=6gPjaQ-8fwRfK2peMqjJh+m+ZzA@mail.gmail.com>
X-Gm-Features: Ac12FXyero4-XOs_Gw2Llu9WOI3GJUY3SRh4iDZu0EfaOdRGg2H-wC76MfapgaE
Message-ID: <CAJ+HfNi-u0aYggUAUS5vc6=6gPjaQ-8fwRfK2peMqjJh+m+ZzA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/10] Add support arena atomics for RV64
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Puranjay Mohan <puranjay@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Pu Lehui <pulehui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Lehui!

On Sat, 19 Jul 2025 at 11:14, Pu Lehui <pulehui@huaweicloud.com> wrote:
>
> From: Pu Lehui <pulehui@huawei.com>
>
> patch 1-3 refactor redundant load and store operations.
> patch 4-7 add Zacas instructions for cmpxchg.
> patch 8 optimizes exception table handling.
> patch 9-10 add support arena atomics for RV64.
>
> Tests `test_progs -t atomic,arena` have passed as shown bellow,
> as well as `test_verifier` and `test_bpf.ko` have passed.

Awesome, thank you for working on this!

I'm on vacation until 4th Aug, but I'll try to do a review before that
-- but expect some slowness!


Thanks,
Bj=C3=B6rn


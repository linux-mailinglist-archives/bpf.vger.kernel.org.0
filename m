Return-Path: <bpf+bounces-76757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C66BCC507F
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 20:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6653303FE0D
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 19:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346C32C326F;
	Tue, 16 Dec 2025 19:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSXb7rIV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C515139D0A
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 19:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765914366; cv=none; b=ED6cmPmVHyIkgdCYK0cE8rwsKK0aiaiA/+ikVFHzoozoRsvgRO3Cg2Fhy5eYv8SMyJzwpWEddgJPeD+dmUeDRyXvBRlfrZznPkBXrtOzzQewk9OWruC8wqxBTKl/VgjB5qoVD0yzwNpv7PHOn1+J5YhjzYEtEfxGQfCLVLfyF4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765914366; c=relaxed/simple;
	bh=NQ8RtfVghKYR46SH2HtiWXoaqjBFrQ2JlHzuiBNkTCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5yI3hyUV034GQvyLLhRZHKeK/ovN7At2Q9yCFkr0EC5qIflJbjOyMgCX+St1bfvS7gy0P+KX/X+zGhYwhaMnhBrtT+0/UxdYTZnaU53GEIE66Un9lVRb03R6h4peQcInHh93iQk9G2Q1k9dpOf4+30ULkDabxd4ROS1BM5Amwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSXb7rIV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DF7C4AF0F
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 19:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765914366;
	bh=NQ8RtfVghKYR46SH2HtiWXoaqjBFrQ2JlHzuiBNkTCI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fSXb7rIVJH5G1V0nQNLRpluRqiiElp8jt0TG2nN067cGim+SnwB4HDppS0D5753c/
	 p6/iiEhBW/OzxEy1nEXGd0XeJsfhOy0CHII7MVrSdGEP6YlDaBsmS6G32ppTVR0HHs
	 0NHnAn58pkbh4i1gwQzA7NvfCOs0wsl2iHoZFosiyv6041DsKHvFmHm/L2JNpb4CBR
	 25q98cNc5cUDKlVrcS2hoPtR/ju1MU+MIw+qpPVhL/aLi/g5dSULLlBKDjl/xJoEQS
	 nxCfkzUAIOafLENKcIGfLKb6TVlqAWyoLakv8n8qwYH77j8u2vJaQeJkgUF4+20Vx0
	 JWVI9CZKbgaGw==
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8888546d570so25183466d6.2
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 11:46:06 -0800 (PST)
X-Gm-Message-State: AOJu0YxipHYhdo9Gd88udfcGtHskJzK/nVEUyL32c47euwC1nIqboIh0
	E89I74MmyzKX630ud7xyz0kLoALMbMQ/XnfbwHcREAU3YKiIdpbqXnRgJt/7BS3B2f57/jm6Rhj
	LpnibByxKyA9q1wcvL6Vx6POaxdH9OrQ=
X-Google-Smtp-Source: AGHT+IGmku2RTQqR1wKh9pgDUIVA4BOA1x1Hpgk7lKcoGdSZTMlncC3jOVNajxmu40a5Q1Q3xzyfMGBx97UhdKezKPQ=
X-Received: by 2002:a05:6214:c88:b0:88a:3657:d3f3 with SMTP id
 6a1803df08f44-88a3657d5c3mr115428866d6.10.1765914365708; Tue, 16 Dec 2025
 11:46:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216133000.3690723-1-mattbobrowski@google.com> <20251216133000.3690723-2-mattbobrowski@google.com>
In-Reply-To: <20251216133000.3690723-2-mattbobrowski@google.com>
From: Song Liu <song@kernel.org>
Date: Wed, 17 Dec 2025 04:45:54 +0900
X-Gmail-Original-Message-ID: <CAPhsuW6u_uLsLuFBi9z0-dr3h4pabpUNJ61UdKpm+CdmF1Hakg@mail.gmail.com>
X-Gm-Features: AQt7F2oKzCSMP4Y4BJF8pvf4PVRdjJYVguYqVN_sBRJczriAEaEyOehQD75J8A4
Message-ID: <CAPhsuW6u_uLsLuFBi9z0-dr3h4pabpUNJ61UdKpm+CdmF1Hakg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: add test case for BPF LSM
 hook bpf_lsm_mmap_file
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, ohn Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Kaiyan Mei <M202472210@hust.edu.cn>, 
	Yinhao Hu <dddddd@hust.edu.cn>, Dongliang Mu <dzm91@hust.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 5:30=E2=80=AFAM Matt Bobrowski <mattbobrowski@googl=
e.com> wrote:
>
> Add a trivial test case asserting that the BPF verifier enforces
> PTR_MAYBE_NULL semantics on the struct file pointer argument of BPF
> LSM hook bpf_lsm_mmap_file().
>
> Dereferencing the struct file pointer passed into bpf_lsm_mmap_file()
> without explicitly performing a NULL check first should not be
> permitted by the BPF verifier as it can lead to NULL pointer
> dereferences and a kernel crash.
>
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>

Acked-by: Song Liu <song@kernel.org>


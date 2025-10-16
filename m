Return-Path: <bpf+bounces-71118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 100DBBE4B34
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 18:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E605019C334B
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 16:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751212E7165;
	Thu, 16 Oct 2025 16:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/CFt/Yq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA8D262A6
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 16:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633803; cv=none; b=X/wQ1Cd0tRR5vEp5P+f4UGlVEJ6I2yQeq3qVtt+i7hy/Gai1ncWfcFU3rewg4jHwVaLfqcGFt8wT3pV+qp6mKSX/XIBO34g7RTPyBkzXmCCS8QAsd0X6Irk3ha6UnocmLM4u5zXQl8orNRnHyyyLjPR42qvGTeBix65mL9TZaiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633803; c=relaxed/simple;
	bh=lT3/WN793E3hmsKlV3Mjpvn8YcwRjpj6HiHw/Gsv94c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DOkirkpa8aOaQarPgQDqMOQ8/7GurEXBAyVco/i1J25hZEMquoR+pUe0MSUjCCzf0yW1Fn9daIXE9j2RZ4tgSNMYt3YYjqv+JAVPa8GU971gYtfElpHSwptjuSg4l32PvPDfiw1cMdw9t1JcGGzANFbuRF5MqupB66jzx+33bvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/CFt/Yq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C85C4CEFE
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 16:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760633802;
	bh=lT3/WN793E3hmsKlV3Mjpvn8YcwRjpj6HiHw/Gsv94c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=E/CFt/YqGcgPjjKLVElriNlbNS30ISd0zQ46ZSNGeyYGh1Qj1y/F3nkgTRWfKMBGS
	 tdO/VgEc6lO6EjPBHCgxIod76f2CACJ4Oj2Xt3i+vRoXcOA9Jdw2os7SsZKH99vQqq
	 0m5R/F7tT5lKw/BLk+sQoaW13df5y0WceNZKpA8aJ/JgUgxro0DSfToGMJiY/PxhPY
	 2I0gTMbqajz+60s6Z8v2m3LfSMEVZvJlXcg2Px54n2AVyJKMfij7xSr/6o1J5z43Ls
	 qAv9SvjDPm8kGHYAipU99jPyScJiMfkp4RgwiM+atpArgZ9frRMSURpjk/j0fidUNd
	 mTil/66G6uNTw==
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-87c217f4aaaso1647086d6.0
        for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 09:56:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXFho5t5YU0nHSZLQhPVzhH0dtGOMo94bEyiVhP4Q3b9Y+TPDZ4700FyGQeJEHk7X7qLEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfPV6BfiAQO5eO2V6z33dm/aoaqAllIEMC1mQavHUKClIXJ6vY
	+zFd0aX9JIGr+In9TaB82ftjg9mhN2zXR5OPAFNhPThyinXdExclyEMpPFZ5vZq95S99zoCljLF
	BJf5138wibKjbNwLTJtcJ3LAosd355yA=
X-Google-Smtp-Source: AGHT+IF+HoQA4ciDMMviejFII3nUssbgT5ZSnVzYGzdwehWfE8yAF5630JTnehlsTNz8VnnPiDfnlb85h6DaamzoR1Q=
X-Received: by 2002:a05:6214:2407:b0:7fd:2bc6:6cb0 with SMTP id
 6a1803df08f44-87c206322b0mr13294636d6.55.1760633801627; Thu, 16 Oct 2025
 09:56:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016063929.13830-1-laoar.shao@gmail.com>
In-Reply-To: <20251016063929.13830-1-laoar.shao@gmail.com>
From: Song Liu <song@kernel.org>
Date: Thu, 16 Oct 2025 09:56:30 -0700
X-Gmail-Original-Message-ID: <CAHzjS_tewz0H5G__hQdM2WgzOiq8t5ZyL=9YuicPF2ttU5mQYQ@mail.gmail.com>
X-Gm-Features: AS18NWC8TpcdquMnfHO00o6pVWtFSIROc7Gq2f3MZQyIZcDqnLvt-ixjbGTQi0w
Message-ID: <CAHzjS_tewz0H5G__hQdM2WgzOiq8t5ZyL=9YuicPF2ttU5mQYQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] bpf: MM related minor changes
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-mm@kvack.org, root <root@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 11:39=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
>
> From: root <root@localhost.localdomain>
>
> These two minor patches were developed during the implementation of
> BPF-THP:
>
>   https://lwn.net/Articles/1042138/
>
> As suggested by Andrii, they are being submitted separately for review.
>
> Yafang Shao (2):
>   bpf: mark mm->owner as __safe_rcu_or_null
>   bpf: mark vma->{vm_mm,vm_file} as __safe_trusted_or_null
>
>  kernel/bpf/verifier.c                   | 9 +++++++++
>  tools/testing/selftests/bpf/progs/lsm.c | 8 +++++---
>  2 files changed, 14 insertions(+), 3 deletions(-)

For the set:

Acked-by: Song Liu <song@kernel.org>


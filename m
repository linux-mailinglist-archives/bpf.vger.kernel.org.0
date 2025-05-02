Return-Path: <bpf+bounces-57237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3353EAA7651
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 17:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A4B74C780B
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 15:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6FE2580C6;
	Fri,  2 May 2025 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkmjeN3K"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A116323B0
	for <bpf@vger.kernel.org>; Fri,  2 May 2025 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746200609; cv=none; b=LB0dlofKdPLene3b4bMeYnmcOA5GRX5E9cv16ST1vpuu9Vq7mJgC8LbT/BwqAGiRVxO7psLUfZDGEwukarnwayWcampHjK2nzM7tEbbYXTD/GrnBQ5zTetjYA5cMl54rAfByg16g7ALHmMyzgu4zQWN8eIlqGuBNenK+GfdGjGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746200609; c=relaxed/simple;
	bh=PaItWjYHU68Rvu/xvxI3f6ix8BVJ19mHeHVfLkaSsdA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a22L+IBPCAQiNkuyBsejhbN59MraKtvMGmvSewS3f7r9iC49WYFEdq4dK1FD4nCTnSoW4J0XzIFmgAqImQueEQQ73osmfWp/UbpDn0PcDuo1FfMmJjX40jnSH3MLkMeXyjSgYfkauaCw4iPLy5rX3QZK/ZeqLuDJuB4m/tkPuyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkmjeN3K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43187C4CEE4;
	Fri,  2 May 2025 15:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746200609;
	bh=PaItWjYHU68Rvu/xvxI3f6ix8BVJ19mHeHVfLkaSsdA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MkmjeN3KNBGp/nvpHQT+G00nR7HO3/PS2cau7Gwc82eEO4oy2yV/Z6kdOWKa1GZWj
	 LOGK6QrNozcOBI3tFRA4HI9Jkhksi2kM/EPsVYMrOmHyM4MfGkP2g0CYvXfQMKq1qE
	 72v1+q8VABRsP7Ww0rMXQb6GjeBJsoxnouaW4k1bgqIAGGPfIJ+V3/bjYLzwpT9qhH
	 tMeF5hC2iuK9EC51ttERbSNEqfNRT5k5ApY7rupFlEVCqcQru5kANRPlnIqh/liwey
	 O3L3Pau0WBPbhIc0nLBkCQiAsQi0OgnqXz10ti7ElCFGyjK2+TgUWVcrJ9ypWsqat7
	 2UKLymflx5MuQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Peilin Ye <yepeilin@google.com>, bpf@vger.kernel.org
Cc: Peilin Ye <yepeilin@google.com>, linux-riscv@lists.infradead.org, Andrea
 Parri <parri.andrea@gmail.com>, Pu Lehui <pulehui@huawei.com>, Puranjay
 Mohan <puranjay@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Luke Nelson <luke.r.nels@gmail.com>, Xi Wang
 <xi.wang@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
 Ghiti <alex@ghiti.fr>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan
 <shuah@kernel.org>, Josh Don <joshdon@google.com>, Barret Rhoden
 <brho@google.com>, Neel Natu <neelnatu@google.com>, Benjamin Segall
 <bsegall@google.com>
Subject: Re: [PATCH bpf-next 0/8] bpf, riscv64: Support load-acquire and
 store-release instructions
In-Reply-To: <cover.1745970908.git.yepeilin@google.com>
References: <cover.1745970908.git.yepeilin@google.com>
Date: Fri, 02 May 2025 17:43:25 +0200
Message-ID: <87ldrfm31e.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrea/Peilin!

Peilin Ye <yepeilin@google.com> writes:

> Hi all!
>
> Patchset [1] introduced BPF load-acquire (BPF_LOAD_ACQ) and
> store-release (BPF_STORE_REL) instructions, and added x86-64 and arm64
> JIT compiler support.  As a follow-up, this patchset supports
> load-acquire and store-release instructions for the riscv64 JIT
> compiler, and introduces some related selftests/ changes.

Thanks a bunch for working on this!

For the series:
Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com> # QEMU/RVA23



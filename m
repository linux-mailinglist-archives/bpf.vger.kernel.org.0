Return-Path: <bpf+bounces-5656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E6675D5E7
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 22:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5198A1C2173F
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 20:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A73FDF6E;
	Fri, 21 Jul 2023 20:42:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48383DDD4;
	Fri, 21 Jul 2023 20:42:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AACFC433C7;
	Fri, 21 Jul 2023 20:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689972135;
	bh=mF5hO4cnwx7N31AkSxnv7cO0zNt07otNtqJAFumdlE0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=eKjjfhikUtSgz9IY1Im/x92qqghAZ+amTqT6cStSSg0vRWwf399UbiMjxveCUBz54
	 6kXVIYY19sq2q0BExt6lyaKUG1j35X8LNwXHzcouFW7ET2PgcC8+wl/uR3beuea/nf
	 Qdyp7UiKi0vnnk5+3RCRNl+7WknYZkNJ60JaOClQKYiZDOeE8NsYkBcXmAs3PD4R4O
	 cVqK7lWoaxuMB8T1tPRqedTVbzrjgQ21+387A2qV0j13TN4cJBrbxI7P7XhN1Zmuh5
	 xB3P1bMj/p+gx4P+/+Z2d60iiDXjtNZRZsiMID4j+E64e3DWTRNucqm7iaRpPaXzwt
	 u2qQm8fZibvvw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>, linux-riscv@lists.infradead.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song <yhs@fb.com>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Guo Ren <guoren@kernel.org>, Song Shuai
 <suagrfillet@gmail.com>, Pu Lehui <pulehui@huawei.com>, Pu Lehui
 <pulehui@huaweicloud.com>
Subject: Re: [PATCH v2] riscv, bpf: Adapt bpf trampoline to optimized riscv
 ftrace framework
In-Reply-To: <20230721100627.2630326-1-pulehui@huaweicloud.com>
References: <20230721100627.2630326-1-pulehui@huaweicloud.com>
Date: Fri, 21 Jul 2023 22:42:12 +0200
Message-ID: <87sf9hgfob.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huaweicloud.com> writes:

> From: Pu Lehui <pulehui@huawei.com>
>
> Commit 6724a76cff85 ("riscv: ftrace: Reduce the detour code size to
> half") optimizes the detour code size of kernel functions to half with
> T0 register and the upcoming DYNAMIC_FTRACE_WITH_DIRECT_CALLS of riscv
> is based on this optimization, we need to adapt riscv bpf trampoline
> based on this. One thing to do is to reduce detour code size of bpf
> programs, and the second is to deal with the return address after the
> execution of bpf trampoline. Meanwhile, we need to construct the frame
> of parent function, otherwise we will miss one layer when unwinding.
> The related tests have passed.
>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

I'll do a proper review later (still on vacation), but I ran the
test_progs BPF selftest with the ftrace series [1] with this patch on
top.

81 more tests pass with [1] plus this patch, which is great!

Pre-patches [2], post-patches [3].

Feel free to add:
Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>


Bj=C3=B6rn


[1] https://lore.kernel.org/linux-riscv/20230627111612.761164-1-suagrfillet=
@gmail.com/
[2] http://ix.io/4B9e
[3] http://ix.io/4B9f



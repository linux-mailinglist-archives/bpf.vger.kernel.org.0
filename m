Return-Path: <bpf+bounces-10872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B44F7AEDF5
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 15:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id A9A69B209C2
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 13:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607C528E32;
	Tue, 26 Sep 2023 13:30:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A3528E17;
	Tue, 26 Sep 2023 13:30:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81973C433C7;
	Tue, 26 Sep 2023 13:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695735019;
	bh=BuTNpWWd/UAFxk2IYQCtAIX9ygrcQeHn4Wa7NWsusII=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ldR49Xpf4JBEqZ3Rc/jRRwnz2VKTfW8HBkk6ZI6ZH+1C+iO2nM/QC0IOmZnphvQe7
	 Kxuj91LbQt1swUkCQlMYWnMfXlikEnFqLYqAW5YsH/BvTLEvwseBEiN0hRDgBHedVe
	 CqF2h8FbLV4DXJuoDLyeEaOK4MLZrDNkGTnDGBYy5zD4m1u3K8EU8pRzdMZjpSqxMX
	 yreHM/bcTyES4ATxki4xFR/6EvMn/yd6DJMieYZOLSeqFHqAN2LK6FPhoZrZ7muSmf
	 lzeQRV9Kl6CrzobN39FJfnCvS1WC8smH/V3wmqJJqy4Dkr9/qVxQzyYbhRQBURlsq8
	 UvskYlen0NJOQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, Luke Nelson
 <luke.r.nels@gmail.com>, Pu Lehui <pulehui@huawei.com>, Pu Lehui
 <pulehui@huaweicloud.com>
Subject: Re: [PATCH bpf-next 0/4] Mixing bpf2bpf and tailcalls for RV64
In-Reply-To: <20230919035711.3297256-1-pulehui@huaweicloud.com>
References: <20230919035711.3297256-1-pulehui@huaweicloud.com>
Date: Tue, 26 Sep 2023 15:30:14 +0200
Message-ID: <877codoye1.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huaweicloud.com> writes:

> In the current RV64 JIT, if we just don't initialize the TCC in subprog,
> the TCC can be propagated from the parent process to the subprocess, but
> the TCC of the parent process cannot be restored when the subprocess
> exits. Since the RV64 TCC is initialized before saving the callee saved
> registers into the stack, we cannot use the callee saved register to
> pass the TCC, otherwise the original value of the callee saved register
> will be destroyed. So we implemented mixing bpf2bpf and tailcalls
> similar to x86_64, i.e. using a non-callee saved register to transfer
> the TCC between functions, and saving that register to the stack to
> protect the TCC value. At the same time, we also consider the scenario
> of mixing trampoline.
>
> In addition, some code cleans are also attached to this patchset.
>
> Tests test_bpf.ko and test_verifier have passed, as well as the relative
> testcases of test_progs*.

Apologies for the review delay. I'm travelling, and will pick it up ASAP
when I'm back.


Bj=C3=B6rn


Return-Path: <bpf+bounces-8452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B62786A88
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 10:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DAAE2814FD
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 08:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A42CA7B;
	Thu, 24 Aug 2023 08:46:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647A5CA73;
	Thu, 24 Aug 2023 08:46:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D557C433C8;
	Thu, 24 Aug 2023 08:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692866801;
	bh=XDddRmzIKkYqEuz8kl983GzVIYWy/vD+zwVKZEhKP2k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DQ7dli6mYgIhSksQ3KibQRXYJ9ICqwsGFeJe2NhE9giEOlOOs8nk+Rjqwpab0o724
	 0givHuxrlp7/G1s60bvbTttOd7Ln9/sO3WMZD3nbplYfTtzlm+zMZOWinbDJCagSfU
	 tSEydsO9k/rNJo4xj5s+pgV2tLJjRTSFoVrY6/IUCx411VreqwPJva/pe536Dm+nzb
	 v1eVRespUfgvAxddCmTda7TWCjXOesS+/cZzR+OTBGrGWcDRrfm7fGUB4laGwYX9qD
	 VQDoLRr7fmVARSWOWXS7t6g7j7k0WGMGLjRppI26LGuH5rfLDzGq48CcBrkI1wykzi
	 7yAMsI5mtgV8Q==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>, linux-riscv@lists.infradead.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri
 Olsa <jolsa@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Xu Kuohai
 <xukuohai@huawei.com>, Puranjay Mohan <puranjay12@gmail.com>, Pu Lehui
 <pulehui@huawei.com>, Pu Lehui <pulehui@huaweicloud.com>
Subject: Re: [PATCH bpf-next v2 0/7] Add support cpu v4 insns for RV64
In-Reply-To: <20230824095001.3408573-1-pulehui@huaweicloud.com>
References: <20230824095001.3408573-1-pulehui@huaweicloud.com>
Date: Thu, 24 Aug 2023 10:46:38 +0200
Message-ID: <87r0nshlox.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huaweicloud.com> writes:

> Add support cpu v4 instructions for RV64. The relevant tests have passed =
as show bellow:
>
> # ./test_progs-cpuv4 -a ldsx_insn,verifier_sdiv,verifier_movsx,verifier_l=
dsx,verifier_gotol,verifier_bswap

[...]

> Summary: 6/166 PASSED, 0 SKIPPED, 0 FAILED
>
> NOTE: ldsx_insn testcase uses fentry and needs to rely on ftrace direct c=
all [0].
> [0] https://lore.kernel.org/all/20230627111612.761164-1-suagrfillet@gmail=
.com/
>
> v2:
> - Use temporary reg to avoid clobbering the source reg in movs_8/16 insns=
. (Bj=C3=B6rn)
> - Add Acked-by

Thanks for getting the cpuv4 RISC-V support out so quickly!

For the series:
Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>


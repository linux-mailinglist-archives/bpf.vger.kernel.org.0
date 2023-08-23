Return-Path: <bpf+bounces-8401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A407785F60
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 20:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2B21C20323
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 18:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411401F196;
	Wed, 23 Aug 2023 18:14:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A421F931;
	Wed, 23 Aug 2023 18:14:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A293FC433C8;
	Wed, 23 Aug 2023 18:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692814451;
	bh=6WYbdQvbaUTU7jAYsOoRLczdc6WiEmOJqx1owqQdczY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=jnp9OnkqCFGBj/h9OTMFiamfq/+P0dMbhMG2wym3WRwS3We453QbP6a6Naa6WA/55
	 d4lxewnPO9sJ/eOFdW8Id7q+oLH+qu5WfYDQfCvEZsEqA4fHS1ZXjl/MCVrHUqcm2V
	 rQnTACprz2PN91Wy6YquXbrmyxgR7JTtwCnIMQ5ArUm5o9SmwEW1AslQAiAZraDgQF
	 h2tDxxbMKoaqy+zaiPzYbMLAi/oaijp+DPUTHk158fgQD2Ywb/PZFPbzgyDYkg8qH9
	 1W3Xw4IOX9qUdj1RLfiTo/cEPzNfdE8Ln2S04DCPkN4s+5vlwAgONpQFbmC2McakrT
	 EjkJ7PP63sJqw==
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
Subject: Re: [PATCH bpf-next 3/7] riscv, bpf: Support sign-extension mov insns
In-Reply-To: <20230823231059.3363698-4-pulehui@huaweicloud.com>
References: <20230823231059.3363698-1-pulehui@huaweicloud.com>
 <20230823231059.3363698-4-pulehui@huaweicloud.com>
Date: Wed, 23 Aug 2023 20:14:07 +0200
Message-ID: <87pm3dlj80.fsf@all.your.base.are.belong.to.us>
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
> Add support sign-extension mov instructions for RV64.
>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>  arch/riscv/net/bpf_jit_comp64.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index fd36cb17101a..d1497182cacf 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -1047,7 +1047,19 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn,=
 struct rv_jit_context *ctx,
>  			emit_zext_32(rd, ctx);
>  			break;
>  		}
> -		emit_mv(rd, rs, ctx);
> +		switch (insn->off) {
> +		case 0:
> +			emit_mv(rd, rs, ctx);
> +			break;
> +		case 8:
> +		case 16:
> +			emit_slli(rs, rs, 64 - insn->off, ctx);
> +			emit_srai(rd, rs, 64 - insn->off, ctx);

You're clobbering the source register (rs) here, which is correct.

(Side note: Maybe it's time to add Zbb support to the JIT soon! ;-))


Bj=C3=B6rn


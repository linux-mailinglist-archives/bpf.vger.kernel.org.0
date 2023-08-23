Return-Path: <bpf+bounces-8408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB73B785F97
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 20:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6591D28130D
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 18:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF451F94E;
	Wed, 23 Aug 2023 18:27:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622E21ED47;
	Wed, 23 Aug 2023 18:27:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4EBC433C7;
	Wed, 23 Aug 2023 18:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692815234;
	bh=WN9L1KlrQREqfwZPOPGJuWCDtRAjdgEQksUouW9qf9M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Y/hxvHUoxtBes39p/jN0qliJnRZK9bsMzMPSyB9IzlUpMCqaSXbqonYuSX0KYNSed
	 7ucAHpMo+3h/LoupE//4Dahe+bBhetrQCCBoCd1QOn2T4y0pSH3Zui96QG5PEZHzY4
	 lRyIh392RGpXlHS72s4eQtGxBSaw2K7reeUDguxRTUsk0YEQdUFB+dLtPpk59UBclh
	 UfN01KzI/dKFIBJaYvwE9jMie80LXbq8+Vml4ETXbI9dDKwVBj7OAxK9xh0THqNfmy
	 KEmDdJ7JY37mDg9tqNdgl5TO+YmobL0IBGNa5RL0HaeSiKALbS+hKB0ub5hpE3As19
	 2FEvD0AqxjqcA==
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
In-Reply-To: <87pm3dlj80.fsf@all.your.base.are.belong.to.us>
References: <20230823231059.3363698-1-pulehui@huaweicloud.com>
 <20230823231059.3363698-4-pulehui@huaweicloud.com>
 <87pm3dlj80.fsf@all.your.base.are.belong.to.us>
Date: Wed, 23 Aug 2023 20:27:11 +0200
Message-ID: <87ttspk41s.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:

> Pu Lehui <pulehui@huaweicloud.com> writes:
>
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> Add support sign-extension mov instructions for RV64.
>>
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>> ---
>>  arch/riscv/net/bpf_jit_comp64.c | 14 +++++++++++++-
>>  1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_co=
mp64.c
>> index fd36cb17101a..d1497182cacf 100644
>> --- a/arch/riscv/net/bpf_jit_comp64.c
>> +++ b/arch/riscv/net/bpf_jit_comp64.c
>> @@ -1047,7 +1047,19 @@ int bpf_jit_emit_insn(const struct bpf_insn *insn=
, struct rv_jit_context *ctx,
>>  			emit_zext_32(rd, ctx);
>>  			break;
>>  		}
>> -		emit_mv(rd, rs, ctx);
>> +		switch (insn->off) {
>> +		case 0:
>> +			emit_mv(rd, rs, ctx);
>> +			break;
>> +		case 8:
>> +		case 16:
>> +			emit_slli(rs, rs, 64 - insn->off, ctx);
>> +			emit_srai(rd, rs, 64 - insn->off, ctx);
>
> You're clobbering the source register (rs) here, which is correct.

Too quick! s/correct/incorrect/! :-)



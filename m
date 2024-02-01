Return-Path: <bpf+bounces-20933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F8E8454E7
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 11:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BDD128A976
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 10:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE92D15B975;
	Thu,  1 Feb 2024 10:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUZcF9T2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7CD15AABD;
	Thu,  1 Feb 2024 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706782259; cv=none; b=So3qvzi0itre2hUQxPEB+pY1Izz3GSXl2UKiNKVBTN9bllPKn9vOLwcMfzxf0ITSV1oLHThp9uLpRxe9Fq0gnaz6/s6wDcPN4mATqJl53CT4u16a6jm8J3mYH7Id68Mj+SEwVsPDbR5DwJ9pVMLetKJbNKlcwQYO0bzEAoQyaMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706782259; c=relaxed/simple;
	bh=kNpL087SdTjcpHpZyVDVxwYbgFh8TGavz5zFaqFwx9I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ijcOxoFYDji4h1CQY8v6nJArupCWFfo+ww+hFMzQpSrj3lZ4OQr4WNz7g5YWfFxjRU9ACOKAE+/GgIBlt926ax2Tg0ogyAzXefwo6lC/3QPbwdC9xazFno6acJqRadlb0n99H1bUyfEhoKbgDBpBCBqJz4rtGPVkbKtO2Qr018s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUZcF9T2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1183C43390;
	Thu,  1 Feb 2024 10:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706782258;
	bh=kNpL087SdTjcpHpZyVDVxwYbgFh8TGavz5zFaqFwx9I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HUZcF9T20LH5e967YRRqhKtkEzGG4/wImL8agSCSMROtzuPTo5wxkrHi8X2bPfk43
	 GCIHf0ozPYQ/ZxXgsbkEuvC6hEal/smcL0umPsIak4Qfgcp/Jm9XOgd7Gd3luyibVc
	 JhXeNbVaYqFdQyQHbop8xfeg4NU8vog1t7OMJh++kPawtlRmpsDla6p7QUvsCYUMd2
	 Zsb+Pibhxk6hsD80w1VLYcVx2Bxdk8dWKK6p0ViXP/YSkIh7xYe+6h+3ubHCPf8c+G
	 UP/swblYGgpBa49CYmBU2FKpCbCGXRRSawTajia0vXJljo0fZlKnbB6cbgVhunLSXp
	 IcAy6LT3+IdJA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Luke Nelson
 <luke.r.nels@gmail.com>, Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH bpf-next v2 4/4] riscv, bpf: Mixing bpf2bpf and tailcalls
In-Reply-To: <fab22b9e-7b56-4fef-ba92-bf62ec43007d@huaweicloud.com>
References: <20240130040958.230673-1-pulehui@huaweicloud.com>
 <20240130040958.230673-5-pulehui@huaweicloud.com>
 <87sf2eohj2.fsf@all.your.base.are.belong.to.us>
 <fab22b9e-7b56-4fef-ba92-bf62ec43007d@huaweicloud.com>
Date: Thu, 01 Feb 2024 11:10:55 +0100
Message-ID: <878r44mr4g.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huaweicloud.com> writes:

>>> @@ -252,10 +220,7 @@ static void __build_epilogue(bool is_tail_call, st=
ruct rv_jit_context *ctx)
>>>   		emit_ld(RV_REG_S5, store_offset, RV_REG_SP, ctx);
>>>   		store_offset -=3D 8;
>>>   	}
>>> -	if (seen_reg(RV_REG_S6, ctx)) {
>>> -		emit_ld(RV_REG_S6, store_offset, RV_REG_SP, ctx);
>>> -		store_offset -=3D 8;
>>> -	}
>>> +	emit_ld(RV_REG_TCC, store_offset, RV_REG_SP, ctx);
>>=20
>> Why do you need to restore RV_REG_TCC? We're passing RV_REG_TCC (a6) as
>> an argument at all call-sites, and for tailcalls we're loading from the
>> stack.
>>=20
>> Is this to fake the a6 argument for the tail-call? If so, it's better to
>> move it to emit_bpf_tail_call(), instead of letting all programs pay for
>> it.
>
> Yes, we can remove this duplicate load. will do that at next version.

Hmm, no remove, but *move* right? Otherwise a6 can contain gargabe on
entering the tailcall?

Move it before __emit_epilogue() in the tailcall, no?


Bj=C3=B6rn


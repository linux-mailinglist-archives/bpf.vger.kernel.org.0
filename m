Return-Path: <bpf+bounces-21052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1894D8470CE
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 14:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9F4E289C88
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 13:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBE7523F;
	Fri,  2 Feb 2024 13:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWov61Xa"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9900A40BF2;
	Fri,  2 Feb 2024 13:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706879047; cv=none; b=POTBHa2z0IFeluRkbG73Eq9JV2NMfdkcnG/FL9FW59WiXA6xSFdeDrNMm2A8SHt3e3o6Dxz+SGrAX73CuMi5KRyco5cOPAlbOtbY5A/eMQl6q07SzLq4KNS+GTB3Q1v2k36mSkJ299SFqr8De2OrVVuTrjzH/xGWGgJ2qZADzH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706879047; c=relaxed/simple;
	bh=sJfAEWjsAZta/5Hz8HZlZF6BluB71hiZTGWU2kv4FZ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xblp8mpV11LkRpN+jixoxyiOP9JD7eL+JuL7V1n75jJ3GdvxolNL/BxCLhd+6lgJp/2VyRP3BO6BnQOuyI/WgPuvQxFdgiMcNXXBW//XH9g4dhCeuCBUMKfMJNRuqAe1Hwm3o5jJZBrKRrvF3OtGfsTdNo1VqP9djf13kfGwhc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWov61Xa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85733C433F1;
	Fri,  2 Feb 2024 13:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706879047;
	bh=sJfAEWjsAZta/5Hz8HZlZF6BluB71hiZTGWU2kv4FZ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=GWov61XaezU5B5NhZDeqObu4dQW+TYXv1GWbezkW4ht3a1uRQNnsaMzXqEbXpqFnX
	 5q2PIKOGqiKTAO2uZFcen2/jaGc+Ranl8uZYNGOs6+U40APcnxtR04Z9U0FSNITy1/
	 EUXGDgwjwPKBXXx3rGWYfdiIg2LI1sFt9jJiAtSY1jayFExR7OCboy8dlMcMhsl9It
	 WfEsRIROz5vNouOVje6g5aYMU93tH0pl1zq8tEZZmAhokow3RwBqJxmEph41aRy1G/
	 nQrpVpP4CaxD11x9+kCtE1grJ6HX3m42lbdjUL7nFsRSk6g7WN09VrGZM0sc0DzaO9
	 pN8duy7KEryyw==
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
In-Reply-To: <160aaa6f-7efb-4a29-ab6f-dcf938d3419f@huaweicloud.com>
References: <20240130040958.230673-1-pulehui@huaweicloud.com>
 <20240130040958.230673-5-pulehui@huaweicloud.com>
 <87sf2eohj2.fsf@all.your.base.are.belong.to.us>
 <fab22b9e-7b56-4fef-ba92-bf62ec43007d@huaweicloud.com>
 <878r44mr4g.fsf@all.your.base.are.belong.to.us>
 <93209b12-9117-484a-908a-5b138fa2ffb0@huaweicloud.com>
 <87jznowbmf.fsf@all.your.base.are.belong.to.us>
 <160aaa6f-7efb-4a29-ab6f-dcf938d3419f@huaweicloud.com>
Date: Fri, 02 Feb 2024 14:04:04 +0100
Message-ID: <87wmrnhvaz.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huaweicloud.com> writes:

> On 2024/2/1 21:35, Bj=C3=B6rn T=C3=B6pel wrote:
>> Pu Lehui <pulehui@huaweicloud.com> writes:
>>=20
>>> On 2024/2/1 18:10, Bj=C3=B6rn T=C3=B6pel wrote:
>>>> Pu Lehui <pulehui@huaweicloud.com> writes:
>>>>
>>>>>>> @@ -252,10 +220,7 @@ static void __build_epilogue(bool is_tail_call=
, struct rv_jit_context *ctx)
>>>>>>>     		emit_ld(RV_REG_S5, store_offset, RV_REG_SP, ctx);
>>>>>>>     		store_offset -=3D 8;
>>>>>>>     	}
>>>>>>> -	if (seen_reg(RV_REG_S6, ctx)) {
>>>>>>> -		emit_ld(RV_REG_S6, store_offset, RV_REG_SP, ctx);
>>>>>>> -		store_offset -=3D 8;
>>>>>>> -	}
>>>>>>> +	emit_ld(RV_REG_TCC, store_offset, RV_REG_SP, ctx);
>>>>>>
>>>>>> Why do you need to restore RV_REG_TCC? We're passing RV_REG_TCC (a6)=
 as
>>>>>> an argument at all call-sites, and for tailcalls we're loading from =
the
>>>>>> stack.
>>>>>>
>>>>>> Is this to fake the a6 argument for the tail-call? If so, it's bette=
r to
>>>>>> move it to emit_bpf_tail_call(), instead of letting all programs pay=
 for
>>>>>> it.
>>>>>
>>>>> Yes, we can remove this duplicate load. will do that at next version.
>>>>
>>>> Hmm, no remove, but *move* right? Otherwise a6 can contain gargabe on
>>>> entering the tailcall?
>>>>
>>>> Move it before __emit_epilogue() in the tailcall, no?
>>>>
>>>
>>> IIUC, we don't need to load it again. In emit_bpf_tail_call function, we
>>> load TCC from stack to A6, A6--, then store A6 back to stack. Then
>>> unwind the current stack and jump to target bpf prog, during this
>>> period, we did not touch the A6 register, do we still need to load it a=
gain?
>>=20
>> a6 has to be populated prior each call -- including tailcalls. An
>> example, how it can break:
>>=20
>> main_prog() -> prologue (a6 :=3D 0; push a6) -> bpf_helper() (random
>> kernel path that clobbers a6) -> tailcall(foo()) (unwinds stack, enters
>
> It's OK to clobbers A6 reg for helper/kfunc call, because we will load=20
> TCC from stack to A6 reg before jump to tailcall target prog. In=20
> addition, I found that we can remove the store A6 back to stack command=20
> from the tailcall process. I try to describe the process involved:

Indeed! tailcall *is* already populating a6, and yes, the store can be
omitted. Nice!

Now, we still have the bug Alexei described, so until there's a
fix/workaround, this series can't be merged.


Cheers,
Bj=C3=B6rn


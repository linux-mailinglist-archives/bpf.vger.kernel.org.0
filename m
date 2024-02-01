Return-Path: <bpf+bounces-20959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F47E8458FF
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 14:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10AC5B24D43
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 13:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44B95B668;
	Thu,  1 Feb 2024 13:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aA3iTIM2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0F25CDC5;
	Thu,  1 Feb 2024 13:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706794540; cv=none; b=gwuYRp6XMRkVqbn1eQs4w6z//eIP6lNayNlDj/kF1Rj6IAyU/E9jLXllZ4r06yXi73iWFIq9ikFMOWUN1LxJPs5nA/GH+fQkbuolS3F52Ncv9YW2IrD7/e47W+If/LbfnrSkiu/5fI060k2P0uei4GgRNl1dPxtrGdP4PFtrzSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706794540; c=relaxed/simple;
	bh=6d+HrDKNndPChG5AQ65MC01cktHgwk8cHkxMaAbaBXw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lLI8VEq/N7jzqEtq5CShhOrielK4VRqpcYfzuoFr9t3LORgB/FYt9WbLBi7edKXuO2LuLNie+ilOZwgUEgel2zcAD5dg0ardnjB0DrNX2kKTpqhEpSvXHanKO2B+ZK3crnLCDYdf75JzYUUqmXcn0CDm90gv+LllyvChVDZfAZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aA3iTIM2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56BA7C433F1;
	Thu,  1 Feb 2024 13:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706794539;
	bh=6d+HrDKNndPChG5AQ65MC01cktHgwk8cHkxMaAbaBXw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=aA3iTIM24LNLvVQTM9MHRfgTQq4kgTbQnr7OOuMlSTJW5lflsMsXBtKoFismDk9lh
	 9ig55vrz6OkxQzVRn95S0aaW21RFNyh/OUCZ8oWuZjE6ILHv39ThjGPthVUdPOTt4M
	 VOyR+WyBNKJdlGbOY+/5fhd1IrTeZZR1XbdZnsTugAfHDHLMR/7sJRrlWv0rtbudxn
	 RnHPve+g1n0HySbljL58fWLoUlAzFz6XWqo1hoIAmI/MZiA6QOdnZcNUG1i4sbfexb
	 M5w30WQZ4vB7SbUB7Xov7Nb28ZRoKxTaSLKc1yNeXQJM85oPR+mmxOPXvkOkuU8PBN
	 3wDGV3usdbFJQ==
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
In-Reply-To: <93209b12-9117-484a-908a-5b138fa2ffb0@huaweicloud.com>
References: <20240130040958.230673-1-pulehui@huaweicloud.com>
 <20240130040958.230673-5-pulehui@huaweicloud.com>
 <87sf2eohj2.fsf@all.your.base.are.belong.to.us>
 <fab22b9e-7b56-4fef-ba92-bf62ec43007d@huaweicloud.com>
 <878r44mr4g.fsf@all.your.base.are.belong.to.us>
 <93209b12-9117-484a-908a-5b138fa2ffb0@huaweicloud.com>
Date: Thu, 01 Feb 2024 14:35:36 +0100
Message-ID: <87jznowbmf.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huaweicloud.com> writes:

> On 2024/2/1 18:10, Bj=C3=B6rn T=C3=B6pel wrote:
>> Pu Lehui <pulehui@huaweicloud.com> writes:
>>=20
>>>>> @@ -252,10 +220,7 @@ static void __build_epilogue(bool is_tail_call, =
struct rv_jit_context *ctx)
>>>>>    		emit_ld(RV_REG_S5, store_offset, RV_REG_SP, ctx);
>>>>>    		store_offset -=3D 8;
>>>>>    	}
>>>>> -	if (seen_reg(RV_REG_S6, ctx)) {
>>>>> -		emit_ld(RV_REG_S6, store_offset, RV_REG_SP, ctx);
>>>>> -		store_offset -=3D 8;
>>>>> -	}
>>>>> +	emit_ld(RV_REG_TCC, store_offset, RV_REG_SP, ctx);
>>>>
>>>> Why do you need to restore RV_REG_TCC? We're passing RV_REG_TCC (a6) as
>>>> an argument at all call-sites, and for tailcalls we're loading from the
>>>> stack.
>>>>
>>>> Is this to fake the a6 argument for the tail-call? If so, it's better =
to
>>>> move it to emit_bpf_tail_call(), instead of letting all programs pay f=
or
>>>> it.
>>>
>>> Yes, we can remove this duplicate load. will do that at next version.
>>=20
>> Hmm, no remove, but *move* right? Otherwise a6 can contain gargabe on
>> entering the tailcall?
>>=20
>> Move it before __emit_epilogue() in the tailcall, no?
>>=20
>
> IIUC, we don't need to load it again. In emit_bpf_tail_call function, we=
=20
> load TCC from stack to A6, A6--, then store A6 back to stack. Then=20
> unwind the current stack and jump to target bpf prog, during this=20
> period, we did not touch the A6 register, do we still need to load it aga=
in?

a6 has to be populated prior each call -- including tailcalls. An
example, how it can break:

main_prog() -> prologue (a6 :=3D 0; push a6) -> bpf_helper() (random
kernel path that clobbers a6) -> tailcall(foo()) (unwinds stack, enters
foo() with a6 garbage, and push a6).

Am I missing something?


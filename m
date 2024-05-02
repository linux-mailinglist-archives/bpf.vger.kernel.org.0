Return-Path: <bpf+bounces-28479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 410F58BA1D1
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 23:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E33361F227D5
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 21:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4AE181BAB;
	Thu,  2 May 2024 21:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0wb9iAw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6111E86E;
	Thu,  2 May 2024 21:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714684024; cv=none; b=GO5MRSdpFBt0zntbx+xn135FuxGJp9pZ/zf2Vgv/xHID35VaumKk9r5hQJEt5/abDMUv5Do87DaXlAIqpgWOJDTStmibR+plxcyPbHnjjGGrz9Q6QBB7jCFzFjhd/ZwAgqJcN/VlI85SIiuj9fL/1AxHBP0njqmFWMCZrSlFrsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714684024; c=relaxed/simple;
	bh=rjkBg6gUkSwRf+TgXtxDgQ2t24FzbYZEekev+R+BxDc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kfyqGm04PHbjTSHZC+EFbtUcflQHMSzwCafKm9YJagKTwRJxholsXtGMHR3K3+e/D23OU29je2S6sTyfd+Vt+NBMtaj4kvtSBoDV0/DuoWOQe8/D/x9a7XNMNa2OtX9tkKvjJD22vuGPQnlD7y53yUS3txk+C6lncE5wbHQAgt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0wb9iAw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA89AC113CC;
	Thu,  2 May 2024 21:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714684024;
	bh=rjkBg6gUkSwRf+TgXtxDgQ2t24FzbYZEekev+R+BxDc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=n0wb9iAwpK+XMfBr/FZ4U1DKg5YoFOUoEbTr63KIe4K4V+uV6oWvbzrQeqtP8mSLh
	 s3O6FRJAbtGMRyRod3rcECmmp3rO6SqFd8q8E6UaVdDJp0ja8BbIgEv/Ez0ACEerK3
	 UrrSf4hRJJ0VkcmpFz/wcBuibPdGxH1LsFVUpvrtl/u+3Zhfl1aeRppuaFGsEAEgHM
	 YgvazFudIx7K3DphZr4E3iYSTULNJ0dSbBbgmUch4hdUz4V5jsL5r1u0AOqq4mZNOx
	 xrejkiKoOu4hN56yYrWy6wA+L+f3RCUfyuOOFUErA7DkJkhGYX5+mB+r6BJzvnDruY
	 ybI1OvPKH2fkQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Arnaldo Carvalho de Melo
 <acme@redhat.com>, linux-kernel@vger.kernel.org, =?utf-8?B?QmrDtnJuIFQ=?=
 =?utf-8?B?w7ZwZWw=?=
 <bjorn@rivosinc.com>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
 bpf@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>,
 llvm@lists.linux.dev
Subject: Re: [PATCH v2] tools/build: Add clang cross-compilation flags to
 feature detection
In-Reply-To: <20240429171145.GA241057@myrica>
References: <20231102103252.247147-1-bjorn@kernel.org>
 <ZUOWcXDpCOzxbFW0@krava> <87o79wxvnu.fsf@all.your.base.are.belong.to.us>
 <20240429171145.GA241057@myrica>
Date: Thu, 02 May 2024 23:07:01 +0200
Message-ID: <87a5l7x6ru.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jean-Philippe Brucker <jean-philippe@linaro.org> writes:

> On Fri, Apr 26, 2024 at 12:31:17PM +0200, Bj=C3=B6rn T=C3=B6pel wrote:
>> Jiri Olsa <olsajiri@gmail.com> writes:
>>=20
>> > On Thu, Nov 02, 2023 at 11:32:52AM +0100, Bj=C3=B6rn T=C3=B6pel wrote:
>> >> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>> >>=20
>> >> When a tool cross-build has LLVM=3D1 set, the clang cross-compilation
>> >> flags are not passed to the feature detection build system. This
>> >> results in the host's features are detected instead of the targets.
>> >>=20
>> >> E.g, triggering a cross-build of bpftool:
>> >>=20
>> >>   cd tools/bpf/bpftool
>> >>   make ARCH=3Driscv CROSS_COMPILE=3Driscv64-linux-gnu- LLVM=3D1
>> >>=20
>> >> would report the host's, and not the target's features.
>> >>=20
>> >> Correct the issue by passing the CLANG_CROSS_FLAGS variable to the
>> >> feature detection makefile.
>> >>=20
>> >> Fixes: cebdb7374577 ("tools: Help cross-building with clang")
>> >> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>> >
>> > Acked-by: Jiri Olsa <jolsa@kernel.org>
>>=20
>> Waking up the dead!
>>=20
>> Arnaldo, Jean-Philippe: I'm still stung by what this patch fixes. LMK
>> what you need from me/this patch to pick it up.
>
> I guess the problem is these files don't have a specific tree. Since you
> mention BPF maybe it should go through the BPF tree, in which case you
> could resend to the tools/bpf maintainers (and "PATCH bpf" subject prefix)
>
> FWIW the change looks good to me:
>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Thanks for the review. Yes, maybe it's a orphan files issue! It does
seem a bit weird to route it via BPF, since it's just a regular
cross-build fix -- Not directly related to BPF. Regardless; I'll do a
respin targetted at *some* tree. ;-)


Bj=C3=B6rn


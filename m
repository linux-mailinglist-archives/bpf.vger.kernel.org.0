Return-Path: <bpf+bounces-49522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D506A1985B
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 19:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C7C57A0FBB
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 18:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB6421516F;
	Wed, 22 Jan 2025 18:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="A1sKEkyi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD735185B62
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 18:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737570137; cv=none; b=UrZaT8BN4JnlUjcp9H0mXTAsQ8+CrUOoGdkzRZlZ3tFrMj8dSFfg5RxL165LvRrsVmi++MP2HyLVDiZCD82Y34fYX3hNuZ1hXocgIXMZ3FYY6S8qlOrgisoySmADYMfLWRGkXx0Fqgb7mxrl1Bo/6KLBV26Ka8QnYa+pXrUy8hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737570137; c=relaxed/simple;
	bh=tu5wAKtXqfhK3F/IrfrjtHZEd9ZHX9mz0jL2LcbalEs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MciZS79YoOBYJICK+XjlpeLUe6GFtJQRypwz04U4ADWXgCqhh/KCLeg8Gu/QOU4YHHAGoqSuWO16OeWqzFi2ggu1CQwIXGujiJrX2G0ggZCNZ8qDBmGzVS3Vb1vX8adq/4ToqXtIIoWbBzzDYhxkppX7ntn+HlUwo9FRIu4mcKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=A1sKEkyi; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1737570132; x=1737829332;
	bh=tu5wAKtXqfhK3F/IrfrjtHZEd9ZHX9mz0jL2LcbalEs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=A1sKEkyihHfKytcPAcAlG11fD5OD27QzDyhcMcqKL7xDtLIIqdeI1mRWIv9cRpf4o
	 NZJqhwM1bt4WwmQllxnJ58PZC5qfTg66rRLw6lcil6Rc7inJ6PkfVEhnXwqbxeyB8D
	 18QrD2inX6YH0VId5wkq41OSlvoWCswT/ZGMt5SZV6h4nR1CawwsBPdVnzZ5kFrkeG
	 4LrJ9oBub39/Npx5uvUoH7j0Ob00sNxmmMvENSLzG3kMKGksZoTMZ77ZfahB8IiaNq
	 2My4Xd9TRNXrC2YFt7F7Rg6A4alJaJltdxUEIDqLYgAGUimmGItk0tEGbnVTI04sy/
	 usExUppZmMQlA==
Date: Wed, 22 Jan 2025 18:22:09 +0000
To: Alan Maguire <alan.maguire@oracle.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com, jose.marchesi@oracle.com
Subject: Re: [PATCH bpf-next 1/5] libbpf: introduce kflag for type_tags and decl_tags in BTF
Message-ID: <eUQJKkT5tEbm9FCNgth5quYCwp802fwpJOdXAbcGraMDHHF2TlNLMyGRHuGU7KkqEg8Ks7Zs3hUbQ_3JGe7ITHHBvEd2Y9hACxwjCYFSJiM=@pm.me>
In-Reply-To: <3e7404bb-b96e-4dc5-877b-d6a49273973b@oracle.com>
References: <20250122025308.2717553-1-ihor.solodrai@pm.me> <20250122025308.2717553-2-ihor.solodrai@pm.me> <3e7404bb-b96e-4dc5-877b-d6a49273973b@oracle.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 94329bee7c105fb857f3f62e630c2d7e00b2742b
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wednesday, January 22nd, 2025 at 2:56 AM, Alan Maguire <alan.maguire@ora=
cle.com> wrote:

>=20
>=20
> On 22/01/2025 02:53, Ihor Solodrai wrote:
>=20
> > Add the following functions to libbpf API:
> > * btf__add_type_attr()
> > * btf__add_decl_attr()
> >=20
> > These functions allow to add to BTF the type tags and decl tags with
> > info->kflag set to 1. The kflag indicates that the tag directly
> > encodes an attribute and not a normal tag.
> >=20
> > See Documentation/bpf/btf.rst changes for details on the semantics.
> >=20
> > Suggested-by: Andrii Nakryiko andrii@kernel.org
> > Signed-off-by: Ihor Solodrai ihor.solodrai@pm.me
>=20
>=20
> need to sync include/uapi/linux/btf.h with
> tools/include/uapi/linux/btf.h, but other than that
>=20
> Reviewed-by: Alan Maguire alan.maguire@oracle.com

I haven't realized btf.h is copied in two places.
Will fix, thanks.

>=20
> [...]


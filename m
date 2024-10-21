Return-Path: <bpf+bounces-42672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F5D9A8FE5
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 21:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77FEA283B74
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 19:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42AC1FBF76;
	Mon, 21 Oct 2024 19:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jytzcSwR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC671FBF5C
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 19:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729539201; cv=none; b=CqupM43vEQz1xoujCAFyyNM8NwvWi8foiLSXu1OT6TVYqw9ukbfb7F7rsVZ8enci+LGYZ5Vh1z59s9sNLDHA9XqxDWuHXSX9Mom2FqcpsNHbmXSQJGlmTbaLSN2oLN9wOjCC98QtQEJ3ASNXAOjyfQfTRej6VQSVUDfN9RxZ0SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729539201; c=relaxed/simple;
	bh=WYUvq4+M/P7zce4EpzCzLba5NZv+3tl1ba0OwmX3ESE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ivOWtE63Tar3qhULrGDSc1BPOdVHVCtXqq7avi/ZpHDvgg23CpyBaMCCkV7UO5+n0nXTVUlbi4PNwX4Xfx55Nbg0F71t4kYjVj+jguupWBGqwHgMSjnTFohO97KF3XLdWQS69yjU54Z6Aq1xN6yVIwvf0AMb3fb/hJ/pacLZmvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jytzcSwR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64059C4CEC3;
	Mon, 21 Oct 2024 19:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729539198;
	bh=WYUvq4+M/P7zce4EpzCzLba5NZv+3tl1ba0OwmX3ESE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=jytzcSwRc6jG7wRsBJDbl7VUOvNKHKJYh0Q2BJABujXo9TCn9vISva9iODu+q3n+s
	 qW1C9G78Krm496Zzm0adV+/i46IwC9oSXL9GjUPpf+CfYPxx6XznazM5voc17W+8La
	 DJaLakSsph9Tq4hJaJboXRr5KGtho4yxM1BQBlSOQVUiCJhRDkFXMY+yPMy5YxMTm3
	 gxKOUu40xcbCjO6Do69Cn8L2c7wZMVz7ccrzkmmE2rUPizKBg3zK5m/clVjYGSnLfd
	 CSv/JrZtdmBdO0d9rey3pDd2r9NzWfJj4Jhy9y5z+XH7jLGJE4pVlU8CoNmIrMFGiT
	 780TkP4QLpi/A==
From: Puranjay Mohan <puranjay@kernel.org>
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>
Subject: Re: [PATCH bpf] bpf, arm64: Fix stack frame construction for
 struct_ops trampoline
In-Reply-To: <20241019092709.128359-1-xukuohai@huaweicloud.com>
References: <20241019092709.128359-1-xukuohai@huaweicloud.com>
Date: Mon, 21 Oct 2024 19:32:48 +0000
Message-ID: <mb61ped49tfof.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Xu Kuohai <xukuohai@huaweicloud.com> writes:

> From: Xu Kuohai <xukuohai@huawei.com>
>
> The callsite layout for arm64 fentry is:
>
> mov x9, lr
> nop
>
> When a bpf prog is attached, the nop instruction is patched to a call
> to bpf trampoline:
>
> mov x9, lr
> bl <bpf trampoline>
>
> This passes two return addresses to bpf trampoline: the return address
> for the traced function/prog, stored in x9, and the return address for
> the bpf trampoline, stored in lr. To ensure stacktrace works properly,
> the bpf trampoline constructs two fake function stack frames using x9
> and lr.
>
> However, struct_ops progs are used as function callbacks and are invoked
> directly, without x9 being set as the fentry callsite does. Therefore,
> only one stack frame should be constructed using lr for struct_ops.
>
> Fixes: efc9909fdce0 ("bpf, arm64: Add bpf trampoline for arm64")
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>

Tested-by: Puranjay Mohan <puranjay@kernel.org>

Thanks,
Puranjay

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIoEARYKADIWIQQ3wHGvVs/5bdl78BKwwPkjG3B2nQUCZxasYRQccHVyYW5qYXlA
a2VybmVsLm9yZwAKCRCwwPkjG3B2nUh7AQC2H7MH73JWY+k4caiIVVmlb8l39jDH
EJ2P5toCncJrqgD+Kzhb4XrubHzyTDJfmnXW6Owi3Qupk12E9yqaGhuwyA4=
=nnrP
-----END PGP SIGNATURE-----
--=-=-=--


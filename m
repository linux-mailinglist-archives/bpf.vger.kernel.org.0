Return-Path: <bpf+bounces-42586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 681889A5F03
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 10:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2984D2814A4
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 08:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626911E2614;
	Mon, 21 Oct 2024 08:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPh3uqZ3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DC1200CD
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 08:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729500319; cv=none; b=CDNuB/ChMFyuxyr+nlj3GTHfqvvxRXx8ylNq9aG1ZChXHmTIVjjBxt/FWh1hp8VY3tAI8jBwhyBrduktVJJAuavqUvt1pVUMLf03R5wTtUHobBpj8EbjU0y4t7PGhjmpqaK/OTdtIwQctCCE6mba1QFmzKDvqKdDKrSQ19/A1yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729500319; c=relaxed/simple;
	bh=5FzE/0BLnnxuZ1FYPWCfLYlRYhMxhNmkZxMdynZNq+o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cCwZ4+YuF69xtpPfWn+uRmxj+0sKfnKk9gIGJ38e87JsR32h3/OQgNoQtOu1qhZPGOPpw6p+lX3HGzPIPhydX9vnzObUWPwJN4vgeo65JLn+8EJ3PnjvSPaXbgGI30gJ4MbCRYECMEyrvCMJKM7RPHEN10bS+GjSftVMIV2axNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPh3uqZ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C771C4CEC3;
	Mon, 21 Oct 2024 08:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729500319;
	bh=5FzE/0BLnnxuZ1FYPWCfLYlRYhMxhNmkZxMdynZNq+o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=jPh3uqZ3ccNy38q2S22/20N/t558HrYwek3angjZKspOU0j/JPH8TEFdFf5AXPt3v
	 fFVAIwDKVsxuzuVLk/uQ8SQAyOA8uATkHnMShNnR5fMgFg7Y7j2qtWClAyt8Ekp1EM
	 oJp6b97ahilC+WkO7LvCIz+GJpqE3TaFvHij+DS38VYFw4h4veFJYdeE0gjvCCQmC5
	 j/dBbCmL0LqJB4uc4+TPDREaT/pdjvGnNI5xHVOZRxpU1r33w0CUfnSdpO8BI/H6CI
	 tLvUZlWZ5XzimXmPBhjqIxwFqB4udyqxjgwhhF9swgnEavuxhvHkQ4kq6lw1Y/j3b7
	 jmBVNPJ/6ynFw==
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
Date: Mon, 21 Oct 2024 08:44:59 +0000
Message-ID: <mb61pjze1u9o4.fsf@kernel.org>
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

Acked-by: Puranjay Mohan <puranjay@kernel.org>

> ---
>  arch/arm64/net/bpf_jit_comp.c | 47 +++++++++++++++++++++++------------
>  1 file changed, 31 insertions(+), 16 deletions(-)
>

[...]

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIoEARYKADIWIQQ3wHGvVs/5bdl78BKwwPkjG3B2nQUCZxYUjBQccHVyYW5qYXlA
a2VybmVsLm9yZwAKCRCwwPkjG3B2nTzqAQCheSKtCWZA+DUPWWXtvx+SnjkUNgt4
hIaoB/Vmo+wnHAEAhU0kVtv6kTodVwpkWTJXSnVvkLnPl+M5AQKDCVxh+QA=
=0hsB
-----END PGP SIGNATURE-----
--=-=-=--


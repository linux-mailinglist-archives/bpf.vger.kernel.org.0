Return-Path: <bpf+bounces-52907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 452B7A4A318
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 20:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA3DA7A3761
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 19:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA25230BE5;
	Fri, 28 Feb 2025 19:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aj14BI2S"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAFB1B87FB
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 19:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772389; cv=none; b=igsIN0VytTG1+oBkBWqUdgHYC4t5rQCZyT5I9SkOry+1kgGZIacfhF3mzW3ESxf18Tsc/dFsuAabPRA3IL6HzvxK5TKDwoDXs+DJSFlN9dhqgyEfjGT8+/S2nD6KroeOhQ8whNlHFv0bdPo4m4O8HWXxwb+aHlOhYOtmp6mIISI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772389; c=relaxed/simple;
	bh=EcsZpfGSPX/X9HBka4cd3H7PGSNQLBokC3svgTbthC0=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=PrJlFiYLcieNiuZ7y6EpedRowV6T1QvHcePYna+oDSh04h1sglUQS3SMQ4b26qB/bJ8tnQ4cdSEeK8SRVfHwFxYRrgEb7gtUvA9plUuq+rAAEa3qg63sTGnM/+gAMM70Yc/tyDvNupZlsfoH9DAfFZZ4xMWegXPmAVT91lyrPe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aj14BI2S; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740772385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/7Wwe498qsEAnlbwQpLpWflELriewcuLcBq0HraIf3k=;
	b=aj14BI2SsGLjfilBNOPl0UI3kt9KeT6QLAHn1XEwu5HJ02H+3EYXwpp1G8Tc8FiFEvJJYa
	rsQt1hd5rD+DAmzAx4w3FzXcQIpiQ75J1LjTB9WK1nJajXA+COrByCcvqwgXOJwzZ+gpKW
	6rJ8KRYq6Det1Q8NghokqTND58kyeBc=
Date: Fri, 28 Feb 2025 19:53:04 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <050b81d2c82f57f3e97b27c59198a08b1c8d7f7b@linux.dev>
TLS-Required: No
Subject: Re: [PATCH dwarves v4 2/6] btf_encoder: use __weak declarations of
 version-dependent libbpf API
To: dwarves@vger.kernel.org, bpf@vger.kernel.org
Cc: acme@kernel.org, alan.maguire@oracle.com, ast@kernel.org,
 andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com,
 kernel-team@meta.com
In-Reply-To: <20250228194654.1022535-3-ihor.solodrai@linux.dev>
References: <20250228194654.1022535-1-ihor.solodrai@linux.dev>
 <20250228194654.1022535-3-ihor.solodrai@linux.dev>
X-Migadu-Flow: FLOW_OUT

On 2/28/25 11:46 AM, Ihor Solodrai wrote:
> Instead of compile-time checks for libbpf version, use __weak
> declarations of the required API functions and do runtime checks at
> the call sites. This will help with compatibility when libbpf is
> dynamically linked to pahole [1].
>
> [1] https://lore.kernel.org/dwarves/deff78f8-1f99-4c79-a302-cff8dce4d80=
3@oracle.com/
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  btf_encoder.c | 48 +++++++++++++++++++-----------------------------
>  dwarves.h     | 11 ++++++++++-
>  pahole.c      |  2 --
>  3 files changed, 29 insertions(+), 32 deletions(-)
>
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 2bea5ee..12a040f 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -34,6 +34,7 @@
>  #include <search.h> /* for tsearch(), tfind() and tdestroy() */
>  #include <pthread.h>
>=20=20
>=20+#define BTF_BASE_ELF_SEC	".BTF.base"
>  #define BTF_IDS_SECTION		".BTF_ids"
>  #define BTF_ID_FUNC_PFX		"__BTF_ID__func__"
>  #define BTF_ID_SET8_PFX		"__BTF_ID__set8__"
> @@ -625,29 +626,6 @@ static int32_t btf_encoder__add_struct(struct btf_=
encoder *encoder, uint8_t kind
>  	return id;
>  }
>=20=20
>=20-#if LIBBPF_MAJOR_VERSION < 1

There is an identical condition in btf_loader.c, however it guards
static functions, for example btf_enum64(). I decided to leave it as
is, although I find it unlikely that someone would use libbpf < 1.0.

> [...]


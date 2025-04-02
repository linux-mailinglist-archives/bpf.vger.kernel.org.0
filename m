Return-Path: <bpf+bounces-55192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF25AA798C2
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 01:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFC7616868F
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 23:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6FC1F8EEC;
	Wed,  2 Apr 2025 23:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jECkKzbF"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3CC1F8758
	for <bpf@vger.kernel.org>; Wed,  2 Apr 2025 23:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743636178; cv=none; b=LGepkNckpk9dYp2yNTfP182lbBqzotFZq/a1Mg1napjx1WkZNLg/MoO4ZivC+Xrc+4dcMVmMxGRU31/UUf2mgFbuH+zQeQ3HVE11RJ3gaVZMd+ZUwalWwsSGd9LqyLD1Scbn9J8XnBQowM0BAdpFibQ7EuDoE4uf7tBH3JZElMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743636178; c=relaxed/simple;
	bh=isyr4ncjJ3SBQdCYaGRbOfH6r2m2rRrczv7I3ZV6osM=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=Gn0z47WHvDcpgeVRNnl6Hc6a4LwdK72XHE4nl8kQMKH9uji1ooUrYnTm89T+m6LQxyD7G8z4JGTpn1nJ4wufXbsrvEoZfb2WO3oyh8uASyuA/KjrpmjaaqDAI8hYVp/2IqjXLI2bxSewbfERcfYYEUDncIbvxVbCazSVsH2P6DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jECkKzbF; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743636163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BgIONT4wQ07PU/U45BKCs+rhhpDdreAs5X6DXIqqC7s=;
	b=jECkKzbF7VtWW+p4Bf3+Ad355Jx6/OMGR69l1+WuJQZCwI4FmbAbxxYMayi9Sn5105D8R4
	Zf+VFF5NYyVpLTCI95DGF3nhrrFKTuBTULHqQ/LLUWTnZeumggji2vauwm7/+bLWoOJ7R4
	4WSVuC4Odiq2UFFOHiRTcoGnXS4XbHg=
Date: Wed, 02 Apr 2025 23:22:40 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <6acbc2347a86153c2646a4bfebaa226e9b0e01f7@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] scripts/sorttable: Fix endianness handling in build-time
 mcount sort
To: "Vasily Gorbik" <gor@linux.ibm.com>, "Steven Rostedt"
 <rostedt@goodmis.org>
Cc: "Masami Hiramatsu" <mhiramat@kernel.org>, "Catalin Marinas"
 <catalin.marinas@arm.com>, "Nathan Chancellor" <nathan@kernel.org>, "Ilya
 Leoshkevich" <iii@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <patch.git-dca31444b0f1.your-ad-here.call-01743554658-ext-8692@work.hours>
References: <patch.git-dca31444b0f1.your-ad-here.call-01743554658-ext-8692@work.hours>
X-Migadu-Flow: FLOW_OUT

On 4/1/25 6:15 PM, Vasily Gorbik wrote:
> Kernel cross-compilation with BUILDTIME_MCOUNT_SORT produces zeroed
> mcount values if the build-host endianness does not match the ELF
> file endianness.
>
> The mcount values array is converted from ELF file
> endianness to build-host endianness during initialization in
> fill_relocs()/fill_addrs(). Avoid extra conversion of these values duri=
ng
> weak-function zeroing; otherwise, they do not match nm-parsed addresses
> and all mcount values are zeroed out.
>
> Fixes: ef378c3b8233 ("scripts/sorttable: Zero out weak functions in mco=
unt_loc table")
> Reported-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Reported-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> Closes: https://lore.kernel.org/all/your-ad-here.call-01743522822-ext-4=
975@work.hours/
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> ---
>  scripts/sorttable.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/sorttable.c b/scripts/sorttable.c
> index 7b4b3714b1af..deed676bfe38 100644
> --- a/scripts/sorttable.c
> +++ b/scripts/sorttable.c
> @@ -857,7 +857,7 @@ static void *sort_mcount_loc(void *arg)
>  		for (void *ptr =3D vals; ptr < vals + size; ptr +=3D long_size) {
>  			uint64_t key;
>=20=20
>=20-			key =3D long_size =3D=3D 4 ? r((uint32_t *)ptr) : r8((uint64_t *)=
ptr);
> +			key =3D long_size =3D=3D 4 ? *(uint32_t *)ptr : *(uint64_t *)ptr;
>  			if (!find_func(key)) {
>  				if (long_size =3D=3D 4)
>  					*(uint32_t *)ptr =3D 0;

Hi Vasily,

I can confirm that this patch fixes BPF selftests on s390x:
https://github.com/kernel-patches/vmtest/actions/runs/14231181710

Tested-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Thank you!


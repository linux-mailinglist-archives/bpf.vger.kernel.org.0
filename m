Return-Path: <bpf+bounces-75692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B95EC916F7
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 10:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7C683A373A
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 09:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8283302143;
	Fri, 28 Nov 2025 09:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MqvcNskt"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BC22D0C98
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 09:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764322003; cv=none; b=bSnMoEOtQbqNRZEvjHjJQNn7tJEqX52lA2i+bTyPwNvfTYaU6TZngOeVxtsU47IjkT/q8qjPe7bPAl+i+0kv8ldKc9wTLijsw7Rqhe6SBJqhVjupg34s1mnCoBWska4yeaOQqpZhWlhnZuhCIBoBC6oRvRqxYEKLWHUHh2ooj1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764322003; c=relaxed/simple;
	bh=cjxlpTgC0FgazlbSlTyQ931rDr2BaJvfvakEpzfHmEs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QuinhI5QAszKopFH+a6l44k2Aui3Kg1qqR8Vab2FeH8vBtv7AZf+ppvn38YggsE4d9+nm8mLHFrQaa/bhWvyWsC9XCb/AdF2DS6VLFuTJUE5QP35y4OdhAz4ewvleGg260eqLX/yOrHgSTW6vNOgjEMtY4oY8lh+/Or/JAmTQ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MqvcNskt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764322000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O8CQlyZzp285FE1BOOE/nbwVCoNW66iOkRVieViPZi0=;
	b=MqvcNskt0jaH2hiX98v4lvfI3bKkoeQ7OVPK6920zB0+jiLes/ao2R2n79rj9lKDmsX5oF
	eZbRRZiU+iBgbFqJ25xuJZ2NPhVZKKNeX/8sOq9CUAkExCCETo0r0+LTHhD3Jh7L1zfTU5
	4vGewvNsfCSO4yFuTihLS6SHKkEu7pc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-581AT-7dN0OGEg-V5LFgFQ-1; Fri,
 28 Nov 2025 04:26:38 -0500
X-MC-Unique: 581AT-7dN0OGEg-V5LFgFQ-1
X-Mimecast-MFC-AGG-ID: 581AT-7dN0OGEg-V5LFgFQ_1764321997
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC7B5180028A;
	Fri, 28 Nov 2025 09:26:36 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.2.16.49])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D0D71800451;
	Fri, 28 Nov 2025 09:26:34 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: bpf@vger.kernel.org,  andrii@kernel.org,  ast@kernel.org,
  daniel@iogearbox.net,  netdev@vger.kernel.org
Subject: Re: [PATCH] tools/lib/bpf: fix -Wdiscarded-qualifiers under C23
In-Reply-To: <20251128002205.1167572-1-mikhail.v.gavrilov@gmail.com> (Mikhail
	Gavrilov's message of "Fri, 28 Nov 2025 05:22:05 +0500")
References: <20251128002205.1167572-1-mikhail.v.gavrilov@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Fri, 28 Nov 2025 10:26:31 +0100
Message-ID: <lhuecpi8q48.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

* Mikhail Gavrilov:

> glibc =E2=89=A5 2.42 (GCC 15) defaults to -std=3Dgnu23, which promotes
> -Wdiscarded-qualifiers to an error in the default hardening flags
> of Fedora Rawhide, Arch Linux, openSUSE Tumbleweed, Gentoo, etc.
>
> In C23, strstr() and strchr() return "const char *" in most cases,
> making implicit casts from const to non-const invalid.
>
> This breaks the build of tools/bpf/resolve_btfids on pristine
> upstream kernel when using GCC 15 + glibc 2.42+.
>
> Fix the three remaining instances with explicit casts.
>
> No functional changes.
>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2417601
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index dd3b2f57082d..dd11feef3adf 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8247,7 +8247,7 @@ static int kallsyms_cb(unsigned long long sym_addr,=
 char sym_type,
>  	struct extern_desc *ext;
>  	char *res;
>=20=20
> -	res =3D strstr(sym_name, ".llvm.");
> +	res =3D (char *)strstr(sym_name, ".llvm.");
>  	if (sym_type =3D=3D 'd' && res)
>  		ext =3D find_extern_by_name_with_len(obj, sym_name, res - sym_name);
>  	else
> @@ -11576,7 +11576,7 @@ static int avail_kallsyms_cb(unsigned long long s=
ym_addr, char sym_type,
>  		 */
>  		char sym_trim[256], *psym_trim =3D sym_trim, *sym_sfx;
>=20=20
> -		if (!(sym_sfx =3D strstr(sym_name, ".llvm.")))
> +		if (!(sym_sfx =3D (char *)strstr(sym_name, ".llvm.")))
>  			return 0;
>=20=20
>  		/* psym_trim vs sym_trim dance is done to avoid pointer vs array
> @@ -12164,7 +12164,7 @@ static int resolve_full_path(const char *file, ch=
ar *result, size_t result_sz)
>=20=20
>  			if (s[0] =3D=3D ':')
>  				s++;
> -			next_path =3D strchr(s, ':');
> +			next_path =3D (char *)strchr(s, ':');
>  			seg_len =3D next_path ? next_path - s : strlen(s);
>  			if (!seg_len)
>  				continue;

I think you should change the type of the relevant variables to const
char *.  The kernel coding style does not disallow using const, does it?

Thanks,
Florian



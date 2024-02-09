Return-Path: <bpf+bounces-21658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B53884FF50
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 22:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FCB81C22544
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 21:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514F121345;
	Fri,  9 Feb 2024 21:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhtswKwt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C611805F;
	Fri,  9 Feb 2024 21:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707515970; cv=none; b=TvjfGFGEdG7y7meMmV47Yka/O5pYqtnd5oSB4BMyUh/hBJ/ZLGjbXEkGOp8bieDmoM2+z8sIjcHASpZ2/GcCDSZQSO03wwXaRtfQ5EvsqHCfn44AvSGu6jsXkPy+th9wizMVa5/fW8tiET0+rYekjYTi789KrwK8IVAdom1BBfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707515970; c=relaxed/simple;
	bh=RXhRagBEmxcAWAdk66koZjCY6GUUlZi4pspGJ5Vbzp0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qI9AstF2EGvhe7d5nKt5LUHhBdQce7iSwBIXnxi7rxRBQ4GYqtK4BmyrXfcH37ccs4fYJL4nZOZkotP2urV5wQzngEwOmJzrsbjNFCQGblA/MDnh4ZDGUfQqspp4LZZcsUv+BB9XKJdbBMwys34+KqYV+RGiZmvGwibL1EHhnx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhtswKwt; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-42c3a75c172so9837071cf.2;
        Fri, 09 Feb 2024 13:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707515968; x=1708120768; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tK7fVyjGu887guJVNi6Q/bCg6d8p04V5VmJM+r28A38=;
        b=DhtswKwtYO0LXYOufodEYSyCt0QgP9dKpvunDL9U0bCJriOj29vtsRgBktmnY7bxaH
         zaeoQCMwBHQv1u/hnaiiylOf0qOWOqPjOh4g96GD1Y9/lhJzSwdw16YuKRYj2YLCxJVA
         R8EurnRbRFqFcPPASdZ1flEq7IMx5zFJUnJe2/UXS5YrwRkGU8uJ9mvW5ut2en0bPayR
         1ZRvHyPturrRGYNBbB/ASaQNa/0xmQRdkewJX1+MsNh1GyaNJdN1IKOIQ3eYohJSHaKx
         GcIBrChKdERm8chT4C07ANyeVB9xTRVhmMb+rWUW1qNulbnOJX1j2h6200J2lrMGsZtb
         E0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707515968; x=1708120768;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tK7fVyjGu887guJVNi6Q/bCg6d8p04V5VmJM+r28A38=;
        b=vzPNJBL2yuXsaM1xMrDtWQJ+HNrGcYXDpbawup34zD5U2G0CLOiwkwltAiaCxBqsmV
         MCzrpNxdM70JSn458UGwgEarBXlOyKaOygEr4TbV+dCvYk5LX0FminG6i1EaAtgBpNSv
         sfC+cTr/Ofhm9NqCXXmDap4rjuMxl6uuwU0azPoeHbQ3kjFRKrxKy4sA05/Qo4JGK+jn
         0il4wt6M8DwUyyTXX3f72gb8FzDXRP7WVh3O/3nh7tP6fe5hQQZ8nnhISFTVa8SNAImJ
         sKKHsY/5xoSzGSzKVCaTojn6qK37Opy++XkXA3uH9LYNbwMs3ZwS/gFRhsV15PZqXGIM
         TM5A==
X-Forwarded-Encrypted: i=1; AJvYcCU3jvPLuI/kF2kQ5peosGDaspJPHGbd0JbBfqEwKf4MJATqX3AYa67AUap7T5SFp6fSQZfPA01UPyJNVQBveuo40C3bpPuxnXdUQdoL
X-Gm-Message-State: AOJu0YwwHod4fl36efOmbsED5SMs+wJf60ME8P0vDUkQNSbXlUJJ5Zft
	y4TFLckxlELNXQvNtwPlLjugQrO8acq3VAh6g16KeTKkFYQOgqR6
X-Google-Smtp-Source: AGHT+IH/X5qewuwE5hTAVtdoV6q2wL9qUEHsL8ep/L5fZ2BFYrFJw20FXx+8c62p93twGhLif6X6Cg==
X-Received: by 2002:a05:622a:c5:b0:42b:f341:f8aa with SMTP id p5-20020a05622a00c500b0042bf341f8aamr526958qtw.21.1707515968168;
        Fri, 09 Feb 2024 13:59:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWBTjDRx0bT3Hl1WGYI6wh7E2pWW1vYwr/pfl1HubkoXVFu5A3Axd32R9owUk2XXfS9WZC78Zvr4B7Qb4QpvYT8qbNTAj1jyYn/xA4uF8hihQsr+HmwEabF2aFLl9XGQrYMmXdatxS+1UMvKxVaxq242JwOC9YYJcgPU8J2XWz9WH0Dewk9XMAbp0Dkp7w5oWTPyOjbGppty4yO1XmSxq0AYs3b7AYRpc97M8lharxigznuhUXnMhGv/cF3nhtDdf+oYEIjlHsmoHKw0gJWYsEx5v+HmBV5/felWmOE38jwJq+i1bxsD4+0LFR1RXneONTpzUHPY7A24Gkhk7ifWT50ShlUo+O0FLhewVUXb8qvzbhQ1vXkSdqiJvBAAprByms4DCgqsP056S73K5uB
Received: from localhost ([2601:8c:502:14f0:acdd:1182:de4a:7f88])
        by smtp.gmail.com with ESMTPSA id f11-20020ac8470b000000b0042ab72fd47esm1039844qtp.34.2024.02.09.13.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:59:27 -0800 (PST)
Date: Fri, 9 Feb 2024 11:59:25 -0500
From: Oliver Crumrine <ozlinuxc@gmail.com>
To: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, sinquersw@gmail.com
Subject: [PATCH v2] net: remove check in __cgroup_bpf_run_filter_skb
Message-ID: <adwssgplvtrgagjw5ftcc5ogpq2nz4pp722wzn3yt2jnql6odf@peiwrqaoyil2>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="adabdr3lq45rmeih"
Content-Disposition: inline


--adabdr3lq45rmeih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Originally, this patch removed a redundant check in
BPF_CGROUP_RUN_PROG_INET_EGRESS, as the check was already being done in
the function it called, __cgroup_bpf_run_filter_skb. For v2, it was
reccomended that I remove the check from __cgroup_bpf_run_filter_skb,
and add the checks to the other macro that calls that function,
BPF_CGROUP_RUN_PROG_INET_INGRESS.

To sum it up, checking that the socket exists and that it is a full
socket is now part of both macros BPF_CGROUP_RUN_PROG_INET_EGRESS and
BPF_CGROUP_RUN_PROG_INET_INGRESS, and it is no longer part of the
function they call, __cgroup_bpf_run_filter_skb.

Signed-off-by: Oliver Crumrine <ozlinuxc@gmail.com>

v1->v2: Addressed feedback about where check should be removed.

---
 include/linux/bpf-cgroup.h | 7 ++++---
 kernel/bpf/cgroup.c        | 3 ---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index a789266feac3..b28dc0ff4218 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -195,10 +195,11 @@ static inline bool cgroup_bpf_sock_enabled(struct soc=
k *sk,
 #define BPF_CGROUP_RUN_PROG_INET_INGRESS(sk, skb)			      \
 ({									      \
 	int __ret =3D 0;							      \
-	if (cgroup_bpf_enabled(CGROUP_INET_INGRESS) &&			      \
-	    cgroup_bpf_sock_enabled(sk, CGROUP_INET_INGRESS))		      \
+	if (cgroup_bpf_enabled(CGROUP_INET_INGRESS) &&			      \
+	    cgroup_bpf_sock_enabled(sk, CGROUP_INET_INGRESS) && sk &&	      \
+	    sk_fullsock(sk))						      \
 		__ret =3D __cgroup_bpf_run_filter_skb(sk, skb,		      \
-						    CGROUP_INET_INGRESS);     \
+						    CGROUP_INET_INGRESS);     \
 									      \
 	__ret;								      \
 })
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 491d20038cbe..644bfb39cf9d 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1364,9 +1364,6 @@ int __cgroup_bpf_run_filter_skb(struct sock *sk,
 	struct cgroup *cgrp;
 	int ret;
=20
-	if (!sk || !sk_fullsock(sk))
-		return 0;
-
 	if (sk->sk_family !=3D AF_INET && sk->sk_family !=3D AF_INET6)
 		return 0;
=20
--=20
2.43.0


--adabdr3lq45rmeih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE16z70XZtqMhb/BJHifZEXNYDnHAFAmXGWekACgkQifZEXNYD
nHDFsg/+LFfMdY0hV8/Lf6dT3g9oo2CJ78Flqg6d/Moe0kEEjcVwnFkfjxFwH//T
4Pw7Qvwq1YQ6MVqL/KAZHLUGiVQuQZEnzHtHwSYOgShdfesbDVq/ang3XfrST2ZQ
qlx6QqvCEYWpfjESgjWC6e7SNxoPuSkNrpWOJsZYvE9ZWCS3Ppc7V350EVKUmvTN
lKEwidgDSbZk2rZZKozpVhJya8vyUsJ5OXAkNfZWDetiN2syfEPXS49I/svaF3Jh
Lk4DUO6/6lDhcr4vQUnvZAb672HOPmqlRR5Mh9K/DX+0kkwWjw+l22SS1j4Iatkj
Z5ctMLPGXgKwV26TZeSzCJ/tEl4/tdsTUspQ1fky/G9JBGRGhx3tmusHSqZpKJjF
daBULbrYMNsrYoLAE8jk16JSOO3u4CYDJOGaFiKa7hyqPbduKI1D/7kKoKmUHTJB
3U3C5VFfQBulcf8wA+bH5hkbWz7+RC7YKhM1Orfb598pQOpdsX6ljf+EQxgO0hOd
siMb0T3HonoAnZEhtp77xqWrTxc9gWpTkfuyrjrk0r6I8BI4YBK9PqplhvCSu5eN
sXzIA2L5V6eKQ2+9vi2W5Ehpx9RZMvSplFewnXzdbZJvKeKZfAGE1kKzEMHxCE1I
WmDzzrv7B9LtCEhmqrpyvyTv0xcSQxj3p8wBBwvq8ninBuwEYWQ=
=qSMx
-----END PGP SIGNATURE-----

--adabdr3lq45rmeih--


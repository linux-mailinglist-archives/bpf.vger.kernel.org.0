Return-Path: <bpf+bounces-30090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6758CA7CC
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 08:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E76141C20BE6
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 06:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA527433C0;
	Tue, 21 May 2024 06:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DMIQhl5Y"
X-Original-To: bpf@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC8B7F;
	Tue, 21 May 2024 06:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716271383; cv=none; b=hUeGjgGYPkD+8EO0sYjyQ529suleXF4LUaVEFYIEnBcmuUPx+PCU8QQlB/dEOsUL0agPQQTHdJQHd85elc013kpLozn6ve/z4edDMIMNWMubSQuZNua1h5IWkpSHvg/4miAIL3oZrmU9fB4ridTCZ/RWK6kQvV42RoqNVXvl/2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716271383; c=relaxed/simple;
	bh=REIpe/tsZdnVcKXAJgaW3Cm7pKrMgd6soEuZTFKGyJE=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=gWTw+7nzEGTFKyl0ep/BgAIo6ofAiSn4DG800kgikRU8KtNlS4Uk1ESAyh/kpSow4vVJr5hvVA8Uxc5lcFaSPDXJIkhfnI+wq75a6Q3PTkldx/JQJqaiXq2A4T2J7NS80hcQ5rU6YMD04QZwTrY1Lp1A5unVh3n/4L31S3Eg4Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=DMIQhl5Y; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240521060251euoutp017901cb39dc50381b35b95a06dd1d4037~Ra7gk3pWL1236312363euoutp01R;
	Tue, 21 May 2024 06:02:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240521060251euoutp017901cb39dc50381b35b95a06dd1d4037~Ra7gk3pWL1236312363euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716271371;
	bh=lE6WJs8oCEQ7CTqKEXiYkNqhodYrOh5I7S0sTfqEK0U=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=DMIQhl5YnnCJZOtM4LPXsa3k1z3v9M0m3/R88cHWmqtWHFfgTGLbsW0E7DWScfenY
	 nPgNQNrwFU4OmYaLqTikUU9JGSq/8UMyxGmcqI4SNCRHC9Oxjjmjju4YbBsQ7sFukz
	 YsaxwVFjzcJtJMpWHfjEb4ChKW7tXoe9eW6qvPj0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240521060251eucas1p2432364034bbb322edcc56f5a79ce51ed~Ra7gW_YWf2617026170eucas1p2V;
	Tue, 21 May 2024 06:02:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id FC.FE.09624.B093C466; Tue, 21
	May 2024 07:02:51 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240521060250eucas1p215702fa50b4832b69071816982ef5721~Ra7fzcD5z0966409664eucas1p2H;
	Tue, 21 May 2024 06:02:50 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240521060250eusmtrp29eb31c409deb8d963f2095fdc12d2cea~Ra7fy0DyF3234432344eusmtrp2B;
	Tue, 21 May 2024 06:02:50 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-f0-664c390b425f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 61.A1.08810.A093C466; Tue, 21
	May 2024 07:02:50 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240521060250eusmtip1fc4e4d0c4500d9ce1e854e625b276327~Ra7feqPDG1533715337eusmtip1F;
	Tue, 21 May 2024 06:02:50 +0000 (GMT)
Received: from localhost (106.210.248.3) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 21 May 2024 07:02:49 +0100
Date: Tue, 21 May 2024 08:02:43 +0200
From: Joel Granados <j.granados@samsung.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Andrii
	Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong
	Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
	Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
	<jolsa@kernel.org>, <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] bpf: constify member bpf_sysctl_kern::table
Message-ID: <20240521060243.w2g57rrdjvi7biol@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="d6hc32oq7mipiuho"
Content-Disposition: inline
In-Reply-To: <20240518-sysctl-const-handler-bpf-v1-1-f0d7186743c1@weissschuh.net>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZduznOV1uS580g6ZtIhbff89mtvjy8za7
	xecjx9ksFi/8xmxxY8UMZotDx/ezWzTtWMFkcWTKLGaL5/t6mSwu75rDZvH7xzMmizWdK1kt
	bkx4ymhx6cdrFovjy/+yWTxYvY3VQcBj56y77B4LNpV6dN24xOyxaVUnm8fChqnMHp83yXn0
	dx9jD2CP4rJJSc3JLEst0rdL4Mp4OekCe8ExgYqDV16yNzDu4eti5OSQEDCROHvtGksXIxeH
	kMAKRon2X5uYIZwvjBJzp95hg3A+M0r8+tbODNNyqPUQE0RiOaPEnsV9CFW73/xghXA2M0r0
	L/oDVMbBwSKgKvF3oRBIN5uAjsT5N3fAJokI2Eis/PaZHaSeWWAui8Sc3jusIAlhAQeJp09m
	sIH08gLZ0zrUQcK8AoISJ2c+YQGxmQUqJF6smw5WwiwgLbH8HwdImFMgUOLXsZ1QhypKrDt/
	hQXCrpU4teUW2NESAq84JbYuWcwOkXCR2HP9P5QtLPHq+BYoW0bi/875UA2TGSX2//vADuGs
	ZpRY1viVCaLKWqLlyhOoDkeJd9/eg10kIcAnceOtIMShfBKTtk1nhgjzSnS0CUFUq0msvveG
	ZQKj8iwkr81C8toshNcgwnoSN6ZOwRTWlli28DUzhG0rsW7de5YFjOyrGMVTS4tz01OLDfNS
	y/WKE3OLS/PS9ZLzczcxAhPn6X/HP+1gnPvqo94hRiYOxkOMKkDNjzasvsAoxZKXn5eqJMK7
	aYtnmhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe1RT5VCGB9MSS1OzU1ILUIpgsEwenVAOT/zY+
	nS8fL2uemK+vnNV8U+lPpOy2T4sMnygtF5VfOLe6omjr68Ip06NdImy7K3cpGZkcqY/qmeVc
	w3VMNW7+o5eu1Y9XLqn0YEv3CnB68X9T6pruOV8uBIou0r8oFs62SL3ev/TeiR3XC/ev1/jf
	Lt7Svyx9wpnHtdL3SjusLx86mah1f2lG6AwHu4Mpdl+d0i13R/o8vbOPa2Ju6YkDcYtWHP2s
	cFTZ8XDtnstqK2ufuAac3vwmTPneGd/4vPyFHaK9z/OkrhXXyB7vNtOdw6eiEd63cZPfzKeu
	0489a1zz2O9ew7XFt+vKujLYLC51CFYGf7j8r0OXiS8/4NbUlI63l1oisg/15p6SfjRViaU4
	I9FQi7moOBEAp1q2kxcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsVy+t/xu7pclj5pBo9faFt8/z2b2eLLz9vs
	Fp+PHGezWLzwG7PFjRUzmC0OHd/PbtG0YwWTxZEps5gtnu/rZbK4vGsOm8XvH8+YLNZ0rmS1
	uDHhKaPFpR+vWSyOL//LZvFg9TZWBwGPnbPusnss2FTq0XXjErPHplWdbB4LG6Yye3zeJOfR
	332MPYA9Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8u
	QS9jS/sCtoIjAhVTv/WwNTDu4uti5OSQEDCRONR6iKmLkYtDSGApo8SDzt3MEAkZiY1frrJC
	2MISf651sUEUfWSU+Hr8CyOEs5lR4vH500BVHBwsAqoSfxcKgTSwCehInH9zB2yQiICNxMpv
	n9lB6pkF5rJIzH+4H2yqsICDxNMnM9hAenmB7Gkd6hAzlzBKnD2+DqyGV0BQ4uTMJywgNrNA
	mcSLn3/YQeqZBaQllv/jAAlzCgRK/Dq2E+poRYl156+wQNi1Ep//PmOcwCg8C8mkWUgmzUKY
	BBHWkdi59Q4bhrC2xLKFr5khbFuJdevesyxgZF/FKJJaWpybnltsqFecmFtcmpeul5yfu4kR
	mDy2Hfu5eQfjvFcf9Q4xMnEwHmJUAep8tGH1BUYplrz8vFQlEd5NWzzThHhTEiurUovy44tK
	c1KLDzGaAgNxIrOUaHI+MK3llcQbmhmYGpqYWRqYWpoZK4nzehZ0JAoJpCeWpGanphakFsH0
	MXFwSjUwrZ2zz+L3ce413zreuy7c8XLZ9UV7SixSLde1Vv9ZuHenRYnbNfHaN/0cM/81/nFz
	9nR5/Tt48uEerty11wPVLn010vloFmh9qGNdEO/JT/E8S7coF212Z117SO4t89zV79ukr00s
	fKh9Wc5u16O8EJvb20OZukW1JHWSneNWfpke8Ho2+/fHP2yKFs1oTpJLt8yZoXM88T37o5DA
	rxv3Bu/c3tfms2lF7aFrzcpbdmucu6a7YJbVkkOByxcxMemfOiEjaDV5fnUXU+XaReGz3lhW
	Cz4NbWBObmRzyvm0rLzev1WJs/nfu19TF7Gn2NjIl7/vVX9Uqv+GXZD73YXQZA7dyK1HM4/O
	felxNiSiTImlOCPRUIu5qDgRAI0ZxgSzAwAA
X-CMS-MailID: 20240521060250eucas1p215702fa50b4832b69071816982ef5721
X-Msg-Generator: CA
X-RootMTR: 20240518145935eucas1p160af103aca811919cc3f0b47626ed7ec
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240518145935eucas1p160af103aca811919cc3f0b47626ed7ec
References: <CGME20240518145935eucas1p160af103aca811919cc3f0b47626ed7ec@eucas1p1.samsung.com>
	<20240518-sysctl-const-handler-bpf-v1-1-f0d7186743c1@weissschuh.net>

--d6hc32oq7mipiuho
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 18, 2024 at 04:58:47PM +0200, Thomas Wei=DFschuh wrote:
> The sysctl core is preparing to only expose instances of
> struct ctl_table as "const".
> This will also affect the ctl_table argument of sysctl handlers,
> for which bpf_sysctl_kern::table is also used.
=2E..
> Cc: Joel Granados <j.granados@samsung.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  include/linux/filter.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 0f12cf01070e..b02aea291b7e 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1406,7 +1406,7 @@ struct bpf_sock_ops_kern {
> =20
>  struct bpf_sysctl_kern {
>  	struct ctl_table_header *head;
> -	struct ctl_table *table;
> +	const struct ctl_table *table;
>  	void *cur_val;
>  	size_t cur_len;
>  	void *new_val;
>=20
> ---
> base-commit: 4b377b4868ef17b040065bd468668c707d2477a5
> change-id: 20240511-sysctl-const-handler-bpf-bec93a18ac68
>=20
> Best regards,
> --=20
> Thomas Wei=DFschuh <linux@weissschuh.net>
>=20

Reviewed-by: Joel Granados <j.granados@samsung.com>

--=20

Joel Granados

--d6hc32oq7mipiuho
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmZMOQMACgkQupfNUreW
QU92cwv6A3Q54H1yWAu0kZl0kwaEfyuJ8P0cdishMdjgVnPLUhbT+lDcuom2KU0c
zgxj40U08H7GnVNorLYKKhSYqbNTRpJwgZ+59QRSFB/U4EEc+7IWKUhCyZO/ED1K
X5NND5rUJudBey0MsUrUqLfswzurzG4/44lG+wdxfVcYuPt6cBySW5YlA7jC5QZ7
OvB/TJJg2H1zN9tIsmfRdqw+cgkN/ifl7M+195+ivGP2Yn2PnvntG8qGDiaKmx6t
QiMkOUSrOn1p1q/gTVAq9IlN/q5mbAunmmSxK4npyK7pT8THp63/0ZSb5CJvepVF
EvpK/nEr8XHFJ5vN03uvcOOxB/oP1zNxfBAkR9swQ7Roa2M2fpUR/kEuZrXp5fst
2V1X0JBu4oaKBxg7YiJ+h8JMrwimld7BgZscrQRfRhfQdZNQhXrfyIlV2DENp6HX
8d6a4QoeDNyl4WQnhGQdExNnI+37iH2oRDhTPO55Wy8yxJOAW/TrSgeUxBTFPlD/
eQnplWZQ
=QnWQ
-----END PGP SIGNATURE-----

--d6hc32oq7mipiuho--


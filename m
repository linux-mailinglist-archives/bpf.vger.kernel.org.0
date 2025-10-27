Return-Path: <bpf+bounces-72363-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 40012C104A9
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 19:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 927F9351725
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 18:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97CF32C31A;
	Mon, 27 Oct 2025 18:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZXYyHHG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9FD3148B3
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 18:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761591194; cv=none; b=IOiOW0p30oSsftNJrPcJGD6hotdQP8a9DZCMh0Lvazt6/JzbFLI6imWHWeBeBSmoYDRp9SPuICcwPCVEf53dSONwAUTs1Jz/K4MSC22vWU2oAA0kK3Y1rd0ld4hL8dvq/eJVhZ4hXE+HjBh5g0jz2RAGDihSu7BOrYDYoYBt8Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761591194; c=relaxed/simple;
	bh=uYWfkFfWMFuAe2Polh5uAQSuKeFMWrimqTHBcKsd04w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y0l1MbNWSyVy2uvw3sULBzzSFMEdqiu6SHdc4PCI5dyHHbD/GLrCEvKwBG68/9YINtXQMy6zp6BORsuMd5FjFMMF4q+FL109zW+cjN7L5Dde5eg6RzRHgRqI44hI/sfvHOMfOk0d6BBNajJswGaEhKS4D3IXErJx9rbFYtMOv5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZXYyHHG; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7a27053843bso6962003b3a.1
        for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 11:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761591190; x=1762195990; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J4tHB7NOSCnXB8+sEigzrKdqRsFsCQn6iwgCfvvwoAU=;
        b=kZXYyHHGqREgySjogLQlpX19fLbt2VWCZWoVBfN9DkEWgOALXUsQUM7+baxVORPE1l
         Dftbt/gRLZDYqmGTFteDQmPf+kAVYTZUT+00QJ+BN4mmbMKpBcgGkurUO/0aapKjlxKt
         jf1ya/LAePufS+t5NuIRK6V1H4Zc7KHKMgoeSb5ttUL+r5iMZVIEGRrPjhDSkQMZeKlq
         AK4GK0yliNILJVtYvnv8d9pHsKsQ5qWo82AZ8Bkv68h5bcqjKOUwOP451/nnDARK//kO
         RPLalTEN19XsIipiUZClQeVXkETx3gQ+0cKXTyj0+cYHaKDPX3Z6wfZ2bqBjQMlWphSx
         w7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761591190; x=1762195990;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J4tHB7NOSCnXB8+sEigzrKdqRsFsCQn6iwgCfvvwoAU=;
        b=K6mf/C8CMNxLgHzp3Ql2faTTtGrB+PJidkTCngsoo/v+7Fky00zPg8GZanb+segDV0
         LwoUsbTliLTiylSHifC+mWQPsbPQfCG2TgU5gPYQ343xHfvMeeKA5DQ9Got8gEMMku1y
         2Fwli6QPpQygqKGu4sTe+kNYMeky+JKA+OBET/Es5vTnJj3gDnQj1ZzPqNEXpRdDa/e9
         QZnR6RcmSW3kO1UfEMhtk3DaSbTNXTCkvso8GcRfrAfD0hpwmGBFH3eki8INHMoVBiCS
         0t/IZh34IGiD/uwklr8A/EFT/fEPRG+pQjHxonghqEwil4kQ46CzGmaoKb11b2xS2xlO
         cuWw==
X-Forwarded-Encrypted: i=1; AJvYcCXh9lqhVUPpUDrArvjoMa4T97zIQ7vmX5IxL6Iklz59rTO/tAojUwZpRW439OfdYv2WdrY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6PyA1QCFSlZuPVeZBw8YpIkhdsSouajn86tO/+q49lNx1KiU5
	Wu8W4iysl/e2Pf9OFgqWNO2skg26IiPaanyRacO6GtAHTPODp2mAifIV
X-Gm-Gg: ASbGncspPD4TLM8crISA0cXWYwy7sUExmt4fIN+AnLZvo/JxcArllkJ+9LoPJTdyZdD
	Oz12cl01T7dYh0WTbCW4pBNdrWQPDbeAl2waDv5GROtxa2NRaw3RIesQZDIRnstZOLIBsDWt8xW
	YTAcRVHqo3ENPd+bQ5dAKaB46k1gFMCY+FJJUbHLnPRR0+uPgAfMOyXT9mZ12x3YJ884Hq0mDph
	OQwmpC5wJ736oEobl797yGMPeSHKH+GMFrDXqrnYYM974PZ6zn5I59it5VFX/D6HikSKafRUF5a
	yoPb4Qa3H7t5MpWY4TjjShEDSymxmR0XVdER1Q5EVpl/NGiw9VIojutsGcvEZQ2jYzIAYnSef0p
	alcYcFdz9CNHeobn0z98VTN25Ntu3VVczBJaFN+WBP290GRIJK+E8DQAYqL2K0DXR36oFTkpKkv
	ndb8rX0DPP
X-Google-Smtp-Source: AGHT+IE62kYfU7miIY/p/r6n7kxaGzZbtD6OocXxytketBIhvEjOLLaliRIhqTR042Zp2dIIYI9KgQ==
X-Received: by 2002:a05:6a20:1591:b0:342:6380:7ebd with SMTP id adf61e73a8af0-344d3d51341mr796441637.33.1761591190333;
        Mon, 27 Oct 2025 11:53:10 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b71268bdb2dsm8313722a12.5.2025.10.27.11.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 11:53:10 -0700 (PDT)
Message-ID: <c3f1b8ce39335ea0061a8b75a943f12638da6a9c.camel@gmail.com>
Subject: Re: [RFC PATCH v3 2/3] selftests/bpf: add tests for BTF type
 permutation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Andrii Nakryiko	
 <andrii.nakryiko@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Song
 Liu	 <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Date: Mon, 27 Oct 2025 11:53:07 -0700
In-Reply-To: <20251027135423.3098490-3-dolinux.peng@gmail.com>
References: <20251027135423.3098490-1-dolinux.peng@gmail.com>
	 <20251027135423.3098490-3-dolinux.peng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-27 at 21:54 +0800, Donglin Peng wrote:
> Verify that BTF type permutation functionality works correctly.
>=20
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Song Liu <song@kernel.org>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> ---

Do we need a test case for split btf?
We probably do, as there is index arithmetic etc.

[...]

> @@ -8022,6 +8026,72 @@ static struct btf_dedup_test dedup_tests[] =3D {
>  		BTF_STR_SEC("\0foo\0x\0y\0foo_ptr"),
>  	},
>  },
> +{
> +	.descr =3D "permute: func/func_param/struct/struct_member tags",
> +	.input =3D {
> +		.raw_types =3D {
> +			/* int */
> +			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
> +			/* void f(int a1, int a2) */
> +			BTF_FUNC_PROTO_ENC(0, 2),			/* [2] */
> +				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(1), 1),
> +				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(2), 1),
> +			BTF_FUNC_ENC(NAME_NTH(3), 2),			/* [3] */
> +			/* struct t {int m1; int m2;} */
> +			BTF_STRUCT_ENC(NAME_NTH(4), 2, 8),		/* [4] */
> +				BTF_MEMBER_ENC(NAME_NTH(5), 1, 0),
> +				BTF_MEMBER_ENC(NAME_NTH(6), 1, 32),
> +			/* tag -> f: tag1, tag2, tag3 */
> +			BTF_DECL_TAG_ENC(NAME_NTH(7), 3, -1),		/* [5] */
> +			BTF_DECL_TAG_ENC(NAME_NTH(8), 3, -1),		/* [6] */
> +			BTF_DECL_TAG_ENC(NAME_NTH(9), 3, -1),		/* [7] */
> +			/* tag -> f/a2: tag1, tag2, tag3 */
> +			BTF_DECL_TAG_ENC(NAME_NTH(7), 3, 1),		/* [8] */
> +			BTF_DECL_TAG_ENC(NAME_NTH(8), 3, 1),		/* [9] */
> +			BTF_DECL_TAG_ENC(NAME_NTH(9), 3, 1),		/* [10] */
> +			/* tag -> t: tag1, tag2, tag3 */
> +			BTF_DECL_TAG_ENC(NAME_NTH(7), 4, -1),		/* [11] */
> +			BTF_DECL_TAG_ENC(NAME_NTH(8), 4, -1),		/* [12] */
> +			BTF_DECL_TAG_ENC(NAME_NTH(9), 4, -1),		/* [13] */
> +			/* tag -> t/m2: tag1, tag3 */
> +			BTF_DECL_TAG_ENC(NAME_NTH(7), 4, 1),		/* [14] */
> +			BTF_DECL_TAG_ENC(NAME_NTH(8), 4, 1),		/* [15] */
> +			BTF_DECL_TAG_ENC(NAME_NTH(9), 4, 1),		/* [16] */
> +			BTF_END_RAW,
> +		},
> +		BTF_STR_SEC("\0a1\0a2\0f\0t\0m1\0m2\0tag1\0tag2\0tag3"),
> +	},

Nit: I think that this test is a bit too large.
     Having fewer decl_tags would still test what we want to test.

> +	.expect =3D {
> +		.raw_types =3D {
> +			BTF_FUNC_ENC(NAME_NTH(3), 16),			/* [1] */
> +			BTF_STRUCT_ENC(NAME_NTH(4), 2, 8),		/* [2] */
> +				BTF_MEMBER_ENC(NAME_NTH(5), 15, 0),
> +				BTF_MEMBER_ENC(NAME_NTH(6), 15, 32),
> +			BTF_DECL_TAG_ENC(NAME_NTH(7), 1, -1),		/* [3] */
> +			BTF_DECL_TAG_ENC(NAME_NTH(7), 1,  1),		/* [4] */
> +			BTF_DECL_TAG_ENC(NAME_NTH(7), 2, -1),		/* [5] */
> +			BTF_DECL_TAG_ENC(NAME_NTH(7), 2,  1),		/* [6] */
> +			BTF_DECL_TAG_ENC(NAME_NTH(8), 1, -1),		/* [7] */
> +			BTF_DECL_TAG_ENC(NAME_NTH(8), 1,  1),		/* [8] */
> +			BTF_DECL_TAG_ENC(NAME_NTH(8), 2, -1),		/* [9] */
> +			BTF_DECL_TAG_ENC(NAME_NTH(8), 2,  1),		/* [10] */
> +			BTF_DECL_TAG_ENC(NAME_NTH(9), 1, -1),		/* [11] */
> +			BTF_DECL_TAG_ENC(NAME_NTH(9), 1,  1),		/* [12] */
> +			BTF_DECL_TAG_ENC(NAME_NTH(9), 2, -1),		/* [13] */
> +			BTF_DECL_TAG_ENC(NAME_NTH(9), 2,  1),		/* [14] */
> +			BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [15] */
> +			BTF_FUNC_PROTO_ENC(0, 2),			/* [16] */
> +				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(1), 15),
> +				BTF_FUNC_PROTO_ARG_ENC(NAME_NTH(2), 15),
> +			BTF_END_RAW,
> +		},
> +		BTF_STR_SEC("\0a1\0a2\0f\0t\0m1\0m2\0tag1\0tag2\0tag3"),
> +	},
> +	.permute =3D true,
> +	.permute_opts =3D {
> +		.ids =3D permute_ids_sort_by_kind_name,
> +	},
> +},
>  };

[...]


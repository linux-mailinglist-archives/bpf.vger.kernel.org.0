Return-Path: <bpf+bounces-69655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E112AB9D023
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 03:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 164021BC3183
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 01:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4047C2DE1F0;
	Thu, 25 Sep 2025 01:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqaTlCv/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9337483
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 01:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758763375; cv=none; b=pbfT4hb+Mfi4AoQ8ZanS5yo2Ytpmukx+byzV/EY45FQVTK5vkkYU3NkWzj+r1Yo2cluxBrgU3Q+cALwUq8P2+rxY40dk6jdwAtarS7pFUb/3kjo3WyFstzdtwW51c0F4vq0jIEm26aYt4p2vCTVtYuBvFRd7IJQ5K/zTb402+kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758763375; c=relaxed/simple;
	bh=o0EaVucAffVjVNWgKC9SycpMt7zNfoJTy3Oflm8S4Uk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AeQrsNUlVDlXwCCkhXInS/pmYE1+JE5WfabW8cvONYOTy2zDIrvEqJVlW/ZRj5ycB9KogQxLFF4a4XEVzmWuPpyzxjcCwxRGN4dIqnY3Q16d4XFVsAT0h1WehLi4C0lQKYQmvJEUyz+jjjqCzJc4TSjDU8a7bUxELd9SilBGOzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqaTlCv/; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-4248a13fbe9so2210655ab.1
        for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 18:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758763373; x=1759368173; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1DItSFqISv8b0sp2o1o+gwdJ26XpE/NHjR7F/HcZXZM=;
        b=AqaTlCv/5ocwmfE0L/k9VQ0vdSXpB1EtptQ+3o3T9Zci2oThWegTnJlmoA0D5uuEko
         qTnzCjVl+AylRJqKgyKlH5Bvr7ZeM7NyjYx7qBAxvM+wh/au4tRTPgdnjtmAH/oSh3w4
         Q5kQYDSca4dxka2tNQmAK1NmWYMCBEZnehnp5J6aAZbVHAP+GjGMbWFY9scBPRt4GYNW
         2tvFLABfhquu3zi2+WXEwCIux2yzFQVl1mrFjYwnvvM13MGsM1Ujm/tSyVdjBtYTST4d
         tyEDjDpTUI4o33oz5bZfkcrH/G7TGqTtpn0FViw2Vq9eEhigNIETxGh3yIZl7NU+5p/e
         Wtvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758763373; x=1759368173;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1DItSFqISv8b0sp2o1o+gwdJ26XpE/NHjR7F/HcZXZM=;
        b=k/VyjokbiuWZdyT0fwOnf8Pjrzy0HQROnObuITKrHFIe0OgRyrhT4NBZuAsl13xV2c
         1nNhzqtEXG06Scgfkm01z+c/oTo0A+u5IakOItGp6v4wouE9IcAPMjTRTvldlz4YkeUC
         j7SBw63os753Xt4BZiDOPtOk4RY0QhYYLsSQfcn1cHYvhLkW/QgEQIyeS1Kng788MAp/
         4LJyQpMC421GNOtN5gXiGkn112bnxM13KGOZmgnEI71jj8kzwWt0ahAh1H/xPOa7NxVW
         f/LdyHx70hHTInXWZjOwZ56acgNszhPds3OKlnUEf9nmN49btBcqXtqmX3ij+b1d6OTc
         QWyA==
X-Gm-Message-State: AOJu0Yzb34T6Nr6p7nqCWy48fuEy7mvcWu9QM1y/ElOYW/Zmn3eXTjlq
	29qTXa6Rbd/dgqICnHHDkRqhXRB9lnzyvWf3ZnG3BRJRE5/pkY0mlkgl
X-Gm-Gg: ASbGncuaq6Dn2cAl/USSuj17GND/IgaxNfyGkkMPZkJkCqJ78/QazEZjxix7xBB6kXL
	3M4ozPnRlvWcgP0QXq0ZHR0eyjfXrbjTadJ5kJt5gjWbCkoAGuHNgjQUmBXNksj8ZNZfIFfa/gJ
	aHMjR9lFepjlieFBgs7t02bgqdU+yVjdYXsN4/4yy0cC457FvrXOE1/rUJVOPfuDQXccZ1dH3z7
	/5MOT684gCbFTQwciEELgTxnB+0DTf1MBVG2fAC9G5AtgO78lpQjCgrJS5ftKm3PVlZXIF9unIO
	CXP5ovMBjQd8WQDgIker5t8DDt71PpPBH+EXYMF3bzKw2tOAQdlgfHt+fkmoDN8=
X-Google-Smtp-Source: AGHT+IE+Mr9sbqIiUqiFxCLoQppQyUvIwE99EE7EeQ/11eChZXXpB6ohyOTfNUFAafgN6j19FmIbxg==
X-Received: by 2002:a05:6e02:12e6:b0:424:553b:f2f5 with SMTP id e9e14a558f8ab-425955e82cdmr27176215ab.10.1758763373411;
        Wed, 24 Sep 2025 18:22:53 -0700 (PDT)
Received: from [172.19.1.71] ([70.41.76.87])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-56a6508a1bfsm291892173.18.2025.09.24.18.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 18:22:52 -0700 (PDT)
Message-ID: <4fb8a812fdd01f115a99317c8e46ad055b5bf102.camel@gmail.com>
Subject: Re: [PATCH dwarves v1 2/2] btf_encoder: implement
 KF_IMPLICIT_PROG_AUX_ARG kfunc flag handling
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves@vger.kernel.org, 
 alan.maguire@oracle.com, acme@kernel.org, andrii <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, tj@kernel.org, 
	kernel-team@meta.com
Date: Wed, 24 Sep 2025 18:22:37 -0700
In-Reply-To: <20250924211512.1287298-3-ihor.solodrai@linux.dev>
References: <20250924211512.1287298-1-ihor.solodrai@linux.dev>
	 <20250924211512.1287298-3-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-09-24 at 14:15 -0700, Ihor Solodrai wrote:
> When a kfunc is marked with KF_IMPLICIT_PROG_AUX_ARG, do not emit the
> last parameter of this function to BTF.

[...]

> @@ -887,6 +923,12 @@ static int32_t btf_encoder__add_func_proto_for_state=
(struct btf_encoder *encoder
>  	nr_params =3D state->nr_parms;
>  	type_id =3D state->ret_type_id;
> =20
> +	if (is_kfunc_state(state) && KF_IMPLICIT_PROG_AUX_ARG & state->elf->kfu=
nc_flags) {
> +		if (validate_kfunc_with_implicit_prog_aux_arg(state))
> +			return -1;
> +		nr_params--;
> +	}
> +
>  	id =3D btf_encoder__emit_func_proto(encoder, type_id, nr_params);
>  	if (id < 0)
>  		return id;

This change hides the fact that function accepts one more parameter
both from kernel BTF and from program BTF (via vmlinux.h).
Do we anticipate other implicit parameter types?
Because if we do, it seems like having some generic KF_IMPLICIT_ARG
and hiding it only from vmlinux.h seem more flexible.


Return-Path: <bpf+bounces-39644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFFE97598E
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 19:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B00E0B2366A
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 17:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2170A1B3B27;
	Wed, 11 Sep 2024 17:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gX7jLlBz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F8764A8F
	for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 17:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726076269; cv=none; b=OQAVXu9U/uWQgPWa93QZZmOkSEnk+HWGDbYexxnhrYMo5HdaQy6PQ23IGqIu/Jpiy8W5XnMaPPsVGcf2ucv0M0KFCUfZu+Zu/YvkVZH93Nmr2rDUKnHlXfaZDXLvl4Z/Mmrcxb0rpiB5tsuE+pvArhVbdSheBi4o7ahHQrle9aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726076269; c=relaxed/simple;
	bh=/RQWfNPWEHQTKQ6PdjiVw7tz03nhfjqS2eA3NeqKI3k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=knHfUd603PhSanV32Qsi3YTYaIn/kBcov7bEH5S17aZGb50TeA3r93umM1DGteMC3nPc+Um9r3OdMlz9kRupK+jd8Rm/DGCgsDp8QHzEyVpcQErqKuLwPRGxFyt/zCrtv7zgoYwbBVK7VDyytNps16ld2bvP8BofBgwWdYLF9yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gX7jLlBz; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7191ee537cbso23502b3a.2
        for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 10:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726076267; x=1726681067; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YuNkX83LCAMiIxJkZrd56EklvRF1aaeElCrfbqB8pHM=;
        b=gX7jLlBzkFIJ/vKLJgVcIqhcUxlR2J5tIgDMYbHUtWr1BPH2AxQYRss28gPhUPEg8U
         kn/Uuwx/LDMkzHc3lk3qEm83GydocFBZrCSH2+kasQkdP50B5YLbbMOE2eFSjI9K4lqV
         3V3PopfAACjbw1XzQ+HejEoeu3R0Osssx8GI0FPHxl2o74BzTuyykuuAZi1ED/KdsCfW
         PdOrlqDWaDyhz3VNvMHmOmH63UcekXSXi55qDskpgcO3OJYJGxgPjl6uyKBgaZtxnWqK
         360v/OW+uLrck6pT2n/Zz1U9TJBQ/26/AHOISdeWwaaICT7BTSg0DrV1xgKXxPtaXKdQ
         KXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726076267; x=1726681067;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YuNkX83LCAMiIxJkZrd56EklvRF1aaeElCrfbqB8pHM=;
        b=NHExZihN81h83arsMvcZk3vqcwkCo7zNwbpXjzrCTIkFlZyGATTx5wa4HT2wYWxUq6
         Fp3pVUn4Vj7BuYbue/fo96zju0Sgb68KWuhsCPR9ovOa/5xtwL28cIhjsYq1wFCivvjF
         nrKf54WCmGNhJqVfNlUOvv6eXhI+vcBHmbbBh1sIMfYHTgE+Xv64t+p3P4hwghWzYGRY
         iQMTRMzeebv0QHH0l+2af1uW/BHwVjFkjDKbd0ANbbZH01kOk7MQ7NmLNbHC851gJA3E
         2JOFe0B3/nJSQ3snCkUU81IYswhja53WOr5GBJZbt/3ZonlV0HTFVqTPTk8kSapE2No7
         K7Vw==
X-Forwarded-Encrypted: i=1; AJvYcCVIkjdYrdgF95SGxaED6si7eDTQl7+2gpmUiO2OB1kFqr5SlFBplZNWv5ZyWEXy0RbE6nw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+XYx08Ff+kispoFFzXjK7tTz0+ZuNTa86ao3y24slkeW/fl8F
	tJTxU45sHH5BgHAkTKsGYgG/IPDccf0ZnB67K08SQFq+94efUJiq
X-Google-Smtp-Source: AGHT+IH/H8GGPDy6tg/9Td83d5NDdfqzV09k5cDW4T2Sg1iq8JKNqWV/Mi2pF39IdT3uSAk+IJqP3g==
X-Received: by 2002:aa7:8886:0:b0:70d:2a4d:2eeb with SMTP id d2e1a72fcca58-71926065578mr170578b3a.3.1726076267263;
        Wed, 11 Sep 2024 10:37:47 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-719090923adsm3226199b3a.100.2024.09.11.10.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 10:37:46 -0700 (PDT)
Message-ID: <16794f86fd1030d923e3ab7356c5ff3617b2b193.camel@gmail.com>
Subject: Re: [RESEND][PATCH bpf 1/2] bpf: Check the remaining info_cnt
 before repeating btf fields
From: Eduard Zingerman <eddyz87@gmail.com>
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Song
 Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, Yonghong Song
 <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, KP Singh
 <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Kui-Feng Lee <thinker.li@gmail.com>, 
 houtao1@huawei.com, xukuohai@huawei.com
Date: Wed, 11 Sep 2024 10:37:41 -0700
In-Reply-To: <20240911110557.2759801-2-houtao@huaweicloud.com>
References: <20240911110557.2759801-1-houtao@huaweicloud.com>
	 <20240911110557.2759801-2-houtao@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-09-11 at 19:05 +0800, Hou Tao wrote:


[...]

> ---
>  kernel/bpf/btf.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index a4e4f8d43ecf..9a4a074d26f5 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3592,6 +3592,12 @@ static int btf_find_nested_struct(const struct btf=
 *btf, const struct btf_type *
>  		info[i].off +=3D off;
> =20
>  	if (nelems > 1) {
> +		/* The type of struct size or variable size is u32,
> +		 * so the multiplication will not overflow.
> +		 */
> +		if (ret * nelems > info_cnt)
> +			return -E2BIG;
> +
>  		err =3D btf_repeat_fields(info, ret, nelems - 1, t->size);
>  		if (err =3D=3D 0)
>  			ret *=3D nelems;


btf_repeat_fields(struct btf_field_info *info,
                  u32 field_cnt, u32 repeat_cnt, u32 elem_size)

copies field "field_cnt * repeat_cnt" times,
in this case field_cnt =3D=3D ret, repeat_cnt =3D=3D nelems - 1,
should the check be "ret * (nelems - 1) > info_cnt"?

I suggest to add info_cnt as a parameter of btf_repeat_fields() and do
this check there. So that the check won't be forgotten again if
btf_repeat_fields() is used elsewhere. Wdyt?



Return-Path: <bpf+bounces-41359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 682FF995FFA
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 08:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4E98B2143E
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 06:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E7F16631C;
	Wed,  9 Oct 2024 06:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbhDsDsI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F4722EEF
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 06:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728456129; cv=none; b=ni2OnYFQ13s64r/MZEPHoILtK8K2NEIIVYiHrsOIf3zBgMZGdBi5xedlmXTAYKEiRZm1n87hbvz0ufThLguEXL2dEiMvx4hGoM6Pi713MO088iYVd8whjsz2EvgKQsVz9rsr6T117HAwrnJGgqaQSs1Ke3j8PX6usqJuTZRws+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728456129; c=relaxed/simple;
	bh=nEriyqfjSUaRPYDhKGhIpPJVX0DTqB+eN5kHCXCTdOo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T5ZwlqYK2QGd0xea7+LxH0pZN3oYhFRXpmiBkkuDmn30XXqkhyx2LdKQXms7rKpfrAeErovjSD6skkX1ACOtQYMvyZZCICtYg71mC9R7KK2c34ELKV1VfDnbaJpfozBV10tt7orMnwmMD+A4zDEax5qbvypErxLGbkximKoYY2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbhDsDsI; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c767a9c50so72015ad.1
        for <bpf@vger.kernel.org>; Tue, 08 Oct 2024 23:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728456128; x=1729060928; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4HRKuS1uNPopzOeg6+ndEBZ2xxuAbAP3V+foB+1OsAE=;
        b=WbhDsDsIxSYn/TOBnD04mv0r29NGWAH/9jD9NBI4WUq294ldCSPtSgPvMq3Pd/on6h
         V99f0PCUCsv513toaaaDRz3pY+beZ8iB2BbJ0KOtMZZl8PUyOpliIZd0nfeGhYVf0kLH
         VrlSB6ARwG5Ka14j4VtLl4ic2Q9VBM3hwvGfUtXyumyIN/JRxE9Mx0GzGoJtL/36hATS
         X+H+X3uO794LlhEuYrnQ5yYir7In5tlee25tbT6F/j239JL86ZnpBykjgMzD+YsFclSP
         l5IAHGcig5ikJAD168Uc6RXe7tfuqLSy4Mi125SkVFTrgu77w85nqZdtr6HusH2sAUf/
         IGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728456128; x=1729060928;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4HRKuS1uNPopzOeg6+ndEBZ2xxuAbAP3V+foB+1OsAE=;
        b=HTB0m7yiMN5gDCJraowOjC6REsxo6ZqV3JbKDyj26bL4IA/lslSpWUM6LOwM38zXzN
         OnLO7iFl1lLcrz72pHd80/EAZOPnsmFRo9G3DtNKstQ+XxgA2HCXvk/s+4zfRadOYuN2
         HrXz8F1dVPM2KhduL9NUbFqzGfhXobkhCpvFuGaee6uLLh2pSrXPj8fYsm/jdLl8Cqfr
         dqbEdPdH8MHN4CTeBLieDH08KDDb+n0FgMCMlMA+1eIeHk6MgmdI/vCH2adtAW5VEopG
         YGrIQDnVR34AW8NSjNE1agfIshM7DhKG5OO4JjJUj5q9+R+3qnC8nnhAL5KNLiOuRkXi
         pVYg==
X-Forwarded-Encrypted: i=1; AJvYcCUkJz7l0MHW/oe4jue5xyhuq9/F7U65IS5eSE459V98F+oy3c2VWBnuG3CzMQrTLWGsQkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCEHKO3oOluyhfF1704hncx9b+Ypq9eIw+XcfjIGy794cvqmnv
	1vwBhoBj26k6MZ5esSHW9R3Ls40pWpIvu3V/iW7KppdRSJKEYh8cedxRpl84
X-Google-Smtp-Source: AGHT+IGU2BulWZYBN1ADAlPcgROe19DQTzDQIXkAI6z66Cy5eFOsk7iYNrxfxk22pe+42eFZcx4P2g==
X-Received: by 2002:a17:902:f690:b0:20b:49d6:7c74 with SMTP id d9443c01a7336-20c63708c43mr24941685ad.11.1728456127619;
        Tue, 08 Oct 2024 23:42:07 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c6377f534sm6131735ad.232.2024.10.08.23.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 23:42:07 -0700 (PDT)
Message-ID: <e8b1e868755e0369d212f53f4e00c0cf93477af1.camel@gmail.com>
Subject: Re: [PATCH bpf RESEND 1/2] bpf: Check the remaining info_cnt before
 repeating btf fields
From: Eduard Zingerman <eddyz87@gmail.com>
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Song
 Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, Yonghong Song
 <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa
 <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Kui-Feng Lee
 <thinker.li@gmail.com>, houtao1@huawei.com, xukuohai@huawei.com
Date: Tue, 08 Oct 2024 23:42:02 -0700
In-Reply-To: <20241008071114.3718177-2-houtao@huaweicloud.com>
References: <20241008071114.3718177-1-houtao@huaweicloud.com>
	 <20241008071114.3718177-2-houtao@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-08 at 15:11 +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
>=20
> When trying to repeat the btf fields for array of nested struct, it
> doesn't check the remaining info_cnt. The following splat will be
> reported when the value of ret * nelems is greater than BTF_FIELDS_MAX:

[...]

> Fix it by checking the remaining info_cnt in btf_repeat_fields() before
> repeating the btf fields.
>=20
> Fixes: 64e8ee814819 ("bpf: look into the types of the fields of a struct =
type recursively.")
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> @@ -3681,10 +3687,10 @@ static int btf_find_field_one(const struct btf *b=
tf,
> =20
>  	if (ret =3D=3D BTF_FIELD_IGNORE)
>  		return 0;
> -	if (nelems > info_cnt)
> +	if (!info_cnt)
>  		return -E2BIG;
>  	if (nelems > 1) {
> -		ret =3D btf_repeat_fields(info, 1, nelems - 1, sz);
> +		ret =3D btf_repeat_fields(info, info_cnt, 1, nelems - 1, sz);
>  		if (ret < 0)
>  			return ret;
>  	}


I think the change like below (on top of yours) would work the same
(because nelems is >=3D 1 at this point):

-       if (!info_cnt)
-               return -E2BIG;
-       if (nelems > 1) {
-               ret =3D btf_repeat_fields(info, info_cnt, 1, nelems - 1, sz=
);
-               if (ret < 0)
-                       return ret;
-       }
+
+       ret =3D btf_repeat_fields(info, info_cnt, 1, nelems - 1, sz);
+       if (ret < 0)
+               return ret;

wdyt?



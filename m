Return-Path: <bpf+bounces-39683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2EE975F88
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 05:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FE0228A934
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 03:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6658F3987D;
	Thu, 12 Sep 2024 03:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHwGQ4WA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EE826AC1
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 03:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726110210; cv=none; b=ThVWFUnUUUNMSPyIQiKC3DoJ6/dEjRPDQ19KAhWa0qhopQ9ZejANGUT+PqFNMD8RHDtcF2eybrV9u569J0gQRb0W1fjwEfYijAYlHsimSmMFRVboUTAZV5whqGAgNNmjjwfhQ3KOnpFZz5BzWZHRZ20TA7ZYzPBtwP875tNurcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726110210; c=relaxed/simple;
	bh=W/VH9NTaOf0aTAiXk8NdXVFsx9uqrNF7U9vq45cKzNg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=COHUMl6XvAFl9FjT3/ELSgsZEhi1AOdRc36CEXtQNKWWmAKUKcq8pd7cbeYFsW7yFdQLa56BcSV6xGMQD62bY1iVMHk0ru7R6PpLuzd+7AQX4fAP2QxHnQtcZqjcJqCMdOoEH0LYw5GW9RdEmcp0BEgi5gaCc5EqvLkG3kog/hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHwGQ4WA; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-206e614953aso5434265ad.1
        for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 20:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726110208; x=1726715008; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KwFNGMTmSFjLUAlrr6tSeFuAnm8N5stpHYJgSW61zJw=;
        b=FHwGQ4WAbOFdzbze0pPt/9nGDVb4Doitz7RaqymITPy/tFicCtoWIEyC2M6CZxSf+W
         CMFyN4VAtA2LngPqcNPKEZtEuHPkYjqK9NA2FVCb95MVrgwLofaQv4sx0WIOKo9xQjyj
         uKTgA01+njmoUcVx3E4ptlJ4mNDksiSHmam9zUfLboqhXzsGYt6B4D/+k1mX28S2n83d
         HRIe/D/j7KEeRCmcsn4Iw6DDprkaMgCfN+D/Bo6svMMX1y6sOKsG1WO3eqAZW5Nz2ZtZ
         4Eox5cB9GHpVlU5JkJKhxqk89NJGMHTdw1XQ4+H6BPKWKdjzf0XRPC5rt/nzcke0BIrO
         BS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726110208; x=1726715008;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KwFNGMTmSFjLUAlrr6tSeFuAnm8N5stpHYJgSW61zJw=;
        b=du9+43VxHek8y5n87l8NyuQIXtUWEjE5meWeRh/t6nLKDGrJMemij8lvHGTMlwEDKw
         VfxWGs+sLFP2csVVXdgQSs3lIcIujXXuaR1QMqwKGblFNcgOTQrv5R9D49c17TpO0XYa
         F3SM/Y0uQwMkoUt/Y45Y9mvNzygd3wf1JnI7+TO9266jSvgPvSg31HAALcDc8TjOHLWf
         qZ+c0EcL7JMmxpEyOYucdOgFGODS2YEOgdNMRZDvvxhsX//onajnRgaiy0kAYlmLiY54
         D1npArJlAOTrzih/HhlaLN5/gjv5FI1eTnJhAIDqych4UlSP1R6opSeakc8JyzWOPCDD
         xSmA==
X-Forwarded-Encrypted: i=1; AJvYcCVqPIc/fl8QrXc6IE85EHtYpIsPd2KY+73D5HI+prfwJClSnEgBMduGnOoiHWnQFWOmlkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPr1D1wlMvmiND5shaSOId8Z3mbuIJMLKyXz3wtp4mM1ZIRr8y
	ZMTcTlm4A/mE9SSwfI9PXi/ZI2W//vIAHwxMeVZO5RHcR6lzKGMd
X-Google-Smtp-Source: AGHT+IGeDADxWqkdBgYPzDIgb3IEMp7UQHafkU5vpLdHqPDKtBbhXV2cS+7LI6NPEdLQNjseHdxt9Q==
X-Received: by 2002:a17:902:d54a:b0:202:9b7:1dc with SMTP id d9443c01a7336-2076e44ba5emr18724645ad.54.1726110207639;
        Wed, 11 Sep 2024 20:03:27 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076af253d5sm5992945ad.10.2024.09.11.20.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 20:03:27 -0700 (PDT)
Message-ID: <9a7d4f5ff0ea8af86a6d7a5b630c38cb7ecc2075.camel@gmail.com>
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
Date: Wed, 11 Sep 2024 20:03:22 -0700
In-Reply-To: <99c3bd09-054a-2c7c-7c6f-f1c613444f1f@huaweicloud.com>
References: <20240911110557.2759801-1-houtao@huaweicloud.com>
	 <20240911110557.2759801-2-houtao@huaweicloud.com>
	 <16794f86fd1030d923e3ab7356c5ff3617b2b193.camel@gmail.com>
	 <99c3bd09-054a-2c7c-7c6f-f1c613444f1f@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-12 at 09:20 +0800, Hou Tao wrote:

[...]

> > > @@ -3592,6 +3592,12 @@ static int btf_find_nested_struct(const struct=
 btf *btf, const struct btf_type *
> > >  		info[i].off +=3D off;
> > > =20
> > >  	if (nelems > 1) {
> > > +		/* The type of struct size or variable size is u32,
> > > +		 * so the multiplication will not overflow.
> > > +		 */
> > > +		if (ret * nelems > info_cnt)
> > > +			return -E2BIG;
> > > +
> > >  		err =3D btf_repeat_fields(info, ret, nelems - 1, t->size);
> > >  		if (err =3D=3D 0)
> > >  			ret *=3D nelems;
> >=20
> > btf_repeat_fields(struct btf_field_info *info,
> >                   u32 field_cnt, u32 repeat_cnt, u32 elem_size)
> >=20
> > copies field "field_cnt * repeat_cnt" times,
> > in this case field_cnt =3D=3D ret, repeat_cnt =3D=3D nelems - 1,
> > should the check be "ret * (nelems - 1) > info_cnt"?
>=20
> No. The number of available btf_field_info is info_cnt,
> btf_find_struct_field() has already used ret fields, and there are still
> ret * (nelems - 1) fields waiting for repetition, so checking ret *
> nelems against info_cnt is correct.

Please bear with me. Here is btf_repeat_fields():

    static int btf_repeat_fields(struct btf_field_info *info,
                     u32 field_cnt, u32 repeat_cnt, u32 elem_size)
    {
        u32 i, j;
        u32 cur;
        ...
        cur =3D field_cnt;
        for (i =3D 0; i < repeat_cnt; i++) {
            ...
            for (j =3D 0; j < field_cnt; j++)
                info[cur++].off +=3D (i + 1) * elem_size;
        }
        ...
    }

The range for 'cur' is [field_cnt .. field_cnt * repeat_cnt].
Meaning that at-least 'field_cnt * repeat_cnt' entries are necessary
in the 'info' array.
Given parameters passed to the function, this is 'ret * (nelems - 1)'.
What do I miss?



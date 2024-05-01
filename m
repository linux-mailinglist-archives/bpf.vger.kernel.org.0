Return-Path: <bpf+bounces-28397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 741B48B90B4
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 22:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3184E28331E
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 20:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E59B1635B7;
	Wed,  1 May 2024 20:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtJGlwNx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C7812F378
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 20:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714595974; cv=none; b=MkS/TmT+OCTc12mR/WdKr9iW+IO+jz7mSkfbnFn4Aq6MGqKuMbbgIoetH+vtcahs2Yk1dGK6jEmqtDWF/n/l9JVJuB9HaHrqtGD5aI9ZvUg3lR23impL+W8S64u7Acdb2XwP9o7AyjzPU5F98RWAKzc9AwgR+kbn1s4wPDt+6Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714595974; c=relaxed/simple;
	bh=BkOzNX9yU2y4POhn2awBh3CXd+ArukJonSNe+RbFabo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hkrrq4sf9IoSZlvnwsP+8qiwfN4/bCcM3N9XlZyhqOciSuN94p9hkP16LqORDeXE4wnja0v2UENwMCDk8tSboKJ/dZftESvkc3ooanlbZMMCaPsh76o+lvfFBaVR9UrjAq6XMLSLAr5r+2kCCfYSLVvyeJjLxoQtctSjGR6Y5EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtJGlwNx; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e651a9f3ffso37178785ad.1
        for <bpf@vger.kernel.org>; Wed, 01 May 2024 13:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714595972; x=1715200772; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0Ma1qAARjSBc+K+cZ0oo33PUNwa1jv4SXvBsH+jYoLg=;
        b=CtJGlwNxEqRIwDuysEQ2Dt2+4pyrPakPwV/V7L4gFLLw5GEE+1ojsIuWcxANztUQUQ
         +nJ7ixIGXBHeZ89M6vOViSXfKaeeOUL0snPs2dYtFye8ijlcWVdAXYV7klTJz50iFXSu
         4b04gG2oWu2yFotoSxfCbfvj2yl3xU4VWWOXZ5KgX7Rn5kIpKN4rWGTK0kdX8LyEULX7
         Fn2kmPp6eUwJfqVRFU9yjARCD4HXSBl7+qVXR1Nm76sf2Eh5+x0Mq8A0W/oXJdH+bPLw
         AgmQHh3iuhZk16buBqp+fgQdenqFVCMWoA15gn6Do5kCRvs9tsTG21OMt2its/3tpwtK
         zf3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714595972; x=1715200772;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Ma1qAARjSBc+K+cZ0oo33PUNwa1jv4SXvBsH+jYoLg=;
        b=dOCnYunPV5AU6nk7Q7y8KgxS+/KmA73t7F9VYf0zo0pB/B5JiY429PNpeIKaJ7llGk
         QtxaVIiUi3yoVsaEvKnEZBPO8crLOv5p+z8n9lts1DJtIlGyPw/fPyTwtCpofAGtO2tL
         D8lbsdBhN7mslYi8Tv8+iQOpQ2iwO5xYS5hK26qoCtbwJXN7t+OmnimkHqh4GTnbraX7
         7agAbf9aSaKewx2ta4rTjRIhP8/gHt91jYG6K4V4eI2ULPwdI/Ik5W8lfRicLfiVtZv9
         lv4ZumsoNef37w/IV5cTA/1q80OUaFGJYvpvQkajZ+mHMuM5IXiTWpN20RbruswVpQ+H
         m4mA==
X-Forwarded-Encrypted: i=1; AJvYcCVMerdmVXDSqmFwrwnVBb1EzxrE0A+8mGdehmMEMI10Sy2v88vfqsdp6/c8W5dy3N16Wr0H/mkaQU8IHFvMGFWbHGN6
X-Gm-Message-State: AOJu0YwL35tcfxZs3IRG3t5A6/aU8VUngIV3H9OV90KAE+lmHfp+ywfg
	0I+LMul+0v5guEgESn4mTWdch261f7kqg5Fx///Z4RgJ6jQtRV0+
X-Google-Smtp-Source: AGHT+IEeDhkNpEeOzJyoGkMp3Cu7GtWcVT0hSVWrVuox12A0AhFSFmG/jTnK/geyRFQWXRIBPnkJZw==
X-Received: by 2002:a17:902:e74b:b0:1e4:4125:806f with SMTP id p11-20020a170902e74b00b001e44125806fmr4234655plf.11.1714595972270;
        Wed, 01 May 2024 13:39:32 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160:7cc5:20b9:bcdc:5d52? ([2604:3d08:6979:1160:7cc5:20b9:bcdc:5d52])
        by smtp.gmail.com with ESMTPSA id m1-20020a170902db0100b001ec32171d04sm3881577plx.21.2024.05.01.13.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 13:39:31 -0700 (PDT)
Message-ID: <e79129b07130c6b76f02a6f98e5c68e861bfaef1.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 07/13] resolve_btfids: use .BTF.base ELF
 section as base BTF if -B option is used
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org, ast@kernel.org
Cc: jolsa@kernel.org, acme@redhat.com, quentin@isovalent.com,
 mykolal@fb.com,  daniel@iogearbox.net, martin.lau@linux.dev,
 song@kernel.org,  yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org,  sdf@google.com, haoluo@google.com, houtao1@huawei.com,
 bpf@vger.kernel.org,  masahiroy@kernel.org, mcgrof@kernel.org,
 nathan@kernel.org
Date: Wed, 01 May 2024 13:39:30 -0700
In-Reply-To: <20240424154806.3417662-8-alan.maguire@oracle.com>
References: <20240424154806.3417662-1-alan.maguire@oracle.com>
	 <20240424154806.3417662-8-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-04-24 at 16:48 +0100, Alan Maguire wrote:

[...]

> @@ -532,11 +533,26 @@ static int symbols_resolve(struct object *obj)
>  	__u32 nr_types;
> =20
>  	if (obj->base_btf_path) {
> -		base_btf =3D btf__parse(obj->base_btf_path, NULL);
> +		LIBBPF_OPTS(btf_parse_opts, optp);
> +		const char *path;
> +
> +		if (obj->base) {
> +			optp.btf_sec =3D BTF_BASE_ELF_SEC;
> +			path =3D obj->path;
> +			base_btf =3D btf__parse_opts(path, &optp);
> +			/* fall back to normal base parsing if no BTF_BASE_ELF_SEC */
> +			if (libbpf_get_error(base_btf))
> +				base_btf =3D NULL;

Should this be a fatal error?
Since user requested '-B' explicitly?

> +		}
> +		if (!base_btf) {
> +			optp.btf_sec =3D BTF_ELF_SEC;
> +			path =3D obj->base_btf_path;
> +			base_btf =3D btf__parse_opts(path, &optp);
> +		}
>  		err =3D libbpf_get_error(base_btf);
>  		if (err) {
>  			pr_err("FAILED: load base BTF from %s: %s\n",
> -			       obj->base_btf_path, strerror(-err));
> +			       path, strerror(-err));
>  			return -1;
>  		}
>  	}

[...]


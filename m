Return-Path: <bpf+bounces-52568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81392A44B04
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 20:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9A1A3B3364
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 19:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142C719E7E2;
	Tue, 25 Feb 2025 19:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhKLkJyB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CECA199396
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 19:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740510273; cv=none; b=cNUnhj3nd0YEFvl9iY4JTm0zsEk09DALXZnmQyN03GQigeDOgPuWZsdaawSYWwHCPd88uHkKlkgnV5dqS7waxXeyCtUc19wPtI95wsv0kAAokhmPT59HMfoN50AY4pzAsK+bteOyDkdRPlx/ve8Z30PgtTNTMCohhllVpnykZqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740510273; c=relaxed/simple;
	bh=EgZksElEEOclC4ymeMmOiSimG/m78rZcLFTrrZQtJvQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dkAhaNrP/xzZW4uvd0TMHyHmoo4ivYrwkPPQM+aVS3/Hw8NcmB5TLGbhx4TV4MLsO/I/RjflJ0te9gYAnHCBnEO2HLmvuS+VoTfTsKmXAyXX3LOSGJ1qrLnBdw/KZav2HDbVf73FbUT7jQLGNYyHxX8Ct8KKJAHuVo3z8cCb/Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhKLkJyB; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22128b7d587so117706575ad.3
        for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 11:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740510271; x=1741115071; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BQCTOkjcwv4oVIbCFdUX6WhUysS2AHLq+fvfoVW8PGg=;
        b=mhKLkJyBxQGe9lnRz6oyP/CyTiAuP6sjKvvZh0ACk69KwS6TlqVqPJNjHPLVMHluom
         oA9OX/n+AoxdMp4cTDeu15YfETf/M22w50j0sPL02YH0At8y6yuablzV/xzdjOiLCrEE
         XZrIEi13v3Pgs4hzGSHeb953P3e54ZB7VJFWI64mZJmdLyrSdh7VPd5vxEv1rMHrOOUa
         E0T4+erkTdtn7LYXSt6XdQMR0kgWLp7+lDaHSXPpc0dU3l3xsUzae+mzkPR8gzwCFKNf
         nKOvVMa7A+cDbV8X/ebY1Hsjp7EDSQAXWviS7sOsgaVYUl/98G3UToCMhAAVwnRzNeol
         DUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740510271; x=1741115071;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BQCTOkjcwv4oVIbCFdUX6WhUysS2AHLq+fvfoVW8PGg=;
        b=qRooLcLS85dhQ42SslD+6aXCJ0rBPPg8IGHrS9USDT6zwq2c7k6ldbLw7ERdG45dw6
         mSuL+gmxfWicAQRbJlO9irmVTL/FiQRfzgIpRbu0h4SxfdfZr63c9N4gTPqP5nj5QpvT
         341XN6fdplLRpKyoFYT+oRfduuCAK21NZbPs5m49slZ2b8AZl0J9OEarlwU05ygCjpm8
         0dj4VefS4Fi/HqPLSMPBikl2Op5i04GKvIlWRJZdwUqHDCkrK+js5/Md97W/+YQQkcN9
         YNox8PpPNWWi/KtkgVTEjhRky/ff1VVn6qTO0y3Vgo23gmeUS4ifkCKkvDD7Yzw47426
         OnXA==
X-Forwarded-Encrypted: i=1; AJvYcCV+j+bspHEZEb1pRXcr08a3tBUBoLlURLjFDFshCJBvSZKTapWSpLHfO2yknen8qlpp+M8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4M7wjRVf8TXyVWmb6EQE5yfXRontX0WWTfLYFbFzD53iAoe0Y
	fpKKfEefbILx/N/uYX9/7U9JdHah6sEvq9WxkUXHRuBV2+e99gsl
X-Gm-Gg: ASbGncuGGhDSp0aE2wiXFgvYH4THAWs8SwWJom9Lg2ggVmyN9yh5L2hLZBrfoLtmRgO
	qQ9eN1UpkEbLV3E9R8j6r4Y46oJwEQqgfyBT+GFiTlFfiGaSl51WCpK1Ylpl/p4957N9JvQtN1C
	fWv3TW5IOMPEq/S/WBCE7iDR5yEtR7QspT6gWwNVcrv+lHPfXPDb0I15WBGdByG6REfv7RoApbx
	7v6GBfNa6xhgdLHRSQ+5TLjkj1v+lp+xSGeg4BOZKcualwTR/ZWn9rCbsT7/S6HFCPUr4B0Qwzz
	X7xnepnnW7gZUHf6lvOqkgc=
X-Google-Smtp-Source: AGHT+IEqmu8Zyx7MUf0PAxJR6X5pTZPVv6aKiDF4jXz3JxEV66Uzs6JRZR4kmRCPi9CNnRfka4DuEQ==
X-Received: by 2002:a05:6a00:3e0c:b0:730:7d3f:8c71 with SMTP id d2e1a72fcca58-7348be2c98cmr646233b3a.19.1740510271330;
        Tue, 25 Feb 2025 11:04:31 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a72f4c7sm1869180b3a.79.2025.02.25.11.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 11:04:30 -0800 (PST)
Message-ID: <b8b36cfa2700a753e85468591ac3ec458b3a5fa5.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 1/2] selftests/bpf: implement setting global
 variables in veristat
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Tue, 25 Feb 2025 11:04:26 -0800
In-Reply-To: <20250225163101.121043-2-mykyta.yatsenko5@gmail.com>
References: <20250225163101.121043-1-mykyta.yatsenko5@gmail.com>
	 <20250225163101.121043-2-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-02-25 at 16:31 +0000, Mykyta Yatsenko wrote:

New warning for trying to set non-enums from enumerators works fine.
This still can be abused if numeric value outside of the supported
range is specified, but that's fine, I think.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -1292,6 +1320,268 @@ static int process_prog(const char *filename, str=
uct bpf_object *obj, struct bpf
>  	return 0;
>  };
> =20
> +static int append_var_preset(struct var_preset **presets, int *cnt, cons=
t char *expr)
> +{
> +	void *tmp;
> +	struct var_preset *cur;
> +	char var[256], val[256];
> +	long long value;
> +	int r, n, val_len;
> +
> +	tmp =3D realloc(*presets, (*cnt + 1) * sizeof(**presets));
> +	if (!tmp)
> +		return -ENOMEM;
> +	*presets =3D tmp;
> +	cur =3D &(*presets)[*cnt];
> +	cur->applied =3D false;
> +
> +	if (sscanf(expr, "%s =3D %s\n", var, val) !=3D 2) {
> +		fprintf(stderr, "Could not parse expression %s\n", expr);
> +		return -EINVAL;
> +	}
> +
> +	val_len =3D strlen(val);
> +	errno =3D 0;
> +	r =3D sscanf(val, "%lli %n", &value, &n);
> +	if (r =3D=3D 1 && n =3D=3D val_len) {
> +		if (errno =3D=3D ERANGE) {
> +			/* Try parsing as unsigned */
> +			errno =3D 0;
> +			r =3D sscanf(val, "%llu %n", &value, &n);
> +			/* Try hex if not all chars consumed */
> +			if (n !=3D val_len) {
> +				errno =3D 0;
> +				r =3D sscanf(val, "%llx %n", &value, &n);

The discrepancy between %lli accepting 0x but %llu not accepting 0x is
annoying unfortunate. Does not look simpler then before, but let's
merge this already.

> +			}
> +		}
> +		if (errno || r !=3D 1 || n !=3D val_len) {
> +			fprintf(stderr, "Could not parse value %s\n", val);
> +			return -EINVAL;
> +		}
> +		cur->ivalue =3D value;
> +		cur->type =3D INTEGRAL;
> +	} else {
> +		/* If not a number, consider it enum value */
> +		cur->svalue =3D strdup(val);
> +		if (!cur->svalue)
> +			return -ENOMEM;
> +
> +		cur->type =3D ENUMERATOR;
> +	}
> +
> +	cur->name =3D strdup(var);
> +	if (!cur->name)
> +		return -ENOMEM;
> +
> +	(*cnt)++;
> +	return 0;
> +}

[...]



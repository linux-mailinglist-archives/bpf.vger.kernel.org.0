Return-Path: <bpf+bounces-45864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C771A9DC10E
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 10:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6497EB2109E
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 09:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77F616DEDF;
	Fri, 29 Nov 2024 09:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3/T+A/Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4661143C40;
	Fri, 29 Nov 2024 09:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732871235; cv=none; b=vEj7GJ3E4GmKlvC5ISqJ6hGFx/Ifh93yG73f276G7jsiJDsSIkYwTCJODWcpLzWjOlsO52ngBZPCFLqcBldW+yt8YdJTXZujSMWX+YKcnvq9pFRb38eZuxUBUV+fE53wOpfjl5XWzoMulKUk4QSVTg2ggnIxIs5NOWAuNUAT7G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732871235; c=relaxed/simple;
	bh=9QrLSJSfCssyqrKu1PKVDMrDLdQ8KEa80hp/tKV7lc0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YeOl+WXjA/VWtvmwqLz/DLgmZL6s9vDj/M7vxhfojzs1zdyZ+mGzUpMJPpn7vgNoUSmFhtnIpXuFan4ovMHZH70sZchbo9MT7ao2WIBR2Y/WJVyu52zyd3EN1VxFzt3b/RxcLqGMwJ3K0YeNZQQGD+1d/OHhCo2801tORpAM9x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3/T+A/Q; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21210eaa803so13836965ad.2;
        Fri, 29 Nov 2024 01:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732871233; x=1733476033; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fqln9ZdHFUDuCiK8OVuT8Z5lz7dg7Qs0TmnwLBv3y5A=;
        b=d3/T+A/QvcPT+g6VnXHaZyRBHuk9qlmoicWTKt4jVHGhYRN4DHnSgI4OOHEPVI02xd
         90ccIN4KWEifBp8QWO0LONIYjKMYoiuoWnmLE9hg5k/GzLIhfLg1TdhvOomTRwPpkg8Y
         KCokLEONCr3X8NtNNDtH6rLsFRk1i8aN9f4MrRR2bCNYh/oHGiS2Nv9YaKfu7W0Vax3B
         qxbALTsVFipPQS9P+VAmcEWuJ090fTpxuXLINae0YIZwNidm8rjq/8UJcNCNbMhf0Qtv
         G1ZEv/LDAMbH7PfUxx4MS0G7Mpr9vwOvRLGkTA3smvsYwJfMlkjNdm/B+QkAlaStClVO
         wm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732871233; x=1733476033;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fqln9ZdHFUDuCiK8OVuT8Z5lz7dg7Qs0TmnwLBv3y5A=;
        b=J0LyCjlE37a7PsJVSFuRPTB0mWQD9+RN9vEyBH+dwOpvkVVU+yBOCrMz4igfq2RprD
         yHYhYcCXSTlZ6N2RfMs6IDXnk54zGE996PGgg+DF5YrW3Qq1jDwDxYxaOmOnQ4YGpaT6
         uwT/+bGSV5U7UvhMs6A481ZfUeO1EkWqkgEnvLe9jfrqRjYhHLj0OoQz/oRnUxr82J9/
         nqPCd1o0edGYZ8BO1ivlQBQcTGpaSr+9Vt/JK+PBnkltRTjtf9UUXunesXD654XgoJ+X
         9Lc6GVn7jT26XtyKiC7U1c4qQ7oRRCIP7dGM9uWOucNNxuXdcmH4WPHKzN9T6hO8Yxl/
         jAFw==
X-Forwarded-Encrypted: i=1; AJvYcCVDg/n4SZ1G5e3Q1ytUNHKN0l3AA/cDpJ1YCvFiCiCLfG8h5jJT/H3vsELCJCN8U5EYMtBbuyFD@vger.kernel.org
X-Gm-Message-State: AOJu0Yw51bDJugu9t2FUIRiRE53O3xv/j71gxQV7gwqhIktRd4iM7LGp
	/hrbq6QEqVdeaRHevD2fSaa3rqclKXvjZQ2k756H9tK0FJ8UN20N
X-Gm-Gg: ASbGncsFajVLg5N3QnbS4vwVfhUhuV4w8t9PG0KeTCAWQ0E0uB3CFOp6Ej8jG8Z1WJf
	AVEpvytsCI0C8F1Rm6lUsyly6CrpGDspQ+ohwm7yabFSYy6MZ+q1IUxLpF6An4zHDsn/4NpMxEI
	TQu6BxTOkxsdnHtM2bvtetIXuySnTP3Ty8kV2tlRdRYLU/ojw5ZeLsD0pRCwcBprpojGqgAE5gB
	AuZ+b8qZJ69u7wo1vp8Mo7qiBM+MHtsljIFygCdJOW4M0E=
X-Google-Smtp-Source: AGHT+IG024v4MKZ0mFYSWuYwxhMjctlBjjpe+DSrKp6nbGdfyx5B5nWHSYqcGNl8xq/Q3j2DqCCuNA==
X-Received: by 2002:a17:902:e88a:b0:20c:5909:cc30 with SMTP id d9443c01a7336-21501082d2fmr149701645ad.10.1732871233099;
        Fri, 29 Nov 2024 01:07:13 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215219676b7sm25650605ad.120.2024.11.29.01.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 01:07:12 -0800 (PST)
Message-ID: <60f195235812389d44c009a7fd97a6a12aa48b17.camel@gmail.com>
Subject: Re: [RFC PATCH 2/9] btf_encoder: store,use section-relative
 addresses in ELF function representation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>, dwarves@vger.kernel.org, 
	acme@kernel.org
Cc: bpf@vger.kernel.org, alan.maguire@oracle.com, andrii@kernel.org, 
	mykolal@fb.com
Date: Fri, 29 Nov 2024 01:07:07 -0800
In-Reply-To: <20241128012341.4081072-3-ihor.solodrai@pm.me>
References: <20241128012341.4081072-1-ihor.solodrai@pm.me>
	 <20241128012341.4081072-3-ihor.solodrai@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-28 at 01:23 +0000, Ihor Solodrai wrote:
> From: Alan Maguire <alan.maguire@oracle.com>
>=20
> This will help us do more accurate DWARF/ELF matching.

It would be good to have a more detailed explanation here.
E.g. number of generated functions differs with this patch:

# without this patch
$ bpftool btf dump file /home/eddy/work/tmp/old.btf | grep "\] FUNC '" | wc=
 -l
48056
# with this patch
$ bpftool btf dump file /home/eddy/work/tmp/new.btf | grep "\] FUNC '" | wc=
 -l
48189

It would be helpful to peek one of newly added functions and explain
why it was previously excluded.

>=20
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
> ---
>  btf_encoder.c | 37 +++++++++++++++++++++++++++++++------
>  1 file changed, 31 insertions(+), 6 deletions(-)
>=20
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 98e4d7d..01d7094 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -88,6 +88,7 @@ struct btf_encoder_func_state {
>  struct elf_function {
>  	const char	*name;
>  	char		*alias;
> +	uint32_t	addr;
>  	size_t		prefixlen;
>  	struct btf_encoder_func_state state;
>  };
> @@ -131,6 +132,7 @@ struct btf_encoder {
>  		int		    allocated;
>  		int		    cnt;
>  		int		    suffix_cnt; /* number of .isra, .part etc */
> +		uint64_t	    base_addr;

This field is set, but never read.

>  	} functions;
>  };
> =20

[...]



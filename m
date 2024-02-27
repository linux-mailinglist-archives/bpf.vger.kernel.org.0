Return-Path: <bpf+bounces-22820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A93F86A356
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 00:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EFAC29283F
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 23:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055D455E45;
	Tue, 27 Feb 2024 23:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Imy0SpOP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5FD1E86C
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 23:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709075371; cv=none; b=ubsKvrkMcvaFduRMlWTZmxvZOBYmzQAb7+rLD8xEedTUP+UT0Rt/I+DC/+kcWYNyWVIijrjuToBAY7Ay5agMynXDnQuuKduVamxIIx1SjrGipzqNPO0uTqdPA6ngqvvJYzinl55D+OlHW5GGLuK35aEyAbC1Rgj3465PmCUlcFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709075371; c=relaxed/simple;
	bh=8stcQoSGmMnpE0B49TkmqGpUwg91RHFJ79En4ZUzg4o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RN5E2tZVeQlRQAXPCacwrUBEjCjNDN1ANqsYWE01gunbV7VaGjMBsTy5d9M/AV8vBwtsQhqaoOG63RNs4enwgjkIuFfY5sjnLsz2E1+hintw7D5i1/FVKMp1x2/Hg6gFmvdhLtBtaSAYWkL8ZtrRet69yyfS4aoipd8hx0wCZ8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Imy0SpOP; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3f829cde6dso580458866b.0
        for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 15:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709075368; x=1709680168; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=62YCQsvPRjkak17F+44ZCA3DnoN+GsuOuxK7+kSasd8=;
        b=Imy0SpOPZWgibZQ14rhDwFbl8GWJb6Fzypfhw+vgVmqcIr3G99Gtr9MeOMdMh8Rl0v
         w753g98NcECprO9AKXYbUKClK1o/G9PMOPIDbYPiDcIp/v9Kw1KN3dlUCDNR7QQvIbW9
         HivURDuykv/9XS4OUBymdBpTu+7C+XrAktsvSIErdRPA0HcQrBS7YuLpAYeb/5iLQ+R8
         sotV30IwqJHJcJyHl6q//BDhTe/2n826ngcitpI3u0wrNQQ4WRMIhfk76LbuAAJ+KI/G
         5XpuEszgIhHsNiJ64YwnQYgJRS0qa8AdgW53N4zZM6ApnMZAy+15quLzulayQstBJ5Gb
         YsmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709075368; x=1709680168;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=62YCQsvPRjkak17F+44ZCA3DnoN+GsuOuxK7+kSasd8=;
        b=aZKRaOMoynYJSQWy4z8Ek2wjVOKL5hko8V6jUrPVCycqDskwJskTVP7t+pLndsdMcS
         llOkYnGF67P9iaRr0Sqf262Q+qK0P3mHpEC9pOMrTttBjtEM1qoP5ftM3TBC7FI+iP8t
         yqAYz9LqxQCbgk+J391cUbOm02v4lpsGu/8m6xkRT2s3t5Jn60GdYMGtQok1mqOmH5Bi
         hsmnR7TWulXKDdfeJDr5x+IHL3aXPFnNw35MO8Tx22MZcajPJuNKLxasyrl6TPAq0J19
         4XO714moBSoGT/Mdh4OhcsaFE1k30ft7MnyWrGG9xsOE/5G5Djw+cCNH6XDhdlor+tR3
         IuJA==
X-Forwarded-Encrypted: i=1; AJvYcCXcOJE04Wwp3wtBG99ZQt159KXD+FGe1UOi0vRyX2XCZA1yhz7WnfqSHRVrtjCcyvjwFub5k1dykiFgAy6LF9mvTDOI
X-Gm-Message-State: AOJu0YyhANCdfxhS8CBxvnXdtZ3w8OtjgbDy8LiBiYQU/HU3QG9Uhrll
	hfrtAXyNnsGhbMxxmnJrIOuFHSfSS5+c12bQ5iITIv297p9DmBhP
X-Google-Smtp-Source: AGHT+IFQ3U3tSp2dergt+zlpvmwfe8J3W+2Oj7uoN29dKeHfWRRAz6ZaaDFeGhGBbxzMwwlsMCA6rg==
X-Received: by 2002:a17:906:4158:b0:a3e:b7a5:71f0 with SMTP id l24-20020a170906415800b00a3eb7a571f0mr7308968ejk.41.1709075368177;
        Tue, 27 Feb 2024 15:09:28 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ck25-20020a170906c45900b00a431cc4bd3dsm1215991ejb.182.2024.02.27.15.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 15:09:27 -0800 (PST)
Message-ID: <c9395bfd3cbd27ec5280d2e55abc6a6186fc663a.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 7/8] libbpf: sync progs autoload with maps
 autocreate for struct_ops maps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kui-Feng Lee <sinquersw@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev, void@manifault.com
Date: Wed, 28 Feb 2024 01:09:26 +0200
In-Reply-To: <ec9d8997-f5a2-44b6-9bc4-2caaf19df8a9@gmail.com>
References: <20240227204556.17524-1-eddyz87@gmail.com>
	 <20240227204556.17524-8-eddyz87@gmail.com>
	 <ec9d8997-f5a2-44b6-9bc4-2caaf19df8a9@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-27 at 14:55 -0800, Kui-Feng Lee wrote:
[...]

> > @@ -4509,6 +4514,28 @@ static int bpf_get_map_info_from_fdinfo(int fd, =
struct bpf_map_info *info)
> >   	return 0;
> >   }
> >  =20
> > +/* Sync autoload and autocreate state between struct_ops map and
> > + * referenced programs.
> > + */
> > +static void bpf_map__struct_ops_toggle_progs_autoload(struct bpf_map *=
map, bool autocreate)
> > +{
> > +	struct bpf_program *prog;
> > +	int i;
> > +
> > +	for (i =3D 0; i < btf_vlen(map->st_ops->type); ++i) {
> > +		prog =3D map->st_ops->progs[i];
> > +
> > +		if (!prog || prog->autoload_user_set)
> > +			continue;
> > +
> > +		if (autocreate)
> > +			prog->struct_ops_refs++;
> > +		else
> > +			prog->struct_ops_refs--;
> > +		prog->autoload =3D prog->struct_ops_refs !=3D 0;
> > +	}
> > +}
> > +
>=20
> This part is related to the other patch [1], which allows
> a user to change the value of a function pointer field. The behavior of
> autocreate and autoload may suprise a user if the user call
> bpf_map__set_autocreate() after changing the value of a function pointer
> field.
>=20
> [1]=20
> https://lore.kernel.org/all/20240227010432.714127-1-thinker.li@gmail.com/

So, it appears that with shadow types users would have more or less
convenient way to disable / enable related BPF programs
(the references to programs are available, but reference counting
 would have to be implemented by user using some additional data
 structure, if needed).

I don't see a way to reconcile shadow types with this autoload/autocreate t=
oggling
=3D> my last two patches would have to be dropped.

Wdyt?


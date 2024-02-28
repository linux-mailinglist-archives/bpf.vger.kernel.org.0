Return-Path: <bpf+bounces-22964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0236386BC50
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 00:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB75C287ACE
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 23:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3B472910;
	Wed, 28 Feb 2024 23:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fojOptpl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4759513D2E8
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 23:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709163888; cv=none; b=BR6n+DFp0llhZE6nRQr1qDMlFDeKmjdDK0xPcgmfCHSuzRnJWPzgBjYdlxvNCiyFNP5OiJb/apRy5qnHM03cEtOrZvnbHky8wZUftj1w1BgiPMHt6tiSsPUKICSXDgIeOLsTRldiUzDalDMMelCMWn639VSWdWa3QLIjcC4FpLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709163888; c=relaxed/simple;
	bh=fnlXzS7etZrvzpJdsc1VXVvs8X5zhDFb0GuoMZ+514A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jdQyxbxBtcL0Wwhoc9XtwLmtnvxm4LC9oXq6UF+Jd6cZUcHSp7Hwx95Bu8v8b3g6TMrU+gg0GNjAJklgrrlX8gznrFEbjC+WxDB0uAhjRXAE4k5QZReWvWiOqr8OUhDAzySp4lIsLXIl6Paz4L6tuAIAuZ79OwrlN+ZT6TK6gJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fojOptpl; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-51325c38d10so6016e87.1
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 15:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709163885; x=1709768685; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vsp/RQ+fM/51gjS3q7TlLu1AAWo/DTWdiHPkD7rDdCQ=;
        b=fojOptplGf4drWdXSSKfKGNn4p2CshQ6Cz6CPUT/JNyUW/HJd0nriMF24Qc3dM2GcG
         WPf0Tt4hAbwvEkIwi7OzhEIgCnkiTckmJkyBEJOPmSwgPT1bjkR3WeZBTM0NoD2TyhTt
         tv5IwWKAxVHWqmvNOW3JmMInY3E0JumHyZNtjQxHz6UDQZZuw4+KInS1v7cyGWNZ7izV
         ygJe9/ehVHf8ClDrkN8Kw00Cm2pijBTabmXOvleg0nv/1EJuHxn/KJ4HwN6ZjRpfWAtX
         NUpS+nGz5w3pruAx9+nn8kAsFWjPSuIy6uXtpaAKVuAM+fDtio3vadVBMiJVO42UaKhT
         7QfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709163885; x=1709768685;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vsp/RQ+fM/51gjS3q7TlLu1AAWo/DTWdiHPkD7rDdCQ=;
        b=pp754+L8AHU+XOXUPserTv7QvZqIFUKZOyq2xjzOKbyAYcxhNw/Netce3/X92emzZu
         sC+Ft28b82z6W4Ou5vwm2CR2Zh++67WhXZczRS6jW+S6coWXiLtvdUmqZW9zoETD0Cz+
         cSjLqFZYktxmqXlSs5IrdCFL7KFmVzTX1Fn2yGVQK0wl5B8D4H6JzcrIYhC5IuFPHywy
         8mSTkBRFYoLLOj/cUVdKtar000K7q91KNJ+sY6drhaXrNSAYEDXUAP/KwMzU9rSonDW1
         d+UjaPvQIBozo9JR5jOEvxiVbA0Fo2RgwLmja7O/kksGfxJDuNXt0b1U75NGh67wH2p9
         yG6Q==
X-Gm-Message-State: AOJu0YzHphSaEg7et7+T/exGzbzJ8CVviR9+XXpJm/QvKgjgSHyinb7N
	rTDXUdWybbzZSiFZqceSAEa+VgWjPix1jwFGYyIJ02heL5bdkG1o
X-Google-Smtp-Source: AGHT+IEGkId5J8z72NoG6GiIegfyRt4/NdgSHG0tB/oj066NnnjcMgTXN+6Lzf8Ssoe7G1IewmIjwQ==
X-Received: by 2002:ac2:4478:0:b0:512:eb44:1ea1 with SMTP id y24-20020ac24478000000b00512eb441ea1mr100383lfl.21.1709163885365;
        Wed, 28 Feb 2024 15:44:45 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id er15-20020a05651248cf00b005131e4804f9sm31115lfb.190.2024.02.28.15.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 15:44:44 -0800 (PST)
Message-ID: <81fd7d298578b2bbc3d7a117c8e2144adbd0fb4b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 5/8] selftests/bpf: bad_struct_ops test
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  void@manifault.com
Date: Thu, 29 Feb 2024 01:44:38 +0200
In-Reply-To: <CAEf4BzaDwpTVwc_wTT74EthE5g11URiysNeuu6V+HDKrWXEnfQ@mail.gmail.com>
References: <20240227204556.17524-1-eddyz87@gmail.com>
	 <20240227204556.17524-6-eddyz87@gmail.com>
	 <CAEf4BzaDwpTVwc_wTT74EthE5g11URiysNeuu6V+HDKrWXEnfQ@mail.gmail.com>
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

On Wed, 2024-02-28 at 15:40 -0800, Andrii Nakryiko wrote:
[...]

> > +static libbpf_print_fn_t old_print_cb;
> > +static bool msg_found;
> > +
> > +static int print_cb(enum libbpf_print_level level, const char *fmt, va=
_list args)
> > +{
> > +       old_print_cb(level, fmt, args);
> > +       if (level =3D=3D LIBBPF_WARN && strncmp(fmt, EXPECTED_MSG, strl=
en(EXPECTED_MSG)) =3D=3D 0)
> > +               msg_found =3D true;
> > +
> > +       return 0;
> > +}
> > +
> > +static void test_bad_struct_ops(void)
> > +{
> > +       struct bad_struct_ops *skel;
> > +       int err;
> > +
> > +       old_print_cb =3D libbpf_set_print(print_cb);
> > +       skel =3D bad_struct_ops__open_and_load();
>=20
> we want to check that the load step failed specifically, right? So
> please split open from load, make sure that open succeeds, but load
> fails

Ok

>=20
> > +       err =3D errno;
> > +       libbpf_set_print(old_print_cb);
> > +       if (!ASSERT_NULL(skel, "bad_struct_ops__open_and_load"))
> > +               return;
> > +
> > +       ASSERT_EQ(err, EINVAL, "errno should be EINVAL");
> > +       ASSERT_TRUE(msg_found, "expected message");
> > +
> > +       bad_struct_ops__destroy(skel);
> > +}
> > +
> > +void serial_test_bad_struct_ops(void)
>=20
> why does it have to be a serial test?

Because it hijacks libbpf print callback.

[...]


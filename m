Return-Path: <bpf+bounces-22919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D87386B8D5
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 21:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FDB028CF12
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 20:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1677E5E093;
	Wed, 28 Feb 2024 20:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaKeiTC4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF1B5E082
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 20:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709150786; cv=none; b=kn7jd0RA4gemBY6MFYB9kPrXCxEBc08tU3FcGHNLkO5M8jyEtE19FPbPuyNf8PRAzKyy7Kc5oWvA61+h2kODFYfS7lpuSF2VNfZrRbSJuQaIUt4ma86f3SzjkSgmTToAgwIwsAgKHsRhFDtjjtavf5PniegnwmWLzRkVmqfwZPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709150786; c=relaxed/simple;
	bh=OJhZvb50czgMY+2rkEecAtG8LQmeGeSonF1jI+5r47c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iv+6haa0LDZhx+Ql+gDwzCIUXTTcAuXWi2+X/o20T8qcfT/JcOcIN0yMSLhzoxwZasUkFpcaVXOt4ppkGjexapyKePEFe9UxTAhQnsj3saaVMmq5cv7zol+0TCBNvVIJRFlwx7nY7sh7sIUXirm3u3TzAh552pNw0RCa0zQvQro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AaKeiTC4; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d23d301452so1531321fa.1
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 12:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709150783; x=1709755583; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qgqY3fIBnbE5bytxYqqZZl7UkD8tNzxu57ORx7dfzeg=;
        b=AaKeiTC47ukYqyOYe+imNSnT/2zDhoYPLobe24lMns+X/HKl0WyIsgzcZm7lLlz5l5
         zIXP15yqh5a8CXQkSVUph88dDzLhcdvtk/i/hLiN8WrgNCYLP48uzQl45szxdrWzB0UR
         ZsC8eKjC+jb9hzSSmcF4VKDNrFSUGHodEeqiql3kGIWtr4903/a7wyJDZCs0fPdC6FUU
         6cMtA0u2WjO83LFx9vuZNL2ORfqoM5IiHYVtSX49zkXqFXBR/DJTpck4mRTUfkrLe/xE
         HTxZ+uIedt6j4z+8hDTktpMv+XJbCuVLAIIydllw+yugMJqI5O9ydRewPTjPYn6o90sV
         qt9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709150783; x=1709755583;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qgqY3fIBnbE5bytxYqqZZl7UkD8tNzxu57ORx7dfzeg=;
        b=DE2DgM2OU7B6ydcJLOwNveehu5Q2OCYIMly8R6hMEEGBygoscnh/rwGOpro6npkHeO
         6wF4y0u30uuwEZ3sBHEv+7qKtGNqH9TI7UInuPnc4ecQi+vwJCyG+9NQLnh0wzQB3Dvn
         KVDkcZHGsyaiolqATycVapGsfUpPtJoahS0exXZmavwjw9Dp8AoJNteM1hGy3IQormeU
         DC/hTpeBbrLBit8Y0VxL2rfQOf07vCF9F91NyvdHVb8l3nrE8wJder1K266VNxJKviUS
         OuvLyC9kbhi/vX9nZNz+wd5Eom9PMWeIhufR4W9hlhYjZMZGojTeDf3HK0UaE35epRBX
         SHiA==
X-Gm-Message-State: AOJu0YwUlF1cebQTE5Ut1R1A0WJUYB6EbxycOvBPoWlScegv1UhQzAWq
	9KTcJCt7+XEspSOtbhhhSckBSkwsKxi7nPDOx4U9w+S437dhZW7Al1U6PK49
X-Google-Smtp-Source: AGHT+IEO/wJultIFTQNFJ9HbZYGmiWdxC5unWBUzXG2xc9zlheTjyk12NsXc5E9FeLUBrkYE4/AmRg==
X-Received: by 2002:a05:651c:b0b:b0:2d2:d449:6425 with SMTP id b11-20020a05651c0b0b00b002d2d4496425mr1989489ljr.35.1709150782807;
        Wed, 28 Feb 2024 12:06:22 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id n6-20020a2e8786000000b002d0aad9dcfcsm22594lji.59.2024.02.28.12.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 12:06:22 -0800 (PST)
Message-ID: <8771665b7c0d607896b533e8c973785b28b5af0f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 5/8] selftests/bpf: bad_struct_ops test
From: Eduard Zingerman <eddyz87@gmail.com>
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev
Date: Wed, 28 Feb 2024 22:06:21 +0200
In-Reply-To: <20240228181552.GG148327@maniforge>
References: <20240227204556.17524-1-eddyz87@gmail.com>
	 <20240227204556.17524-6-eddyz87@gmail.com>
	 <20240228181552.GG148327@maniforge>
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

On Wed, 2024-02-28 at 12:15 -0600, David Vernet wrote:
[...]

> > +static libbpf_print_fn_t old_print_cb;
> > +static bool msg_found;
> > +
> > +static int print_cb(enum libbpf_print_level level, const char *fmt, va=
_list args)
> > +{
> > +	old_print_cb(level, fmt, args);
> > +	if (level =3D=3D LIBBPF_WARN && strncmp(fmt, EXPECTED_MSG, strlen(EXP=
ECTED_MSG)) =3D=3D 0)
> > +		msg_found =3D true;
> > +
> > +	return 0;
> > +}
>=20
> Not necessary at all for this patch set / just an observation, but it wou=
ld be
> nice to have this be something offered by the core prog_tests framework
> (meaning, the ability to assert libbpf output for a testcase).

This might be useful, I will add a utility function for it (probably two).

[...]

> > diff --git a/tools/testing/selftests/bpf/progs/bad_struct_ops.c b/tools=
/testing/selftests/bpf/progs/bad_struct_ops.c
> > new file mode 100644
> > index 000000000000..9c103afbfdb1
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/bad_struct_ops.c
> > @@ -0,0 +1,17 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <vmlinux.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +#include "../bpf_testmod/bpf_testmod.h"
> > +
> > +char _license[] SEC("license") =3D "GPL";
> > +
> > +SEC("struct_ops/test_1")
> > +int BPF_PROG(test_1) { return 0; }
> > +
> > +SEC(".struct_ops.link")
> > +struct bpf_testmod_ops testmod_1 =3D { .test_1 =3D (void *)test_1 };
>=20
> Just to make be 100% sure that we're isolating the issue under test, shou=
ld we
> also add a .test_2 prog and add it to the struct bpf_testmod_ops map?

You are concerned that error might be confused with libbpf insisting
that '.test_2' should be present, right?
libbpf allows NULL members but I can add '.test_2' here, no problem.

[...]


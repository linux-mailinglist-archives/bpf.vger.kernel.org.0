Return-Path: <bpf+bounces-20612-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 820A7840B1B
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 17:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B52981C21EC9
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 16:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4243155A5F;
	Mon, 29 Jan 2024 16:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcHkh/eF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD188155A3C
	for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 16:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706544955; cv=none; b=dX4gxxIt6d8n5cKXzXCUhhIjKvCwWR7uiMQuJVAlm2w/EN1KLY0X4GPTVaulBCuyB9gvchAwDFuyndjaTyHI0sBN4KkFD8wk/0zQCK1IC+PmUPt4xjJh/Jsxd/Q/P2e5pnlETUgDsfBC0hivoQIHcDwjH9Ytq7ihJuzlY9Pm7SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706544955; c=relaxed/simple;
	bh=NN3dQsWewzCrrHPgmOKPSoJluDpOa36SljbnyQPtTbg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tv1EYzL5hsE+TGt+kKxZ2UwL6u+yBDLUPKSrOOhs91S3+Uw9IGQbzlEzio3lpUXYJEcxbd3Qn6G/0rfn+hkrWO/UhBa8UCyGE8+SAukCTj7CKPkHJdNiGjEfWNfJLZcVUqcJN3neXf40HuS8PzWUorPog8Ay67ZrsIcA6G4+D6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcHkh/eF; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5110f515deaso1967438e87.2
        for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 08:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706544952; x=1707149752; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CGOsxXMO+WExRs9EJmAadSGoHaZ/BDne/lN3MbU2Jy0=;
        b=KcHkh/eF5SEBjnROFSGWbyUcOE2kArzIXEC0nqOKTOkxK0PbECiSKVE/s4cjbzJfYF
         Nu/ychOHcKZ0xA9uVWMmQZKGP5NfLMmTR1GDf3TxpeXOi9gfzn9QuS+02wnFj4ulISUW
         gw7yqOBuhQtL8MjphUCibh7nVMwc2HIO5+SCYVJgN3zOz7jHJLbZk7e+ea8gECuMOwfz
         cFJM7jJrU5NsnC46gmhEnIQSV7iL+KarH3un0x2RZzobEMGkF5y46y+oYGic43Y5t0f1
         SMaWHme6SaDwxoGqoxtHvYhzK2so7CZ8ExzPt5+Dgh9ADcfmWPvMQW174xoxwD4BvDAD
         5eGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706544952; x=1707149752;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CGOsxXMO+WExRs9EJmAadSGoHaZ/BDne/lN3MbU2Jy0=;
        b=Gp6i4BEeZWlORMNARLWEaZCnpWlrOLynvappYzdmlDnuPXKbB2U3zpQeotHAQPgCCC
         ELp3P+Xx88Uk70oDIKLvMxKQQqDZcPvH4x00ACGWLa6QVUeARwiYYr83Kt/+esfa5IIN
         wf9JsjXlOS1F0ek6F4n3U59DAT/DNIazLWqXGQcTHcqpla+uxkNJXFPx7OIFuz1OG6Lw
         Iof9tM/kZsKNm7tGyBC38F5A+4BZZtwaC5QPE9okJfNo+0JZyzrv3Cl4t0TlzQJkt5Gj
         YiuwI7DSjK7mKStzR2FyjFZkdkAdwTwtg9kNa2Y9EYvFKA+aKEFNn6sgpOgtgK3IGSFU
         fXSw==
X-Gm-Message-State: AOJu0Yys2/Y0c2sVrUgyvthuaQxcQVKvmvDvlzQvn45DPBFjW8fqc+uo
	0+Invhw17pQ0JBtrk5Cv8gKEPqnEv6ejL27PnE9zXyIj5C6WDsEI7YBxXo2X
X-Google-Smtp-Source: AGHT+IE+Zr15g16+n0/ioqKtf4LMeAonbzZuzmQ+Teo5ATt8jJi9E2tH5PVmT1qEFnkNJRlu8GB1Iw==
X-Received: by 2002:ac2:52b5:0:b0:510:2365:2e0f with SMTP id r21-20020ac252b5000000b0051023652e0fmr3872790lfm.36.1706544951562;
        Mon, 29 Jan 2024 08:15:51 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id qt9-20020a170906ece900b00a35c5acc51bsm1020611ejb.160.2024.01.29.08.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 08:15:51 -0800 (PST)
Message-ID: <6819204566bfae73c140938920eeb389d27abad8.camel@gmail.com>
Subject: Re: BPF selftests and strict aliasing
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, "Jose E. Marchesi"
	 <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, david.faust@oracle.com,
 cupertino.miranda@oracle.com,  Yonghong Song <yhs@meta.com>
Date: Mon, 29 Jan 2024 18:15:39 +0200
In-Reply-To: <04efa2a3-ca81-42c3-883f-5b91917f2bde@linux.dev>
References: <87plxmsg37.fsf@oracle.com>
	 <b1906297-d784-479b-b2f3-07ab84ae99c1@linux.dev>
	 <87a5opskz0.fsf@oracle.com>
	 <04efa2a3-ca81-42c3-883f-5b91917f2bde@linux.dev>
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

On Sun, 2024-01-28 at 21:33 -0800, Yonghong Song wrote:
[...]
> I tried below example with the above prog/dynptr_fail.c case with gcc 11.=
4
> for native x86 target and didn't trigger the warning. Maybe this requires
> latest gcc? Or test C file is not sufficient enough to trigger the warnin=
g?
>=20
> [~/tmp1]$ cat t.c
> struct t {
>  =C2=A0 char a;
>  =C2=A0 short b;
>  =C2=A0 int c;
> };
> void init(struct t *);
> long foo() {
>  =C2=A0 struct t dummy;
>  =C2=A0 init(&dummy);
>  =C2=A0 return *(int *)&dummy;
> }
> [~/tmp1]$ gcc -Wall -Werror -O2 -g -Wno-compare-distinct-pointer-types -c=
 t.c
> [~/tmp1]$ gcc --version
> gcc (GCC) 11.4.1 20230605 (Red Hat 11.4.1-2)

I managed to trigger this warning for gcc 13.2.1:

    $ gcc -fstrict-aliasing -Wstrict-aliasing=3D1 -c test-punning.c -o /dev=
/null
    test-punning.c: In function =E2=80=98foo=E2=80=99:
    test-punning.c:10:19: warning: dereferencing type-punned pointer might =
break strict-aliasing rules [-Wstrict-aliasing]
       10 |    return *(int *)&dummy;
          |                   ^~~~~~
   =20
Note the -Wstrict-aliasing=3D1 option, w/o =3D1 suffix it does not trigger.

Grepping words "strict-aliasing", "strictaliasing", "strict_aliasing"
through clang code-base does not show any diagnostic related tests or
detection logic. It appears to me clang does not warn about strict
aliasing violations at all and -Wstrict-aliasing=3D* are just stubs at
the moment.


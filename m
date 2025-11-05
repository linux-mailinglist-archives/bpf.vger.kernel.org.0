Return-Path: <bpf+bounces-73742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C747C38437
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 23:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D8C1434D380
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 22:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C91E2E8DF5;
	Wed,  5 Nov 2025 22:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8bBTb0S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26322D0C60
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 22:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762383142; cv=none; b=m9zTf1/fqKB0cAFRiiBQhBMUquWUXY7fDgWQd51LRSTEn/ku4reU7kacLyff3yHvkrQCuml6VAwnLj09iKJ4auF4dodJ/fGhw4WZBy6y6FR7Ukcf+PfcvFN77MjY5eI6oK7F0QB6TpR5stoeijlegFm8zIr2hdH7pVPKGDIbSww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762383142; c=relaxed/simple;
	bh=l5JUzmodHo5k0pjByQaXoLIRkMflBv6P4mXMmvNQqLg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BWxHSCMXsUmlE3z2Ems7PbUDC8i30FKk7mjDWmvgVQ1arQA7RUWsdC2m4wxycxddQoRwbhVPGryQHv06hlWFt+8Kh9asJ6VzMvi/VCcJ8c88SyPERvHTrFLj5gPvdbeqtVaFmnt0/ckKlIfj6+Vbw7d4w52VfsnFJQujzP4+xVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8bBTb0S; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b556284db11so228540a12.0
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 14:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762383140; x=1762987940; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1FJexW1JYx6DxuL3q/fhfUe6qlvpO4i0LqL1JMZwwtI=;
        b=N8bBTb0Szaaveb3zDVpKbBvHNVCGRJ0xJ2t5we6HPGE5IHv0PkzZrfLNhHT8OxJ3e7
         qB6DYyKeK1rfqTMjtA7I8sYMoBK/o0NgTshTJ85wLgz+Gw9T2Cy9qX5OoRuiJBl45B7p
         PiEAqVLDqKw8GkaUDX1mGJl1Uo0yQoHrucbZI/jYViEUnCPCKYL7xzs89s1D6hDm+GUA
         YlDcYzGJ3E0PV2cVqKSXu4STvQ/hrefVaO6meEoovcAcF/xCa4v7/Zp5bUfTVDbryDDH
         wXsj1nXU4hM4QTm+LXsudA6SDqj/+nNUmV3V0S5gWc/xRLoGhSZM7nfVlAoFMTv7OdZi
         YDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762383140; x=1762987940;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1FJexW1JYx6DxuL3q/fhfUe6qlvpO4i0LqL1JMZwwtI=;
        b=xQDgUfYYvgcEKUzC2M+fBa+aUvPwdKlcwkoIa557vRJ+BM1jbOrWU/eLfA+E4BWO04
         vrYvOAVMi3zi3oPRUZRmPhNeVC6OQZNQPmUQAHyp3dvhz9IfqsPTgc73POoAM60MpfSn
         QoR1Py9o7UmPMiptnUu0pI2cPm88VCVT/ixPcgwoh1w/ldHBFNW8ILHuSENoOa1ab/Ih
         3vzQv8Ae9o39KbTRNrTaxcE5dwmZJj8X1Zr5TfVm5Gmfl1NKMyuTTrE4nk6hy3u2aA6h
         kNgj9l/UBn5jAC7tXJDmowoM3O3qLXfkQIm1433r7vITY74hHNrfmks0Ie7t8qAZYSGS
         wc+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXx0nECsR5TZhyvXhggKaR6kca2suld9K+JyztCy1r79o/qlEVfKYzsy390C5HTzktufQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy0qiWYo+r92zkp+oey9b7qJMi0U88C/ljHhS5/PAAkLXIQBfO
	s3oQU/yj8WZTurtiHlljxPujToKo2YirHVbyvLvnamYMsVWGu6nlCU+1
X-Gm-Gg: ASbGncupUKqwKtdaGOWNXByg1t+6GuEeO9xjHTLeWp5LWVwc7tvcL4iJS/8moSFaSFc
	N+H1jdrXOt8sqc6ezOYyTJgRUtTJ6PnK3QyB9fQbupubFZidQeR+AGU7trO8KzZnfzFmfbguJvT
	Lt141mWdKciOWmI+D+YWz/cMhV99PFtG/sf7E5GLRO1REJDKk9dfLjvE7YqG35FSdcaWJ6+WR1i
	hYRxyRQrLh4dmQg+sNA+fCPV9mt5NgfIftcpcI4HYihz4sAiRf+aRm+SxEjtIwTplzqa7iXa9Wv
	dDkd2M3mc1cIAaxyqN+GP2VM7VSMzYigDv5UdsvOcfz19YRwwf2WL4GPaVBYjHKbU90236YiBq4
	i3QhICNum38uhNJTttQOa7tKS6k6qS8EVjS+610gNg6dlWuaY/GXCyn/jf4xzIIsJLhmcgDqmff
	QaaBTWDiJ1iSt79TpP2nvIOHmAmZUmay/clMA=
X-Google-Smtp-Source: AGHT+IFFcgx9KXj+jLf79Pju5kq5jwAVtbDiZ7dkTm0x2E6aEFwhvXO7JjhTU0TeYTFMldVIg3jsGQ==
X-Received: by 2002:a17:902:cecd:b0:269:91b2:e9d6 with SMTP id d9443c01a7336-2962adb61b9mr78252305ad.46.1762383139845;
        Wed, 05 Nov 2025 14:52:19 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:cdf2:29c1:f331:3e1? ([2620:10d:c090:500::6:8aee])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba902c9d0d4sm346296a12.36.2025.11.05.14.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 14:52:19 -0800 (PST)
Message-ID: <b3f13550169288578796548f12619e5e972c0636.camel@gmail.com>
Subject: Re: [bpf-next] selftests/bpf: refactor snprintf_btf test to use
 bpf_strncmp
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Hoyeon Lee
	 <hoyeon.lee@suse.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  bpf <bpf@vger.kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau	 <martin.lau@linux.dev>, Song Liu
 <song@kernel.org>, Yonghong Song	 <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh	 <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo	 <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,  "open list:KERNEL
 SELFTEST FRAMEWORK"	 <linux-kselftest@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Date: Wed, 05 Nov 2025 14:52:18 -0800
In-Reply-To: <CAADnVQK7Qa5v=fkQtnx_A2OiXDDrWZAYY6qGi8ruVn_dOXmrUw@mail.gmail.com>
References: <20251105201415.227144-1-hoyeon.lee@suse.com>
	 <CAADnVQK7Qa5v=fkQtnx_A2OiXDDrWZAYY6qGi8ruVn_dOXmrUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-05 at 14:45 -0800, Alexei Starovoitov wrote:
> On Wed, Nov 5, 2025 at 12:14=E2=80=AFPM Hoyeon Lee <hoyeon.lee@suse.com> =
wrote:
> >=20
> > The netif_receive_skb BPF program used in snprintf_btf test still uses
> > a custom __strncmp. This is unnecessary as the bpf_strncmp helper is
> > available and provides the same functionality.
> >=20
> > This commit refactors the test to use the bpf_strncmp helper, removing
> > the redundant custom implementation.
> >=20
> > Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
> > ---
> >  .../selftests/bpf/progs/netif_receive_skb.c       | 15 +--------------
> >  1 file changed, 1 insertion(+), 14 deletions(-)
> >=20
> > diff --git a/tools/testing/selftests/bpf/progs/netif_receive_skb.c b/to=
ols/testing/selftests/bpf/progs/netif_receive_skb.c
> > index 9e067dcbf607..186b8c82b9e6 100644
> > --- a/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> > +++ b/tools/testing/selftests/bpf/progs/netif_receive_skb.c
> > @@ -31,19 +31,6 @@ struct {
> >         __type(value, char[STRSIZE]);
> >  } strdata SEC(".maps");
> >=20
> > -static int __strncmp(const void *m1, const void *m2, size_t len)
> > -{
> > -       const unsigned char *s1 =3D m1;
> > -       const unsigned char *s2 =3D m2;
> > -       int i, delta =3D 0;
> > -
> > -       for (i =3D 0; i < len; i++) {
> > -               delta =3D s1[i] - s2[i];
> > -               if (delta || s1[i] =3D=3D 0 || s2[i] =3D=3D 0)
> > -                       break;
> > -       }
> > -       return delta;
> > -}
> >=20
> >  #if __has_builtin(__builtin_btf_type_id)
> >  #define        TEST_BTF(_str, _type, _flags, _expected, ...)          =
         \
> > @@ -69,7 +56,7 @@ static int __strncmp(const void *m1, const void *m2, =
size_t len)
> >                                        &_ptr, sizeof(_ptr), _hflags);  =
 \
> >                 if (ret)                                               =
 \
> >                         break;                                         =
 \
> > -               _cmp =3D __strncmp(_str, _expectedval, EXPECTED_STRSIZE=
); \
> > +               _cmp =3D bpf_strncmp(_str, EXPECTED_STRSIZE, _expectedv=
al); \
>=20
> Though it's equivalent, the point of the test is to be heavy
> for the verifier with open coded __strncmp().
>=20
> pw-bot: cr

I double checked that before acking, the test was added as a part of [1].
So it seems to be focused on bpf_snprintf_btf(), not on scalability.
And it's not that heavy in terms of instructions budget:

File                     Program                  Verdict  Insns  States
-----------------------  -----------------------  -------  -----  ------
netif_receive_skb.bpf.o  trace_netif_receive_skb  success  18152     629


[1] https://lore.kernel.org/bpf/1601292670-1616-5-git-send-email-alan.magui=
re@oracle.com/


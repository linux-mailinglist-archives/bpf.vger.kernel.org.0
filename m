Return-Path: <bpf+bounces-65928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA45B2B408
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 00:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19732523E08
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 22:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2877B2144CF;
	Mon, 18 Aug 2025 22:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfAKMXMv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C6F1E0B9C
	for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 22:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755555405; cv=none; b=sisLYQxBlqIza7vMiQ1VMkuwYL4eIeimUKnQr6BgT70cKo+3gpjNzjaya7d21dKRaLOkvrTtX3LYZvjWm08kcPGHRcO797Ytw3NDhY15gCV0hZsGypKXsmqJDOj8WXbL1NKj5m5xtt1svOA3GaZeSfNWysXwGPVhnsqLAamfTo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755555405; c=relaxed/simple;
	bh=aUA6aO1HcwzEJcULY15Y1pCNmV3ikYWel5OkH07Bwhs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q0K02B64h0k+bK/pUE9IkPLNnofHZjjYTlx8sL95Iypj7lnV3ge5BRLK/7wxbrYE24xuI3BkJGstjmbIeT7CSlWVYdag5c5AqzxQvSS9JGvDYMn2UpWyb1/5aSf/nZw3B9zXR3g8lrpV7c8DfchRjMKpKeZYPGxWF8pdqDR4smE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfAKMXMv; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b474d0f1d5eso784357a12.2
        for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 15:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755555404; x=1756160204; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U157OIeZP2+25U5RW5SpjaSpRqqTm+ey3HUjrcRp3PE=;
        b=OfAKMXMvMHXB6U2WmQz+APfV/maWp3J8159g033fTkwxta2fwHKi1U4CgapHQUfX0f
         zaVZlO+1jVQspoGevwAouy4v/y1xsOM2/cJMeeRl26kJ7i4RgasDdfdeTgPCWgjQnQzf
         vCDd46bp8fmgE35WX6AJkJaPc3YSOFSIzfOgR1UicNNzB7YczoQoYvEWK/tmbmSxmEb6
         UsmfI5mVQcmN0a/4edPICU9d/jomqib4L/20X6SaGSdnaJtoj3O108Nm6kgyecSqhr4B
         RqVHuZshFpARxPTmQnJikBI1viB0H3Voi1E2Y3KyhUdxudHgZXj6O5gDhD1k1XpOnaWN
         3ytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755555404; x=1756160204;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U157OIeZP2+25U5RW5SpjaSpRqqTm+ey3HUjrcRp3PE=;
        b=kb27Jmi62l5KRTcs4QHJhQZ28LauJEDa1oMv1eKBv+LIjKyD9stgQr3MgDlZDJuBBe
         cKaAh+Gi4Cf6eEFEpsD55HQHA81RSD3ChbJ+kzpcpkXBtXE9aLBBkMMu8gFqUPEUtzWf
         H6IP0jnhnyDA/sa2QMvh/gbjj7UttTb5XcbK8LpgVF0uz3GpRYPm705YacLkN14nsuNK
         iwNzyzoXx+B1vmW685sEGCVnLCNMtwMOaWThROj1CAaQ/PuUVrw9W/3awlewSXW0hEp+
         qRf+V1EY16v7rw93QKndTlk/yNnxvGicZec+fMmpEoDv9FD317Z/U5NIFQxQT2h1URM0
         SFgw==
X-Gm-Message-State: AOJu0Yz3W3S5m+nVcx0rTn50O6fPWmJW19cvngyVNV+XwvS37DlLNXnB
	X01XrXRq5eAEsM8mpTNvg/+Ieo72bgcJCOAZlzhC12DkZN0Yb7FUn25GsacQV/N6
X-Gm-Gg: ASbGnctweLImmOCgDDp5AdBum9wdqKwgfsGazPXzO2ai07QISPRjruS8QzJro+iavDV
	BB/h2hcgHUrMuERlqfmTN+sSG/rOt1MNu2Ykp7ptVgjC/obaY2HUTg4nqZZONMkDlQdtwcIHt2d
	4K2WuFIwaR/FmbwgR92QYUH2e6MmhzN+8L9j1+S8POT4pgmwcQbWoYFay4c7lfX15UVcoZdUftA
	vgkeFSrNTyW2MUDiq+x0SpuX/ndfmFDDX+gFPYv4YaCtYMVRvjubkjVsuw27RVnlOtfbBxUymO6
	onDPjyr2VBH6C8l4xmeR2fShCkuTF8ZXBOa/GumxqN7YUwcg2Cbfesdg0C7cFyXC39ojyYJT+iZ
	xAISDbt+XhjOVAeozXFS8WQ8aydla
X-Google-Smtp-Source: AGHT+IFlP3+9TunGn+9SQwdn7IlJO7MjwjIFsvLu3Tzz/6XptEPKaw/E8y74S4ZyGNKdIyM8DWnVbA==
X-Received: by 2002:a17:903:2f48:b0:240:49d1:6347 with SMTP id d9443c01a7336-245e0484aa5mr3116515ad.35.1755555403511;
        Mon, 18 Aug 2025 15:16:43 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::8c7? ([2620:10d:c090:600::1:2a59])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d5ae524sm89631585ad.168.2025.08.18.15.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 15:16:43 -0700 (PDT)
Message-ID: <7070ae77076342c295cc500e8c0eccd238e826d5.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpf: improve the general precision of
 tnum_mul
From: Eduard Zingerman <eddyz87@gmail.com>
To: Nandakumar Edamana <nandakumar@nandakumar.co.in>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann	 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Date: Mon, 18 Aug 2025 15:16:40 -0700
In-Reply-To: <e9549198-f0d6-466d-a104-99b228d35dde@nandakumar.co.in>
References: <20250815140510.1287598-1-nandakumar@nandakumar.co.in>
	 <e7cb82ac838e28620324f70907235d2b8c75262f.camel@gmail.com>
	 <e9549198-f0d6-466d-a104-99b228d35dde@nandakumar.co.in>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-08-16 at 10:28 +0530, Nandakumar Edamana wrote:
> On 16/08/25 00:40, Eduard Zingerman wrote:
>=20
>  > Could you please provide a selftest demonstrating a difference in=20
> behavior?
>  > What technique did you employ to estimate the number of cases when
>  > precision is improved vs worsened? If this is some kind of a program
>  > doing randomized testing, could you please share a link to it?
>=20
> Hi Eduard,
>=20
> Thanks for the quick response! I've made the test program available here:
> https://github.com/nandedamana/improved-tnum-mul

Hi Nandakumar,

Thank you for the link and for the algorithm explanation in the readme.
What tool do you use for code generation (ngg)?

[...]

> $ ./experi --bits 6
> ...
> mine vs kernel (bits =3D 6):
>  =C2=A0 better =3D 285059
>  =C2=A0 same=C2=A0 =C2=A0=3D 229058
>  =C2=A0 worse=C2=A0 =3D 17324
>  =C2=A0 myprod optimal cases=C2=A0 =3D 432406 / 531441
>  =C2=A0 linprod optimal cases =3D 202444 / 531441
> ----------------------------------------------------------
> is optimal? (bits =3D 6): 0

I did a more primitive jab at this in [1], comparing number of unknown
bits (`__builtin_popcountl(tnum.mask)`) for current vs proposed
tnum_mul() for all 8-bit tnums and got the following results:

  Tnums  : 6560
  New win: 30086328    70 %
  Old win: 1463809      3 %
  Same   : 11483463    27 %

[1] https://github.com/eddyz87/tnum_mul_compare/blob/master/README.md

[...]

> Regarding adding selftests, I'll look into that as well. It'd be great=
=20
> if you
> have any specific strategy in mind, wrt to this particular change. BTW, a=
ny
> set of BPF programs that are known to fail due to the imprecision in the=
=20
> current
> algorithm?

I don't know of any current examples failing because of lacking
multiplication precision. Given that your algorithm does not introduce
any new edge cases, I'd simply add a test case which is more precise
with the new algorithm. Just to have selftests that can detect the
change.


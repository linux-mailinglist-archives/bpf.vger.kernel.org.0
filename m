Return-Path: <bpf+bounces-38502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7272B9654AB
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 03:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 978931C22B2A
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 01:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4501A3715E;
	Fri, 30 Aug 2024 01:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKgRqv1d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CB1EEB7;
	Fri, 30 Aug 2024 01:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724981168; cv=none; b=kHmkrVkjXTo+KXqZim1vsaWU5bEFtyxJlaZ9f0rCC83nFZn7thM5UPFYmFPQjBvaEhgeHe9IB86onrDszUcAcHMo6MjT9fTEKuna7/cARQgtfZQV9slNHQrLmCTu8KKcj2XU0MoZZm0QCwuRVbVnnU+myPgmLQF4mLU3DRUNMjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724981168; c=relaxed/simple;
	bh=2wyCsHsRRJKdrWGdDuUb0aX5AzOF2ocHXCpBTc7CN1U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YFl8XikK6pA8dfgvtg3Iyxbp2/DJ06vL6ZQN4nB08I5SdG2MhKDFzlTjgps6IOW2ak+KPxJPYJE/5+a7P0/I5Gt3x4EUORBbnjfsPrhjKPEcFKxHdc0NfAQX+vHnyRXmU6LkUmCHidx5UTaHAOwXWPwrTcZzSurcHK95DQSoYVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKgRqv1d; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-202089e57d8so9513725ad.0;
        Thu, 29 Aug 2024 18:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724981166; x=1725585966; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=m+7+E/V+gTN7DwBR2G5JQp5vV0V1os8H7sXva99Hj6s=;
        b=OKgRqv1dz1t6Q76tO7urxshpGcI1YaO34Jov3VKYzEhgmlM/t6OaCB5mNsyKrXfoid
         b3YM4751bcLsbgazgKRaI5UkpmXo7iFtglYF0+LQA6/FqpXDWq79068IGOgUgvi0T17S
         AWpnZCQ6qsKbE11goEdZGSWrXRhSnhhx1BxJD6u8XsdHyhHpYz9GYadgmpK/FIW+JL91
         TONBlmpIMpaB807JJQVuRIXShMQYDQuYGLoZUsdRpp3wi/o2sSwJmW3uEmcn0gIyTgJF
         vfuzaU9X8+ODh+txR7h+HvkUHjw9Lclf0jK57czzQ6H38Gnmi0p701D9HYoPuqvMmyzG
         rpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724981166; x=1725585966;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+7+E/V+gTN7DwBR2G5JQp5vV0V1os8H7sXva99Hj6s=;
        b=oOQlmmntlGd0MueBdJcREEquSCgvAz19je9BJoWXm3ijMvCd8AoQ6w4GsNtNvCutRz
         quuEMkzdYEZ6QRbrAyWoBuIMWqnrXvYb64yls3hWIfk0VegYi3PqkPpNr+e12rz2afn3
         Dkm7e6CZD6XVwHdVwjm7sBLorc5k32LVceMwszuYGq/Q+5Jh6enws8ZGOBVi3VxYaUqD
         U6KZpw3fma1qAazryRS4/4tGC5+ru9msyLvFHSn27GqrYSdhsNit6EvO4E8VARh5DlmD
         ka0jMtMwZmPbLnJzVHmZk4/d7KuK9wxY//uTKT1P5CL3i9KKxxbdMtgSkyPx8FsI8g0B
         GKJA==
X-Forwarded-Encrypted: i=1; AJvYcCWTFRXvSOHRJqntJMDZWqNyZ784wjHEkTausl5EaWuVDK5w94eOWBdPTKlHc3/mKXIWLbM=@vger.kernel.org, AJvYcCXh/7Vv2p5I+5iCrFKePx/alM+nzfWIL0uskCVwFRmZhl91NhC5wPLSTWdvvdMepUGomOOIfy28YXHvtf94@vger.kernel.org
X-Gm-Message-State: AOJu0YyNBieS6vRvIEn6lZ4v/vJVrPAces0GBBoqk5Q31b7m+jxNaMin
	gW4kgHI1Se6phKDot/SJjiEwTkKSwjnjInXtRpHvPlLPHnCHEgdN
X-Google-Smtp-Source: AGHT+IFhhGY7colNmOH35tYfC30+IT9h7yd0VKLBHHZOJ9XsSJ8y9vlFBicfOhspTnRSyR1ZhwvQEQ==
X-Received: by 2002:a17:902:f60a:b0:1ff:4a01:43f7 with SMTP id d9443c01a7336-2050e97bf7bmr61338715ad.10.1724981166312;
        Thu, 29 Aug 2024 18:26:06 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515537704sm17255185ad.125.2024.08.29.18.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 18:26:05 -0700 (PDT)
Message-ID: <3a48e38f29cc8c73e36a6d3339b9303571d522a8.camel@gmail.com>
Subject: Re: [PATCH bpf] bpf: add check for invalid name in
 btf_name_valid_section()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Jeongjun Park <aha310510@gmail.com>, alexei.starovoitov@gmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net,  haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org,  linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, sdf@fomichev.me,  song@kernel.org,
 yonghong.song@linux.dev
Date: Thu, 29 Aug 2024 18:26:00 -0700
In-Reply-To: <d1ca563d8f2f5b63e7b0ec8b91c57914c32f1679.camel@gmail.com>
References: 
	<CAADnVQKsZ9zboc4k0mnrwcUv6ioSQ6aBXXC+t+-233n17Vdw-A@mail.gmail.com>
	 <20240829034552.262214-1-aha310510@gmail.com>
	 <d1ca563d8f2f5b63e7b0ec8b91c57914c32f1679.camel@gmail.com>
Content-Type: multipart/mixed; boundary="=-niWrXF/chqXzzhgAUdlz"
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-niWrXF/chqXzzhgAUdlz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2024-08-28 at 22:45 -0700, Eduard Zingerman wrote:

[...]

> I will prepare a test case.
> Probably tomorrow.

Please find test in the attachment. This test triggers KASAN error
report as in another attachment. (I enabled CONFIG_KASAN using
menuconfig on top of regular selftest config).

On Fri, Aug 23, 2024 at 3:43=E2=80=AFAM Jeongjun Park <aha310510@gmail.com>=
 wrote:

[...]

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 520f49f422fe..5c24ea1a65a4 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -823,6 +823,9 @@ static bool btf_name_valid_section(const struct btf *=
btf, u32 offset)
>         const char *src =3D btf_str_by_offset(btf, offset);
>         const char *src_limit;
>=20
> +       if (!*src)
> +               return false;
> +

I think that correct fix would be as follows:

---

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index edad152cee8e..d583d76fcace 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -820,7 +820,6 @@ static bool btf_name_valid_section(const struct btf *bt=
f, u32 offset)
=20
        /* set a limit on identifier length */
        src_limit =3D src + KSYM_NAME_LEN;
-       src++;
        while (*src && src < src_limit) {
                if (!isprint(*src))
                        return false;


--=-niWrXF/chqXzzhgAUdlz
Content-Disposition: attachment; filename="bad-name-test.patch"
Content-Type: text/x-patch; name="bad-name-test.patch"; charset="UTF-8"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL2J0Zi5j
IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dfdGVzdHMvYnRmLmMKaW5kZXggMDA5
NjVhNmU4M2JiLi5lYTRkM2Y2ZDVkZTkgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL2JwZi9wcm9nX3Rlc3RzL2J0Zi5jCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2Jw
Zi9wcm9nX3Rlc3RzL2J0Zi5jCkBAIC0zNTUwLDYgKzM1NTAsMjEgQEAgc3RhdGljIHN0cnVjdCBi
dGZfcmF3X3Rlc3QgcmF3X3Rlc3RzW10gPSB7CiAJfSwKIAlCVEZfU1RSX1NFQygiXDB4XDA/LmZv
byBiYXI6YnV6IiksCiB9LAoreworCS5kZXNjciA9ICJkYXRhc2VjOiBuYW1lICdcXDAnIGlzIG5v
dCBvayIsCisJLnJhd190eXBlcyA9IHsKKwkJLyogaW50ICovCisJCUJURl9UWVBFX0lOVF9FTkMo
MCwgQlRGX0lOVF9TSUdORUQsIDAsIDMyLCA0KSwgIC8qIFsxXSAqLworCQkvKiBWQVIgeCAqLyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvKiBbMl0gKi8KKwkJQlRGX1RZUEVf
RU5DKDEsIEJURl9JTkZPX0VOQyhCVEZfS0lORF9WQVIsIDAsIDApLCAxKSwKKwkJQlRGX1ZBUl9T
VEFUSUMsCisJCS8qIERBVEFTRUMgXDAgKi8gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IC8qIFszXSAqLworCQlCVEZfVFlQRV9FTkMoMywgQlRGX0lORk9fRU5DKEJURl9LSU5EX0RBVEFT
RUMsIDAsIDEpLCA0KSwKKwkJQlRGX1ZBUl9TRUNJTkZPX0VOQygyLCAwLCA0KSwKKwkJQlRGX0VO
RF9SQVcsCisJfSwKKwlCVEZfU1RSX1NFQygiXDB4XDAiKSwKK30sCiB7CiAJLmRlc2NyID0gInR5
cGUgbmFtZSAnP2ZvbycgaXMgbm90IG9rIiwKIAkucmF3X3R5cGVzID0gewo=


--=-niWrXF/chqXzzhgAUdlz
Content-Disposition: attachment; filename="bad-name-kasan-report.txt"
Content-Type: text/plain; name="bad-name-kasan-report.txt"; charset="UTF-8"
Content-Transfer-Encoding: base64

WyAgICA3LjAyNTcyOF0gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09ClsgICAgNy4wMjU5NzddIEJVRzogS0FTQU46IHNsYWIt
b3V0LW9mLWJvdW5kcyBpbiBidGZfZGF0YXNlY19jaGVja19tZXRhKzB4NzNjLzB4N2EwClsgICAg
Ny4wMjYxODVdIFJlYWQgb2Ygc2l6ZSAxIGF0IGFkZHIgZmZmZjg4ODEwOGVhYTVkNCBieSB0YXNr
IHRlc3RfcHJvZ3MvMTcyClsgICAgNy4wMjYzNThdIApbICAgIDcuMDI2NDMwXSBDUFU6IDIgVUlE
OiAwIFBJRDogMTcyIENvbW06IHRlc3RfcHJvZ3MgVGFpbnRlZDogRyAgICAgICAgICAgT0UgICAg
ICA2LjExLjAtcmM0LTAwMjI1LWcwNjczODg4Yjg0NjktZGlydHkgIzIzClsgICAgNy4wMjY2NzNd
IFRhaW50ZWQ6IFtPXT1PT1RfTU9EVUxFLCBbRV09VU5TSUdORURfTU9EVUxFClsgICAgNy4wMjY2
NzNdIEhhcmR3YXJlIG5hbWU6IFFFTVUgU3RhbmRhcmQgUEMgKFEzNSArIElDSDksIDIwMDkpLCBC
SU9TIDEuMTYuMy0yLmZjNDAgMDQvMDEvMjAxNApbICAgIDcuMDI2NjczXSBDYWxsIFRyYWNlOgpb
ICAgIDcuMDI2NjczXSAgPFRBU0s+ClsgICAgNy4wMjY2NzNdICBkdW1wX3N0YWNrX2x2bCsweDVk
LzB4ODAKWyAgICA3LjAyNjY3M10gID8gYnRmX2RhdGFzZWNfY2hlY2tfbWV0YSsweDczYy8weDdh
MApbICAgIDcuMDI2NjczXSAgcHJpbnRfcmVwb3J0KzB4MTcxLzB4NTAyClsgICAgNy4wMjY2NzNd
ICA/IGJ0Zl9kYXRhc2VjX2NoZWNrX21ldGErMHg3M2MvMHg3YTAKWyAgICA3LjAyNjY3M10gID8g
c3Jzb19hbGlhc19yZXR1cm5fdGh1bmsrMHg1LzB4ZmJlZjUKWyAgICA3LjAyNjY3M10gID8gX192
aXJ0X2FkZHJfdmFsaWQrMHgyMGMvMHg0MTAKWyAgICA3LjAyNjY3M10gID8gYnRmX2RhdGFzZWNf
Y2hlY2tfbWV0YSsweDczYy8weDdhMApbICAgIDcuMDI2NjczXSAga2FzYW5fcmVwb3J0KzB4ZGEv
MHgxYjAKWyAgICA3LjAyNjY3M10gID8gYnRmX2RhdGFzZWNfY2hlY2tfbWV0YSsweDczYy8weDdh
MApbICAgIDcuMDI2NjczXSAgYnRmX2RhdGFzZWNfY2hlY2tfbWV0YSsweDczYy8weDdhMApbICAg
IDcuMDI2NjczXSAgYnRmX2NoZWNrX2FsbF9tZXRhcysweDMyYi8weGFjMApbICAgIDcuMDI2Njcz
XSAgYnRmX25ld19mZCsweDZmYi8weDJkYzAKWyAgICA3LjAyNjY3M10gID8gc3Jzb19hbGlhc19y
ZXR1cm5fdGh1bmsrMHg1LzB4ZmJlZjUKWyAgICA3LjAyNjY3M10gID8gY3JlZF9oYXNfY2FwYWJp
bGl0eS5pc3JhLjArMHgxMzkvMHgyMzAKWyAgICA3LjAyNjY3M10gID8gX19wZnhfY3JlZF9oYXNf
Y2FwYWJpbGl0eS5pc3JhLjArMHgxMC8weDEwClsgICAgNy4wMjY2NzNdICA/IHNyc29fYWxpYXNf
cmV0dXJuX3RodW5rKzB4NS8weGZiZWY1ClsgICAgNy4wMjY2NzNdICA/IF9fcGZ4X2J0Zl9uZXdf
ZmQrMHgxMC8weDEwClsgICAgNy4wMjY2NzNdICA/IF9fcGZ4X2xvY2tfcmVsZWFzZSsweDEwLzB4
MTAKWyAgICA3LjAyNjY3M10gID8gc3Jzb19hbGlhc19yZXR1cm5fdGh1bmsrMHg1LzB4ZmJlZjUK
WyAgICA3LjAyNjY3M10gID8gc2VjdXJpdHlfY2FwYWJsZSsweDZmLzB4YjAKWyAgICA3LjAyNjY3
M10gID8gc3Jzb19hbGlhc19yZXR1cm5fdGh1bmsrMHg1LzB4ZmJlZjUKWyAgICA3LjAyNjY3M10g
IF9fc3lzX2JwZisweDEyNTEvMHg0NjUwClsgICAgNy4wMjY2NzNdICA/IHNyc29fYWxpYXNfcmV0
dXJuX3RodW5rKzB4NS8weGZiZWY1ClsgICAgNy4wMjY2NzNdICA/IF9fcGZ4X19fc3lzX2JwZisw
eDEwLzB4MTAKWyAgICA3LjAyNjY3M10gID8gc3Jzb19hbGlhc19yZXR1cm5fdGh1bmsrMHg1LzB4
ZmJlZjUKWyAgICA3LjAyNjY3M10gID8gZmluZF9oZWxkX2xvY2srMHgyZC8weDExMApbICAgIDcu
MDI2NjczXSAgPyBzcnNvX2FsaWFzX3JldHVybl90aHVuaysweDUvMHhmYmVmNQpbICAgIDcuMDI2
NjczXSAgPyBsb2NrX3JlbGVhc2UrMHg0NWEvMHg3YTAKWyAgICA3LjAyNjY3M10gID8gX19wZnhf
bG9ja19yZWxlYXNlKzB4MTAvMHgxMApbICAgIDcuMDI2NjczXSAgPyBfX3BmeF9fX3JzZXFfaGFu
ZGxlX25vdGlmeV9yZXN1bWUrMHgxMC8weDEwClsgICAgNy4wMjY2NzNdICBfX3g2NF9zeXNfYnBm
KzB4N2IvMHhjMApbICAgIDcuMDI2NjczXSAgPyBzcnNvX2FsaWFzX3JldHVybl90aHVuaysweDUv
MHhmYmVmNQpbICAgIDcuMDI2NjczXSAgPyBsb2NrZGVwX2hhcmRpcnFzX29uKzB4N2IvMHgxMDAK
WyAgICA3LjAyNjY3M10gIGRvX3N5c2NhbGxfNjQrMHg2OC8weDE0MApbICAgIDcuMDI2NjczXSAg
ZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NzYvMHg3ZQpbICAgIDcuMDI2NjczXSBS
SVA6IDAwMzM6MHg3ZjkzOThkMjgxZGQKWyAgICA3LjAyNjY3M10gQ29kZTogZmYgYzMgNjYgMmUg
MGYgMWYgODQgMDAgMDAgMDAgMDAgMDAgOTAgZjMgMGYgMWUgZmEgNDggODkgZjggNDggODkgZjcg
NDggODkgZDYgNDggODkgY2EgNGQgODkgYzIgNGQgODkgYzggNGMgOGIgNGMgMjQgMDggMGYgMDUg
PDQ4PiAzZCAwMSBmMCBmZiBmZiA3MyAwMSBjMyA0OCA4YiAwZCAwYiBkYyAwYyAwMCBmNyBkOCA2
NCA4OSAwMSA0OApbICAgIDcuMDI2NjczXSBSU1A6IDAwMmI6MDAwMDdmZmRkYzExYjQ4OCBFRkxB
R1M6IDAwMDAwMjA2IE9SSUdfUkFYOiAwMDAwMDAwMDAwMDAwMTQxClsgICAgNy4wMjY2NzNdIFJB
WDogZmZmZmZmZmZmZmZmZmZkYSBSQlg6IDAwMDA3ZmZkZGMxMWI5ZjggUkNYOiAwMDAwN2Y5Mzk4
ZDI4MWRkClsgICAgNy4wMjY2NzNdIFJEWDogMDAwMDAwMDAwMDAwMDAyOCBSU0k6IDAwMDA3ZmZk
ZGMxMWI1MDAgUkRJOiAwMDAwMDAwMDAwMDAwMDEyClsgICAgNy4wMjY2NzNdIFJCUDogMDAwMDdm
ZmRkYzExYjRhMCBSMDg6IDAwMDA3ZmZkZGMxMWIzMjAgUjA5OiAwMDAwN2ZmZGRjMTFiNTAwClsg
ICAgNy4wMjY2NzNdIFIxMDogMDAwMDAwMDAwMDAwMDAwNyBSMTE6IDAwMDAwMDAwMDAwMDAyMDYg
UjEyOiAwMDAwMDAwMDAwMDAwMDAzClsgICAgNy4wMjY2NzNdIFIxMzogMDAwMDAwMDAwMDAwMDAw
MCBSMTQ6IDAwMDA3ZjkzYTAxMTQwMDAgUjE1OiAwMDAwMDAwMDAxMDkwZDkwClsgICAgNy4wMjY2
NzNdICA8L1RBU0s+ClsgICAgNy4wMjY2NzNdIApbICAgIDcuMDI2NjczXSBBbGxvY2F0ZWQgYnkg
dGFzayAxNzI6ClsgICAgNy4wMjY2NzNdICBrYXNhbl9zYXZlX3N0YWNrKzB4MzAvMHg1MApbICAg
IDcuMDI2NjczXSAga2FzYW5fc2F2ZV90cmFjaysweDE0LzB4MzAKWyAgICA3LjAyNjY3M10gIF9f
a2FzYW5fa21hbGxvYysweDhmLzB4YTAKWyAgICA3LjAyNjY3M10gIF9fa21hbGxvY19ub2RlX25v
cHJvZisweDFhYy8weDQ5MApbICAgIDcuMDI2NjczXSAgYnRmX25ld19mZCsweDNlNC8weDJkYzAK
WyAgICA3LjAyNjY3M10gIF9fc3lzX2JwZisweDEyNTEvMHg0NjUwClsgICAgNy4wMjY2NzNdICBf
X3g2NF9zeXNfYnBmKzB4N2IvMHhjMApbICAgIDcuMDI2NjczXSAgZG9fc3lzY2FsbF82NCsweDY4
LzB4MTQwClsgICAgNy4wMjY2NzNdICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg3
Ni8weDdlClsgICAgNy4wMjY2NzNdIApbICAgIDcuMDI2NjczXSBUaGUgYnVnZ3kgYWRkcmVzcyBi
ZWxvbmdzIHRvIHRoZSBvYmplY3QgYXQgZmZmZjg4ODEwOGVhYTU4MApbICAgIDcuMDI2NjczXSAg
d2hpY2ggYmVsb25ncyB0byB0aGUgY2FjaGUga21hbGxvYy05NiBvZiBzaXplIDk2ClsgICAgNy4w
MjY2NzNdIFRoZSBidWdneSBhZGRyZXNzIGlzIGxvY2F0ZWQgMCBieXRlcyB0byB0aGUgcmlnaHQg
b2YKWyAgICA3LjAyNjY3M10gIGFsbG9jYXRlZCA4NC1ieXRlIHJlZ2lvbiBbZmZmZjg4ODEwOGVh
YTU4MCwgZmZmZjg4ODEwOGVhYTVkNCkKWyAgICA3LjAyNjY3M10gClsgICAgNy4wMjY2NzNdIFRo
ZSBidWdneSBhZGRyZXNzIGJlbG9uZ3MgdG8gdGhlIHBoeXNpY2FsIHBhZ2U6ClsgICAgNy4wMjY2
NzNdIHBhZ2U6IHJlZmNvdW50OjEgbWFwY291bnQ6MCBtYXBwaW5nOjAwMDAwMDAwMDAwMDAwMDAg
aW5kZXg6MHgwIHBmbjoweDEwOGVhYQpbICAgIDcuMDI2NjczXSBmbGFnczogMHgyZmZmZTAwMDAw
MDAwMDAobm9kZT0wfHpvbmU9MnxsYXN0Y3B1cGlkPTB4N2ZmZikKWyAgICA3LjAyNjY3M10gcGFn
ZV90eXBlOiAweGZkZmZmZmZmKHNsYWIpClsgICAgNy4wMjY2NzNdIHJhdzogMDJmZmZlMDAwMDAw
MDAwMCBmZmZmODg4MTAwMDQyMjgwIGRlYWQwMDAwMDAwMDAxMjIgMDAwMDAwMDAwMDAwMDAwMApb
ICAgIDcuMDI2NjczXSByYXc6IDAwMDAwMDAwMDAwMDAwMDAgMDAwMDAwMDA4MDIwMDAyMCAwMDAw
MDAwMWZkZmZmZmZmIDAwMDAwMDAwMDAwMDAwMDAKWyAgICA3LjAyNjY3M10gcGFnZSBkdW1wZWQg
YmVjYXVzZToga2FzYW46IGJhZCBhY2Nlc3MgZGV0ZWN0ZWQKWyAgICA3LjAyNjY3M10gClsgICAg
Ny4wMjY2NzNdIE1lbW9yeSBzdGF0ZSBhcm91bmQgdGhlIGJ1Z2d5IGFkZHJlc3M6ClsgICAgNy4w
MjY2NzNdICBmZmZmODg4MTA4ZWFhNDgwOiBmYSBmYiBmYiBmYiBmYiBmYiBmYiBmYiBmYiBmYiBm
YiBmYiBmYyBmYyBmYyBmYwpbICAgIDcuMDI2NjczXSAgZmZmZjg4ODEwOGVhYTUwMDogZmEgZmIg
ZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmMgZmMgZmMgZmMKWyAgICA3LjAyNjY3M10g
PmZmZmY4ODgxMDhlYWE1ODA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDA0IGZjIGZj
IGZjIGZjIGZjClsgICAgNy4wMjY2NzNdICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBeClsgICAgNy4wMjY2NzNdICBmZmZmODg4MTA4ZWFhNjAwOiBmYyBm
YyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYwpbICAgIDcuMDI2Njcz
XSAgZmZmZjg4ODEwOGVhYTY4MDogZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMgZmMg
ZmMgZmMgZmMgZmMKWyAgICA3LjAyNjY3M10gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Cgo=


--=-niWrXF/chqXzzhgAUdlz--


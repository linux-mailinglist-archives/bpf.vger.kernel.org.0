Return-Path: <bpf+bounces-26210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFE689CAFD
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 19:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9A1E1F258EF
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 17:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B24B1442F4;
	Mon,  8 Apr 2024 17:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXzs6aF7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0561442F1
	for <bpf@vger.kernel.org>; Mon,  8 Apr 2024 17:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712598453; cv=none; b=rgC0+AvIqQnfGZ0+wMKBqC+bcK9DLRW/GM7qcFPDCfup0oLpvyjYdW8hD/MsGNWzPGWWOn3KwpAdkTygjOO9cyZnNz1UScUVhvUYHpDzQXXSOmrPZLiIrHhi3gn3LCfVFCDgyfp4JNF6eZEUhDUNhtHvICw/njfbUba86rhrRVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712598453; c=relaxed/simple;
	bh=3SGvUqolVdfqzERgA5kea744bHC78LSqiv2Ey7+68dE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tzVO/8BJnQbNw7TqL87hRrwrKUzI78OdptdgCt8SpsELXD7Z+53asu5G7b8OsrAlkAmvjXDOWIPGsDox+1nls4etS5/YEeYtoJs/R+07geIXLva6SjfLuMiZ6E7vdrQQVZdX1Qlmfepw+Ed1cm0nY0GQ7hN9Ky8FpcgdGi9VlMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXzs6aF7; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4169e385984so384665e9.3
        for <bpf@vger.kernel.org>; Mon, 08 Apr 2024 10:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712598449; x=1713203249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GGgqjeWNmokU1aVDMMNSoNk2sBIAtSbnbJXqxxo5FnY=;
        b=fXzs6aF7LBUeneGDotWpkYf2PRzlql28BAVVLfkFvla5Fhd7NsmhZzhNJIMK7sc3lg
         cl7fxGrv+gMFQ2K9STPqQQC8yilq422r60XJOMimTv5NJ4jtihGKHLarM+0wGuuFCjA3
         xOd5EXE/2E2rZEKi61p3p51exoiMQBIQ6UymMDJbnCAMHmVdEX/712TLkmFbO/GQqW0G
         ZbtJreZM7yZzF/yk5wXD6V03Ok1zCqEpwM7lHWF2qI1ulKHSIOezcgyWLevHFcqpOm/l
         Ug//mWECU1Uaaeb7yPFCR4xva7bcZNhxPT+pAt/uyCir7fbHdADzBt6i/KIa2hduHspI
         xxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712598449; x=1713203249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGgqjeWNmokU1aVDMMNSoNk2sBIAtSbnbJXqxxo5FnY=;
        b=YeiB6FOD2o81tycd2xBlf4ggUDXWvBnwLWVxS0AidKcsSkmXy0Dh+ijAscZtiNy5F2
         AyDI74BUApB042V3EPWcmN64wNHgHR8w4qoyK7wB1UJHqHigcQnEnZeQW3NdAwloGKwk
         Xw9s6zJXsnnomUvbRb5t0ydYDOzVoc/V+DzRtWbZ5L8GdAw5hJUGK3XXdWv6638M6GRA
         PXMuK5fiOKac8eYxww2o7LhWlSReii6Czuuf/pmUFGhJYK8d8KIPF+xSGeoGVXY/dyEV
         p/NmxSLicBOZ4vYbGjjtzYfnpZYHnhLNGBler8XQqBCHi/Eo4B0WUQIDG5nwLgU2eEw7
         B+6A==
X-Gm-Message-State: AOJu0YxpsdLQyF0W5xa0hKYX1J3LpZ92PS2GhVvl1erupKLrApChdQDa
	iCsxj3ymgE69LWFIQfdcIbK30nx9oztI6C3Qzawa7xsOTP3+/H06taWXMf20IBAcTHx6CrSWwhG
	UHojbhxKM6cHxRgxsKgcPioYCWEEDf6Jq
X-Google-Smtp-Source: AGHT+IFKCQEAL7rJwu7QCIUxrwFJb0tOVvpTFJ48vrzUs3gfFRPzcjby9Nbrk56FwaecBtd8RA5hj3JN5++WHYZZaMc=
X-Received: by 2002:a5d:4d50:0:b0:343:7c16:34d6 with SMTP id
 a16-20020a5d4d50000000b003437c1634d6mr6799366wru.51.1712598449299; Mon, 08
 Apr 2024 10:47:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405220817.100451-1-cupertino.miranda@oracle.com>
In-Reply-To: <20240405220817.100451-1-cupertino.miranda@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 8 Apr 2024 10:47:17 -0700
Message-ID: <CAADnVQ+7hMVTu=yQ3XSRkxACaW68wgwLYPQBQH9StDvBsNXN1g@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next] verifier: fix computation of range for XOR
To: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: bpf <bpf@vger.kernel.org>, "Jose E. Marchesi" <jose.marchesi@oracle.com>, 
	David Faust <david.faust@oracle.com>, elena.zannoni@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 3:08=E2=80=AFPM Cupertino Miranda
<cupertino.miranda@oracle.com> wrote:
>
> Hi everyone,
>
> This email is a follow up on the problem identified in
> https://github.com/systemd/systemd/issues/31888.
> This problem first shown as a result of a GCC compilation for BPF that en=
ds
> converting a condition based decision tree, into a logic based one (makin=
g use
> of XOR), in order to compute expected return value for the function.
>
> This issue was also reported in
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D114523 and contains both
> the original reproducer pattern and some other that also fails within cla=
ng.
>
> I have included a patch that contains a possible fix (I wonder) and a tes=
t case
> that reproduces the issue in attach.
> The execution of the test without the included fix results in:
>
>   VERIFIER LOG:
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   Global function reg32_0_reg32_xor_reg_01() doesn't return scalar. Only =
those are supported.
>   0: R1=3Dctx() R10=3Dfp0
>   ; asm volatile ("                                       \ @ verifier_bo=
unds.c:755
>   0: (85) call bpf_get_prandom_u32#7    ; R0_w=3Dscalar()
>   1: (bf) r6 =3D r0                       ; R0_w=3Dscalar(id=3D1) R6_w=3D=
scalar(id=3D1)
>   2: (b7) r1 =3D 0                        ; R1_w=3D0
>   3: (7b) *(u64 *)(r10 -8) =3D r1         ; R1_w=3D0 R10=3Dfp0 fp-8_w=3D0
>   4: (bf) r2 =3D r10                      ; R2_w=3Dfp0 R10=3Dfp0
>   5: (07) r2 +=3D -8                      ; R2_w=3Dfp-8
>   6: (18) r1 =3D 0xffff8e8ec3b99000       ; R1_w=3Dmap_ptr(map=3Dmap_hash=
_8b,ks=3D8,vs=3D8)
>   8: (85) call bpf_map_lookup_elem#1    ; R0=3Dmap_value_or_null(id=3D2,m=
ap=3Dmap_hash_8b,ks=3D8,vs=3D8)
>   9: (55) if r0 !=3D 0x0 goto pc+1 11: R0=3Dmap_value(map=3Dmap_hash_8b,k=
s=3D8,vs=3D8) R6=3Dscalar(id=3D1) R10=3Dfp0 fp-8=3Dmmmmmmmm
>   11: (b4) w1 =3D 0                       ; R1_w=3D0
>   12: (77) r6 >>=3D 63                    ; R6_w=3Dscalar(smin=3Dsmin32=
=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D1,var_off=3D(0x0; 0x1))
>   13: (ac) w1 ^=3D w6                     ; R1_w=3Dscalar() R6_w=3Dscalar=
(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D1,var_off=3D(0x0; 0x1))
>   14: (16) if w1 =3D=3D 0x0 goto pc+2       ; R1_w=3Dscalar(smin=3D0x8000=
000000000001,umin=3Dumin32=3D1)
>   15: (16) if w1 =3D=3D 0x1 goto pc+1       ; R1_w=3Dscalar(smin=3D0x8000=
000000000002,umin=3Dumin32=3D2)
>   16: (79) r0 =3D *(u64 *)(r0 +8)
>   invalid access to map value, value_size=3D8 off=3D8 size=3D8
>   R0 min value is outside of the allowed memory range
>   processed 16 insns (limit 1000000) max_states_per_insn 0 total_states 1=
 peak_states 1 mark_read 1
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The test collects a random number and shifts it right by 63 bits to reduc=
e its
> range to (0,1), which will then xor to compute the value of w1, checking
> if the value is either 0 or 1 after.
> By analysing the code and the ranges computations, one can easily deduce
> that the result of the XOR is also within the range (0,1), however:
>
>   11: (b4) w1 =3D 0                       ; R1_w=3D0
>   12: (77) r6 >>=3D 63                    ; R6_w=3Dscalar(smin=3Dsmin32=
=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D1,var_off=3D(0x0; 0x1))
>   13: (ac) w1 ^=3D w6                     ; R1_w=3Dscalar() R6_w=3Dscalar=
(smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D1,var_off=3D(0x0; 0x1))
>                                             ^
>                                             |___ No range is computed for=
 R1
>

I'm missing why gcc generates insn 11 and 13 ?
The later checks can compare r6 directly, right?
The bugzilla links are too long to read.

> Is this really a requirement for XOR (and OR) ?

As Yonghong said, no one had the use case to make the verifier smarter,
so pls send an official patch.


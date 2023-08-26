Return-Path: <bpf+bounces-8740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2807895E8
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 12:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 088071C20FDF
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 10:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558F2C2F7;
	Sat, 26 Aug 2023 10:20:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD588834
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 10:20:10 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BC91FC3
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 03:20:09 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9a2a4a5472dso386329266b.1
        for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 03:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693045208; x=1693650008;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VvvH9Dw5yYY0fITeFVpqm3wKlVBtJLE2Y9rYhkGOEU=;
        b=qrblKXBenHam3X1cIEa66Xto2upmyo8lMfn7TRSjHrCxUpf8HohcRhbyF+EtUVhJXQ
         ZgYAWlT/1c0DCXji4lHm17vBITDmCeRw7fP8hnpHsVpNaCxR91dqtbUspKaMwY4lHeGu
         5aRkV2Qhpx7NhdRZ4jAYMBIxc/Lg9UK8gVDewcmSB7zGM6KWOKDrpdt8tOj6JP6k+Xde
         lrZBDBpbeuGzLz5/vLJlyQ2S4I8jDLys2T+4nvDndhfhzsCCkFD3j2hDJ5hod1xbSAJ8
         sScK8k6yGL8jtaM1hKzPhMp+jGKlgoo1Ni1KmFeqp/FN4XwJvFnXI1s6Pc1z4Pwty7HZ
         phoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693045208; x=1693650008;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+VvvH9Dw5yYY0fITeFVpqm3wKlVBtJLE2Y9rYhkGOEU=;
        b=itcVV4+WcdJhMq7OJULjgQ3wpXjIvTrfmh61Ti3/koqSQV6nQzo6d6QpEU3kxblzyI
         3NrbAIiicv5ew/mOrsy2hoAq13x+u3TNjUjazDVOQAWzFVGTs1Ulc1JV1N/DYw07YSL/
         d+czZjVB2lVTYBzSdJsK/jEkcephbDzgN0Kqwf7LtRh/V26G7eYmWrM1xsg7q1+xeRWo
         27XG0pTylN1l+s5CgngTFQdeIer7xZE8bMX5VhlvS2dtEKxpzcwA7MuzwS0OT687/mW7
         FRTjDOt7kvAjiiCxYEiMVxgxXRO9sQY7fi2yfCemnMLPcfAAdkRTdIM1IJavKCMBNcy8
         aLgQ==
X-Gm-Message-State: AOJu0Yx+8Sd6tiPQ5ffD9No3WG/CoNspmSYGWge14ili8IWr6hSAeiPi
	Hkxwt5QpvoGAlzXspDMvTsYsmMMW3BFpmQ==
X-Google-Smtp-Source: AGHT+IHZCzzaTqxdVzd1PCmo0Bvr9RnUGU0V3pjEYtd1x6kPoWXjWNSY6Ps1Kq5s7V+sqdC39cwOkg==
X-Received: by 2002:a17:907:1c20:b0:98e:3dac:6260 with SMTP id nc32-20020a1709071c2000b0098e3dac6260mr23958367ejc.13.1693045207601;
        Sat, 26 Aug 2023 03:20:07 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id g17-20020a170906c19100b00993a9a951fasm2038514ejz.11.2023.08.26.03.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 03:20:07 -0700 (PDT)
Message-ID: <d9486d7d4b36184accc9b8a8b5aa7c75ee73781f.camel@gmail.com>
Subject: Re: [PATCH] bpf, docs: Correct source of offset for program-local
 call
From: Eduard Zingerman <eddyz87@gmail.com>
To: Will Hawkins <hawkinsw@obs.cr>, bpf@vger.kernel.org, bpf@ietf.org
Date: Sat, 26 Aug 2023 13:20:06 +0300
In-Reply-To: <20230826053258.1860167-1-hawkinsw@obs.cr>
References: <20230826053258.1860167-1-hawkinsw@obs.cr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, 2023-08-26 at 01:32 -0400, Will Hawkins wrote:
> The offset to use when calculating the target of a program-local call is
> in the instruction's imm field, not its offset field.

Indeed, this is the case, e.g. see kernel/bpf/verifier.c:add_subprog_and_kf=
unc().
Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>=20
> Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
> ---
>  Documentation/bpf/standardization/instruction-set.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Docu=
mentation/bpf/standardization/instruction-set.rst
> index 4f73e9dc8d9e..c5b0b2011f16 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -373,7 +373,7 @@ BPF_JNE   0x5    any  PC +=3D offset if dst !=3D src
>  BPF_JSGT  0x6    any  PC +=3D offset if dst > src                    sig=
ned
>  BPF_JSGE  0x7    any  PC +=3D offset if dst >=3D src                   s=
igned
>  BPF_CALL  0x8    0x0  call helper function by address              see `=
Helper functions`_
> -BPF_CALL  0x8    0x1  call PC +=3D offset                            see=
 `Program-local functions`_
> +BPF_CALL  0x8    0x1  call PC +=3D imm                               see=
 `Program-local functions`_
>  BPF_CALL  0x8    0x2  call helper function by BTF ID               see `=
Helper functions`_
>  BPF_EXIT  0x9    0x0  return                                       BPF_J=
MP only
>  BPF_JLT   0xa    any  PC +=3D offset if dst < src                    uns=
igned
> @@ -424,8 +424,8 @@ Program-local functions
>  ~~~~~~~~~~~~~~~~~~~~~~~
>  Program-local functions are functions exposed by the same BPF program as=
 the
>  caller, and are referenced by offset from the call instruction, similar =
to
> -``BPF_JA``.  A ``BPF_EXIT`` within the program-local function will retur=
n to
> -the caller.
> +``BPF_JA``.  The offset is encoded in the imm field of the call instruct=
ion.
> +A ``BPF_EXIT`` within the program-local function will return to the call=
er.
> =20
>  Load and store instructions
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D



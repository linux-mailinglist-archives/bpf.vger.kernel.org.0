Return-Path: <bpf+bounces-65211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F12CCB1DB29
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 17:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6C86188AA0F
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 16:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4F226AA8F;
	Thu,  7 Aug 2025 15:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmc3cZQs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D994266B52;
	Thu,  7 Aug 2025 15:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754582393; cv=none; b=sJz/8pKuBfjZEFbFKu94IrSPLKW+AMsyP38d8xraG5xTEhd+bxzMIJxB5SeQwU1eAl/hunHkGBXnUILksQkreZ1wPQTEySrN4YIMAmWxjh/55MfOQrzq5PJXJQA/pRfRYkU8+uJEyS1eq4T+cu84wAHDEB+Mahjs2T+jOvqjWC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754582393; c=relaxed/simple;
	bh=Ebc+AGF/6GnJxKxuAOGAeYl3CtsjqnQbzPgqYYqm/Cc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PwkmlvnaJPzhPV9M1ExCL2+eFmKyYtHI66LA3B+/PzH+KmJhYZ8LZPY7dciTqZ8dxE4HVZI0jXYU+cNSePxBK3wcBA6gy+tXXVYnkv98SkYCe+PbhM/e8pBn1biS6f956o7PdSQl8PX/WTfBiaZu01Z6teOf3Ii6aYTF0EntAuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmc3cZQs; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-459d40d16bdso8064215e9.0;
        Thu, 07 Aug 2025 08:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754582390; x=1755187190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ebc+AGF/6GnJxKxuAOGAeYl3CtsjqnQbzPgqYYqm/Cc=;
        b=fmc3cZQsBxLMqMtCYKH7lbrzFsVhFkBikzaDihD9bGUN/47F/2e8LoHlWRvbM09yEG
         ngdHgofgL48JSgb2q02BcpuNrThNTV67BzvrbewmzCj39XSYL4nNlt10lVpJbIEAPJxl
         IeVq7LdQ2RI86SGwxXNwlzG/fLw0aJDFQmVKK3/X45kdfAnKgtYSAFDz43zEYG28m6/N
         OI4gBCW7Ef7UIrVxBNBAAfvsSr0PyihN1CWHcxGa//tZV5EUGFXRRD6WpsAtgii1F+xe
         LnDnHXbgEwxIIXRrsOIQM0r4Z8WprjGEZuZLAjNBumPi2yXaQSYWZRJuWx0g2tt9r0V7
         jyKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754582390; x=1755187190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ebc+AGF/6GnJxKxuAOGAeYl3CtsjqnQbzPgqYYqm/Cc=;
        b=t65O+T8IT6iL6Zz5OzpYx2GnogfpWxo0GKaYXMrtIqWjp/YAHLXepJwtBYerpjNq37
         3T+/StYuyHwI82ptsKzPNsU1MaoY6q+8daO0jMwzCeYPlyPxRtn2y7x2vWiCqz+db+/g
         sNfrZy/enQigN2b/t4xjYFIddGNQeBBZBRk+mEC36EvEwYzWU/3icAYElKa6nZwAH2H4
         iKm8JQo16/z5ILOpx5s1AQbe47Fa5+WHmBssbrO3hWpU6Pi0FxRD6J+AraMsHJeRePbU
         5g5KAVg2Vg012Ga9j4T7X+NQgRxFhtE5bV8fomK2JUi7uW2fZFrkr7GZUAH3oA5C5aDW
         TZjA==
X-Forwarded-Encrypted: i=1; AJvYcCWKDoI8vnr3b65Pz8N0QDrtvMKepdwQGcalUbMg/fs2YhsA2grVql3FfSPicyomKfWwd64=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnIlnAC0wmG/n1RrPq3daC2dk/maco7oQgUcg0pe2zP8i2HrAj
	2dESFKTXh8KNwTMdLkLPaIiniXXVhOAJvrtwtc14Pvezsr9gDa4vvFUvo7CHle4P9Oau0ztHbf6
	dHwXyIwf0hM29qHTCXLUqFJA0P9BcQ7Wo22YL
X-Gm-Gg: ASbGncv7MPlUJtXRkzwHo2a/5ZF1GrmKaCrEY5tY6k+UPo8lsGoaS8bDFM+5RIul/BE
	cZv/OE9CEOTGX2T/kvMKbioMPZYV+hUPofjb83ppcSMI7RjHcv9NY8DCqn52u/Nruz4O89ew5nl
	KyX6Oh/tihKEpiHFd4GE6p9wRyKKxsooeog1BLd6TOnEEAtpkBla71iYja5h1ULOxUGlGHw81VJ
	cVhus4Th9oy6Rgon7LSkKulHNddvWda1Q==
X-Google-Smtp-Source: AGHT+IE3TM+0uXQsXwFIJZxPZSu/cSCLUb58nUrkM6m28IFLNP2XvykwfP4WwQRmDLnJJ447+1GnV7N2+gooJwSEhRk=
X-Received: by 2002:a05:600c:840f:b0:456:25aa:e9b0 with SMTP id
 5b1f17b1804b1-459e745c61amr77325365e9.16.1754582389733; Thu, 07 Aug 2025
 08:59:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807144209.1845760-1-alan.maguire@oracle.com> <20250807144209.1845760-6-alan.maguire@oracle.com>
In-Reply-To: <20250807144209.1845760-6-alan.maguire@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 7 Aug 2025 08:59:36 -0700
X-Gm-Features: Ac12FXxtb_SM4LHJl4FVRaghuJYV-bF0AKxyHytUHvAEuMDHA3iR1VsKkDw41Zg
Message-ID: <CAADnVQK38yk3XO9cebrXhMUSK10bH2LVPvs6W4e168x3mGpTWA@mail.gmail.com>
Subject: Re: [RFC dwarves 5/6] btf_encoder: Do not error out if BTF is not
 found in some input files
To: Alan Maguire <alan.maguire@oracle.com>
Cc: dwarves <dwarves@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 7:42=E2=80=AFAM Alan Maguire <alan.maguire@oracle.co=
m> wrote:
>
> This is no substitute for link-time BTF deduplication of course, but
> it does provide a simple way to see the BTF that gcc generates for vmlinu=
x.
>
> The idea is that we can explore differences in BTF generation across
> the various combinations
>
> 1. debug info source: DWARF; dedup done via pahole (traditional)
> 2. debug info source: compiler-generated BTF; dedup done via pahole (abov=
e)
> 3. debug info source: compiler-generated BTF; dedup done via linker (TBD)
>
> Handling 3 - linker-based dedup - will require BTF archives so that is th=
e
> next step we need to explore.

Overall, the patch set makes sense and we need to make this step in pahole,
but before we start any discussion about 3 and BTF archives
the 1 and 2 above need to reach parity.
Not just being close enough, but an exact equivalence.

But, frankly, gcc support for btf_decl_tags is much much higher priority
than any of this.
We're tired of adding hacks through the bpf subsystem, because
gcc cannot do decl_tags.
Here are the hacks that will be removed:
1. BTF_TYPE_SAFE*
2. raw_tp_null_args[]
3. KF_ARENA_ARG
and probably other cases.


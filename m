Return-Path: <bpf+bounces-75412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E39B8C82E83
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 01:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6E684341C2E
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 00:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13881CAA4;
	Tue, 25 Nov 2025 00:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcFIt+E5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE8EB67E
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 00:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764029378; cv=none; b=Aisi+HDF4B7Ub2I+6j30BzVMFw730sSmBoVizT/CoyZiEzvNYli0YYJ0/Xk15Zu1bUNaO5I1QT65brvUipV21frqw2glt+DYztOB3ZmYh+jJwqUqXt1eBjamRpO3KMvMn2ZtrfsA1VtoZ/3DQTCvCIjG1UVgofJUWF0t6pkvstI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764029378; c=relaxed/simple;
	bh=0Lvpfoxubeeb7j+YJwRlWFwiMS275nIcFC6RiGe6oh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WLhuDNkcJMt0LlVcTVJ0Dn0bfV+uktGoAsz7unOo+bWKLNe4b2O5wFAL+tIMSeNIzybD40fIgNSgJM4yFJXFfLv2fP1qzQ6c8O0NZ/+cDtTlLAkXpsg4VsTMFuz74VEIKsDhcPpyFyWSvEttFsY9piY2XlFU451GTscchHfbFIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcFIt+E5; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42b3d4d9ca6so3983306f8f.2
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 16:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764029375; x=1764634175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FI+CD7aZrEMV144oGufGV3X8lig8B6BjvwPOWzqjuKE=;
        b=EcFIt+E5DqfDK/+khJkFRUje2eoEZhLksaZY2PlSLIwbYW8UAlFtjtVf3CahTlPccM
         Zy3x/PzAreM83Brs1Xgb1V7wuWIZBQV4FhHRDMukXwrR31pIWAmhsBxE9nbUQMkXXkhC
         /MhiA9SVcp/04jvXifoDK7zcbS72ouQY7mQhQzkbgMIvrTbAcmkV3tJXJPkInC9fB8HF
         J6ip5dnQ148jwq/0y998AjARnOrsfvxSYFWI6m5ARpCe3+QocDJ2KZwAqmRfxMgv4nU5
         s5kgG5MPF/4gm8li8O7d2swP32aMSihqHre6pV7KQeAJJEY0UZTAhYBj9UIKmxgcJINV
         z5kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764029375; x=1764634175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FI+CD7aZrEMV144oGufGV3X8lig8B6BjvwPOWzqjuKE=;
        b=BdAFV1Znv5zrctTRVTv+7/oyTje2fhSfdjSHMsoFtwOaJORDZ9nh0jJNdgSwYsLOAD
         zhL3n87skMe25paoka9neJcOZAnhkZ7MDF2mpxZn0LAgXeMnIbvOyWG34nKa7NVGxmFW
         Zm96oow34TnYD38gTY+aHPomcrRO1aO+lmCN2jvKsPymQ1iZq4ScQoGkvE01DaOWk689
         Jbu92XhLsAxCdAisSeOW5B95UWYQDVtf2M/7OnqvrDGhm+F7LFv2IXaze4jbEMROKG97
         ZaHcQgycbyg7MiHfovDG16Pn2Ohtf5Hg4oCj0wbQm8Ou/D6K7SFGIlMERvsX2LcosxoK
         V3Bw==
X-Gm-Message-State: AOJu0YzAusay8LwtaEDKI8kslCM67vJNxr0LREnNK5pG3lOpzDOVw9rg
	DWU+Opu0i3sbArM2+RewJjF4ExdnL6xb62J/OkfL/AX0/97Z50Irbs1osq94sg8sFqS5f0yxgjw
	eIQQAi4liIYTZmQi+OeSSW7Wi6UXQJ6o=
X-Gm-Gg: ASbGnctlwpuJnDTjlKQSTokXy+z3ZYtohS8NQFlRkpJqCthKsN0rUdQSXBwht7ujpcC
	OgepdroQsyGYVqXTa0EBsf4MMWlrnFh0BbLqOTlrhJJt+QXRMXYDIhfApbcdIVOygrIKcTEt8j+
	aWCZJNBwKDXIubG/j3Jx2sJCzgU8rSopBCFChAkj95uawDQkLUjXNgB7mZ4IY2v7/+y0yMdhRUN
	ukJLQ07+soOLEQOyUNLvkaft+SAo4ON4nsGE29MdR5e4EZNfq2B0fxwsW7XD8edV46xOJF2I0+l
	sQRVT+wq9EzyCyuf3d/DOrpGAdqwCwAr361iKo4=
X-Google-Smtp-Source: AGHT+IHjnIaUrF3AzECtiSXiGX5EsmywBuuqpQrqj79bqJRqMvBRAc+SzBSDg5bhZTS2PLHdAQ4esx9TaCQDaBqp7oQ=
X-Received: by 2002:a05:6000:428a:b0:42b:40df:2339 with SMTP id
 ffacd0b85a97d-42cc1d61959mr15426073f8f.57.1764029374505; Mon, 24 Nov 2025
 16:09:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124180013.61625-1-cupertino.miranda@oracle.com> <20251124180013.61625-3-cupertino.miranda@oracle.com>
In-Reply-To: <20251124180013.61625-3-cupertino.miranda@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 24 Nov 2025 16:09:23 -0800
X-Gm-Features: AWmQ_bmdxN-7T1c9bTaMFJxKO1Xbhbvnr7QDwFPdEmd_IySm6avJuGgMLpapDNM
Message-ID: <CAADnVQ+tzCrbJ2G2nuqejVQF_xzxM818HOut6va=UBAmMavJ5Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selftests/bpf: add verifier sign extension bound
 computation tests.
To: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: bpf <bpf@vger.kernel.org>, Andrew Pinski <andrew.pinski@oss.qualcomm.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, David Faust <david.faust@oracle.com>, 
	Jose Marchesi <jose.marchesi@oracle.com>, Elena Zannoni <elena.zannoni@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 10:01=E2=80=AFAM Cupertino Miranda
<cupertino.miranda@oracle.com> wrote:
>
> This commit adds 3 tests to verify a common compiler generated
> pattern for sign extension (r1 <<=3D 32; r1 s>>=3D 32).
> The tests make sure the register bounds are correctly computed both for
> positive and negative register values.
>
> Signed-off-by: Cupertino Miranda  <cupertino.miranda@oracle.com>
> Signed-off-by: Andrew Pinski  <andrew.pinski@oss.qualcomm.com>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Cc: David Faust  <david.faust@oracle.com>
> Cc: Jose Marchesi  <jose.marchesi@oracle.com>
> Cc: Elena Zannoni  <elena.zannoni@oracle.com>
> ---
>  .../selftests/bpf/progs/verifier_subreg.c     | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_subreg.c b/tools/=
testing/selftests/bpf/progs/verifier_subreg.c
> index 8613ea160dcd..55e56697dbc4 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_subreg.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_subreg.c
> @@ -531,6 +531,76 @@ __naked void arsh32_imm_zero_extend_check(void)
>         : __clobber_all);
>  }
>
> +SEC("socket")
> +__description("arsh32 imm sign positive extend check")
> +__success __retval(0)
> +__naked void arsh32_imm_sign_extend_positive_check(void)
> +__log_level(2)
> +__msg("2: (57) r6 &=3D 4095                    ; R6=3Dscalar(smin=3Dsmin=
32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D4095,var_off=3D(0x0; 0xfff))")
> +__msg("3: (67) r6 <<=3D 32                     ; R6=3Dscalar(smin=3Dsmin=
32=3D0,smax=3Dumax=3D0xfff00000000,smax32=3Dumax32=3D0,var_off=3D(0x0; 0xff=
f00000000))")
> +__msg("4: (c7) r6 s>>=3D 32                    ; R6=3Dscalar(smin=3Dsmin=
32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D4095,var_off=3D(0x0; 0xfff))")
> +

nit: unnecessary empty line.

> +{

lgtm, but gcc-bpf doesn't like the above :)
See CI failure:
bpf/tools/include/bpf/bpf_helpers.h:41:19: error: attributes should be
specified before the declarator in a function definition
41 | #define SEC(name) __attribute__((section(name), used))
| ^~~~~~~~~~~~~
progs/verifier_subreg.c:534:1: note: in expansion of macro =E2=80=98SEC=E2=
=80=99
534 | SEC("socket")
| ^~~

clang is fine with that order. fwiw.

pw-bot: cr


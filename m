Return-Path: <bpf+bounces-27866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8EE8B2D90
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 01:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BC622826ED
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 23:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2286715666F;
	Thu, 25 Apr 2024 23:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEgCApHW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8F415665A
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 23:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714087609; cv=none; b=D4O/xDV/60sz8fhlC38f/AYjAkMXAvEk+9zUJSN0qLaJroxtZ8H9N0M9vrJxoxIDy86NIjuRq8doT5DJSONA6jEhBA3kbhHCX8azFg/zKdOIw//geP1cASmzviuOG4ofq214TkUOnuNYS1tdFHO117/K52cZ6AH+iEtM9P3+ukM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714087609; c=relaxed/simple;
	bh=6/NnS08H+za8mqGgiMS0gArZU28OZ+j2xqhQgS8h6hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZCZtiLz+yeR0I7PsSc1VBEPhyQU7HOCZVODKNKRSHXCVvmH4DR9El5t4VaAuFpWY+r9Jat6d2NhPxWmnX5/LutK3ptL0Ukuz6uw4m82h6/ii2WI27k4Mlh/1baopMNTW577NDKZ0ML2109IWONdAThyiBpn7tjtPheYgISkxbww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEgCApHW; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-60c49bdbcd3so365834a12.0
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 16:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714087607; x=1714692407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SiNHsfFPg35FO4Sr5G0ebakvYmggCGNR4s25TH+ljGo=;
        b=WEgCApHW1vpvh2frv+lcHCY5MQ48lTReTkRBlfctIuVYcdZnfECx1SqayoAv64npo2
         ofc3rH52+ejvZv5xVgO9hO2nHztcsybnm95y88qoIqRPRDXRjk3YOZItkjxE9TImX6Qp
         u391+tRJPMtlSVUpzU4dydNIRKji7AZZTZImyeUKABqINYbFlhfp3YGbsNSUu8/xAgIF
         TostPU0H8QBU1gn0xHuz+iy7KQ+sCZD20ycZTNpQdTPgR5rMJxlGaz3K/duMXWHlGRHe
         Sos9GdhiGTZm9W0fWw0wSA6FIyQKoWxvl92KGarDlsxGvL/NDMFN2FYFwZAniskzt3Us
         CKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714087607; x=1714692407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SiNHsfFPg35FO4Sr5G0ebakvYmggCGNR4s25TH+ljGo=;
        b=lSzNYEgmokFU9NOnQLZLtRXfNXh81rJRaixlKA04vYXy023ocTExzxsrQ5GscnBQAm
         G56aKGl9yhybxl8aDxZnZmjRnLuLCRIz2J/2Vq1ZgoVh/HAfRhIVc7FVnl56hhEFw1Zv
         SnDJJkN9H/6rNtg4ZRxhsNWtF7VELsryk+uInAObN0tcXw4mXCYzT7i7lz4wFWIm2DnX
         SPG4ctAsO1BxT6Dui22/aZAQI5XT1IqhclbvuPECTc448rzkycaPapdpWKWDeJbU+zio
         JfG6NrEAfruUCdOHp+un+bRwyRiVfc4Rr2RZp33BEyR7eHWtvJYY5Kb4Sw5j4uBvG0+W
         rQ2Q==
X-Gm-Message-State: AOJu0YxzsDj9eurBh0bZlkvFQ8JGeiEB1iMmIpQ9ASf4bxcPevlM3kU1
	lly+7XLqp+Lob+3JdSU7+lTRm7ghCB0Ybrmcq4NmgoeqBRXJDqyQjBj2PBiS8UQs+uiBTJO9vze
	xf2S7FDhcugT46C+5Mok6ntjQqd4=
X-Google-Smtp-Source: AGHT+IE4KLsKay4ireEB1UwFJ7b+W0oD/EOZKYDDrrJLsRvDGWWootNmaU+2TlfGbjgru7KfPc5aTpNqHHrWZ3tW/wE=
X-Received: by 2002:a05:6a21:6d83:b0:1ad:878:5006 with SMTP id
 wl3-20020a056a216d8300b001ad08785006mr1459093pzb.14.1714087607624; Thu, 25
 Apr 2024 16:26:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424224053.471771-1-cupertino.miranda@oracle.com> <20240424224053.471771-7-cupertino.miranda@oracle.com>
In-Reply-To: <20240424224053.471771-7-cupertino.miranda@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Apr 2024 16:26:35 -0700
Message-ID: <CAEf4BzYvzFf6zb2qnPxs6AKjAg=1AtwtCpE=_SUGGvp4Grto4g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 6/6] selftests/bpf: MUL range computation tests.
To: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: bpf@vger.kernel.org, Yonghong Song <yonghong.song@linux.dev>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, David Faust <david.faust@oracle.com>, 
	Jose Marchesi <jose.marchesi@oracle.com>, Elena Zannoni <elena.zannoni@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 3:41=E2=80=AFPM Cupertino Miranda
<cupertino.miranda@oracle.com> wrote:
>
> Added a test for bound computation in MUL when non constant
> values are used and both registers have bounded ranges.
>
> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: David Faust <david.faust@oracle.com>
> Cc: Jose Marchesi <jose.marchesi@oracle.com>
> Cc: Elena Zannoni <elena.zannoni@oracle.com>
> ---
>  .../selftests/bpf/progs/verifier_bounds.c     | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/=
testing/selftests/bpf/progs/verifier_bounds.c
> index aeb88a9c7a86..8fd7e93b112f 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> @@ -927,6 +927,27 @@ __naked void non_const_or_src_dst(void)
>         : __clobber_all);
>  }
>
> +SEC("socket")
> +__description("bounds check for non const mul regs")
> +__success __log_level(2)
> +__msg("5: (2f) r0 *=3D r6                      ; R0_w=3Dscalar(smin=3Dsm=
in32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D3825,var_off=3D(0x0; 0xfff))")
> +__naked void non_const_mul_regs(void)
> +{
> +       asm volatile ("                                 \
> +       call %[bpf_get_prandom_u32];                    \
> +       r6 =3D r0;                                        \
> +       call %[bpf_get_prandom_u32];                    \
> +       r6 &=3D 0xff;                                     \
> +       r0 &=3D 0x0f;                                     \
> +       r0 *=3D r6;                                       \
> +       exit;                                           \
> +"      :
> +       : __imm(bpf_map_lookup_elem),
> +       __imm_addr(map_hash_8b),
> +       __imm(bpf_get_prandom_u32)
> +       : __clobber_all);
> +}
> +

LGTM, but it would be a bit more interesting to have a few known bits
as well. Just setting 0x100 bit for r6 and 0x10 bit for r0 (before
multiplication) would test that tnum actually tracks those known bits
during multiplication correctly. Consider it as a follow up, I guess.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  SEC("socket")
>  __description("bounds checks after 32-bit truncation. test 1")
>  __success __failure_unpriv __msg_unpriv("R0 leaks addr")
> --
> 2.39.2
>
>


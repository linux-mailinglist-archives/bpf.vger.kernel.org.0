Return-Path: <bpf+bounces-28269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A988B7A9D
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 16:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED2431F22161
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 14:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25504770F3;
	Tue, 30 Apr 2024 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SomhqbCm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E241527B9
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 14:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714488782; cv=none; b=OBKUEebC4UdBFw83syL8NqAQNhWYrXECOCDyS1Uwxpu+n9cFM9DoicV8TrVpctiiOXPW9C4EZOWaWNE983GlLgnb+VV47qnPgKRPQtcs6ryn8c3bVwdP6TO2wuOOkIieR5tOllmx4OwX6rsLvFX5nNmBA8Tlu1ZCh2jV/WLWeIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714488782; c=relaxed/simple;
	bh=Io/+wo/+xwnfjnQeayZDivMHoUqFi+pc1N0/SklXp60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t3Xxu+zwa1h6u0+j3W75dENYMuC/NC9lDWlA/qFe/jB3p9xP/Lt4VSgCdEJa2trvvNN9mpYTUVAs1ZZaepe90PJDTvyrM+XDmu279WjeQJA2XYXUl3StV4FBbvKB9ycWUNfbSD1/SUfyQvxIARv1DWu3y2VBRfeAULAqhkyZFj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SomhqbCm; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41ba1ba55ebso29881175e9.1
        for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 07:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714488779; x=1715093579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRtux/TX7iF7XzQc1vO63ELPV2RcyJecmJzH3KHf2gw=;
        b=SomhqbCmBFCvPGwL3Mkvy8mGXyhxN6vbV90vcFBa+l/ZLSrRtBB8+Ed5AHEVP+OxSG
         nM6D1hmH1YhZ4o012cY91iLpC3fHKrgxJ8J0h+PI49u8j3eaY/YzCa+1rV6cRWMBDFlL
         m2jOyT2WBC6DKYU8jX5WpKYLEL37fLVm3ae2ogbmp8MOtT84VGBcc23w+GJhFeI6QmjS
         jYLtu7lAE3aacgtaJfRC/e/WSjKO9TUMf+pLhdO4jomXKVAdui7gFIiU5ZrOpx6vtz7u
         X3ESzMXfzVA2P1uQH163nrfUNtdVO/ZP/dWiJkM9Cdg5W5bNLTPOPkzUmQKPRoWrOnv2
         ct/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714488779; x=1715093579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IRtux/TX7iF7XzQc1vO63ELPV2RcyJecmJzH3KHf2gw=;
        b=AvktTF9l2ON450I0y3rIwlQN5FjHxGCtDEV/a7/L8rNmuEA/CbbBLOsqiDp61EZz+n
         Cm0wcfaZ6m8HQ811e+p56E7ME8Tr0K8Vh2E+HtZ7d0pkLnOhaqq555iuA8p9bm1jpYfM
         DtpC5lp+MVRXzO2GZKVunQ5ODmYXqqYSE6jgglDccptWY03LhB820s8kfar5zKYNQe2r
         I7+o/nJXtPZ+aw951IFBEmMFcB3pr/sv/ABJXEo7TawdJbKz/Nvg/mFmKXTEt5kLl6OU
         9v2gISdreSRVbYE12gAn4BJBw0JIZN7oiu2UXwF0cUvOmEkir/Mjib4CKMqzeIty8kK+
         B0Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVCMHtHLm18B64V2lT1gVUkxyBPvMRyIyf/JYMr3LhqpLnxkqbzXR3KVEY9e1z42slQR4kaZwN+ycffO4XVE+E3pl+Q
X-Gm-Message-State: AOJu0YwEZuzwqniOtqfCZthw2bglGRiBHi6ucBnJ124oGekb287kzVGy
	qWy/9osUN6Mzl1h4xfethyyaZPVlTyD2Zdq9jWdknhpemeONCshfegXnduTpxu90HEZrbcuwC7H
	DlDSAvGbVyPFtjs/t0FOW5ipqEpY=
X-Google-Smtp-Source: AGHT+IGhsZEax9djyUdbjETgoGmG68cnBHb5KxNLHLMlwu1gwsw8Kbc5Uog5UQkt1verCKUxv9QhcIKcEasVxrUcbM0=
X-Received: by 2002:a5d:6e8a:0:b0:343:61bb:115d with SMTP id
 k10-20020a5d6e8a000000b0034361bb115dmr9429451wrz.26.1714488779118; Tue, 30
 Apr 2024 07:52:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429212250.78420-1-cupertino.miranda@oracle.com>
 <20240429212250.78420-3-cupertino.miranda@oracle.com> <65e3b41c78870a563136109e26ab84cd880154c5.camel@gmail.com>
 <87y18vl3op.fsf@oracle.com>
In-Reply-To: <87y18vl3op.fsf@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 30 Apr 2024 07:52:47 -0700
Message-ID: <CAADnVQJzz1mB=8nM87X12e4-P+P2K3LvwbpySBXGLW=z9+TxVA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/7] bpf/verifier: refactor checks for range computation
To: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, David Faust <david.faust@oracle.com>, 
	Jose Marchesi <jose.marchesi@oracle.com>, Elena Zannoni <elena.zannoni@oracle.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 12:17=E2=80=AFAM Cupertino Miranda
<cupertino.miranda@oracle.com> wrote:
>
>
> Eduard Zingerman writes:
>
> > [...]
> >
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index 6fe641c8ae33..1777ab00068b 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -13695,6 +13695,77 @@ static void scalar_min_max_arsh(struct bpf_re=
g_state *dst_reg,
> >>      __update_reg_bounds(dst_reg);
> >>  }
> >>
> >> +static bool is_const_reg_and_valid(const struct bpf_reg_state *reg, b=
ool alu32,
> >> +                               bool *valid)
> >> +{
> >> +    s64 smin_val =3D reg->smin_value;
> >> +    s64 smax_val =3D reg->smax_value;
> >> +    u64 umin_val =3D reg->umin_value;
> >> +    u64 umax_val =3D reg->umax_value;
> >> +    s32 s32_min_val =3D reg->s32_min_value;
> >> +    s32 s32_max_val =3D reg->s32_max_value;
> >> +    u32 u32_min_val =3D reg->u32_min_value;
> >> +    u32 u32_max_val =3D reg->u32_max_value;
> >> +    bool is_const =3D alu32 ? tnum_subreg_is_const(reg->var_off) :
> >> +                            tnum_is_const(reg->var_off);
> >> +
> >
> > Nit:
> > Sorry for missing this earlier, should we initialize 'valid' here? e.g.=
:
> >
> >       *valid =3D true;
> >
> > I understand that it is initialized upper in the stack,
> > but setting it here seems better.
> >
>
> With the last patch and the suggestions of Andrii this code gets
> removed.
> Should we we keep having this small changes? :-)

Pls avoid this churn.
Don't add something in patch 2 just to delete it in patch 8.

pw-bot: cr


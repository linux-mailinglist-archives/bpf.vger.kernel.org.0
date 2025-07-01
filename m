Return-Path: <bpf+bounces-61959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F32AEFF64
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 18:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57341520FA1
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 16:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A941F7910;
	Tue,  1 Jul 2025 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kB/MyeX9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225C21B0421
	for <bpf@vger.kernel.org>; Tue,  1 Jul 2025 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751386612; cv=none; b=ptWtLWXJENDMms7gvMfpk4OP+gJWZDh2EfOou5uolE+m1Pm13JqsVPrsUvYO6oeNn7qsOfY7Nk6HYb271FtAEV73pa4NYYWo/dJH4je97GObnYq5LDxj6sbp6C7iTJwghcK2pplJVZf1Uundz47PXHpCUhi5QlJTrbjvF0dSwkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751386612; c=relaxed/simple;
	bh=Pr6YOZRTHWSVaUm7/hXZXx1Ebe2tglEtfbkaWcfhZxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NXempbTiqKl/LwxVlrAnZTDliMP00MQ8VvI70bw9TbPxDmKBS7MC7M6E3ocr/txvcJcr7dwdwHuVgdNRwtnXFdYJWieGk+xrusS/w4dYJe7ZFcSR7FCWd/XPObGnLxx1OyYdRVbG3TPRh4UNGU09Pl781w1BRCGgfs8fI7MxLS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kB/MyeX9; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so4450225f8f.1
        for <bpf@vger.kernel.org>; Tue, 01 Jul 2025 09:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751386609; x=1751991409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQkF/JZ7B/vCBrQE0TP19THqprsGNa819N3CrEXd7X8=;
        b=kB/MyeX9eCvFME4yyb+SHyKNl+RStXo7+ixozsIUdO4j1cG6Pk8cP2QGevyorqS/jT
         CbSeAzpC1lAvGV4AIKRppHaxNyWFTZeJdG85q/7GqlYBj0fm5InOIjNLNVfztM9SF4s9
         Hd0NTmzr63co1ckb5gsg99JZVhvC7IjbyUrco5fGHkq1xUAeeMvzUz8Ir5KLvque5QJw
         c/5W5UKwNmsZHkxVGObqMOta5GggeV56qCNt1XnMoN4CXwoDeppOsVapFeF9UVp81Wpb
         QBY7/kvh6g7BV1aNAYx6edzaU3m0VLF3p6UxYtqVQ7okrd75Qpz49AfS6K1PUbKRzxIw
         wrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751386609; x=1751991409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQkF/JZ7B/vCBrQE0TP19THqprsGNa819N3CrEXd7X8=;
        b=Ccaw+TKxEvbabkZfeEr5Tq4TPSAc/Bm8SKoQmt66VyLd0mkkP0024qngY7b8BZOoe5
         yIqYzjssnRTpW43dsoIi0tLIC1GlT+m+BOvtUNFi1b0j1YSoDN5+FHT5AgvHAVNnFC7s
         gxu1EAJFyYim4mJ3Txjmd0sBi6TGAaBY19c0DlI5CtxjX8095+d//mpH+3aR//XJckij
         c+DAa3TrEC/SAd/HLhOCNixNLwD7bP8BpOpFsv+a/gk6/ESk0CaBYwO3ZRURXEqUk15j
         SbZwl0l3eiGgViGxypJN65LWEJoIEeqr1fe6sQsjh6E9jQqh3mml09Pzsrg08avlaeLN
         KsUA==
X-Gm-Message-State: AOJu0YwW043gm2n+5Kvwk1tNQNRUDasY5HdZun2vrpX1ENYBf0i2Aazb
	8tqOAyxGIECIRfhF/NCXXU6dURqAx0yenqOjifiwHyihSGb2XOU2M71z1oV+Pszcb/52bHpCDtG
	QhWTaanE6Q+nCvRCIDxcHKyP6Dw7xGCyCBvjX
X-Gm-Gg: ASbGncsZMKLYNHs3Jifc3bcH6ckHb+t+qurwV297sUwDsNb+jgilf9o8gGvjj9UgYuT
	S87A589jjQ+5F7hyGZyLJclVJxKuTZDmPJx/X1NVanHI5JrhXE4g63ATcCwZqCQi6AlWYOpXgjG
	mPdQ1vIMtvVw4Sw5D4pycXw12nYGhI6ijjAlKji1QhHYIy7fQgHjsZhimOPgk=
X-Google-Smtp-Source: AGHT+IE+lkrAJxjK2+oVVo5LjBOniIyQUBAUWKj09l5Qk5klU1McBGRULuORBNASvW5UCIcLMEOpOopkJSjfxMu1UP0=
X-Received: by 2002:a05:6000:41c9:b0:3a0:b565:a2cb with SMTP id
 ffacd0b85a97d-3afa162e2f3mr3903419f8f.1.1751386609102; Tue, 01 Jul 2025
 09:16:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aGPmVDaeHDeS_wXw@Tunnel>
In-Reply-To: <aGPmVDaeHDeS_wXw@Tunnel>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 1 Jul 2025 09:16:34 -0700
X-Gm-Features: Ac12FXymTPsxyRboMztDFBsquqnlJlZ1tLMY9aZSP8ihowAvU0YPCdUg8LoLbuo
Message-ID: <CAADnVQ+FV8+2p9=Z55u0e2=6aqcXdTAL9UmMqcr4-oWMBCLb4A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Warn on internal verifier errors
To: Paul Chaignon <paul@isovalent.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 6:45=E2=80=AFAM Paul Chaignon <paul@isovalent.com> w=
rote:
>
> @@ -15426,12 +15418,12 @@ static int adjust_reg_min_max_vals(struct bpf_v=
erifier_env *env,
>         /* Got here implies adding two SCALAR_VALUEs */
>         if (WARN_ON_ONCE(ptr_reg)) {
>                 print_verifier_state(env, vstate, vstate->curframe, true)=
;
> -               verbose(env, "verifier internal error: unexpected ptr_reg=
\n");
> +               verifier_bug(env, "unexpected ptr_reg");
>                 return -EFAULT;
>         }
>         if (WARN_ON(!src_reg)) {
>                 print_verifier_state(env, vstate, vstate->curframe, true)=
;
> -               verbose(env, "verifier internal error: no src_reg\n");
> +               verifier_bug(env, "no src_reg");
>                 return -EFAULT;
>         }

These two don't need to change. There is WARN_ON there anyway and
print_verifier_state() too. Changing the last verbose() to be conditional
depending on .config will be surprising and inconsistent.

The rest lgtm.

--
pw-bot: cr


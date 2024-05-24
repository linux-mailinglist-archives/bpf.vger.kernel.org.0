Return-Path: <bpf+bounces-30449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B8FF8CDF0B
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 02:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9239282653
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 00:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B292A6138;
	Fri, 24 May 2024 00:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YS4D6qDo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF92981F
	for <bpf@vger.kernel.org>; Fri, 24 May 2024 00:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716512391; cv=none; b=e9ZanyQNB0tR9AA8YQaGHWWryMf8y9+gZ43yMuDvDQ9B/Jxc5X2B8ObcE8PNfyRvNdOrWBVE5U6GTwlct588/tuRRtNpXwHW+CEnEFwJly/t2ShAvQ/IML27/7wJU4iXTMvTZ8Nqq5QNiUuQ3MPQQUIQByqahtPAD8W+76iW1VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716512391; c=relaxed/simple;
	bh=QxsX++cyOwnAy1udmhMfTSFAkPB78kozjWnVzukiL6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d+OzLKPd8Ka9IBRjY2qJXsoa6+6CXeAzUeK2lPnrk9zJtdkQGnHmNoaqxSZDADYZVuF5Ox3cvQdOlQSE6fXV2ZLJSJQ9K5xHWXRzL1FlSKctpMU40fsjExQwzFHowUKesBWggeX4ZIcPLxTCp3Gx5JbUjA7QmPEn7UByY3yaZvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YS4D6qDo; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-354de3c5d00so1230408f8f.1
        for <bpf@vger.kernel.org>; Thu, 23 May 2024 17:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716512388; x=1717117188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWw1PPrJrBTQSrqYDqZSFZtTbrotPvB64y+sZCtvy+Q=;
        b=YS4D6qDoMoUs9yRfXdK6LPmKVTgPxz3qnRKiwcg0N+oxQbxTrFjbXCXqEphyrCDzHB
         mGu+yyNEyG8dV6l/VyKcoOHjDc3kBgjMXKFN29nNdsuDaUQ9PiHAhBJMF2g+fE2cOyOw
         9TfnwMCnXyeFkPwVbO8vuxb5hw/ysT3YrTKla42GAog0QPxmObLDGSjJ80IunwBxeqZx
         2C2PZTWdT+z0hrO+DKMdyMAoqn62s84Ctq9R0SCj8bVYKKAyZULH4H1DMzCTVX7zlRH8
         GQYsKuDWcdYfiotKIPxFMSma51X8kkdLLkp3HeqRYWBRKV8zX+bmp3OtI3co1p35aY3e
         r8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716512388; x=1717117188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWw1PPrJrBTQSrqYDqZSFZtTbrotPvB64y+sZCtvy+Q=;
        b=S1Peyap6QVtTijwT8y5qvKLDXKBPYqs759vOS6hQ0owO7X86D/T1zM55SyKNznCXae
         OMu1K2KrJhJoirOYpqOrv3jk0I13Turwkjm0wA4aYuGmKloTaATjXMSsAyfyGcsPRQKX
         unaJbm5o8sjFEzeJ0CJAlsemqfLq0+l1lhzyOgQEiLWNpzlgamQSYVfbHjChYMA93Ra1
         s2CTKU+9BhFzMbjQd1UpTKkrmiSPOKpjtkNTeSBsxWVBJ2XZjXGR/ZDpuomUVaopmsKW
         9TpZGouyo34pdsnqE6GMCEUgBQN4MmlUoJYfBrLBTOAFguqvVeyJ739hnq/gjfdwUpGY
         Kf/Q==
X-Gm-Message-State: AOJu0YyVWo3/KGrYbnYMtUr6xBu81GrcVTULjU/wYYhjaNuqcUIzSKW/
	1o0F0XFdcGb1mpVj+v/glQDcoJoK0sVOioBDltWX+lFHZi47fVZwgvQ82gL9FEYakJIG81M+Ek1
	TJekz2Cpi8d5rdzYgeZM3E0+GiNBd4A==
X-Google-Smtp-Source: AGHT+IGkzqOASjEKVswLFSYUGJ/YED7OOVhkav8CH6lTyP1P3EbB5NlMY86JjygJgEudcSzI+iHdQ1YBVrJd67DOPak=
X-Received: by 2002:a5d:584e:0:b0:355:95bd:9d01 with SMTP id
 ffacd0b85a97d-35595bd9db3mr391037f8f.1.1716512387451; Thu, 23 May 2024
 17:59:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523064219.42465-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20240523064219.42465-1-alexei.starovoitov@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 23 May 2024 17:59:35 -0700
Message-ID: <CAADnVQLjAV8i3KO2hqRoQ9Yab+mq4z4N7NkCgw-Qpq+bqm-HsA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpf: Relax precision marking in open coded
 iters and may_goto loop.
To: bpf <bpf@vger.kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 11:42=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> v1->v2:
> - Replaced copy precision logic with faster and more accurate alternative=
.
>   See find_precision().

...

> +static void find_precise_reg(struct bpf_reg_state *cur_reg)
> +{
> +       struct bpf_reg_state *reg;
> +
> +       reg =3D cur_reg->parent;
> +       while (reg && reg->type =3D=3D SCALAR_VALUE) {
> +               /*
> +                * propagate_liveness() might not have happened for this =
states yet.
> +                * Intermediate reg missing LIVE_READ mark is not an issu=
e.
> +                */
> +               if (reg->precise && (reg->live & REG_LIVE_READ)) {
> +                       cur_reg->precise =3D true;
> +                       break;
> +               }
> +               reg =3D reg->parent;
> +       }
> +}
> +
> +static void find_precision(struct bpf_verifier_state *cur_state)
> +{
> +       struct bpf_func_state *state;
> +       struct bpf_reg_state *reg;
> +
> +       if (!get_loop_entry(cur_state))
> +               return;
> +       bpf_for_each_reg_in_vstate(cur_state, state, reg, ({
> +               if (reg->type !=3D SCALAR_VALUE || reg->precise)
> +                       continue;
> +               find_precise_reg(reg);
> +       }));
> +}

This turned out to be an ok idea for a good case and
horrible idea when loop doesn't converge, since walking parentage
chain is very expensive when loop is reaching million of iterations.
There will be a v3 with fixes.

pw-bot: cr


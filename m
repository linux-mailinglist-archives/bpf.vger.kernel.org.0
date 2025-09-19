Return-Path: <bpf+bounces-69003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 463E4B8B796
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 00:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6280D7B2129
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 22:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F234C25F784;
	Fri, 19 Sep 2025 22:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H23abTHZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237141DDC1B
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 22:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758321124; cv=none; b=Jjf3KSNKtbj42h06FoDCmQzqWZ+I6mZ7t0e6ncAqpmYVNZ2NaRJ1ihjXuI06N96GLcCkz9At67fCrY7FTHjqaLWLehkVo26jeh36ZXyn4ECOFBVKk/RFBYQ5mImF1fQ65jISerzr7xLp6Sf0C1gpzp6uR7YlwQv9f+4fHHyQkgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758321124; c=relaxed/simple;
	bh=C/WAYjtUfCbh/mAIBtNPFNH48RNafq2/9m75zxgtBIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b7kyWAi84zJNEJZeQ9GWOIWBJ9iWSVgtIH+JAo7i7/EKawyMi2ViZ/38C0oSXQQumUD3qsQ7uJifHy/eru5qlynKv5YMPbt7apJnbhJtSiFQxm8HeoYfr+UfXzbtEfdQDUby2jmpkPtY/YifOWWo1zAbIoYlxNvVXYssCzNC/J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H23abTHZ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b5506b28c98so1440879a12.1
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 15:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758321122; x=1758925922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTlrxr3rNicIqRXPX/OqzCaAPWSU2a8N7NS4e90QrH8=;
        b=H23abTHZnShrhZO9SnQswIlLPMGkDpm8/o9JtmA/R6OksWuL8VJdhojqbWuZCNkUjt
         kC5b9ucMqTiaFFc/abjkyqEjQgVLMcmXxcR/B6feRiGoePEwMN9jbE9Z+jdX9MT/yHuw
         qp8UoRJ9CgWe0SSsR/B9Afgq4N2T1/Yi3/K4outstx5xyxzOrhg6RCZeEfpDsVmtFsgV
         wtU8aEZPo35rlAQHSxhtaKutCWlsaPoLqM4E2JwIRKdF+p1AJJ2vWI8Tm0HschznjpJr
         k9Tc8S+9aQ1OhefM5EqUjJ1lvVAEonuXtspbHIC30vlhh/m5QgpXnBpwbjJGmISfH/Oi
         PRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758321122; x=1758925922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTlrxr3rNicIqRXPX/OqzCaAPWSU2a8N7NS4e90QrH8=;
        b=lT2QZRfYeqS4zlQSR51q6444ST77lxX3vwjb83gWT9MgtbPJKuTeMr7mrmth3fdcJ1
         pW8hbYBhAubBoeZWGZHwFdF+2owcEJMII4PL9V7C7/9XCRXEAp7TwKiOQ9G0nkHAzNUe
         oOFRivfQtwv1Pevmo1knSiy6w2jAAFsiJXpXefYLaCcWJUFOftXiRGApfwryI/6w3uAu
         jDKz5pNfBIDIyoBo5LGnFZoo9E18uf1xiXVtNN9sjJwtPD6pzJ07cDmLaEEKE64kwFyh
         RwbbpHMlqfXeXSkQtr7eV/VVZpZRV3FoNfVcbuFqIq+1uuBqYqDCWP/U/w5+mYczEv+T
         KqiA==
X-Gm-Message-State: AOJu0YzYyeu1A1pg9B0rxWgnEgPN1PoIwYBrMvNgmYMn3Cby05omR2D9
	JXEx84ghBF9Txx3V6vikc9PPfVG1mOlfJY+59krjDoxhHuKmsTMe8DPw/ZTH1KYl+LM7XWBhBEL
	XvaadsVooTbim7G7+4SXKY9XKcF0PSrTdStve
X-Gm-Gg: ASbGncsL7xU3Nic3FfVCryL/WFJqlLBxzoYAThDm3xqjMQkDNNIezIVW0GV2pG+QpJL
	YTNFD7pzfPXucwakACyia70s8KkI6F2vsAuAgEbsAQ+ULKQpn1iGjN/+XPrRNqmz4c1fV51NVx8
	MpP/xkllCxN4n+00zniVgbTTnJOCZ6yCT+EYPc3NyibsDz0lWLCUCvQrSBM/Nor5QKXaYayTRQZ
	X4eQWLs0t7nUtjDdacTErs=
X-Google-Smtp-Source: AGHT+IE0H5iIbAGn5hEO0NqETdIqLxXepoDwK7AiZc4dDO1dLdPRmoejr7m6FY5sPYzJJa9s/QDrBERneyXw6YeT1nU=
X-Received: by 2002:a17:90b:3fd0:b0:330:852e:2bcc with SMTP id
 98e67ed59e1d1-3309834e1f2mr5302181a91.21.1758321122250; Fri, 19 Sep 2025
 15:32:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910162733.82534-1-leon.hwang@linux.dev> <20250910162733.82534-5-leon.hwang@linux.dev>
 <CAEf4BzZJ3fEd6EaBV5M8QX=bTtL7bx0OM1E3o5HAgCemfuFQEQ@mail.gmail.com> <40840553-6c0a-494d-8429-863c4a6608f9@linux.dev>
In-Reply-To: <40840553-6c0a-494d-8429-863c4a6608f9@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Sep 2025 15:31:45 -0700
X-Gm-Features: AS18NWDDdTESlU51qYvioSXKeI3GPdNbtAmac73ViQdoSv65OiQGJJtf0EXKbew
Message-ID: <CAEf4BzYTse1=pAYcM6y_vKbm74ZDtSu2Daj3sLewvKz16WF9NA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 4/7] bpf: Add BPF_F_CPU and BPF_F_ALL_CPUS
 flags support for percpu_hash and lru_percpu_hash maps
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, jolsa@kernel.org, yonghong.song@linux.dev, 
	song@kernel.org, eddyz87@gmail.com, dxu@dxuuu.xyz, deso@posteo.net, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 10:25=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> =
wrote:
>
>
>
> >> @@ -1724,7 +1742,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_ma=
p *map,
> >>         value_size =3D htab->map.value_size;
> >>         size =3D round_up(value_size, 8);
> >>         if (is_percpu)
> >> -               value_size =3D size * num_possible_cpus();
> >> +               value_size =3D (elem_map_flags & BPF_F_CPU) ? size : s=
ize * num_possible_cpus();
> >
> > if (is_percpu && !(elem_map_flags & BPF_F_CPU))
> >     value_size =3D size * num_possible_cpus();
> >
> > ?
> >
>
> After looking at it again, I=E2=80=99d like to keep my approach.
>
> When 'elem_map_flags & BPF_F_CPU' is set, 'value_size' has to be
> assigned to 'size' ('round_up(value_size, 8)') instead of keeping
> 'htab->map.value_size'.
>

isn't that what will happen here as well? There is

size =3D round_up(value_size, 8);

right before that if

> Thanks,
> Leon


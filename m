Return-Path: <bpf+bounces-62555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A17AFBC4D
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 22:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 868723B8B71
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 20:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EA221A445;
	Mon,  7 Jul 2025 20:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLWDOTfE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC2B13D51E
	for <bpf@vger.kernel.org>; Mon,  7 Jul 2025 20:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751918981; cv=none; b=UFnMMJtVz1aNIon1KFS4dCZXxSaBV7ai00/XeUewIJWw+BH572h/hWFYRInA+NcjMrpYrRJeG8rwHbvTeHBYfjBan30zEhlsDaxsI4rE6fy3NWN7lbBPf2zn5ZPgL5GAW0F8w6oQRH/KHNKdm684Do2kArOxz0URuZi7xvIsM+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751918981; c=relaxed/simple;
	bh=7TPl0Fn0mG0GAMSzskGy3Gl5yJBJtLjWxScgeR9vfrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=riK59gqSR0C/PURU7XOE8lhBj5zD9WJO+lm5Mudgs1bK4DzZIf6GlbQxKeg3SGQaMR7x/8Q0htf8Pd914MIpk5MkYrFz7oenJD2snfc3axy/y6TtNGe0aGNnEfQIWH/3d/HD5lbx/zHYIcnQEKCSpssY0VymCFOxWMuX3xkVReE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLWDOTfE; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a510432236so2446642f8f.0
        for <bpf@vger.kernel.org>; Mon, 07 Jul 2025 13:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751918978; x=1752523778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TPl0Fn0mG0GAMSzskGy3Gl5yJBJtLjWxScgeR9vfrw=;
        b=KLWDOTfE0gtotWPMnAT/TYI4Prmc85nl+/uleno1V7TjuJOKUlOCZSW/YvwGmFA+iM
         hUu0ENnNG7LRITdKLFfIt/3dteT3PfW2B39eB8h/hs6v7YAPWmHIWSFdB/EcHFXmcutU
         PbNqTBSLixpiqbT/UMVYk+27pLFCohbOs9WYSWPHtHQvC1DxJ7r6kV2thOEUErD5D3ky
         SqWBpfpm1pGQqHdFvmHyfr8zdB37i3qEV6/8zpaZMWmI+mOyzkGZFBEHaNCRhVC1ICtG
         DQZJ/gflSD2+00CTOzLo1q1ahZXHpwR6/Z3+SMbPSvlGNwqJUW1vQxKZyKxLD9cntHty
         3rPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751918978; x=1752523778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7TPl0Fn0mG0GAMSzskGy3Gl5yJBJtLjWxScgeR9vfrw=;
        b=C+lDU6HMqToy+E+b4M49lN18D2d7UO560FTH5drBz045lRnfDluXtzkT0KWBRhX1c0
         4To/HVAjmBIqJAJPiSa+V2Q9g81jvjxxGR7w2V0xSs7KF+zTf5581JB54w5ELt9+o1W6
         UGWGN1Zzcx2EVwOCDWWtOFT1pfwSdXMdNmHVe730sIFM03e0UPgAbRaKoXCfs6sVxZO0
         lU75bEzB99PxmfdHNT0sP8gLAv+mpOebhaXfUPwAe2aWE7COpqOY6h/lVtUsKBxeQFRm
         eYLvdYLwM/JF0Itk82GaMsSwOjdRo6RCVxuOAYz51vBj3tVYKODvBtL5m0q3FYSN4u+G
         VLnA==
X-Forwarded-Encrypted: i=1; AJvYcCUQSeicB28lyLyTdPSzGLjUowT2+S9aFMyQ7EeZC/p/Yg1J3cWiMgDRko04JV7dQIpdoHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ+mwq5axqDBWkmc6XQRVJZVgy1lcCRzpsUybkU8vGGoIqLiLE
	dZ255q6t1aAfUbzInjzUw9C6R0RrmOALTVA8TM2zlbJ6cHQmjkDYgnovqGwSEST5I1QW8k4ElO5
	IOmocDRtonZMopztYqCEcAnuXICC0IkDCKfx/
X-Gm-Gg: ASbGncuIGH9zPGHdmg9xG/NXYFCLUMxkbC9QFY6YV/XPZTkyYKj0w6Kh+3ejwzyo7WL
	Odu6WY9w4VGAJ+HFKiMqSiqdZGWJS0Y5grrDYoQseDCvPLTZuP9+PviiQG4+xQK8ofAE8mGJD4K
	EQNhWH2Q9XvJw2SvKp7azRL8lLKlRGhbrF24I0LK7TCtIWX+avUauTTmhUjUw=
X-Google-Smtp-Source: AGHT+IGMKnkM4FHj0W0Mom8recoXPZzEGX/VuidGNmnXk5eeH1GlOn8z9dF2IadGh8qrXXAP3IuRIMpCW5Un6FLoLMo=
X-Received: by 2002:a5d:64cc:0:b0:3a4:e6e6:a026 with SMTP id
 ffacd0b85a97d-3b49703162fmr10282735f8f.28.1751918978036; Mon, 07 Jul 2025
 13:09:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250614064056.237005-1-sidchintamaneni@gmail.com>
 <20250614064056.237005-4-sidchintamaneni@gmail.com> <CAP01T77TBA3eEVoqGMVTpYsEzvg0f7Q95guH0SDQ3gZK=q+Tag@mail.gmail.com>
 <CAM6KYssFT35L5HN_Fes-2BdhEO6EmhF9Qa+WSWLML4qnZ0z1tA@mail.gmail.com>
 <CAP01T76S4X4f=owz9D7dXfv15=vD8HB8dO_Ni2TmKfqTKCtuhA@mail.gmail.com>
 <CAADnVQ+EiaoWUVcN9=Nm=RWJ6XE=Kcm8Q2FYQqWGJ_NsCtyJ=A@mail.gmail.com> <CAP01T74i8a4daQ1Cca5Eysy==hTKox-ovpc1Y==64M1LacATEQ@mail.gmail.com>
In-Reply-To: <CAP01T74i8a4daQ1Cca5Eysy==hTKox-ovpc1Y==64M1LacATEQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 7 Jul 2025 13:09:25 -0700
X-Gm-Features: Ac12FXx47uSB2uz0aiEEG2A5n5ZpkgRK7XgYLMEDfcgT4ll_V6AcPZu_A6c8n40
Message-ID: <CAADnVQKiek12fUz6LDJUz_yy2EJQdXCYNg_ixE3PYROSWOrSbQ@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 3/4] bpf: Runtime part of fast-path termination approach
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Raj Sahu <rjsu26@gmail.com>, Siddharth Chintamaneni <sidchintamaneni@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Dan Williams <djwillia@vt.edu>, miloc@vt.edu, ericts@vt.edu, 
	rahult@vt.edu, doniaghazy@vt.edu, quanzhif@vt.edu, 
	Jinghao Jia <jinghao7@illinois.edu>, egor@vt.edu, 
	Sai Roop Somaraju <sairoop10@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 12:16=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> The other option of course is to do run time checks of
> prog->aux->terminate bit and start failing things that way.
> Most of the time, the branch will be untaken. It can be set to 1 when
> a prog detects a fatal condition or from a watchdog (later).
> cond_break, rqspinlock, iterators, bpf_loop can all be adjusted to check =
it.
>
> When I was playing with all this, this is basically what I did
> (amortized or not) and I think the overhead was negligible/in range of
> noise.
> If a prog is hot, the line with terminate bit is almost always in
> cache, and it's not a load dependency for other accesses.
> If it's not hot, the cost of every other state access dominates anyway.

bpf_check_timed_may_goto() can certainly check prog->aux->must_terminate.
bpf_loop() can gain aux__prog and check the flag as well.
if we add it in more places then we won't need fast-execute.
Everything that can take a long time will be required to check that flag.
I was hoping fast-execute can avoid this run-time penalty,
but if it comes with extra clone (even if optional for some progs)
then the amortized flag check looks much simpler.


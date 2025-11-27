Return-Path: <bpf+bounces-75621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 904BBC8C74E
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 01:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40AC13B6381
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 00:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5FE273809;
	Thu, 27 Nov 2025 00:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=superluminal.eu header.i=@superluminal.eu header.b="C9VIItaT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F26B26F471
	for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 00:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764204255; cv=none; b=OtPYMAnsnFNPvImAWSYDWSRfckmKJXKMRT5R8Z0YxRXaVc0WvIpq/+yiajb7PJcnfa9VzdD02CeCdkrGkEJMyOOCcMnVmfbbFJ58NJf+j3qjCEEX8gCR69KkUwLtXDBI1RIXhjaLq8K2fjwodGN/3YUgHYel46gm3dqUNPRl7Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764204255; c=relaxed/simple;
	bh=aG+pgRnOJ+DMs5uLweUVaXzLH/Bht3WAdD9IqYyYcsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ezy8xAS6gjHwYcGgJRkDjNdVWzTIi0Wx9HQ+ugquzhmRVPGXgFjl4dsyFUk+aXosvB9xfjuoFrMeriT5iM0p+AKqtPwt4Rlt6zCi62tGxjVtUvl4wd+Uqb40fcLH5PX/hV5IS1i3H/j/7W6a967j8dgj1TgpWFZrTRH50jWKgJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=superluminal.eu; spf=pass smtp.mailfrom=superluminal.eu; dkim=pass (2048-bit key) header.d=superluminal.eu header.i=@superluminal.eu header.b=C9VIItaT; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=superluminal.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=superluminal.eu
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34381ec9197so261040a91.1
        for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 16:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=superluminal.eu; s=google; t=1764204253; x=1764809053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6EAd9LY/yR3zEhrnbS+D5ap7BArxJIcxzT9mWC+tGFg=;
        b=C9VIItaTEt2VrB1LLagTp6gT8N5nIkCl+ofldRTmPfKfXjKk/zmkyNhAnAjdPWYikI
         dk5hfdb332z1Tyk9swG/d2SZSYpHWk4ocxnWVd2xpORCcJUk0G18sjHlTPmDXrBxujqs
         4YgW1rhkg69sbNy2xySaPbGAyqRG+1sIL87OnXeLcfbPnWj2sTk+8CMaU6Dtca/ozaXL
         LzFrKGkZ/3+rczDXAfXoZWazcj1O4DepWYBkhx8oLJt98Nqgqgbtff3CfkhDCWMdXprV
         vGOi6jIXdhdYVWLwT9Y6rCE4Ow2pCi4T+MQ5RHln3IKivklgJ2eioBpfBfwIGrn+Cpxa
         BBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764204253; x=1764809053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6EAd9LY/yR3zEhrnbS+D5ap7BArxJIcxzT9mWC+tGFg=;
        b=CuSoYu4cb1HxpBoVJYJa8W9VaWb8ueDYh4VmPcd+ub2Cqz2wlNh9IwgSflTvm9SC8I
         RBK9wf5rBqI0v1PG9Y+dhhVh9K+TXGoqEOq6GV3OgVQF7OZzCV9cWWuWfnyDxJUNB7Ba
         Hv104TiWFGH2GYjzGF/K+w3pAE6vaD63u0617EE6fp+sgrO/ds0YnkYNBYrYNUdX394y
         iAR01kABlnG+4TY8DZmeq+uKoYLlL2tTpg3I1OcfSivOvzQoY4PF/LsyjKWa0kZsZ+QX
         +JenZEp8pWmAnzARsN0jLwDhuyJt//124gYEoy35Atc8xg8DO1V4meD6iQNEZE2O0mmE
         yTow==
X-Forwarded-Encrypted: i=1; AJvYcCVitJ92pldFvhg71D/raBYn/lzQB/N0IwJmNMGmu+wmKw1bjj2Scq1iFRzzAlrrDiJg+kU=@vger.kernel.org
X-Gm-Message-State: AOJu0YytcAZmu/RyUoD4wnkEFZ3lSjsGgCAMZHNuKl/mAAdcfTHwUxp1
	WW6BS3A7ibtSO3ngZg2aOAtyxrGX1X2ag+nY1C5Sf77EEMCcPostCI3a4h5M9d4Ow16F49guqbe
	yJllurvbdA3WHxdmPpqVcVDv4tuhYilScrzI1TjStww==
X-Gm-Gg: ASbGncsEDUGnmgbfLq7LHeqZ1o7VfTCIUdHdOBBzI7JcgGPBvTuiMX4K9WgDJsKfgx9
	Ev2E2rMPeSeVXEWoapyoHarVg4gbyAkiFT/NDIjJiECb3fVlqO8ls34Coo1m0jgPYYBXxbMV0vy
	zP9aidsqBh8mNLI/64b6+Xw1zn0rMls/NHAFIObF1uxRVJUdI9v2e1opsbOIDhynUbygf3IkueM
	GJoH8kI5iNQAHVnPpftiv4nmz6DDb4PmF+4+tuvWazxb0S+Y7ODCdDRktFfnJ8o54UTaR/T
X-Google-Smtp-Source: AGHT+IGZhgKdedh4CxLdUiQISlEOJyocfIip00rY1+bLk/dVPLdkonye2891ZC8g0TbPCZvntQXqEQTVc4xwr7nRNAg=
X-Received: by 2002:a17:90b:3503:b0:340:be44:dd0b with SMTP id
 98e67ed59e1d1-34733f5d2femr17685148a91.34.1764204252986; Wed, 26 Nov 2025
 16:44:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125203253.3287019-1-memxor@gmail.com> <CAADnVQ+HV+p6P8eLFz8Nsp2=apE8KYGAxTY3LJ0vQoy3AV42uw@mail.gmail.com>
 <CAADnVQ+WrJ3kwccbwMOkuqvFGJKJzGSoHh_46Kgus8PzH+k9vA@mail.gmail.com>
In-Reply-To: <CAADnVQ+WrJ3kwccbwMOkuqvFGJKJzGSoHh_46Kgus8PzH+k9vA@mail.gmail.com>
From: Ritesh Oedayrajsingh Varma <ritesh@superluminal.eu>
Date: Thu, 27 Nov 2025 01:44:02 +0100
X-Gm-Features: AWmQ_bmTMlenQ8H1GA-TH7H9HcXlmmXTfhWvXLQOFVyN4Ng9XEOFbR_9cgbniFA
Message-ID: <CAH6OuBRinOO655Y_zne0rOeD1ud+G_b3o-LesnRrTOcWCtS_-A@mail.gmail.com>
Subject: Re: [PATCH bpf v1] rqspinlock: Enclose lock/unlock within lock entry acquisitions
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Jelle van der Beek <jelle@superluminal.eu>, kkd@meta.com, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 4:51=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Nov 25, 2025 at 6:46=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > Overall all makes sense to me, but I thought the patch will fix
> > these messages from stress test:
> >
> > [   12.636716] INFO: NMI handler (perf_event_nmi_handler) took too
> > long to run: 12.473 msecs
> > [   12.785373] INFO: NMI handler (perf_event_nmi_handler) took too
> > long to run: 261.095 msecs
> > [   21.455161]    >=3D 251ms: total 5 (normal 0, nmi 5)
> >
> > but the stats seem to be the same before and after the patch
> > when I played with the patch in bpf-next.
> >
> > I suspect there is more here to discover.
>
> I tried:
>         if (unlikely(idx >=3D _Q_MAX_NODES || in_nmi())) {
>                 lockevent_inc(lock_no_node);
> -               RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
> +               RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT * 16);
>
> and see that it hits 4 sec timeout just as well while
> stats show that lock acquisition is unfair:
> cpu4: total 20 (normal 13, nmi 7)
> cpu5: total 319 (normal 160, nmi 159)
> cpu6: total 470 (normal 238, nmi 232)
> cpu7: total 25 (normal 13, nmi 12)
>
> which, I think, means that queued_spin_trylock() in nmi
> has no chance of competing with queued lock logic.
> Other cpus from !in_nmi() ctx keep grabbing and releasing
> the same lock multiple times while in_nmi waiting is
> hopelessly spinning on trylock.
>
> I think we should consider:
>         if (unlikely(idx >=3D _Q_MAX_NODES || in_nmi())) {
>                 lockevent_inc(lock_no_node);
> -               RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
> +               RES_RESET_TIMEOUT(ts, NSEC_PER_MSEC);
>
> until proper queueing logic is implemented for in_nmi.

Thanks both! I've tested the AA fix, and the timeout change with a
locally compiled kernel and posted my results to the original thread.

Let me know if you have any questions or if there are any further
tests you'd like me to run.


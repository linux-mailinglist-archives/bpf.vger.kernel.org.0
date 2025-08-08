Return-Path: <bpf+bounces-65255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CD8B1E257
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 08:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A78DB62132D
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 06:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA1E221FB1;
	Fri,  8 Aug 2025 06:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wi6PMwGt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453EC26AFB;
	Fri,  8 Aug 2025 06:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754634754; cv=none; b=taH8K05VxRJdwwo7/fG+hbL9IiG7AmmuM/HKFFWaGyoQsXYpMuxMPCFjbqfSSonwXWa6/lm9NPSwBgs7CISfm4sIolBMcopIDqa15m2Rh0Li5Xke9y/US6sOIIVELH+NUEOy6Nz9KJe3RsE93mQlrXy/ey5Ed3uEXVqhdAIOL/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754634754; c=relaxed/simple;
	bh=09vs+9wIX3El3CMG5NovDOr2gXAnypcPwnQ1hqFo3vU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BjlJwU+ce81Xr7jVsoffj9kLL4gBzp05eT3aZmXDKFkWSXPGyh2gTdU4jlutTinsztK9o/aPrFdFTkUL3dH0o+NHpdc+4VZzb5plSJw/3mZ1ZN06z0Leesow0EDosxQG3aaoqrLOEpZre1qhtPorkL6Puf/uij+98qyT9MRw4jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wi6PMwGt; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-e8da1fd7b6bso1629948276.2;
        Thu, 07 Aug 2025 23:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754634752; x=1755239552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gt9ZsO1nheudsEaJUBPemdj5Cga+NzjEQIUdFfDdTBU=;
        b=Wi6PMwGt4OX6Osc31o9UGcN4MfTQMfUcEH/LAmaT+OgUKcYqIzNWp0th9+ba5HSgzy
         +p9SaAxKM9hNG6k2zc+PU/UT1l5RfGFwDOSSxkNemSYnf3uaJ9NExj+eORAUUZcuEHvM
         ufkEvstg24cAMg0JNg7x/mZQxQiafl2fHrLeQ1MuR1/5WwsmDv69BpOW/+s5yrCi7GpV
         ZjK4f5aKDhod/hs3aNzn2Zfc1FkMN5BrHJmDe1+/YJ6emcIgcsZ0OF0ck03sqoSr3C8U
         VAw42oryG5Utn46+bn5J3P2rjOQZphZE8l6FO50Q4HSMj5/msGg7QoBpYVQvDDrDhQS6
         811w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754634752; x=1755239552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gt9ZsO1nheudsEaJUBPemdj5Cga+NzjEQIUdFfDdTBU=;
        b=DxdLLHQfO+uikTwim5LM/UNgeoGOE/jCy3Kr8F61RC0mnEs3UxRjJ9lYqXJH/Wg10/
         1ma/MrKzMxjDv8QlicWcoLk5TetWn4BpPZwAYW7Peavm1g6MsXgQL5wVm3G1gflNNVOr
         xDUpdnEdcvICDC61pvQK2in/aS54EkYkST+wDV2yV3ANDCKSdR2UqTLpAqEkK5KKExQz
         Sh4cTMmgXvrOu5diFxwzUmNMVbg5Ch3gY4OcHV+tF+pDMPsl7mT+CBR5Fp60myqjiDH3
         rVqkoliKl4QLK0NNZ62qSLpnEopkbNCVcNrGMBukTJvGHNoFY0ENwwg5aI0+bs3yJVsG
         c4zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYh47jUnAMQvPkrtF3QrnKWkboOPpcwRdkfJBerqGx6XJXOq6BvLpEw35KwKlX4NIox5Q=@vger.kernel.org, AJvYcCWkZW2J0vBrhJtyuxyv5rtoNFqw848HvdvqpIaI2HIfpTTzTGu/9QSaCBQl8F+Q8d5YRq6mXr5s@vger.kernel.org, AJvYcCX/fDTvxyECykFIRk6uNeXjExXHaITRYixaEMEWPUKS3IreeF5gkA34/7nsylbkkQKTS3FNZEBbGIH04XmD@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5uBn9IWISs5ISO0btP/zfYeG2AgSRSB4zgpCTLcRXEYv14rXC
	lfErikJQWPs33dcbUYHuY2aG04+b+SK4zpdfczZCP3p+1wtTAxrSudD/EL/QGFXUHuw21gABAks
	Y/jHT1zIvQdBbD0dra+ENsbQSc/NNY58=
X-Gm-Gg: ASbGncuY/BQh8q+XJJ8Hb35PpU6mSBoLgz4u3mqzl4tiU9cDWgJPjGapCG8ZMl8b5I0
	djaoaadpgrVkFwcQ7AZnts0cQ9Q+bjOhGgURl1iELKpn65M0eo1GeGtP54+9jF9KXos2AswkAHb
	BCDWvhPmA0xq2TfsojbS2DnyxDoHbwc60kwKGy/blDw6hzHJySzcqgjPLPZpvk+zXcyVQTO0/cy
	rNAAEI=
X-Google-Smtp-Source: AGHT+IGGsvIuBG2qPoh9zkwtLYd/BaFKSVD7NsRlik0Wc2DWUjl7M+XIqzQ3GfSaZPJk1SAoGmtLVwOPrcP+iuITA0A=
X-Received: by 2002:a05:690c:28b:b0:712:c55c:4e65 with SMTP id
 00721157ae682-71bf0d36b00mr24377697b3.16.1754634752182; Thu, 07 Aug 2025
 23:32:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <20250703121521.1874196-3-dongml2@chinatelecom.cn> <CAADnVQKP1-gdmq1xkogFeRM6o3j2zf0Q8Atz=aCEkB0PkVx++A@mail.gmail.com>
 <45f4d349-7b08-45d3-9bec-3ab75217f9b6@linux.dev> <3bccb986-bea1-4df0-a4fe-1e668498d5d5@linux.dev>
 <CAADnVQ+Afov4E=9t=3M=zZmO9z4ZqT6imWD5xijDHshTf3J=RA@mail.gmail.com>
 <20250716182414.GI4105545@noisy.programming.kicks-ass.net>
 <CAADnVQ+5sEDKHdsJY5ZsfGDO_1SEhhQWHrt2SMBG5SYyQ+jt7w@mail.gmail.com>
 <CADxym3Za-zShEUyoVE7OoODKYXc1nghD63q2xv_wtHAyT2-Z-Q@mail.gmail.com>
 <CAADnVQ+XGYp=ORtA730u7WQKqSGGH6R4=9CtYOPP_uHuJrYAkQ@mail.gmail.com>
 <CADxym3YMaz8_YkOidJVbKYAXiFLKp4KvYopR3rJRYkiYJvenWw@mail.gmail.com> <CAADnVQL_tMbi-xh_znjGwvvY1GkMTUm6EvOUU1x7rNPx53eePQ@mail.gmail.com>
In-Reply-To: <CAADnVQL_tMbi-xh_znjGwvvY1GkMTUm6EvOUU1x7rNPx53eePQ@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 8 Aug 2025 14:32:20 +0800
X-Gm-Features: Ac12FXy3mxx2F-b20OU8lIsb12E-iGNTqf76Dos-9H44ul6naxHyqyk4jZEAUY8
Message-ID: <CADxym3ZeuoSXDS3j+Sv-Au-FbJzKjkh7TPmM619gRODuRCKzJw@mail.gmail.com>
Subject: Re: Inlining migrate_disable/enable. Was: [PATCH bpf-next v2 02/18]
 x86,bpf: add bpf_global_caller for global trampoline
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Menglong Dong <menglong.dong@linux.dev>, 
	Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 8:58=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
[......]
> > +{
> > +    DEFINE(RQ_nr_pinned, offsetof(struct rq, nr_pinned));
>
> This part looks nice and sweet. Not sure what you were concerned about.
>
> Respin it as a proper patch targeting tip tree.
>
> And explain the motivation in commit log with detailed
> 'perf report' before/after along with 111M/s to 121M/s speed up,
>
> I suspect with my other __set_cpus_allowed_ptr() suggestion
> the speed up should be even bigger.

Much better.

Before:
fentry         :  113.030 =C2=B1 0.149M/s
fentry         :  112.501 =C2=B1 0.187M/s
fentry         :  112.828 =C2=B1 0.267M/s
fentry         :  115.287 =C2=B1 0.241M/s

After:
fentry         :  143.644 =C2=B1 0.670M/s
fentry         :  149.764 =C2=B1 0.362M/s
fentry         :  149.642 =C2=B1 0.156M/s
fentry         :  145.263 =C2=B1 0.221M/s
fentry         :  145.558 =C2=B1 0.145M/s

>
> > +    return 0;
> > +}


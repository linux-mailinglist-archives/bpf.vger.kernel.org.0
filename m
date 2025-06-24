Return-Path: <bpf+bounces-61335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8996AE5980
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 04:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F2AF17F1AE
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 02:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56F31C84DF;
	Tue, 24 Jun 2025 02:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8zox4XS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C294214A4CC;
	Tue, 24 Jun 2025 02:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750730639; cv=none; b=QL957ZVPHFF/oKSa6FjpVQ39dSvNujsqkWSQk3Rs/a0fkZxiUxXptmUmL3IQe/2HwrIXacsQS/fnZDTY1CHrCdsiJ0KmvbICrRHWfCrHmpmqdnzEKXf1wjuqtHJiQBL5lSx1MXJtzga3A3QBbkA3J160AfvQ8Cnxuo2fhoCVJ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750730639; c=relaxed/simple;
	bh=UJE2/Y7LI/pKefGOhbN7ZDMBgEeuetvdd15cyoz+nKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mK2GyvndggGR6EjtK+EwFgjUclnegh0i0J7ArSPuU3xZmJU84uqwI+xI57CgsccCfUgoBJBnhdS3feXR20UkDqVPGd01LhX1xR0By3iFzOYLqVYJqtcKRkJmfs9Y+waScOxgrhbh/Kl0a4wG0S35T0JXLzSUZJ9IVegnpz7bUl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8zox4XS; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-7113ac6d4b3so44657707b3.3;
        Mon, 23 Jun 2025 19:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750730636; x=1751335436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbET8ZuLZumqrMIKpSUW3w2wpA6THdEQI6aTEMnHyl4=;
        b=W8zox4XSyrGoow1yeCIiJ/X0LNsvpmyXBmMLfgBJANUmqNIPSTHOq2AYfPNTSB2IEa
         ec8WKfqCYgOUFklFqTpP3FiOuB4onZvWAPq85hUsJvukhFSXpe83pe0jpXJeupLsCtSR
         YES6yMsmtLxAjh0Gjz+UU7RngyZwPXfAm+T6w/821KFCq4ZKKjKmifXRh3QAJYv1jwO+
         tUJV9KvHjhI/pdTUPDGl695T8GL2p9pkUTKPu7UHv+HnwdI2o2va0Z+iCQp+qgK5yruH
         8Tu4+J2hIA0+d32y5ap++/HeI6rBWNbd03bhWiHq5QL0yzw/vZvLvaFRx1MBFtmj+4i0
         qH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750730636; x=1751335436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LbET8ZuLZumqrMIKpSUW3w2wpA6THdEQI6aTEMnHyl4=;
        b=ZfxFwO7gU9UizBtmIKc8YJVw+dwVrzV026nuVgcPwrjtFsqG78Vqbtqf/ZnOjQPSYy
         1VkjouOWpAjrtxvfILcEyQt+OQRSlv2yPrq3UdDgsFtlQN8Dbo+2S0q5JPMEhSQK9VHf
         Thcp/RXsKcLMt2aebuBSTxLtgfyG+50fcPgYbFf1s6RdjmOqUT6TFiHSy3IuyHi1E3mc
         I7jN9vOjFtUd+NCcbP6OpJ7kJubopqxYZZKnG/CmZjtjXDnsghNLafwbT7/h0xSDZ12L
         tibE9b+KVliOaZUvgY8C/99xzSQLpR6Q0g6AyjtXQ+v+Gzcgjxnr4kop+5B1107/xul2
         twjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqqEdTTnWK0WymlhM9/z6vwuUsFqGtqdkIy265S0atPcbfxFVsPf0tqhXI6dkcocWC91DbpyZ8v/KZsrHB@vger.kernel.org, AJvYcCWXdObsHr2HR32wV02KBX/YP+chFy+WOfSVROAKz0jP9RYuZpDraE65Te/x+K67obBsLfY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz1iofUHRbl+FCduTfkAD3vFW31eKWABeT5gVa4WF1QAepZL9j
	pfPVA4SOuMDtCGNzKLMqnLtCqL+V1AKlA97TcUhk5IdaSEQCXFEavUaPMUTe55yxforFt/rcX85
	81a76ol4RcyGlpw+4v/UTEQsHskCd7X8=
X-Gm-Gg: ASbGncu4giLAh7KooZ6Ve3eMEtoTvh+oJig/YBBFDpzJ5iI+sXsnNL8A4ImlFq8d/NG
	DQsTdzrWGBJWFx8E48oy4SIZMs8JKXUpG9TrV8X1+3+GXjDyHPjnNec6HhwyW6acHzbdOVY8B/B
	LLJKN57YjwysgT1ACGdrXQCq0ow/gew7Cg+pjwWrIfJj8=
X-Google-Smtp-Source: AGHT+IHOPhdtF/Z59QPk3w46p7Lp0drAeKTcVm8UPsK5Kg2MvMFSi2UmEpSzHr9pm8xE1Jb7PAqQtqtwFxDigvZ7uiA=
X-Received: by 2002:a05:690c:720a:b0:70e:1d14:2b76 with SMTP id
 00721157ae682-712c65176efmr217686177b3.23.1750730635611; Mon, 23 Jun 2025
 19:03:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250621045501.101187-1-dongml2@chinatelecom.cn> <CAADnVQLz7-tVmJ7C3VdNDcL8y07Vyg5Ad+DhKAQ7odQAo_BO=Q@mail.gmail.com>
In-Reply-To: <CAADnVQLz7-tVmJ7C3VdNDcL8y07Vyg5Ad+DhKAQ7odQAo_BO=Q@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Tue, 24 Jun 2025 10:03:12 +0800
X-Gm-Features: Ac12FXyvar2ZApG5VPKeQGwM1dztSP5um2keuHqSibu6UiSRKIDa7zDE1AnkIEI
Message-ID: <CADxym3bJUNA4H_ksUhX9tjcDQSrLTvr0kKaPzVzeEC79o0OVTQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: make update_prog_stats always_inline
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Menglong Dong <dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 12:26=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Jun 20, 2025 at 9:57=E2=80=AFPM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > The function update_prog_stats() will be called in the bpf trampoline.
> > In most cases, it will be optimized by the compiler by making it inline=
.
> > However, we can't rely on the compiler all the time, and just make it
> > __always_inline to reduce the possible overhead.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> > v2:
> > - split out __update_prog_stats() and make update_prog_stats()
> >   __always_inline, as Alexei's advice
> > ---
> >  kernel/bpf/trampoline.c | 23 ++++++++++++++---------
> >  1 file changed, 14 insertions(+), 9 deletions(-)
> >
> > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > index c4b1a98ff726..1f92246117eb 100644
> > --- a/kernel/bpf/trampoline.c
> > +++ b/kernel/bpf/trampoline.c
> > @@ -911,18 +911,16 @@ static u64 notrace __bpf_prog_enter_recur(struct =
bpf_prog *prog, struct bpf_tram
> >         return bpf_prog_start_time();
> >  }
> >
> > -static void notrace update_prog_stats(struct bpf_prog *prog,
> > -                                     u64 start)
> > +static void notrace __update_prog_stats(struct bpf_prog *prog, u64 sta=
rt)
> >  {
> >         struct bpf_prog_stats *stats;
> >
> > -       if (static_branch_unlikely(&bpf_stats_enabled_key) &&
> > -           /* static_key could be enabled in __bpf_prog_enter*
> > -            * and disabled in __bpf_prog_exit*.
> > -            * And vice versa.
> > -            * Hence check that 'start' is valid.
> > -            */
> > -           start > NO_START_TIME) {
> > +       /* static_key could be enabled in __bpf_prog_enter*
> > +        * and disabled in __bpf_prog_exit*.
> > +        * And vice versa.
> > +        * Hence check that 'start' is valid.
> > +        */
>
>
> Instead of old networking style I reformatted above to normal
> kernel style comment.
>
> > +       if (start > NO_START_TIME) {
>
> and refactored it to <=3D and removed extra indent in below.
> while applying.

Looks much better, thanks a lot ~


Return-Path: <bpf+bounces-51896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0116EA3AF7D
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 03:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4D21176D8B
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 02:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7891A317F;
	Wed, 19 Feb 2025 02:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kz/ZxYrF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC85719AD89;
	Wed, 19 Feb 2025 02:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739931511; cv=none; b=Izj8mvfkW7FYDLrXCZipFNMDqc93+6Fuo+m2NU0YgO3lF+xHrcGEeRhfDI73AG9Lk+5+rZv/QBO/e656s9Zx3gm0xcPm4LsPoi5lJfJCXVcD2LlMGzdN/xu8xY0iIZW96t9drQzHbQu4hQrQtZCXU1gsQbxsrBZBpqf1tAfXzVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739931511; c=relaxed/simple;
	bh=jl75z7y2Ms5wnV8uhx97wUGOOWXQKm0wQF8durQp6KY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZmYfSNi/7bm2e+eqj9jMAdoQGosYvzUb0XW3MlTAbO+uTUuAfuLJDn5sPWjdSB5HLsSW1qLkOO7qNI904Sm3jjVQ6HjXTDPqJDUxY81PHt5la4bQ9mHLEeqaZLaOY7j9XLnOLy0ITT+W0QcpzdrwsCdy6wE0UsaQteHMiSRePzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kz/ZxYrF; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3d2acdea3acso4241275ab.0;
        Tue, 18 Feb 2025 18:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739931509; x=1740536309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9f0XbZfBregd+bocxqnOhX6INh3mabe05JGJ5DhhbU=;
        b=kz/ZxYrFy6UL6SDg4NZFiN+Kv18KlqEnoX9f4blPl5HiDLkAi92NsIgNmkEtac2l0D
         WAAa+6io7201o3PO7rqQVa7el6UYmlTGibL80XUD7COUH0yV+kbW32qpZU+h89bj/iEl
         Y84ob7s5BE9v1ay/vfi2ap1faZiv2f9I28NXX5H+wpA4GewrEIt8PpvLNn20EjQS5skc
         8rm4u1/qHLfVPqSypTRbAGy/7IrX1ebAfC+/ZZGA02k4ch8g+nxgPMgn3d6DPznRjXXl
         3s8AnmvtjrEYY2NKtembLSgRGm9ae73XjrMj1+6qAuREBWqWHBgXfXlwEJRxqtTyKiWY
         yWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739931509; x=1740536309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9f0XbZfBregd+bocxqnOhX6INh3mabe05JGJ5DhhbU=;
        b=wx/GMumWPBCuNxY8NZFEx59cqGVpgyryP8H3kgy0B3sJbS+bWSfJG7a+45Xa+rmyw4
         IDCCXuAqtukIGhv5M6ueFau7mV92cDC4kt2Bmz80rK7Rb21YrBWM3aEjP64ZQAWfe5GN
         sihvMhXU+K+L2sBzm3MJH5VpIOnH56SJxTa37pBnURSVtT7u4MQC2CrxMVUGWAl/qK3K
         tmkYbJDZ0vHeBQs+fZkTZq/g5Y29srXFcG5eIvnRpfxS9sv3uP0ByphBz84XmrloFOf8
         zyDxtnoEKyU+5l17f0DfPqrQ0NemJlcCGZbHkCADzaOvjJWF3wpP29oty/Ldqb0SMUua
         GlCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe7j5XysoLg7OilnXIFkWt8BOGcElLcCqe9qIQsikbl9g+g3xLANEPeApM0MnSkSmf8eK23Zzd@vger.kernel.org, AJvYcCUsG3Q9TeEdlt03N8FKzlbvbRnfcAFkNufBBjYwMmLBug+3fNQmnxmyH2JkHgBJG48Nk10=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVIc5DxUnLOaPWgxuqkDQRfquV8aKvBj8a1LiqeocwJqmnV0PL
	erWseLdth6ym18CqTQnwPaCucals1ohLFA+Xb+06cmTFo8Hb/WunpgGYN5BiN2gQJaTtCQfQYaJ
	ux7x3ebEpeJ+k49/a7uKJlrt3px8=
X-Gm-Gg: ASbGnctNmCnY5SxYhsAW/h9Orglch6MABP5YhxIgn4GKFmsTCInElrO34UzRQQwL8vB
	oX7dq67+groUStFSMIpZdgqgIqYt3xxLnwhCFCeRe7SY+X12RuZ0QycpGQdTYeG0rBhTiilX+
X-Google-Smtp-Source: AGHT+IFBfIt9gD/lPHDelW3Ua/esb4rzG+Ztl3Cw/nQLbQKXt91q+TwDnjS+MWtu7+pmpdLqKXfCciJJBkrbyxmVfeE=
X-Received: by 2002:a05:6e02:2405:b0:3d1:9236:ca50 with SMTP id
 e9e14a558f8ab-3d2b51058fdmr20286385ab.0.1739931508953; Tue, 18 Feb 2025
 18:18:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217034245.11063-1-kerneljasonxing@gmail.com>
 <20250217034245.11063-4-kerneljasonxing@gmail.com> <71d6c5e8-058b-470d-b411-347e2a1266a5@linux.dev>
In-Reply-To: <71d6c5e8-058b-470d-b411-347e2a1266a5@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 19 Feb 2025 10:17:52 +0800
X-Gm-Features: AWEUYZlbh2oCK0IQx0-4m6xzaDq8VXCBU1Dme8VedQZhQitSZcfMjGP1nYzVaU8
Message-ID: <CAL+tcoC0jsCMie0Y5qgwGVb=MZ+gfMhBC3eodGp3G5Yr=dC4Dw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: add rto max for
 bpf_setsockopt test
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, kuniyu@amazon.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, 
	ykolal@fb.com, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 10:01=E2=80=AFAM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> On 2/16/25 7:42 PM, Jason Xing wrote:
> > Add TCP_RTO_MAX_MS selftests for active and passive flows
> > in various bpf callbacks. Even though the TCP_RTO_MAX_MS
> > can be used in established phase, we highly discourage
> > to do so because it may trigger unexpected behaviour.
> > On the contrary, it's highly recommended that the maximum
> > value of RTO is set before first time of transmission, such
> > as BPF_SOCK_OPS_{PASSIVE|ACTIVE}_ESTABLISHED_CB,
>
> s/,/./
>
> What unexpected behavior when setting in BPF after the established state?
>
> Setting it after the established state or not is not specific to BPF. sys=
call
> can choose to do it after the connection established also. The above make=
s it
> unclear what unexpected behavior that the BPF prog will cause if TCP_RTO_=
MAX_MS
> is used in BPF instead of syscall.
>
> If there is subtle difference between calling TCP_RTO_MAX_MS from bpf and=
 from
> syscall, please write it clearly what are the unexpected behaviors when c=
alling
> in BPF after the established states.

I don't think there is any difference between them. For both of them,
It would be better to set before transmission.

>
> Otherwise, the commit message can be just this:
>
> Test the TCP_RTO_MAX_MS optname in the existing setget_sockopt test.

Got it. Will use this instead.

>
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >   tools/include/uapi/linux/tcp.h                      | 1 +
> >   tools/testing/selftests/bpf/progs/bpf_tracing_net.h | 1 +
> >   tools/testing/selftests/bpf/progs/setget_sockopt.c  | 1 +
> >   3 files changed, 3 insertions(+)
> >
> > diff --git a/tools/include/uapi/linux/tcp.h b/tools/include/uapi/linux/=
tcp.h
> > index 13ceeb395eb8..7989e3f34a58 100644
> > --- a/tools/include/uapi/linux/tcp.h
> > +++ b/tools/include/uapi/linux/tcp.h
> > @@ -128,6 +128,7 @@ enum {
> >   #define TCP_CM_INQ          TCP_INQ
> >
> >   #define TCP_TX_DELAY                37      /* delay outgoing packets=
 by XX usec */
> > +#define TCP_RTO_MAX_MS               44      /* max rto time in ms */
>
> Have you checked if this change is really needed?

I thought we needed to sync it from include/uapi/linux/tcp.h. Will test it =
then.

Thanks,
Jason

>
> >
> >
> >   #define TCP_REPAIR_ON               1
> > diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tool=
s/testing/selftests/bpf/progs/bpf_tracing_net.h
> > index 59843b430f76..eb6ed1b7b2ef 100644
> > --- a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
> > +++ b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
> > @@ -49,6 +49,7 @@
> >   #define TCP_SAVED_SYN               28
> >   #define TCP_CA_NAME_MAX             16
> >   #define TCP_NAGLE_OFF               1
> > +#define TCP_RTO_MAX_MS               44
> >
> >   #define TCP_ECN_OK              1
> >   #define TCP_ECN_QUEUE_CWR       2
> > diff --git a/tools/testing/selftests/bpf/progs/setget_sockopt.c b/tools=
/testing/selftests/bpf/progs/setget_sockopt.c
> > index 6dd4318debbf..106fe430f41b 100644
> > --- a/tools/testing/selftests/bpf/progs/setget_sockopt.c
> > +++ b/tools/testing/selftests/bpf/progs/setget_sockopt.c
> > @@ -61,6 +61,7 @@ static const struct sockopt_test sol_tcp_tests[] =3D =
{
> >       { .opt =3D TCP_NOTSENT_LOWAT, .new =3D 1314, .expected =3D 1314, =
},
> >       { .opt =3D TCP_BPF_SOCK_OPS_CB_FLAGS, .new =3D BPF_SOCK_OPS_ALL_C=
B_FLAGS,
> >         .expected =3D BPF_SOCK_OPS_ALL_CB_FLAGS, },
> > +     { .opt =3D TCP_RTO_MAX_MS, .new =3D 2000, .expected =3D 2000, },
> >       { .opt =3D 0, },
> >   };
> >
>


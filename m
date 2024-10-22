Return-Path: <bpf+bounces-42781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 037009AA30E
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 15:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A51EB212CD
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 13:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4156019EEC7;
	Tue, 22 Oct 2024 13:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+muq424"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5455719DF5F;
	Tue, 22 Oct 2024 13:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729603414; cv=none; b=AQncQOhZGoiQOGhFad1JAe4bGkRKStu+al+S+NZJTeJh2LvmGBp4lPqdL7nEI3fPvIxyGwKGKbG85KEc5xqexiH+AU/y4QHTnp77HCOEz+uwpLUubZrLlOxm/wly8bcf2JRe0mO4elYjEal3Dog+1sEAoQh70WE8Fdt7J1NDK20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729603414; c=relaxed/simple;
	bh=FFc4mFv1fqlfTWKLAoHgYyCwsD4zz6w4Q5RxsTKyZ7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fy+3QxRZqmiU266jLJGMIlCarMgq1BthZ6zYAvWzIzTkrbkKW6LJiWcpz8KFO1SzncWdcNuzChJj8dMC3Hq+r19dvbWQm/k4zylKEEAR7aZ+B4223HEOMRKHCDAupRFToy3lRTayr7/wlRIf0pUO14i+2v8AUl+kDayaGi0hqHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+muq424; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a3f8543f5eso10427805ab.0;
        Tue, 22 Oct 2024 06:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729603412; x=1730208212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LX5NLjhgO1IGsuIgFgvkURkum8vSAeJYDnKkIEmF8dY=;
        b=Q+muq424/apuNDEvBuv1H1B/zt5zZQYFQJCvuE9PjKqBeYMwOh3sxtMfp/a/v5X5GJ
         JFTp1nDXFdNq0mZq/xLVV5gdAgrrsbb40DkamgOXd5o4iyxMc6J9APPo7UEQ1Uv4X1Sq
         VjwsRg2564VDR+AZkDy1MApXJxJZxSe7WDUzN3vPxWQr3QhYckkWtUgFT/HuIeX7x4sv
         dqT2Y/sh/zxpXgSnkWNlC9pmeftVCg5wPug43Q3PWrVyjYpEhlbYySGKKPuXKsrXtF2S
         fF9u1b5ONByB8vLwGa/6D2fbhO7hOZZJydEB9M3xmlL48Fv5nyVCzM311U59miqUU0l0
         ilAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729603412; x=1730208212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LX5NLjhgO1IGsuIgFgvkURkum8vSAeJYDnKkIEmF8dY=;
        b=ry56bSXRib21iHxpLt1Ibo0VxoCFa+2SUxUrB425dtJjvoiNRokJMcL+ZlPUgNy0oe
         R/dGtC+VKknpqrbYsLXw7wMQ8ymMl+r4NHvHWZfb1SKdIWMk5yQb8G0oggVcnnV3cVIr
         iu6rwibWMARYkHBXiuTnIPUv4Rm0NeloL1Xete/KKOIyIAOPomGStiNBHRizTTiY+018
         2VnfhHexx7NpYg5l8R5lyUuyDJ28bfDl/RYDGpfkKQRynpNAAhHoSYR8CLtIeEP+fZ8h
         mX6pTHtYm4Sw/VUC7/1tqvdcPE4wSu1mlT0DixkSW3gC+E7RQp4kcZx8j3g5nGYPtGrF
         p/7g==
X-Forwarded-Encrypted: i=1; AJvYcCUui7WzHQs6gq/Ndoa0IX9HYxolvU4VM3MjE0HTEmGN8khTrgPZZBHc+PyOOpCHfRsLDniX2NTg@vger.kernel.org, AJvYcCWonsESDl7Tcv1n5QYNUm6QTJAd9VyfPrY1PMN+93QHWPuRoBY0+pdm+LUJVeoU49RgHLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwasbRCiI+2ST+3uZipQ2E92hhyu9rVpcw2i4djoPSLwvZMbCIO
	3FQ2MQDumrFuTzZtxqcvlgfP3vh93htnpTB3pVrsLafj3FKozNS3bUHV1TkbuFVDSPbWQwY9bJ5
	+S8sybm5u7fJ2mca6RpqAbHsp4ds=
X-Google-Smtp-Source: AGHT+IEiOLDj3dAptrZCl/wJUzbFGWsQhshhtvCO9ZjrOsCLkZ4XJFDyPXMJxsipdk+J2tpvlQ6S1jLSIZKXpgOD+bg=
X-Received: by 2002:a05:6e02:b2a:b0:39f:507a:6170 with SMTP id
 e9e14a558f8ab-3a4cc143042mr22510715ab.8.1729603412328; Tue, 22 Oct 2024
 06:23:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-3-kerneljasonxing@gmail.com> <cb96b56a-0c00-4f57-b4b5-8a7e00065cdc@linux.dev>
 <670ee4efea023_322ac329445@willemb.c.googlers.com.notmuch>
In-Reply-To: <670ee4efea023_322ac329445@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 22 Oct 2024 21:22:56 +0800
Message-ID: <CAL+tcoCBONnrP_YyE_0n_o4zQUNJfE8DY61f6XRQeeBdGNZMgQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 02/12] net-timestamp: open gate for bpf_setsockopt
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 5:56=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Martin KaFai Lau wrote:
> > On 10/11/24 9:06 PM, Jason Xing wrote:
> > >   static int sol_socket_sockopt(struct sock *sk, int optname,
> > >                           char *optval, int *optlen,
> > >                           bool getopt)
> > >   {
> > > +   struct so_timestamping ts;
> > > +   int ret =3D 0;
> > > +
> > >     switch (optname) {
> > >     case SO_REUSEADDR:
> > >     case SO_SNDBUF:
> > > @@ -5225,6 +5245,13 @@ static int sol_socket_sockopt(struct sock *sk,=
 int optname,
> > >             break;
> > >     case SO_BINDTODEVICE:
> > >             break;
> > > +   case SO_TIMESTAMPING_NEW:
> > > +   case SO_TIMESTAMPING_OLD:
> >
> > How about remove the "_OLD" support ?
>
> +1 I forgot to mention that yesterday.

Hello Willem, Martin,

I did a test on this and found that if we only use
SO_TIMESTAMPING_NEW, we will never enter the real set sk_tsflags_bpf
logic, unless there is "case SO_TIMESTAMPING_OLD".

And I checked SO_TIMESTAMPING in include/uapi/asm-generic/socket.h:
#if __BITS_PER_LONG =3D=3D 64 || (defined(__x86_64__) && defined(__ILP32__)=
)
/* on 64-bit and x32, avoid the ?: operator */
...
#define SO_TIMESTAMPING         SO_TIMESTAMPING_OLD
...
#else
...
#define SO_TIMESTAMPING (sizeof(time_t) =3D=3D sizeof(__kernel_long_t) ?
SO_TIMESTAMPING_OLD : SO_TIMESTAMPING_NEW)
...
#endif

The SO_TIMESTAMPING is defined as SO_TIMESTAMPING_OLD. I wonder if I
missed something? Thanks in advance.

Thanks,
Jason


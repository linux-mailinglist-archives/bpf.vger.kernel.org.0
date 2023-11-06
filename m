Return-Path: <bpf+bounces-14298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BB87E2A3E
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 17:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF689B20FE0
	for <lists+bpf@lfdr.de>; Mon,  6 Nov 2023 16:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B312942C;
	Mon,  6 Nov 2023 16:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fywR6Dsx"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC01729409
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 16:47:36 +0000 (UTC)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A873D51
	for <bpf@vger.kernel.org>; Mon,  6 Nov 2023 08:47:35 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7afc13d58c6so1605543241.1
        for <bpf@vger.kernel.org>; Mon, 06 Nov 2023 08:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699289254; x=1699894054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qw9LT+eDkqBWCWgoT5gi4svTWg+hExM31Ju8qjxl7aE=;
        b=fywR6DsxejjryKQmtuf8jBf3eaO3m1hy5d+NVcbtCDvVRxa7AbXma2f/1sXOBPCqIh
         kWA0LlfiaF5eYHNGtD6/oDPjQWSHn+RLQe/W3XWtqG8oywNa081l52idw8dG/IQtE8HK
         Kzmv2sfOyzxSFCkA2b8qCl89cHnKV+d4vvbJCEa/ZGqu5bm4Do1zPstXK06QOpxOP5XM
         aKWTwdKdZ38i9mCORpXVvZleLdaqMhBlc65rspdbR1/afD35JYiyEYaDDPEfNl6rfuav
         TEMJkIH8MDmP4bY5Ivtv0OR0iuCCdmtctoscvDaP9HfAk6HeAW5QUQX7ygGaZnvqixeA
         JxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699289254; x=1699894054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qw9LT+eDkqBWCWgoT5gi4svTWg+hExM31Ju8qjxl7aE=;
        b=kiXmJu/T9Uh56OH/BqCKuC/+FI2XoTIJXuHysL2SHWvFU+zaw/8IZ3QvvIR36FOcSc
         wUowRQqNd+Bd5+GDwnFFCouNr8kwLvvzr+9+TXOWpRxp2FK+m4z56vXcburGUzFPoCED
         9PjZsxcTBPKZ2NIE0koqXQy3XyxQhr0C4B+e6Aucs143WOMOCG1Mq9vKFNcnCGsaK68c
         /tYSWWTLh2MY5knm0Pfu25YQdtKhl2NY8FQH5E0Er+NIsP8H1a/kAR/07lzcHz2yyoz8
         BOcd+70Yl0X968teZpWQF1fihzBN3+b2Ajr8wWMLjgA5qDuUYGMpYpQC4wArhbIibGoQ
         45ow==
X-Gm-Message-State: AOJu0YyvpRm1nipULa2b62iThQKP0huBAPFSYrGqXlIPG4sEXZaw26Aj
	Ipny/+FV5T2bLfwhDofgnZwnnZa5bFXrsHeViE9vi5EYP/d7dp/OK1Q=
X-Google-Smtp-Source: AGHT+IEWgd0iAWCXHfwBGzTrmQrVtW+FMzo5zH4VLf6g9k7F1yhIUlz2cfDSSNKnvFKDG81xgnLwp0Rk+xxKWMedRq4=
X-Received: by 2002:a1f:1e97:0:b0:4a4:d34:421b with SMTP id
 e145-20020a1f1e97000000b004a40d34421bmr27136954vke.7.1699289254490; Mon, 06
 Nov 2023 08:47:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231102225837.1141915-1-sdf@google.com> <20231102225837.1141915-7-sdf@google.com>
 <20231105124514.GD3579@kernel.org>
In-Reply-To: <20231105124514.GD3579@kernel.org>
From: Stanislav Fomichev <sdf@google.com>
Date: Mon, 6 Nov 2023 08:47:23 -0800
Message-ID: <CAKH8qBvg7oEZ0PVrAVFS-av_9uxvS28W+kMvc00AGvbYUCQmtA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 06/13] xsk: Document tx_metadata_len layout
To: Simon Horman <horms@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org, kuba@kernel.org, toke@kernel.org, willemb@google.com, 
	dsahern@kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org, 
	maciej.fijalkowski@intel.com, hawk@kernel.org, yoong.siang.song@intel.com, 
	netdev@vger.kernel.org, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 5, 2023 at 4:45=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Thu, Nov 02, 2023 at 03:58:30PM -0700, Stanislav Fomichev wrote:
> > - how to use
> > - how to query features
> > - pointers to the examples
> >
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
>
> ...
>
> > diff --git a/Documentation/networking/xsk-tx-metadata.rst b/Documentati=
on/networking/xsk-tx-metadata.rst
> > new file mode 100644
> > index 000000000000..4f376560b23f
> > --- /dev/null
> > +++ b/Documentation/networking/xsk-tx-metadata.rst
> > @@ -0,0 +1,70 @@
>
> Hi Stan,
>
> a minor nit from my side: an SPDX licence identifier tag should probably =
go
> here.

Ugh, thanks, not sure how I missed it :-(


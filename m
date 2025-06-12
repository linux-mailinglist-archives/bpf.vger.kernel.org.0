Return-Path: <bpf+bounces-60436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6208EAD6618
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 05:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0504C3AC2D0
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 03:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4FE1D63E4;
	Thu, 12 Jun 2025 03:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCPljML8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com [209.85.219.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD2218DF89;
	Thu, 12 Jun 2025 03:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749698359; cv=none; b=eqd0De/jooNKh4Zv5K1pIPPNN5quUNce7/zoIrly1+QMFwCfBNmJb6bceJ7dBm3UZPoLB2rE56eZaI/M9csHS0nVuumoeB5toT+jWjY1mCaIyDcv24z8bkJFdaJ3nVyVQ2fffZEN7NulywKJmpWyz3CIovbhVHbLLoJMQOgHGgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749698359; c=relaxed/simple;
	bh=LqT62hpEkjDkTSssN+QxjSix+Y5eCURTaiH374a2EcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R27S8zkKuK7AgzFnKzpnKe71zZP4uyvrMeVqbRN8cMRbuggI2wO7eBcdx1kEm2cuB5MlvYglJo1iKlEGmLO/erMlTdqWtknFWInel5gqYjZGiXOp1P+jRAkpcn3TxDuF69KNeYw6PzUqW6jfNHX2fscPVi8B4OL1JO6iOonHlKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCPljML8; arc=none smtp.client-ip=209.85.219.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f196.google.com with SMTP id 3f1490d57ef6-e8175f45e18so325698276.0;
        Wed, 11 Jun 2025 20:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749698357; x=1750303157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqT62hpEkjDkTSssN+QxjSix+Y5eCURTaiH374a2EcQ=;
        b=TCPljML8oTSAZh2Swl2qF1tOMBm4QyATKalYT7OVyKrSTLvL45tJdJ4oPsjl87qp3a
         agLTWDkpSVOVuWXy0+K2m7O2PETMfXp/y9duRoSjzgMNyR49XC4NCYH1VAvr/fUnqyIG
         /EnaVUclBEroGOuCLMWwa2mg3Ye/FEqAZtgnMZDn1T1Qt/GV3SfYxMgm0BdYLKYYHt56
         CuxGrkAZdH6ZnjMBmTc9iohTngq/xk+E4uzXpmZZcCagq9NyyeCtmwioDsOVU0mpd9lf
         vTg+4ezE93CV1oiA8tKFRDVZD93IAcGWF+GaPXxQ+Z6Vh7Jm2o3F6GzNNojggbmUqSZE
         oIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749698357; x=1750303157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LqT62hpEkjDkTSssN+QxjSix+Y5eCURTaiH374a2EcQ=;
        b=vlDuHD+j3FCjclrJFyY4VAaU1X/ch0Ovzk/KmwWx0s+jdSMPybzp6AYZp/iKu1GQvA
         aUOUNATGdAvCm3jyBxeHc7QUyCEvSwPNM9Rp2RfESqptlQpwhzgt1IGF9uXKffiW0kJa
         2e9uM4esZdOC/Qx/guiMXxXrosAxgHxthSu3mD2wgdGfcdTnkN00Lvej5aXyQHStbqSD
         5uUVm3Di3Qn6NyOjdLJ0gXrS7DnoZu/L3yZ6cdcRgPfw5EbBLpBbl1hruL2fPfBu/KAb
         dxnZCMP+wo1U+0AoAVW4TVtQU4UU++Fel9JUY8gTeFYLYXukUs7OFNq4oBPrCQkHSgNp
         QPVw==
X-Forwarded-Encrypted: i=1; AJvYcCV6/DT87UvOtYwSHtpUat/MO5wxrZUmP/z34ulOHZM8uMv1sxLwdErMey70dVmZQ3d2eoHd1DdF0XVPgt5V@vger.kernel.org, AJvYcCX1YGSLlELotuRuXFoKTliuyD4gcCkFG6ib2oZSqDwi5u8E2g8mNl+tgXVpY/Qg6L/FZpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHyuNmfNbVEpR+dMdJl7a0xaD/vubcpKEcpt7pPQK5SV7AfGr2
	1nQcHoFFycQfLbbmnPEQfLurocPpMP6+GwmKHT+QPo5cBB8PkK21D8qaEf721l4y2o1PYtxj5Bk
	29vQucrUaoQPAhcz3RKeG5j4RYuN9uV+tsh15n6nm97hk
X-Gm-Gg: ASbGncsWjrte2Qs32ARBsX/Buivq9LhPCgX0Z//JpFv7KW/b9ddc/PRpfH6cjOB+XlL
	A2v4xRUmoi4XLm0EUUdME+NOEjXEFQ/sgxj8GzkAaRTLCt25i9vJXxOzHKB8mSMFAQf8/8xYV6g
	gWYngkPSemP/t8pO8JmaOf6SekUKd1lUULKOqxnXjtEagmhY35dZRd6g==
X-Google-Smtp-Source: AGHT+IFBLWQTy/TlYwLcD3IvzbAC5ijPWMnSDeFRm3MqAqqAo+J2KAB9sKFe5H1Fg4bCcRnI/Q1Voq1aUoQKKgr09pY=
X-Received: by 2002:a05:6902:1b8a:b0:e81:b2ba:cedf with SMTP id
 3f1490d57ef6-e81fda2c0c6mr8136869276.15.1749698356834; Wed, 11 Jun 2025
 20:19:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528034712.138701-1-dongml2@chinatelecom.cn>
 <CAADnVQ+G+mQPJ+O1Oc9+UW=J17CGNC5B=usCmUDxBA-ze+gZGw@mail.gmail.com>
 <CADxym3YhE23r0p31xLE=UHay7mm3DJ8+n6GcaP7Va8BaKCxRfA@mail.gmail.com>
 <CAADnVQ+Qn5H7idVv-ae84NSMpPHKyKRYbrn30bVRoq=nnPq-pw@mail.gmail.com>
 <CADxym3bK503vi+rGxHm5hj814b8aaxbQW17=vwLYszFncXMXhQ@mail.gmail.com> <CAADnVQL1KBYE3ev6b1gvve_miDhfxSV=6y5QYWEhG5ynPwti-g@mail.gmail.com>
In-Reply-To: <CAADnVQL1KBYE3ev6b1gvve_miDhfxSV=6y5QYWEhG5ynPwti-g@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Thu, 12 Jun 2025 11:18:43 +0800
X-Gm-Features: AX0GCFt99ylZT6APqPx_bCBTu3wKkzZJ8kWsqX-cIZ-CxVswHWNHd2nXkRpXrkM
Message-ID: <CADxym3bjJARRg3OQtd_e4R=UTAc+5UMyjAU8vT_frs67Em2-9A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/25] bpf: tracing multi-link support
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Menglong Dong <dongml2@chinatelecom.cn>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 8:58=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jun 11, 2025 at 5:07=E2=80=AFPM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > Hi Alexei, thank you for your explanation, and now I realize the
> > problem is my hash table :/
> >
> > My hash table made reference to ftrace and fprobe, whose
> > max budget length is 1024.
> >
> > It's interesting to make the hash table O(1) by using rhashtable
> > or sizing up the budgets, as you said. I suspect we even don't
> > need the function padding part if the hash table is random
> > enough.
>
> I suggest starting with rhashtable. It's used in many
> performance critical places, and when rhashtable_params are
> constant the compiler optimizes everything nicely.
> lookup is lockless and only needs RCU, so safe to use
> from fentry_multi.

Thanks for the advice! rhashtable is a nice choice for fentry_multi.
and I'll redesign the function metadata with it.

Thanks!
Menglong Dong


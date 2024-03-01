Return-Path: <bpf+bounces-23206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D13D086EBA8
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 23:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 599F7B22878
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 22:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7060A5A792;
	Fri,  1 Mar 2024 22:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlmgUwrY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA215A4C9
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 22:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709331464; cv=none; b=rA0jYy3VaAtcsOqk38DPCKMUVPTSyELSp0T3SJFqRhGAqD4GSRJs4pgXMWqw08iG4jiehz1udYQCotujHVH41kA+gSTiN5j6RCL9UU7ND/BqEkIB7G/x4cZk9t+vByGzxoC077bm56pF1rLXwac0510adivYXxsVW8mv2AROWqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709331464; c=relaxed/simple;
	bh=VYq1C9i0sHg2Xz/LD/1hVIAP6Npr/1i2TqqZ+xB0X+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rWoAR3u9Jok+/Xd4plTrVsCW59+uR5yojkCBtkypoPIl5euPgBuQtiq0w/lY6kxEuzIXzFwU/NUAo6mfuqOsufUZTMiUzZF+D3e7sHkTrlAPPpy+fXvsS7+JSAQuHJ0L2Xg4oP3/u7kPE3wXkXJVFsLmYdHycZz8+mtmJVRQsJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlmgUwrY; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-412d4335a84so158445e9.2
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 14:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709331461; x=1709936261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bLrX0C4NYfgMm/vzth8DcvdgDLqdSxx/Ge1/CHMNV0=;
        b=WlmgUwrYab7OKUC1jcDKykCCOkcSDpHbzamVwtpcZHwVv1I3XWc7s5o+NU8EPA55Qk
         6TbquEtNE7o6s2LdbeQOQ5rX8jlkJONCwI367G8m+RLKubj30HcYUIFJ8++Yjy/J0RwM
         yEwlveUUisN2f5ohxO45STIEhX74A17QRETVDko1ZDaN3DxSeEMQXrPZF97/HbZkBn2M
         6ekE+pbr4wkLr6r0KIZR8HHavxNRn0clhNTFkWw1QT8qarPeiVOMVldLGB58ysb5M0Km
         Uj6mOUheTYM144uImZ2Hd804t1oHar1Uk1UhqszCBJS8kRLk/S2pNCcCu/Woc5KDblRL
         Nddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709331461; x=1709936261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bLrX0C4NYfgMm/vzth8DcvdgDLqdSxx/Ge1/CHMNV0=;
        b=aRdJRXxRBcrrcpgdHh0GBt+Gl3SeOX+PbyyO4WJZ76dLwoXVAlz2MZeNZ1rGMOw+lw
         PPygYLz2DLoR7a7h3MqQ7ILHkaiDyrVoXjNbFoT2LqZFhtZlgF4VwEJj7UWj/PYbQc/p
         ufPCjt6NCWpCtT5s88FAhbVK0Jf8PItGF2pAVtys4Se5LCawODmymV7HXgyAucKysWSc
         NQ/ookk/IGG+O+OoJAKtjyH2BGLhhONOdp5QuKFgIfIhSkwpGzZJwzA445uj6EpAmEH0
         dc0ozD0mhjcaUnHrcrgoMlAAQLcPLKy0UT5Slx/ZfpWEhmZcn+jf6uf8z+pQr0C5ggjZ
         VfgQ==
X-Forwarded-Encrypted: i=1; AJvYcCURng1H6TG8Q0AYPTEzZqmerQR4IEuSjU/N1A53HijikuvHj33OlUOXxVrwsxgbvegkL62IMETRbTycXLVuAzzSE5rG
X-Gm-Message-State: AOJu0YyzHCR4H4pZ0eeNabR9O49tkxWgxeKppHXwc08bIEVeaIBNfjlo
	hjSEA6iC/7E9JVH/oFYuUX0KdHukAbtmIsCJ5j3MY5+K4V+rHXTLhnAa2GDxPVB/xaPD1R7wH+t
	sU++ivTbcb410L7AD+LOItBrvXME=
X-Google-Smtp-Source: AGHT+IEBCF7Kwe00w+SLlTyahlNDeJXlD1fiMJiDB6HuE/JYPJXkK7JgqdRXGfnEafHMS0E+mGddsbvV7yY8x6/zLFA=
X-Received: by 2002:adf:ffd2:0:b0:33e:dd4:ca5c with SMTP id
 x18-20020adfffd2000000b0033e0dd4ca5cmr2310033wrs.45.1709331460534; Fri, 01
 Mar 2024 14:17:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301192020.15644-1-dthaler1968@gmail.com> <20240301214929.GB192865@maniforge>
 <236501da6c23$30b03380$92109a80$@gmail.com> <20240301220458.GC192865@maniforge>
In-Reply-To: <20240301220458.GC192865@maniforge>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 1 Mar 2024 14:17:29 -0800
Message-ID: <CAADnVQK0PFbLXujQzO3HJRPa2NAP8U82LjtqA6PjsPYdnWXHaA@mail.gmail.com>
Subject: Re: [Bpf] [PATCH bpf-next] bpf, docs: Use IETF format for field
 definitions in instruction-set.rst
To: David Vernet <void@manifault.com>
Cc: Dave Thaler <dthaler1968@googlemail.com>, bpf <bpf@vger.kernel.org>, bpf@ietf.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 2:05=E2=80=AFPM David Vernet <void@manifault.com> wr=
ote:
>
> On Fri, Mar 01, 2024 at 01:55:34PM -0800, dthaler1968@googlemail.com wrot=
e:
> > David Vernet <void@manifault.com> wrote:
> > [...]
> > > Very glad that we were able to do this before sending to WG last call=
.
> > Thank
> > > you, Dave. I left a couple of comments below but here's my AB:
> > >
> > > Acked-by: David Vernet <void@manifault.com>
> > [...]
> > > > -``BPF_ADD | BPF_X | BPF_ALU`` means::
> > > > +``{ADD, X, ALU}``, where 'code'=3D``ADD``, 'source'=3D``X``, and
> > 'class'=3D``ALU``,
> > > means::
> > >
> > > For some reason ``ADD``, ``X`` and ``ALU`` aren't rendering correctly=
 when
> > > built with sphinx. It looks like we need to do this:
> > [...]
> > > -``{ADD, X, ALU}``, where 'code'=3D``ADD``, 'source'=3D``X``, and
> > 'class'=3D``ALU``,
> > > means::
> > > +``{ADD, X, ALU}``, where 'code' =3D ``ADD``, 'source' =3D ``X``, and=
 'class'
> > =3D
> > > ``ALU``, means::
> >
> > Ack.  Do you want me to submit a v2 now with that change or hold off fo=
r a
> > bit?  Keep in mind the deadline for submitting a draft before the meeti=
ng is
> > end-of-day Monday.
>
> I think we can hold off until other people review.

Probably better to respin now fixing sphinx issues.

The diff lgtm.


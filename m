Return-Path: <bpf+bounces-78093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE6FCFE18F
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 14:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 542A1307EA17
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 13:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8AE32A3C3;
	Wed,  7 Jan 2026 13:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ExWGNxVA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kev63+mu"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5234A328631
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767793644; cv=none; b=qH+S0UVIj2g2oUBDvhkPab/5As9/uv1lybsP6DAmnxWwSP+JalfDRbPa2h8JfywyBuF3MYjQTtluquKHHlsJZIx4vRqsgJneGZbwBuP3uKccEMB3iI1q9iiz4NEEaJBMX7Oedk/0csU9VXfMAaCDN8p/JPgqC06ecRfawYEWoqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767793644; c=relaxed/simple;
	bh=5UeIv+085j7X+A2KkpBcuIkf8eSlo8D6e6Ms8n27crs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hRiHUJNJ/G0IwtMOtMwq5Dmwt4fiTP/uUpCAOXVsFQs+0Iv6le91W2KP54M+8L+mSgTbQm+GzgCvAZcM+eJPbjWvCG/1GB4pl4iyWZiieC0kQo/eZZYeXk1Vax9jixVSm9jwQh6nM1bbHTvTDygCu66XtVwHUmMAFq2NweTVHR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ExWGNxVA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kev63+mu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767793641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLoPxkvg9MQAFGxKvostktDgMdVNq96nmc+PVOzg14c=;
	b=ExWGNxVADYrF9YeNp3DNJFvJRwzb00SkBox1AO4eq7w7PywNsZwupstpT8cXrhGXNGzWC6
	pZeDlyxAxb9J99n8Exh9iA0Wo0C68KdpNadT3Tzjm9kAcJ+NgJ6DhDi/jwlMyt7nP4mbJw
	3srhQRDR+yzCOTsgpaWMmDnrVCghP3c=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-EfgHcAyKMBeqWv-uhFDzsg-1; Wed, 07 Jan 2026 08:47:20 -0500
X-MC-Unique: EfgHcAyKMBeqWv-uhFDzsg-1
X-Mimecast-MFC-AGG-ID: EfgHcAyKMBeqWv-uhFDzsg_1767793639
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b72de28c849so203478966b.1
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 05:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767793639; x=1768398439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLoPxkvg9MQAFGxKvostktDgMdVNq96nmc+PVOzg14c=;
        b=Kev63+mucYk6GyIEX1JXZF+eFeZL8Lih2J6iUYEBlTZn0OD967Ywm00PlLzWlX+ib4
         RlptKoNU2N4FknKpTblrEo/SWWdDNKQSKUVgaR7hljxC2WRTd+WDQN0IpVw7WFe/GZBx
         ADSXaoXvoFkiAJyKbitlQgeDKY5ubpcjaB/we0GuX+s1iicORCqWxKksG+L3FH8DzfLC
         relwiwNsvh6rdSlbHqwt+yCnQP+elmwL6tiYsAUC/em4L/xxh7pZxWjAxW29md4o6n9j
         pjgh8DzErNjbebAGRIJS9m/nEXj3GpPytfn3fmna8paQh9Wo4Xnup/VpBWCDRR2fRFwH
         LnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767793639; x=1768398439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZLoPxkvg9MQAFGxKvostktDgMdVNq96nmc+PVOzg14c=;
        b=eP+VgzKq8jYLDijaw3e4+Dhs3kPzvi+ey7zqeZmUx2pxXRB1gokd78m+Evc5G91aq5
         5T1q2IpeKaM98FKxFcVC6RDB9czUyvz4ZtL3NToYpGDpLmA+/xakt143YsnrREzco2Qo
         N5c2bFcJgflt8g+AA5CqaPaazfV08BjlTbCgZgRnhe/zugOJbVb5F8DvD9zJXLrdm8Er
         oVtpP94T7j6d3rw1DTmNaKONzWJhP0x8k9zQKV07ZOfK/MenpzgYvU8SEKrMC8ZhWPl/
         xkQFiNMtj4retl2sEQlpEWmKqTwu+9R3yUj/0RsNri06XxWF7QV9+j9WIS6FaFgUHkcY
         8wVg==
X-Forwarded-Encrypted: i=1; AJvYcCVemMsRsWIbzpHi0PdiDV5ZEa/scX2lulqdXkvK/CjgSTsaKQRK2TGATGCX2Z+7aS+QGZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxYU7blRWTQh5/JoXDm9FEMxhe93h0sRiY5uJcCIIzrpSHt0m+
	8u6ES5CeS3DiwO58Z9BQGUcCkXbZaH4ijM2r0MaaslzU4c5HSlcpTTB/UIHyegWUQTF68HnzpAp
	cG4RlILIiQjVqeCs8SoOBsNf7ZZJu8OFU/afH8LgRpeO78pgIqRMx/IwATVmuhrMcTQSUZR+Cdy
	quNEgfn1d2gcqGa4MhReR7lW6tgWuI
X-Gm-Gg: AY/fxX6OdqPRi56ihmkIkWw4m33ypquFbVPW6AThhgjZfOxHF6shzWhVJKyrS7xkDY0
	nB+0xwrrj5iE1QQ7wwpKytNKnyanmabRQuQJD6/xc10+dLUVPGDrct6139K/0gFlMStLRvU4VPU
	1RoXHF3pyEUuvFTgsufCMvYAn068bR808b3572jOxOo5WTDIAQxnFmhdib2kyhLUxiFPmKzQMuG
	JcfQl7MIjVInuuGNaJMMLsx
X-Received: by 2002:a17:907:97d3:b0:b76:4c16:6afa with SMTP id a640c23a62f3a-b844520d854mr274385566b.28.1767793638878;
        Wed, 07 Jan 2026 05:47:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1i2QRzGxxzUUyfW72AkZX83kM1+QBJ7NrayLZXt+2mPD0j700Gvi3U/l9XmWKJUNVUbEXTKZjcZRfR/KKLT4=
X-Received: by 2002:a17:907:97d3:b0:b76:4c16:6afa with SMTP id
 a640c23a62f3a-b844520d854mr274382666b.28.1767793638425; Wed, 07 Jan 2026
 05:47:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106133655.249887-1-wander@redhat.com> <20260106133655.249887-8-wander@redhat.com>
 <CAP4=nvT2oPtM73nfPkSJZ4612mcAPw1LWbHNrszFBVAmSJOVbw@mail.gmail.com> <CAAq0SUmrRecimVNCa=zv-h3uPm-GpQo3g+ZTV4zLNVA4ZVo-EQ@mail.gmail.com>
In-Reply-To: <CAAq0SUmrRecimVNCa=zv-h3uPm-GpQo3g+ZTV4zLNVA4ZVo-EQ@mail.gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 7 Jan 2026 14:47:07 +0100
X-Gm-Features: AQt7F2ph3Al6PnRm9hkpWdRKwER31ZBY_y1Igwr58DOaNMEWshQZaPUQl5IDXow
Message-ID: <CAP4=nvTeFtHF+K0h0FkWMh6uLb5Qwy6LnYPcrbrbNOM6M6kFNA@mail.gmail.com>
Subject: Re: [PATCH v2 07/18] rtla: Introduce common_restart() helper
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

st 7. 1. 2026 v 13:43 odes=C3=ADlatel Wander Lairson Costa
<wander@redhat.com> napsal:
> >
> > The deduplication idea is good, but I find the name of the helper
> > quite confusing. The main function of the helper is not to restart
> > tracing, it is to handle a latency threshold overflow - restarting
> > tracing is only one of possible effects, and one that is only applied
> > when using --on-threshold continue which is not the most common use
> > case. Could something like common_handle_stop_tracing() perhaps be
> > better?
> >
>
> Sure, I will change the name in v3.
>

Thanks.

> > > +enum restart_result {
> > > +       RESTART_OK,
> > > +       RESTART_STOP,
> > > +       RESTART_ERROR =3D -1,
> > > +};
> >
> > Do we really need a separate return value enum just for this one helper=
?
> >
>
> If it was success/failure type of return value, we wouldn't need.
> However, a three state code, I think it is worth for code readiness.
> Do you have something else in mind?
>

The main loop can simply use the continue flag, just like in the old
version, no need to duplicate that information into the return value
of common_restart().

Tomas



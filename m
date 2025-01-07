Return-Path: <bpf+bounces-48064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFA3A03B1B
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 10:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E01ED7A2324
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 09:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC39D1E2619;
	Tue,  7 Jan 2025 09:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTzGKFkm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2319C1DE8AF;
	Tue,  7 Jan 2025 09:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736242224; cv=none; b=nIU2FtjnFlnOBYv6VJcwQkAifddSRg2tHu4ABYpo8F1Sp41H5RYKp1HTwrQAVj86L5j2aRAVuo13vXQE/KKwbbVqQwE+7GuhWqLGyhhJRMj9QhtvpnMBm33ZFkF7q1VffTCmbcfvhMNJJiwiDbOWERukC4kG9JdzBN/3sFhT5oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736242224; c=relaxed/simple;
	bh=EaIGrVKZALl19A983m5NREM9zA6bQIo7XwE5Ta6ybUk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=PXF2S5KbFk5swmbRmI2wV7ojxDAvnAB/p4CIRrlzIz3Nh+waaMJCU4+/TiLVX/5Jkvsi4LPhNAncS6HEOAxHvbh0lT7VPFNTDFiVU6CXJTQlcjKxl6wAFdkqRpSYvhJSMTFaMUUvmSSFQzxK7/MRTYFpnLjTCq4LIa5XLobY15k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTzGKFkm; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6dd16e1cfa1so132094236d6.1;
        Tue, 07 Jan 2025 01:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736242221; x=1736847021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaIGrVKZALl19A983m5NREM9zA6bQIo7XwE5Ta6ybUk=;
        b=VTzGKFkmdZDhGYLzN44aLDcAOTje6Y4UCfpSrWZNXY4We21dxDKjyrn7QEaCEdZIbu
         EjDLZt8pCBo+909pKgZTWyZoK0+8stmkhIoR6vB5k3WhC2J9R/k5sUTinuxNOeWo4wuE
         NNSBi6O7p3RAvak4oV11F+TT0j91yoQZCZFO1OaodW/gDmaqDQGUx9cUzE4kXIdkTIak
         sOoD8V6P3ZmlhhhebZM4Vg/MfZlwmTzAvciJ+kQzChcc0dCeBKSX265q4SsgjDodUtwy
         NJrmgHlt5Z0BNngIPiH/fyv5ncSN+GIpfyP9j3PFCvUbhIfDgrBqz8D1BXpZtSk6Zbun
         /bAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736242221; x=1736847021;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EaIGrVKZALl19A983m5NREM9zA6bQIo7XwE5Ta6ybUk=;
        b=T+U4mrtg22Jo+73qOj9Wf/5XxJnKgzvjr9otD2bF1TL5WQpuM1VSQ/QGfhSAbk9FYC
         02Zvn7rTLA+LxGZUv1dBODzaKHI9MgAAXjnA2g6Zepy1FPARSI0IABhfB++muIH/oAds
         Lm/f9SWEC6UW7VdQvRrjx4ujJ5yOi9qoBOdvF9w9Ije00Yam2Xe27K5VOhFCRhxvJXPz
         SnK8tDJCBsrt7B3ufIJOZD2PfTp3XnChddpy7Yd4SGysgQDm3SY8EDCDAVSZu+2rXUmK
         +dk30OLFlsdU/V6I6boaKRQcVlbojuvfLL/oxEpTTjHXHLcPLkT4JRmxv4UEYJgzJpJM
         7L1g==
X-Forwarded-Encrypted: i=1; AJvYcCU+eK8tXrlgB0CmsTludSOx31x7nQ/axQo/rm3ERC/KePZdk32v9Ec72VbNRib4ERVXFlU=@vger.kernel.org, AJvYcCViVmr6Wu6d5uMvF5IRONqmUCOBx8gxfi452FDZZ/YbBVVqDD/eiqs69887F5QpgJoePJHm6s09@vger.kernel.org
X-Gm-Message-State: AOJu0YwLelEBoIpU5uZ4yavSYWg+wHraPTN307C82A0vgbG90ACGWrjC
	A5HzAnuzruqkBxzK9j84hfh+Yj0WlcoxoDmXU6clJjFEoHClmVvC
X-Gm-Gg: ASbGncvIZVzYd7d4Jp3E/XKIl7H9DCoU6IfWMq5o0R6wRP0qG23rr7eXXmEPmbtLA4H
	RGfBhKhFSfpzsbyOQP8tCxjAx2Lf3gZxy7XoLMljJp4F09SAa3flWeyAgYA4eUHbmhjK0eDSiA4
	9E+Zmbl4QU5Ef5nsP58O0eHJ72CJr4F6ROk/LRQl6FwpUf0yQyASYCWw2uHe7wXteiSSO1RJ3BE
	PQwE6ztKZWHD1szd8O4OwaCJVduAEfy6RJ9RwpoqUsqb3E9JvUAfVaU29nspyPE06UbmGZ4bS8x
	GY1pib2ieaiXFTYWeoMUi2FQyf2f
X-Google-Smtp-Source: AGHT+IH65RVCYOmwWkyJFt9/Dyk6oF16mArfs/qGwCMPRCGLM2XVw1yYxFmmBhPHbAL9mWEfSlZu9g==
X-Received: by 2002:a05:6214:810d:b0:6dd:5f90:5167 with SMTP id 6a1803df08f44-6dd5f905bb3mr429579296d6.48.1736242220821;
        Tue, 07 Jan 2025 01:30:20 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181d432asm179043556d6.110.2025.01.07.01.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 01:30:20 -0800 (PST)
Date: Tue, 07 Jan 2025 04:30:19 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jeroen de Borst <jeroendb@google.com>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 pkaligineedi@google.com, 
 shailend@google.com, 
 hawk@kernel.org, 
 john.fastabend@gmail.com, 
 willemb@google.com, 
 bpf@vger.kernel.org
Message-ID: <677cf42b9e361_23f4742946a@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAErkTsR0Av6sFnabSSJ7TNtix8Y_QLX+xb6vShvx3P0GyV3w9A@mail.gmail.com>
References: <20250106180210.1861784-1-kuba@kernel.org>
 <CAErkTsR0Av6sFnabSSJ7TNtix8Y_QLX+xb6vShvx3P0GyV3w9A@mail.gmail.com>
Subject: Re: [PATCH net] eth: gve: use appropriate helper to set xdp_features
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jeroen de Borst wrote:
> Reviewed-By: Jeroen de Borst <jeroendb@google.com>
> =

> =

> =

> On Mon, Jan 6, 2025 at 10:02=E2=80=AFAM Jakub Kicinski <kuba@kernel.org=
> wrote:
> >
> > Commit f85949f98206 ("xdp: add xdp_set_features_flag utility routine"=
)
> > added routines to inform the core about XDP flag changes.
> > GVE support was added around the same time and missed using them.
> >
> > GVE only changes the flags on error recover or resume.
> > Presumably the flags may change during resume if VM migrated.
> > User would not get the notification and upper devices would
> > not get a chance to recalculate their flags.
> >
> > Fixes: 75eaae158b1b ("gve: Add XDP DROP and TX support for GQI-QPL fo=
rmat")
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Thanks!

> > ---
> > CC: jeroendb@google.com

Reminder: please don't top post=


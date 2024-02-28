Return-Path: <bpf+bounces-22950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAB386BC05
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 00:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2FEEB214DC
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 23:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE50413D309;
	Wed, 28 Feb 2024 23:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJIb+q5x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB02B72903;
	Wed, 28 Feb 2024 23:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709162071; cv=none; b=uhhmqHD44RhFwAmk1swwntA8NAClgFtTLBySTgYwNR6HBVKZsORmQBjcZeUUWLK89OoyyXc63Kw3iGNy6rvBtDrKaLbKsLNhGcLvaTKFYxtu20egS17JDD/cKEDYCKDPuBdjgahPVbG3hjvFYLQksBVoAUwr8LlY4HYKNoTygBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709162071; c=relaxed/simple;
	bh=8fdh3uYGMPOXqvAOHOoKQAaXXudO0fmxMPdCZHjqsRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lEQzWeurHXBMvV0P9vt/z3Kk/96B/u5JpxLhH6Z8hn6iOVr9+EWpia3ZGoZUxh0Utu5lFzQT2adg0TcJp5Oog7nnngZk0e1yZ5sn/3v28HDqls3e4ft5z7hqVk6IQ0J1ERMS9RGVajDosxZ8JF75Q+o02h4fDCe6qHjsTVJ8NS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJIb+q5x; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dbd81000b6so162415ad.0;
        Wed, 28 Feb 2024 15:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709162069; x=1709766869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ot4CmQ/hhG4zUoY7ofq6ZiMV1G5BUrp00rn44kQoMs0=;
        b=NJIb+q5xoF2uxAjdOR6wY23tcLSWhDLzroxqtpNts/LgfeSirmGu6lVov+gZvDz20X
         SfPy6xiNRCU5MolZ39zsMR7KGlsZyKYaO3dOiixpNrm0VYaMIcW+qnJvzETU63cgzGx0
         /AYLrpQVpo0vo0eELGTD422Apkv97Tbyr58zAEy7ikQy5cwJA66QbHNQEteUnuMGZZY4
         iHaB9s7PybVCs/GszZaAq97DG2E0qHeXDBGEyXihXrrHJ0p41LSfDlxSut4au56yp9NE
         ERfXTGBGRHUTTvRZXNh9gYgV7Hoy5HS+T3iOLkqyVm33YE8mlg62PEsPIoLsdu913G+p
         4sGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709162069; x=1709766869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ot4CmQ/hhG4zUoY7ofq6ZiMV1G5BUrp00rn44kQoMs0=;
        b=KeNoHQ4oFwUEgdtx2sM8uYFaVI1lSEryXHFKhM7m3gSLSkpOkt4VByCaTJN7hlMST/
         IhWvUT6GfM9tk0rwVIEDaE7qlEI8vb9VvX5M5jiOT2U2As1XiOn/AJIooQj4XTzkPTDv
         Ku9yEWVbGsHoGLYTMgLonTY39HOR59xBpXf3npD3ZefijRqS3T72uU1JvpP9NQnXBJ3L
         F0hyPCSeLWjB+De/dlVJ7PbfvII3HbkGtG4WVtPPSeP4Fmo8q//SpxDi4ZSk5ZVVKrxe
         Ge62/3esdG9zADV5mxHmq77FAwHV/dm92CWD4JZ4lznJn65RthBDLJValQ3VI/QYhPgu
         pIJA==
X-Forwarded-Encrypted: i=1; AJvYcCUkl1o5cn5HtoauDwjyUpcjdm+IsVShd2gBIGNQIZSHxQcRv7In4Bbt/ABe7rvp+YbJYvj190H7WHoTNmBHZTmLv5iKIdd05P+NN7C39tRw/mi/gPnADJbyE+2mbgSmIJ4a83dtVpKGmvMlYhz/r9ZhFSoJ5NZskfofaoAS
X-Gm-Message-State: AOJu0Ywa2DhgO411xyaYf2T73o56/MNPHVrSlGQS4n66TSpQgEz0GpbX
	iYznWb1WhFbfPK3zEUsLdiORMnRvxmP4qoteBiUEGRVtqxOtMsK9ccPHPhMY+um/AIQ+rU4lm7q
	f8Wq93nhxGFarE9KjcwJXtAy8HZs=
X-Google-Smtp-Source: AGHT+IGdgZmlOD3uGWnVHJMjyJeA37xtSoParRksvcba8xX7FIeNpPx7PfxE6W9DLFTPkUvcu1cBQtxqPixljO3Quq4=
X-Received: by 2002:a17:90a:3d45:b0:298:b736:ecf7 with SMTP id
 o5-20020a17090a3d4500b00298b736ecf7mr667831pjf.0.1709162069188; Wed, 28 Feb
 2024 15:14:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227-pci2_upstream-v1-0-b952f8333606@nxp.com> <20240227-pci2_upstream-v1-1-b952f8333606@nxp.com>
In-Reply-To: <20240227-pci2_upstream-v1-1-b952f8333606@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 28 Feb 2024 20:14:16 -0300
Message-ID: <CAOMZO5C-01=jYbJTgQucfD8+pT-chy4xvQMckUee1O+gtE-0pQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] PCI: imx6: Rename imx6_* with imx_*
To: Frank Li <Frank.Li@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	NXP Linux Team <linux-imx@nxp.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-pci@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 6:47=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:
>
> imx6_* actually mean for all imx chips (imx6x, imx7x, imx8x and imx9x).

That's OK. In the kernel, we have lots of examples where the names of
files and functions follow the first chip model.

If this same IP gets used by another SoC in the future that is not
named i.MX, will this driver get renamed again?

> Rename imx6_* with imx_* to avoid confuse.

I don't find it confusing.

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 754 +++++++++++++++++-----------=
------
>  1 file changed, 377 insertions(+), 377 deletions(-)

I think this pure churn and we should not do the rename as it brings
no benefits.


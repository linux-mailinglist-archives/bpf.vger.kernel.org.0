Return-Path: <bpf+bounces-33458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4480691D4D1
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 02:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 771F31C2087B
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 00:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF5B10F1;
	Mon,  1 Jul 2024 00:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hm95ZJmG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A71633;
	Mon,  1 Jul 2024 00:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719792622; cv=none; b=g2JkZrbroiRvAXI6mDWPmUKWX4BJ2ic4OEg8Mx6NXxfES+jh6NEeEhNpdCgHdoafcSCHWbVkRvGC8Qme94TDFSho7zwndkCtZ2R9r3crTcNo8YOinD4aBsXBsqKZpHRtzyvpT6+bnJZMeliGlF9KKuRf1O92hTdEax5bl5Ilozc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719792622; c=relaxed/simple;
	bh=nnClZwL7a9Lo3WGW0DdfJENLXrqDwfN4i6NjSsXCfhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YN8YqVShrnVpJyp2VUC91y8c+cMvRhS166E2LtJROGtv4UbHdMMqfpGOGxZisp88YHE22GYwIR0F1pM2G4giUF+qvh43hLywxlpgL4RN2eypAnvua9u96gy4g58yp79/coyP6qVR7iXDCz7VuQR4MBy4KPpJ+vhCI0tMVr+BBtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hm95ZJmG; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52ce17f6835so269109e87.1;
        Sun, 30 Jun 2024 17:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719792619; x=1720397419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2zppEwdRUP4lBbNN9dpO2QH9XHyegI1cIfNKuSEDlk=;
        b=Hm95ZJmGBprIo/iuNj8yCSAvpCL2Vq4mds/bkLy8N7blLgdk7oiwErgl3xnw0ak/vB
         +sjZW2xcxTxdkuA9mGBVAXu0jqWpdPh+dDepcdccHantP9W84qshm6K3xLe83mKRNdtj
         1eXBSg+l/RPoc5/jPFFP7X3fBSOnbG0f5/SgD5VhYPL87W3TJOjnDphB62YwtMVKep80
         7+YlHob9yrFvFQWCNGQiFg/neT563A69IMAYRWaEz0uKtq85la9VL+OQGPgAXtK4PkSm
         KzmzotvPPUE8urw+MruKXMtsyaQXjHw/BOAnJThuVLzVJma1tNjo+pxLFKMTLxfnZfyb
         /YFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719792619; x=1720397419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2zppEwdRUP4lBbNN9dpO2QH9XHyegI1cIfNKuSEDlk=;
        b=JFEIMIadpeOBjXdwFRnHkuRdUEKj9bejYLMuPqfCPncI6b2ijuTYcvnISdMa84weoJ
         wmqiWgwNzhJZnkIlt26KBW91szCHlMU50aOEDhf7Dzbl+iQRZiGFiRKOfwivEZPzGC6y
         P+Z4mnGv7ZTCm/nbCOC9dT2lZYB63fQ3FnOiCsV1XcisOShGLVDt8tsb6nVFy6VFPcRN
         vfeqK/CsKRByK5Oy+OrZ7NyplpCz2ge1lElWVHIkO/BibaV+pIvadlpv9bWJi56UdeB+
         SfsnyLkISXP2P/sRjShgd3V7T7NQsGT9xlrJNUxl03+cSVVSU7Y3YNe24rvkGrVdLo+4
         8MsA==
X-Forwarded-Encrypted: i=1; AJvYcCUTLSS8457WNaiwyqHHnKJpW/VS8DJTOFsgDWCWIGS89gxwWZnP/dtljaY7kwjhFJz62ANr6AFlaHFXrXt11KSeW5g+opG3KCqPUz0vc3RVJmy/viy+tVy5IpxTppcbdHuqZcQ1oE8pNOoUTEtiPmeCWYZvY4wRvKdl3m0FsMttWCYggjCzeJlA68KTStSkNRyDecuPD7BkzQ==
X-Gm-Message-State: AOJu0YwiUBNc3hLsYTgN2vvsZYZ06SarAvOp7FHLl7Ft0CLHMkxRVxR1
	3/2B/5xBlOTM6OXQwiC9RpldUg+X8ItyyMGH6p9bU/S5EvQjGGo+F9wTPaa5ikdZFZWJLyA1y9/
	0xs8YYwASGqcWOi/k7seZtgJPiWY=
X-Google-Smtp-Source: AGHT+IGfcLlbEM4SexKB3qvZxwtdSASEeJ4vyW8XH9MyjF6BNz8i77fKusEhzt5Z8hmMXUodZLIPP4wsLqpBG8aZWlQ=
X-Received: by 2002:a2e:a7d5:0:b0:2ec:ca8:4897 with SMTP id
 38308e7fff4ca-2ee5e6ca046mr27574861fa.4.1719792618943; Sun, 30 Jun 2024
 17:10:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-pci2_upstream-v6-0-e0821238f997@nxp.com> <20240617-pci2_upstream-v6-6-e0821238f997@nxp.com>
In-Reply-To: <20240617-pci2_upstream-v6-6-e0821238f997@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 30 Jun 2024 21:10:07 -0300
Message-ID: <CAOMZO5CpFB4yuZty6zkX0KyGfYvXyuSnmeJyH=pn7DiRPmGxJQ@mail.gmail.com>
Subject: Re: [PATCH v6 06/10] PCI: imx6: Improve comment for workaround ERR010728
To: Frank Li <Frank.Li@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	NXP Linux Team <linux-imx@nxp.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-pci@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 5:17=E2=80=AFPM Frank Li <Frank.Li@nxp.com> wrote:
>
> Improve comment about workaround ERR010727 by using official errata

This should be  ERR010728, not  ERR010727.


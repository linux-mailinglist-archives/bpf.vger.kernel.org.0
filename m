Return-Path: <bpf+bounces-38092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1C595F81F
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 19:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79D44B20C7E
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 17:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5E3198E69;
	Mon, 26 Aug 2024 17:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="e+pjeuj4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF067D417
	for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 17:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724693463; cv=none; b=jLrCRynDV9fJPMpCSqajxlJzpsd3JE8xfJC7HBbxTEHuVetGnEftObPmFKxCmdKpSzhr3I6H67y6nEF8+m3+lGpLFI7z/vRMm8f2g07czGEQ6wNTCoBzTyRTSNFsFxHZ4MDL9doQpaNLEZSRRez/lr3L6z0kdbSTlaXvR9j3otQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724693463; c=relaxed/simple;
	bh=ai93OtOQrbR4S3AT314DLeiH8KJPW3YI556gX8jIasE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6xhC8dRYnlv/TRGEA/cfeNsczo7f86bovYx4zVGGLw7+SlSoY3BXEoRFRzxq1NsvhytkHkZrOmJJ3iopr5ZiawljEYf5hhb/EpUiNxQjSJI9e4hqJawUBf9fhYbJGYHDUFHlKe6c15i4S6iD6/SZFqYCXLzBVhmZZU5mRmqnRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=e+pjeuj4; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d3b5f2f621so3258569a91.1
        for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 10:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724693461; x=1725298261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iClgDrknyT0dEay6TLsYqV+rELzO0m3jwG6/VjVsKOY=;
        b=e+pjeuj4mPrtiacsgQal52McaGxDOWl6JKcDmgYDtfpRpu5x5rZ94dZ9bQmeQS6INY
         md7PNXfBKZ55/+GpJo+gI0ARPrS134axbAVbJGBGTYZph5L9E14QYmD4/Ov/S+MjtVaw
         Swy5SiFwqLgFpqTAwpaAEwue4ZdbRAg7kKbjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724693461; x=1725298261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iClgDrknyT0dEay6TLsYqV+rELzO0m3jwG6/VjVsKOY=;
        b=wSBDizToqX1dWX1IMHjYfaSkeuQJDtG8NYy8CFY29j4Yml2E4BDWR6w8aytAht1viJ
         2bLczvudfGERTXMhaMAkOy4oVUdEa7jas1NTstRF3qM/dz5WDSXr79bOD2aVgUqKUxDu
         am9OaCPymj4EnNzyTCCT4eFmMFrUqeK6IMkHwUapXf5aQLhmfbbZnqn6TA6ozbhq/wTZ
         TC4jq2x8ZmbENljEcr/5t3+6buxTFmBoRkSUx51fuWIo8HJ95r/XI6WVsijzFsqAwfY3
         7II4KRKJnsWL1LgIS4CP0vu+CM09sGG2+xK1Ty9UbYTWl7EpZHoAT6KIfGWpfJlcx3CH
         mKpg==
X-Forwarded-Encrypted: i=1; AJvYcCXcz9NUJiUGNsY7d3sg3uFfQHALr4xelt0MBUiyfbsrt9QMxC8pVVTC0PByFf6N+YurnDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlvtiyi6B/gNqLGZLl/7ah6INcKynBWpcdvM55zUwmTticJFNM
	4X8Umu//8fFcqb1YFiFE5JPoDQeV5iIaMO351GaIp1uDXCAML/8Je5Hmx8jyBm7W5Bl1LInma60
	bg+pLb+4k+0Gb+V+XVbFbyIevvjw6crK4pAND
X-Google-Smtp-Source: AGHT+IGOiC9l+tylzHyvTlxh5R323gDD1FRUx3Z+bfPXVWn9FyrfJSQssxkfETmOUkVELarY+SrTHbJFJ2oK/08oDGc=
X-Received: by 2002:a17:90b:4a43:b0:2d4:924:8891 with SMTP id
 98e67ed59e1d1-2d8259f79a4mr319895a91.38.1724693460840; Mon, 26 Aug 2024
 10:31:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814221818.2612484-1-jitendra.vegiraju@broadcom.com>
 <20240814221818.2612484-5-jitendra.vegiraju@broadcom.com> <5f7a617e-a8a2-40ca-a54a-19e58d69ab33@marvell.com>
In-Reply-To: <5f7a617e-a8a2-40ca-a54a-19e58d69ab33@marvell.com>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Mon, 26 Aug 2024 10:30:49 -0700
Message-ID: <CAMdnO-+ZKyoPY=ZDO8cir5T8hcF-nLRhkasfykF8EFbbedqXFg@mail.gmail.com>
Subject: Re: [net-next v4 4/5] net: stmmac: Add PCI driver support for BCM8958x
To: Amit Singh Tomar <amitsinght@marvell.com>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, fancer.lancer@gmail.com, 
	rmk+kernel@armlinux.org.uk, ahalaney@redhat.com, xiaolei.wang@windriver.com, 
	rohan.g.thomas@intel.com, Jianheng.Zhang@synopsys.com, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, andrew@lunn.ch, 
	linux@armlinux.org.uk, horms@kernel.org, florian.fainelli@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Amit,
Thanks for the review comments.

On Thu, Aug 22, 2024 at 9:35=E2=80=AFAM Amit Singh Tomar <amitsinght@marvel=
l.com> wrote:
>
> Hi,
>
>
> > +{
> > +     int ret;
> > +     int i;
> nit: This can be merged into single line.

Thanks, I will fix it.

> > +err_disable_msi:
> > +     pci_free_irq_vectors(pdev);
> > +err_disable_device:
> > +     pci_disable_device(pdev);
> Shouldn't pcim_iounmap_region be called here to unmap and release PCI BAR=
s?

My understanding is that for managed API calls pcim_iomap_regions(),
we don't need to do explicit clean up.
Please let me know if that's not the case.
Just realized that pci_disable_device() in cleanup is not required
since the driver is using pcim_enable_device().


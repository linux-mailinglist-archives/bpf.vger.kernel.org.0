Return-Path: <bpf+bounces-38093-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAAB95F853
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 19:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 378151F21C0E
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 17:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1814F198E96;
	Mon, 26 Aug 2024 17:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RyY4xkTi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440E6198830
	for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 17:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724694093; cv=none; b=eONC09kRzx3oD3IsfPjXe/q6klSoceoOMo7xS8n0VjObdKjAE37WbxUA6eMf17P5ZH0gQ/X00sc9wJBRPB68x8pUtIoveTVqBM9QMu9QFyfhlwqSPAgKE7Dqi74KmHWbgyrLD/1ZNOPxzus9x6bZFVeIdnL7R52YXCg21itrJaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724694093; c=relaxed/simple;
	bh=8z0ijpKLCyL0/hK7XURRlPlM8gG/OVt4zB5FIjNk014=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jqEJvoeDObUkvqV9SSwvWRqzdyCpu7g730V5Y03yArTjvLDvtH/iwA4M8DfnNcXdQOS0WVRU/Fcs3qwrjoyv0QnmxFHH0Ore0fGKdFtQjgnz/FF8NuupZk7m6o/AFgK8tCegoFmiy1rjIX9z2bOZqJo3IFIvPBqz41WVtdRB27U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RyY4xkTi; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-714302e7285so3860128b3a.2
        for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 10:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724694090; x=1725298890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gk6yec5dWuUP0cgrAQJG6vAUBJ9aHrLwI2uJ5n3Lhmk=;
        b=RyY4xkTipN3cKTf0Z8//tSaD5kW+wficFpJYbltMkKVdaDyPF6/WxyXU/01wxPtPct
         zwZNAtZ1jnBNuImupSypFXtpCJJxke4rRiZzjxP75DbC14u7ovmESAb4XOtMBAtWHgCb
         yBTtrrZ37IaYo/1fXFlIQ+TBdCgdJlfZDVHnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724694090; x=1725298890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gk6yec5dWuUP0cgrAQJG6vAUBJ9aHrLwI2uJ5n3Lhmk=;
        b=YWVpOPrBYDwV29KGxgPLKhal47FOlpkGHvBU0sGLtMZIIJNtBLY6Z0mqZB1pgyhTUz
         DYzldAOKQoyC7x/QjavdL3LzjZ2MrZZhskbSAFE6dI99KyidR3Gerv288P46NM5Zpzc4
         JTBl1C8TfidAajuKvuzXnl6lz7I/wKB/u8DEPnEncf4wIrDxx+SGm3Z3Hjd/Jn/H5SkP
         L1ihoM7VqAkm1D+o6s146obHSVD7e3pzDzqQXWrBrjPKHkJ+wYpx7eJpAnjhLKzQ222T
         B3/RpkcgR4krpaX9neObmL4Wxu4QM8huegguKeg0dxy+JMQt/wO0sZVWaG4S52VHT7Q7
         gDdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVch+lW9XBQnQ+rW4Pp8IqVyo/qnh2o7MzSwfnQtr48rL0Jpnp1F6p13/lmYuCP3p7Rwbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/BhLhDaDVcjSJyGxKbsq0lieOJaFhKmFFqMn/a3K0llKDV6qV
	Px+bcAUhIfvOcGgFIaW8OozY3lXzwlX3LSbWbJ0fcS8mfVga0h1vMVOLIId+8/b/x91C7HVAw0d
	qifRSSTQPkecwI75LWm6HS9ewU0DqjWV2Bws2
X-Google-Smtp-Source: AGHT+IGUoZte0p19xwWBeSiInV7PcfaUqsGgBPlQ2VYY7m0wFFR9zVxHRono64Qiy0v2wUCnm32xn+uUvVhnGv9x41o=
X-Received: by 2002:a05:6a00:1a8e:b0:710:4d08:e094 with SMTP id
 d2e1a72fcca58-7144573cd07mr11456889b3a.2.1724694090361; Mon, 26 Aug 2024
 10:41:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814221818.2612484-1-jitendra.vegiraju@broadcom.com>
 <20240814221818.2612484-3-jitendra.vegiraju@broadcom.com> <0de48667-fe8e-4cd8-a84a-e3e5407c7263@marvell.com>
In-Reply-To: <0de48667-fe8e-4cd8-a84a-e3e5407c7263@marvell.com>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Mon, 26 Aug 2024 10:41:18 -0700
Message-ID: <CAMdnO-JSPEkJZLMPL8BLy1DKFUtU4aC_JpaXfs=g5YJFBu4_RQ@mail.gmail.com>
Subject: Re: [net-next v4 2/5] net: stmmac: Add basic dw25gmac support to
 stmmac core
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

On Thu, Aug 22, 2024 at 10:17=E2=80=AFAM Amit Singh Tomar
<amitsinght@marvell.com> wrote:
>
> Hi,
>
> > The BCM8958x uses early adaptor version of DWC_xgmac version 4.00a for
> > ethernet MAC. The DW25GMAC introduced in this version adds new DMA
> > architecture called Hyper-DMA (HDMA) for virtualization scalability.
> > This is realized by decoupling physical DMA channels(PDMA) from potenti=
ally
> > large number of virtual DMA channels (VDMA). The VDMAs are software
> > abastractions that map to PDMAs for frame transmission and reception.
> You should either run ./scripts/checkpatch.pl --strict --codespell
> --patch or use :set spell in vi to check for spelling mistakes

Thank you, I will do that next time.

> > +static u32 decode_vdma_count(u32 regval)
> > +{
> > +     /* compressed encoding for vdma count
> > +      * regval: VDMA count
> > +      * 0-15  : 1 - 16
> > +      * 16-19 : 20, 24, 28, 32
> > +      * 20-23 : 40, 48, 56, 64
> > +      * 24-27 : 80, 96, 112, 128
> > +      */
> > +     if (regval < 16)
> > +             return regval + 1;
> > +     return (4 << ((regval - 16) / 4)) * ((regval % 4) + 5);
> Is there a potential for regval to be out of bounds (regval > 27)  that
> needed to be handled properly?

The IP core documentation we have only defines support upto 128 VDMAs.
The same formula should for higher values (bound by bitmask).

> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dw25gmac.h b/drivers/n=
et/ethernet/stmicro/stmmac/dw25gmac.h
> > new file mode 100644
> > index 000000000000..c7fdf6624fea
> > --- /dev/null
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dw25gmac.h
> > @@ -0,0 +1,90 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/* Copyright (c) 2024 Broadcom Corporation
> > + * DW25GMAC definitions.
> > + */
> > +
> > +#define XXVGMAC_ADDR_OFFSET          GENMASK(14, 8)
> > +#define XXVGMAC_AUTO_INCR            GENMASK(5, 4)
> > +#define XXVGMAC_CMD_TYPE                     BIT(1)
> > +#define XXVGMAC_OB                   BIT(0)
> > +#define XXVGMAC_DMA_CH_IND_DATA              0X00003084
> nit: lower case please, 0x00003084.

Thanks, will fix it.


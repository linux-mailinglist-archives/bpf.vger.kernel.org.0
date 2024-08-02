Return-Path: <bpf+bounces-36321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C192946580
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 23:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41F3C282642
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 21:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDE81514E0;
	Fri,  2 Aug 2024 21:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="P/3G9qMR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D73137764
	for <bpf@vger.kernel.org>; Fri,  2 Aug 2024 21:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722635164; cv=none; b=AcUGsRrYz55/aesuuIcDK1DhiOe83BQkbmx8g56g7oaUXsGWwDjfpOuGJoKF8fr2zulP2ne7XRwoAUxOfB2t39zdKMHXT/gMV/RacEdzYzssdxSgYsVpf5Ow4yX+hvMpk6esuqo0bXX8l0ZNrPZdl3BvPlB07cyaV2ZnIIA57rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722635164; c=relaxed/simple;
	bh=CLgLwCBQz+SOj2L4A+2atrxYMUduHMBsKzplkUr+idM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NPs4xNMinpn17B7RAUosYVCymNisrz94uJ40XWNAFC1DNvJUXqBd5u/nGiJKGq5GvxujVsttc1DenyqXbURPpqA7z+7t1V6RSm8tob37ruabtPgbBrcYpLV7ygu7bhBpo4yR/SwrNeT1HkR47ETLi8YpZdg1+dD5fxjNS3PelJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=P/3G9qMR; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2cdadce1a57so5922911a91.2
        for <bpf@vger.kernel.org>; Fri, 02 Aug 2024 14:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722635161; x=1723239961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JU9A3+pkHtkV1/Zl7dIEANXrrOXhOpFpmn/8LwuWvI=;
        b=P/3G9qMR18sDpa7r6qj8GvYo7vI1AggEyP8UqWa7W8+6+3IHeS/cL54jP/aGRPzezh
         FZSSMfQTHPsAAim0bf8ZaT6AffZyTYyWg3mDsrldlu3IxfUb6dnj0GWAUhzUZKbdMRiZ
         JU6MswonsKNqIHlsoREq/TPKtQJvfsyq0ZIf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722635161; x=1723239961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6JU9A3+pkHtkV1/Zl7dIEANXrrOXhOpFpmn/8LwuWvI=;
        b=UM3KRldbwxhFxs28AJ09dPK0BI6QtozfBfN9prV0W8iKP8w4EUXl+NSKvbqagGTH6y
         nY1iyIyTMv0FQ1S0iuU+UL4FWwg53bA6omnTRDyp+9d7+1Oxwqlc7KJRJ/lm4cvJnRSv
         qIwiTGySf7gijmaMPYEKhiiuXWzyjWWFp6slwtWGvGLxKqYqf2fq7Fp1fRIW9FqM/SRH
         Bi+nc89HN6NE5UC6rpaRxcOWch1l8E+oOHQf9fED2XIuqmbacZh7qLHVla/ck2EwMMz0
         yzuztb/a+cOyLY7AHnLxg7YsqxTy+/UvS2F7FixrXegf8gQyfuADbhYDllvlnq+7Cj12
         fcVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmgdgvshvWlJnuZULAkb5VfRf1iIHAHNsdBYBTOo4f4bogEXXQ4hJ3+eOBzHramSRJUGfMMOHZS/QtxV0+2YTvRjgJ
X-Gm-Message-State: AOJu0YzeLSZUpQ4kEyShT6t6CRRK88C7SWCDKqn0/hRZYNTnT6cqu/Si
	kr+hCEjhEAlSYYTu8oEdVWrTEM8UsubJrqcCoNKw9EQ4FSy7SaSpu9PeL8anUM0/GREU/KSlmMV
	IffCpgorlxpNWIR0Ex7QAyGBve7td7NB611yZ
X-Google-Smtp-Source: AGHT+IF40zRRZ4gCavijc3AcIA9p7ICZ/ZbFiiXFymV9WjpQVTokLcCdEOjlLAeEwbQjG/06LFmkIZxUZud2wsOJD7k=
X-Received: by 2002:a17:90a:6387:b0:2bf:8824:c043 with SMTP id
 98e67ed59e1d1-2cff9413e04mr6094475a91.18.1722635160975; Fri, 02 Aug 2024
 14:46:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802031822.1862030-1-jitendra.vegiraju@broadcom.com>
 <20240802031822.1862030-2-jitendra.vegiraju@broadcom.com> <20240802143818.GB2504122@kernel.org>
In-Reply-To: <20240802143818.GB2504122@kernel.org>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Fri, 2 Aug 2024 14:45:50 -0700
Message-ID: <CAMdnO-+JBk9X66rzPqWL+1Bf_0kyqnMN9+ikaTp65CfzVmps=g@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/3] net: stmmac: Add basic dwxgmac4 support
 to stmmac core
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, andrew@lunn.ch, 
	linux@armlinux.org.uk, florian.fainelli@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 7:38=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Thu, Aug 01, 2024 at 08:18:20PM -0700, jitendra.vegiraju@broadcom.com =
wrote:
> > From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> >
> > Adds support for DWC_xgmac version 4.00a in stmmac core module.
> > This version adds enhancements to DMA architecture for virtualization
> > scalability. This is realized by decoupling physical DMA channels (PDMA=
)
> > from Virtual DMA channels (VDMA). The  VDMAs are software abastractions
> > that map to PDMAs for frame transmission and reception.
> >
> > The virtualization enhancements are currently not being used and hence
> > a fixed mapping of VDMA to PDMA is configured in the init functions.
> > Because of the new init functions, a new instance of struct stmmac_dma_=
ops
> > dwxgmac400_dma_ops is added.
> > Most of the other dma operation functions in existing dwxgamc2_dma.c fi=
le
> > can be reused.
> >
> > Signed-off-by: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
>
> ...
>
> >  stmmac-$(CONFIG_STMMAC_SELFTESTS) +=3D stmmac_selftests.o
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drive=
rs/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
>
> ...
>
> > @@ -641,3 +642,33 @@ const struct stmmac_dma_ops dwxgmac210_dma_ops =3D=
 {
> >       .enable_sph =3D dwxgmac2_enable_sph,
> >       .enable_tbs =3D dwxgmac2_enable_tbs,
> >  };
> > +
> > +const struct stmmac_dma_ops dwxgmac400_dma_ops =3D {
> > +     .reset =3D dwxgmac2_dma_reset,
> > +     .init =3D dwxgmac4_dma_init,
> > +     .init_chan =3D dwxgmac2_dma_init_chan,
> > +     .init_rx_chan =3D dwxgmac4_dma_init_rx_chan,
> > +     .init_tx_chan =3D dwxgmac4_dma_init_tx_chan,
> > +     .axi =3D dwxgmac2_dma_axi,
> > +     .dump_regs =3D dwxgmac2_dma_dump_regs,
> > +     .dma_rx_mode =3D dwxgmac2_dma_rx_mode,
> > +     .dma_tx_mode =3D dwxgmac2_dma_tx_mode,
> > +     .enable_dma_irq =3D dwxgmac2_enable_dma_irq,
> > +     .disable_dma_irq =3D dwxgmac2_disable_dma_irq,
> > +     .start_tx =3D dwxgmac2_dma_start_tx,
> > +     .stop_tx =3D dwxgmac2_dma_stop_tx,
> > +     .start_rx =3D dwxgmac2_dma_start_rx,
> > +     .stop_rx =3D dwxgmac2_dma_stop_rx,
> > +     .dma_interrupt =3D dwxgmac2_dma_interrupt,
> > +     .get_hw_feature =3D dwxgmac2_get_hw_feature,
> > +     .rx_watchdog =3D dwxgmac2_rx_watchdog,
> > +     .set_rx_ring_len =3D dwxgmac2_set_rx_ring_len,
> > +     .set_tx_ring_len =3D dwxgmac2_set_tx_ring_len,
> > +     .set_rx_tail_ptr =3D dwxgmac2_set_rx_tail_ptr,
> > +     .set_tx_tail_ptr =3D dwxgmac2_set_tx_tail_ptr,
> > +     .enable_tso =3D dwxgmac2_enable_tso,
> > +     .qmode =3D dwxgmac2_qmode,
> > +     .set_bfsize =3D dwxgmac2_set_bfsize,
> > +     .enable_sph =3D dwxgmac2_enable_sph,
> > +     .enable_tbs =3D dwxgmac2_enable_tbs,
> > +};
>
> Please add dwxgmac400_dma_ops to hwif.h in this patch rather than a
> subsequent one to avoid Sparse suggesting the symbol should be static.
Thanks, I will make the change in the next patch revision.
>
> ...


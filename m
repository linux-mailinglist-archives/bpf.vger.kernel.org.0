Return-Path: <bpf+bounces-33889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E375A92770A
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 15:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE70281DF0
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 13:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E209B1AE872;
	Thu,  4 Jul 2024 13:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlRz09DX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56DC7E9;
	Thu,  4 Jul 2024 13:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720099194; cv=none; b=CcI5FZj2zgpk2+rW5cRu9zHlKIta2mBBHMlDxuKi7y/jL1WsC3ogf/H+mp4JDN4cyYNkVgL/YSJO7QfjeGaKNdMUlEPc9JGmbRUe9nP0minOMDq4iCiENvH1hMGszQa75RVLXRaYp3cRRGBU6lCk9tJwDC/eyUPUBK4PAITGFRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720099194; c=relaxed/simple;
	bh=bEx1ORCE++4Hi7zOuGfdPFW0dAv2Txvp4mLuIr675wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGG0iTo3kZmRi3UNsE7Cg4nFOmUFsy8jx81b0U8y0QpCdo7DTg5QgySb2878dmrnQhhxgiKdescJYkELu6andpqrArC4rYgpnbs4ZsY4lWtSkTHl95TGhsXTi6cM7mPtcbK5ZOdrR0AwQKYyT3k9B0PcK8xf8L8sdHXzNZ3ILB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlRz09DX; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52cdbc20faeso741337e87.1;
        Thu, 04 Jul 2024 06:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720099191; x=1720703991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Mio7nA2GrQAf/CO8lwaLayQG4Qad6gjdq+KH1l6Sqc=;
        b=XlRz09DX2BTfVwFIAAngf/wCYyZLEJV6VtuUPLqkhC23gNgVrxrbxOnAXdo9MatQYi
         cj8uQ6WYEF1rZKKVu//CPmgfpjAJV4qrxuSlQnskb5Wbe73VE2sLKqOl9mhU5KcRvSld
         qPYj0ISMpTO8F66++zQZ4Bo0yTPpQtQjFXMHkS93ZV7+R1aUL5ugQZL3Zj2xyCHW1mI0
         3xmi8rh1C4fRutKFlsKKQO9Wg0I4AmC06okmI7AG2EcqUQpnijkhJuXEbyENN4KpEP7u
         gNI31Xo8yiCOlncNO4CJnXFQ0+eQelmkHWovtJL371Z5FszIHGWfe4BxeFAZ9MOEUiBv
         MJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720099191; x=1720703991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Mio7nA2GrQAf/CO8lwaLayQG4Qad6gjdq+KH1l6Sqc=;
        b=bX8rgRixY2QNj56ya8TTRKt8/o4mO7tabphSQ5iohEhHTv69dylyL/VSEBmiQnCdcO
         KATYUvr1/oParWr0rFSzKsJX1NFtkmS2uTjakaEng5ocm5dFer9Nc2GeGkrFd3gESceu
         Vd3PmRZNuyHkzq3L6BwqDUFB4LDV3GM0NzXeQSUx9mgCz9QVRnVPxZUyvTHh14tQzDrr
         +xFHUE6VDO9MxPFwB/tRVbtrJ/tfRt4LWo6cSYszOcTmcd2/ccVEd23NJyXsJMmVlCfh
         IylvJeJuGbbFUnEihCTLephWu1nv4BolllWTL+xWvsadvkj92pUst8nrpZJ1E1VIG1z2
         PZiA==
X-Forwarded-Encrypted: i=1; AJvYcCWUkL0CCqzuzGTbenDJvoNV6Q5JzYijiHyeZJJt9uH7f42ogdiu9baMPo3vey8o8WVXFFZajzw+r/lfpc2fUNcvgbrrulphK2u/jJuFDso36nS1VeWLujMjOF/BfFbbY40coi6Q2e8/MZ7FL6eFYhVu2Ddtn0+wIjaA
X-Gm-Message-State: AOJu0YyQQ7CwheHPNm3wfLI0UsyUnIgrqBJXDeL4nUjpNcP5ZcalvjkU
	NLaLPfyMQ+fd1hiEKzdfYFC4npq0hctGOQUPiSItDGQ66AYYfTf5
X-Google-Smtp-Source: AGHT+IFLsJluxr9qbjbQR6D4oopUOzte2TNpjqiQgp9iU60Xia5F2mbvt0C30sUaoP0hA8XPlTqBtA==
X-Received: by 2002:a05:6512:4819:b0:52c:7fe8:6489 with SMTP id 2adb3069b0e04-52ea07126e6mr985561e87.63.1720099190585;
        Thu, 04 Jul 2024 06:19:50 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e9fbeb17asm200371e87.194.2024.07.04.06.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 06:19:50 -0700 (PDT)
Date: Thu, 4 Jul 2024 16:19:47 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Halaney <ahalaney@redhat.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next v2 17/17] net: stmmac: pcs: Drop the _SHIFT
 macros
Message-ID: <tqghwucifrtbeeucsrbbc4zx22axaij7f4qx3rwhj27kmohgci@zin7ke5272n5>
References: <Zlmzu7/ANyZxOOQL@shell.armlinux.org.uk>
 <20240624132802.14238-9-fancer.lancer@gmail.com>
 <Zn7L4cP62MsNN61J@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn7L4cP62MsNN61J@shell.armlinux.org.uk>

On Fri, Jun 28, 2024 at 03:42:41PM +0100, Russell King (Oracle) wrote:
> On Mon, Jun 24, 2024 at 04:26:34PM +0300, Serge Semin wrote:
> > The PCS_ANE_PSE_SHIFT and PCS_ANE_RFE_SHIFT are unused anyway. Moreover
> > PCS_ANE_PSE and PCS_ANE_RFE are the respective field masks. So the
> > FIELD_GET()/FIELD_SET() macro-functions can be used to get/set the fields
> > content. Drop the _SHIFT macros for good then.
> > 
> > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
> > index a17e5b37c411..0f15c9898788 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
> > @@ -43,9 +43,7 @@
> >  #define PCS_ANE_FD		BIT(5)		/* AN Full-duplex flag */
> >  #define PCS_ANE_HD		BIT(6)		/* AN Half-duplex flag */
> >  #define PCS_ANE_PSE		GENMASK(8, 7)	/* AN Pause Encoding */
> > -#define PCS_ANE_PSE_SHIFT	7
> >  #define PCS_ANE_RFE		GENMASK(13, 12)	/* AN Remote Fault Encoding */
> > -#define PCS_ANE_RFE_SHIFT	12
> >  #define PCS_ANE_ACK		BIT(14)		/* AN Base-page acknowledge */
> 

> I would actually like to see all these go away.
> 
> PCS_ANE_FD == LPA_1000XFULL
> PCS_ANE_HD == LPA_1000XHALF
> PCS_ANE_PSE == LPA_1000XPAUSE and LPA_1000XPAUSE_ASYM
> PCS_ANE_RFE == LPA_RESV and LPA_RFAULT
> PCS_ANE_ACK == LPA_LPACK

Great! It will be even better.

> 
> Isn't it rather weird that the field layout matches 802.3z aka
> 1000base-X and not SGMII? This layout would not make sense for Cisco
> SGMII as it loses the speed information conveyed by the Cisco SGMII
> control word.
> 
> This isn't a case of the manufacturer using "SGMII" to mean a serial
> gigabit media independent interface that supports 1000base-X
> (PHY_INTERFACE_MODE_1000BASEX) rather than Cisco SGMII
> (PHY_INTERFACE_MODE_SGMII) ?

It's not that weird. The only CSRs available and functional for SGMII
PCS are PCS_AN_CTRL and PCS_AN_STATUS (plus PCS_SRGMII_CSR where the
PCS exposes the link status, aka Cisco SGMII tx_config_reg[15:0] with
the vendor-specific layout). Registers from PCS_ANE_ADV up to PCS_TBI_EXT
exist for TBI and RTBI PCS only. Since TBI is defined in the IEEE
802.3z C36 I guess that's why the layout matches to what is described
in IEEE 802.3z C37.

-Serge(y)

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


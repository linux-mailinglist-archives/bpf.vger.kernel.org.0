Return-Path: <bpf+bounces-38386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8373964246
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 12:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BD2BB24967
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 10:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C013018FDA6;
	Thu, 29 Aug 2024 10:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdLiriDb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC76418F2C1;
	Thu, 29 Aug 2024 10:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724928770; cv=none; b=ViB6z6KZ8MPrc1C7nDd4MEIOvsCJQ2goqR0wkkj0OKKGuvElWUBhXHKEkiBvmJ0vjeVj0rkeluJXdVAPynatljuT+biSCqs/T2sbuNk3VCotrINel5tTzMHtE56bE18Jn0bZ7Knjdra8KhgahxXKiTPkqDd16BYYerGwLqulsLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724928770; c=relaxed/simple;
	bh=xZQ59p1q3lZltXo5m95QXJ/g4rKkFaSLyF3m77XIVrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TErvnfqMjM0cb7Nf3sRhHFrLXEWTPpIJFiHF2Mpy2aseSIplHU43SKr9UV97rDwjKTwU9nYyfQivDkVkzXe1acwEW9NXeHMPYpgtn1oRGMMdJ0Pax1dA3xhGLX5shROafXuNO8b4xvZoQgAPw9/2OiJs6V2wEGweyV0BqOLrT5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdLiriDb; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f3ffc7841dso4745401fa.0;
        Thu, 29 Aug 2024 03:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724928765; x=1725533565; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=85t1HtXgo7SOU0tFEbV89Wze3MMLMJdkmn9MnnBc9fY=;
        b=mdLiriDbPXOFEIkZA+Jz+x/94jmW/BMo8DghnNI0iAyk2Fr4HXPA64V5qscS0INLxS
         5ermrkDce8r2LXwg9tRYd6jfJsOAHLB0ql7mMLDjtra0BeNnVTyFQEaSv5w/aiP++nuH
         qHm+NGI+V84MRmuyzI7oWjQuXrLgAPexRN9fD759YEOlP6gQuWV6I98yttg97ILjYTBB
         gg4AqqHzS5z57H6QkHrGTd5887DufdVu4YWPhzXIlGLennoaRROWPWDayGjCBtmjDruE
         WYGQyXysOdSIMV6/bcLY9r4ZsZxh/JkE2Ghnz0DkO5SSSIl1h4fJlKL9PCXIYD4uv9dN
         vDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724928765; x=1725533565;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=85t1HtXgo7SOU0tFEbV89Wze3MMLMJdkmn9MnnBc9fY=;
        b=JXOjnS1WX/9MgEp08vJLOlGD9R0ZBWvvgd6xzEb6YvUfTArZC2CSwEKHlFVWAk5UDb
         vtVRZtiCmW/l2lZ+LrX/c7kCcsVtyPhbhagw6XtvcA9WfcaN4meV5px8zPXg7ZbdjSZE
         9jYB9ZrgNwIwPIiTjK24iSxh9kDjXJvATmbxMePEyLntFInZ2QzsbBeaDxvNWJQtnnu6
         9tDeuwQ3dkSbAN5avljJto1ulSbqcSCbxgUrB1wEO4LUTX9uy+BovuFIYUCmcucaoW/l
         5ommkBMNwZ5fuu9BKDuUrj1Q908fjn6qlBG7Us9Fid5uaSFWPUsAeA0UZaIldbz6LMTT
         GfEw==
X-Forwarded-Encrypted: i=1; AJvYcCUHYeHq3aQBH7gRHROF6SBd3Bv74bdFWX5QPA4GIBrkxBtGye7Fy+3IOGCB5dE2zmwwoSAUwCavrxmOeO/o@vger.kernel.org, AJvYcCUZkzNoaL7NaY8YJlkuFXqeANtXoYAh0FrstcPMWEBIgmU99qYYWFN/SuiOAO3m++VWeQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YywoG5y48EF1lXU25tr/bIrxoxQ7fD1we6oHE3qyQS3BbRXaCOR
	6vZgoRtokFcAZXlFf+obCtpwJugomxtQ02/RAxQ9lXNP/s/060kQ
X-Google-Smtp-Source: AGHT+IEB/7p1y7S3x/3Z99k2vwiX5IMmtekOSaDa7H4Y4hvZQdNoJ3r226lxw5zBSAYxoAqEwF3oDQ==
X-Received: by 2002:a05:651c:1503:b0:2ef:2bac:bb50 with SMTP id 38308e7fff4ca-2f6108a3d59mr20296631fa.11.1724928764065;
        Thu, 29 Aug 2024 03:52:44 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f615182d72sm1355891fa.112.2024.08.29.03.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:52:43 -0700 (PDT)
Date: Thu, 29 Aug 2024 13:52:40 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, 
	joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, rmk+kernel@armlinux.org.uk, ahalaney@redhat.com, 
	xiaolei.wang@windriver.com, rohan.g.thomas@intel.com, Jianheng.Zhang@synopsys.com, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, andrew@lunn.ch, linux@armlinux.org.uk, 
	horms@kernel.org, florian.fainelli@broadcom.com
Subject: Re: [net-next v4 3/5] net: stmmac: Integrate dw25gmac into stmmac
 hwif handling
Message-ID: <li75hdp527xa3k23za3mfnwgwdcs7j324mlqj3qcxto6t5f6mw@yvhnpxlvlt5c>
References: <20240814221818.2612484-1-jitendra.vegiraju@broadcom.com>
 <20240814221818.2612484-4-jitendra.vegiraju@broadcom.com>
 <vxpwwstbvbruaafcatq5zyi257hf25x5levct3y7s7ympcsqvh@b6wmfkd4cxfy>
 <CAMdnO-LDw0OZRfBWmh_4AEYuwbq6dmnh=W3PZwRe1766Ys2huA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMdnO-LDw0OZRfBWmh_4AEYuwbq6dmnh=W3PZwRe1766Ys2huA@mail.gmail.com>

Hi Jitendra

On Mon, Aug 26, 2024 at 11:53:13AM -0700, Jitendra Vegiraju wrote:
> Hi Serge(y)
> Thank you for reviewing the patch.
> 
> On Fri, Aug 23, 2024 at 6:49 AM Serge Semin <fancer.lancer@gmail.com> wrote:
> >
> > Hi Jitendra
> >
> > On Wed, Aug 14, 2024 at 03:18:16PM -0700, jitendra.vegiraju@broadcom.com wrote:
> > > From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> > >
> > > Integrate dw25gmac support into stmmac hardware interface handling.
> > > Added a new entry to the stmmac_hw table in hwif.c.
> > > Define new macros DW25GMAC_CORE_4_00 and DW25GMAC_ID to identify 25GMAC
> > > device.
> > > Since BCM8958x is an early adaptor device, the synopsis_id reported in HW
> > > is 0x32 and device_id is DWXGMAC_ID. Provide override support by defining
> > > synopsys_dev_id member in struct stmmac_priv so that driver specific setup
> > > functions can override the hardware reported values.
> > >
> > > Signed-off-by: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> > > ---
> > >  drivers/net/ethernet/stmicro/stmmac/common.h |  2 ++
> > >  drivers/net/ethernet/stmicro/stmmac/hwif.c   | 25 ++++++++++++++++++--
> > >  drivers/net/ethernet/stmicro/stmmac/stmmac.h |  1 +
> > >  3 files changed, 26 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
> > > index 684489156dce..46edbe73a124 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/common.h
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/common.h
> > > @@ -38,9 +38,11 @@
> > >  #define DWXGMAC_CORE_2_10    0x21
> > >  #define DWXGMAC_CORE_2_20    0x22
> > >  #define DWXLGMAC_CORE_2_00   0x20
> > > +#define DW25GMAC_CORE_4_00   0x40
> > >
> > >  /* Device ID */
> > >  #define DWXGMAC_ID           0x76
> > > +#define DW25GMAC_ID          0x55
> > >  #define DWXLGMAC_ID          0x27
> > >
> > >  #define STMMAC_CHAN0 0       /* Always supported and default for all chips */
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> > > index 29367105df54..97e5594ddcda 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> > > @@ -278,6 +278,27 @@ static const struct stmmac_hwif_entry {
> > >               .est = &dwmac510_est_ops,
> > >               .setup = dwxlgmac2_setup,
> > >               .quirks = stmmac_dwxlgmac_quirks,
> >
> > > +     }, {
> > > +             .gmac = false,
> > > +             .gmac4 = false,
> > > +             .xgmac = true,
> > > +             .min_id = DW25GMAC_CORE_4_00,
> > > +             .dev_id = DW25GMAC_ID,
> > > +             .regs = {
> > > +                     .ptp_off = PTP_XGMAC_OFFSET,
> > > +                     .mmc_off = MMC_XGMAC_OFFSET,
> > > +                     .est_off = EST_XGMAC_OFFSET,
> > > +             },
> > > +             .desc = &dwxgmac210_desc_ops,
> > > +             .dma = &dw25gmac400_dma_ops,
> > > +             .mac = &dwxgmac210_ops,
> > > +             .hwtimestamp = &stmmac_ptp,
> > > +             .mode = NULL,
> > > +             .tc = &dwmac510_tc_ops,
> > > +             .mmc = &dwxgmac_mmc_ops,
> > > +             .est = &dwmac510_est_ops,
> > > +             .setup = dwxgmac2_setup,
> > > +             .quirks = NULL,
> > >       },
> >
> > This can be replaced with just:
> >
> > +       }, {
> > +               .gmac = false,
> > +               .gmac4 = false,
> > +               .xgmac = true,
> > +               .min_id = DW25GMAC_CORE_4_00,
> > +               .dev_id = DWXGMAC_ID, /* Early DW 25GMAC IP-core had XGMAC ID */
> > +               .regs = {
> > +                       .ptp_off = PTP_XGMAC_OFFSET,
> > +                       .mmc_off = MMC_XGMAC_OFFSET,
> > +                       .est_off = EST_XGMAC_OFFSET,
> > +               },
> > +               .desc = &dwxgmac210_desc_ops,
> > +               .dma = &dw25gmac400_dma_ops,
> > +               .mac = &dwxgmac210_ops,
> > +               .hwtimestamp = &stmmac_ptp,
> > +               .mode = NULL,
> > +               .tc = &dwmac510_tc_ops,
> > +               .mmc = &dwxgmac_mmc_ops,
> > +               .est = &dwmac510_est_ops,
> > +               .setup = dw25gmac_setup,
> > +               .quirks = NULL,
> >         }
> >
> > and you won't need to pre-define the setup() method in the
> > glue driver. Instead you can define a new dw25xgmac_setup() method in
> > the dwxgmac2_core.c as it's done for the DW XGMAC/LXGMAC IP-cores.
> >
> > Note if your device is capable to work with up to 10Gbps speed, then
> > just set the plat_stmmacenet_data::max_speed field to SPEED_10000.
> > Alternatively if you really need to specify the exact MAC
> > capabilities, then you can implement what Russell suggested here
> > sometime ago:
> > https://lore.kernel.org/netdev/Zf3ifH%2FCjyHtmXE3@shell.armlinux.org.uk/
> >
> I like your suggestion to add one stmmac_hw[] array entry (entry_a) for this
> "early release" DW25GMAC IP and another entry (entry_b) for final DW25MAC
> IP, in the process eliminate the need for a new member variable in struct
> stmmac_priv.
> 

> However, I would like to bring to your attention that this device requires
> special handling for both synopsys_id and dev_id.
> This device is reporting 0x32 for synopsys_id and 0x76(XGMAC) for dev_id.
> The final 25GMAC spec will have 0x40 for synopsys_id and 0x55(25GMAC) for
> dev_id.

For some reason I was thinking that your device had only the device ID
pre-defined with the XGMAC value meanwhile the Synopsys ID was 0x40.
Indeed you get to override both of these data in the platform-specific
setup() method.

> 
> So, in order to avoid falsely qualifying other XGMAC devices with
> synopsis_id >=0x32 as DW25GMAC, I am thinking we will have to overwrite the
> synopsys_id to 0x40 (DW25GMAC_CORE_4_00) in glue driver using existing
> glue driver override mechanism.
> 
> We can implement dw25gmac_setup() in dwxgmac2_core.c for generic 25GMAC
> case. But, this glue driver will have to rely on its own setup function
> to override the synopsys_id as DW25GMAC_CORE_4_00.
> 
> Do you think it looks reasonable?

What I was trying to avoid was the setup() method re-definition just
for the sake of the IP-core version override. Because if not for that
you could have created and used the generic DW 25GMAC dw25gmac_setup()
function.

One of the possible solutions I was thinking was to introduce the
plat_stmmacenet_data::{snps_id,dev_id} fields and use their values in
the stmmac_hwif_init() procedure instead of the data read from the
MAC.VERSION CSR.

Another solution could be to add the plat_stmmacenet_data::has_25gmac
field and fix the generic driver code to using it where it's relevant.
Then you won't need to think about what actual Synopsys ID/Device ID
since it would mean a whole new IP-core.

-Serge(y)

> If yes, do you want me to add the generic 25GMAC stmmac_hw[] entry
> ("entry_b") now or when
> such a device becomes available for testing?
> 
> > If you also have a DW 25GMAC-based device with 0x55 device ID, then
> > just add another stmmac_hw[] array entry.
> >
> 
> > >  };
> > >
> > >       int hw_cap_support;
> > >       int synopsys_id;
> >
> > > +     int synopsys_dev_id;
> >
> > With the suggestion above implemented you won't need this.
> 
> Got it. Thanks.
> 
> >
> > -Serge(y)
> >
> > >       u32 msg_enable;
> > >       int wolopts;
> > >       int wol_irq;
> > > --
> > > 2.34.1
> > >


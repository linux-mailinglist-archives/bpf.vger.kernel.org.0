Return-Path: <bpf+bounces-52168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FD9A3F1E9
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 11:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61FE216B6A2
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 10:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C08B205504;
	Fri, 21 Feb 2025 10:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfwY+BaF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265C22046A2;
	Fri, 21 Feb 2025 10:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740133467; cv=none; b=S+zYpB/dgGQvZ1QOOFrLvM+VBklyns7ASW7QAZOZ6y6g2UttFT4R+8Jz2vlCbsLxz7l/mr2hHsOQYfpN+I3CJVafCDXMGgeV+nKxdH4+DjsSrZoqYHCKfgXoYGF8lXR6iyYXYEwMtGX9RB1fW3jGmstxchHrAqGLfg7c94tcK4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740133467; c=relaxed/simple;
	bh=Eu+HjUPlHpd1kdRtWMGR+4QSBzjUTWtnpfAPcG0GlQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XrMdLQmjPSLdcw/8T3eMQb7i6g5S2KKyzCDRFbaGAqoIsdYHsmX3KOwBikNCLLk0k4quVYRnMwuCkm/69iYJFHio4xGJn/9stTiIc/oKjss62ou/HZQsmSLlNoMBJ6Sa1Udym8rqE5HORUWkZLrVohiLqbFtNK/xIn+VVNXtlFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfwY+BaF; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2212a930001so51271245ad.0;
        Fri, 21 Feb 2025 02:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740133465; x=1740738265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Ew/m0Tesk9Nn8WJobtK7q6jqPTmqqXgIVl6zfztn/w=;
        b=KfwY+BaFFJtz9Mw4K5XbCtKI/2kPY4b0/2Z7Z+j86WI9cl8C06FD2fgBCTkXiHFSsj
         hf0xn812GOowv9ZSGb0nhoPEDwMxvOljG4Boa0/pdczLdnc1mTAHJnwhaxKGbWFO3hel
         z+xpclU5xsVy+ZLHyx5c0U9y2fISHV0tP0z6FrtNjLXB/7SfLqCcyphHtOkDkCEgk0UA
         yprBYXialNPKmNzlU5WpWsoJCa8b4Tdm3235UYcUHhmvmguKM9SQWwUX655c2A9+MUwv
         2+56vv1+E8RhttopOTcNBUSCa/22BF4nyeQhS41bwH7snnd7CTWKKaRbFM1IFo6ROWEw
         dnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740133465; x=1740738265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Ew/m0Tesk9Nn8WJobtK7q6jqPTmqqXgIVl6zfztn/w=;
        b=C8EHZyj8zCjdsUhTR3z0W+e1n5WEK4dzHVhkyaxj2AEwk7i85HhvncPmawwxFvmZU3
         2LfIFkgbf5oW29H5N7nsmOviq5xrTVs/9IfTtEIkmHd7ZbFbmW6ZvjhbPn9Zi83N9W4O
         /4NvfOYjyI6Bmcfo2QkpYprYUcMqHiwN8ZtFC4UG2jppIQijw8lx3UcktYTHgfl7RnV+
         AWy34HIT3HB1UqrfQxTkevLka7SyIlBoDQ6UiPJ4GANBCK2OaXNk5z8N/nxkKu1b6U1I
         NcNW2lVL96r5i67O54qgs+CQTSRWmH+fGCyr+uIxNHWtqYig8Kx8rpqxuHxMUuuH+odA
         STEA==
X-Forwarded-Encrypted: i=1; AJvYcCUHNSW1I+frYw6sZTkAbnAA+0OhXHKDsGlqGJpBZ8Z9vpEoayZ+CcZ+40u8l/aGssXEtdJTkky44YMNTBlp@vger.kernel.org, AJvYcCX3iyIcXdF2LG3XMQYuvtXDv2Aa13bhEDERKal4gDAzwIKq1guUZDvLLtLpQBs0shTnarA=@vger.kernel.org, AJvYcCXYMMP+MXBEwiCAyi+r0CvHw1Uv34phEji3l4+zGH2yNaGo7QzHiVOelrV097tDKaT0NnhTluVQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2mZNlusrJS7639qrId5olmE3oupnQIRWwL8GZxhnytFfDkGZR
	57aLNU3eY0IkIobpaG8qPpHdumpIsHxtPHalDin9o15Qlo9v6iZB
X-Gm-Gg: ASbGncuBojAM7XgzdLcSaTMB/9y5QVfLWRGwqB72Puf2qXPxGXiCujRjPNEJLnwZKEI
	M80BBeJ9RE5j6SbP/+x04/RQuFDn1fKvPPRWs0sK2ChBkeabUNRL+yLpv7Vdr+TqQMOuPSib5Md
	EpeqDSLSnLX6O3RYxJAI4Oj7Nr7ydsXR+E90oBeMS5JRd4lym7wlEtzcMFJ7nonaXa4guyW6oQi
	msNIQ9+x2K/BfV2NMWs+aZM8mLfsuCKzezU0SXtD2f9L0uNc0vyIeVVaSinhKI7CRSo900SeIHi
	9+F9jUY8pHFzHa9OHRDXnHM=
X-Google-Smtp-Source: AGHT+IGJZmPsP1AQp35fmvwVzaW4gHUPKNfzSI/RTvC+piEPapIcYtvOiFrJzWkqFVimOfGDgcDxpA==
X-Received: by 2002:a05:6a21:7888:b0:1ee:e669:ef88 with SMTP id adf61e73a8af0-1eef52da075mr4126395637.16.1740133465235;
        Fri, 21 Feb 2025 02:24:25 -0800 (PST)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73250dd701bsm13961074b3a.131.2025.02.21.02.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 02:24:24 -0800 (PST)
Date: Fri, 21 Feb 2025 18:24:09 +0800
From: Furong Xu <0x1207@gmail.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Simon Horman <horms@kernel.org>, Russell
 King <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Russell King
 <rmk+kernel@armlinux.org.uk>, Serge Semin <fancer.lancer@gmail.com>,
 Xiaolei Wang <xiaolei.wang@windriver.com>, Suraj Jaiswal
 <quic_jsuraj@quicinc.com>, Kory Maincent <kory.maincent@bootlin.com>, Gal
 Pressman <gal@nvidia.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Andrew
 Halaney <ahalaney@redhat.com>, Choong Yong Liang
 <yong.liang.choong@linux.intel.com>, Kunihiko Hayashi
 <hayashi.kunihiko@socionext.com>, Vinicius Costa Gomes
 <vinicius.gomes@intel.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH iwl-next v5 1/9] net: ethtool: mm: extract stmmac
 verification logic into common library
Message-ID: <20250221182409.00006fd1@gmail.com>
In-Reply-To: <20250221095651.npjpkoy2y6nehusy@skbuf>
References: <20250220025349.3007793-1-faizal.abdul.rahim@linux.intel.com>
	<20250220025349.3007793-2-faizal.abdul.rahim@linux.intel.com>
	<20250221174249.000000cc@gmail.com>
	<20250221095651.npjpkoy2y6nehusy@skbuf>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Feb 2025 11:56:51 +0200, Vladimir Oltean <vladimir.oltean@nxp.com> wrote:

> On Fri, Feb 21, 2025 at 05:42:49PM +0800, Furong Xu wrote:
> > > +void ethtool_mmsv_link_state_handle(struct ethtool_mmsv *mmsv, bool up)
> > > +{
> > > +	unsigned long flags;
> > > +
> > > +	ethtool_mmsv_stop(mmsv);
> > > +
> > > +	spin_lock_irqsave(&mmsv->lock, flags);
> > > +
> > > +	if (up && mmsv->pmac_enabled) {
> > > +		/* VERIFY process requires pMAC enabled when NIC comes up */
> > > +		ethtool_mmsv_configure_pmac(mmsv, true);
> > > +
> > > +		/* New link => maybe new partner => new verification process */
> > > +		ethtool_mmsv_apply(mmsv);
> > > +	} else {
> > > +		mmsv->status = ETHTOOL_MM_VERIFY_STATUS_INITIAL;  
> > 
> > Tested this patch on my side, everything works well, but the verify-status
> > is a little weird:
> > 
> > # kernel booted, check initial states:
> > ethtool --include-statistics --json --show-mm eth1
> > [ {
> >         "ifname": "eth1",
> >         "pmac-enabled": false,
> >         "tx-enabled": false,
> >         "tx-active": false,
> >         "tx-min-frag-size": 60,
> >         "rx-min-frag-size": 60,
> >         "verify-enabled": false,
> >         "verify-time": 128,
> >         "max-verify-time": 128,
> >         "verify-status": "INITIAL",
> >         "statistics": {
> >             "MACMergeFrameAssErrorCount": 0,
> >             "MACMergeFrameSmdErrorCount": 0,
> >             "MACMergeFrameAssOkCount": 0,
> >             "MACMergeFragCountRx": 0,
> >             "MACMergeFragCountTx": 0,
> >             "MACMergeHoldCount": 0
> >         }
> >     } ]
> > 
> > # Enable pMAC by: ethtool --set-mm eth1 pmac-enabled on
> > ethtool --include-statistics --json --show-mm eth1
> > [ {
> >         "ifname": "eth1",
> >         "pmac-enabled": true,
> >         "tx-enabled": false,
> >         "tx-active": false,
> >         "tx-min-frag-size": 60,
> >         "rx-min-frag-size": 60,
> >         "verify-enabled": false,
> >         "verify-time": 128,
> >         "max-verify-time": 128,
> >         "verify-status": "DISABLED",
> >         "statistics": {
> >             "MACMergeFrameAssErrorCount": 0,
> >             "MACMergeFrameSmdErrorCount": 0,
> >             "MACMergeFrameAssOkCount": 0,
> >             "MACMergeFragCountRx": 0,
> >             "MACMergeFragCountTx": 0,
> >             "MACMergeHoldCount": 0
> >         }
> >     } ]
> > 
> > # Disable pMAC by: ethtool --set-mm eth1 pmac-enabled off
> > ethtool --include-statistics --json --show-mm eth1
> > [ {
> >         "ifname": "eth1",
> >         "pmac-enabled": true,
> >         "tx-enabled": false,
> >         "tx-active": false,
> >         "tx-min-frag-size": 60,
> >         "rx-min-frag-size": 60,
> >         "verify-enabled": false,
> >         "verify-time": 128,
> >         "max-verify-time": 128,
> >         "verify-status": "DISABLED",
> >         "statistics": {
> >             "MACMergeFrameAssErrorCount": 0,
> >             "MACMergeFrameSmdErrorCount": 0,
> >             "MACMergeFrameAssOkCount": 0,
> >             "MACMergeFragCountRx": 0,
> >             "MACMergeFragCountTx": 0,
> >             "MACMergeHoldCount": 0
> >         }
> >     } ]
> > 
> > verify-status always normal on other cases.  
> 
> Thanks for testing and for reporting this inconsistency.
> 
> > @Vladimir, maybe we shouldn't update mmsv->status in ethtool_mmsv_link_state_handle()?
> > Or, update mmsv->status like below:
> > mmsv->status = mmsv->pmac_enabled ?
> > 		ETHTOOL_MM_VERIFY_STATUS_INITIAL :
> > 		ETHTOOL_MM_VERIFY_STATUS_DISABLED;  
> 
> You mean mmsv->status = mmsv->verify_enabled ? ETHTOOL_MM_VERIFY_STATUS_INITIAL :
>                         ~~~~~~~~~~~~~~~~~~~~   ETHTOOL_MM_VERIFY_STATUS_DISABLED?

Your fix is better when link is up/down, so I vote verify_enabled.


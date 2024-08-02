Return-Path: <bpf+bounces-36306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CCE946354
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 20:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7C31283270
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 18:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995271537CD;
	Fri,  2 Aug 2024 18:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FV45IUAw"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2371ABEC2
	for <bpf@vger.kernel.org>; Fri,  2 Aug 2024 18:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722624322; cv=none; b=ARdLVQUru5jvt4CfNLojwWLGbWRIYyBUqMwFvUqlD/UItnY6ITWVruUrHIyICtp//vFuZboOPV9j1pEeMeJkoI6HaTrnaztdThmP665diFyNHjT7XF2CLnSUgOvOUKvhTprLBrodjn9GYHxtMiV1/A/J4/a+2uWy/DNLfhn2Txc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722624322; c=relaxed/simple;
	bh=6VbM1xTfuy9x8nDg6/hr/99c0BITQcVEab1BgICHmjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSyqQDAny408VXi8wvEA1lTNIZ6AttgPhljMzQ+If0Nz/VwC4Z7khxsLWwuC5hKFb5rvH0OKVfDdxdXgwmPqP7SxAs1GkGqKv3m0NXJOQAKLxxVx2dzyH5P4lDIxSRFQyVYxw4XPY+EHNKN4kZ64j5t3PcWCfd4bB+IVPTc/6OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FV45IUAw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722624319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K9JQ2Bf0SWejaUXaO1CuoWG99+H3ynJpTMEOSBOBAU8=;
	b=FV45IUAwD8WubsDylMxR8c0XFfn49ELblSYswLBieXzaoXcJkbHjeHKTwnId8RxgpJyB56
	AeV5ZT32hzOXS6wyllKA5aKuiRwr92RuAIh7uSzsyk5FCY9SdkBGRww+RVl+g1fw8H5TUf
	UlacApqnMvqd62cGskYGfahp81V2qZI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-P0a65PZAN6KZOkJECM9g2Q-1; Fri, 02 Aug 2024 14:45:18 -0400
X-MC-Unique: P0a65PZAN6KZOkJECM9g2Q-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-44fdd39f503so109323731cf.1
        for <bpf@vger.kernel.org>; Fri, 02 Aug 2024 11:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722624318; x=1723229118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9JQ2Bf0SWejaUXaO1CuoWG99+H3ynJpTMEOSBOBAU8=;
        b=kaaKowCFVYdUgNDx0BHtVBQuWdeCs2cdbFraqoBO47dhIZggGgFt+FitWn6jh8qNZg
         5469JaD8asmG72EI7uRM9v7UMBbYzPhDWI94FpfjsHrMKRw8sjjE2yt2GPTHLYHU2jpK
         43H8tCtNWmMzpoCHMI/Q/Fnq+xFvCm/c1VIz+mPNwxxTSafCgsYAGX4JstYW11f1+Nde
         2xculMSN+ijb2hmfLR5z3NqxiZlXpwRJzjXCYXGkZodZQF8dkH0Q30rGlbXbeOee2RCL
         +Iq01NMsUQpDOeJoJLgQwT1LdMTfaIVr+okBviTjesfZ0tqow4N2fmtQ7mYyRavY4pzq
         Ur8w==
X-Forwarded-Encrypted: i=1; AJvYcCVy2XbM6sXcnnTRepClmDMxeBTuMuG+vW/DSqZO6JWo/9AZKn+FnIpIKc3KQsAvaoDeCHXTcaApAnW+nDBppyz55afS
X-Gm-Message-State: AOJu0Yzbcx+hZMisjD6I0iKj/Mf7VHsGuvSDbIgq5RFMx8yGGVD5mm4C
	mFP8dxJfNE6bpOcyHLOJ57twvzB3dZ6We9XS5Cdfco35dnFBIDXGBQbV7Z4wLo4YtWydSrQgSD8
	9czrHCUdUA4tzLugK3/aRmtTOq4Sj61frfyAHyt5hI1x6dOL9tw==
X-Received: by 2002:ac8:7fc4:0:b0:447:ee02:220 with SMTP id d75a77b69052e-451892ad6a7mr52630191cf.30.1722624317894;
        Fri, 02 Aug 2024 11:45:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVwPo418K/j4TSG5frJ/PeeWs9ccUUjf6b01FC1y1GFDXNXPuzIYaN0JC6zJzw9tCN9/UwJA==
X-Received: by 2002:ac8:7fc4:0:b0:447:ee02:220 with SMTP id d75a77b69052e-451892ad6a7mr52629981cf.30.1722624317602;
        Fri, 02 Aug 2024 11:45:17 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4518a757920sm9405371cf.67.2024.08.02.11.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 11:45:17 -0700 (PDT)
Date: Fri, 2 Aug 2024 13:45:14 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jose Abreu <joabreu@synopsys.com>, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH net-next 10/14] net: stmmac: move dwmac_ctrl_ane() into
 stmmac_pcs.c
Message-ID: <4t4wd6bv3gzyzc4nbbszydnagvzgynluy2rb6jtfjxtidrmoqh@62cs3wx52pob>
References: <Zqy4wY0Of8noDqxt@shell.armlinux.org.uk>
 <E1sZpob-000eHh-4p@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1sZpob-000eHh-4p@rmk-PC.armlinux.org.uk>

On Fri, Aug 02, 2024 at 11:47:17AM GMT, Russell King (Oracle) wrote:
> Move dwmac_ctrl_ane() into stmmac_pcs.c, changing its arguments to take
> the stmmac_priv structure. Update it to use the previously provided
> __dwmac_ctrl_ane() function, which makes use of the stmmac_pcs struct
> and thus does not require passing the PCS base address offset.
> 
> This removes the core-specific functions, instead pointing the method
> at the generic method in stmmac_pcs.c.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>



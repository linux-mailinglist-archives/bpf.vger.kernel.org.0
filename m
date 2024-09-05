Return-Path: <bpf+bounces-39077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0F596E4DD
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 23:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B6502853DA
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 21:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82BE1AD413;
	Thu,  5 Sep 2024 21:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gJNfY7lo"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA530172BDF
	for <bpf@vger.kernel.org>; Thu,  5 Sep 2024 21:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725571001; cv=none; b=Z0614f6iCMEiPEhmitQwnG4PSYBpdPu0fiN2GTLtd0fj2dKpOkKiJG1U3YaPm9dRM9dbRhUyiwo87GZ93vx9ev7VJe47O0yc7BkX/amJrTJr5R6b1k8jJ9SkVq5w7/jebm0lqsXIwGOEmH5ScDSRCKP1+G11XS+YVO5sOHLF49U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725571001; c=relaxed/simple;
	bh=/U56oYodVHS7dpWVocXrXDbGpMjUt9U+S2ou0QXjyos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/8KKFxieEjJ1hiYB3jxgNNdziQxaqqnrTY23v9pHQ0Qo6Z2/qez2gnyQKDvVJZmR7b1CJOpBD3SD0Gty+pY06Quo9VOFKbSF/iJLWBGCrIpuilb0jB45+huMSulwGiYKb9IbBTfI5AM1lKEG6utpI0ojkiMeRjpFzNB/lAtFns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gJNfY7lo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725570998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aCS9FGPb22Zp8YOFZ9hjWeIZgSN7BXU4B9ST/Ivvoxw=;
	b=gJNfY7loo+6uckt5qLJS3t/wG9zrU7YN3odJ4he37lo4dTkYCZMxtF17gJXvwSkG4MBMWk
	8DfMd3UzdB0fOgI+FzmOEhtQ4N8C/Mlpkvcf+7x0vOijvc6+8WSBN2pp6qYrMde/4NHC2X
	O5eJcFaJmObx5gIx82nd6rMXJXB4Gy8=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-LSGTjjs8O5-0JLBGuJpC7g-1; Thu, 05 Sep 2024 17:16:37 -0400
X-MC-Unique: LSGTjjs8O5-0JLBGuJpC7g-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5dfbd897bd7so1220254eaf.0
        for <bpf@vger.kernel.org>; Thu, 05 Sep 2024 14:16:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725570997; x=1726175797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aCS9FGPb22Zp8YOFZ9hjWeIZgSN7BXU4B9ST/Ivvoxw=;
        b=ZFfpmKF8dorvDIEEff4rwmSFSdJ21aqW3zjMWSyh7+9USD3AeUcqWneIPwRBKhPFG2
         DbO04pSXFtQi2szfgZB09c3z+jRVXAdi1e5LPLza1QEmzUkgfOFZBqlMckORuqzUtwqq
         YuEzQU3U1xUg+WJhIoGoaHXUSoGxWgQmy/TmQ/irnTlHezBW56GxYo/SLWKC0j8mPde3
         GpRxrGPRp9FSRQWY4AMWk9FbywLSlK3TN/RT97RNO3h4rSd1Wu+UK/m3AqVsA+PzPyjO
         RCDHqPS6860dYY/e9AK33G18RYCbkK20p+2v9mo72m2Qxi4OV7eJYA/NsVSPfmMONUcf
         Jw0w==
X-Forwarded-Encrypted: i=1; AJvYcCWSgYYTs8M8E8pd0bS2BTOhZcYziTpzhVteLaq1kJ1FLWIt5FHcTS34JZnex06KoWqbbIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeEMi7yoiJXH7m+iTQavOHGCBEmkjY9OE7NeWJvxbYJA1FXrnP
	MxHwC9wzqLEmn2JRz+i7KKdhEUWnHL5HX/Qu4omsZlFcyWzDPAhv9tDxepyJZrStKr+XtiAvHFn
	8w0OZUiLEa/GUb3KswXPkSU2VKcfuCA8ylSU093ZfqOrPzWacqA==
X-Received: by 2002:a05:6820:220f:b0:5dc:a733:d98a with SMTP id 006d021491bc7-5e1a9d3deaemr460129eaf.7.1725570997213;
        Thu, 05 Sep 2024 14:16:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcn3lC302r4cvOynTV/pTYo7UP0omv7LrahF3fXXR7CTInjmYCD99NLWRLjJz2kCarVDyMyA==
X-Received: by 2002:a05:6820:220f:b0:5dc:a733:d98a with SMTP id 006d021491bc7-5e1a9d3deaemr460105eaf.7.1725570996900;
        Thu, 05 Sep 2024 14:16:36 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::40])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c5201e46a4sm11023736d6.53.2024.09.05.14.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 14:16:36 -0700 (PDT)
Date: Thu, 5 Sep 2024 16:16:34 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Serge Semin <fancer.lancer@gmail.com>, 
	"Russell King (Oracle)" <linux@armlinux.org.uk>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jose Abreu <joabreu@synopsys.com>, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Sneh Shah <quic_snehshah@quicinc.com>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH RFC net-next v4 00/14] net: stmmac: convert stmmac "pcs"
 to phylink
Message-ID: <6ktdiyivdf6pz64mck4hbxxxvvrqmyf5vabuh7zfzfpcm4cu6z@oh43gmbrs2tj>
References: <ZrCoQZKo74zvKMhT@shell.armlinux.org.uk>
 <rq2wbrm2q3bizgxcnl6kmdiycpldjl6rllsqqgpzfhsfodnd3o@ymdfbxq2gj5j>
 <ZrM8g5KoaBi5L00b@shell.armlinux.org.uk>
 <d3yg5ammwevvcgs3zsy2fdvc45pce5ma2yujz7z2wp3vvpaim6@wgh6bb27c5tb>
 <ce42fknbcp2jxzzcx2fdjs72d3kgw2psbbasgz5zvwcvu26usi@4m4wpvo5sa77>
 <74f3f505-3781-4180-a0f3-f7beb4925b75@lunn.ch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74f3f505-3781-4180-a0f3-f7beb4925b75@lunn.ch>

On Thu, Sep 05, 2024 at 11:00:31PM GMT, Andrew Lunn wrote:
> > Hmmm, I'll poke the bears :)
> 
> Russell is away on 'medical leave', cataract surgery. It probably
> makes sense to wait until he is back.
> 

Ahh yes, I forgot about that! Thanks for the reminder. I'll be patient
then and hope is surgery and recovery is smooth :)

Thanks,
Andrew



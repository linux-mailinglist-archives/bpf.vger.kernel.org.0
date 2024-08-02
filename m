Return-Path: <bpf+bounces-36303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7C99462D1
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 20:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED1532828BB
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 18:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665BF1AE050;
	Fri,  2 Aug 2024 18:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKMUqJsO"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910FC1AE052
	for <bpf@vger.kernel.org>; Fri,  2 Aug 2024 18:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722621673; cv=none; b=Dmv9P/TrsVZk8WAMVZEv9t4IfyLONXoru3MXzoMW6PmavSm3QAYLEt6o8GpEFDWEsBqiHJtefGCXSjmVwn/44NibfkSR0RlIoCGhP45J2dV5vlq3Tp005kNy35BYp+bP4SSlFO9g3FfgZpymBeOtEIqIMT8P/FgiaYzP2XhzmeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722621673; c=relaxed/simple;
	bh=NwqwjZ1ZkmCR5L3cE68C/lUHncA4QY/rihu4kv5E3Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNCWeEFh9LEs/Piv6M6XUzE0I5B4g1FLQu8Kr6RNXvoQCgQKqYsGlKSiHXyH9FNjsgLSVjn/vYuueCSiBpI6zEM7CO87+CXkbygmvvCWQnafPGqz4YQCGKM9pWXEvotjdNAppGiqVO8oI+MLUYSlNcscDgjGFeCcF5xkAzjLXmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SKMUqJsO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722621670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HVTfFpaLZUbOaQ0HJhEjOqrkLc8CExWlF+kJqRyqPAo=;
	b=SKMUqJsOtl4Mu0IB3JO9I55VJxlkRbJAAs3mC1uI0uIP1qaXVooH6v/WudPOzhHhMluWil
	58SxRTbhHUIYTKy3/zt3MjH0dFiZZLsI09ggty8cM4AB20jIoocMzfofa64EdyGyIaa0tw
	rDqhOT4NLFy2Kh7yGCR9LmtH0+sWIHM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-KN5-8KBPOsGSHmjQ3iH9fw-1; Fri, 02 Aug 2024 14:01:08 -0400
X-MC-Unique: KN5-8KBPOsGSHmjQ3iH9fw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7a1d44099a3so998126785a.3
        for <bpf@vger.kernel.org>; Fri, 02 Aug 2024 11:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722621667; x=1723226467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HVTfFpaLZUbOaQ0HJhEjOqrkLc8CExWlF+kJqRyqPAo=;
        b=Z2pmYU5d2acpSrPT6UmyEBKWb4b5e1GKZtC9s46LWXplPzz+eGA7tNGmekTVMP0Y50
         jyaHfTu81UozRbtD2tv2yKTtjxDACa0iu5RnSeqJ+Kr0EMdh0K3CFoJlI8Wa71nIt8mE
         pIdQ6e0DzZ5wzG0YeL3cloeRQpb8oI/QCedn1z/X95BWzSJ5TNZLHpk17wp6yXAgNEPd
         wugTUJMKlvDHZyAKdIjzgkdJpuxzlx2LdGgXHbeZDxdPu0/lz41SJlAd+krdiE6heinG
         QpdgGTUePswNbUBbDgtfvl8cjV2YfwaT+ZTnSHqQCs1yC7JdgM/ftPxNQOs4rmFosUl8
         DruQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJqumwJ4ffxA+uxR9lKlDt+NFm4t0K5o3rREOadIw0cxLR3tfwsCcBpSSazrJTs4CDRWrfQ0H7anYm2JPXMvoNR8TC
X-Gm-Message-State: AOJu0YyqiaXi8k9SGUz9P8t7WopPDUaGNRCIQT9y58uXRXp1VtTP/aJV
	2cxKWX9h4GKgZzxyFkmdz2B4fDn1mp5SCgb8K5eoSrqzq7ZrWjWusk9/x2p4Oz5zw6p3PG7vorx
	jet/cQniyJ+vXs+QPGTvEk03ASfbB/f5zKWRnJIzLiCYCJFT3mA==
X-Received: by 2002:a05:620a:46a4:b0:79f:735:4cfd with SMTP id af79cd13be357-7a34efaeea7mr554500485a.50.1722621667653;
        Fri, 02 Aug 2024 11:01:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQJErAfbeHi7Cr/9xQl9lT7goXT1BrY20xVWa1C2WQla2ME5KtsJNYLix6zqIYtiFu1FmZog==
X-Received: by 2002:a05:620a:46a4:b0:79f:735:4cfd with SMTP id af79cd13be357-7a34efaeea7mr554496585a.50.1722621667225;
        Fri, 02 Aug 2024 11:01:07 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f6dca50sm107699185a.16.2024.08.02.11.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 11:01:06 -0700 (PDT)
Date: Fri, 2 Aug 2024 13:01:04 -0500
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
Subject: Re: [PATCH net-next 02/14] net: stmmac: replace ioaddr with
 stmmac_priv for pcs_set_ane() method
Message-ID: <idusdyewthu5q4j7awi3rc77ncdolt27ppq2pknrbynaobgztc@3xvnkeqml2bd>
References: <Zqy4wY0Of8noDqxt@shell.armlinux.org.uk>
 <E1sZpnw-000eGw-2F@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1sZpnw-000eGw-2F@rmk-PC.armlinux.org.uk>

On Fri, Aug 02, 2024 at 11:46:36AM GMT, Russell King (Oracle) wrote:
> Pass the stmmac_priv structure into the pcs_set_ane() MAC method rather
> than having callers dereferencing this structure for the IO address.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>



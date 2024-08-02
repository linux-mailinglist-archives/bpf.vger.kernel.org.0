Return-Path: <bpf+bounces-36304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8211E9462D8
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 20:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B0872829B5
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 18:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D18715C148;
	Fri,  2 Aug 2024 18:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eEm4ZIHs"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2069B1AE05E
	for <bpf@vger.kernel.org>; Fri,  2 Aug 2024 18:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722622129; cv=none; b=tDlS+kcZagP1m9CShrf2xMxJq6avPkSBcuVHs5rCqvdcKyyyjIJCpeWYD0n6P0Apc9puW09fuiLH4Dmr/skmg48ceNhEl3Ch6dblClt5W8cWYFQlPa+L0lmz7nHzIr9h1TX4cjL7GmCgQ8oGHpVXhuNM01voY4eNfrcYO46c37A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722622129; c=relaxed/simple;
	bh=1hzYSWBmFCCK+uKRWu72lLr8Q2S3/C2xUqeMNQzuPLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehPC2BRAifforIHG2Mt5ORoYAsPZPQeVz8cv0PxFRVEURQV7TaaITlUDHJmm8eszlVgpMYEjKie8ruZbLbOAoX3RBGzXscR8AsX658iEy+Wzgb88N30beWav+UvyHdA88gB4ihlDPT7pjieHiHXHwvk+zNbdlheSIHTvPwFom4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eEm4ZIHs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722622127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aLcM9MWhiHw0bs3x9mpTiGnVhWovcyriDIOcsgAYyLw=;
	b=eEm4ZIHsmHB8KAbxxQl05DzR3RhxfLLVQQ9X4oYdae88UulzP1/sqNFScbxv0+OOzsUyDv
	+U+QnVzFH/LACLklpl9qKFVTztv421/xgRtSoPpi2NJAeoun5sPKeCa1e2AyHgueBMbACV
	JuYeTJXCxmyJfnkxM176BTEJ6dA1Eqw=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-3t-8uW8tOnWvHcjQ4nadYw-1; Fri, 02 Aug 2024 14:08:44 -0400
X-MC-Unique: 3t-8uW8tOnWvHcjQ4nadYw-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-26103a95b34so10394440fac.3
        for <bpf@vger.kernel.org>; Fri, 02 Aug 2024 11:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722622124; x=1723226924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLcM9MWhiHw0bs3x9mpTiGnVhWovcyriDIOcsgAYyLw=;
        b=GpoVmK4o0kHBZ+OLdqgInKdFnnjhLHOtC09JN9r0PGgm/YHvhQJBA8zzB/VQimLfcw
         nX3u48k7Xk3lK1gKjCnXHNW9WUit34P7kkitRG/7FZsfnzbBIT5qRPWLjeMdTcmX3GcZ
         qA4hoc2fqhZ8dpIoxaIb7v2dITTAYTwL1YG1PG36OeR7An5XovmO5mze6sRLRZlVb4UM
         WO4FP5Y23wvbjw5T/TKJBSgVXqGCgU9Z90bFnL4n2cIcV/0PsPgDQPdOdarfvb0aVSmT
         NE5s4xctey4kuth40voQ9dCLTMRn+ouGAMTUjFoy6La0y1u1nSsJiWm3e1nyIAjbiT0R
         laeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMAOeAAM8zHKLgAM2CoSBeU/sEyXqO1wSBEsJIjeO38BmMl+OOJpZlpzSXTmJQK//LJLgKyy9iz9i+bQweAXj6ogYw
X-Gm-Message-State: AOJu0YwwMCUkPAM0sUhP2MwU0gZjX5gN8/xusmx3v9nH5IrGQEguTKEf
	5cuU8KFqg5/UGtaYhyLs4WNVUhCh+3ZUMIWHa3XcOuqG1mQh1lEOt6/NDhfpdHaOBbJjXdSttk+
	FYTdMBXP4kPtxsI6tbOh5z8lEIMHaWYm71YdMD1masjCaUdeUTw==
X-Received: by 2002:a05:6870:b528:b0:25e:14f0:62c2 with SMTP id 586e51a60fabf-26891ae014cmr5007838fac.3.1722622123950;
        Fri, 02 Aug 2024 11:08:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFR8xANvIW9PT25/s/1o20v300D34AcEqg5SxNPaonYq0aR8vsoes+Ti9UOB+gaVvGdCgqf3A==
X-Received: by 2002:a05:6870:b528:b0:25e:14f0:62c2 with SMTP id 586e51a60fabf-26891ae014cmr5007818fac.3.1722622123595;
        Fri, 02 Aug 2024 11:08:43 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4518a6aaa56sm9123001cf.16.2024.08.02.11.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 11:08:43 -0700 (PDT)
Date: Fri, 2 Aug 2024 13:08:40 -0500
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
Subject: Re: [PATCH net-next 03/14] net: stmmac: remove pcs_get_adv_lp()
 support
Message-ID: <kse4bj55hlnwsmidecriuqvkxj6i2fh6eredcd37jia7u7djbs@gcpastryv7jp>
References: <Zqy4wY0Of8noDqxt@shell.armlinux.org.uk>
 <E1sZpo1-000eH2-6W@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1sZpo1-000eH2-6W@rmk-PC.armlinux.org.uk>

On Fri, Aug 02, 2024 at 11:46:41AM GMT, Russell King (Oracle) wrote:
> Discussing with Serge Semin, it appears that the GMAC_ANE_ADV and
> GMAC_ANE_LPA registers are only available for TBI and RTBI PHY
> interfaces. In commit 482b3c3ba757 ("net: stmmac: Drop TBI/RTBI PCS
> flags") support for these was dropped, and thus it no longer makes
> sense to access these registers.
> 
> Remove the *_get_adv_lp() functions from the stmmac driver.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Clean up seems good, I'll take Serge's word on the IP details here.

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>



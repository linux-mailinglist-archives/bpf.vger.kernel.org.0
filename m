Return-Path: <bpf+bounces-58730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20794AC0FFC
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 17:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 080BA4A7071
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 15:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC81298C06;
	Thu, 22 May 2025 15:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVC0BZdG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC5C28CF74;
	Thu, 22 May 2025 15:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747927730; cv=none; b=u+h4cLW6Ubm4cpD+QwQqYps23POLjGjgMIWXckH1f5Kocin2NVtk/v9DNWSgfzqC+1H9G8WZpkEp5X1fvTNJpS/fnnNlUSiPSoKRxG8c+OY3mt9ihVTy0TVlTK0azhDB8zs+rW0W0FFqHhu3xG/uuV6fDl7Rely3LfY7Y4wJdZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747927730; c=relaxed/simple;
	bh=5NoudLGvdWRbcFgJfKlj655VK2kEbWuxeXEInAdpp6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5cdPEjiYHQmVbVACLZ0kb7imhf9RHd6PUmJYt+Uos7n2qjtXeakwDxoLRJM2YGqN3cQ/3z/U3z4rGHIlofSfvD/4Wkw2X1zk+rFL56pXkuV3VeL0xbL605BKVOHeI+Xu5SThaJn4w0CEJlTC87xDBkgj4nKGQOTpRh04ecudrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVC0BZdG; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b26c5fd40a9so7266755a12.1;
        Thu, 22 May 2025 08:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747927727; x=1748532527; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pxhVf4Fk0Buh1n6NgxkYLO8IAOCXV9pzn1pPfzcBZWw=;
        b=OVC0BZdGjT6dfFP+IbT9L0YT4boP2LLkhg1+ckx8tnuF7HEYUF9jgdsReRDm5CLfFd
         ucUtXpG/Qith6belD9D1jRpYe5LHJcLh71kDdspCB1cPUWVx2p1EE10Zt1oSmeoFQhlI
         1eRhKmsQPx+krbxs2SOF22oaDXXPj+qYynfAM0pYeUcju3N1GOBBdxFky7d1ZC6OOCG1
         Y+MWkkGGAcYckXD3luL8+cumWskBrey4HHpBT0PFh2lWtu4t/SHxRA+S6hCgOk7nuPPw
         YvJK0OTa34Z0Vlq2WOaEAHEunAm+wru8OieZb4XBhxdCHYfD0OKp1vXRLgoBK4jYldmH
         L5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747927727; x=1748532527;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pxhVf4Fk0Buh1n6NgxkYLO8IAOCXV9pzn1pPfzcBZWw=;
        b=itSG65Ecu5dv76uSVnzkxtiQtlpSvNLcVbE0alPGATxEgeezumFrbVsMAtPY+BMI/E
         nrCE+9L/ZzTfIWmutxITVovWFZWAtnqRkfhilCR5KwVH7S4pN+dSqFWh4GquydZR6wtb
         tmRUI1iZgNvkMY9ST6l/tGCWQPrj8a5idnAclQNNzgCFHk392gaSzIbyUzOTYs7P0SkT
         z0j/rfc5vkQIZJTIYwyyKErhPUJZNHiPz1hMS7O+K0KCU0U8bD0fS0WXV+lqjeiEHVvL
         IdmzzquOBENGzETTYgIRCinNZw/cvumWVn/Ke8RHKserUi8T2lyYfMeCEuCqVHaHDTIO
         Vttw==
X-Forwarded-Encrypted: i=1; AJvYcCU9nu+Sih3KZs2+AvLISLr5q9fDcTgpnY7EShHZEZl+ROUpNAKunC8ssxhiAzLB11txcTY=@vger.kernel.org, AJvYcCVP3B9/ZLxt9S2Ofr7FY6Lx0Wi9UlRog9fsKR1E8Cj5W1RGOPA6IGneTvxNeBJgEAzS5FWEpsVUpM4p0Q==@vger.kernel.org, AJvYcCW/szMbYw+ZRREbzMjC9gzB2CoMxevZh3QmLUO/d+g1QKFXGeKRGcmEicwu4GuvmmLrpLqkIRXk@vger.kernel.org, AJvYcCWvq/K43bTFuGDFguElGFhIc+fAkqMhAx9YVaWIkp4XsymoUO4+404/Ph2uFXF2OsaPd5lmJUVnSJ1kDjD+@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1GXM1Bn+4CB6rQ7lsvF3mJzOx1SBObxWL7TQ0ZhsYKSMp5INf
	7Fln8B9s8BNMjgw3kVLV4IuATJNHd9xPUk8GlpjuU8YSnPtv0QSHrQM=
X-Gm-Gg: ASbGncvLvPnIzlvHqdaF6oabA2Ulto2nfTRUZ1b3cgwUrBciLOQOrUH32X+hAsiN25r
	KZMPO1XcZjJsxCinqIt2BMyTt2yeEXxVvgEHxkiFtTek+CvWaceRSI0Ehjih3+5fMklApEmmwxH
	WSlAiBrZIF49ww8blDjzNtOBi7kWYP/3MMzTkNPeVXV0Lnav2IPMcyGHlRz/4wtXe3zKnj2E9PD
	3trEjuokwOnCDeL8rnSGTIbTiNNnu97DrQTI+u5NoAz0iXHBovZ7Iw92BG/S8u9raBf7ts/XRnF
	MFktl24cPL0C3ZQJDFvgL03jN6laksXqPPwQFYnpveziUIaHSqcRwpusZiONiknj5FdfKfw4RqC
	j1Y4680Q74yf1
X-Google-Smtp-Source: AGHT+IEs/L5Nah7O1be+YbAYx6rBYAuNcmd+A7wMEvRk1+S7stm6JzSVsgR+NJlVa6Qc4kCODkqMWg==
X-Received: by 2002:a17:902:d48d:b0:232:557c:2501 with SMTP id d9443c01a7336-232557c2657mr202892395ad.10.1747927727492;
        Thu, 22 May 2025 08:28:47 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2325251da10sm64589025ad.42.2025.05.22.08.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 08:28:47 -0700 (PDT)
Date: Thu, 22 May 2025 08:28:46 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"hawk@kernel.org" <hawk@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"leon@kernel.org" <leon@kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"ast@kernel.org" <ast@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Mark Bloch <mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH net-next 5/5] net/mlx5e: Convert mlx5 netdevs to instance
 locking
Message-ID: <aC9CrkOPhLBykJSp@mini-arch>
References: <1747829342-1018757-1-git-send-email-tariqt@nvidia.com>
 <1747829342-1018757-6-git-send-email-tariqt@nvidia.com>
 <aC4bAXlevrV5venn@mini-arch>
 <4ced8f1c8228eeb80f78677a46c3ba7ca3de2bc3.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ced8f1c8228eeb80f78677a46c3ba7ca3de2bc3.camel@nvidia.com>

On 05/21, Cosmin Ratiu wrote:
> On Wed, 2025-05-21 at 11:27 -0700, Stanislav Fomichev wrote:
> > On 05/21, Tariq Toukan wrote:
> > 
> > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
> > > b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
> > > index 0979d672d47f..79ae3a51a4b3 100644
> > > --- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
> > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
> > > @@ -32,6 +32,7 @@
> > >  
> > >  #include <rdma/ib_verbs.h>
> > >  #include <linux/mlx5/fs.h>
> > > +#include <net/netdev_lock.h>
> > >  #include "en.h"
> > >  #include "en/params.h"
> > >  #include "ipoib.h"
> > > @@ -102,6 +103,8 @@ int mlx5i_init(struct mlx5_core_dev *mdev,
> > > struct net_device *netdev)
> > >  
> > >  	netdev->netdev_ops = &mlx5i_netdev_ops;
> > >  	netdev->ethtool_ops = &mlx5i_ethtool_ops;
> > > +	netdev->request_ops_lock = true;
> > > +	netdev_lockdep_set_classes(netdev);
> > >  
> > >  	return 0;
> > >  }
> > 
> > Out of curiosity: any reason this is part of patch 5 and not patch 4?
> 
> If you're referring to enabling instance locking in
> drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c and by patch 5
> you meant patch 3, this part cannot be submitted separately from the
> other changes in this patch, as without all of the changes we'd either
> get assertion failures from missing the instance lock or deadlocks
> (e.g. from using the dev_* instead of netif_* functions).
> 
> As I tried to explain in the description, I couldn't figure out a way
> to split this change into smaller units, as the call graph looks like a
> ball of hair spit out by a cat.

SG, thanks for clarifying!


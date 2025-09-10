Return-Path: <bpf+bounces-68030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF6CB51D83
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 18:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842FE1B27D7A
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 16:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE87B33438E;
	Wed, 10 Sep 2025 16:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NOkYGeC/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A5933438C
	for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 16:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757521395; cv=none; b=T0PK0Evh7XVmO1dyjTOYRUgUjSrYaVdRzalzka0pvc98W+dfFyDgPwRCta60WAKfc4haRJ3isd2DrvLuZ2jA/j9oe4ai68vhsR6/qx55XycRsBGM5IsfHwbWuDmBnKhRM9zRwZ008xU0tE2teNj2ewr03gGGclt+mLVXAvn71Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757521395; c=relaxed/simple;
	bh=QV4qaVeduj/yREU+BcPgw7XZ6y4Ontzbperd5ZjM2FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maDZQ9FBjF2uQnXXPRFux3JdmU8SiMJRD+J/xTs+nhfaGy4JZ80ybgF4kGPdmGcfBLCFCY4IBmHyUh9piliVrJAj7GWoGI8kguOMwQpYtnDq67l+cBKqon+sFKvKHmU5Gj5yPmnZghw3pgeQnDjSLSUUUnLsXn47DqMISqW7Tdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NOkYGeC/; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-721504645aaso55555096d6.2
        for <bpf@vger.kernel.org>; Wed, 10 Sep 2025 09:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1757521393; x=1758126193; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6FwkMlW01VIxUYcm4CJlAUCNZh7Z+O+5WtmWOGwJI3A=;
        b=NOkYGeC/S+w/8ATjQvShKnZMry6MY69n21syvlKD/TTlx355U9cULP7fW94d405l0H
         f++QA1CPEbk4wOfziDL5xDrerqbEsBF1GBAE6WLkSlotZ/gOaRBdffZnPAKwpUwHXpwn
         3gVmCtLg1cFPmjkK4wGvxc43LFqk2xfFUtti9goCwpIJQhXodP7OB98HCD7etonUoHbs
         /HN2PVVBsad1MeFnMgMMAyoumQdsWASMJSTI9fkPsebfEuFj9frTW/J+pImlrJS5VayA
         ELLqx5tSMVgwm8/eSoTepH7RxYqb5DZ02MWM4CT0EA85I9TPNbFJYv+6djUsf4zza+0y
         YZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757521393; x=1758126193;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FwkMlW01VIxUYcm4CJlAUCNZh7Z+O+5WtmWOGwJI3A=;
        b=VIPgl6KeL7P6NQy7QzpiyZFxlEVv4kFzNRL83JEVjwYxhEetnwVofxGvBa5dHtx37U
         0r2eVmSTHWOfxqdLLWqobH3sJUD1sqnS2QTdI0DQIUHaR9IsPfTiY26j1NCyka920yhT
         Xs62dfl0DSOoVHAhalyA9+kNWtQYpCqKa0tRpwJIazAWZ5A6iLuwUYqvObbdm45a/M7p
         xyRA1fQGuSHNAhTUdNAc3u+dpr1bkXDhAyW08VgEpG+L+Iz5Qg/TtOiWbHprMcJEXvpC
         w8fdX2V6i4q5hvmshhBjG1PkmLgvc/tMeLzpBIVyIVHwEIeAP5DuuQtUiH4bARoW6Gek
         9JeA==
X-Forwarded-Encrypted: i=1; AJvYcCUAdUBfv1BWNfQKsIyzBQuSRs/jwU2C6w9uRB7vgkZ7aVqSpgcUPbY0H9yNW/tnCXZRlyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyzqdZChHjept3WfiuDIyzuBTWtfLUD63mcZeXgS5c9BkjnGQ7
	2SyBdDNsPDIMLCIv+pCXqwRL0b9EetQhrJXvhNJS0LOefoUnAcAY26pRt1PIjQB5QaU=
X-Gm-Gg: ASbGncuDTIyCQvnhBu9oSw1rEJ15B+mGD/eNutQipxeM6DFIIj0UWJGS56wAZdGQlsL
	iBF9fPvIbwNou6ULsK5oTYP9qRXLTN7oZeJKUyzk8Eh6i7avvZipuon+G/XFCT7xGbcAiZ3kPca
	WChonNF/yBUXcRe+rMveMsoEmgDf4IjE0uUUJCJKt96DtRk89sbDiKw1V2vv1eaEl65jBiO/aXy
	svCUL3QpGYLyLyaQR+nu4eYpIYlhRD0sm7U2NrFww1BXUVTdlScBO54s341DCqJDYiYN/FbtpjT
	MBG8CJ7nseAcXo3yxQCT5MkAqPMFqQ85uuZqDBTnneYUyWDsoILIn794E9ktdSUzfp+TyN1sW/r
	2X16bxarUdmIphXPfZD+7li9wgR0zSx1ywv/xsUzvQAF7i98pxkMFrgg/Zc/pWJt8jCjJ
X-Google-Smtp-Source: AGHT+IHPGap2dCYWlJBOrKoIpqhzx0hg0+yPsTujjfLJBGMgHZWbcQURT6fJPbtpQWPkXIn9zn4B6A==
X-Received: by 2002:a05:6214:ca8:b0:747:b0b8:307 with SMTP id 6a1803df08f44-747b0b805a2mr108386976d6.26.1757521392357;
        Wed, 10 Sep 2025 09:23:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-721cf6d6cffsm150161886d6.54.2025.09.10.09.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 09:23:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uwNbC-00000003tad-1XQm;
	Wed, 10 Sep 2025 13:23:10 -0300
Date: Wed, 10 Sep 2025 13:23:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
	Leon Romanovsky <leon@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next 10/10] net/mlx5e: Use the 'num_doorbells'
 devlink param
Message-ID: <20250910162310.GF882933@ziepe.ca>
References: <1757499891-596641-1-git-send-email-tariqt@nvidia.com>
 <1757499891-596641-11-git-send-email-tariqt@nvidia.com>
 <aMGkaDoZpmOWUA_L@mini-arch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMGkaDoZpmOWUA_L@mini-arch>

On Wed, Sep 10, 2025 at 09:16:40AM -0700, Stanislav Fomichev wrote:

> > +   * - ``num_doorbells``
> > +     - driverinit
> > +     - This controls the number of channel doorbells used by the netdev. In all
> > +       cases, an additional doorbell is allocated and used for non-channel
> > +       communication (e.g. for PTP, HWS, etc.). Supported values are:
> > +       - 0: No channel-specific doorbells, use the global one for everything.
> > +       - [1, max_num_channels]: Spread netdev channels equally across these
> > +         doorbells.
> 
> Do you have any guidance on this number? Why would the user want
> `num_doorbells < num_doorbells` vs `num_doorbells == num_channels`?

I expect it to be common that most deployment should continue to use
the historical value of num_doorbells = 0.

Certain systems with troubled CPUs will need to increase this, I don't
know if we yet fully understand what values these CPUs will need.

Nor do I think I'm permitted to say what CPUs are troubled :\

> IOW, why not allocate the same number of doorbells as the number of
> channels and do it unconditionally without devlink param? Are extra
> doorbells causing any overhead in the non-contended case?

It has a cost that should be minimized to not harm the current
majority of users.

Jason


Return-Path: <bpf+bounces-35655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB47093C7EE
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 20:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F05A283852
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 18:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556A719E7DB;
	Thu, 25 Jul 2024 18:01:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3736B23D0;
	Thu, 25 Jul 2024 18:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721930482; cv=none; b=q8Ce0LUNyjw7Y8HbMrjemUughn2LW3AF/jJqOLUY4xALBhXXSvH/1NteDyI/1ZP0QUuxYAPtCCTnqJgGB0mRfDtafva+ngwUS2BSYPBmT4rH7jgQbIs9vlg+oJXFJLyF4uGoPxZc6skVodI96aKsPFHCxqkbEh+f78B4PRpwGm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721930482; c=relaxed/simple;
	bh=iH9vl7q5kH55HILOIVDAxx38kfcD1ii9MGjPYepeAl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwLLY5O8fvCHg/dkeVujQtrHMlrH2wDGen+IZMn6tRBFRNUgqBv+IexwkVNB2HhuevjmHXYCcruu11h20nNFz1/nKJT4+zevqzmuiOFCL/Wz2ow5mneoO6JETv2Qw07A+6xNEXjE9cmR+spiUxTBRF01K5ZODD4drvDmaDN6mxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fc49c0aaffso10093295ad.3;
        Thu, 25 Jul 2024 11:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721930479; x=1722535279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/OZaqwa9tDtUWYU0+YlFrjs0e/nmxV4DhH2nuXeMEs=;
        b=iJ8UYYsfDaFPgrBaUwqvE9f47f0AYLzKmWyDxbgWYTtQtMvDC8P/Yu9HzsgnxD5ltc
         V3BRabAqO5dU7Jrp4W9g/exXMJ2ROgw8k63NY8zgiqauhyi4+K37E5PQlva07Irb+NOj
         qF9mCBST4hzvRSyk3Yzkaemdnz52M3V4LI7VbrCRIoqedP7ENz4wI+FMz7mY5EUTMlIA
         /mTqMGO9CtIOn4jHByogQwKD7HntN35+G9VcuwZC+5ARYHg9eMoZ/dlpfE40lbE1VH0k
         BIW9g+Q7gqJSqI9h8A6CezpWL+gAfGoZbyl5da6IadChHIt2wegTdtXv6mGZiZu40cff
         CwEA==
X-Forwarded-Encrypted: i=1; AJvYcCU+sZBN3DxGaY1CGwWfEChjgrBuKdnJwOUer9uIMaTt0pZjq1NRVcKvvBiT7SsC56bVv18Q3OTElSEzTxu0Ya+1U7wt0zwe
X-Gm-Message-State: AOJu0YxflgaEckRPrKW+x3rrJRQ39z+AAvNcn4ucidjDEP21Wpf9v4Pi
	c3qyrEKfhV4FDt1/9yessXwoOxfpuLmWD4jg2acKZ6IZOKOYqBI=
X-Google-Smtp-Source: AGHT+IGRk9TMa8fDUbWNAAWfK9ELCceNe8aMmMY5DQo9zgwtIjgKeNRKjeny+sry1eRSIDStSbcD5A==
X-Received: by 2002:a17:902:f54f:b0:1fc:287f:638 with SMTP id d9443c01a7336-1fed920a7b5mr24667845ad.13.1721930478735;
        Thu, 25 Jul 2024 11:01:18 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f2b80bsm17042615ad.205.2024.07.25.11.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 11:01:18 -0700 (PDT)
Date: Thu, 25 Jul 2024 11:01:17 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	jolsa@kernel.org, Julian Schindel <mail@arctic-alpaca.de>,
	Magnus Karlsson <magnus.karlsson@gmail.com>
Subject: Re: [PATCH bpf 3/3] xsk: Try to make xdp_umem_reg extension a bit
 more future-proof
Message-ID: <ZqKS7QAH54vTnJ2z@mini-arch>
References: <20240713015253.121248-1-sdf@fomichev.me>
 <20240713015253.121248-4-sdf@fomichev.me>
 <ZqEcAKWCDp6lyaC9@boxer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZqEcAKWCDp6lyaC9@boxer>

On 07/24, Maciej Fijalkowski wrote:
> On Fri, Jul 12, 2024 at 06:52:53PM -0700, Stanislav Fomichev wrote:
> > Add a couple of things:
> > 1. Remove xdp_umem_reg_v2 since its sizeof is the same as xdp_umem_reg
> 
> So thing here is that adding __attribute__((packed)) on kernel side
> wouldn't help because we wouldn't fix old uapi with this, correct? old
> uapi would still yield 32 bytes for xdp_umem_reg without tx_metadata_len.
> 
> Just explaining here to myself.

Yea :-(

> > 2. Add BUILD_BUG_ON that checks that the size of xdp_umem_reg_v1 is less
> >    than xdp_umem_reg; presumably, when we get to v2, there is gonna
> >    be a similar line to enforce that sizeof(v2) > sizeof(v1)
> > 3. Add BUILD_BUG_ON to make sure the last field plus its size matches
> >    the overall struct size. The intent is to demonstrate that we don't
> >    have any lingering padding.
> 
> This is good stuff but I wonder wouldn't it be more feasible to squash
> this with 1/3 ? And have it backported. Regarding the patch logistics, you
> did not provide fixes tag here for some reason, but still include the
> patch routed via bpf tree.

SG, will resend this against bpf-next.


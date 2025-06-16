Return-Path: <bpf+bounces-60769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6F4ADBB89
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 22:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EF72176A02
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 20:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B951D214812;
	Mon, 16 Jun 2025 20:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOS1qmqF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFCA1FAC4D;
	Mon, 16 Jun 2025 20:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750107154; cv=none; b=k4QamR4B+P+rGW7oHpsGxJpuS9kGCqUscxjEBVwSyIL9EzNIIdAbBLHDdXsc7qXqWlIX6ATDa+7v9ZgX4z4yQoWKg5gAXySTHutA8cAhj1W9xtYALxnAOMPGOeM2LjfL9Ps/K6e+e6lbkMdDQGskpSyR//33AX9n2VsI7prZa+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750107154; c=relaxed/simple;
	bh=/QPXfKttFjUhg22/E4OyijBaAwE9LIOKJXwgi2S01bU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXFdS+1EqxQNRnWit14rWZEM3iGZxK1DSSa8dCrbNx371p7V8KF4TsVNgHsq8QWWEMWPhquzBGYxHvX8PW7MSVw6wTULK7jw2YAYODx/C1BPTsBRj8tQlYGNPh4eXEjMzfqcZQ8Xk1CmmQVZBzqPaqrnfFUBfl22arm7Lnexrs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOS1qmqF; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad89c10dfabso140637966b.0;
        Mon, 16 Jun 2025 13:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750107151; x=1750711951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MjHD7ImHqgaEg0QySeT0KO/CLSf7LriRa1vYRjxGumo=;
        b=XOS1qmqFmUcUiw1wd7Ya933Ri7ekdmFmN8l6GHfPBkggNb1JbbZ+5/l7xIT0R9Q+TM
         I2/RYOZI/Fy/vsjVIF24PH/kHlZZpAtF7fs6A/3bIli5EO8injwK5H6SecQFvGpruInE
         fcW130JrUaMVVWWRxnmWtF9wxlz1m3jZdcACJ/E8q3a4fUaSe5URErDyMMlr3/oBB9yU
         9U/5rv43pCD0GPJU0Otzf5XaubNw8BCpNy3ZM8hPzXdhg18+o0NcuD5RV8fD7Gnx4+Y9
         c3OVmMYX80vdk4mRC+X4eW+Da3Xl+9f4oXOUTxa3ufnq7VlfbLcoP+qbU1BVfqnUua/Z
         l3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750107151; x=1750711951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjHD7ImHqgaEg0QySeT0KO/CLSf7LriRa1vYRjxGumo=;
        b=JruoOzC6kxsanAOjynUVLiONVCotcfitqKpu77DZ7JfpCHRC20wS80YX/h+/HUQbXf
         WASdoM8xPmkEWSK7tZ2ftHO7nW6iuQFMJQwKQ+NxpdngDMG0H0r30R+MvxH7CrYJkq3I
         Al3sNyjsSY4x2tgaL2VfALO6E8tJWaWJlVA6uvtkKkMloRICt1v4GKP2fayWGEsNmdt5
         Fat0LGUJzPAeZrLCo+GwzrNDv/GlBtuHHVe0SmuHlqawjKM0IJCJhKrHr0kW7+tkrtV7
         oY0REavt1fGUpeT0V8ZhUMkvOyKlk/Nh2/iEHWAHcTmog+1SGwb9w0ck9QSvNAx0Mlxn
         qxqA==
X-Forwarded-Encrypted: i=1; AJvYcCVFM8hU3BvKLk31cPOpEW+GDd5nHjSxnqBGN+3nQ2pVdywD6xMmk2tHuCca0k2ZfNojwPU=@vger.kernel.org, AJvYcCVgc7lyDaN3cwdIfmgCKmBb3Qw37SJCnKnzeERkqsC2WGZ9FbR8ynSWE++qDnTVzsSgONaEfX39iyFyFuPm@vger.kernel.org, AJvYcCWlC3kkqjKiXEBziWrVLu5Ynt8XCvA6sEYBaI6/g0Wo67QQtJf3QU6V8EVLSBo/AJt1T8mVuQBQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv7YPxzqlj9IJVoslYPFSaZ99YDfo1ImgjIWr2A5Wx4Us7ETcB
	mkbWT+k4dePVc5kFfYDJ6nQ2mLhMyi/yBP7jE+29FvhKM8P4RJmxDX0k
X-Gm-Gg: ASbGncvU58TrFBhFkkrgtKQsthg65H63o8AbHG/SRVsfOEo8TvR8krwTAN3fmmMyG+X
	Gx/wvXlHTYquNn30S4qykcdmmZaUbgSDpj9ElG3OHj6tqcYxMm0Ld1OVhxgPaat5FibH7bTLxY2
	H3RHQihll2uNgx2I6NmfSLVGr7YTvDz6wWflysUUwfv+gGJH2vhslE4HOqRouwYX+gLX8gbSNWA
	tmcW04Aq8+uGIEnXuuyPvW0XDHNcqplnl4OOQe90p12u579rDQhbMKAIdn8RZ7KRtkMYj9rX7VF
	Px7NYfnp0iX24cYCrtkIgNwczro+DXm31lms2M5PbIsQmgklO4/96lhJKdZ/
X-Google-Smtp-Source: AGHT+IFH/SSx7c8PUrit49w4s+in5qNAffBYzMPwVtXx0HldiOhTr26CVPqogKFnR9YNJ3L1h9lIeg==
X-Received: by 2002:a17:906:d555:b0:ade:3372:4525 with SMTP id a640c23a62f3a-adfad502daemr381962566b.9.1750107150465;
        Mon, 16 Jun 2025 13:52:30 -0700 (PDT)
Received: from skbuf ([86.127.223.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adec81c60f1sm730344566b.60.2025.06.16.13.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 13:52:29 -0700 (PDT)
Date: Mon, 16 Jun 2025 23:52:27 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Robert Cross <quantumcross@gmail.com>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: dsa: mv88e6xxx: fix external smi for mv88e6176
Message-ID: <20250616205227.2qmzv2fsbx6j533t@skbuf>
References: <20250616162023.2795566-1-quantumcross@gmail.com>
 <3c5a8746-4d57-49d5-8a3d-5af7514c46b3@lunn.ch>
 <CAATNC474tcoDeDaGg1GKbSAkb8QBT9rcHrHrszycWpQwzU+6XA@mail.gmail.com>
 <ad17b701-f260-473f-b96f-0668ce052e75@lunn.ch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad17b701-f260-473f-b96f-0668ce052e75@lunn.ch>

Hi Andrew,

On Mon, Jun 16, 2025 at 08:43:14PM +0200, Andrew Lunn wrote:
> On Mon, Jun 16, 2025 at 02:22:43PM -0400, Robert Cross wrote:
> > According to the documents I'm looking at, the 88E6172 and
> > 88E6176 both have external MDIO buses. I have brought up
> > a board with two connected 88E6176 chips, each with a PHY
> > that can only be managed with the MDC/MDIO_PHY pins of
> > the 88E6176s.
> > 
> > After applying this patch I was able to successfully manage
> > and control these external PHYs without issue. I'm not sure
> > if you have access to the 88E6176 datasheet specifically,
> > but this chip absolutely does have an external MDIO.
> 
> You are not understanding what i'm saying. This family has a single
> MDIO bus controller. That controller is used by both the internal PHY
> devices, plus there are two pins on the chip for external PHYs.
> 
> All the PHYs will appear on that one MDIO bus controller.
> 
> The MV88E6390_G2_SMI_PHY_CMD_FUNC_EXTERNAL bit is reserved on the 6352
> family.
> 
> 	Andrew

Is there any addition to Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml
that we could make in order to clarify which switch families have a
combined internal+external MDIO bus and which ones have them separate?
As you're saying, this is an area where mistakes happen relatively
frequently.


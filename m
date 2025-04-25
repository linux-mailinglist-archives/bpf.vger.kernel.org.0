Return-Path: <bpf+bounces-56661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC8FA9BC71
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 03:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5FE317681C
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 01:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9187E145B27;
	Fri, 25 Apr 2025 01:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="OWV7qZ91"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D733595B
	for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 01:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745545128; cv=none; b=RWDAYrAbhuEm1O6rOmchp4cGWlD/DcmEmMKNvDUbchQ3a4HhzOgcmm3AWMKzqwsiMZCB6BU18B5LtXQkt5+atWhXShc4GqAxNd77pmzpCzscpHh7zl4uEcekQcehN4LJlkJVcp9ZDvahkUkE2cB6BBCAHtRhw68LrmrpL6GiM10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745545128; c=relaxed/simple;
	bh=yhOlAEzwrF0aCAFf+JgQeNbbx3sk62jQPHuNFSORMuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQ1O+rwvPFMo+8buFNMXs+6oxfJyuqx0hqEy3qA+ybCwOAw3h+8H1vs7bPRdHGMzNL8o1Ahnx2MsYMZpLFCGJXwnSNX47RpoIO2laO08RdOdaBvVEXKP6t7YxH53R7C6IZ6OnZRroPq5fEHG2YBc8lzLVZjldVjRC9eS+0sz0qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=OWV7qZ91; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-224019ad9edso24348615ad.1
        for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 18:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745545126; x=1746149926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KSqYScKgytFmXzzaTTv95GQdkzPtmJIkcWKivQdfd7E=;
        b=OWV7qZ91iqDuT+nIndMTN3+mLDvFqvm0SPifYoT0vQYv6e23u7mATuF35l0sbtfaSh
         DU4aAksXg8kTxuXwwZUmp+NimBiZo4FM4b8iadkqnYuayNakFFl7Wcpo6xN7e4Y/mRb9
         GpIY4wlgGvsZaRjRmgqZVlA631Kso9qMhnLf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745545126; x=1746149926;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KSqYScKgytFmXzzaTTv95GQdkzPtmJIkcWKivQdfd7E=;
        b=kPpLgmr/gl37qbBMllKAsrcxxQean3UthKQEExBXg9U6MdRBGw+G1xordanoX8G5j4
         TbO1lA/Zvvi9TS7nUgmMKoxDcvueIKOJhtVkz/TLUu7ETxeBVCuIq5iLU7JZ4Y7dHibb
         W6hXSxKP3/8zCbgcpYOt3oI6WRZi2n7maM3MbzvUjyokkghnUPX40S4dwT6UkSGom2xW
         aN8XIaOsSfCIRjyROzv7nCccCLbuLi8rqXQPxEordB34pK1y8X5PdDoaN7wtWGiWe/xD
         L2OX+mZUKuudcUotkF60NXX029zVd3JKJS+d7Ik5yHRx1XFPxo47L2wUQUOu7VboOhdl
         kJGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsXwyikuicb+iBXMw4L7wdMkTS0MMQKl+omMm8uPo3Rt7qpGC3oYmBGffoXRZ41WqXKl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiFFolG2d/4Ukk0iaaJ/qrc7HcU4mer58LfEanTSlRarU7J5XY
	38TQ5r35d5Q+etLTqMZrM0pqWptm/n03yhp6LLvJ1Mvk4fxlw28XO+HsqjeCtQo=
X-Gm-Gg: ASbGnctvARl8tDIski2z4FebY/DSaMOeapz10UL6MtbPQfr1Wh7UOE9X/VG3Ksya7cP
	tcBCnXCC/1s7kGWJ6aw3urrR+eEsbLd0QHCt7ixravaraEgeIbckHFDg97UuoTHXfx6JUXFg4XN
	I71PFO1Lyhlh1NV+2rrSEf13bmipbeldHdSuCiUJ1AX9Rv4/4TCFzb1tgJdCJnEkdsG0SappprX
	nsbibd685gnQLCBZbWlUnbStGtFKlhewq9DchExMQCURfPS6ioBmZcK1oan8YtmcnMQ2Sd+Cy/h
	4A7gtpzRWCnbSm/JTrfcjH7dwsD36niUIl5U4qa+ly2bSM/HXPd0pRoGMsTsN9XW+1MI5jT5Qw0
	UdeeIxdGm7QfNhcmcHw==
X-Google-Smtp-Source: AGHT+IHtyY/Uad+Dw4YYDrHqlH0t+QCAu2yareuHTx9iQsFmiei7axjBQ/X+aTouMtAFce8aEB6OZQ==
X-Received: by 2002:a17:902:e84c:b0:216:644f:bc0e with SMTP id d9443c01a7336-22dbf5efce5mr8556365ad.24.1745545126067;
        Thu, 24 Apr 2025 18:38:46 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db52214ebsm20612495ad.246.2025.04.24.18.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 18:38:45 -0700 (PDT)
Date: Thu, 24 Apr 2025 18:38:42 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, shaw.leon@gmail.com, pabeni@redhat.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v4 2/3] selftests: drv-net: Factor out ksft C
 helpers
Message-ID: <aArnojKzMWKS1ySR@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	shaw.leon@gmail.com, pabeni@redhat.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
References: <20250424002746.16891-1-jdamato@fastly.com>
 <20250424002746.16891-3-jdamato@fastly.com>
 <20250424183218.204e9fd1@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424183218.204e9fd1@kernel.org>

On Thu, Apr 24, 2025 at 06:32:18PM -0700, Jakub Kicinski wrote:
> On Thu, 24 Apr 2025 00:27:32 +0000 Joe Damato wrote:
> > +++ b/tools/testing/selftests/drivers/net/ksft.h
> > +static void ksft_ready(void)
> 
> > +static void ksft_wait(void)
> 
> These need to be static inlines.
> I'll fix when applying cause I think this series may conflict 
> with Bui Quang Minh's

OK -- if you change your mind and prefer that I respin to save you
some cycles or something, I am happy to do so.

Thanks.


Return-Path: <bpf+bounces-60838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 323F8ADDC1F
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 21:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DE8F175022
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 19:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5E725A334;
	Tue, 17 Jun 2025 19:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="f24dP1a6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E6D215073
	for <bpf@vger.kernel.org>; Tue, 17 Jun 2025 19:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750187866; cv=none; b=eUmf6pXFzpe47alqyu34nyLtOdmhuORxMfyGTYH7SSQm3Z6a0uLS+OcBKHT5/TCq/ltRT1hxuIQ7XY3B88+ZP6kNZDrSRKUcSGtAvfJF0zZlf2uOHzCtZ+tgxvqM6jBDJ2sOQZR8d7O9toQzevCmCwDHGCcceptawIlXDgrKPus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750187866; c=relaxed/simple;
	bh=1bP6rJEA8wFohueF5jqDh/zAC0rZ53XrMgdF+00Sxw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVSz6Cu6sqlFdoUkh6Pf+qIqqnUiUr3BUu1MhvsX1qH7q7E4RFRp097iNNnbLD8LPikcQDL/Y/deqzyISf4vJ92ug/S+qS3ul2tcMGKm85XKXDFU8BIq910En3EWqlIjrSheIkXADHKpwLzQpKigaeQsHhO2OHPI7TxFNETkEqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=f24dP1a6; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-452f9735424so20389715e9.3
        for <bpf@vger.kernel.org>; Tue, 17 Jun 2025 12:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1750187863; x=1750792663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvfQMwCx3aaFLH1gBYzFPVa5Y0KFbLLTPkKAtJ7FGcM=;
        b=f24dP1a6dfCFYcJJz9zsm/qxBai4Kp/6CWp1u6yb5AR3BJAqSBmKihBlsObpDAmyBK
         rH2EN970kST+6qFYVH8eSayc1z9Tu8gTR0nDMFCD5iZLQHxwwpHRcn546psZp1H3PDL/
         TsfRJgvSN+Kwgpekvg0HzFVmFjshdTGkU9Czhgs6HpcL21QH95DKcRfVxIYaPc0vFbLi
         2l7WhVpoNH6weLKZwwURN9Ixny85r4mYVs0p13tGQDQkBuNosxIkSCkj9bFuWWVqx5+l
         2i0SqJKu51oGLHO+Kfx+V6NjhIu3nUeTdG4k6e10E6W1YVwqpP14fcGRTqeK2MO5EFWc
         zKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750187863; x=1750792663;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uvfQMwCx3aaFLH1gBYzFPVa5Y0KFbLLTPkKAtJ7FGcM=;
        b=KaqsmukCxRdkUxISaUCKaNQNlZvV4hPfB+9I5L4vvZZRjyTuro8xEdt/hE2GshQAPE
         5o2coPtUEyitLPS6Yd9blH6f2B7oH5skDyv/8EiimijRMB/yfCrKw6RRzPpBerXbz5YD
         QpvGiC+S3Sq4KCU6wJpxI6JcG6te+vNZwUSrjhFGU5vEgiNL7RQCSXp6NsVb37yIzvPr
         7f2tuuQ7DLziIPjAVpuWIVPdPHoCXLP1taFr1X4uki+IA+nEVRxwJexSSctqhrNq54kl
         wykYIcTIqE7MLK28v0zKZJVrcqJDrQ8Igor8Xj4MbKMilOpfcZcin0AgbjCd7khbmOkv
         sTVA==
X-Forwarded-Encrypted: i=1; AJvYcCV3tKnzs6Uq7C2ad8XJK3BS0oJM0rq5CA9Cjn7djBFXQxhDS29MRoGucefBkpbV4qSaV5g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5jeZOA8S7uHnY1wtX/W6EaK4a43Z9jeZybjLySZ+J8UmF6MpI
	HauF9xdA/TfW+TPAX7NL8crhGLZmO10K1DFDCh8oZ1/jMfR4qSRttdtfiKyoLq41pQI=
X-Gm-Gg: ASbGncvgg1M3nl/bp+44A0ofDB5CJmg0xqaZ2Gc9Ay6FrSQPJ+8Y6P8LYjz49qknH65
	DXSczfF19BWpjApv9aKhD7j+ptiYosDEKMhBMe9qptjBPiH0jkAjM9K5UTkZG3x9sdIv96OI3+a
	k5l8bQSQg/GJTpTZclriH/7XbRrvEbes1202pV0h80aWz2kgtMVd/vnKuEbumOpw85Fha4Y2pWv
	w/EwwYteuvb4ADdr5VBNUZLCROvg32slp5yOwxERTyRYZ2Z54puVn+ORrNcrkc824IHsGE4u+ug
	8vzpu62CB2e2T5Gqf92WY/jfMMs3tJuujt+V9skQItrrs5240190IQaK9J07XAcFU2U=
X-Google-Smtp-Source: AGHT+IH6QEm50PmO7DOXT3ObwZddoTuvRG1KMDkLrrDO70vSNhxTbXEd9HYKRQhDrOpboEzGDHDmKw==
X-Received: by 2002:a05:600c:1f10:b0:442:e0f9:394d with SMTP id 5b1f17b1804b1-453560d2fe9mr22881915e9.24.1750187862956;
        Tue, 17 Jun 2025 12:17:42 -0700 (PDT)
Received: from MacBook-Air.local ([5.100.243.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532dea1925sm188221825e9.12.2025.06.17.12.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 12:17:42 -0700 (PDT)
Date: Tue, 17 Jun 2025 22:17:39 +0300
From: Joe Damato <joe@dama.to>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next 0/2] net: xsk: add two sysctl knobs
Message-ID: <aFG_U2lGIPWTDp1E@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
References: <20250617002236.30557-1-kerneljasonxing@gmail.com>
 <aFDAwydw5HrCXAjd@mini-arch>
 <CAL+tcoDYiwH8nz5u=sUiYucJL+VkGx4M50q9Lc2jsPPupZ2bFg@mail.gmail.com>
 <aFGp8tXaL7NCORhk@mini-arch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFGp8tXaL7NCORhk@mini-arch>

On Tue, Jun 17, 2025 at 10:46:26AM -0700, Stanislav Fomichev wrote:
> On 06/17, Jason Xing wrote:

> > >
> > > Also, can we put these settings into the socket instead of (global/ns)
> > > sysctl?
> > 
> > As to MAX_PER_SOCKET_BUDGET, it seems not easy to get its
> > corresponding netns? I have no strong opinion on this point for now.
> 
> I'm suggesting something along these lines (see below). And then add
> some way to configure it (plus, obviously, set the default value
> on init). 

+1 from me on making this per-socket instead of global with sysfs.

I feel like the direction networking has taken lately (netdev-genl, for
example) is to make things more granular instead of global.


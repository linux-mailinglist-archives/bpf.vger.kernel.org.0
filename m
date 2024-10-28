Return-Path: <bpf+bounces-43320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8949B39D5
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 19:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 274021F221AE
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 18:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574451DFE17;
	Mon, 28 Oct 2024 18:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="YDxXyY6v"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E896F1D7994
	for <bpf@vger.kernel.org>; Mon, 28 Oct 2024 18:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730141973; cv=none; b=Kpp2PYm275Ev7LcfGnSJ6pZmwiH3oWBYt4WZmzBOF4cjiwr2tJkuf0fOZCgaXqBuW8aPxNww6j1Y882f0NjEAg2VP8bcO8JLAsIyKD7GE8wN8+Bf1rTYXAaL7PFvFYGyAoEHOShV57oF94YLs2+7P/AuQAl6QH1dbP87lFJfBYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730141973; c=relaxed/simple;
	bh=f7jCv518i3r2DmaD2jR4yg1phCBC6+krsahdbsKRe+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwG7FfzjdjYrheAoPKz+RwQ+CVh9NX3F2LMv70V4je/Y51TnSbhEOyQOp8VGQyQn1Li7cUlxTgZ6dSAR8iiwDSdaph4fEi6XCsmiQEgvIpn6hgBAxGpe0LpLyuIw+2owgPbv3bAbACOBlRgUc5nY/G9bJmrwS+6Bqi98x/CqHS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=YDxXyY6v; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20ca388d242so41438785ad.2
        for <bpf@vger.kernel.org>; Mon, 28 Oct 2024 11:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730141971; x=1730746771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qeCldZNN0uQOZMpedqS7Oua78AnyCHE6/huQVyFkvbY=;
        b=YDxXyY6vXCC9BbgYD5Jr8qrdQe9mPTWj90+kgVZ1KVfX0fVSEl95U7goCVw1wjSzUu
         VWjMUQnnlPAs5uIPIV4FD3/miDd7lXPpOirJbl6X6Lj0qRS3AP26VWTIh4ig592R40cC
         K0qIhI87pReApToH/HKCVgLvz+AqFB1TrckQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730141971; x=1730746771;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qeCldZNN0uQOZMpedqS7Oua78AnyCHE6/huQVyFkvbY=;
        b=qwM/SWEcwtkAI5j4NGOZxgUH41I3Tyh7XWBrPulKV8z7FbnWaYGIqNol9wOfS0Z3TZ
         pyxOlvr1Kh8vGd2eR4+J8L/0GYnFZ7q91k0xoXORa6kc9MMERrW+y8I6vVwdQ4+xEjMG
         sakybTT2XfxGj8+6ynkznQWFwGJ4KnuagEpel3+DkrkZieCsorVKo9oge83Bc3X1/nkV
         T+Qke/5s7ky1PMsUlHATWqkdQRWElQjsfNnVXrpmpk/boKcmay+mtYipLOSlQI/SMSqU
         N3d947BmL6Qmo6tczvvLsT13F6djQ+sChMNjM4Mk1XypsdruBPaAowIYXNN6RLzGeBz3
         J5cg==
X-Forwarded-Encrypted: i=1; AJvYcCXB8myzWF1blfBmifF9Xl9eSiULfjwQ9VYt7jsx7/hAGMfh/zAlUzLeNQ2vCCARIypoHts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0H06M1eZIl4SpH7cUvD7o/2GojH+BoLZCV1K/eUBKDxt2vopN
	xP99d4fzMYQ4+/pbtB4L5A2+8ZK1fBoyxAk3rRKaj2qXizGYk6HVb5Lih5gfurU=
X-Google-Smtp-Source: AGHT+IHUdnN8IaS4uaqWrdTjg4xrewbchje8khIGQ1Drr+enMS0lfIciArKhVhl88XNPN1+fZdpMbg==
X-Received: by 2002:a17:902:ce12:b0:20c:7898:a8f4 with SMTP id d9443c01a7336-210c6ccfc15mr125345945ad.60.1730141971225;
        Mon, 28 Oct 2024 11:59:31 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf434adsm53854335ad.10.2024.10.28.11.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 11:59:30 -0700 (PDT)
Date: Mon, 28 Oct 2024 11:59:27 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"kurt@linutronix.de" <kurt@linutronix.de>,
	"Gomes, Vinicius" <vinicius.gomes@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>,
	stanislaw.gruszka@linux.intel.com
Subject: Re: [Intel-wired-lan] [iwl-next v4 2/2] igc: Link queues to NAPI
 instances
Message-ID: <Zx_fD72US_Jhq1oL@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"Lifshits, Vitaly" <vitaly.lifshits@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"kurt@linutronix.de" <kurt@linutronix.de>,
	"Gomes, Vinicius" <vinicius.gomes@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>,
	stanislaw.gruszka@linux.intel.com
References: <20241022215246.307821-1-jdamato@fastly.com>
 <20241022215246.307821-3-jdamato@fastly.com>
 <d7799132-7e4a-0ac2-cbda-c919ce434fe2@intel.com>
 <Zx-yzhq4unv0gsVX@LQ3V64L9R2>
 <Zx-1BhZlXRQCImex@LQ3V64L9R2>
 <529d08d7-94ee-43da-904e-cf89823a59fb@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <529d08d7-94ee-43da-904e-cf89823a59fb@intel.com>

On Mon, Oct 28, 2024 at 11:53:55AM -0700, Jacob Keller wrote:
> 
> 
> On 10/28/2024 9:00 AM, Joe Damato wrote:
> > 
> > I see, so it looks like there is:
> >    - resume
> >    - runtime_resume
> > 
> > The bug I am reintroducing is runtime_resume already holding RTNL
> > before my added call to rtnl_lock.
> > 
> > OK.
> > 
> > Does resume also hold rtnl before the driver's igc_resume is called?
> > I am asking because I don't know much about how PM works.
> > 
> > If resume does not hold RTNL (but runtime resume does, as the bug
> > you pointed out shows), it seems like a wrapper can be added to tell
> > the code whether rtnl should be held or not based on which resume is
> > happening.
> > 
> > Does anyone know if: resume (not runtime_resume) already holds RTNL?
> > I'll try to take a look and see, but I am not very familiar with PM.
> 
> I believe the resume doesn't hold RTNL, as its part of the core device
> code, which is not networking specific. It shouldn't be acquiring RTNL
> since that is a network specific lock.
> 
> I believe the code you posted as v5 should resolve this, and makes sense
> to me.
> 
> Thanks for digging into this :)

No problem; sorry for all the back and forth on this one and I
really appreciate your patience and reviews.

Thanks,
Joe


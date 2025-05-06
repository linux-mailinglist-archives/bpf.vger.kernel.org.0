Return-Path: <bpf+bounces-57480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39359AAB86E
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 08:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE1E54C4AC5
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 06:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209C9297138;
	Tue,  6 May 2025 04:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wyzwk1q/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BB433842B
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 02:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746498178; cv=none; b=pLbf81dwLTGAweFhgf5CfbDZLtgNhWqSzoVZzy4nc1smt1r0qQE1mdvlHWR7tVmFgEkV902fSNZ0s775TlAkwkUZgPr6rI6sZAzZ28ZN37raKROjQkUNTWNxqeCabM7mLnzsZuHeS6L+MJQWH+tJVB2K/DIZMnrkl2RUIkxkZ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746498178; c=relaxed/simple;
	bh=CGwm+uClyM68lDdLpAKcYoogMH1nK0BFJ9x04hZGAXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLgTRijo7EJDzmfFiMFWC/NsfwZpdVIUCGE5XhrzV1rsGbXZGV2cgak/DN1c7/eghaKyNO0dLZIJfwkoPXMJCRCb7iQDbh9wESloPEyL1+yEnpYEILodAWcVZsixCOPi4ts9KGIVjhulcf4xBZDBTcL/qHDmm6hovzWiUqQdDT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Wyzwk1q/; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-736aa9d0f2aso6879926b3a.0
        for <bpf@vger.kernel.org>; Mon, 05 May 2025 19:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1746498175; x=1747102975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wcToqMHkDpTdLEXjKroWxHP95+TmEN3Q5daky/KBWzI=;
        b=Wyzwk1q/ckeyL4Lg+Vc9WZ6BEhaouRchAGmJ2B/E8N9RA7Oy04VPw9gLUcbTDV9lv6
         wiYMzlQ412vCOgr67IyUIX4MHRVtZmsb7/N15J2bniJP9psvkTKKr5WY8uAJGDxB6NUs
         l5/USR3LpsSlsfAU7RSETB3i2hv7ahOg+kr94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746498175; x=1747102975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcToqMHkDpTdLEXjKroWxHP95+TmEN3Q5daky/KBWzI=;
        b=IgrEe3zNzfb25d7yaIbGCBfI/aKICcSwgzdPuejmqMkItOdvp9WTtXxC3XK1tb3dn4
         ajpOhztT91JYznxIgkBma8E+qqJ31NWkUQNHAt15EdReEPyf3FTMchXVyJdqigKZcozQ
         xU4waPKJI3tLfNRS/DXqjk9Kw0AAnqx3i9OlvmuBgGyUpYHSIGdUQ/ZZl5HIMBPWzMlJ
         I8vAjapAnOjfwZieN57fzKJ0qyU9+1f2RoUsKHi5is54R4+oUzdFw7XX4equbSt4XjK4
         As6/ndsbOTpRMxPUqmHEyzknznY07onVBRezlt+H5lkFlzTEtxPgUgGyb6IxM1b9nJPu
         g78w==
X-Forwarded-Encrypted: i=1; AJvYcCWIj09wiK9Xl3LxFtmjzdDZJz4cg41txM7KpfCbiBs1QqpYJ+w639R4ym0euf4HKmXSpDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzwZNq/U+0s+IA9BSlIlct9joGHyRptU4yM4yzhq3JEXUTu1g2
	Mw0LJ3G9GqdtsLK7IjRazq+mcRanvW6a/Rud8dgbm9+17QFikYXZ7EPKfs4nhPSNJ3jP35b7OpV
	JAA==
X-Gm-Gg: ASbGncty3hU6rY6kJuobL4l9rOyh+7BZWJurQpKT1OXkwQey5Wt3nSDhVNUFjaPy6bR
	YlPWZpayi1bGARAABTVORD5Z4G2jIPxSMW9ZXKDITvEkEa3eZO+3M27JBvE9CAwra6db1Kxfa8o
	4kVi8zC/+w3aoldXSFhlFpWDMG/Qm8qBoyjha2PwHQt/DPG7Mjm16ZECL3KkBZP5nzalX1c83a+
	wPX1KirChigU2YPp3b9xRigbRcMNpLoah+pOnV32qCrlWjkHZvzXaguk1gox0ZuBEZu/QXFzs4i
	xpHrHNKGhMBYMS1WUY2L6U6YwPwNLEUyCwYoDH/OYtaVVAX12XmEwaE=
X-Google-Smtp-Source: AGHT+IFc6wz2lLiTovWw/lmIDOLnGErdPqyw+m3UEoeaabqxUpsithWSUC6r2ammWN8skoKVjYaQ0w==
X-Received: by 2002:a05:6a20:3953:b0:203:bb65:995a with SMTP id adf61e73a8af0-211834a9d45mr2119227637.30.1746498175296;
        Mon, 05 May 2025 19:22:55 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:4dd5:88f9:86cd:18ef])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fb3b57e2asm5261813a12.26.2025.05.05.19.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 19:22:54 -0700 (PDT)
Date: Tue, 6 May 2025 11:22:50 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Song Liu <song@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: add bpf_msleep_interruptible()
Message-ID: <bianejll3uuual7ffytpuraphcgr4xysmnuapk74x3owx4m45c@vwxgbzkwkt5x>
References: <20250505063918.3320164-1-senozhatsky@chromium.org>
 <aBiJnR5MEL5hVXXC@google.com>
 <wzxhhoiczrhsosf5bkwqf2yypdrhgrm6wskiusfg7iumpgk7ew@rcegtieelqco>
 <CAPhsuW4Q7cHyMHemnLtoys6uNgd-tzKARx9gX177PimAEwpszg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW4Q7cHyMHemnLtoys6uNgd-tzKARx9gX177PimAEwpszg@mail.gmail.com>

On (25/05/05 12:01), Song Liu wrote:
[..]
> > + * unsigned long bpf_msleep_interruptible(unsigned int msecs)
> > + *     Description
> > + *             Make the current task sleep until *msecs* milliseconds have
> > + *             elapsed or until a signal is received.
> > + *
> > + *     Return
> > + *             The remaining time of the sleep duration in milliseconds.
> >   */
> >  #define ___BPF_FUNC_MAPPER(FN, ctx...)                 \
> >         FN(unspec, 0, ##ctx)                            \
> 
> kfunc shouldn't have any changes in include/uapi/linux/bpf.h.

Ack.


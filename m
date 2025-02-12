Return-Path: <bpf+bounces-51321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD6CA332D8
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 23:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8BD21889A40
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 22:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC122063F4;
	Wed, 12 Feb 2025 22:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="LUNIucAr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4A2205516
	for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 22:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739400319; cv=none; b=qlVv2HHxxqkLARjBc+nVWh5mFK56sBp+41FDnQRDAr4LcHMOhSs8C0FumDz/qI5YpXIv+w7oGGvCGLfJL2uP7tcNiakrOBW19r8tyu/US4GEoDDiiOU2N5+3sC0ERF2hIdoN9tfQIG0lZnIH6bpiJkET4bayISEBWm77kqrfJWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739400319; c=relaxed/simple;
	bh=TrYhj9YtDhjs2+zWIm8UW+a8Ijj+74m1trvWbyQOCSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKq3Cw7Yai7jk2U2SmQOWhEiSpJ0o7UNoiYWADQE7aHVBpdfDFOvP+kfEiMv329zQdl3pDzS73onnPOzi7AQCbVLSoPc7/Y+mqaZ7tIZIKs1HGoKJDZLFpTsWBUYS+FAjdLn5o0N3oS/G/FrlzEvCRSimOkm58FvCGgz86+dnNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=LUNIucAr; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21f818a980cso2579095ad.3
        for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 14:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739400317; x=1740005117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxmsI4n3mNC29jNhrwky8mt9Y2e3VkJ4dixbH6NADTc=;
        b=LUNIucArorYsj2QN+oCyqiEc2Od7dBSV+ZjPnevnjEjxbZhfKGMumO2ZzVzkBwu/Ey
         2lInL35zv8oPciwRZn/7czzNrsBg+nlUyMwCvc8zzgRTmklGBobSmcg3iOYgZdCCf16p
         1F3mY7XrLro9P7leQ6T6w4g4vxBH8hqzj8j+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739400317; x=1740005117;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wxmsI4n3mNC29jNhrwky8mt9Y2e3VkJ4dixbH6NADTc=;
        b=vx2gtOnvDSAX10H9hcgPBY11h/yCmuvnYjaN2Z2MzSVC0a3e1TCFU5vtOKG5RJO2+m
         rQAMm48bIQZh0Bz3poxOtUZKyArt/9rlAWBI8fmebLaMjXL2ytTb2pL3uVZ/4gN0eJYN
         enbVnmsGQHV/WNCn4L1QvFtAcCx8U5R2S9JLNjdUVcm6sUeaiByWRagAA3aIWc6Ly9lg
         dxgxABZr2viTR4UgNtAkLCyMRyVi59NIVMHB8Pspq0CBv8Ne0NLb4Q19+X4PEuuYjKsA
         UYVdUY3mqwJqY5jbNvdkkDQ0315Ef1wPJZK84y7JVFfGYsN67QgTiK755P5eFQuVwHpR
         XIVw==
X-Forwarded-Encrypted: i=1; AJvYcCWImh/MDdvczEAnF1vxdlq2WREpeotULg7Mj9KnbIRbUFvBtZFWGOpDZrrxdpYJIZ8p6fI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6eohMobTjHr6rC0iCgkLyC/JrRPdD8DglHHmnM10SqRCX4J1T
	93VmamncKzQU+v4aE0aorJO+K1L22m5ZBW0GFu89GWJnhzy4/v+AG3vL8gHoJi8=
X-Gm-Gg: ASbGncs0iBzoH0w1sygN9nNRGgrns3gCvlebFe7A1UgLtgLaDKQQdlYBAZMRN5pSIib
	3iFAh9whp3bXvTkdxCH2jj06kcYsKxYesuTjUGmhfy4ccdkSLGcT34Mt2QR8ihwY+oU/KPPscTL
	ZzFS79zQ+Kp8tkba/PnuABFVH//0oK62HgMnHl5BOcC729EZf7HjCByf+YBfOGwZpQd0X9DJy74
	n8fpnUDJKfNV3XMMlY1cqMDtYITX1OeOaUY4BVHyUXkxhaZf9NNrMggHseNy8i4rIif6TOdsXEu
	Ei3/ZbVvoRe6/EkY+GBnrMo2FeDaZeDELEY+fHsBIaioyyUzHJ769rHRmw==
X-Google-Smtp-Source: AGHT+IFUBiyhDYvXIFj3i8/1IXRfWTJGO1CJwO79pTr/N2oVci7/x1idO4rC9J9iW9gid4RM7SPniA==
X-Received: by 2002:a17:902:f682:b0:220:cab1:810e with SMTP id d9443c01a7336-220cab18355mr25527595ad.6.1739400316978;
        Wed, 12 Feb 2025 14:45:16 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55858d6sm541515ad.223.2025.02.12.14.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 14:45:16 -0800 (PST)
Date: Wed, 12 Feb 2025 14:45:12 -0800
From: Joe Damato <jdamato@fastly.com>
To: Stefano Jordhani <sjordhani@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Mina Almasry <almasrymina@google.com>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:IO_URING" <io-uring@vger.kernel.org>,
	"open list:XDP SOCKETS (AF_XDP)" <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next] net: use napi_id_valid helper
Message-ID: <Z60keJDOL_50cGbY@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stefano Jordhani <sjordhani@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Mina Almasry <almasrymina@google.com>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:IO_URING" <io-uring@vger.kernel.org>,
	"open list:XDP SOCKETS (AF_XDP)" <bpf@vger.kernel.org>
References: <CAEEYqun=uM-VuWZJ5puHnyp7CY06fr5kOU3hYwnOG+AydhhmNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEEYqun=uM-VuWZJ5puHnyp7CY06fr5kOU3hYwnOG+AydhhmNA@mail.gmail.com>

On Wed, Feb 12, 2025 at 04:15:05PM -0500, Stefano Jordhani wrote:
> In commit 6597e8d35851 ("netdev-genl: Elide napi_id when not present"),
> napi_id_valid function was added. Use the helper to refactor open-coded
> checks in the source.
> 
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Stefano Jordhani <sjordhani@gmail.com>
> ---
>  fs/eventpoll.c            | 8 ++++----
>  include/net/busy_poll.h   | 4 ++--
>  io_uring/napi.c           | 4 ++--
>  net/core/dev.c            | 6 +++---
>  net/core/netdev-genl.c    | 2 +-
>  net/core/page_pool_user.c | 2 +-
>  net/core/sock.c           | 2 +-
>  net/xdp/xsk.c             | 2 +-
>  8 files changed, 15 insertions(+), 15 deletions(-)

Thanks for the cleanup. As far as I can tell, LGTM.

Reviewed-by: Joe Damato <jdamato@fastly.com>


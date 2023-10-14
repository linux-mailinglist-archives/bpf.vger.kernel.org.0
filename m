Return-Path: <bpf+bounces-12212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A42837C9332
	for <lists+bpf@lfdr.de>; Sat, 14 Oct 2023 09:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FAF1282D34
	for <lists+bpf@lfdr.de>; Sat, 14 Oct 2023 07:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E075694;
	Sat, 14 Oct 2023 07:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMEATjnk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3E71869;
	Sat, 14 Oct 2023 07:28:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36973C433C7;
	Sat, 14 Oct 2023 07:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697268508;
	bh=G5pBXaikKy5eZl79Bhi0g0REKTXJ2KpCpRRBmh/PXQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oMEATjnk4N9ELAngiomINc1CaPU1jqZ830cOQrefLc/MRELm28PC7n1A3890dssT+
	 p7AhUNEb+Z2jYl61CMyaW1PYZivJnJxBmwKO+EZHLWtdZwUFhWUNMqMPUmkLZG/GPF
	 pS2kNPnjFI4juE/C9JJpm8IW9zHmqPASLKGEwT0IDX3DitX0jxsraGXZjyV4GV6nAF
	 gHuGdbwWdN6vjvdlxh2t2GxxUMfP9HS7YpQ3A5Kut20tNk7iptIcAGs772IvcLfX36
	 6Z0zAn8HoCBZbkILL3EqiNIrMOvHk+s9fTmWxk1V/5dBBqeT+OxsijqEYGGdjAP7oI
	 56nHXhiI3hgOg==
Date: Sat, 14 Oct 2023 09:28:24 +0200
From: Simon Horman <horms@kernel.org>
To: Edward AD <twuufnxlz@gmail.com>
Cc: bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+225bfad78b079744fd5e@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] media: imon: fix stall in worker_thread
Message-ID: <20231014072824.GU29570@kernel.org>
References: <20231013105909.GC29570@kernel.org>
 <20231014035114.1057686-2-twuufnxlz@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231014035114.1057686-2-twuufnxlz@gmail.com>

On Sat, Oct 14, 2023 at 11:51:15AM +0800, Edward AD wrote:
> On Fri, 13 Oct 2023 12:59:09 +0200 Simon Horman wrote:
> > The code is already switching based on urb->status,
> > so unless the warning message is really desired,
> > perhaps this is more appropriate?
> > 
> > diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
> > index 74546f7e3469..0e2f06f2f456 100644
> > --- a/drivers/media/rc/imon.c
> > +++ b/drivers/media/rc/imon.c
> > @@ -1799,6 +1799,7 @@ static void usb_rx_callback_intf1(struct urb *urb)
> > 
> >  	switch (urb->status) {
> >  	case -ENOENT:		/* usbcore unlink successful! */
> > +	case -EPROTO:		/* XXX: something goes here */
> >  		return;
> > 
> >  	case -ESHUTDOWN:	/* transport endpoint was shut down */
> 
> Hi Simon Horman, 
> 
> Who added the above code where?

Maybe I misunderstand your question but
I am suggesting the above change as an alternative approach.


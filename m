Return-Path: <bpf+bounces-63305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E6BB05497
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 10:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E79B47B21A9
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 08:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20ACB226CF3;
	Tue, 15 Jul 2025 08:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dIJyN1Uq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F3B26C396;
	Tue, 15 Jul 2025 08:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752567556; cv=none; b=lVxTILTopS4ZzSiJjIWPxJzVY9JtqQ8aJqlQZcZogxeyWqLkJKlJqqQ1uo6nMlcZYba4T9T2FlOO76rrU3IHL9JknL5Sjc+4LJgd9cwBJqnqt5xfTklCxTzJZHV0agn/28HMD1w7scxTCRfppVO36t3nxvAkVtFLRPb/gD9WFPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752567556; c=relaxed/simple;
	bh=xYYx8zlxp5oa3pFs+0lI4y+5Yub7dz7/WicSltLdFB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLczCTnKPMFbg1lwGyPGWFdczSsNIfs8i80HiZiK4foO7HKgXIC2VtGVr6qvMRQbh9RErAbnXaO2K+cy2+ga+Ke10l4OpefyJzfD5i7GGPLim9SaJVZl0klksEYSB3asxnUTHPH11yph9nAe3x5yBPk1od2gyl+8+igTZeyv6os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dIJyN1Uq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68501C4CEF5;
	Tue, 15 Jul 2025 08:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752567555;
	bh=xYYx8zlxp5oa3pFs+0lI4y+5Yub7dz7/WicSltLdFB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dIJyN1UqwTFT2l3WIYPcaJ2HLY8C7gsyXFuC6mvHTCA+fWxSG0xRSLEuHqSSkxA0p
	 FfOgGnnUlI7kqgH7kveKZHLVxYAvw98MQn/IOuSFvKbPnrYzZeAsydZMS3iBzSMWO3
	 dhA2C/NuR98H0BokdAb6bLWVcQWzl4x3fbGnHxtM=
Date: Tue, 15 Jul 2025 10:19:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Pranav Tyagi <pranav.tyagi03@gmail.com>
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	ast@kernel.org, cong.wang@bytedance.com, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
	syzbot+b18872ea9631b5dcef3b@syzkaller.appspotmail.com
Subject: Re: [PATCH] net: skmsg: fix NULL pointer dereference in
 sk_msg_recvmsg()
Message-ID: <2025071555-august-deskwork-e162@gregkh>
References: <20250715081158.7651-1-pranav.tyagi03@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715081158.7651-1-pranav.tyagi03@gmail.com>

On Tue, Jul 15, 2025 at 01:41:58PM +0530, Pranav Tyagi wrote:
> A NULL page from sg_page() in sk_msg_recvmsg() can reach
> __kmap_local_page_prot() and crash the kernel. Add a check for the page
> before calling copy_page_to_iter() and fail early with -EFAULT to
> prevent the crash.
> 
> Reported-by: syzbot+b18872ea9631b5dcef3b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b18872ea9631b5dcef3b
> Fixes: 2bc793e3272a ("skmsg: Extract __tcp_bpf_recvmsg() and tcp_bpf_wait_data()")
> Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
> ---
>  net/core/skmsg.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 4d75ef9d24bf..f5367356a483 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -432,6 +432,10 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
>  			sge = sk_msg_elem(msg_rx, i);
>  			copy = sge->length;
>  			page = sg_page(sge);
> +			if (!page) {
> +				copied = copied ? copied : -EFAULT;
> +				goto out;
> +			}
>  			if (copied + copy > len)
>  				copy = len - copied;
>  			copy = copy_page_to_iter(page, sge->offset, copy, iter);
> -- 
> 2.49.0
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.


If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot


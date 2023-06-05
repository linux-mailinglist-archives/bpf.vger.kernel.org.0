Return-Path: <bpf+bounces-1807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 916D1722310
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 12:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05BA71C20B9B
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 10:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDC2156EC;
	Mon,  5 Jun 2023 10:12:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055FD4432
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 10:12:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA224C433D2;
	Mon,  5 Jun 2023 10:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1685959950;
	bh=cKNPdiA5PBH3IZr0t+oe3bKG1W5Vi7xvHHCg7AkoYAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IIZ8gAomksGXSCS+HcqhfdtsPcUtT3IEvihKPLPA/V85dyNeEtIKW5SlmJJIzWhd6
	 IyuYcm2kWtYZz45FTtTCe+DzQAzNiJFfPurPGH8A1CLEVMyDczCc5IjVpajS5z9Peq
	 ItNueRkacDJFB4D2/C7q/13Gs7NOyGwBEqccGi1w=
Date: Mon, 5 Jun 2023 12:12:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yang Bo <yyyeer.bo@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, Yang Bo <bo@hyper.sh>
Subject: Re: [PATCH 1/2] Add api to manipulate global variable
Message-ID: <2023060500-swaddling-gala-317c@gregkh>
References: <20230605085733.1833-1-yb203166@antfin.com>
 <20230605085733.1833-2-yb203166@antfin.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605085733.1833-2-yb203166@antfin.com>

On Mon, Jun 05, 2023 at 04:57:32PM +0800, Yang Bo wrote:
> From: Yang Bo <bo@hyper.sh>
> 
> implement function.
> refactor code.
> 
> Signed-off-by: Yang Bo <bo@hyper.sh>


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

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what a proper
  Subject: line should look like.


If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot


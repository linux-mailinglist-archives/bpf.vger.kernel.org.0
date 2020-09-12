Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F61267B25
	for <lists+bpf@lfdr.de>; Sat, 12 Sep 2020 17:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgILPBM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 12 Sep 2020 11:01:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:46560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbgILOzY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 12 Sep 2020 10:55:24 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D24C20855;
        Sat, 12 Sep 2020 14:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599922522;
        bh=qInZn1/egWCEWFvA4yvyOBeLuLl91HdsgrtXiTqOoz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wZC0P8vUa9KFX5+Mjhd/cZcHpQDema900na2XGcmJg0Ip4+qdgCDsLXYoN8mXLrW0
         nBfrUmIwlaDvplV6wsKnHphRi1igdYpzuUygBSy4k216R7g+BU37xB1gsodpkJppsI
         OMdmH++O0NAxH0ErQHr0+1sajmWVgbgfq6lO7HMc=
Date:   Sat, 12 Sep 2020 16:55:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     andriin@fb.com, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, hawk@kernel.org,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@chromium.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Using a pointer and kzalloc in place of a struct directly
Message-ID: <20200912145525.GA769913@kroah.com>
References: <000000000000c82fe505aef233c6@google.com>
 <20200912113804.6465-1-anant.thazhemadam@gmail.com>
 <20200912114706.GA171774@kroah.com>
 <09477eb1-bbeb-74e8-eba9-d72cce6104db@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09477eb1-bbeb-74e8-eba9-d72cce6104db@gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Sep 12, 2020 at 05:43:38PM +0530, Anant Thazhemadam wrote:
> 
> On 12/09/20 5:17 pm, Greg KH wrote:
> > Note, your "To:" line seemed corrupted, and why not cc: the bpf mailing
> > list as well?
> Oh, I'm sorry about that. I pulled the emails of all the people to whom
> this mail was sent off from the header in lkml mail, and just cc-ed
> everyone.
> 
> > You leaked memory :(
> >
> > Did you test this patch?  Where do you free this memory, I don't see
> > that happening anywhere in this patch, did I miss it?
> 
> Yes, I did test this patch, which didn't seem to trigger any issues.
> It surprised me so much, that I ended up sending it in, to have
> it checked out.

You might not have noticed the memory leak if you were not looking for
it.

How did you test this?

> I wasn't sure where exactly the memory allocated here was
> supposed to be freed (might be why the current implementation
> isn't exactly using kzalloc). I forgot to mention it in the initial mail,
> and I was hoping that someone would point me in the right direction
> (if this approach was actually going to be considered, that is, which in
> retrospect I now feel might not be the best thing)

It has to be freed somewhere, you wrote the patch  :)

But back to the original question here, why do you feel this change is
needed?  What does this do better/faster/more correct than the code that
is currently there?  Unless you can provide that, the change should not
be needed, right?

thanks,

greg k-h

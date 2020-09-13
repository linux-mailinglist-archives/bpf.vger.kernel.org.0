Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47708267F5E
	for <lists+bpf@lfdr.de>; Sun, 13 Sep 2020 13:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgIMLtL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 13 Sep 2020 07:49:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgIMLtH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 13 Sep 2020 07:49:07 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35C002158C;
        Sun, 13 Sep 2020 11:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599997746;
        bh=nNNZtKQ9vNpyp0AU2mlHeeJpLKdX3ZCosPfSE/RvRU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dIEYq1U0ypah+NkLQx6/szK3jNn/P2s5pW8bE/k+RYZmRvX5s4Y+3fpc0Wq5nCEna
         Ae4d/YEh7AX6GiKlRk9vB5oAno4HWt2fv5+SuQyi8gYgEY9Y5xUw6VfCoUtYUgINuH
         qJpylynfpOVa6A78zqv2iz+JLb7gNgF/g0+mc6RQ=
Date:   Sun, 13 Sep 2020 13:49:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     andriin@fb.com, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, hawk@kernel.org,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@chromium.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Using a pointer and kzalloc in place of a struct directly
Message-ID: <20200913114908.GA929395@kroah.com>
References: <000000000000c82fe505aef233c6@google.com>
 <20200912113804.6465-1-anant.thazhemadam@gmail.com>
 <20200912114706.GA171774@kroah.com>
 <09477eb1-bbeb-74e8-eba9-d72cce6104db@gmail.com>
 <20200912145525.GA769913@kroah.com>
 <45d9f933-a5c8-ddbd-c014-2bdd5d911e13@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45d9f933-a5c8-ddbd-c014-2bdd5d911e13@gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Sep 13, 2020 at 01:32:43AM +0530, Anant Thazhemadam wrote:
> On 12/09/20 8:25 pm, Greg KH wrote:
> > On Sat, Sep 12, 2020 at 05:43:38PM +0530, Anant Thazhemadam wrote:
> >> On 12/09/20 5:17 pm, Greg KH wrote:
> >>> Note, your "To:" line seemed corrupted, and why not cc: the bpf mailing
> >>> list as well?
> >> Oh, I'm sorry about that. I pulled the emails of all the people to whom
> >> this mail was sent off from the header in lkml mail, and just cc-ed
> >> everyone.
> >>
> >>> You leaked memory :(
> >>>
> >>> Did you test this patch?  Where do you free this memory, I don't see
> >>> that happening anywhere in this patch, did I miss it?
> >> Yes, I did test this patch, which didn't seem to trigger any issues.
> >> It surprised me so much, that I ended up sending it in, to have
> >> it checked out.
> > You might not have noticed the memory leak if you were not looking for
> > it.
> >
> > How did you test this?
> Ah, that must be it. I tested this using syzbot, which wouldn't have looked
> for memory leaks, but only the issue that was reported. My apologies.
> >> I wasn't sure where exactly the memory allocated here was
> >> supposed to be freed (might be why the current implementation
> >> isn't exactly using kzalloc). I forgot to mention it in the initial mail,
> >> and I was hoping that someone would point me in the right direction
> >> (if this approach was actually going to be considered, that is, which in
> >> retrospect I now feel might not be the best thing)
> > It has to be freed somewhere, you wrote the patch  :)
> >
> > But back to the original question here, why do you feel this change is
> > needed?  What does this do better/faster/more correct than the code that
> > is currently there?  Unless you can provide that, the change should not
> > be needed, right?
> I was initially trying to see if allocating memory would be an appropriate
> heuristic in trying to get a better sense of the bug and crash report, and
> at that moment, that was my goal, and figured that I'd deal with rest
> (such as freeing the memory) later on, if this was a something that could work.
> 
> I was surprised when the patch (although it caused a memory leak), seemed
> to pass the test for the bug, without triggering any issues; since this patch
> basically only allocates memory as compared to locally declaring variables.
> 
> I wanted some input or explanation, about how is it that doing this no longer
> triggers the bug?

That really is up to you to work out, sorry.

Look at what the syzbot is testing, and look at the code change to see
the difference, and you should notice what memory is now being cleared
that previously was not.

good luck!

greg k-h

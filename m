Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6DEB1D5C
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2019 14:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388189AbfIMMSg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Sep 2019 08:18:36 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46468 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388187AbfIMMSg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Sep 2019 08:18:36 -0400
Received: by mail-ot1-f68.google.com with SMTP id g19so29164055otg.13
        for <bpf@vger.kernel.org>; Fri, 13 Sep 2019 05:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A/c97/nFme+ivPwJjzTzfClgEa0OIy/3njro+D9o78o=;
        b=XOYIJFsaopl13XxNMqGXKTMtqthGHFDixCdxfm/BRkbm8C7nqft8bOMYav+KkL38Qt
         QBPmqIznV8C75U0erZcJeN+FS4ORrdfnOjlRb9HcFlpbAXpaDUwEMEFfgca6deU40mKQ
         dAOsSZkAX1fiHcUyIlZI0MpYcLKZkJiURtJujVfDoxC7cHZxhUrtdZawEtZRorybqoKp
         Du310WWUJuQYwvmI+m/z4o8nvQoTbQdB9+0Eb9svR+kK5/cpRBeRAWUoHJP1VOu6fTY3
         9DYzNQKc+KVnxHkBABtxBwWcts/Vcw2KusB5j9MY08YSFdZXJcIUkmnHlOhvEmYtyq/g
         +xmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A/c97/nFme+ivPwJjzTzfClgEa0OIy/3njro+D9o78o=;
        b=LxV+uyEr9BqupIWSOSDYZn0CJK+8x2lOgphw9+68Xm10W82YdjyQ+3EPSCJC6lzYnL
         Av4JmMRZPlaSPLCbZ8t5pDLSvfkD3QoMsTnmeACvVeyHnlYIi3JkWT/H6ouh6JHFfqr3
         L+oVrS8pCzVLqTJL8GSnSJsmMmOyoJwAaLdDNn1mE0yOUegwgo1WK1iRpuUYjQjHsmWH
         rQWqH+9iR0L3gtFEyW163bPvGMJPQ5MMnAtvmBzqRGQLiEAHdQGi+TX/7/fTKiilaYlW
         1w0gcEPUNRLF7bErUmfzFnYnb3px5na94uYKOH+CddOGjbzFhYvDTMXwUbontGIFxebG
         GdMQ==
X-Gm-Message-State: APjAAAVjioOn2ykKtHC9HOyDRDoINHJSqBqC2lRDUe54/KFnzOtYA/kb
        bLE18eLrkDoYcOb4U/f6sOcN0GZPnnPX3Trjp4iNKg==
X-Google-Smtp-Source: APXvYqyUP3UinjilPMLX5L/ce/vPrHjlyiR9Mzwouxkvl/+9B3J3lEInbbUjdvdAF29WZpR8yBBtHGAMbtEPFqknxsQ=
X-Received: by 2002:a9d:2642:: with SMTP id a60mr8278939otb.247.1568377114876;
 Fri, 13 Sep 2019 05:18:34 -0700 (PDT)
MIME-Version: 1.0
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190911184332.GL20699@kadam> <9132e214-9b57-07dc-7ee2-f6bc52e960c5@kernel.dk>
 <20190913010937.7fc20d93@lwn.net> <20190913114849.GP20699@kadam>
In-Reply-To: <20190913114849.GP20699@kadam>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 13 Sep 2019 05:18:22 -0700
Message-ID: <CAPcyv4jPpxS4wxNO-e1pSHdQpKo5=V0YwD1CHqR61g8zmECKfw@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH v2 3/3] libnvdimm, MAINTAINERS:
 Maintainer Entry Profile
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
        Dave Jiang <dave.jiang@intel.com>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 13, 2019 at 4:49 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Fri, Sep 13, 2019 at 01:09:37AM -0600, Jonathan Corbet wrote:
> > On Wed, 11 Sep 2019 16:11:29 -0600
> > Jens Axboe <axboe@kernel.dk> wrote:
> >
> > > On 9/11/19 12:43 PM, Dan Carpenter wrote:
> > > >
> > > > I kind of hate all this extra documentation because now everyone thinks
> > > > they can invent new hoops to jump through.
> > >
> > > FWIW, I completely agree with Dan (Carpenter) here. I absolutely
> > > dislike having these kinds of files, and with subsystems imposing weird
> > > restrictions on style (like the quoted example, yuck).
> > >
> > > Additionally, it would seem saner to standardize rules around when
> > > code is expected to hit the maintainers hands for kernel releases. Both
> > > yours and Martins deals with that, there really shouldn't be the need
> > > to have this specified in detail per sub-system.
> >
> > This sort of objection came up at the maintainers summit yesterday; the
> > consensus was that, while we might not like subsystem-specific rules, they
> > do currently exist and we're just documenting reality.  To paraphrase
> > Phillip K. Dick, reality is that which, when you refuse to document it,
> > doesn't go away.
>
> There aren't that many subsystem rules.  The big exception is
> networking, with the comment style and reverse Chrismas tree
> declarations.  Also you have to label which git tree the patch applies
> to like [net] or [net-next].
>
> It used to be that infiniband used "sizeof foo" instead of sizeof(foo)
> but now there is a new maintainer.
>
> There is one subsystem which where the maintainer will capitalize your
> patch prefix and complain.  There are others where they will silently
> change it to lower case.  (Maybe that has changed in recent years).
>
> There is one subsystem where the maintainer is super strict rules that
> you can't use "I" or "we" in the commit message.  So you can't say "I
> noticed a bug while reviewing", you have to say "The code has a bug".
>
> Some maintainers have rules about what you can put in the declaration
> block.  No kmalloc() in the declarations is a common rule.
> "struct foo *p = kmalloc();".
>
> Some people (I do) have strict rules for error handling, but most won't
> complain unless the error handling has bugs.
>
> The bpf people want you to put [bpf] or [bpf-next] in the subject.
> Everyone just guesses, and uneducated guesses are worse than leaving it
> blank, but that's just my opinion.
>
> > So I'm expecting to take this kind of stuff into Documentation/.  My own
> > personal hope is that it can maybe serve to shame some of these "local
> > quirks" out of existence.  The evidence from this brief discussion suggests
> > that this might indeed happen.
>
> I don't think it's shaming, I think it's validating.  Everyone just
> insists that since it's written in the Book of Rules then it's our fault
> for not reading it.  It's like those EULA things where there is more
> text than anyone can physically read in a life time.
>
> And the documentation doesn't help.  For example, I knew people's rules
> about capitalizing the subject but I'd just forget.  I say that if you
> can't be bothered to add it to checkpatch then it means you don't really
> care that strongly.

True, can someone with better perl skills than me take a shot at a
rule for checkpatch to catch the capitalization preference based on
the subsystem being touched, or otherwise agree that if a maintainer
has a changelog capitalization preference they just silently fix it up
at application time and not waste time pointing out something so
trivial? For example, I notice Linus likes "-" instead of "*" for
bullet lists in changelogs he just fixes it up silently if I forget.

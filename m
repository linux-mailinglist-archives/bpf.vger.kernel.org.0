Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F31E27F589
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 00:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731874AbgI3Wx5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Sep 2020 18:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731828AbgI3Wx5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Sep 2020 18:53:57 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D100C061755
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2020 15:53:57 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id gm14so768420pjb.2
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2020 15:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xT7z4KWpY1tW0DUzf7kauPlyM86hsIyuR+DbyM/kIF4=;
        b=dJSvn+nVMHOhyyebiONq5L1qo38q1OX51JVgtEQrhaCb9Ko8DFOcatX2GGKv2OpzZr
         sIvN3Ky6KPhHJRJx//ba2NE4yw/9fp3TyA2uoDw7vHOSexKqne+cqwQpImU41Lyz31Bo
         HucnSHirKztZuVWWFld/RQCHHttbmiGQcpaww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xT7z4KWpY1tW0DUzf7kauPlyM86hsIyuR+DbyM/kIF4=;
        b=ib/6lVGk+vHD5Le7N7tU8Cd8+2Jl+QC1BQSTTZa3oY73f5ZNLkjDV0E3HZS1k6Dnq/
         UVfwa1LKxx8nEw8laEXt5qVjeD0VvtOY/ht2Ip1QSATWKDotdGzl26YoRksyVOT3pzFH
         oJMNSuIzbtrx0SZVidYeDSKgbXQixLP1wXFj0+yEemopT3df2p1MYxhgvCqPJvGrMjJd
         MRfnO73/Ygx66ylp6YIySSMXWxKGHXgCrittzIdSn/75V2iSstMxQMyTIgZn8dVDYBL1
         kf52k0sW3TSMeBVPCdujY3f9TPAWGyRmogEdRbdtv+Ks2OtVeIikkIn9qgofUzrEwyyJ
         8+bg==
X-Gm-Message-State: AOAM530wz4BqmZ99lecgYx8Qmoi87jIJfbfTXtOXUJ0FqHGvjsC5mjcD
        qzicNOm3jbAEPTajFCXi2TwPWw==
X-Google-Smtp-Source: ABdhPJym9XGRJgUPD0aK76nCGJgVfLs8G5aI0UXZOOiThurScckwIjdLNnP4Mp59y5rMZ/XCz74uUA==
X-Received: by 2002:a17:90b:ecf:: with SMTP id gz15mr4360289pjb.126.1601506436994;
        Wed, 30 Sep 2020 15:53:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 1sm3974626pfx.126.2020.09.30.15.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 15:53:56 -0700 (PDT)
Date:   Wed, 30 Sep 2020 15:53:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     YiFei Zhu <zhuyifei1999@gmail.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH v3 seccomp 1/5] x86: Enable seccomp architecture tracking
Message-ID: <202009301549.17D3DE5@keescook>
References: <cover.1601478774.git.yifeifz2@illinois.edu>
 <484392624b475cc25d90a787525ede70df9f7d51.1601478774.git.yifeifz2@illinois.edu>
 <202009301418.20BA0CE33@keescook>
 <CAG48ez3039B+w_D7SJBaGGXw9sd1_SzWO+qUnhMs6tcweGa-+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3039B+w_D7SJBaGGXw9sd1_SzWO+qUnhMs6tcweGa-+w@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 30, 2020 at 11:33:15PM +0200, Jann Horn wrote:
> On Wed, Sep 30, 2020 at 11:21 PM Kees Cook <keescook@chromium.org> wrote:
> > On Wed, Sep 30, 2020 at 10:19:12AM -0500, YiFei Zhu wrote:
> > > From: Kees Cook <keescook@chromium.org>
> > >
> > > Provide seccomp internals with the details to calculate which syscall
> > > table the running kernel is expecting to deal with. This allows for
> > > efficient architecture pinning and paves the way for constant-action
> > > bitmaps.
> > >
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > [YiFei: Removed x32, added macro for nr_syscalls]
> > > Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
> [...]
> > But otherwise, yes, looks good to me. For this patch, I think the S-o-b chain is probably more
> > accurately captured as:
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > Co-developed-by: YiFei Zhu <yifeifz2@illinois.edu>
> > Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
> 
> (Technically, https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by
> says that "every Co-developed-by: must be immediately followed by a
> Signed-off-by: of the associated co-author" (and has an example of how
> that should look).)

Right, but it is not needed for the commit author (here, the From:),
the second example given in the docs shows this:

	From: From Author <from@author.example.org>

	<changelog>

	Co-developed-by: Random Co-Author <random@coauthor.example.org>
	Signed-off-by: Random Co-Author <random@coauthor.example.org>
	Signed-off-by: From Author <from@author.example.org>
	Co-developed-by: Submitting Co-Author <sub@coauthor.example.org>
	Signed-off-by: Submitting Co-Author <sub@coauthor.example.org>

and there is no third co-developer, so it's:

	From: From Author <from@author.example.org>

	<changelog>

	Signed-off-by: From Author <from@author.example.org>
	Co-developed-by: Submitting Co-Author <sub@coauthor.example.org>
	Signed-off-by: Submitting Co-Author <sub@coauthor.example.org>

If I'm the From, and YiFei Zhu is the submitting co-developer, then
it's:

	From: Kees Cook <keescook@chromium.org>

	<changelog>

	Signed-off-by: Kees Cook <keescook@chromium.org>
	Co-developed-by: YiFei Zhu <yifeifz2@illinois.edu>
	Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>

which is what I suggested.

-- 
Kees Cook

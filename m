Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8202D2D5020
	for <lists+bpf@lfdr.de>; Thu, 10 Dec 2020 02:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731830AbgLJBNi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Dec 2020 20:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731943AbgLJBNg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Dec 2020 20:13:36 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2AFC0613D6;
        Wed,  9 Dec 2020 17:12:56 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id w13so5815978lfd.5;
        Wed, 09 Dec 2020 17:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QyjZecAJCum42+wa4R0rubhKSM2W54Cbm6oDZdsQblA=;
        b=nQ8iSrlOU8qAkkvB2DFzVO9/y5Ugxl4jx20hH6ARVqnCs3p13pIkU3pOq/+xj4fGcL
         ST1+AhMrIoFHopKfHzOfQDrTt6+e3SR7x4wtZbzIPTe836Wg/epumGb81psMIKUUP92R
         Z6AgrlDAXw2DjBmHbvVZKKv/6eAp3JPx+ul5yTIevK3jZuL7p36mCgI8bfTk9S1LnGZf
         fukbhDgDQwwMbJdUahCspou61v6PLB7Qn8/FOigcplastmym0LwpHVdVgH3xGfyIyW/c
         hzE+DmVWl7m1TGDc+5sLdle2nkkVnUuVu1SZcAYOksjHLNn03Xsg7+ryqdo76ykJ+fsS
         YcFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QyjZecAJCum42+wa4R0rubhKSM2W54Cbm6oDZdsQblA=;
        b=Fm8fH58oQDrDknHnY/2XFTZJlGX1TOG5ak9kqv+epD+f63qvKRu0habaipiD9d/5/H
         Zce41dWhnBifMqkoyIP3+C6HdBXLJOCrwXt6iwHRLRYYh37H9IvVOkhWEFm/2ZFVRRA8
         g2snMRmeyusmYiPcp1swTSwNY9Q0ANLN8kCIMJxz//G9JmYxPo6Pm3LvcR8Z7cg+79zA
         2LDMCIa5A21zq/F0kzxqgzsdr39mTnix+Vq1PmIeLaH+uXIE7P9SEyyQFcqnKo0jeAVF
         j6U+k/j3ffu3DPjPPdir8ixgyulIzaOx0jephIcOC6Mi/COlYA14bFqkAhKViOkMrXMl
         Ymbg==
X-Gm-Message-State: AOAM531Dfu0a+fH3am3fmTNp/tlgRCLHCOjYRU4M86GmE0k6C73rCrUN
        ecDXRVabXBHXXnbWW6k/eOgtbfGS38VvOlkRI2/TBSA2
X-Google-Smtp-Source: ABdhPJzYwCnYNE8XNSNlGBL+LALCBUAE1nm0EdvDkAX0JEp06MibXC0+43/kKoYAfQhm85NMXolnM8Vll12GXa0tY+4=
X-Received: by 2002:ac2:43c1:: with SMTP id u1mr879140lfl.38.1607562774513;
 Wed, 09 Dec 2020 17:12:54 -0800 (PST)
MIME-Version: 1.0
References: <20201207081556.pwxmhgdxayzbofpi@lion.mk-sys.cz>
 <CAFxkdApgQ4RCt-J43cK4_128pXr=Xn5jw+q0kOaP-TYufk_tPA@mail.gmail.com>
 <CAADnVQK-EsdBohcVSaK+zaP9XuPZTBkGbQpkeYcrC9BzoPQUuw@mail.gmail.com>
 <20201207225351.2liywqaxxtuezzw3@lion.mk-sys.cz> <CAADnVQJARx6sKF-30YsabCd1W+MFDMmfxY+2u0Pm40RHHHQZ6Q@mail.gmail.com>
 <CAADnVQJ6tmzBXvtroBuEH6QA0H+q7yaSKxrVvVxhqr3KBZdEXg@mail.gmail.com>
 <20201209144628.GA3474@wp.pl> <20201209150826.GP7338@casper.infradead.org>
 <20201209155148.GA5552@wp.pl> <20201209180552.GA28692@infradead.org> <20201209223206.GA1935@home.goodmis.org>
In-Reply-To: <20201209223206.GA1935@home.goodmis.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 9 Dec 2020 17:12:43 -0800
Message-ID: <CAADnVQKiBWG9NVNEV9EqGkyd-n3Yj88cNJpH997js-63eTVAOQ@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: add static for function __add_to_page_cache_locked
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Kubecek <mkubecek@suse.cz>,
        Justin Forbes <jmforbes@linuxtx.org>,
        bpf <bpf@vger.kernel.org>, Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 9, 2020 at 2:32 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, Dec 09, 2020 at 06:05:52PM +0000, Christoph Hellwig wrote:
> > On Wed, Dec 09, 2020 at 04:51:48PM +0100, Stanislaw Gruszka wrote:
> > > On Wed, Dec 09, 2020 at 03:08:26PM +0000, Matthew Wilcox wrote:
> > > > On Wed, Dec 09, 2020 at 03:46:28PM +0100, Stanislaw Gruszka wrote:
> > > > > At this point of release cycle we should probably go with revert,
> > > > > but I think the main problem is that BPF and ERROR_INJECTION use
> > > > > function that is not intended to be used externally. For external users
> > > > > add_to_page_cache_lru() and add_to_page_cache_locked() are exported
> > > > > and I think those should be used (see the patch below).
> > > >
> > > > FWIW, I intend to do some consolidation/renaming in this area.  I
> > > > trust that will not be a problem?
> > >
> > > If it does not break anything, it will be not a problem ;-)
> > >
> > > It's possible that __add_to_page_cache_locked() can be a global symbol
> > > with add_to_page_cache_lru() + add_to_page_cache_locked() being just
> > > static/inline wrappers around it.
> >
> > So what happens to BTF if we change this area entirely?  Your IDs
> > sound like some kind of ABI to me, which is extremely scary.
>
> Is BTF becoming the new tracepoint? That is, random additions of things like:
>
>    BTF_ID(func,__add_to_page_cache_locked)
>
> Like was done in commit 1e6c62a882155 ("bpf: Introduce sleepable BPF
> programs") without any notification to the maintainers of the
> __add_to_page_cache_locked code, will suddenly become an API?

huh? what api/abi you're talking about?

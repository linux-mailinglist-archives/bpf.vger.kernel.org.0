Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECFB21F1DBF
	for <lists+bpf@lfdr.de>; Mon,  8 Jun 2020 18:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387454AbgFHQtS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Jun 2020 12:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387429AbgFHQtR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jun 2020 12:49:17 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D078EC08C5C2
        for <bpf@vger.kernel.org>; Mon,  8 Jun 2020 09:49:15 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id a6so14867630qka.9
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2020 09:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4cSXd/WEBOMmjBzHT5V64B0CdBFXvfK/YmpOS865C/E=;
        b=U3EfLuu7JaLkGMY8hL5QIb1XxjOTvGLy8smtkMre6qK5eYxBLb2UL/zFO2wglyhsMu
         UvezhXn9mhrv0A7/FhCf8JnkEJTlV1VLNsipBdO/UsRGBq7OU4cvXBok03qi61RIPwYY
         cPFbpx7piIlTZzGtkW8/4i7sum2DbqS2EbzkDwEB3fJwkusvralu/xdeCEm1jeCCTR5I
         hgQLAlzmiNsYiwK8xuG6S/FSqj9OtLCIfPL3Ux2nlm4a+ru9sgaOfJjtOfYfH4CFwTEx
         mqp0KagzuygvTokeurbn2I3y+aupyDOmqHa0WNO3I2RH1aXp9uX80NDRvqN3aNVp0vHm
         OWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4cSXd/WEBOMmjBzHT5V64B0CdBFXvfK/YmpOS865C/E=;
        b=FekLWxjDV29o0GEqs2LoUzTGigeNDuS9bD/+V3/q36K9hPR7UV62GW/a+fHLk8yy5d
         Vl9t1KmzZnt4gDwTxu7HdvRZ0OxnI3JaDdS/wbS76xJStAKqZ7VoN5h8TdJCFfRMMFtc
         0giQ+nzQP2OYl0iIX299m3HMMcLkhWpieAvq4VFtiYxi823lB3jKcHI/i/I4mexrRkzP
         AMIoopkBXnns0CyMtn8cAHWWtjyTxWKzzfKC6bbWFtoFkGMfm2l4c3xUi2SOI/eAkKMv
         b2yUTjiaSikzhvwonfEoesPDx3OIVMfPQIlGQyTRQR2dbRrdWymx9GK4VPVyyc4hssg9
         bwaw==
X-Gm-Message-State: AOAM533B4xxQd7HrbmVuaGTdJ7pCRVPOYdbyoRp2RtuNp5yadcSZlG0L
        CJLJ7iYiEriCWXEo2oQ66HdKmHI=
X-Google-Smtp-Source: ABdhPJw3SF/yeOWoX1y6fxdX9jvAKFUnJPCziJIZcvXIyleiG6G/g3vMRpIR6CTI4d5n5FeYtiZMXjs=
X-Received: by 2002:a0c:f991:: with SMTP id t17mr23459051qvn.123.1591634954981;
 Mon, 08 Jun 2020 09:49:14 -0700 (PDT)
Date:   Mon, 8 Jun 2020 09:49:13 -0700
In-Reply-To: <CAADnVQL3iBoem4T6CxYeZRCJwS7qRwjjbW+8ip5r3-LCt_eRXQ@mail.gmail.com>
Message-Id: <20200608164913.GA142074@google.com>
Mime-Version: 1.0
References: <20200424064338.538313-1-hch@lst.de> <20200424064338.538313-6-hch@lst.de>
 <1fc7ce08-26a7-59ff-e580-4e6c22554752@oracle.com> <20200608065120.GA17859@lst.de>
 <c0f216d1-edc1-68e6-7f3e-c00e33452707@oracle.com> <20200608130503.GA22898@lst.de>
 <CAADnVQL3iBoem4T6CxYeZRCJwS7qRwjjbW+8ip5r3-LCt_eRXQ@mail.gmail.com>
Subject: Re: WARNING: CPU: 1 PID: 52 at mm/page_alloc.c:4826
 __alloc_pages_nodemask (Re: [PATCH 5/5] sysctl: pass kernel pointers to ->proc_handler)
From:   sdf@google.com
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        Andrey Ignatov <rdna@fb.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 06/08, Alexei Starovoitov wrote:
> On Mon, Jun 8, 2020 at 6:05 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Mon, Jun 08, 2020 at 09:45:49AM +0200, Vegard Nossum wrote:
> > > Just a test case.
> > >
> > > Allowing the kernel to allocate an unbounded amount of memory on  
> behalf
> > > of userspace is an easy DOS.
> > >
> > > All the length checks were already in there, e.g.
> > >
> > >  static int cmm_timeout_handler(struct ctl_table *ctl, int write,
> > >                               void __user *buffer, size_t *lenp,  
> loff_t
> > > *ppos)
> > >  {
> > >         char buf[64], *p;
> > > [...]
> > >                 len = min(*lenp, sizeof(buf));
> > >                 if (copy_from_user(buf, buffer, len))
> > >                         return -EFAULT;
> >
> > Doesn't help if we don't know the exact limit yet.  But we can put
> > some arbitrary but reasonable limit like KMALLOC_MAX_SIZE on the
> > sysctls and see if this sticks.

> adding Stanislav. I think he's looking into this already.
Yeah, I'm looking at it from the get/setsockopt point of view.
I'm currently trying to bypass allocating a buffer if it's greater
than PAGE_SIZE.
I suppose for sysctls we should try to do something similar?

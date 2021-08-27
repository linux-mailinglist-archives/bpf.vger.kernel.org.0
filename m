Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB39D3F91D5
	for <lists+bpf@lfdr.de>; Fri, 27 Aug 2021 03:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243916AbhH0BGS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Aug 2021 21:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243853AbhH0BGS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Aug 2021 21:06:18 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2827C061757;
        Thu, 26 Aug 2021 18:05:26 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id m4so2910412pll.0;
        Thu, 26 Aug 2021 18:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CJoF4Bgpjmz+E7bVdWY2k+bvCattJTFOGcI1X+RlV2A=;
        b=Xw8hi+ZNH78UlcZDWdCmX6NKyyAA3smvcVS5KjVJWrErrTcr2LmjJL6ARgqTOrR15v
         xLy0egSMc7lZTlT1MQQcSlhOwRjK8gjy3Wttkew03DA4S6VY7ytzQD+R1mAOBTMJT4j9
         Ev1bjV8bwfvL4zmjLxRvRBef42hH6yB0Zlp5q6sd+P8mFlKpMtJfg7KsamNxPeEi6zkO
         4oGveSMKQI5drBkNvkLTgifODCE3tNJhbQtsdkxMq67l6/xznsY8tvS2Hi6iSFW+hlbT
         9eu/ZPcIzTLPZe9QRNFWxOXwB5DDDYFVZquqRhz2CjFrumFhGlZctUuf43irUiHYr+66
         1Zcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CJoF4Bgpjmz+E7bVdWY2k+bvCattJTFOGcI1X+RlV2A=;
        b=UQAC7w9tf534eDFcXrK56sH9avGIp8MhSk4mWmghio8vYft7rUlVKaERIEB9N7OIIv
         GF+rkc+MyjDujaIj6o5gwUrfY6iUSZFrJKmAsGpp1b6KXV23IIWZGJpynP7V64/UAnRw
         +ya00KF0uA6B4fCrA6jk1lmW4yjB8R/qYag4oSYpMoDC7eDwLqtqJGWk2O9EuE4Rw8+/
         9M+nrUI6u4wxaWppac0TNLWZ1jzK/rhKUPQ31Os/KvZyqIQiBVK164sLA15e9VHNF5No
         F4C1dWvomKOAEwurX6ZMTmIckYzFRSDClToeJTaTqad3J8KzFtzZ+289NQ8hRW9b6Oa/
         iuKg==
X-Gm-Message-State: AOAM5309E2P6veNUJDAfbbaySWom8oSSCPb6KYKaiNWXLkZ9UqQanH7Z
        Ye/x9ukfCJyfYBcuYmTegVM=
X-Google-Smtp-Source: ABdhPJxOah0eBvELAOjhdzUXVYmB2Z/tYt7nhdTqVkdviWdPsuvJZFJ1Ehtt6xtuHJlfJ23Nay0SJA==
X-Received: by 2002:a17:90a:b785:: with SMTP id m5mr20286683pjr.213.1630026326070;
        Thu, 26 Aug 2021 18:05:26 -0700 (PDT)
Received: from localhost ([2405:201:6014:d820:9cc6:d37f:c2fd:dc6])
        by smtp.gmail.com with ESMTPSA id c15sm3975021pjr.22.2021.08.26.18.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 18:05:25 -0700 (PDT)
Date:   Fri, 27 Aug 2021 06:35:23 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     KP Singh <kpsingh@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Spencer Baugh <sbaugh@catern.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Alexander Mihalicyn <alexander@mihalicyn.com>,
        Andrei Vagin <avagin@gmail.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 1/5] bpf: Implement file local storage
Message-ID: <20210827010523.4mty6oqzeuvadaml@apollo.localdomain>
References: <20210826133913.627361-1-memxor@gmail.com>
 <20210826133913.627361-2-memxor@gmail.com>
 <20210826222347.3bf5q5ehdfnrblir@ast-mbp.dhcp.thefacebook.com>
 <CACYkzJ6G-E6X2hxwQfwqJ6Hgm-CbiNnY6h+xZRhO1AuOUu0NJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACYkzJ6G-E6X2hxwQfwqJ6Hgm-CbiNnY6h+xZRhO1AuOUu0NJA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 27, 2021 at 05:43:41AM IST, KP Singh wrote:
> On Fri, Aug 27, 2021 at 12:23 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Aug 26, 2021 at 07:09:09PM +0530, Kumar Kartikeya Dwivedi wrote:
> > > +BPF_CALL_2(bpf_file_storage_delete, struct bpf_map *, map, struct file *, file)
> > > +{
> > > +     if (!file)
> > > +             return -EINVAL;
> > > +
> > > +     return file_storage_delete(file, map);
> > > +}
> >
> > It's exciting to see that file local storage is coming to life.
> >
>
> +1 Thanks for your work!
>
> > What is the reason you've copy pasted inode_local_storage implementation,
> > but didn't copy any comments?
> > They were relevant there and just as relevant here.
> > For example in the above *_storage_delete, the inode version would say:
> >
> > /* This helper must only called from where the inode is guaranteed
> >  * to have a refcount and cannot be freed.
> >  */
> >
> > That comment highlights the important restriction.
> > The 'file' pointer should have similar restriction, right?
> > But files are trickier than inodes in terms of refcnt.
> > They are more similar to sockets,
> > the socket_local_storage is doing refcount_inc_not_zero() in similar
>
> Even the task_local_storage checks if the task is refcounted and going to
> be around while we do a get / delete.
>
> > case to make sure socket doesn't disappear.
> >
>
> Agreed, I would prefer if we also revisit inode_local_storage
> in this respect pretty much because of what Alexei said.
> One could end up with an inode (e.g. by walking pointers) in an LSM hook
> whose life-cycle is not guaranteed in the current context.
>
> This is generally not that big a deal with inodes because they are
> not as ephemeral as tasks, sockets and files.
>
> e.g. your userspace "_fd_" version of the helper does the right thing
> by grabbing a
> reference to the file and then dropping it once the storage is updated.
>

Thank you both of you for the comments. I will revisit this and inode_storage
and get back to you, soon.

--
Kartikeya

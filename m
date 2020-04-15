Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3609F1AB10A
	for <lists+bpf@lfdr.de>; Wed, 15 Apr 2020 21:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441557AbgDOTIh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Apr 2020 15:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2411747AbgDOTHo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Apr 2020 15:07:44 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AA1C061A10
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2020 12:07:44 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x23so3537451lfq.1
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2020 12:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WHS9w73gVSKGtfELfF7LkOOhEm3OShLI4yNVYb/K/vg=;
        b=vNQ7f9OhoXlteGQGEZ1dY5/wbTe6sfGzrHwHE+eDlS0otiDLJitsZY6ZHod83gVnOH
         17i2CeCUgTmYwQDtqn/fAqt0O3bGbDfearVxysENsd73NRFYJTVuuOebwrhdR+8Lp4c9
         bPoiGe6gmPTOcl86OkwmIoS79YZizSDIr2PIxgwWUmWP2khgLjnqcutnMnyyRyZBsc58
         P5Q5CRojd8enWgHE5vo4RtfeWQbL0xefmhS/6Vg2Vkkj+/QQ/lEwENbgwPFo/ZSJCsEl
         QSPwP8knHk1BZ/Wosi9W0jgAO032fLo3Q9jWmKk8KRNTrjeGXpI8uesOE6CrvndD0sZu
         0c3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WHS9w73gVSKGtfELfF7LkOOhEm3OShLI4yNVYb/K/vg=;
        b=Gfo9T9qBDeYKcDo0DbgGisOOvaRx+B8hR2xrUcBJHAWveTOuh9oAH82LZLM6lgqQyg
         RVQ7oUuak9pTaIR+q5RoY20MhNBO1uYOOxIf3N3pOpCqp0s52uqu1is8apL/R4xSPrgj
         SaSPWpAdbosB8WyP6D0qdZxUUl81Z9a9q1NH2nRwS6hpyUPA27y8+Ksyb6+ImyLHv8tu
         m6OQMcSchQeIie1dIVHYuBAGkJ0aYMg8GcGBRWhPAOTKfhENMa34TtZiaJkJw/kbd+gy
         bsHrv0oAAiAgjWZzC03jtXy8F13lzxP8z8uLkK8C/LQTzRDP2etWx9NK+fOS84yFtwe2
         533Q==
X-Gm-Message-State: AGi0PubXc+wlFvsEbev8GxBKi5bFOrTh27yAnYa9kbQkh8ETr0K//jSH
        UW1bu17ncM+1uDIaZ36ZzLyXED+oX9vCaFl5hFWqiQ==
X-Google-Smtp-Source: APiQypKNDC5icx02jo8aPboJVWpOXmQ4cs43JUX1uNS9vVezg89YbRzSNzcUHokiR5U9DxrVeop6XR1NKs39NF75H7c=
X-Received: by 2002:a19:f719:: with SMTP id z25mr3996229lfe.63.1586977662292;
 Wed, 15 Apr 2020 12:07:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez2R5nZA91j7cf2Z5o3dOEz0QNZK7cxecjmw0B-ZQ7AjmA@mail.gmail.com>
 <CAEf4Bzb2zcfJt6ujAN8zY_=x7-dFO92mPzkbCE+UMHVDGL7J+Q@mail.gmail.com>
 <CAG48ez20KjiYjcYzWnnVCyNTMjNFf+YgnwbbF9BUovZxDzsuEw@mail.gmail.com>
 <CAEf4BzbEcbgAmXSzKx70rEhzmWcZ_8ECuX98_wsfvRkprKQgbQ@mail.gmail.com>
 <CAG48ez15gsNtjiwFtLR_eBGAZnfXAt4O+ykuaopVf+jW5KTeRQ@mail.gmail.com>
 <CAEf4Bzak3FnhD3kUZ4Dn9ZRz=yWSfZ+nkYa1Gz1WeZO7PC7Wkw@mail.gmail.com>
 <CAG48ez0mmVtBVTjy-KmpUnvJ52O=EYKwJWoCxcXH8O6zCG1QHA@mail.gmail.com> <CAEf4BzZ2vmdmn111KXXrp3qp1qLb4iMjUJ11Cj06SOGeOB6_Qg@mail.gmail.com>
In-Reply-To: <CAEf4BzZ2vmdmn111KXXrp3qp1qLb4iMjUJ11Cj06SOGeOB6_Qg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 15 Apr 2020 21:07:14 +0200
Message-ID: <CAG48ez0G5q8CouLsTDHjkOcJ7WKJE09OB9FHFPQJUzQrCmZG1w@mail.gmail.com>
Subject: Re: BPF map freezing is unreliable; can we instead just inline constants?
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 15, 2020 at 6:59 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Tue, Apr 14, 2020 at 3:50 PM Jann Horn <jannh@google.com> wrote:
> > On Tue, Apr 14, 2020 at 9:46 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > > On Tue, Apr 14, 2020 at 9:07 AM Jann Horn <jannh@google.com> wrote:
> > > > On Fri, Apr 10, 2020 at 10:48 PM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > On Fri, Apr 10, 2020 at 1:47 AM Jann Horn <jannh@google.com> wrote:
> > > > > > On Fri, Apr 10, 2020 at 1:33 AM Andrii Nakryiko
> > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > > On Wed, Apr 8, 2020 at 12:42 PM Jann Horn <jannh@google.com> wrote:
> > > > > > > >
> > > > > > > > Hi!
> > > > > > > >
> > > > > > > > I saw that BPF allows root to create frozen maps, for which the
> > > > > > > > verifier then assumes that they contain constant values. However, map
> > > > > > > > freezing is pretty wobbly:
[...]
> > > > > > > > Is there a reason why the verifier doesn't replace loads from frozen
> > > > > > > > maps with the values stored in those maps? That seems like it would be
> > > > > > > > not only easier to secure, but additionally more performant.
> > > > > > >
> > > > > > > Verifier doesn't always know exact offset at which program is going to
> > > > > > > read read-only map contents. So something like this works:
> > > > > > >
> > > > > > > const volatile long arr[256];
> > > > > > >
> > > > > > > int x = rand() % 256;
> > > > > > > int y = arr[x];
> > > > > > >
> > > > > > > In this case verifier doesn't really know the value of y, so it can't
> > > > > > > be inlined. Then you can have code in which in one branch register is
> > > > > > > loaded with known value, but in another branch same register gets some
> > > > > > > value at random offset. Constant tracking is code path-sensitive,
> > > > > > > while instructions are shared between different code paths. Unless I'm
> > > > > > > missing what you are proposing :)
> > > > > >
> > > > > > Ah, I missed that possibility. But is that actually something that
> > > > > > people do in practice? Or would it be okay for the verifier to just
> > > > > > assume an unknown value in these cases?
> > > > >
> > > > > Verifier will assume unknown value for the branch that has variable
> > > > > offset. It can't do the same for another branch (with constant offset)
> > > > > because it might not yet have encountered branch with variable offset.
> > > > > But either way, you were proposing to rewrite instruction and inline
> > > > > read constant, and I don't think it's possible because of this.
> > > >
> > > > Ah, I see what you mean. That sucks. I guess that means that to fix
> > > > this up properly in such edgecases, we'd have to, for each memory
> > > > read, keep track of all the values that we want to hardcode for it,
> > > > and then generate branches in the unlikely case that the instruction
> > > > was reached on paths that expect different values?
> > >
> > > I guess, though that sounds extreme and extremely unlikely.
> >
> > It just seems kinda silly to me to have extra memory loads if we know
> > that those loads will in most cases load the same fixed value on every
> > execution... but oh well.
> >
> > > I'd say
> > > the better way would be to implement immutable BPF maps from the time
> > > they are created. E.g., at the time of creating map, you specify extra
> > > flag BPF_F_IMMUTABLE and specify pointer to a blob of memory with
> > > key/value pairs in it.
> >
> > It seems a bit hacky to me to add a new special interface for
> > populating an immutable map. Wouldn't it make more sense to add a flag
> > for "you can't use mmap on this map", or "I plan to freeze this map",
> > or something like that, and keep the freezing API?
>
> "you can't use mmap on this map" is default behavior, unless you
> specify BPF_F_MMAPABLE.

Ah, right.

> "I plan to freeze this map" could be added,
> but how that would help existing users that freeze and mmap()?
> Disallowing those now would be a breaking change.
> Currently, libbpf is using freezing for .rodata variables, but it
> doesn't mmap() before freezing.

Okay, so it sounds like there are probably no actual users that use
both BPF_F_MMAPABLE and freezing, and so we can just forbid that
combination? That sounds great.

> What we are talking about is malicious
> user trying to cause a crash, which given everything is under root is
> a bit of a moot point. So I don't know if we actually want to fix
> anything here, given that lots of filesystems are already broken for a
> while for similar reasons... But it's certainly good to know about
> issues like this.

Well, it's not just "crash", it's full write access to kernel memory.
I think such issues should be fixed for robustness reasons; and if BPF
does not fix such issues, that goes against the intent of Matthew
Garrett's lockdown LSM, and we'll have to block all of BPF in
lockdown's integrity mode if we ever want to get to a point where
lockdown actually does anything.

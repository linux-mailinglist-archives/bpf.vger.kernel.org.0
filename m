Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7F51602C
	for <lists+bpf@lfdr.de>; Tue,  7 May 2019 11:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfEGJJY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 May 2019 05:09:24 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37853 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfEGJJY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 May 2019 05:09:24 -0400
Received: by mail-ot1-f65.google.com with SMTP id u3so8749148otq.4
        for <bpf@vger.kernel.org>; Tue, 07 May 2019 02:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9buAf+Ew4etQY23xlS97C5dXN/p+SbG8D1dqNa3yIs4=;
        b=mdQDxalGn4qon6F4ag4iLavez9Y9Mc3vuE46CicjvrETUtliFTa4W4buJPHCV3dN8O
         w+5510ZK9dAZcXz7neUQjrcREU5ZRXQdD+mbmP46qpmlTaeRqxkcV+PdHb14vjNCrIiQ
         XPwGzxHsySryMgBfquf0T0i/XpOPPWPAMdBDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9buAf+Ew4etQY23xlS97C5dXN/p+SbG8D1dqNa3yIs4=;
        b=UVmbbv+JAB+LMOorAiEXGQ8dexZ5cfRnYs+yDQ1yK7ECymT05nKInDSctm9LcZAsqC
         4WJbYF64KIIvb0ZRiTCf43yRJ0cWd9QTN/+0liTTUXkS3oJ4f1i1d15MQUI4ZB8jaIGr
         eav5FDmUkQLsF1xlg1Rz5XCwBDEevXDzUXlNEiakiQ1or9EZrP/GzigGKK+v9YnhgF0G
         CAzs27fSOAMNVQSQAxLiNG4xgNWztGYWVSc7d9WWJGNtcX1eCAuUeIMRnMb+xDIPywq5
         hPKOY5C6yua7lCQ6oN7bKFZyvTomt9VHa9BfMtAVOLDGfMTcyXQIpr3qC9sbvDC8txcN
         FwcQ==
X-Gm-Message-State: APjAAAWk6hfgqaAKhsgTHwEEu0q/8lpBpGXP7aYYxVEb3QGa0mWkPMWn
        bhFg/rge/G0dmqcdC3BKu5otUIEaYL8sI5sraoQ7DQ==
X-Google-Smtp-Source: APXvYqyCw6N3VjBHN/0D0FgLupiWCkQSxbRQR8aZNK5NUwS/oh78xjYoWoew5kMkyDB5YhigBmYaiwV/E80s96f6J2U=
X-Received: by 2002:a9d:5d08:: with SMTP id b8mr21140722oti.181.1557220163397;
 Tue, 07 May 2019 02:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190502154932.14698-1-lmb@cloudflare.com> <20190502160324.uroud3xrggnfgvrp@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20190502160324.uroud3xrggnfgvrp@kafai-mbp.dhcp.thefacebook.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 7 May 2019 10:09:12 +0100
Message-ID: <CACAyw9-HMaFh3it_nPs96+tdthbhzV+cjEfFNT_G20ghKCwfvQ@mail.gmail.com>
Subject: Re: [PATCH bpf] libbpf: always NULL out pobj in bpf_prog_load_xattr
To:     Martin Lau <kafai@fb.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2 May 2019 at 17:03, Martin Lau <kafai@fb.com> wrote:
>
> On Thu, May 02, 2019 at 11:49:32AM -0400, Lorenz Bauer wrote:
> > Currently, code like the following segfaults if bpf_prog_load_xattr
> > returns an error:
> >
> >     struct bpf_object *obj;
> >
> >     err = bpf_prog_load_xattr(&attr, &obj, &prog_fd);
> >     bpf_object__close(obj);
> This is a bug.  err should always be checked first before
> using obj or prog_fd.  If there is err, calling bpf_object__close(NULL)
> is another redundancy.

Ack, I'll send another patch. The bug is in a couple of places, so I
figured that this is something people do naturally.

>
> >     if (err)
> >         ...
> >
> > Unconditionally reset pobj to NULL at the start of the function
> > to fix this.
> Hence, this change is unnecessary.
>
> >
> > Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> > ---
> >  tools/lib/bpf/libbpf.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 11a65db4b93f..2ddf3212b8f7 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -3363,6 +3363,8 @@ int bpf_prog_load_xattr(const struct bpf_prog_load_attr *attr,
> >       struct bpf_map *map;
> >       int err;
> >
> > +     *pobj = NULL;
> > +
> >       if (!attr)
> >               return -EINVAL;
> >       if (!attr->file)
> > --
> > 2.19.1
> >



-- 
Lorenz Bauer  |  Systems Engineer
25 Lavington St., London SE1 0NZ

www.cloudflare.com

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB832662BF
	for <lists+bpf@lfdr.de>; Fri, 11 Sep 2020 18:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgIKP77 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Sep 2020 11:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbgIKP4b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Sep 2020 11:56:31 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7425AC061757
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2020 08:56:31 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id h6so8205912qtd.6
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2020 08:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HB1wLkJBUPBITqr249AFzq+PR4Y7nrQ2PRnzX2SICNU=;
        b=q6mTZynvnuOIdXFxtOD49r+38vJ9B5saRc3IwrULNNlQw4i2QImBldf6kJg536NWqQ
         GuKZ/xQg/z2eqdHj+zDrvIhQNnmNLfLw8ECIGw+EwdIEgxnu0xezOYq9N/7fndQWfmag
         6k+kkjfPeDFhTJC/hptFfjQQV38r2owSheIlqMRlvKQ+bcAIVgYNuNe9Bvzi1nbxTduG
         /u4KOemjjBSZk5dPMYz7NCp2aWO/jA58SA8yHuUSzGtFHCHJ0/7X5MYTKzb3Ks50byML
         85feoiOX3GWXU03Gi6PcPD2H0JbSQvT5ljbgA+baUamBozteFMGwONWP3fwYRozpHxCy
         Ojpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HB1wLkJBUPBITqr249AFzq+PR4Y7nrQ2PRnzX2SICNU=;
        b=llbGSuLv6BDp7JyrT2KydIPACoEiP3cmyoTgxd6CopV1U5TUJ4cfPuTBxOTlp9d2ei
         dp4O4/F/9Rf3VSAdN/ScPfjIGrMLN571nSBXN0E9ohGFhlV7rZuAmXUEGo/ivHpPQYLN
         YDxUEQq0xoDQa4mMkOnQ+j95IgF4pvO6RDxTUO0lVAXbjsUwM2gMcoubLYwzJfLyGIql
         4EBKMehNvdF+o65+OXmoIeJkrQwwuQOxXyEhP1UpRTiNIt3Essur++4GS4pj4kqBZteH
         pKv4dtZ5n7Vw1kv8UCmV6WVWpMO1WWQCu21tHyXEFKdoyQbmAhlbHI9zPUGrzdoyH1mN
         CaMQ==
X-Gm-Message-State: AOAM5313JUNSmzt+lwvjGS1Fb/Wfl29wjak5pUJM2phm0OW9xSAQyGrT
        Lt9A83I1b3m6e0N2I/vKKohJjViLCyvPBq/45aS3Og==
X-Google-Smtp-Source: ABdhPJwX6e9cju+FL0v94+Z0/0T0ORtkFdzm5HvbrtkrybQyiKcZ93D1C9S02/CEAgsWDiMYufPy6anpHcb8ShTao1Q=
X-Received: by 2002:ac8:4784:: with SMTP id k4mr2595978qtq.266.1599839790431;
 Fri, 11 Sep 2020 08:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200909182406.3147878-1-sdf@google.com> <20200909182406.3147878-5-sdf@google.com>
 <CAEf4BzaWxnm_X=nZWn0tcq7bMnbL8ZFDuU=qzMNDh_aSAayXsA@mail.gmail.com>
In-Reply-To: <CAEf4BzaWxnm_X=nZWn0tcq7bMnbL8ZFDuU=qzMNDh_aSAayXsA@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 11 Sep 2020 08:56:19 -0700
Message-ID: <CAKH8qBtiMh1evaQ-CQ83nESSS2UQLCM7avydoXvqY6aM+GHwDw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 4/5] bpftool: support dumping metadata
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        YiFei Zhu <zhuyifei1999@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 10, 2020 at 12:54 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Sep 9, 2020 at 11:25 AM Stanislav Fomichev <sdf@google.com> wrote:
> > diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> > index f7923414a052..ca264dc22434 100644
> > --- a/tools/bpf/bpftool/prog.c
> > +++ b/tools/bpf/bpftool/prog.c
> > @@ -29,6 +29,9 @@
> >  #include "main.h"
> >  #include "xlated_dumper.h"
> >
> > +#define BPF_METADATA_PREFIX "bpf_metadata_"
> > +#define BPF_METADATA_PREFIX_LEN strlen(BPF_METADATA_PREFIX)
>
> this is a runtime check, why not (sizeof(BPF_METADATA_PREFIX) - 1) instead?
Make sense, will fix.

> > +static int bpf_prog_find_metadata(int prog_fd, int *map_id)
> > ...
> > +free_map_ids:
> > +       saved_errno = errno;
> > +       free(map_ids);
> > +       errno = saved_errno;
>
> not clear why all this fussing with saving/restoring errno and then
> just returning 0 or -1? Just return -ENOMEM or -ENOENT as a result of
> this function?
Yeah, I just moved this function from it's original (libbpf) location as is.
I guess it makes sense to simplify the error handling now that
it's not in exported from libbpf.

> > +       if (bpf_map_lookup_elem(map_fd, &key, value))
> > +               goto out_free;
> > +
> > +       err = btf__get_from_id(map_info.btf_id, &btf);
> > +       if (err || !btf)
> > +               goto out_free;
>
> if you make bpf_prog_find_metadata() to do this value lookup and pass
> &info, it would probably make bpf_prog_find_metadata a bit more
> usable? You'll just need to ensure that callers free allocated memory.
> Then show_prog_metadata() would take care of processing BTF info.
Sounds reasonable. I can maybe keep existing
bpf_prog_find_metadata (rename to bpf_prog_find_metadata_map_id?)
and add another wrapper that does that map lookup.

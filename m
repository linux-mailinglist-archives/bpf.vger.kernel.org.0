Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB82F46CBB1
	for <lists+bpf@lfdr.de>; Wed,  8 Dec 2021 04:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238300AbhLHDpY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Dec 2021 22:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbhLHDpY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Dec 2021 22:45:24 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0C2C061574
        for <bpf@vger.kernel.org>; Tue,  7 Dec 2021 19:41:53 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id w14so905941qkf.5
        for <bpf@vger.kernel.org>; Tue, 07 Dec 2021 19:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gQfAhuXOX6FW/ZgjnahGUuly5JSw9KNECgeH4N0wNxs=;
        b=MKHjpO1trOM8EimTPP4r701XjsO99WFxDz7YladXnLu5K1sfTEZDwHjSkkrtYT/9RF
         gNTFytAYZKD2rjUK635e8Go4FbWVvz4sb3IXareUofwK6tzIZaz9wa1ud2SllERmP85r
         nqKHnGnRIqzknU44xrK0EZ3SjKP5w3ZlJ9ujENV2AFXqh4iB2c1UBK3/xHrUGtfoj/aE
         rqoQoQy2MfZyvy+2Q19L35cvJ+b8m5oPQw53PW6mCGcXf5bTTcj1uJTzQp2RgT1OWP8q
         YP+OGtS4jjg4BJRjhpVKd+6945Db08UCeSaOX4UV1Q4b5XIwOW1titAAvZ5O8/gWGgEx
         lsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gQfAhuXOX6FW/ZgjnahGUuly5JSw9KNECgeH4N0wNxs=;
        b=2qj7j+lIFStKUgazJDNUEk0W5KslvRkcgBYDzqxL1bHkusEatu13pdno++NNT5qT42
         6owUzVxeknxcjzMNkiuvALxVZNm6Rm49t8z4RxCgMfPWpUXaVHRnpqe2NXa1xAtwuW0b
         BUjQLvI8oNBefHf+mVwNEbIo5A7/HP0rc3c4g/1zryb9J80zrCDpbY0rNy6yv1qoMQIJ
         ihn+7pFAVzjDiiXKhrwrvIf9rwRAysRHGYFZlmJvztwoavwsoyaXl6GFIKmqWc53YgJM
         9ZM2E6GIaysFJAH3dBISD+Yp5qksJRfqK08+KyOiaKslf/NhMZ4NNWX56/IlUVe/koQ+
         dddw==
X-Gm-Message-State: AOAM5335qJU2CgyHNaxR2cgLowXj0YfswQJJjhn2IFqYnEqKvpMcQn7d
        yyTxDZnfqefr4s9Kt/WvfxGrSRmZ+UhdwZ4ptyi0Lw==
X-Google-Smtp-Source: ABdhPJyhms0pvQyyEYt9y8E1tyDeD+YKMGp0QTxSegITXB1VtEGh8AuDmI5DYbCIkUe27J9CZS3ciC7e40aMfztMtNQ=
X-Received: by 2002:a05:620a:454d:: with SMTP id u13mr3766583qkp.221.1638934912183;
 Tue, 07 Dec 2021 19:41:52 -0800 (PST)
MIME-Version: 1.0
References: <20211206232227.3286237-1-haoluo@google.com> <20211206232227.3286237-6-haoluo@google.com>
 <CAEf4BzZ6_KQjnn60pSfadgPOMv2bwme1ajDh89Ziuqogmgd-0g@mail.gmail.com>
In-Reply-To: <CAEf4BzZ6_KQjnn60pSfadgPOMv2bwme1ajDh89Ziuqogmgd-0g@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 7 Dec 2021 19:41:41 -0800
Message-ID: <CA+khW7gRHtvX6YvJM+uM2F=uUA14VjMfx3M8qqew3YyW_3v7mQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 5/9] bpf: Introduce MEM_RDONLY flag
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 6, 2021 at 10:14 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Dec 6, 2021 at 3:22 PM Hao Luo <haoluo@google.com> wrote:
> >
> > This patch introduce a flag MEM_RDONLY to tag a reg value
> > pointing to read-only memory. It makes the following changes:
> >
> > 1. PTR_TO_RDWR_BUF -> PTR_TO_BUF
> > 2. PTR_TO_RDONLY_BUF -> PTR_TO_BUF | MEM_RDONLY
> >
> > Signed-off-by: Hao Luo <haoluo@google.com>
> > ---
> >  include/linux/bpf.h       |  8 +++--
> >  kernel/bpf/btf.c          |  3 +-
> >  kernel/bpf/map_iter.c     |  4 +--
> >  kernel/bpf/verifier.c     | 76 +++++++++++++++++++++++----------------
> >  net/core/bpf_sk_storage.c |  2 +-
> >  net/core/sock_map.c       |  2 +-
> >  6 files changed, 55 insertions(+), 40 deletions(-)
> >
>
> [...]
>
> >  static bool arg_type_may_be_refcounted(enum bpf_arg_type type)
> >  {
> >         return type == ARG_PTR_TO_SOCK_COMMON;
> > @@ -541,8 +546,7 @@ static const char *reg_type_str(enum bpf_reg_type type)
> >                 [PTR_TO_BTF_ID]         = "ptr_",
> >                 [PTR_TO_PERCPU_BTF_ID]  = "percpu_ptr_",
> >                 [PTR_TO_MEM]            = "mem",
> > -               [PTR_TO_RDONLY_BUF]     = "rdonly_buf",
> > -               [PTR_TO_RDWR_BUF]       = "rdwr_buf",
> > +               [PTR_TO_BUF]            = "rdwr_buf",
>
> super misleading if it's actually read-only...
>

True. :)

I will have it fixed in v2. See the reply on patch 4/9 for a potential solution.

> >                 [PTR_TO_FUNC]           = "func",
> >                 [PTR_TO_MAP_KEY]        = "map_key",
> >         };
>
> [...]

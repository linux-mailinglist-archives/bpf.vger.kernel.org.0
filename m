Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB1B4A6978
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 02:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243171AbiBBBGO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 20:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiBBBGO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Feb 2022 20:06:14 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C274C061714
        for <bpf@vger.kernel.org>; Tue,  1 Feb 2022 17:06:14 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id r144so23492960iod.9
        for <bpf@vger.kernel.org>; Tue, 01 Feb 2022 17:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XZILtTq0D3F5vArQ4Pcqv+pecfBzNfyy67GnoSH0+z8=;
        b=kZvmdB3v2ZWgkf77/QNDbZ+SqeSQ3qUZmcAL4bGCIY7Fo7IHkorBLtQKGwBhl8rAK+
         bL5r+7GV8SXn+zTm7o9GCSlervHQVlY54qXwEBUKMOnQ/MrhZOhu1qHVqxouVabKJEdr
         RSHv32zIV2Z2ut8a7fIGjntBrVoINOeRJcUm1TABJQCxya4GPv2TrGsjLZzHULtigIdy
         lOzKNymuwkFJbc/vuP2O3cF5n3j5MLHatMVbvz93f1Q1XBJAQ9EPFtzhiz4DJs8qT49G
         srMnpAaswrWyiNLBPpwxuwIW3jeF8ztVkB9u+mHTQ+b1oc6tEO8SNkjKrRvtsyUpNXxa
         aD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XZILtTq0D3F5vArQ4Pcqv+pecfBzNfyy67GnoSH0+z8=;
        b=S4B6GpRziZMB1pmixDV6YcToFihMZz6Mjl7r5SkJhf/RsL6TPQyN7DAuUZBQmaFng0
         xgDNlrsOhmZK6fUOO7vAsxNoRsnkgQhWDRfxOB7UvtbIc/gpzoUqkmKo+epgh7HjhO1K
         X5Xbm471jDG6SYbE+jWRWaOcRKwABEjuVO78bLzcmEDzlI40XqambAJD2OwKuX5n0Ee0
         x+3QWhYijhOMAyTE6RY5U84f7NZNpIdrY+pOBz7otxMZAhwUgYcvr7HPPA9hCnCNavGK
         ouwvPCXST7YHbDlyWc7G839hOcwejdmhQNIbFY5MfGJFOoTsPXvG+mop5ZzxoEde56k4
         WbDg==
X-Gm-Message-State: AOAM531ZUSn/o94/C2PPqjGp+XDeb9CYaQYWY9UkPijgHogONQKbUEQe
        lQtBxZErIQJSBSkWgneUMBE8LHkweckVbuuNKn4=
X-Google-Smtp-Source: ABdhPJzq+ek7w9RzSvuiPOpoHW8IRuPqFORNtxVtBd7nlgoupQ888ZhXH8AJqDrGpiylf+W3mIxsyqs+m2tJ8gRrpVc=
X-Received: by 2002:a02:2422:: with SMTP id f34mr14447134jaa.237.1643763973476;
 Tue, 01 Feb 2022 17:06:13 -0800 (PST)
MIME-Version: 1.0
References: <20220126214809.3868787-1-kuifeng@fb.com> <CAADnVQKkJCj+_aoJN2YtS3-Hc68uk1S2vN=5+0M0Q9KRVuxqoQ@mail.gmail.com>
 <CAEf4BzYFFnBnLu0ue8HoeZDD6V3DBKZFFKSA7VnL=duQgqc-nQ@mail.gmail.com> <8f1d25d8c01d7397192e3c034330c5f757eabea0.camel@fb.com>
In-Reply-To: <8f1d25d8c01d7397192e3c034330c5f757eabea0.camel@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 1 Feb 2022 17:06:02 -0800
Message-ID: <CAEf4BzbL7Y61vDPwEc6TMb8Mp99zN4iL3SHGsOEN-YYWL7E__Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] Attach a cookie to a tracing program.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 1, 2022 at 9:37 AM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> On Mon, 2022-01-31 at 22:45 -0800, Andrii Nakryiko wrote:
> ...... cut ......
> > For multi-attach fentry, we could use the same approach if we let
> > either bpf_link or bpf_prog available to fentry/fexit program at
> > runtime. Kui-Feng seems to be storing prog_id in BPF trampoline
> > generated code, I don't think that's the best approach, it would be
> > probably better to store bpf_link or bpf_prog pointer, whichever is
> > more convenient. I think we can't attach the same BPF program twice
> > to
>
> FYI, the prog_id used is casting from a bpf_prog pointer.  It gets a
> bpf_prog by casting a prog_id back.
>

Ok, this is why we all got confused. There is already a concept of
"prog ID" (it is also visible to user-space, btw), but you were
actually storing an actual `struct bpf_prog *` pointer. So just a
misleading use of the term in this context.

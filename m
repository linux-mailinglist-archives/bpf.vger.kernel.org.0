Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE3A444642
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 17:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhKCQvw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Nov 2021 12:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbhKCQvt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Nov 2021 12:51:49 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F16C061203
        for <bpf@vger.kernel.org>; Wed,  3 Nov 2021 09:49:13 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id j5-20020a17090a318500b001a6c749e697so1495357pjb.1
        for <bpf@vger.kernel.org>; Wed, 03 Nov 2021 09:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m7bFvuQN9zk0mHLWmYkPWqt2EmUXh5X8ZDOe9W+hOoA=;
        b=kvBhnUxaGzuwJUL5i5HED8fJOhnx9CVSEaTZ4SgEn3sk05cMBgKYCrXvf0aewqm798
         SkPfSxIMv1bSJuq9t8lnaZHcsoM/sAxK/XvAJvqqeTBFZWWRUs0DOe/gIH2TMXEVpfK3
         Qr1fkaV7KANOdM/wkXqzFrO6Vsza9+kqRWiaEJ9PKT0Yc+/fYA1X3gEmb73zQ6+0Kprl
         badOyelqEvWYyl9vRbJgAC2ozDLXva7PHYfPjyYnJ4NzJ/jFpx2M2OqGDS/vnP+bfFaM
         Jn2n/700DorsNvB7TJrlBp7zMA2WMCm8zDD7TdaIkslF9nu5YKYeru4pBeCKdXH0kfvU
         YEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m7bFvuQN9zk0mHLWmYkPWqt2EmUXh5X8ZDOe9W+hOoA=;
        b=kDYXyH1vgypXVrr4cRYjnJ8qEwL7Jtt2oFXNlpSo+cVdAhpOlT8+aJGnxnVaE83Uym
         T06/yfQhWNev6CkpQOngW4dVBZCZEn9f9YrF9bNQFm55V0ZbJ0zlrCn62uJldF0jK8o8
         HTuxgrl/D3RMzcdt9CURo7Fc1sKpXOSSvMLiymXLDL7J7mrXdPaXmeQU7DYEwwxiccmS
         XkHZ07Oaq4jDeD+jaG+2m631xaUns+62OANhFdy4+3ItSGxL1fMLbVvokVunXZX0dzpJ
         xPyX1oqiqmq5uXrD6wfA/mKqra+TQKHGs9XbEBWqugQ832AOsdp+B4a8nv+NlzHOR1/q
         wJVA==
X-Gm-Message-State: AOAM5323561CeXxEZdU5enVojhy0m4a0guBD0QjPBpaCl+UMzy8NUxdl
        LW6SUAn9dS8Lsv8C9boehRskXL1R0w/BF8Ne66k=
X-Google-Smtp-Source: ABdhPJwjdK48tV9+Q2a3FHfnKgDmWoWZGL2v8hIA/0P3z383Vx20H6znD4CL0y4rXBYH7tvEtarQn4FOHjZQjtwyCCk=
X-Received: by 2002:a17:903:2306:b0:141:e52e:457d with SMTP id
 d6-20020a170903230600b00141e52e457dmr21311721plh.3.1635958152775; Wed, 03 Nov
 2021 09:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <269c70c6c529a09eb6d6b489eb9bf5e5513c943a.1635196496.git.lorenzo@kernel.org>
 <CAADnVQLG-T-7mLgVY9naMKGog-Qcf3yoZRvZLJqm55iAPhFEhQ@mail.gmail.com>
 <YYHUabJ5TedbUsd/@lore-desk> <CAADnVQKAX-6mFBXWDDjF3Hdi-KbAzhTHtiNa2ePHSTb+3SVGDw@mail.gmail.com>
 <YYK8bmBFriIgh4O+@lore-desk>
In-Reply-To: <YYK8bmBFriIgh4O+@lore-desk>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 3 Nov 2021 09:49:01 -0700
Message-ID: <CAADnVQLfTYBtj9_zfxJPt261wEu1t_nzjH_XbzQ+Zr59MmUWFg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: introduce bpf_map_get_xdp_prog utility routine
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 3, 2021 at 9:44 AM Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> > That patch alone is unnecessary.
>
> Yes, right. Sorry for the noise.
> Regarding this patch, do you want me to repost with a proper commit log (maybe
> included in the xdp multi-buff series) or do you prefer to just drop it?

I think this patch alone is not necessary.
When you'll get to the full series it could be meaningful.
It's hard to tell without seeing the rest of the patches.

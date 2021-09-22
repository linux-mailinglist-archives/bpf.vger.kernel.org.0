Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0FE4153C6
	for <lists+bpf@lfdr.de>; Thu, 23 Sep 2021 01:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238406AbhIVXQ0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Sep 2021 19:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238293AbhIVXQZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Sep 2021 19:16:25 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B2DC061574
        for <bpf@vger.kernel.org>; Wed, 22 Sep 2021 16:14:55 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id q81so11981062qke.5
        for <bpf@vger.kernel.org>; Wed, 22 Sep 2021 16:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3IUCCnpMiAx+Sp4ZYwWaipPgU9Vrqsgzsabw00i6aQ0=;
        b=oFe/vVtt4W71JBCL3eqYLjEPHWxEaUDN0EO4XBmQsxbIe5P8yuui7PDmif9d1sCpXB
         4vYYcah+FyNRYtnCqNGOHrbaJobzbBfbMHj+jZWMjQnbliRgaJQ85fqkrlz90gyq/p7C
         3/s8h6ylgS2Eb9XWHdtHqfD+spro5Y0e8urEJ8ppmen60WvwEz76pWe7bgwGf1KhL7wS
         Eh5rVg/f/BHrRUpFtohbmUJk2gD3wm8TOwQM7t1CckAmU0+0Irypjt/x7B5b/4p55zQF
         CqKaFN13mdWh7RdlvyThtyMHHwTH0zp/fqY09b0MJs0bLk60XgdypZ3C5KuUc0yfyN6Q
         1dOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3IUCCnpMiAx+Sp4ZYwWaipPgU9Vrqsgzsabw00i6aQ0=;
        b=Ufk3hnuchBGm5wXAsfq34lllKE+1y6qd2ZFWe+5/xaulV6Kn1UkVn3Fx39zpvs7GWk
         War/yRekjVtdOvtJgCNBIpJoA5p+QxzYCw1QryrUx1dVApKnE8otwCAuALtkLIpg+ukp
         Uo+U9TQvpFRZMMDU4R9T1botV5x+M0CC37GKoSp7B5f4kDR8DkbSjwtlX9dOmMFIAOug
         iBWM5tabL9ZnVSqXGDDJUm7bmH0JIzDnliXglxjLssm9bD8bPapjD4lujiGZ261ojlja
         mETMoLBh9BnMY+DNTnvBnoUyDlLVehAU1AgsG+jfMcQC9E8dqyN5jVNQ/hjVDAU4NPu5
         63Fw==
X-Gm-Message-State: AOAM533/9iu5CDfph5nw55H7j24CATIqmO4S9usk/+1+CbrHIjkOuRA/
        hoUA/XqA7x1BHiC6CDyroZQVp/l2fZxbgEy7o1m1FXwX
X-Google-Smtp-Source: ABdhPJzcDrzd9I8vsbHqc9PC5Pq5rut9K/T11qnIQfAL2F/aojBKylmCgpJX+Ne9Qm0/RS4UCr0oDFw7d3PiU+eLIbY=
X-Received: by 2002:a25:1884:: with SMTP id 126mr2054511yby.114.1632352494187;
 Wed, 22 Sep 2021 16:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210921210225.4095056-1-joannekoong@fb.com> <20210921210225.4095056-3-joannekoong@fb.com>
 <9d26bf60-6a74-f994-d199-1babcd4b1943@fb.com>
In-Reply-To: <9d26bf60-6a74-f994-d199-1babcd4b1943@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 22 Sep 2021 16:14:43 -0700
Message-ID: <CAEf4Bza4r3J4pw+_xXawSqGTO_iXc9kXu9eVGp1teLsKoVoVNA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 2/5] libbpf: Allow the number of hashes in
 bloom filter maps to be configurable
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 21, 2021 at 7:02 PM Joanne Koong <joannekoong@fb.com> wrote:
>
>
> On 9/21/21 2:02 PM, Joanne Koong wrote:
> > This patch adds the libbpf infrastructure that will allow the user to
> > specify a configurable number of hash functions to use for the bloom
> > filter map.
> >
> > Please note that this patch does not enforce that a pinned bloom filter
> > map may only be reused if the number of hash functions is the same. If
> > they are not the same, the number of hash functions used will be the one
> > that was set for the pinned map.
> >
> > Signed-off-by: Joanne Koong <joannekoong@fb.com>
> > ---
> >   include/uapi/linux/bpf.h        |  5 ++++-
> >   tools/include/uapi/linux/bpf.h  |  5 ++++-
> >   tools/lib/bpf/bpf.c             |  2 ++
> >   tools/lib/bpf/bpf.h             |  1 +
> >   tools/lib/bpf/libbpf.c          | 32 +++++++++++++++++++++++++++-----
> >   tools/lib/bpf/libbpf.h          |  2 ++
> >   tools/lib/bpf/libbpf.map        |  1 +
> >   tools/lib/bpf/libbpf_internal.h |  4 +++-
> >   8 files changed, 44 insertions(+), 8 deletions(-)
> >

[...]

> >
> >   struct btf_map_def {
> > @@ -201,6 +202,7 @@ struct btf_map_def {
> >       __u32 map_flags;
> >       __u32 numa_node;
> >       __u32 pinning;
> > +     __u32 nr_hash_funcs;
> >   };
> >
>
> I just realized that Andrii's comment on v1 stated that btf_map_def is
> fixed indefinitely.
>
> This implies that for bloom filter maps where the number of hash
> functions needs to be set,
> we will not be able to use the BTF-defined format and will instead need
> to use the older
> map definition that uses bpf_map_def. Is my understanding of this
> correct? If so, I will go
> ahead and fix this for v4.

You are confusing bpf_map_def (which is part of the public libbpf API,
even if to-be-deprecated) and btf_map_def, which is only
libbpf-internal. So it's ok to modify that struct.

>
> >   int parse_btf_map_def(const char *map_name, struct btf *btf,

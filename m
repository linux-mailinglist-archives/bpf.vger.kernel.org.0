Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD106BC33D
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 02:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjCPBT6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Mar 2023 21:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjCPBT5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Mar 2023 21:19:57 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7014928E44
        for <bpf@vger.kernel.org>; Wed, 15 Mar 2023 18:19:54 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id h8so1590453ede.8
        for <bpf@vger.kernel.org>; Wed, 15 Mar 2023 18:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1678929593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6WPmqtphJvBgFBNycelI/R5ZAd4TzcDyEgrAAAfBQY=;
        b=aAGaaforSe9E7/ymyqTllBFc0Dq2h/pC81v2JehvjJM78NuBxFBUFbYavRPFwjXlki
         G0Hg59IHQsWqjIkirlZrclHMfb1MLTAPEt99ja+FBBLxBapcjKnyIC8qoeXHc3IuLMwO
         +XZBWFdbLv6S9a2bStfyYIuqeqHOVMCcNowJbyQH/xFAsb1qlybPwy7mBO3mGc0aNpUt
         ufok0iQ2kTCjQ8GCqANnmWnRPs3YbeVwX2wR1Kl/lNpojTtmnCoCeHIvTAPX9pLLCfZa
         +WoAtZtAclBvpB3UNtJJd+P7kh+3ewd21rmUtHh0ZhwG60YoR5TbeNq5/RvCu8mgY6Yx
         6XeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678929593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X6WPmqtphJvBgFBNycelI/R5ZAd4TzcDyEgrAAAfBQY=;
        b=luk5KkWg7oMSsAcwDyrpV44dCKeaxphDJodszUbqhhcMSYFuytbzRblE9jMm2sBkI/
         9lc68/oNQMOAasZ4raQpIfP71mt9KCG6CRNw0hMil6Jb255B2rPZOfHjYw/zjv8mm6qh
         miqm+uBH65qN8I+pwg4owhOuH1Su8n66WtuXvH5EepZVLBPq+29F8N0Lp3iBIuO7OjDF
         siHkgdpdnrsHp8QLLXq66foJ9jxzXo4u/EdzvgNrRmay2euRtjKUdyBQ42gXmVwNejbV
         KVQn/HzxBZ72uYPUuEXx/EclXzJWWbXwYV8do6hC57yWrca96hGMVQmeHZFSBArPMZWE
         oy0w==
X-Gm-Message-State: AO0yUKU0NVL0Cws7c/EfUf9bqoN6an2Jyb2EQNgeWwvX1DEkehhMba11
        o4ApJDck4Ap22CXASbBa6UO2V156nkpRStlJ0yB7Yg==
X-Google-Smtp-Source: AK7set9ZnAfCv1TXEp81dZGBQciEmGQx6bFkwQnlONPgDH2FTJCnypC62XYn1tZsJ3llLR6dsQoe5StrCFYD5E9eWa0=
X-Received: by 2002:a50:9f48:0:b0:4fa:d919:86dd with SMTP id
 b66-20020a509f48000000b004fad91986ddmr2533880edf.4.1678929592868; Wed, 15 Mar
 2023 18:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230312190600.324573-1-joe@isovalent.com> <6410046013834_42581208fd@john.notmuch>
In-Reply-To: <6410046013834_42581208fd@john.notmuch>
From:   Joe Stringer <joe@isovalent.com>
Date:   Wed, 15 Mar 2023 18:19:41 -0700
Message-ID: <CADa=Rywk4cm7LB_QQO662Mqjnb=HNb=Gnj76Jm+AYE15SUp6Uw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] docs/bpf: Add LRU internals description and graph
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, corbet@lwn.net,
        martin.lau@linux.dev, bagasdotme@gmail.com, maxtram95@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 13, 2023 at 10:21=E2=80=AFPM John Fastabend
<john.fastabend@gmail.com> wrote:
>
> Joe Stringer wrote:
> > Extend the bpf hashmap docs to include a brief description of the
> > internals of the LRU map type (setting appropriate API expectations),
> > including the original commit message from Martin and a variant on the
> > graph that I had presented during my Linux Plumbers Conference 2022 tal=
k
> > on "Pressure feedback for LRU map types"[0].
> >
> > The node names in the dot file correspond roughly to the functions wher=
e
> > the logic for those decisions or steps is defined, to help curious
> > developers to cross-reference and update this logic if the details of
> > the LRU implementation ever differ from this description.
> >
> > [0]: https://lpc.events/event/16/contributions/1368/
> >
> > Signed-off-by: Joe Stringer <joe@isovalent.com>
>
>
> Thanks couple nits below
>
> > ---
> > v3: Use standard table syntax
> >     Replace inline commit message with reference to commit
> >     Fix incorrect Y/N label for common LRU check
> >     Rename some dotfile variables to reduce confusion between cases
> >     Minor wording touchups
> > v2: Fix issue that caused initial email submission to fail
> > ---
> >  Documentation/bpf/map_hash.rst            |  62 ++++++++
> >  Documentation/bpf/map_lru_hash_update.dot | 166 ++++++++++++++++++++++
> >  2 files changed, 228 insertions(+)
> >  create mode 100644 Documentation/bpf/map_lru_hash_update.dot
> > diff --git a/Documentation/bpf/map_hash.rst b/Documentation/bpf/map_has=
h.rst
> > index 8669426264c6..61602ce26561 100644
> > --- a/Documentation/bpf/map_hash.rst
> > +++ b/Documentation/bpf/map_hash.rst
> > @@ -1,5 +1,6 @@
> >  .. SPDX-License-Identifier: GPL-2.0-only
> >  .. Copyright (C) 2022 Red Hat, Inc.
> > +.. Copyright (C) 2022-2023 Isovalent, Inc.
> >
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  BPF_MAP_TYPE_HASH, with PERCPU and LRU Variants
> > @@ -206,3 +207,64 @@ Userspace walking the map elements from the map de=
clared above:
> >                      cur_key =3D &next_key;
> >              }
> >      }
> > +
> > +Internals
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +This section of the document is targeted at Linux developers and descr=
ibes
> > +aspects of the map implementations that are not considered stable ABI.=
 The
> > +following details are subject to change in future versions of the kern=
el.
> > +
> > +``BPF_MAP_TYPE_LRU_HASH`` and variants
> > +--------------------------------------
> > +
> > +An LRU hashmap type consists of two properties: Firstly, it is a hash =
map and
> > +hence is indexable by key for constant time lookups. Secondly, when at=
 map
> > +capacity, map updates will trigger eviction of old entries based on th=
e age of
> > +the elements in a set of lists. Each of these properties may be either=
 global
> > +or per-CPU, depending on the map type and flags used to create the map=
:
> > +
> > ++------------------------+---------------------------+----------------=
------------------+
> > +|                        | ``BPF_MAP_TYPE_LRU_HASH`` | ``BPF_MAP_TYPE_=
LRU_PERCPU_HASH`` |
> > ++=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> > +| ``BPF_NO_COMMON_LRU``  | Per-CPU LRU, global map   | Per-CPU LRU, pe=
r-cpu map         |
> > ++------------------------+---------------------------+----------------=
------------------+
> > +| ``!BPF_NO_COMMON_LRU`` | Global LRU, global map    | Global LRU, per=
-cpu map          |
> > ++------------------------+---------------------------+----------------=
------------------+
>
> Above all seems API to me. Maybe move the statement about not considered =
stable
> ABI down here? Something like,
>
> "
> The internal details of which entry is evicted and acquiring a new entry
> are not considered stable and may change in the future. But the current
> impelementation is as follows.
> "
>
> Or something like that?

Yep sounds good to me, I'll fix that up.

> > +
> > +Notably, there are various steps that the update algorithm attempts in=
 order to
> > +enforce the LRU property which have increasing impacts on other CPUs i=
nvolved
> > +in the following operation attempts:
> > +
> > +- Attempt to use CPU-local state to batch operations
> > +- Attempt to fetch free nodes from global lists
> > +- Attempt to pull any node from a global list and remove it from the h=
ashmap
> > +- Attempt to pull any node from any CPU's list and remove it from the =
hashmap
> > +
> > +Even if an LRU node may be acquired, maps of type ``BPF_MAP_TYPE_LRU_H=
ASH``
> > +may fail to insert the entry into the map if other CPUs are heavily co=
ntending
> > +on the global hashmap lock.
>
> Similarly this is ABI correct? Probably we can also specify the error cod=
e?
> Assuming it is just EBUSY or EAGAIN?

Hmm. It's EBUSY right now. Also looks like we're missing corresponding
docs in the uapi header for this case:

https://github.com/torvalds/linux/blob/9c1bec9c0b08abeac72ed6214b723adc2240=
13bf/include/uapi/linux/bpf.h#L163

I think that "this function may fail due to contention on map usage,
in which case it returns EBUSY" (or similar wording) is reasonable to
document as ABI. IMO that should go in the header linked above (which
gets turned into UAPI docs elsewhere). This particular phrasing is
going into more detail around things like the hashmap lock which
should not be described as part of the uAPI/ABI.

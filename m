Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5216BC37D
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 02:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCPByx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Mar 2023 21:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjCPByw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Mar 2023 21:54:52 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27C41F4A8
        for <bpf@vger.kernel.org>; Wed, 15 Mar 2023 18:54:48 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id cn21so2046415edb.0
        for <bpf@vger.kernel.org>; Wed, 15 Mar 2023 18:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1678931687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VK16ssT3iVXFDwPE2/b5McnzjfW/AUDZ9chsGSHxweM=;
        b=V4krVXtv+coVNo8PefjwHhL2VZ+4Pfnd4yl/QfhNKqFNl955Y4pGn2lpEIXzdeSrYv
         5wTC9BnVTPfMkbvYMFMOMPPD1RMcyUHNeJ/CZUVsrd4mzymb2RwWd6xLBKUIb+AvBm3t
         /k4mfUbhrRyJFhtT2Z5kTgU0s38T3W0zCl2NKWA9rNAxp9A9CeUL+Y9Kcd+edSj06jn+
         c/zkChFeeAN+mHhQrY+RTGPamg2imNdk7DtG7QNuBo1fjFS+KsZxi3eGwLlAfs0t7RyR
         hOK5zrYFd59BJ2ezC0bEAWy8iyMqRB71wkCDx6Lf8r0FBdYh1CS1ihsHj1vEyqSgR3AD
         P9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678931687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VK16ssT3iVXFDwPE2/b5McnzjfW/AUDZ9chsGSHxweM=;
        b=xoviDDetVRaw3Ia6Mum4K6Mx8drPZ8z4cZi+SPLvFepPjNCETeeM0oG5ZpMqP+w0nF
         dzFP6JJ0e8QYeuBn/38zb3t6NWPnditmrgyDYcY4v6kuCGj68I9LNgx3JL8Y7zQZtkU/
         +Up67px9umuYxk17qabm9LUa/0nsQ2OuOR2xrbHB3aV0z9pLgs4QJRTOZwb94Ig51bu9
         d9WpWCNJVHav+TY8ogODlS6ECgo44G8Wf4kfCAGwKFDaPOoQ1OL1swWARddUZxztDec/
         O1lrp29vZ3RXlJ6BDuD3w7CzqsTNWjRAP8NLihLnQ2YKoCA1NGfQeo05esCbVfO0VMe0
         GW5A==
X-Gm-Message-State: AO0yUKXKWsmZyNYBcw2h7vz+9uUrMnkUjeVC87Y5ltUzC7e/71dLVA8+
        8pTNWIahAG197lBW+9byKTO3dqhuMsYLwXY33gwQbg==
X-Google-Smtp-Source: AK7set865sbz6R6Pj9A1v+mxb4vLIBDOk2fBHNE3/1+gnMyeS5huuYKPwF6X58KEvDH7zgiB2V3BZyRc9blCHjbMups=
X-Received: by 2002:a17:907:8a12:b0:92f:cf96:e1f6 with SMTP id
 sc18-20020a1709078a1200b0092fcf96e1f6mr1152494ejc.11.1678931687347; Wed, 15
 Mar 2023 18:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230312190600.324573-1-joe@isovalent.com> <c6172fe2-7d88-f9f8-e19a-47c232f9cb75@linux.dev>
In-Reply-To: <c6172fe2-7d88-f9f8-e19a-47c232f9cb75@linux.dev>
From:   Joe Stringer <joe@isovalent.com>
Date:   Wed, 15 Mar 2023 18:54:36 -0700
Message-ID: <CADa=RyxDHp5x0iCcfgiCDuM68we=dTAmVBvx1hgrRLBbN27rdw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] docs/bpf: Add LRU internals description and graph
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, corbet@lwn.net, bagasdotme@gmail.com,
        maxtram95@gmail.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 14, 2023 at 12:31=E2=80=AFPM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> On 3/12/23 12:05 PM, Joe Stringer wrote:
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
> > ---
> > v3: Use standard table syntax
> >      Replace inline commit message with reference to commit
> >      Fix incorrect Y/N label for common LRU check
> >      Rename some dotfile variables to reduce confusion between cases
> >      Minor wording touchups
> > v2: Fix issue that caused initial email submission to fail
> > ---
> >   Documentation/bpf/map_hash.rst            |  62 ++++++++
> >   Documentation/bpf/map_lru_hash_update.dot | 166 +++++++++++++++++++++=
+
> >   2 files changed, 228 insertions(+)
> >   create mode 100644 Documentation/bpf/map_lru_hash_update.dot
> >
> > diff --git a/Documentation/bpf/map_hash.rst b/Documentation/bpf/map_has=
h.rst
> > index 8669426264c6..61602ce26561 100644
> > --- a/Documentation/bpf/map_hash.rst
> > +++ b/Documentation/bpf/map_hash.rst
> > @@ -1,5 +1,6 @@
> >   .. SPDX-License-Identifier: GPL-2.0-only
> >   .. Copyright (C) 2022 Red Hat, Inc.
> > +.. Copyright (C) 2022-2023 Isovalent, Inc.
> >
> >   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >   BPF_MAP_TYPE_HASH, with PERCPU and LRU Variants
> > @@ -206,3 +207,64 @@ Userspace walking the map elements from the map de=
clared above:
> >                       cur_key =3D &next_key;
> >               }
> >       }
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
> The global hashmap lock described here is the action taken in htab_lock_b=
ucket()?
>
> It is a percpu counter added in commit 20b6cc34ea74 ("bpf: Avoid hashtab
> deadlock with map_locked") to avoid deadlock/recursion.

Hmm, yes that's the lock I had in mind. Thanks for the pointer, I
didn't really understand the motivation for that case previously. That
said, I now find it even harder to think of reasonable wording to
describe in the ABI about how an eBPF program developer should reason
about the -EBUSY failure case.

> I would suggest to simplify the diagram by removing the "Can lock this ha=
shtab
> bucket?" details.

I could swap that to instead have "Update hashmap with new element",
then have two possible outcomes depending on whether that succeeds or
not. I guess this is also similar to John's feedback above that in the
end, EBUSY return code ends up being ABI for the helper. Does that
make sense? One of my goals for the diagram was to at least capture
the various return codes to assist readers in reasoning about the
different failure modes.

> Maybe a note somewhere to mention why it will still fail to
> shrink the list because the htab_lock_bucket() have detected potential
> deadlock/recursion which is a very unlikely case.

I missed the "shrink the list" link here since it seems like this
could happen for any combination of update or delete elems for the
same bucket. But yeah given that also needs to happen on the same CPU,
it does seem very unlikely... Could there be a case something like
"userspace process is touching that bucket, gets interrupted, then the
same CPU runs an eBPF program that attempts to update/delete elements
in the same bucket"?

Previously I had read this to think that EBUSY was the common case and
ENOMEM is the uncommon case, but based on your pointers above I'm less
convinced now, and more surprised that either failure would occur.
Perhaps the failure I had hit was even later in the regular hashtab
update logic. At the time of the incidents I was investigating, we
unfortunately did not record which of the failure cases occurred so I
don't have specific data to back up what we were experiencing. We have
since added such reporting but I haven't received further information
from the failure mode.

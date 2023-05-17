Return-Path: <bpf+bounces-682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAD2705B92
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 02:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 328A41C20B61
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 00:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86D617CB;
	Wed, 17 May 2023 00:02:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C8E17C8
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 00:02:55 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BD82D66
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 17:02:54 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-643990c5319so64221b3a.2
        for <bpf@vger.kernel.org>; Tue, 16 May 2023 17:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684281773; x=1686873773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2SPN2EMkGWTnQbD/obnoCI0LyTr7M93fs7lQdMVIRg=;
        b=FxBF3Jh2uhdmlxq6wDeE0pmyX6roVcy/uOwXBNkDew6cLEbF2VIgp/9qfEvX34EUdt
         WGj0rzexFeHvMjTwJ4z1DZ5XBuV5Dt4VqtQlXZyIY4Y2gj8MWtEod+4+7CpsTLid3nkv
         aodMc1J9cvW48iUCUFmSNpsrlZBASLUxRERjVjpHxg4PZyOF67Frz+bK06Pmjm0KaP6v
         xnLF7TdvORZtYC5lHT4MGj31jXX4C/GPDQ7cBsoQVdGcyhVjo0RiD8oD/HVIMpA8S2kB
         cpt2j5bMnLinNwPK6ux8qlx1wXTGVlHblpNGRkAWjHRgG/krjuorJaDTpHUDDzhfrTr7
         COmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684281773; x=1686873773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2SPN2EMkGWTnQbD/obnoCI0LyTr7M93fs7lQdMVIRg=;
        b=WODNGvzpcZrRQd+vZuB8BSU6csJwHcqvkBOP9wGhu87eF7x3GaJgV5KPFG0S7o2U9y
         DndtEB4Kj5PC8oLs4JsPTuCUhHVbbJXJxeDx4ljHnwyuWFm/3ktfownjCnSPBnfGsQtd
         enVS3ejI+J2MM5erE5DbIVCIZU9y6dhm3Uo8FvCkSMPa7JzfyoRVv8prT/uXF1hJ8rqM
         pTX91ycdrTx0bUOzZfbL/cy48aY2jJ8gHXGO1SXwGZjJ7Eo0tibLuvJNr9QyS2EsBMeD
         LGcZcyFrKSpaWydHSBQjSlgJ5sFBQGwBFHYOI425qduoOmJxSmuE0sFJ5IooEVe5gEUs
         ULlQ==
X-Gm-Message-State: AC+VfDwQ5U0mk4vQzqs4m15dNKblo0TRmG0tnY2VGWvDf4k1MjxBmguq
	OKJXaiLK/FqzYtenJD1mfLlyVYQZ6DFlB07C52r3kTjEnaEUYEL77rk9YA==
X-Google-Smtp-Source: ACHHUZ4c9GCv1jUgb2XPZ6I6aEE5CIY3AeFgoN7iShuMh8Qx2PtVns/zzzJNh0Y14+lbdfmhRTYraV8BbgATdUvX4Nk=
X-Received: by 2002:a05:6a20:429a:b0:100:a785:4a86 with SMTP id
 o26-20020a056a20429a00b00100a7854a86mr38390551pzj.7.1684281773455; Tue, 16
 May 2023 17:02:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230511172054.1892665-1-sdf@google.com> <20230511172054.1892665-5-sdf@google.com>
 <CAEf4Bzam+Cy+qmf5dH5=_36QuOd94_EmqnUW6nkxo0Y_EmirOA@mail.gmail.com>
In-Reply-To: <CAEf4Bzam+Cy+qmf5dH5=_36QuOd94_EmqnUW6nkxo0Y_EmirOA@mail.gmail.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Tue, 16 May 2023 17:02:42 -0700
Message-ID: <CAKH8qBv80U_G4M0sCW_hJuJB63BrHJcrWAZNsHX9e52MMi3=5A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/4] bpf: query effective progs without cgroup_mutex
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 16, 2023 at 3:02=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, May 11, 2023 at 10:21=E2=80=AFAM Stanislav Fomichev <sdf@google.c=
om> wrote:
> >
> > When querying bpf prog list, we don't really need to hold
> > cgroup_mutex. There is only one caller of cgroup_bpf_query
> > (cgroup_bpf_prog_query) and it does cgroup_get/put, so we're
> > safe WRT cgroup going way. However, we if we stop grabbing
> > cgroup_mutex, we risk racing with the prog attach/detach path
> > to the same cgroup, so here is how to work it around.
> >
> > We have two case:
> > 1. querying effective array
> > 2. querying non-effective list
> >
> > (1) is easy because it's already a RCU-managed array, so all we
> > need is to make a copy of that array (under rcu read lock)
> > into a temporary buffer and copy that temporary buffer back
> > to userspace.
> >
> > (2) is more involved because we keep the list of progs and it's
> > not managed by RCU. However, it seems relatively simple to
> > convert that hlist to the RCU-managed one: convert the readers
> > to use hlist_xxx_rcu and replace kfree with kfree_rcu. One
> > other notable place is cgroup_bpf_release where we replace
> > hlist_for_each_entry_safe with hlist_for_each_entry_rcu. This
> > should be safe because hlist_del_rcu does not remove/poison
> > forward pointer of the list entry, so it's safe to remove
> > the elements while iterating (without specially flavored
> > for_each_safe wrapper).
> >
> > For (2), we also need to take care of flags. I added a bunch
> > of READ_ONCE/WRITE_ONCE to annotate lockless access. And I
> > also moved flag update path to happen before adding prog
> > to the list to make sure readers observe correct flags.
> >
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  include/linux/bpf-cgroup-defs.h |   2 +-
> >  include/linux/bpf-cgroup.h      |   1 +
> >  kernel/bpf/cgroup.c             | 152 ++++++++++++++++++--------------
> >  3 files changed, 90 insertions(+), 65 deletions(-)
> >
>
> Few reservations from my side:
>
> 1. You are adding 16 bytes to bpf_prog_list, of which there could be
> *tons* copies of. It might be ok, but slightly speeding up something
> that's not even considered to be a performance-critical operation
> (prog query) at the expense of more memory usage feels a bit odd.
>
> 2. This code is already pretty tricky, and that's under the
> simplifying conditions of cgroup_mutex being held. We are now making
> it even more complicated without locks being held.
>
> 3. This code is probably going to be changed again once Daniel's
> multi-prog API lands, so we are going to do this exercise again
> afterwards?

I'm happy to wait for (3). From my pow (2) is the most concerning. The
code is a bit complicated (and my patches are not helping), maybe
that's a sign that we need to clean it up :-)
Some parts are rcu-safe, some aren't. cgroup_mutex usage looks like
something that was done long ago for simplicity and might not apply
anymore. We now have machines which have multiple progs attached per
cgroup; grabbing global lock just to query the list seems excessive.

> So taking a bit of a step back. In cover letter you mentioned:
>
>   > We're observing some stalls on the heavily loaded machines
>   > in the cgroup_bpf_prog_query path. This is likely due to
>   > being blocked on cgroup_mutex.
>
> Is that likely an unconfirmed suspicion or you did see that
> cgroup_mutex lock is causing stalls?

My intuition: we know that we have multiple-second stalls due
cgroup_mutex elsewhere and I don't see any other locks in the
prog_query path.

> Also, I wonder if you tried using BPF program or cgroup iterators to
> get all this information from BPF side? I wonder if that's feasible?

Cgroup iterator has the following in the comment:
Note: the iter_prog is called with cgroup_mutex held.

I can probably use a link iterator; I would have to upcast bpf_link to
bpf_cgroup_link (via bpf_probe_read?) to get to the cgroup id, but it
seems like a workaround?


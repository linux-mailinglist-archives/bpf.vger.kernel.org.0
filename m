Return-Path: <bpf+bounces-679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCBD705A61
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 00:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3A201C20C20
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 22:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDD927205;
	Tue, 16 May 2023 22:02:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE36101C0
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 22:02:57 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1759EB4
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 15:02:51 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-510b56724caso3904846a12.1
        for <bpf@vger.kernel.org>; Tue, 16 May 2023 15:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684274569; x=1686866569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HdOlwwskTorsyHY2wnNiHH+8QOFeFZ2fH5kaqtBChDU=;
        b=LMBmaCS94YMnOJLn8Lnm2pAwJ/nbyw7b8B+RIOjY6PQq1VpvJFf0xtHnKgt/eqZOUI
         Z+ECS2b30u4Q6uxQJ/ITuGNaYyW5vrPaV4V1Olrt9e4YXM8+zZu8/mgLkx2iaueKOZ0Q
         1jYd5Tr3xj4JwhqJ8McfyWPfBing9s2nvbRCNA190PvRegeui8mfHLwU0G5pXBDyTYg0
         HRn/chFjUFBGGwR89VBNfAROaUMT+tTEwkaPdGsGFQCPijbia+0IRbJIVHI5x0RsGGMk
         5vUy2BS3EpWiCkrpfsakWQmM2X8wv03g9RY2rRojUlDP3X/Vvk0ggNKFejNjR3wj7o3a
         nNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684274569; x=1686866569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HdOlwwskTorsyHY2wnNiHH+8QOFeFZ2fH5kaqtBChDU=;
        b=UqgM1Ei3HMY3DG7Z3XJ2eu9LjoC+yBq9IjhZ1f36eUXVtsncRwBDpQKbBjcBLCmBjk
         neQZ1uHeMpUtkxjVWq1X+cGUrWCoAZsS7XTUveBIy5nAzmp2ATX1i4nNjsB/0EHKFXVE
         t3wyVLg33omWgdGCD8oLc0yk+IGxCAfG71eOs2zSgU2NxRqfAC0bxp4pDcvRNYvQCOvV
         oSz651Oeg9DedSkDSoKuQbzl9RN76SupLtXxIrFjojkm/eoL7zScpdwYu15n73U8HPe5
         fXHI0tTS1xNdxtTnG+Ru1DuORV5nj1c787e60ZtGNKrCOBdD973IXfLZ/fZAWu9ZHk6D
         mXAw==
X-Gm-Message-State: AC+VfDx/ZmNK7d8JEosxv2NuLy7bOKTYAoYL44N9oukAQJYiOlX/EQsS
	eC47tQjcnhwrGWYl6YPdAb/mFo8SYz8KRr53c/g=
X-Google-Smtp-Source: ACHHUZ5kHqGH54tuKG6PxW3SaDTPlO2BxLOYBVHZATGbIu6hLkXx/69sjzvhLWGw+dSG7G/972aoSB6g/RSuPsQV8FI=
X-Received: by 2002:aa7:c6c4:0:b0:50d:9058:733 with SMTP id
 b4-20020aa7c6c4000000b0050d90580733mr47122eds.18.1684274569295; Tue, 16 May
 2023 15:02:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230511172054.1892665-1-sdf@google.com> <20230511172054.1892665-5-sdf@google.com>
In-Reply-To: <20230511172054.1892665-5-sdf@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 May 2023 15:02:36 -0700
Message-ID: <CAEf4Bzam+Cy+qmf5dH5=_36QuOd94_EmqnUW6nkxo0Y_EmirOA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/4] bpf: query effective progs without cgroup_mutex
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com, 
	jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 11, 2023 at 10:21=E2=80=AFAM Stanislav Fomichev <sdf@google.com=
> wrote:
>
> When querying bpf prog list, we don't really need to hold
> cgroup_mutex. There is only one caller of cgroup_bpf_query
> (cgroup_bpf_prog_query) and it does cgroup_get/put, so we're
> safe WRT cgroup going way. However, we if we stop grabbing
> cgroup_mutex, we risk racing with the prog attach/detach path
> to the same cgroup, so here is how to work it around.
>
> We have two case:
> 1. querying effective array
> 2. querying non-effective list
>
> (1) is easy because it's already a RCU-managed array, so all we
> need is to make a copy of that array (under rcu read lock)
> into a temporary buffer and copy that temporary buffer back
> to userspace.
>
> (2) is more involved because we keep the list of progs and it's
> not managed by RCU. However, it seems relatively simple to
> convert that hlist to the RCU-managed one: convert the readers
> to use hlist_xxx_rcu and replace kfree with kfree_rcu. One
> other notable place is cgroup_bpf_release where we replace
> hlist_for_each_entry_safe with hlist_for_each_entry_rcu. This
> should be safe because hlist_del_rcu does not remove/poison
> forward pointer of the list entry, so it's safe to remove
> the elements while iterating (without specially flavored
> for_each_safe wrapper).
>
> For (2), we also need to take care of flags. I added a bunch
> of READ_ONCE/WRITE_ONCE to annotate lockless access. And I
> also moved flag update path to happen before adding prog
> to the list to make sure readers observe correct flags.
>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>  include/linux/bpf-cgroup-defs.h |   2 +-
>  include/linux/bpf-cgroup.h      |   1 +
>  kernel/bpf/cgroup.c             | 152 ++++++++++++++++++--------------
>  3 files changed, 90 insertions(+), 65 deletions(-)
>

Few reservations from my side:

1. You are adding 16 bytes to bpf_prog_list, of which there could be
*tons* copies of. It might be ok, but slightly speeding up something
that's not even considered to be a performance-critical operation
(prog query) at the expense of more memory usage feels a bit odd.

2. This code is already pretty tricky, and that's under the
simplifying conditions of cgroup_mutex being held. We are now making
it even more complicated without locks being held.

3. This code is probably going to be changed again once Daniel's
multi-prog API lands, so we are going to do this exercise again
afterwards?

So taking a bit of a step back. In cover letter you mentioned:

  > We're observing some stalls on the heavily loaded machines
  > in the cgroup_bpf_prog_query path. This is likely due to
  > being blocked on cgroup_mutex.

Is that likely an unconfirmed suspicion or you did see that
cgroup_mutex lock is causing stalls?

Also, I wonder if you tried using BPF program or cgroup iterators to
get all this information from BPF side? I wonder if that's feasible?


[...]


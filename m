Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554BF2A4883
	for <lists+bpf@lfdr.de>; Tue,  3 Nov 2020 15:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgKCOqw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Nov 2020 09:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbgKCOqq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Nov 2020 09:46:46 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4DAC0617A6
        for <bpf@vger.kernel.org>; Tue,  3 Nov 2020 06:46:46 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id k25so19314283lji.9
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2020 06:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pp8uAn32f3t2FIuwzoaa3d8s2O0PQKKs2nYF0Ij9oV0=;
        b=Lp8sR9nPKnAG2KgrCOLy/YNC01bsS2U/CefENaisdUaUl3RHmmqXuECaKfQC6Rt1As
         35jHUVFOoIO5YGknLJg2/sB51Cidar0vALts1XYOf54MtMKdpvSbtwmvAAsPRUIs40CD
         gxHo3IGflEu+oIrpqzJ9f4iIISKkCT/PonEt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pp8uAn32f3t2FIuwzoaa3d8s2O0PQKKs2nYF0Ij9oV0=;
        b=Rzg5qYgvWk57ryQhg/2yq67MGnWD3Y5NPx6bppXXt32LCRqVzE1hStRAgDOucvYkU1
         GZkc2tZa3Qdu6SZGKxXozChHRUnPJ30kfXZL44sXBhf4j1isdz/IIl4c5U7o3ncbQrih
         ICCRfKHGo9CH5Q7+HAUUNShP+57YXctz3Dcu3gGx7e0Vap5FqwhQa8NWTDmHTMFR40kQ
         U+kYqKDYcMk5ue9G+LCZK9Uw+Na6hXbbDbIZQIknAKIBADHYPqjn0a/MLoo6yBjrVjWQ
         qbT/rfCztctR+04jMewuVAMKMQ/ZO8jqSPT+MiEqZtheDHYn5hIbIAFAPmojjFUGw23D
         nscg==
X-Gm-Message-State: AOAM531y/Rs0d6aQkMFA15/4cuwgVeZJKVVAieeVVlC7sX9G8osqSyz7
        NMofFLNIEi6mlhlgsTEz0MtqSkoWvKGwXa78N8PhFw==
X-Google-Smtp-Source: ABdhPJz1sIc0TCfk/JQes5IB9aL1+j4p7YCdhCtvTca3xYbxNpUE3c6beOd1uoh6nwQGOVC0wR6b7DACK6KZ5QhX8Jg=
X-Received: by 2002:a2e:984e:: with SMTP id e14mr305831ljj.110.1604414804910;
 Tue, 03 Nov 2020 06:46:44 -0800 (PST)
MIME-Version: 1.0
References: <20201027170317.2011119-1-kpsingh@chromium.org>
 <20201027170317.2011119-2-kpsingh@chromium.org> <20201028011321.4yu62347lfzisxwy@kafai-mbp>
 <CACYkzJ5VU2Pd2ZiY7AKJM0yZ2NsDbQOu1Y_FYwkBv6M6NFvkcw@mail.gmail.com>
In-Reply-To: <CACYkzJ5VU2Pd2ZiY7AKJM0yZ2NsDbQOu1Y_FYwkBv6M6NFvkcw@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Tue, 3 Nov 2020 15:46:34 +0100
Message-ID: <CACYkzJ6uzOu6YP2MQs4eYScXzATE+Ha5WLcNWW2cskObC23bEw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] bpf: Implement task local storage
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 30, 2020 at 11:53 AM KP Singh <kpsingh@chromium.org> wrote:
>
> Thanks for taking a look!
>
> On Wed, Oct 28, 2020 at 2:13 AM Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > On Tue, Oct 27, 2020 at 06:03:13PM +0100, KP Singh wrote:
> > [ ... ]
> >
> > > diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
> > > new file mode 100644
> > > index 000000000000..774140c458cc
> > > --- /dev/null
> > > +++ b/kernel/bpf/bpf_task_storage.c
> > > @@ -0,0 +1,327 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (c) 2019 Facebook
> > > + * Copyright 2020 Google LLC.
> > > + */
> > > +
> > > +#include "linux/pid.h"
> > > +#include "linux/sched.h"
> > > +#include <linux/rculist.h>
> > > +#include <linux/list.h>
> > > +#include <linux/hash.h>
> > > +#include <linux/types.h>
> > > +#include <linux/spinlock.h>
> > > +#include <linux/bpf.h>
> > > +#include <linux/bpf_local_storage.h>
> > > +#include <net/sock.h>
> > Is this required?
>
> Nope. Removed.
>
> >
> > > +#include <uapi/linux/sock_diag.h>
> > > +#include <uapi/linux/btf.h>
> > > +#include <linux/bpf_lsm.h>
> > > +#include <linux/btf_ids.h>
> > > +#include <linux/fdtable.h>
> > > +
> > > +DEFINE_BPF_STORAGE_CACHE(task_cache);
> > > +
> > > +static struct bpf_local_storage __rcu **task_storage_ptr(void *owner)
>
> [...]
>
> > > +             err = -EBADF;
> > > +             goto out_fput;
> > > +     }
> > > +
> > > +     pid = get_pid(f->private_data);
> > n00b question. Is get_pid(f->private_data) required?
> > f->private_data could be freed while holding f->f_count?
>
> I would assume that holding a reference to the file should also
> keep the private_data alive but I was not sure so I grabbed the
> extra reference.
>
> >
> > > +     task = get_pid_task(pid, PIDTYPE_PID);
> > Should put_task_struct() be called before returning?
>
> If we keep using get_pid_task then, yes, I see it grabs a reference to the task.
> We could also call pid_task under rcu locks but it might be cleaner to
> just get_pid_task
> and put_task_struct().

I refactored this to use pidfd_get_pid and it seems like we can simply call
pid_task since we are already in an RCU read side critical section.

And to be pedantic, I added a WARN_ON_ONCE(!rcu_read_lock_held());
(although this is not required as lockdep should pretty much handle it
by default)

- KP

>
> >
> > > +     if (!task || !task_storage_ptr(task)) {
> > "!task_storage_ptr(task)" is unnecessary, task_storage_lookup() should
> > have taken care of it.
> >
> >
> > > +             err = -ENOENT;
> > > +             goto out;
> > > +     }
> > > +
> > > +     sdata = task_storage_lookup(task, map, true);
> > > +     put_pid(pid);
>
> [...]
>
> > > +     .map_lookup_elem = bpf_pid_task_storage_lookup_elem,
> > > +     .map_update_elem = bpf_pid_task_storage_update_elem,
> > > +     .map_delete_elem = bpf_pid_task_storage_delete_elem,
> > Please exercise the syscall use cases also in the selftest.
>
> Will do. Thanks for the nudge :)

I also added another patch to exercise them for the other storage types too.

- KP

>
> >
> > > +     .map_check_btf = bpf_local_storage_map_check_btf,
> > > +     .map_btf_name = "bpf_local_storage_map",
> > > +     .map_btf_id = &task_storage_map_btf_id,
> > > +     .map_owner_storage_ptr = task_storage_ptr,
> > > +};
> > > +

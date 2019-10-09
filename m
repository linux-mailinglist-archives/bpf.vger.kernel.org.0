Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15418D193A
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2019 21:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbfJITuX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Oct 2019 15:50:23 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38554 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbfJITuX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Oct 2019 15:50:23 -0400
Received: by mail-qk1-f193.google.com with SMTP id u186so3372392qkc.5;
        Wed, 09 Oct 2019 12:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aNkoSOSLpO8yUGLMo7SKh5bessb8H/CMtgVc3/vAAT8=;
        b=YPJiIYUTpsGqL4yZBID0wqn3WLBZXQGykahxGwI5iHVv7Nh+RW0Bv1stJgyfQMDPsu
         8DSk+zQSGwGF1w/Yf2HwRoiVVqvBvKBGx9ge2hayZsq9T/gUcqwzMdwNUKlK53wHvdjb
         WJqWhjUtRPAgKPslzb2YGP9iEPcZT8zPqBKGBTjoHWRhe8CCjG/T/iJ7Xn4GpQCQqvqd
         CEtxD1nx+fIicX/agDKeYrKrncak5GwU1aqCZtgQuAdarOl95eSl63N2hCwM8eyKCiku
         ua+oLnsRzDVsnUHhLw0pWuy9dq6sVG2RXrUb+Qu8YiqnQoo7lAKNCNIDMpHsEgX/YRYl
         ZP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aNkoSOSLpO8yUGLMo7SKh5bessb8H/CMtgVc3/vAAT8=;
        b=MCmofNTz4sScRIlIw6YITQct72tM6ZY+vgSCd4Y6n/MEzkHYkJtEO/gydYVOr0S4Dt
         ZtimxcMEY6zuyJ7GFuF7pEjLw6I2V+/KevXnJkGErC011q9bn6mJWKBluonYoLsmpv4Y
         FyiJ5/lI1+Gqow32FExXiIyK7rOZddHn3gQsq3R9NYuEvohfSxy+D0lCfv2eBo9JfFTu
         K6s9DDoWklyEhaoNIBiQxuYbD3r3yotxYS1sJF26krQZCyfFd/HVLF+8JjRg8KcflLLC
         tJgtVjCVDYG1i3xISplgppKHAfXSGu4VxoLDvoxPiNNV9RLFbOuNAzbj9+arqejAX8/8
         m/UA==
X-Gm-Message-State: APjAAAUKcpK1zqIsIpVOmRaQkf8t/FVph3doatUTwZTWI4htnmIBYjvM
        +ilK/UVtl5D9LV4p467JSo9wmsPIKFIIa2XtKu4=
X-Google-Smtp-Source: APXvYqyvTPsZfQSlqq+ct5PbnvT74YIwW5BaTfleIKT0EXwSwUHxzfinxLX/8LAlmYQoaoN0cAXPpiY86DZZtunmXCs=
X-Received: by 2002:a37:b447:: with SMTP id d68mr5536638qkf.437.1570650621824;
 Wed, 09 Oct 2019 12:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <20191009152632.14218-1-cneirabustos@gmail.com>
 <20191009152632.14218-3-cneirabustos@gmail.com> <CAEf4BzYf77BxVy9bNBhW5SFA7nkMLyt_BfDEKC1Nis8Hcc2MqA@mail.gmail.com>
 <20191009174538.GB12351@frodo.byteswizards.com>
In-Reply-To: <20191009174538.GB12351@frodo.byteswizards.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 9 Oct 2019 12:50:10 -0700
Message-ID: <CAEf4BzanTFDV6rXTewJYLN_BXsFbDnJoJ-58fAxE9XBVuVVSNA@mail.gmail.com>
Subject: Re: [PATCH v13 2/4] bpf: added new helper bpf_get_ns_current_pid_tgid
To:     Carlos Antonio Neira Bustos <cneirabustos@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>, Yonghong Song <yhs@fb.com>,
        ebiederm@xmission.com, Jesper Dangaard Brouer <brouer@redhat.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 9, 2019 at 10:45 AM Carlos Antonio Neira Bustos
<cneirabustos@gmail.com> wrote:
>
> On Wed, Oct 09, 2019 at 09:14:42AM -0700, Andrii Nakryiko wrote:
> > On Wed, Oct 9, 2019 at 8:27 AM Carlos Neira <cneirabustos@gmail.com> wrote:
> > >
> > > New bpf helper bpf_get_ns_current_pid_tgid,
> > > This helper will return pid and tgid from current task
> > > which namespace matches dev_t and inode number provided,
> > > this will allows us to instrument a process inside a container.
> > >
> > > Signed-off-by: Carlos Neira <cneirabustos@gmail.com>
> > > ---
> > >  include/linux/bpf.h      |  1 +
> > >  include/uapi/linux/bpf.h | 22 +++++++++++++++++++-
> > >  kernel/bpf/core.c        |  1 +
> > >  kernel/bpf/helpers.c     | 43 ++++++++++++++++++++++++++++++++++++++++
> > >  kernel/trace/bpf_trace.c |  2 ++
> > >  5 files changed, 68 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index 5b9d22338606..231001475504 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -1055,6 +1055,7 @@ extern const struct bpf_func_proto bpf_get_local_storage_proto;
> > >  extern const struct bpf_func_proto bpf_strtol_proto;
> > >  extern const struct bpf_func_proto bpf_strtoul_proto;
> > >  extern const struct bpf_func_proto bpf_tcp_sock_proto;
> > > +extern const struct bpf_func_proto bpf_get_ns_current_pid_tgid_proto;
> > >
> > >  /* Shared helpers among cBPF and eBPF. */
> > >  void bpf_user_rnd_init_once(void);
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index 77c6be96d676..6ad3f2abf00d 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -2750,6 +2750,19 @@ union bpf_attr {
> > >   *             **-EOPNOTSUPP** kernel configuration does not enable SYN cookies
> > >   *
> > >   *             **-EPROTONOSUPPORT** IP packet version is not 4 or 6
> > > + *
> > > + * u64 bpf_get_ns_current_pid_tgid(struct *bpf_pidns_info, u32 size)
> >
> > Should be:
> >
> > struct bpf_pidns_info *nsdata
> >
> > > + *     Return
> > > + *             0 on success, values for pid and tgid from nsinfo will be as seen
> > > + *             from the namespace that matches dev and inum from nsinfo.
> >
> > I think its cleaner to have a Description section, explaining that it
> > will return pid/tgid in bpf_pidns_info, and then describe exit codes
> > in Return section.
> >
> > > + *
> > > + *             On failure, the returned value is one of the following:
> > > + *
> > > + *             **-EINVAL** if dev and inum supplied don't match dev_t and inode number
> > > + *              with nsfs of current task, or if dev conversion to dev_t lost high bits.
> > > + *
> > > + *             **-ENOENT** if /proc/self/ns does not exists.
> > > + *
> > >   */
> > >  #define __BPF_FUNC_MAPPER(FN)          \
> > >         FN(unspec),                     \
> > > @@ -2862,7 +2875,8 @@ union bpf_attr {
> > >         FN(sk_storage_get),             \
> > >         FN(sk_storage_delete),          \
> > >         FN(send_signal),                \
> > > -       FN(tcp_gen_syncookie),
> > > +       FN(tcp_gen_syncookie),          \
> > > +       FN(get_ns_current_pid_tgid),
> > >
> > >  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> > >   * function eBPF program intends to call
> > > @@ -3613,4 +3627,10 @@ struct bpf_sockopt {
> > >         __s32   retval;
> > >  };
> > >
> > > +struct bpf_pidns_info {
> > > +       __u64 dev;
> > > +       __u64 inum;
> >
> > seems like conventionally this should be named "ino", this is what
> > ns_match calls it, so let's stay consistent.
> >
> > > +       __u32 pid;
> > > +       __u32 tgid;
> > > +};
> >
> > So it seems like dev and inum are treated as input parameters, while
> > pid/tgid is output parameter, right? Wouldn't it be cleaner to have
> > dev and inum as explicit arguments into bpf_get_ns_current_pid_tgid()?
> > What's also not great, is that on failure you'll memset this entire
> > struct to zero, and user will lose its dev/inum. So in practice you'll
> > be keeping dev/inum somewhere else, then constructing and filling in
> > this bpf_pidns_info struct every time you need to invoke
> > bpf_get_ns_current_pid_tgid.
> >
> > Maybe it was discussed already, but IMO feels cleaner to have only
> > pid/tgid in bpf_pidns_info and pass dev/inum as direct arguments.
> >
> > >  #endif /* _UAPI__LINUX_BPF_H__ */
> > > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > > index 66088a9e9b9e..b2fd5358f472 100644
> > > --- a/kernel/bpf/core.c
> > > +++ b/kernel/bpf/core.c
> > > @@ -2042,6 +2042,7 @@ const struct bpf_func_proto bpf_get_current_uid_gid_proto __weak;
> > >  const struct bpf_func_proto bpf_get_current_comm_proto __weak;
> > >  const struct bpf_func_proto bpf_get_current_cgroup_id_proto __weak;
> > >  const struct bpf_func_proto bpf_get_local_storage_proto __weak;
> > > +const struct bpf_func_proto bpf_get_ns_current_pid_tgid_proto __weak;
> > >
> > >  const struct bpf_func_proto * __weak bpf_get_trace_printk_proto(void)
> > >  {
> > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > index 5e28718928ca..78a1ce7726aa 100644
> > > --- a/kernel/bpf/helpers.c
> > > +++ b/kernel/bpf/helpers.c
> > > @@ -11,6 +11,8 @@
> > >  #include <linux/uidgid.h>
> > >  #include <linux/filter.h>
> > >  #include <linux/ctype.h>
> > > +#include <linux/pid_namespace.h>
> > > +#include <linux/proc_ns.h>
> > >
> > >  #include "../../lib/kstrtox.h"
> > >
> > > @@ -487,3 +489,44 @@ const struct bpf_func_proto bpf_strtoul_proto = {
> > >         .arg4_type      = ARG_PTR_TO_LONG,
> > >  };
> > >  #endif
> > > +
> > > +BPF_CALL_2(bpf_get_ns_current_pid_tgid, struct bpf_pidns_info *, nsdata, u32,
> > > +       size)
> > > +{
> > > +       struct task_struct *task = current;
> > > +       struct pid_namespace *pidns;
> > > +       int err = -EINVAL;
> > > +
> > > +       if (unlikely(size != sizeof(struct bpf_pidns_info)))
> > > +               goto clear;
> > > +
> > > +       if ((u64)(dev_t)nsdata->dev != nsdata->dev)
> >
> > this seems unlikely() as well :)
> >
> > > +               goto clear;
> > > +
> > > +       if (unlikely(!task))
> > > +               goto clear;
> > > +
> > > +       pidns = task_active_pid_ns(task);
> > > +       if (unlikely(!pidns)) {
> > > +               err = -ENOENT;
> > > +               goto clear;
> > > +       }
> > > +
> > > +       if (!ns_match(&pidns->ns, (dev_t)nsdata->dev, nsdata->inum))
> > > +               goto clear;
> > > +
> > > +       nsdata->pid = task_pid_nr_ns(task, pidns);
> > > +       nsdata->tgid = task_tgid_nr_ns(task, pidns);
> > > +       return 0;
> > > +clear:
> > > +       memset((void *)nsdata, 0, (size_t) size);
> > > +       return err;
> > > +}
> > > +
> > > +const struct bpf_func_proto bpf_get_ns_current_pid_tgid_proto = {
> > > +       .func           = bpf_get_ns_current_pid_tgid,
> > > +       .gpl_only       = false,
> > > +       .ret_type       = RET_INTEGER,
> > > +       .arg1_type      = ARG_PTR_TO_UNINIT_MEM,
> >
> > So this is a lie, you do expect part of that struct to be initialized.
> > One more reason to just split off dev/inum(ino?).
> >
> >
> > > +       .arg2_type      = ARG_CONST_SIZE,
> > > +};
> > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > index 44bd08f2443b..32331a1dcb6d 100644
> > > --- a/kernel/trace/bpf_trace.c
> > > +++ b/kernel/trace/bpf_trace.c
> > > @@ -735,6 +735,8 @@ tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> > >  #endif
> > >         case BPF_FUNC_send_signal:
> > >                 return &bpf_send_signal_proto;
> > > +       case BPF_FUNC_get_ns_current_pid_tgid:
> > > +               return &bpf_get_ns_current_pid_tgid_proto;
> > >         default:
> > >                 return NULL;
> > >         }
> > > --
> > > 2.20.1
> > >
> Thanks for reviewing this, I'll make the changes you suggest.
> I'm not sure about removing dev and ino from struct bpf_pidns_info, I
> think is useful to know to which ns pid/tgid belong to using dev and ino
> to figure it out. Maybe in the future we could filter bpf_pidns_info
> structs by dev/ino, just an idea.

I'm not following. dev/ino are specified by the caller to this helper,
right? So caller already know those values. With current set up,
though, the behavior is weird: this struct's dev/ino is preserved on
success, but zeroed out on failure, even though helper itself has
nothing to do with returning dev/ino. It also plays badly with
ARG_PTR_TO_UNINT_MEM, because that memory is expected to be at least
partially initialized. I see only downsides, to be honest.

>
> Bests

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6F13D7F74
	for <lists+bpf@lfdr.de>; Tue, 27 Jul 2021 22:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhG0Ur4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Jul 2021 16:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbhG0Ur4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Jul 2021 16:47:56 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D441C061757
        for <bpf@vger.kernel.org>; Tue, 27 Jul 2021 13:47:56 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id c5-20020a05620a2005b02903b8d1e253a9so62858qka.11
        for <bpf@vger.kernel.org>; Tue, 27 Jul 2021 13:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rK2mGJnDB6D7HYXq4Z/iWMCNgueUnDRkkxXumKN3/ag=;
        b=vnVRn2UWJwnbEQQTdbxxjEA3KMu6I05i9APyd0V6oo9vQB4jSuUQ/Y4o0UEcN9JAJs
         QrUiCNNvD/fAjeYav6VPqjAI491XMNou8v9y2lBBGPT4iEo5mCaITLtRccwHyld2O6dW
         WBt8S3vrwfXLry8Hv7K+qZjAF96ih48DZSYs5iwFFtnZKQc1PsblkO3KwR2Ec8BEaDx4
         q+OuoXOCHCC3zuZmLAsfnyVXGuLA+Rd7ALXoLpV32k8TilNFLgX4mxG2QrjhwgObBC7J
         FxjUBMOg/gjauBKU/NT7NnuzmVI+4KDL5pos75De7sYJdvcGG3URBe+faGUfmc+CvGzn
         0NzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rK2mGJnDB6D7HYXq4Z/iWMCNgueUnDRkkxXumKN3/ag=;
        b=RMO8ws9OYbdm1WfOSH0ts6B2I77lFrbEIBjbZOWF9fCYAOjyXR9O5L3JxtJpiTx3/r
         J0/kjlKBQ4GtxP1mEg7jcFu5pyKyFlOhYxlri3XgOOPXqedFqr+oX3w5BqKiLOGXDyBW
         6E1xuZLWyDDHoeUOVI0dVox6K/+O4aF60eDjUBm0Rae0hp5B7miKrh5aEBWvwdlRt7aY
         UJHuvRG1gzVByh5YPcb9mzI22SGPP4dk6IVq/PStzsoODjtMcsQseP9fXY2MuHDZ2dt7
         Oms9RKEY5rWxhGLXdgZg79E8zYv2//0L00GDN5pDIzZgpUBo4ZhpXy9vLr6cNGj9OtUd
         B2dg==
X-Gm-Message-State: AOAM530qLfP5+1OKhzwwC/T9B0Cw7g8q1OIWWexakUZ6f90zKqUy9R62
        pOMbesJIlH3Iwt6B14CnqGhCQBE=
X-Google-Smtp-Source: ABdhPJzkGF2A/ii6lsAsocYTiCaN00o3fcNxA02uNNt7llq15B4HDt1RYvOAeEX5QwN9lfvf5JkbOhY=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:d295:8a87:15f8:cb7])
 (user=sdf job=sendgmr) by 2002:a05:6214:5186:: with SMTP id
 kl6mr24234101qvb.5.1627418875251; Tue, 27 Jul 2021 13:47:55 -0700 (PDT)
Date:   Tue, 27 Jul 2021 13:47:53 -0700
In-Reply-To: <CAEf4BzaLc7rvUPquXnf+qxjrLSkCR21D7hj0HNVACmwNpgZvSw@mail.gmail.com>
Message-Id: <YQBw+SLUQf0phOik@google.com>
Mime-Version: 1.0
References: <20210726230032.1806348-1-sdf@google.com> <CAEf4BzaLc7rvUPquXnf+qxjrLSkCR21D7hj0HNVACmwNpgZvSw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: increase supported cgroup storage value size
From:   sdf@google.com
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 07/27, Andrii Nakryiko wrote:
> On Mon, Jul 26, 2021 at 4:00 PM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > Current max cgroup storage value size is 4k (PAGE_SIZE). The other local
> > storages accept up to 64k (BPF_LOCAL_STORAGE_MAX_VALUE_SIZE). Let's  
> align
> > max cgroup value size with the other storages.
> >
> > For percpu, the max is 32k (PCPU_MIN_UNIT_SIZE) because percpu
> > allocator is not happy about larger values.
> >
> > netcnt test is extended to exercise those maximum values
> > (non-percpu max size is close to, but not real max).
> >
> > v3:
> > * refine SIZEOF_BPF_LOCAL_STORAGE_ELEM comment (Yonghong Song)
> > * anonymous struct in percpu_net_cnt & net_cnt (Yonghong Song)
> > * reorder free (Yonghong Song)
> >
> > v2:
> > * cap max_value_size instead of BUILD_BUG_ON (Martin KaFai Lau)
> >
> > Cc: Martin KaFai Lau <kafai@fb.com>
> > Cc: Yonghong Song <yhs@fb.com>
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  kernel/bpf/local_storage.c                  | 11 +++++-
> >  tools/testing/selftests/bpf/netcnt_common.h | 38 +++++++++++++++++----
> >  tools/testing/selftests/bpf/test_netcnt.c   | 17 ++++++---
> >  3 files changed, 53 insertions(+), 13 deletions(-)
> >
> > diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
> > index 7ed2a14dc0de..035e9e3a7132 100644
> > --- a/kernel/bpf/local_storage.c
> > +++ b/kernel/bpf/local_storage.c
> > @@ -1,6 +1,7 @@
> >  //SPDX-License-Identifier: GPL-2.0
> >  #include <linux/bpf-cgroup.h>
> >  #include <linux/bpf.h>
> > +#include <linux/bpf_local_storage.h>
> >  #include <linux/btf.h>
> >  #include <linux/bug.h>
> >  #include <linux/filter.h>
> > @@ -283,9 +284,17 @@ static int cgroup_storage_get_next_key(struct  
> bpf_map *_map, void *key,
> >
> >  static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
> >  {
> > +       __u32 max_value_size = BPF_LOCAL_STORAGE_MAX_VALUE_SIZE;
> >         int numa_node = bpf_map_attr_numa_node(attr);
> >         struct bpf_cgroup_storage_map *map;
> >
> > +       /* percpu is bound by PCPU_MIN_UNIT_SIZE, non-percu
> > +        * is the same as other local storages.
> > +        */
> > +       if (attr->map_type == BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE)
> > +               max_value_size = min_t(__u32, max_value_size,
> > +                                      PCPU_MIN_UNIT_SIZE);
> > +
> >         if (attr->key_size != sizeof(struct bpf_cgroup_storage_key) &&
> >             attr->key_size != sizeof(__u64))
> >                 return ERR_PTR(-EINVAL);
> > @@ -293,7 +302,7 @@ static struct bpf_map  
> *cgroup_storage_map_alloc(union bpf_attr *attr)
> >         if (attr->value_size == 0)
> >                 return ERR_PTR(-EINVAL);
> >
> > -       if (attr->value_size > PAGE_SIZE)
> > +       if (attr->value_size > max_value_size)
> >                 return ERR_PTR(-E2BIG);
> >
> >         if (attr->map_flags & ~LOCAL_STORAGE_CREATE_FLAG_MASK ||
> > diff --git a/tools/testing/selftests/bpf/netcnt_common.h  
> b/tools/testing/selftests/bpf/netcnt_common.h
> > index 81084c1c2c23..87f5b97e1932 100644
> > --- a/tools/testing/selftests/bpf/netcnt_common.h
> > +++ b/tools/testing/selftests/bpf/netcnt_common.h
> > @@ -6,19 +6,43 @@
> >
> >  #define MAX_PERCPU_PACKETS 32
> >
> > +/* sizeof(struct bpf_local_storage_elem):
> > + *
> > + * It really is about 128 bytes on x86_64, but allocate more to  
> account for
> > + * possible layout changes, different architectures, etc.
> > + * The kernel will wrap up to PAGE_SIZE internally anyway.
> > + */
> > +#define SIZEOF_BPF_LOCAL_STORAGE_ELEM          256
> > +
> > +/* Try to estimate kernel's BPF_LOCAL_STORAGE_MAX_VALUE_SIZE: */
> > +#define BPF_LOCAL_STORAGE_MAX_VALUE_SIZE       (0xFFFF - \
> > +                                                 
> SIZEOF_BPF_LOCAL_STORAGE_ELEM)
> > +
> > +#define PCPU_MIN_UNIT_SIZE                     32768
> > +
> >  struct percpu_net_cnt {
> > -       __u64 packets;
> > -       __u64 bytes;
> > +       union {

> so you have a struct with a single anonymous union inside, isn't that
> right? Any problems with just making struct percpu_net_cnt into union
> percpu_net_cnt?
We'd have to s/struct/union/ everywhere in this case, not sure
we want to add more churn? Seemed easier to do anonymous union+struct.

> > +               struct {
> > +                       __u64 packets;
> > +                       __u64 bytes;
> >
> > -       __u64 prev_ts;
> > +                       __u64 prev_ts;
> >
> > -       __u64 prev_packets;
> > -       __u64 prev_bytes;
> > +                       __u64 prev_packets;
> > +                       __u64 prev_bytes;
> > +               };
> > +               __u8 data[PCPU_MIN_UNIT_SIZE];
> > +       };
> >  };
> >
> >  struct net_cnt {
> > -       __u64 packets;
> > -       __u64 bytes;
> > +       union {

> similarly here

> > +               struct {
> > +                       __u64 packets;
> > +                       __u64 bytes;
> > +               };
> > +               __u8 data[BPF_LOCAL_STORAGE_MAX_VALUE_SIZE];
> > +       };
> >  };
> >
> >  #endif
> > diff --git a/tools/testing/selftests/bpf/test_netcnt.c  
> b/tools/testing/selftests/bpf/test_netcnt.c
> > index a7b9a69f4fd5..372afccf2d17 100644
> > --- a/tools/testing/selftests/bpf/test_netcnt.c
> > +++ b/tools/testing/selftests/bpf/test_netcnt.c
> > @@ -33,11 +33,11 @@ static int bpf_find_map(const char *test, struct  
> bpf_object *obj,
> >
> >  int main(int argc, char **argv)
> >  {
> > -       struct percpu_net_cnt *percpu_netcnt;
> > +       struct percpu_net_cnt *percpu_netcnt = NULL;
> >         struct bpf_cgroup_storage_key key;
> > +       struct net_cnt *netcnt = NULL;
> >         int map_fd, percpu_map_fd;
> >         int error = EXIT_FAILURE;
> > -       struct net_cnt netcnt;
> >         struct bpf_object *obj;
> >         int prog_fd, cgroup_fd;
> >         unsigned long packets;
> > @@ -52,6 +52,12 @@ int main(int argc, char **argv)
> >                 goto err;
> >         }
> >
> > +       netcnt = malloc(sizeof(*netcnt));

> curious, was it too big to be just allocated on the stack? Isn't the
> thread stack size much bigger than 64KB (at least by default)?
I haven't tried really, I just moved it to malloc because it crossed
some unconscious boundary for the 'stuff I allocate on the stack'.
I can try it out if you prefer to keep it on the stack, let me know.

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA7860961C
	for <lists+bpf@lfdr.de>; Sun, 23 Oct 2022 22:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiJWU05 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Oct 2022 16:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiJWU04 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 Oct 2022 16:26:56 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C5B65833
        for <bpf@vger.kernel.org>; Sun, 23 Oct 2022 13:26:55 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id cr19so4742716qtb.0
        for <bpf@vger.kernel.org>; Sun, 23 Oct 2022 13:26:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7NF/JTBVvhYG97Hu9R/Oakvp86/brX9k5Ls8pxwqbk=;
        b=smM/Fsy0MlJfji3mjzVQlGunQaOM9SVVOWP0cszqS8nbNMPzp13taNaMuZZvt3ZLdO
         JBRCXjfntn6OqhS88klNTt5e9LR1COXtu3xc7WSAFeI24ve1SsKlQOekSa/cSYuDQwe3
         gzHHeOQmr6is5l6IaS16cz9nNqLJtu6Nu3wYe5LUNF9nsEq9u7mZv5PzOAWYM4JGF6Mx
         C+pGywIhgAdIfHDnQgj769ey7OpG4pZ0EGg6UwYXHv5Wv3+33RArXEirLHvfoZ97gWlY
         A3Lfl+zrpvkyQmBS9HUF6P7R8gjH6y91Rg7kPEiY95Wxd/GhPsy0INW+TIdO0eKPJxRt
         O3ww==
X-Gm-Message-State: ACrzQf2M1alAY/tm9jHrnLuzmrexunmxZBTZcjKxT/RGhkteDKOfbJzx
        qjBGL4QOxLfzaj7Rl2B1Ejk=
X-Google-Smtp-Source: AMsMyM6+24vx61NeQfgClBmLTeaPoSZbJhq3rgdK3nPJuRbTnQiEm7CE/koex+kyd4GmHhJzKhkxTQ==
X-Received: by 2002:a05:622a:13ce:b0:39c:c82a:4584 with SMTP id p14-20020a05622a13ce00b0039cc82a4584mr24888367qtk.150.1666556814464;
        Sun, 23 Oct 2022 13:26:54 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::3f58])
        by smtp.gmail.com with ESMTPSA id cg15-20020a05622a408f00b0039c37a7914csm11552331qtb.23.2022.10.23.13.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 13:26:53 -0700 (PDT)
Date:   Sun, 23 Oct 2022 15:26:48 -0500
From:   David Vernet <void@manifault.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next v4 7/7] docs/bpf: Add documentation for new
 cgroup local storage
Message-ID: <Y1WjiCg9dZmPs+J2@maniforge.dhcp.thefacebook.com>
References: <20221023180514.2857498-1-yhs@fb.com>
 <20221023180552.2864330-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221023180552.2864330-1-yhs@fb.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Oct 23, 2022 at 11:05:52AM -0700, Yonghong Song wrote:
> Add some descriptions and examples for BPF_MAP_TYPE_CGRP_STROAGE.

s/STROAGE/STORAGE here and elsewhere

> Also illustate the major difference between BPF_MAP_TYPE_CGRP_STROAGE
> and BPF_MAP_TYPE_CGROUP_STORAGE and recommend to use
> BPF_MAP_TYPE_CGRP_STROAGE instead of BPF_MAP_TYPE_CGROUP_STORAGE
> in the end.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  Documentation/bpf/map_cgrp_storage.rst | 109 +++++++++++++++++++++++++
>  1 file changed, 109 insertions(+)
>  create mode 100644 Documentation/bpf/map_cgrp_storage.rst
> 
> diff --git a/Documentation/bpf/map_cgrp_storage.rst b/Documentation/bpf/map_cgrp_storage.rst
> new file mode 100644
> index 000000000000..4dfc7770da7e
> --- /dev/null
> +++ b/Documentation/bpf/map_cgrp_storage.rst
> @@ -0,0 +1,109 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +.. Copyright (C) 2022 Meta Platforms, Inc. and affiliates.
> +
> +===========================
> +BPF_MAP_TYPE_CGRP_STORAGE
> +===========================

Small nit, can you trim the == border so it matches the width of
BPF_MAP_TYPE_CGRP_STORAGE?

> +
> +The ``BPF_MAP_TYPE_CGRP_STORAGE`` map type represents a local fix-sized
> +storage for cgroups. It is only available with ``CONFIG_CGROUP_BPF``.

This is no longer accurate and should say, "It is only available with
``CONFIG_CGROUPS``."

> +The programs are made available by the same Kconfig. The
> +data for a particular cgroup can be retrieved by looking up the map
> +with that cgroup.
> +
> +This document describes the usage and semantics of the
> +``BPF_MAP_TYPE_CGRP_STORAGE`` map type.
> +
> +Usage
> +=====
> +
> +The map key must be ``sizeof(int)`` representing a cgroup fd.
> +To access the storage in a program, use ``bpf_cgrp_storage_get``::
> +
> +    void *bpf_cgrp_storage_get(struct bpf_map *map, struct cgroup *cgroup, void *value, u64 flags)
> +
> +``flags`` could be 0 or ``BPF_LOCAL_STORAGE_GET_F_CREATE`` which indicates that
> +a new local storage will be created if one does not exist.
> +
> +The local storage can be removed with ``bpf_cgrp_storage_delete``::
> +
> +    long bpf_cgrp_storage_delete(struct bpf_map *map, struct cgroup *cgroup)
> +
> +The map is available to all program types.
> +
> +Examples
> +========
> +
> +A bpf program example with BPF_MAP_TYPE_CGRP_STORAGE::
> +
> +    #include <vmlinux.h>
> +    #include <bpf/bpf_helpers.h>
> +    #include <bpf/bpf_tracing.h>
> +
> +    struct {
> +            __uint(type, BPF_MAP_TYPE_CGRP_STORAGE);
> +            __uint(map_flags, BPF_F_NO_PREALLOC);
> +            __type(key, int);
> +            __type(value, long);
> +    } cgrp_storage SEC(".maps");
> +
> +    SEC("tp_btf/sys_enter")
> +    int BPF_PROG(on_enter, struct pt_regs *regs, long id)
> +    {
> +            struct task_struct *task = bpf_get_current_task_btf();
> +            long *ptr;
> +
> +            ptr = bpf_cgrp_storage_get(&cgrp_storage, task->cgroups->dfl_cgrp, 0,
> +                                       BPF_LOCAL_STORAGE_GET_F_CREATE);
> +            if (ptr)
> +                __sync_fetch_and_add(ptr, 1);
> +
> +            return 0;
> +    }
> +
> +Userspace accessing map declared above::
> +
> +    #include <linux/bpf.h>
> +    #include <linux/libbpf.h>
> +
> +    __u32 map_lookup(struct bpf_map *map, int cgrp_fd)
> +    {
> +            __u32 *value;
> +            value = bpf_map_lookup_elem(bpf_map__fd(map), &cgrp_fd);
> +            if (value)
> +                return *value;
> +            return 0;
> +    }
> +
> +Difference Between BPF_MAP_TYPE_CGRP_STORAGE and BPF_MAP_TYPE_CGROUP_STORAGE
> +============================================================================
> +
> +The old cgroup storage map ``BPF_MAP_TYPE_CGROUP_STORAGE`` has been marked as
> +deprecated (renamed to ``BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED``). The new
> +``BPF_MAP_TYPE_CGRP_STORAGE`` map should be used instead. The following
> +illusates the main difference between ``BPF_MAP_TYPE_CGRP_STORAGE`` and
> +``BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED``.
> +
> +(1). ``BPF_MAP_TYPE_CGRP_STORAGE`` can be used by all program types while
> +     ``BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED`` is available only to cgroup program types
> +     like BPF_CGROUP_INET_INGRESS or BPF_CGROUP_SOCK_OPS, etc.
> +
> +(2). ``BPF_MAP_TYPE_CGRP_STORAGE`` supports local storage for more than one
> +     cgroup while ``BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED`` only support one cgroup

s/only support/only supports

> +     which is attached by a bpf program.
> +
> +(3). ``BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED`` allocates local storage at attach time so
> +     ``bpf_get_local_storage()`` always returns non-NULL local storage.
> +     ``BPF_MAP_TYPE_CGRP_STORAGE`` allocates local storage at runtime so
> +     it is possible that ``bpf_cgrp_storage_get()`` may return null local storage.
> +     To avoid such null local storage issue, user space can do
> +     ``bpf_map_update_elem()`` to pre-allocate local storage before a bpf program
> +     is attached.
> +
> +(4). ``BPF_MAP_TYPE_CGRP_STORAGE`` supports deleting local storage by a bpf program
> +     while ``BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED`` only deletes storage during
> +     prog detach time.
> +
> +So overall, ``BPF_MAP_TYPE_CGRP_STORAGE`` supports all ``BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED``
> +functionality and beyond. It is recommended to use ``BPF_MAP_TYPE_CGRP_STORAGE``
> +instead of ``BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED``.
> -- 
> 2.30.2
> 

One more thought / consideration which you can of course feel free to
ignore. If we're using the acronym "bpf" in documentation (acronym
meaning it's used on its own rather than e.g. in a variable name), IMO
we should capitalize it to "BPF". Very minor thing, but I think it makes
the docs look a bit more polished. Up to you, and not a big deal either
way.

Anyways, this looks great, thanks again for writing it up! Everything I
pointed out was a minor typo / fix so:

Acked-by: David Vernet <void@manifault.com>

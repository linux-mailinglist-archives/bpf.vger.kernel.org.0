Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68296070BB
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 09:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiJUHMY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 03:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiJUHMX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 03:12:23 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C2D1DEC3F
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 00:12:20 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id h24so1123452qta.7
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 00:12:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VfyPabQkDyMp1JmYyIhlX0/xsjb9WQjxRrWjFaYd/ss=;
        b=FvSWtDeES5x+zTJKy3SrTgt11LmpP84bY/qwQO2/IlMNnfgx77FzbKXw8C1QTMIU/t
         0lbMUf52eMYuDAmZQYCscU/IoqLrHr7+4XUQHv/CVyJnN2ystq20NyJ1g3xu4u157pIN
         l/gYjbA7e1cR8bdFpZfK8yObe8RKCvool5UWIkGxN93Kh2bWbDQRmta+vRUZOIlwO8pd
         0uV0lzoc6kKOrgx5fSH4uDR5clefN8o3evXNsMwiCF0AqQp9nLnblETvMRDoF5UpaQnM
         em7LorheoJH3+fWVrHKdrv3WkXW7TQyN1/hQUaYJNvPWfwGZOtYuavtywUeNHlnnacbm
         0wdg==
X-Gm-Message-State: ACrzQf2lhOj3aHWHtIvwRoJp6/rjSedLSQBZAR5IZ22VQUonI3SzkH71
        zNlAPMfir7yiMFh+H3FiKpzyAfWJD2UEBQ==
X-Google-Smtp-Source: AMsMyM6GjiIV5v3RAwSzQViHXjtIRe30s1BjqPCDC06l9IKG404tWNhKUPK/vg99FNgHTzccx168tQ==
X-Received: by 2002:a05:622a:138b:b0:39c:eb5a:5c33 with SMTP id o11-20020a05622a138b00b0039ceb5a5c33mr15189435qtk.412.1666336339321;
        Fri, 21 Oct 2022 00:12:19 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::80b7])
        by smtp.gmail.com with ESMTPSA id h24-20020ac85158000000b00304fe5247bfsm7519281qtn.36.2022.10.21.00.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 00:12:18 -0700 (PDT)
Date:   Fri, 21 Oct 2022 02:12:21 -0500
From:   David Vernet <void@manifault.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next v2 6/6] docs/bpf: Add documentation for map type
 BPF_MAP_TYPE_CGRP_STROAGE
Message-ID: <Y1JGVW9joJd9wipN@maniforge.dhcp.thefacebook.com>
References: <20221020221255.3553649-1-yhs@fb.com>
 <20221020221327.3557258-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020221327.3557258-1-yhs@fb.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 20, 2022 at 03:13:27PM -0700, Yonghong Song wrote:
> Add some descriptions and examples for BPF_MAP_TYPE_CGRP_STROAGE.
> Also illustate the major difference between BPF_MAP_TYPE_CGRP_STROAGE
> and BPF_MAP_TYPE_CGROUP_STORAGE and recommend to use
> BPF_MAP_TYPE_CGRP_STROAGE instead of BPF_MAP_TYPE_CGROUP_STORAGE
> in the end.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  Documentation/bpf/map_cgrp_storage.rst | 104 +++++++++++++++++++++++++
>  1 file changed, 104 insertions(+)
>  create mode 100644 Documentation/bpf/map_cgrp_storage.rst
> 
> diff --git a/Documentation/bpf/map_cgrp_storage.rst b/Documentation/bpf/map_cgrp_storage.rst
> new file mode 100644
> index 000000000000..15691aab7fc7
> --- /dev/null
> +++ b/Documentation/bpf/map_cgrp_storage.rst
> @@ -0,0 +1,104 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +.. Copyright (C) 2022 Meta Platforms, Inc. and affiliates.
> +
> +===========================
> +BPF_MAP_TYPE_CGRP_STORAGE
> +===========================
> +
> +The ``BPF_MAP_TYPE_CGRP_STORAGE`` map type represents a local fix-sized
> +storage for cgroups. It is only available with ``CONFIG_CGROUP_BPF``.
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
> +    long bpf_cgrp_storage_delete(struct bpf_map *map, struct cgruop *cgroup)

s/cgruop/cgroup

> +
> +The map is available to all program types.
> +
> +Examples
> +========
> +
> +An bpf-program example with BPF_MAP_TYPE_CGRP_STORAGE::

s/An bpf-program/A bpf program

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
> +The main difference between ``BPF_MAP_TYPE_CGRP_STORAGE`` and ``BPF_MAP_TYPE_CGROUP_STORAGE``
> +is that ``BPF_MAP_TYPE_CGRP_STORAGE`` can be used by all program types while
> +``BPF_MAP_TYPE_CGROUP_STORAGE`` is available only to cgroup program types.

Suggestion: I'd consider going into just a bit more detail about what's
meant by "cgroup program types" here. Maybe just 1-2 sentences
describing the types of programs where the deprecated cgroup storage map
type is available, and why. A program that's using the
BPF_MAP_TYPE_CGRP_STORAGE map is conceptually also a "cgroup program
type" in that it's querying, analyzing, etc cgroups, so being explicit
may help get ahead of any confusion.

Also, given that BPF_MAP_TYPE_CGROUP_STORAGE is deprecated, and is
extremely close in name to BPF_MAP_TYPE_CGRP_STORAGE, perhaps we should
start this section out by explaining that BPF_MAP_TYPE_CGROUP_STORAGE is
a deprecated map type that's now aliased to
BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED, and then reference it as
BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED for the rest of the page. I think
it's important to highlight that the map type is deprecated, and give
some historical context here so that users understand why they should
use BPF_MAP_TYPE_CGRP_STORAGE, and why we have two such confusingly-
similarly named maps. What do you think?

> +There are some other differences as well.
> +
> +(1). ``BPF_MAP_TYPE_CGRP_STORAGE`` supports local storage for more than one
> +     cgroups while ``BPF_MAP_TYPE_CGROUP_STORAGE`` only support one, the one attached

s/cgroups/cgroup

> +     by the bpf program.
> +
> +(2). ``BPF_MAP_TYPE_CGROUP_STORAGE`` allocates local storage at attach time so
> +     ``bpf_get_local_storage()`` always returns non-null local storage.

Suggestion: s/non-null/non-NULL. In general, I'd suggest changing null
to NULL throughout the page, but I don't feel strongly about it.

> +     ``BPF_MAP_TYPE_CGRP_STORAGE`` allocates local storage at runtime so
> +     it is possible that ``bpf_cgrp_storage_get()`` may return null local storage.
> +     To avoid such null local storage issue, user space can do
> +     ``bpf_map_update_elem()`` to pre-allocate local storage.

Should we specify that user space can preallocate by doing
bpf_map_update_elem() _before_ the program is attached? Also, another
small nit, but I think pre-allocate and de-allocate should just be
preallocate and deallocate respectively.

> +(3). ``BPF_MAP_TYPE_CGRP_STORAGE`` supports de-allocating local storage by bpf program

s/by bpf program/by a bpf program

> +     while ``BPF_MAP_TYPE_CGROUP_STORAGE`` only de-allocates storage during
> +     prog detach time.
> +
> +So overall, ``BPF_MAP_TYPE_CGRP_STORAGE`` supports all ``BPF_MAP_TYPE_CGROUP_STORAGE``
> +functionality and beyond. It is recommended to use ``BPF_MAP_TYPE_CGRP_STORAGE``
> +instead of ``BPF_MAP_TYPE_CGROUP_STORAGE``.

As mentioned above, I think we need to go beyond stating that using
BPF_MAP_TYPE_CGRP_STORAGE is recommended, and also explicitly and loudly
call out that BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED is deprecated and
will not be supported indefinitely.

Overall though, this looks great. Thank you for writing it up.

Thanks,
David

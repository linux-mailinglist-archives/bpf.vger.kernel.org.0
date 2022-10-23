Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52566095F0
	for <lists+bpf@lfdr.de>; Sun, 23 Oct 2022 22:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiJWUCi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 23 Oct 2022 16:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiJWUCg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 23 Oct 2022 16:02:36 -0400
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3C86566D
        for <bpf@vger.kernel.org>; Sun, 23 Oct 2022 13:02:35 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id t16so5395580qvm.9
        for <bpf@vger.kernel.org>; Sun, 23 Oct 2022 13:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ueNW7TYaUKRK8OYy1qO6JZpPJiwuW1Zpy1F27df0y8k=;
        b=QKrOPJwqIIt0RHOc4FMLS259EYJmy2yiNbQLCbCP2PTULzG8/gsQxx/VBEXozZy0Hp
         fb1FVOFsvISpiuKz6oMgDGJpAsRkgY5QZI5O88L7go4q79v6YCeEt4EpxqioUerHlPE3
         S0Agu2NTSi6mgkOy4CIS9VEFYnmS02rr592s0Wh9J0z3KUYa9h5Qlw+h38ZdCkkozsTG
         EaIODby43ip9XcQJN0Y2q2e/JU9bAT6KW9/08a88RL3ZwU6rNNjAaNMnfxA4yLb7H7oY
         R2sCt8AQi45inBQEgCmrnDXmCUrais6W6eveAMR/E2dTRV0QNnRjZ13bLwKrJHOgFAlR
         bvYw==
X-Gm-Message-State: ACrzQf0r7+zDVkFLYo5uBs3aXOYx+/uxdJYbBtgP17HmUnh6WxJpVeM8
        CoZMXfWsmIaUKoXyQ8QKNhQ=
X-Google-Smtp-Source: AMsMyM7adyuWQNwBaHJa9ogUFjDYtH2R4d0Fa1pbB5SIis7qAC0Tz7Q0atkp0Udm7OZrMaLFTJXjOQ==
X-Received: by 2002:a05:6214:411e:b0:4b1:a97e:454 with SMTP id kc30-20020a056214411e00b004b1a97e0454mr24527492qvb.118.1666555354340;
        Sun, 23 Oct 2022 13:02:34 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::3f58])
        by smtp.gmail.com with ESMTPSA id de20-20020a05620a371400b006ef1a8f1b81sm5991463qkb.5.2022.10.23.13.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 13:02:31 -0700 (PDT)
Date:   Sun, 23 Oct 2022 15:02:26 -0500
From:   David Vernet <void@manifault.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next v4 3/7] bpf: Implement cgroup storage available
 to non-cgroup-attached bpf progs
Message-ID: <Y1Wd0nvmeIr2v9de@maniforge.dhcp.thefacebook.com>
References: <20221023180514.2857498-1-yhs@fb.com>
 <20221023180530.2860453-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221023180530.2860453-1-yhs@fb.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Oct 23, 2022 at 11:05:30AM -0700, Yonghong Song wrote:
> Similar to sk/inode/task storage, implement similar cgroup local storage.
> 
> There already exists a local storage implementation for cgroup-attached
> bpf programs.  See map type BPF_MAP_TYPE_CGROUP_STORAGE and helper
> bpf_get_local_storage(). But there are use cases such that non-cgroup
> attached bpf progs wants to access cgroup local storage data. For example,
> tc egress prog has access to sk and cgroup. It is possible to use
> sk local storage to emulate cgroup local storage by storing data in socket.
> But this is a waste as it could be lots of sockets belonging to a particular
> cgroup. Alternatively, a separate map can be created with cgroup id as the key.
> But this will introduce additional overhead to manipulate the new map.
> A cgroup local storage, similar to existing sk/inode/task storage,
> should help for this use case.
> 
> The life-cycle of storage is managed with the life-cycle of the
> cgroup struct.  i.e. the storage is destroyed along with the owning cgroup
> with a call to bpf_cgrp_storage_free() when cgroup itself
> is deleted.
> 
> The userspace map operations can be done by using a cgroup fd as a key
> passed to the lookup, update and delete operations.
> 
> Typically, the following code is used to get the current cgroup:
>     struct task_struct *task = bpf_get_current_task_btf();
>     ... task->cgroups->dfl_cgrp ...
> and in structure task_struct definition:
>     struct task_struct {
>         ....
>         struct css_set __rcu            *cgroups;
>         ....
>     }
> With sleepable program, accessing task->cgroups is not protected by rcu_read_lock.
> So the current implementation only supports non-sleepable program and supporting
> sleepable program will be the next step together with adding rcu_read_lock
> protection for rcu tagged structures.
> 
> Since map name BPF_MAP_TYPE_CGROUP_STORAGE has been used for old cgroup local
> storage support, the new map name BPF_MAP_TYPE_CGRP_STORAGE is used
> for cgroup storage available to non-cgroup-attached bpf programs. The old
> cgroup storage supports bpf_get_local_storage() helper to get the cgroup data.
> The new cgroup storage helper bpf_cgrp_storage_get() can provide similar
> functionality. While old cgroup storage pre-allocates storage memory, the new
> mechanism can also pre-allocate with a user space bpf_map_update_elem() call
> to avoid potential run-time memory allocation failure.
> Therefore, the new cgroup storage can provide all functionality w.r.t.
> the old one. So in uapi bpf.h, the old BPF_MAP_TYPE_CGROUP_STORAGE is alias to
> BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED to indicate the old cgroup storage can
> be deprecated since the new one can provide the same functionality.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Looks great, thanks. Only other thing I'll mention is that I think Tejun
had pointed out in [0] that cg was usually more used as an abbreviation.
I don't feel strongly one way or the other, so here's my ack either way.

[0]: https://lore.kernel.org/all/Y1NByH+suY2s65Kh@slm.duckdns.org/

Acked-by: David Vernet <void@manifault.com>

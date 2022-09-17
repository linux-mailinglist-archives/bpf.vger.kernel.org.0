Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BC25BB92E
	for <lists+bpf@lfdr.de>; Sat, 17 Sep 2022 17:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiIQPnI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Sep 2022 11:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiIQPnG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Sep 2022 11:43:06 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1463932AAE
        for <bpf@vger.kernel.org>; Sat, 17 Sep 2022 08:43:03 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id 138so18748776iou.9
        for <bpf@vger.kernel.org>; Sat, 17 Sep 2022 08:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Rctxp8ISFZSXim/XgDc87NGqTNK31fos2U0MpRy61NM=;
        b=kIWzl0n4yJ3qpzCjDmiXvHfOQund1pt+y12jFY8QUhHJIlgSThXUkN85v7oy7iyTpD
         AgRBuZRXOCGvVMqLn7oh42Xrl9cEg1dE5kMH93CHpQX3DBlFuDIunosppHN7w48p2ZfM
         0QfLS+u+t7b+09Wtr7VvgcAChLlmEjYTY9633QY6ybsc9Okzxq+RGDZAqxbDZnVOL2vD
         4NOOE8350Jn1WZ+n0yymO1sjIf5XqiF7Hgm3mWizc7ixxa06haf/Bkj5RWjYIKFqmZzB
         7LvJtTScfrWqXn/VcpSEOt9PLSqxRzSzk82qafxkKnAbk/E9A4vxtdMlnQVxe99JkUe4
         lNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Rctxp8ISFZSXim/XgDc87NGqTNK31fos2U0MpRy61NM=;
        b=eoH/ncgzxTca7ICOLmtOrzd81WS8Y+jU8mMRCSzAXKYHFothzT+5oW8AezV2+kd/g/
         khdYMvB1pjheGdS0f1RVc4ZzR81lBpHi2loysqvxnQdFI1Q6jLERSZR31gICiR5Ir1JG
         T3Rd7E00IFiQ2G+TBc+k6PVRvLu6R+muL7OqhA4r1b11t7HVx6mC5Xv/e6GUSzYX7XVY
         p1IcCSld0ujWHq/FniY7+E3gvmL1Nc+Ggz7zXFeL0u34i4ylM9k8BgXfUgC/X1Ier6uq
         H0nNvrRtZTatC6xatkKXOLYU2FVZrTmm2TfttCsrhiM0dFB4lFm5qkmAWukODu7Ho1P9
         Z/vg==
X-Gm-Message-State: ACrzQf1WiEz4F63kv68rQm8LAihe3nzjD1lpMswnfqGiDkSUr38ufBzd
        VvgNKFHpjbYL/0StkiuGA12+ouvjjJHy13Or/EAzHliujmkQMw==
X-Google-Smtp-Source: AMsMyM4AGloMKVbNSF8wYOY9UYuht3tPeD2cDoMSXL+6wyPXQTLq7aRGrkyHGVdCdwpNqzLdkFKnNpPjXVeGjypkmkQ=
X-Received: by 2002:a5d:9257:0:b0:6a1:2052:bf0a with SMTP id
 e23-20020a5d9257000000b006a12052bf0amr3841486iol.186.1663429382347; Sat, 17
 Sep 2022 08:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com>
In-Reply-To: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Sat, 17 Sep 2022 08:42:46 -0700
Message-ID: <CAKH8qBtcgdWgJ8JcefFyQPG1FVcLF9hdXKbgf1xhm0nLEVVy3A@mail.gmail.com>
Subject: Re: Closing the BPF map permission loophole
To:     Lorenz Bauer <oss@lmb.io>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 15, 2022 at 3:31 AM Lorenz Bauer <oss@lmb.io> wrote:
>
> Hi list,
>
> Here is a summary of the talk I gave at LPC '22 titled "Closing the BPF map permission loophole", with slides at [0].
>
> Problem #1: Read-only fds can be modified via a BPF program
>
> 1. Craft a BPF program that executes bpf_map_update_elem(read-only fd, ...)
> 2. Load the program & execute it
>
> The reason is that the verifier only checks bpf_map->map_flags in resolve_pseudo_ldimm64, but ignores fd->f_mode.
>
> Fixing this problem is complicated by the fact that a user may use several distinct fds with differing permissions to refer to the same map, but that the verifier internally only tracks unique struct bpf_map. See [1].
>
> Problem #2: Read-only fds can be "transmuted" into read-write fds via map in map
>
> 1. BPF_MAP_UPDATE_ELEM(map in map fd, read-only fd)
> 2. BPF_MAP_LOOKUP_ELEM(map in map fd) = read-write fd
>
> This was pointed out by Stanislav Fomichev during the LPC session. I've not yet tried this myself.
>
> Problem #3: Read-only fds can be transmuted into read-write fds via object pinning
>
> 1. BPF_OBJ_PIN(read-only fd, /sys/fs/bpf/foo)
> 2. BPF_OBJ_GET(/sys/fs/bpf/foo) = read-write fd
>
> The problem is with BPF_OBJ_PIN semantics: regardless of fd->f_mode, pinning creates an inode that is owned by the current user, with mode o=rw. Even if we made the inode o=r, a user / attacker can still use chmod(2) to change it back to o=rw.
>
> On older kernels, this requires either unprivileged BPF or CAP_BPF, but recently BPF_OBJ_PIN has been made available without CAP_BPF.
>
> This problem also applies to other BPF objects: links, programs, maybe iterators? Since we don't have BPF_F_RDONLY semantics for those the issue is maybe less urgent, but see [2] for some more fun.
>
> A number of ideas were explored during the session:
>
> * In OBJ_PIN, create the inode owned by the user that executed MAP_CREATE, not the user that
>   invoked OBJ_PIN. This would allow unprivileged users to create files as another user, which
>   seems like a bad idea.
> * In OBJ_GET, refuse a read-write fd if the fd passed to OBJ_PIN wasn't read-write. This is not
>   possible since we store struct bpf_map * in the inode, so we don't have access to fd->f_mode
>   anymore.
> * In OBJ_PIN, adjust the mode of the created inode to match fd->f_mode, and later refuse attempts
>   to chmod(2). After a cursory glance at the source code it seems like there are no hooks for
>   filesystems to influence chmod.
>
> My gut feeling is that the root of the problem is that OBJ_PIN is too permissive. Once an inode exists that is owned by the current user the cat is out of the box.
>
> BPF_F_RDONLY and BPF_F_WRONLY were introduced in 4.15 [3]. If we want to fix this properly, aka relying on BPF_R_RDONLY doesn't introduce a gaping hole, we'll have to do quite a bit of backporting.
>
> I plan on submitting a sledgehammer approach fix for #1 and #2 as discussed with Daniel after my presentation.
>

[..]

> #3 is in sore need of further discussion and creativity. One avenue I want to explore is whether we can refuse OBJ_PIN if:
> - the current user is not the map creator
> - and the fd is not r/w
> - and the current user has no CAP_DAC_OVERRIDE (or similar)

Thank you, Lorenz, for a nice summary!

We might start by plugging the hole by requiring CAP_BPF for OBJ_PIN
and then discussing a better way forward (unless somebody has better
ideas). I'm traveling so I don't have time to think this through yet
:-(

Our use-case for unpriv so far is for some CAP_BPF process to pin a
read-only map and chmod it to 0755 for unpriv programs to read.

> Thanks
> Lorenz
>
> 0: https://lpc.events/event/16/contributions/1372/attachments/977/2059/Plumbers%2022%20Closing%20the%20BPF%20map%20permission%20loophole.pdf
> 1: https://elixir.bootlin.com/linux/v6.0-rc5/source/kernel/bpf/verifier.c#L12839
> 2: https://lore.kernel.org/bpf/20210618105526.265003-1-zenczykowski@gmail.com/
> 3: https://github.com/torvalds/linux/commit/6e71b04a8224

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97195BA4F1
	for <lists+bpf@lfdr.de>; Fri, 16 Sep 2022 05:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiIPDEj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Sep 2022 23:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiIPDER (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Sep 2022 23:04:17 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C58A98D21
        for <bpf@vger.kernel.org>; Thu, 15 Sep 2022 20:04:09 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id v15so10710932iln.6
        for <bpf@vger.kernel.org>; Thu, 15 Sep 2022 20:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=9e3bR4VUntRfLU7LBMqE2BGvJJCtXZnkVdPNUSg9f/8=;
        b=oTNAPmSsihwRulZEQJT1gYxb6/oF3iYZK8sPnQGMhGeflp3Mihfyh2z/HpQLFy/JXE
         BP5/KMGFFq4soR3QO1DEmv3mmr1Wh2fOd41/mJserT+quaiaBVyZtHtXoozq1wFHkdln
         iFXgCbtpxzbMZo3wS3DzOK+mHL/TQsYO/yWviRUcDKtgmLdaacSrV8eZ61xT6PLFKctj
         joc9mETJhNz5mgiBvEKi4hxGLUzcDjUn6OXEe6MULwePsPEXfpaXAYMhHWoKsBXx3eR0
         hbuyYmjlx6asBY+bJJELzOYJraPFPFiN/XETNeLbsiUoM+1JcIq6edlVAI9vv0nEnWHr
         TY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=9e3bR4VUntRfLU7LBMqE2BGvJJCtXZnkVdPNUSg9f/8=;
        b=OL0/NFgfaf91aDKCOZudutP88IUsP4n6QzlAsppaPoKKNOUwgKbdW/AlGdO369jyCm
         Ac2+ukk+LA/CtQYuHYDfsuQkDgi4+OLT0jQtMHj3RdFaSW7hZ3zQUk/H+ZcbO+T6VNYj
         LMLkA6iJ5PwY1aUihhKxONfzL3TR0kPCwKoa0UID5M2kjZodI5walpCOBcLnxxAuG3ei
         Af7sbNTU2QGE+qNIXBd8iQHSlvnGuJ9qCzaeFp8HD5jKnE/fXvSxQDcrBvI+0PyL1UTj
         9zX9hnzJsezHjzhT3mpRIseJFt+AjMmqexf3i2rRJC1YVKkLzMhFxynB9VYuHbxorJ/0
         5XRQ==
X-Gm-Message-State: ACrzQf2wd83nEbOK9p+U8G8/sYV/1zRcqD07M4nRiQOk7PNA9F5HjQhR
        Y3XSbfXvK8+ZAN29AAIuqPZtl6euUTt/XuC2VQ0=
X-Google-Smtp-Source: AMsMyM4PZSQnpojFBaoGcs2jrUA8nibgND9SjzrWruaCKYljyzhi+93u7roGaKwZ57rAruKOXoNjTA65lk2N1tTDztc=
X-Received: by 2002:a92:d5cd:0:b0:2f4:9660:1ba9 with SMTP id
 d13-20020a92d5cd000000b002f496601ba9mr1378617ilq.91.1663297448091; Thu, 15
 Sep 2022 20:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com>
In-Reply-To: <a6c0bb85-6eeb-407e-a515-06f67e70db57@www.fastmail.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Fri, 16 Sep 2022 05:03:32 +0200
Message-ID: <CAP01T76fv-qpBsEp8CJbg6FzcbKAWPRq+cDoNCWhcaTJvuNyxg@mail.gmail.com>
Subject: Re: Closing the BPF map permission loophole
To:     Lorenz Bauer <oss@lmb.io>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
        luto@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 15 Sept 2022 at 12:41, Lorenz Bauer <oss@lmb.io> wrote:
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

Just for completeness, this was also pointed out by Andy back in 2019:
https://lore.kernel.org/bpf/CALCETrVtPs8gY-H4gmzSqPboid3CB++n50SvYd6RU9YVde_-Ow@mail.gmail.com

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
> #3 is in sore need of further discussion and creativity. One avenue I want to explore is whether we can refuse OBJ_PIN if:
> - the current user is not the map creator
> - and the fd is not r/w
> - and the current user has no CAP_DAC_OVERRIDE (or similar)
>
> Thanks
> Lorenz
>
> 0: https://lpc.events/event/16/contributions/1372/attachments/977/2059/Plumbers%2022%20Closing%20the%20BPF%20map%20permission%20loophole.pdf
> 1: https://elixir.bootlin.com/linux/v6.0-rc5/source/kernel/bpf/verifier.c#L12839
> 2: https://lore.kernel.org/bpf/20210618105526.265003-1-zenczykowski@gmail.com/
> 3: https://github.com/torvalds/linux/commit/6e71b04a8224

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2681662B099
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 02:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiKPBhw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 20:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiKPBhu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 20:37:50 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A86123E91
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 17:37:49 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id f18so7610826ejz.5
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 17:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2FjLAjjbHVSLzrs9BYWAHe9VReAjwoMOzwaJ7GfRQyg=;
        b=agnXGG/mKssJkO/gcdFqkt31t2V0ns9pkBtlAg2tjmovugYb9qGwQzgbveScQSWZGT
         dD61LEjhOlY6RlH7plHLxDwjaEAgLCdrEDwFvPQldQlIhwr94q3hjnqYydhs/4lEm3e1
         9FgYxd1aocL1fcu9QrE3vpZ6CeY2A9+xZghbQdNZ5Ek4rO1NRijSVZftYahG1DzBPyyU
         kkUla2Aj9TT8JzpdIHwurLWqTQgNxq4MjZcq0TJHON8w0z4QjcwQwOIqKd8ulyJY3ILi
         J2mw681pZXM0EEX0JXphUYzIYTBlsI1YPVNaSjsVLP1VTRbX84JuqGWvzee9hbfijmU6
         AoRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2FjLAjjbHVSLzrs9BYWAHe9VReAjwoMOzwaJ7GfRQyg=;
        b=eNaDRiBDyJTXdNObBEYCIsm1+QI/2eIiqAugbiyN2+ldpwhMKt5jc3xyN25qL7i81s
         XKl38OePHKQfz4UpQmVsalkimshvG0WNW1rgB8JjEsMjR+jzumuL6oX1vKR4rzDpI7js
         VPeJq73plMsmSmXAtVh/b2R5LJI5E3/se6Qhb+nx66rwMEPFMRmikMpV1wFdEJ5jPm4i
         28+HaW3N0hTF2LOi5mV5Ha6ZS3V0K04j5v5CYMy+vSQJO2Ulyjx9eHgostdVxbfffWxN
         f4mL4DQSeEnJ6nMjK4ar+wTNB3BEUzwokjV+KbStNbdqxPRyrzWJf5he4NUgZVIc9XuF
         iHvw==
X-Gm-Message-State: ANoB5pkWtOGxbJXhGqKzeWIcvAXz0etS31AsqdnbW9oq8XjiHU48SEhk
        67pCKhGHybl3dqLzBdu2LzcrCSsr5OGeBUKNQ7U=
X-Google-Smtp-Source: AA0mqf4Cw6hsKmjWlLgNVJoITkTmiTBblm8YauCrmgiog6Hb212gVNlB364XpILkWRvjmO8tWbVcs7SJ0vByRNIpHNY=
X-Received: by 2002:a17:907:a701:b0:78d:9858:e538 with SMTP id
 vw1-20020a170907a70100b0078d9858e538mr16543965ejc.502.1668562668014; Tue, 15
 Nov 2022 17:37:48 -0800 (PST)
MIME-Version: 1.0
References: <20221111063417.1603111-1-houtao@huaweicloud.com>
 <20221111063417.1603111-2-houtao@huaweicloud.com> <33b5fc4e-be12-3aa8-b063-47aa998b951c@linux.dev>
In-Reply-To: <33b5fc4e-be12-3aa8-b063-47aa998b951c@linux.dev>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 15 Nov 2022 17:37:36 -0800
Message-ID: <CAADnVQ+Mxb8Wj3pODPovh9L1S+VDsj=4ufP3M70LQz4fSBaDww@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/3] bpf: Pin iterator link when opening iterator
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Hou Tao <houtao@huaweicloud.com>, bpf <bpf@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Hou Tao <houtao1@huawei.com>
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

On Tue, Nov 15, 2022 at 11:16 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> On 11/10/22 10:34 PM, Hou Tao wrote:
> > From: Hou Tao <houtao1@huawei.com>
> >
> > For many bpf iterator (e.g., cgroup iterator), iterator link acquires
> > the reference of iteration target in .attach_target(), but iterator link
> > may be closed before or in the middle of iteration, so iterator will
> > need to acquire the reference of iteration target as well to prevent
> > potential use-after-free. To avoid doing the acquisition in
> > .init_seq_private() for each iterator type, just pin iterator link in
> > iterator.
>
> iiuc, a link currently will go away when all its fds closed and pinned file
> removed.  After this change, the link will stay until the last iter is closed().
>   Before then, the user space can still "bpftool link show" and even get the
> link back by bpf_link_get_fd_by_id().  If this is the case, it would be useful
> to explain it in the commit message.
>
> and does this new behavior make sense when comparing with other link types?

One more question to the above...

Does this change mean that pinned cgroup iterator in bpffs
would prevent cgroup removal?
So that cgroup cannot even become a dying cgroup ?

If so we can do that and an approach similar to init_seq_private
taken for map iterators is necessary here as well.

Also pls target this kind of change to bpf-next especially
when there is a consideration to revert other fixes.
This kind of questionable fixes are not suitable for bpf tree
regardless of how long the "bug" was present.

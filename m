Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139484BE55B
	for <lists+bpf@lfdr.de>; Mon, 21 Feb 2022 19:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357840AbiBUM0u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Feb 2022 07:26:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357897AbiBUM0s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Feb 2022 07:26:48 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817C413E22
        for <bpf@vger.kernel.org>; Mon, 21 Feb 2022 04:26:24 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id e5so18273678lfr.9
        for <bpf@vger.kernel.org>; Mon, 21 Feb 2022 04:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Y2xp4GHZOreqBdq9NTl4mbms3BzgIagOj5DDd+YVyw=;
        b=jquks9KpBNaSJKvLDOpeUQ1oRx5U9PU5GSFXdkrYCXlHqm1tFqkfVz4WcghzJZgG4g
         TGTN/Y6L7StN9oOik/6jzGjp3B+AH8XYIFAVcW1cce4y7TDwZHET496ptGnlDDcV+NoK
         R8Vxs4eUjL/SdzSDgnxb1Im57ucEZb3wPvRdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Y2xp4GHZOreqBdq9NTl4mbms3BzgIagOj5DDd+YVyw=;
        b=wqapvkQN9U/B8pjWhq6NwLsKdgTsZ/R/1WNEIi+0nfETyfW9rpqcKYvY96uyDOVS06
         3wsMEjtAGklgHP1snbOFulGGbLgK8wcuS0aUJJ4asl2noRHFi6JcEBnUnqS3fmouTo2X
         kB/7Wo/KJ0JGZDq4smAtCzNe8MM2BiFQsrbmYiVBtZ32K06HYw7F0JJTlqfnvW5u+thH
         X29l+fmEGP4uJMJE5IHWmB+sYyyEzhQ4QziGoFkzWEUn+PVTkOYbuwKjOhHqtgmoi9O1
         syPSAaH5OkhrF+mXgpsbbihSt46mgQxt/VktvdHzFLlc5+PMRilk6I+FNpZ4aW0VKJmt
         6pIQ==
X-Gm-Message-State: AOAM532xYkZkOBj1c47nqIZ8ZvpHgynCWYqCn66bqv7xT54yFmds56vD
        EEPYiZSvkjmdE28z5zlyq4OG0giw+aZU9CAHtk2BGg==
X-Google-Smtp-Source: ABdhPJz98Au3SEhVNxRUT1hugWSSaQO9u9n+nc1yP0lSlhw9BA6ca13qMzr4QVaItu7T/OBgSJpYyWyT8/4iXhcyt+w=
X-Received: by 2002:a05:6512:2611:b0:443:1369:b599 with SMTP id
 bt17-20020a056512261100b004431369b599mr13482448lfb.569.1645446382829; Mon, 21
 Feb 2022 04:26:22 -0800 (PST)
MIME-Version: 1.0
References: <20220220042720.3336684-1-andrii@kernel.org>
In-Reply-To: <20220220042720.3336684-1-andrii@kernel.org>
From:   =?UTF-8?Q?Mauricio_V=C3=A1squez_Bernal?= <mauricio@kinvolk.io>
Date:   Mon, 21 Feb 2022 07:26:11 -0500
Message-ID: <CAHap4zsLZ80gceMUtEZnHyx8JLfxBXzGm0_cdMM0EVx5zyC-+Q@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next] selftests/bpf: fix btfgen tests
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 19, 2022 at 11:27 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> There turned out to be a few problems with btfgen selftests.
>
> First, core_btfgen tests are failing in BPF CI due to the use of
> full-featured bpftool, which has extra dependencies on libbfd, libcap,
> etc, which are present in BPF CI's build environment, but those shared
> libraries are missing in QEMU image in which test_progs is running.
>
> To fix this problem, use minimal bootstrap version of bpftool instead.
> It only depend on libelf and libz, same as libbpf, so doesn't add any
> new requirements (and bootstrap bpftool still implementes entire
> `bpftool gen` functionality, which is quite convenient).
>
> Second problem is even more interesting. Both core_btfgen and core_reloc
> reuse the same set of struct core_reloc_test_case array of test case
> definitions. That in itself is not a problem, but btfgen test replaces
> test_case->btf_src_file property with the path to temporary file into
> which minimized BTF is output by bpftool. This interferes with original
> core_reloc tests, depending on order of tests execution

ah, good catch! Thanks for the fix!

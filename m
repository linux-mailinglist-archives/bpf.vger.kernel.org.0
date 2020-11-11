Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15DE32AFD25
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 02:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgKLBcJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Nov 2020 20:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbgKKXWc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Nov 2020 18:22:32 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D0FC0613D1;
        Wed, 11 Nov 2020 15:22:32 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id c129so3506998yba.8;
        Wed, 11 Nov 2020 15:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zLAINA497HzN+bAWRfYH3EEhA2UAQMIiVvTDxBBnWcw=;
        b=O4LUkFtRH65lwdUKgb7EIgdnmlBMdqIGl8bAIWrYe5aI8zx80wpnKIpdKFlNNytchF
         3NoApHtOhlaVCBNmiV2czbYlGCnr15zBF+T/nChufjPUK7xM6AQDt2ObCND+LWPHDMFA
         QSEceKpzcbbxQ5px2r/mr5qk2b6wKT4VjCKlUXJkP/eMpH3GbBKVLuopBHgKM730byA0
         9MPVGTmGRkJuqDwV7lO/SyegzKVEnMAw7KLh+L8MqyNgYOyTmuEFOiJWryx8Yh3BlFgX
         uc8vjsE0Zq3vduAWdSYW9y4bOkCgo8XSVWUdWRP1ZCtvXkeJWBVlmID4h+tMf6/kk7Qz
         Q42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zLAINA497HzN+bAWRfYH3EEhA2UAQMIiVvTDxBBnWcw=;
        b=HsaW6rzTRJkGyDOOPYvGEq+fwd2oNJpc5YcJTBD//lhqgZGtY/1uHZgISw32lrbWt9
         2TH2l5tHIhDmyGLIgXN4BBLT+rglVN8n2/dWXoEQiUltkJcrt+b9WF77xQCG+zZjJLrK
         Kg54oXPuBi6hTrW8Dcu9eY+LCeW/J8+39yd80qOdU7U5/eleq4awIA5zFPcQvG+nxzeG
         W4D9UkFptsslnb0ptsBj0vwU7C+kEZfxqbYaujxZABIyLnUkj1xrTbpQLZzMbFv9u/Mn
         gSCPFWsrdUlUIeEiu5iMsb8htGQxAt4XK9ZmXSj5yY+6lwWUYCqVGyH68AgfXJp1B/hA
         QkhA==
X-Gm-Message-State: AOAM5333lK8ZFXkG5as+WhADXqkErGCIAwHe9afAmiguFQFMHleuOhYK
        PCEKXH4zRV5z2cSSVZfD9Bh+LRiCKPqeRylstUP0sqdRFOxTDg==
X-Google-Smtp-Source: ABdhPJx5/7pvemFIXy4D77xCw09+6AsnWpxxD7ASXsoX25rFgkB9QVSo2d/BG0rGiU6YQiUqvCPFo7dA7ht7QcwGsr8=
X-Received: by 2002:a25:df8e:: with SMTP id w136mr10307254ybg.230.1605136951985;
 Wed, 11 Nov 2020 15:22:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605134506.git.dxu@dxuuu.xyz>
In-Reply-To: <cover.1605134506.git.dxu@dxuuu.xyz>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 11 Nov 2020 15:22:21 -0800
Message-ID: <CAEf4BzZx=7N6dbKk8Eb_k-FA-PmmPFBJ=V-PLhbDu38wuXkOkw@mail.gmail.com>
Subject: Re: [PATCH bpf v5 0/2] Fix bpf_probe_read_user_str() overcopying
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 11, 2020 at 2:46 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> 6ae08ae3dea2 ("bpf: Add probe_read_{user, kernel} and probe_read_{user,
> kernel}_str helpers") introduced a subtle bug where
> bpf_probe_read_user_str() would potentially copy a few extra bytes after
> the NUL terminator.
>
> This issue is particularly nefarious when strings are used as map keys,
> as seemingly identical strings can occupy multiple entries in a map.
>
> This patchset fixes the issue and introduces a selftest to prevent
> future regressions.
>
> v4 -> v5:
> * don't read potentially uninitialized memory

I think the bigger problem was that it could overwrite unintended
memory. E.g., in BPF program, if you had something like:

char my_buf[8 + 3];
char my_precious_data[5] = {1, 2, 3, 4, 5};

With previous version you'd overwrite my_precious data. BTW, do you
test such scenario in the selftests you added? If not, we should have
something like this as well and validate 1, 2, 3, 4, 5 stay intact.

>
> v3 -> v4:
> * directly pass userspace pointer to prog
> * test more strings of different length
>
> v2 -> v3:
> * set pid filter before attaching prog in selftest
> * use long instead of int as bpf_probe_read_user_str() retval
> * style changes
>
> v1 -> v2:
> * add Fixes: tag
> * add selftest
>
> Daniel Xu (2):
>   lib/strncpy_from_user.c: Don't overcopy bytes after NUL terminator
>   selftest/bpf: Test bpf_probe_read_user_str() strips trailing bytes
>     after NUL
>
>  lib/strncpy_from_user.c                       |  9 ++-
>  .../bpf/prog_tests/probe_read_user_str.c      | 71 +++++++++++++++++++
>  .../bpf/progs/test_probe_read_user_str.c      | 25 +++++++
>  3 files changed, 100 insertions(+), 5 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/probe_read_user_str.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_probe_read_user_str.c
>
> --
> 2.29.2
>

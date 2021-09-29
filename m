Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934D641BF17
	for <lists+bpf@lfdr.de>; Wed, 29 Sep 2021 08:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244320AbhI2GZj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Sep 2021 02:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244226AbhI2GZj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Sep 2021 02:25:39 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1585C061746
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 23:23:58 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id b82so3026119ybg.1
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 23:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=99Z30LtJUkiTe6vhO1kd8LoPj65Ld4vLFvR/mlhgocU=;
        b=BwZCyQauknXbNlQ7Fcu2NexrrKt6rpP2s5z3Ixk4ryX6xWzIirWB9d3zmf31awldjq
         AjbDL9nDJ4JaW1HHT0Nu/PP1oIUqc4q/LwT+x69SNHLzHscOvo/7+Z7NEvt6KLE3tDrG
         CqTewETQStmuSb0RjeDE6mnwsyU/NxPzhs2NULDRJoeEs45X6P7qx4iepN3DZ26pazHV
         b4jUGjYg8z8ms1PDeFw3zYOTpE9SSIW+FGNqr9fXk+ZUUAkb7XeQpG3+tnNVhL/YLY3o
         LHJO8V1xbzP3J9NRl3/MP+R7hPQ5Dmme4WqQv/RJ7AQgaEmdDQb/gOxMFwbm+Xw2uyd1
         NMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=99Z30LtJUkiTe6vhO1kd8LoPj65Ld4vLFvR/mlhgocU=;
        b=2dFsaZ3VT/b9aLIhOO3IlJPVvqBDf5EinpGgn2euhQyzpT3GVTa7tuF0KNDHLYsZzT
         uLFtJCfTLSL3bVZMfI7SKJwpHCi71xrghVnkU+IcdIhxOssq2JL9KsblA0+OJjZwROSC
         MOyUgb66NuQQpkrMENG4dgdXq6CKnwG1mxdj+t7dRKhlaRmJUHRByWXu/EBnOy4uYHm/
         /7BwC6MMcsGsZI4DzQSDwUj6BdMvxdHrvEXPEC2yxgzc8r/YYX12DNBRFBINqh4JTAEk
         gwcdbhFhQeQt6SvzDyuSfjmcWsD7Wbj7FjbwZdwdeGdB8b0OC3H9OoVw6VrkbnvMlddQ
         61gA==
X-Gm-Message-State: AOAM532g7oMhWus7OWI/uACKWu8UtpsiIoeU/skF2+DeYxdJOP5lkb4/
        pRARvW9JX5LMRinMDrUWY6kIgh/HoAu331vbjPQ=
X-Google-Smtp-Source: ABdhPJweh1rv5MlbR3U7wJEtjONBLitga7L2uCBzYp+3dygprb+hUSrrzpwLJpcEVTjXngn1OEj9RR9nGVvRnsDcFI4=
X-Received: by 2002:a25:7c42:: with SMTP id x63mr12508219ybc.225.1632896638063;
 Tue, 28 Sep 2021 23:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210929033000.3711921-1-yhs@fb.com>
In-Reply-To: <20210929033000.3711921-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 28 Sep 2021 23:23:47 -0700
Message-ID: <CAEf4Bzb9pCbwC0jncHM0F3py0xkmNc_XjOpUDH1Gm4=SQZ-4gA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: fix probe_user test failure
 with clang build kernel
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 28, 2021 at 8:30 PM Yonghong Song <yhs@fb.com> wrote:
>
> clang build kernel failed the selftest probe_user.
>   $ ./test_progs -t probe_user
>   $ ...
>   $ test_probe_user:PASS:get_kprobe_res 0 nsec
>   $ test_probe_user:FAIL:check_kprobe_res wrong kprobe res from probe read: 0.0.0.0:0
>   $ #94 probe_user:FAIL
>
> The test attached to kernel function __sys_connect(). In net/socket.c, we have
>   int __sys_connect(int fd, struct sockaddr __user *uservaddr, int addrlen)
>   {
>         ......
>   }
>   ...
>   SYSCALL_DEFINE3(connect, int, fd, struct sockaddr __user *, uservaddr,
>                   int, addrlen)
>   {
>         return __sys_connect(fd, uservaddr, addrlen);
>   }
>
> The gcc compiler (8.5.0) does not inline __sys_connect() in syscall entry
> function. But latest clang trunk did the inlining. So the bpf program
> is not triggered.
>
> To make the test more reliable, let us kprobe the syscall entry function
> instead. Note that x86_64, arm64 and s390 have syscall wrappers and they have
> to be handled specially.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Applied to bpf-next, thanks.

>  .../selftests/bpf/prog_tests/probe_user.c     |  4 +--
>  .../selftests/bpf/progs/test_probe_user.c     | 28 +++++++++++++++++--
>  2 files changed, 28 insertions(+), 4 deletions(-)
>

[...]

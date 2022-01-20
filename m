Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849B0495520
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 20:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377517AbiATT7U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Jan 2022 14:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377504AbiATT7U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Jan 2022 14:59:20 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFC5C061574;
        Thu, 20 Jan 2022 11:59:20 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id h23so8239760iol.11;
        Thu, 20 Jan 2022 11:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=krG00EaGjjhi8P+u3jEC8kSkTgVWH7baP40/YPU7XSs=;
        b=ZkqwtuGqOMp6oxNV/3t+6jHJaC+VyVfeTCQJTu3yrYaXusWYbejk/N7/DHBWJCcpKj
         DVidTvqZ8w6QX86uCMnpqJUIiJD28K+HVACsDfkeCvxMPEh43m2AIukbR3VzKCdwao9L
         +hPpWxH+EEAcAkZpMfWtgEpQvPrJ1ehbczv1B4AV5XdUgV2EV4mc/nbFzBUAZC6q4tXK
         vdqO0CdZ/SKneLeGgm/JqXV61PTZGpR3hVwyNmW8M7szzopwy19SoxbdV1EB3isQHs/8
         phkwukzAKG1dEHmsjhR7tWpi1OnptaViXPGnexre012Ajl5+pzZhEE/NV+hKS5Up2Y3+
         DJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=krG00EaGjjhi8P+u3jEC8kSkTgVWH7baP40/YPU7XSs=;
        b=e95PkwUpmZCvT377dz5h/luzCZFDz297495quSZlfhjaJxjxVV7NcxudijmuXCEA0C
         EepF/2QFIW0NUkZlLrF4EmxCkpLlj0+zSsjSIarf3CGMvAYmqAqHKhuuWKdWzIzAgMP5
         FZOszAiOk5cl5JWW5f7Sr14SxNmuGiO1WFZKLSVqFFjhdqiOq+W3nLFO3zXrVi4C2ixf
         klftBNwhmDtixsZQ3pA19p9MkD3/mZt6yFvIoPvwaRlOdETWHnPyPMfhdqhEErZwvQan
         /KhH24aJ8Kzmm2VKHXt3Igf8ecLbeuCQA84iv4Ob7gijPrzMpx8GUbXu+PdJP9ff3dNb
         druw==
X-Gm-Message-State: AOAM5336eDwLWTrrvg9/2vjMdMHR6TlVYjH+lka+ddsMWnhhk2FdIAv1
        EzfWaj3LWzVr43FDMmho2aDI4ufJ4ptun60laP4=
X-Google-Smtp-Source: ABdhPJy/o1dmDLi5TAqGRVRZVXyNiEy/7OVqSbY7UZe7kdPvU81mDkqeWTErrxmXbguDEiS2a/z8cdvQaNYYRODj4M8=
X-Received: by 2002:a05:6638:410a:: with SMTP id ay10mr174008jab.237.1642708759594;
 Thu, 20 Jan 2022 11:59:19 -0800 (PST)
MIME-Version: 1.0
References: <20220120010817.2803482-1-kuifeng@fb.com>
In-Reply-To: <20220120010817.2803482-1-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 20 Jan 2022 11:59:08 -0800
Message-ID: <CAEf4BzYtzB6=bphN+RXVrkb3yT4SWp6Xi48KjZhUVLYsQLjO=A@mail.gmail.com>
Subject: Re: [PATCH dwarves 0/2] Parallelize BTF type info generating of pahole
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

+cc bpf@vger.kernel.org

On Wed, Jan 19, 2022 at 5:08 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> Creating an instance of btf for each worker thread allows
> steal-function provided by pahole to add type info on multiple threads
> without a lock.  The main thread merges the results of worker threads
> to the primary instance.
>
> Copying data from per-thread btf instances to the primary instance is
> expensive now.  However, there is a patch landed at the bpf-next
> repository. [1] With the patch for bpf-next and this patch, they drop
> total runtime to 5.4s from 6.0s with "-j4" on my device to generate
> BTF for Linux.

Just a few more data points. I've tried this locally with 40 cores,
both with and without the libbpf's btf__add_btf() optimization.

BASELINE NON-PARALLEL
=====================
$ time ./pahole -J ~/linux-build/default/vmlinux
./pahole -J ~/linux-build/default/vmlinux  11.17s user 0.66s system
99% cpu 11.832 total

BASELINE PARALLEL
=================
$ time ./pahole -j40 -J ~/linux-build/default/vmlinux
./pahole -j40 -J ~/linux-build/default/vmlinux  13.85s user 0.75s
system 290% cpu 5.023 total

THESE PATCHES WITHOUT LIBBPF SPEED-UP
=====================================
$ time ./pahole -j40 -J ~/linux-build/default/vmlinux
./pahole -j40 -J ~/linux-build/default/vmlinux  25.94s user 1.15s
system 685% cpu 3.954 total

THESE PATCHES WITH LATEST LIBBPF SPEED-UP
=========================================
$ time ./pahole -j40 -J ~/linux-build/default/vmlinux
./pahole -j40 -J ~/linux-build/default/vmlinux  27.49s user 1.08s
system 858% cpu 3.328 total


So on 40 cores, it's a speed up from 11.8 seconds non-parallel, to 5s
parallel without Kui-Feng's changes, to 4s with Kui-Feng's changes, to
3.3s after libbpf update (I did it locally, will sync this to Github
today).

4x speed up, not bad!

But parallel mode is not currently enabled in kernel build, let's
enable parallel mode and save those seconds during the kernel build!

>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=d81283d27266
>
> Kui-Feng Lee (2):
>   dwarf_loader: Prepare and pass per-thread data to worker threads.
>   pahole: Use per-thread btf instances to avoid mutex locking.
>
>  btf_encoder.c  |   5 +++
>  btf_encoder.h  |   2 +
>  btf_loader.c   |   2 +-
>  ctf_loader.c   |   2 +-
>  dwarf_loader.c |  58 ++++++++++++++++++------
>  dwarves.h      |   9 +++-
>  pahole.c       | 120 ++++++++++++++++++++++++++++++++++++++++++++++---
>  pdwtags.c      |   3 +-
>  pfunct.c       |   4 +-
>  9 files changed, 180 insertions(+), 25 deletions(-)
>
> --
> 2.30.2
>

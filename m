Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61752CDEF6
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 20:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbgLCT13 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 14:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgLCT12 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 14:27:28 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1C8C061A4E
        for <bpf@vger.kernel.org>; Thu,  3 Dec 2020 11:26:48 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id 10so3067046ybx.9
        for <bpf@vger.kernel.org>; Thu, 03 Dec 2020 11:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jojN6pNGezjibG/id0Ga0nEmVE8COsCOFn1KmUsVWw0=;
        b=oQEUfwFBWOwr+W5zPybWaYcfDtleZhxf7BwLzo+KXAqrRBVn94AdMTuOrRKhftmWuF
         e9KoKmoIw0D9RgBzJnQMGcwjr/YMxR4Gj6C87vBnejpcYJHkLBb1VOSNsFLLKdQNbtVZ
         UVN4We95kR7MUyf0/vk6OT57WqsC4ayqGKuNUAVgHw86eGHWhWVlw0xqiMblmdXNHHV2
         lsGwqNZeJguNjP3fT8AFXRRLbFAF+zFnJtaEoo1nwFV/zmRs77BJVLYVvHaFgtFnonam
         cGiO4Dyszs40jUkL3SBwVyt4TcRGbUywnHw3cHs/9a0MKujGWRsSaVRx/W0laLBE58C+
         oGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jojN6pNGezjibG/id0Ga0nEmVE8COsCOFn1KmUsVWw0=;
        b=NlJ4tCuYuXtNhbQRd1zf1YDTZAY68FsG7uMbB885AAwoiz13kpJ/BVxbZFquvOldJm
         +6olWym01aRZUah2HUJQnz0mdcdwzI9FZt/hFjSmbnuCbghREr6Knn6uLBqLY+AcglDn
         xLuUXo7idws6EoXyWEnjS5uAJa2Ot3xYzKVlD3MzFbFx0ZSYTcnVqTtiUm8Z0+x0cKtZ
         SrgDgUqweMbjVi8lZniGEQu4OIdKLeUpSZsqW3R1EmG/u+b3wHaB/47/3q9jyra2VdCu
         1hpuEAhGfbIXI1Mha4XFl7VV86c8hPn9bA9GeJjhbh+x7iZxr9r97l10vsx1kN4jiGyc
         YAGw==
X-Gm-Message-State: AOAM531ggSkH/hgipibFxmRvX2ILJqrXZUPfiGwp04xMa+zIr5CRyQdJ
        pNMHcie2eSRbxb5NGCHykf49rflt0oaQxMNAbas=
X-Google-Smtp-Source: ABdhPJy6Xotr/8VATXy/kcrfIWcH1wCmeScQqRZ55u89+Xs/cE3y6ixjSDdOkhYYx1HMsnM1W7ipmj46A3bfH/6hTnE=
X-Received: by 2002:a25:c7c6:: with SMTP id w189mr841009ybe.403.1607023608165;
 Thu, 03 Dec 2020 11:26:48 -0800 (PST)
MIME-Version: 1.0
References: <20201203191437.666737-1-kpsingh@chromium.org>
In-Reply-To: <20201203191437.666737-1-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 3 Dec 2020 11:26:37 -0800
Message-ID: <CAEf4BzbAg5AG=J_9ZNz5BikpP0HvbSPH0oCbaQPgXzret5HiSw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/4] Fixes for ima selftest
To:     KP Singh <kpsingh@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 3, 2020 at 11:14 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> # v3 -> v4
>
> * Fix typos.
> * Update commit message for the indentation patch.
> * Added Andrii's acks.
>
> # v2 -> v3
>
> * Added missing tags.
> * Indentation fixes + some other fixes suggested by Andrii.
> * Re-indent file to tabs.
>
> The selftest for the bpf_ima_inode_hash helper uses a shell script to
> setup the system for ima. While this worked without an issue on recent
> desktop distros, it failed on environments with stripped out shells like
> busybox which is also used by the bpf CI.
>
> This series fixes the assumptions made on the availablity of certain
> command line switches and the expectation that securityfs being mounted
> by default.
>
> It also adds the missing kernel config dependencies in
> tools/testing/selftests/bpf and, lastly, changes the indentation of
> ima_setup.sh to use tabs.
>

Thanks, I think this reads much better. And a few months from now it
would be easier to understand and page back the context, if necessary.

I've pushed your fixes. ima selftest still emits a bunch of extra
output from dd and maybe other commands:

10+0 records in
10+0 records out
10485760 bytes (10.0MB) copied, 0.037096 seconds, 269.6MB/s
Filesystem label=
OS type: Linux
Block size=1024 (log=0)
Fragment size=1024 (log=0)
2560 inodes, 10240 blocks
512 blocks (5%) reserved for the super user
First data block=1
Maximum filesystem blocks=262144
2 block groups
8192 blocks per group, 8192 fragments per group
1280 inodes per group
Superblock backups stored on blocks:
        8193

Please follow up at your earliest convenience to silence those in
default (non-verbose) mode.

> KP Singh (4):
>   selftests/bpf: Update ima_setup.sh for busybox
>   selftests/bpf: Ensure securityfs mount before writing ima policy
>   selftests/bpf: Add config dependency on BLK_DEV_LOOP
>   selftests/bpf: Indent ima_setup.sh with tabs.
>
>  tools/testing/selftests/bpf/config       |   1 +
>  tools/testing/selftests/bpf/ima_setup.sh | 107 +++++++++++++----------
>  2 files changed, 64 insertions(+), 44 deletions(-)
>
> --
> 2.29.2.576.ga3fc446d84-goog
>

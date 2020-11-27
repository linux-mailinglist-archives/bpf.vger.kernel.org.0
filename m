Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD63E2C5F3B
	for <lists+bpf@lfdr.de>; Fri, 27 Nov 2020 05:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388818AbgK0E33 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Nov 2020 23:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgK0E33 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Nov 2020 23:29:29 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA702C0613D1;
        Thu, 26 Nov 2020 20:29:27 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id e81so3418408ybc.1;
        Thu, 26 Nov 2020 20:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P0sst/oLXauwchLbbWSFPIHcHhE+8Wlx7EhyzRwqTgg=;
        b=lfV8bHfyXaSW/tBhKP+qnSwXnl3RvdmvehplmMQvlmcGtWAnsjHAtGl4Ues+xHBZXW
         xi7OVyPms1h6srdW4Wgw3hvTmfAYWa2WQIXVZsGS+wsxzPhd+0GIdrrGBga+fqPJYu9l
         mKrWctYPC8IMCnG5+RPc9R/yvDxIKQkd1EwMCstjPutiN/D7nX+5/PU8Q1FzcjCS1VxO
         rPdRfgsZO/rcutFm8kEZooYTcII+wytrxbLiv23w1RZyPZdf85Q3G1xoS7vNGyOn0dp5
         cS9aKI13C1jFE/1eEr9pYPWRRqyk1nilEPsL8s04o4pxVd4CvGXcJniwaCWN/oQPv6LW
         3+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P0sst/oLXauwchLbbWSFPIHcHhE+8Wlx7EhyzRwqTgg=;
        b=ffilBKB96gJ9xF/k2pR5cNqkGp0vlQo+sVfE5AL2uLxoDRSDbW9KOqiigPR4xEw77H
         kwzcXp3haQRXZ/OOTuJaSJEv1KQIhSSPybhOiJrnSX64J4fh76XWF0GdJbG2znrzd7if
         av06bzMNstaLXPVgSfIPYD+zjwSaurqJv9WamYGZFcmPdATkasS4t1jxsGzN5NvMocsX
         FAktYCLAGyAZXUHj4TBc0ASk0c5PmOdjCvNtnbCbHGq/WBoQPtIV7qQWP4+alitl8aK3
         6bmJmxdvCi1s1aXp7sFAokh34cdRfZYOkGV6aLcaSj3kzDdS4ZC1cimvqZq+eWsHBi8Y
         UhhQ==
X-Gm-Message-State: AOAM5322uA2LV1qdDV9KwffKQU2Gdrp9QXk2xB12DLeZ2kwLetIARBS+
        azlk/VERhASYIoQ9yTAzX9yYOmTHjgPiLllr7IGnJz/ZGJoGWA==
X-Google-Smtp-Source: ABdhPJzedDa3IOIQ9/tQ0Wlf1NyhV/rfNPfXbEWXwZYUNY8KqalVvkHoWXgyyIvYBgTHrlHaXGrCltx5MdlHjWWCb8I=
X-Received: by 2002:a25:df82:: with SMTP id w124mr8237206ybg.347.1606451367066;
 Thu, 26 Nov 2020 20:29:27 -0800 (PST)
MIME-Version: 1.0
References: <20201124151210.1081188-1-kpsingh@chromium.org> <20201124151210.1081188-4-kpsingh@chromium.org>
In-Reply-To: <20201124151210.1081188-4-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 26 Nov 2020 20:29:16 -0800
Message-ID: <CAEf4BzbDKX8+AaueNngEeGnWQLfN0Fy+jgcxrwbeLeVfVh0E9Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/3] bpf: Add a selftest for bpf_ima_inode_hash
To:     KP Singh <kpsingh@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 24, 2020 at 7:16 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> The test does the following:
>
> - Mounts a loopback filesystem and appends the IMA policy to measure
>   executions only on this file-system. Restricting the IMA policy to a
>   particular filesystem prevents a system-wide IMA policy change.
> - Executes an executable copied to this loopback filesystem.
> - Calls the bpf_ima_inode_hash in the bprm_committed_creds hook and
>   checks if the call succeeded and checks if a hash was calculated.
>
> The test shells out to the added ima_setup.sh script as the setup is
> better handled in a shell script and is more complicated to do in the
> test program or even shelling out individual commands from C.
>
> The list of required configs (i.e. IMA, SECURITYFS,
> IMA_{WRITE,READ}_POLICY) for running this test are also updated.
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>  tools/testing/selftests/bpf/config            |  4 +
>  tools/testing/selftests/bpf/ima_setup.sh      | 80 +++++++++++++++++++
>  .../selftests/bpf/prog_tests/test_ima.c       | 74 +++++++++++++++++
>  tools/testing/selftests/bpf/progs/ima.c       | 28 +++++++
>  4 files changed, 186 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/ima_setup.sh
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_ima.c
>  create mode 100644 tools/testing/selftests/bpf/progs/ima.c
>

[...]

> +cleanup() {
> +        local tmp_dir="$1"
> +        local mount_img="${tmp_dir}/test.img"
> +        local mount_dir="${tmp_dir}/mnt"
> +
> +        local loop_devices=$(losetup -j ${mount_img} -O NAME --noheadings)

libbpf and kernel-patches CIs are using BusyBox environment which has
losetup that doesn't support -j option. Is there some way to work
around that? What we have is this:

BusyBox v1.31.1 () multi-call binary.

Usage: losetup [-rP] [-o OFS] {-f|LOOPDEV} FILE: associate loop devices

    losetup -c LOOPDEV: reread file size

    losetup -d LOOPDEV: disassociate

    losetup -a: show status

    losetup -f: show next free loop device

    -o OFS    Start OFS bytes into FILE

    -P    Scan for partitions

    -r    Read-only

    -f    Show/use next free loop device


> +        for loop_dev in "${loop_devices}"; do
> +                losetup -d $loop_dev
> +        done
> +
> +        umount ${mount_dir}
> +        rm -rf ${tmp_dir}
> +}
> +

[...]

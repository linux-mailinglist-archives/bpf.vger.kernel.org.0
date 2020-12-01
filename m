Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B12A2CAB97
	for <lists+bpf@lfdr.de>; Tue,  1 Dec 2020 20:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbgLATQ2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Dec 2020 14:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbgLATQ1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Dec 2020 14:16:27 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05EEC0613D6
        for <bpf@vger.kernel.org>; Tue,  1 Dec 2020 11:15:41 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id x17so2880204ybr.8
        for <bpf@vger.kernel.org>; Tue, 01 Dec 2020 11:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SMDoW5Pf2MRwwi/K/AfZwjGgYGEvBUttoz2oKq2qDY0=;
        b=trhaGEUMRHlmAFAK65jK64fyUzE4qOHWTLWeiZh2E2V1CGd19sazywAfYtlU0kVgGH
         qlXHROVyKzSOmB3fzz1uObHRZ5ri3dMLR0uwk8xFl124uc2Xq9N5BSkJXM+pzYYJtqCL
         d0OO7+VAZ0Bm1FHspEIqTBfQ8aGCZRmJkMQGTDIQV3QuwbDnJ5dtiJESbkNzCSOekV0J
         HTBd/g9H0znzP7p00d07PXKcpCIXhD2qfN8EhkOeqprO2Az7duHcmyC7CnYgCxb3KqAu
         cPNxYHa1w9yv8YLl3s19H14g+Hd7WBN/ExnYsFC3dq6TRf75GHZEdEXiRgcpj6xjNCSA
         1WWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SMDoW5Pf2MRwwi/K/AfZwjGgYGEvBUttoz2oKq2qDY0=;
        b=CO+a4N39ZMMkU3+0YD9haKqEsPm29w5gmCzuCvPgROvKHooAJRtYiI/C9k0V5COAGR
         zKEZ7CVlHgL/LRx9g5ARIMz6y7eId7gFoQpk6vabPBP/MDQ92qOGDRVpfpe0Po/7QdjV
         +l2xxm9iUyKfzftkdvHETezgRZvLhd7weRoHI/2/nNNNF0pFyuPp0zJy7MROYba2eIXn
         /NrASLCpZJAeAxdn4ks9vJ0n7GqZ8UlvLeDRaAtd0ofH4Cep+kZYoln1thDvK//iNdr6
         uJZKsXmoVw+iv0RMh1Cg+UQoHsShHfg8x4rPT90+7eQeNCTb9yx0dO2YX1BXGltbMaC8
         PHIg==
X-Gm-Message-State: AOAM533L0Kdn1tZ1QU+Z6QdJA2lypn5pfaH95XdQm2fc3BVBrcnWfL45
        uoYBUnmW5O8Y6rLKgoh2K1l0i1Wkm5EgjgeAb3o=
X-Google-Smtp-Source: ABdhPJz97CUjzEysWZOz61PjWblbTmjnmoNv2ru0yexoHHz4HDlBGe3TFYLNfKtJfMLUDaaY5QFcIUrcVX1JmxmSaEY=
X-Received: by 2002:a25:3d7:: with SMTP id 206mr5212920ybd.27.1606850141229;
 Tue, 01 Dec 2020 11:15:41 -0800 (PST)
MIME-Version: 1.0
References: <20201201143924.2908241-1-kpsingh@chromium.org>
In-Reply-To: <20201201143924.2908241-1-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 1 Dec 2020 11:15:30 -0800
Message-ID: <CAEf4BzZS9sfckQNqt1hsCV2QPWVGJZS=Xf83GYZO_Efz1oLOnw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: Update ima test helper's
 losetup commands
To:     KP Singh <kpsingh@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 1, 2020 at 6:39 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> Update the commands to use the bare minimum options so that it works
> in busybox environments.
>
> Fixes: 34b82d3ac105 ("bpf: Add a selftest for bpf_ima_inode_hash")
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>  tools/testing/selftests/bpf/ima_setup.sh | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/ima_setup.sh b/tools/testing/selftests/bpf/ima_setup.sh
> index 15490ccc5e55..ed29bde26a12 100755
> --- a/tools/testing/selftests/bpf/ima_setup.sh
> +++ b/tools/testing/selftests/bpf/ima_setup.sh
> @@ -3,6 +3,7 @@
>
>  set -e
>  set -u
> +set -o pipefail
>
>  IMA_POLICY_FILE="/sys/kernel/security/ima/policy"
>  TEST_BINARY="/bin/true"
> @@ -23,9 +24,10 @@ setup()
>
>          dd if=/dev/zero of="${mount_img}" bs=1M count=10

This, and few more commands in this script, produce a bunch of output
directly to stdout and stderr. Can you please silence it? If you need
that output for debugging, than you can check verbosity mode in
test_progs and pass extra parameters, if necessary.


>
> -        local loop_device="$(losetup --find --show ${mount_img})"
> +        losetup -f "${mount_img}"

This doesn't work :(

[root@(none) selftests]# ./ima_setup.sh setup /tmp/ima_measurednsymal
+ set -e
+ set -u
+ set -o pipefail
+ IMA_POLICY_FILE=/sys/kernel/security/ima/policy
+ TEST_BINARY=/bin/true
+ main setup /tmp/ima_measurednsymal
+ [[ 2 -ne 2 ]]
+ local action=setup
+ local tmp_dir=/tmp/ima_measurednsymal
+ [[ ! -d /tmp/ima_measurednsymal ]]
+ [[ setup == \s\e\t\u\p ]]
+ setup /tmp/ima_measurednsymal
+ local tmp_dir=/tmp/ima_measurednsymal
+ local mount_img=/tmp/ima_measurednsymal/test.img
+ local mount_dir=/tmp/ima_measurednsymal/mnt
++ basename /bin/true
+ local copied_bin_path=/tmp/ima_measurednsymal/mnt/true
+ mkdir -p /tmp/ima_measurednsymal/mnt
+ dd if=/dev/zero of=/tmp/ima_measurednsymal/test.img bs=1M count=10
10+0 records in
10+0 records out
10485760 bytes (10.0MB) copied, 0.044713 seconds, 223.6MB/s
+ losetup -f /tmp/ima_measurednsymal/test.img
losetup: /tmp/ima_measurednsymal/test.img: No such file or directory
[root@(none) selftests]# ls -la /tmp/ima_measurednsymal/test.img
-rw-r--r--    1 root     root      10485760 Dec  1 19:13
/tmp/ima_measurednsymal/test.img
[root@(none) selftests]# losetup -f /tmp/ima_measurednsymal/test.img
losetup: /tmp/ima_measurednsymal/test.img: No such file or directory


I have zero context on what IMA is and know nothing about loop
devices, so can't really investigate much, sorry...

> +        local loop_device=$(losetup -a | grep ${mount_img:?} | cut -d ":" -f1)
>
> -        mkfs.ext4 "${loop_device}"
> +        mkfs.ext4 "${loop_device:?}"
>          mount "${loop_device}" "${mount_dir}"
>
>          cp "${TEST_BINARY}" "${mount_dir}"
> @@ -38,7 +40,8 @@ cleanup() {
>          local mount_img="${tmp_dir}/test.img"
>          local mount_dir="${tmp_dir}/mnt"
>
> -        local loop_devices=$(losetup -j ${mount_img} -O NAME --noheadings)
> +        local loop_devices=$(losetup -a | grep ${mount_img:?} | cut -d ":" -f1)
> +
>          for loop_dev in "${loop_devices}"; do
>                  losetup -d $loop_dev
>          done
> --
> 2.29.2.454.gaff20da3a2-goog
>

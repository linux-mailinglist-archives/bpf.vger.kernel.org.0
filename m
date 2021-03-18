Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB13F3410F4
	for <lists+bpf@lfdr.de>; Fri, 19 Mar 2021 00:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhCRXXl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Mar 2021 19:23:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:33192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229681AbhCRXXJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Mar 2021 19:23:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1426364ED2
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 23:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616109789;
        bh=BsOo9FyjesicP0uLuqTXCXNGSxpfVFqtWrQPRADs64E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VswDPbfv+LcSVbefFd4rRNfXgrCbTv/sWoYwRQ9ackv+LomW2IUI4yRJ0LLNRYxJ8
         pEojPY/qZ3tRWABaWVtds3Fpftg+yvqcgxB2vEUeOHGpxs8SM/wOkXcdsFx55CoACm
         jODymT+RQj1kKmy4T8Z+KY1ObjVk5wOr1CmENjhfM6SVDzq7SZPeM5hdZJ8JuS/Cmc
         VjSWL7hOCN3iGIoO2oUvPLUeQWgOKboRrYHcqkvwjgjGK8sqYl10eqAjBrtXjmc/HJ
         54qRW6d8BJFtF95twyhCS5xIoUl6gJFNfIH32lGbEaiNGp7Z46dnMsu9TmtDwC8Dbn
         ys9nUDoLVlnKw==
Received: by mail-lf1-f51.google.com with SMTP id o10so7186984lfb.9
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 16:23:08 -0700 (PDT)
X-Gm-Message-State: AOAM5322S8UA/GA9Bqmsrkjvmjt3Nv2Ky/MflYbCva1mPeVvvvCARdiy
        CA+JK/kJB4IkcgJ9hFdd3aUc1zb5xIh6/tpuHIQThQ==
X-Google-Smtp-Source: ABdhPJyPnHj6ZDJQUS+vCGpIZfqBnV3Qw55eILEKnTGtx7FwsanNGGGsfKJZBgmKkaPscsNM/gboMw0xVOaUY8B6KCI=
X-Received: by 2002:a19:dc0b:: with SMTP id t11mr6808690lfg.233.1616109787394;
 Thu, 18 Mar 2021 16:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4BzZ2t_VbdtSde9uPEYNaggZLj3peyA8opHj1Ao_FO8AVrQ@mail.gmail.com>
 <CACYkzJ5eynv81uQ9_PA9uA=FUqva_j8MmpCgM1Pv=urVkXZsWA@mail.gmail.com>
In-Reply-To: <CACYkzJ5eynv81uQ9_PA9uA=FUqva_j8MmpCgM1Pv=urVkXZsWA@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Fri, 19 Mar 2021 00:22:56 +0100
X-Gmail-Original-Message-ID: <CACYkzJ75+ie6H5rsd467TgaznpNkEuEYa9+Ux9Wv9zUXF01KwQ@mail.gmail.com>
Message-ID: <CACYkzJ75+ie6H5rsd467TgaznpNkEuEYa9+Ux9Wv9zUXF01KwQ@mail.gmail.com>
Subject: Re: test_ima passing only first time
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 18, 2021 at 5:04 PM KP Singh <kpsingh@kernel.org> wrote:
>
> Sorry I totally missed this email. Taking a look now.

KP, You top posted in a hurry.

>
> On Wed, Mar 10, 2021 at 10:57 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > Hey KP,
> >
> > test_ima is passing only the very first time I run it in my VM. Alexei
> > earlier reported similar issues. If you run it second time without
> > restarting the VM, you get the following:
> >
> > 10+0 records in
> > 10+0 records out
> > 10485760 bytes (10 MB, 10 MiB) copied, 0.00425121 s, 2.5 GB/s
> > mke2fs 1.45.0 (6-Mar-2019)
> > Discarding device blocks: done
> > Creating filesystem with 10240 1k blocks and 2560 inodes
> > Filesystem UUID: b9927426-1d29-458f-b2a0-8fe56455d209
> > Superblock backups stored on blocks:
> >         8193
> >
> > Allocating group tables: done
> > Writing inode tables: done
> > Writing superblocks and filesystem accounting information: done
> >
> > ./ima_setup.sh: line 53: /sys/kernel/security/ima/policy: Permission denied
> > test_test_ima:PASS:skel_load 0 nsec
> > test_test_ima:PASS:ringbuf 0 nsec
> > test_test_ima:PASS:attach 0 nsec
> > test_test_ima:PASS:mkdtemp 0 nsec
> > test_test_ima:FAIL:71
> > #128 test_ima:FAIL
> >
> > Do you see it on your side? Do you have any idea what's wrong?

Works for me :) Well, works on the CI image and config I mean.

I did the following local change to get a bash prompt from vmtest.sh

I will send a patch that adds a flag so that one can get a shell to
debug instead of
powering the VM off.

diff --git a/tools/testing/selftests/bpf/vmtest.sh
b/tools/testing/selftests/bpf/vmtest.sh
index 22554894db99..710c73fe1b77 100755
--- a/tools/testing/selftests/bpf/vmtest.sh
+++ b/tools/testing/selftests/bpf/vmtest.sh
@@ -175,7 +175,8 @@ echo "130" > "/root/${EXIT_STATUS_FILE}"
        stdbuf -oL -eL ${command}
        echo "\$?" > "/root/${EXIT_STATUS_FILE}"
 } 2>&1 | tee "/root/${LOG_FILE}"
-poweroff -f
+# poweroff -f
+bash
 EOF

        sudo chmod a+x "${init_script}"

 ./vmtest.sh -- "./test_progs -t test_ima"

[...]

[root@(none) bpf]# ./test_progs -t test_ima
#128 test_ima:OK
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
[root@(none) bpf]# ./test_progs -t test_ima
[...]
#128 test_ima:OK
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
[root@(none) bpf]# ./test_progs -t test_ima
[...]
#128 test_ima:OK

Here's the kernel config that the BPF CI uses:

cat ~/.bpf_selftests/latest.config | grep IMA | grep -v "^#"
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
CONFIG_IMA_NG_TEMPLATE=y
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
CONFIG_IMA_DEFAULT_HASH="sha1"
CONFIG_IMA_WRITE_POLICY=y
CONFIG_IMA_READ_POLICY=y
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y

The important bit is having CONFIG_IMA_WRITE_POLICY and CONFIG_IMA_READ_POLICY
which allows reading and overriding the IMA policy.

> >
> > Also, see that super-descriptive `test_test_ima:FAIL:71` line? That's
> > the reason I'm always bitching about CHECK_FAIL() use. At least this

I will send a patch to add more descriptive error messages, in these
it will be something
like

"error while running command ..."

- KP

> > one is not inside some loop.
> >
> > -- Andrii

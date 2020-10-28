Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5936529D50B
	for <lists+bpf@lfdr.de>; Wed, 28 Oct 2020 22:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgJ1V41 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Oct 2020 17:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728579AbgJ1V4V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Oct 2020 17:56:21 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A078DC0613CF
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2020 14:56:21 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id f140so468953ybg.3
        for <bpf@vger.kernel.org>; Wed, 28 Oct 2020 14:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KIXncuFosDmNuagEHN2zwyu/wOeGXdyt4dzPpt73h8M=;
        b=Ubmf2eZynOalf+/hLUy20G/Gp/mrI4LO2j/Vz0L7eQZW7D93wVHok0UGN1lI3uKXIO
         qaFmL+txCoqAVQyxb7Bx7y9CapEeEvFr3qBcEigDc8WOhB7ixdQPS5pa3ywj20aCqPRI
         UTNmiOaanNA1SeEnGynhEIJ4W0RMO2mIOS4KQeObRSpLaxSTZYOkzjsenaOmHKoQbinF
         s2FRonyW3DGEj4c95BoDdugo1+yLYdEYNmVlhJA55FRtf8kRbm7kosh5MqbXooZ2KgZ1
         IJhUk3VoowQ4kYwH2/t0C5JnFCNStZLySawRBXpodXLcs0V4XlqyGp+D08m03//cWrIZ
         2hiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KIXncuFosDmNuagEHN2zwyu/wOeGXdyt4dzPpt73h8M=;
        b=t8emaSFiNnFzBqWB4YvsSe26oJ5RmHThdW0mdaa9heqxhX7IZufDDaAJ2qK/br6s3x
         /bH8Q1jMpXROQtw5HPoW843oi3m5tVCWpag7ShfqoLZzDKkgSyqf7/HHS9x9WOEXZMxD
         Ghx8XmL0y0p99a+pQXVOLGIMEhE8XXYjOiy7EyVibOsxgzDmqRO4CMLF40rfPlIy/LKX
         +HXXCVlqZ+R4YP2gTqX8mVHXbtfNMKM3wHGKlcS9ee/t+rrGsv9X2bM7sh74UDVR32v+
         1OgnrPnZcJIvNZVHNd/IJa/h7hUbL/bop9HNgq+Vj8bm2sLM+PaUFQ3zltrLI9fkJYnv
         Ep7A==
X-Gm-Message-State: AOAM5318PK2l4n0AJK2HHYDL7JXE3Y9Lud+KHQWmnqZHrDD1G0eZHJBX
        X+UfnMoS+6Irnc9HpE3wGAwcULI3C685XF/ioak=
X-Google-Smtp-Source: ABdhPJx1h4+tlQni0Welj4xcnVA9W/FIsAMhL3meM0zhwyxYT8vz+tu7OpDycbPD/9zTiv+INpoWcYMS/G+g0eNar3o=
X-Received: by 2002:a25:25c2:: with SMTP id l185mr1712029ybl.230.1603922180897;
 Wed, 28 Oct 2020 14:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <20201028203853.2412751-1-dan@kernelim.com>
In-Reply-To: <20201028203853.2412751-1-dan@kernelim.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 28 Oct 2020 14:56:09 -0700
Message-ID: <CAEf4BzZxabLCaNj0E5UEcnrEY25ujSLOzTbYRXneJy2HrY64JA@mail.gmail.com>
Subject: Re: [PATCH] btf: Expose kernel BTF only to tasks with CAP_PERFMON
To:     Dan Aloni <dan@kernelim.com>, bpf <bpf@vger.kernel.org>
Cc:     security@kernel.org, Liran Alon <liran@amazon.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

+ bpf@vger.kernel.org

On Wed, Oct 28, 2020 at 1:40 PM Dan Aloni <dan@kernelim.com> wrote:
>
> Commit 341dfcf8d78e ("btf: expose BTF info through sysfs") added a sysfs
> file that exposes to userspace kernel BTF information which allows
> userspace to deduce the structure layout of all kernel internal
> structures.
>
> This file is currently accessible to unprivileged users, without
> requiring any special capability. Given that knowledge on kernel
> structure layout is useful for dynamically building local privilege
> escalation exploit in userspace, access to this file should be
> restricted.

So is /proc/config.gz, which is also very helpful in understanding
what exactly is there in the kernel. So seems to be
/boot/vmlinux-$(uname -r), which has exactly the same BTF data and
more.

Guarding /sys/kernel/bpf/vmlinux behind CAP_PERFMON would break a lot
of users relying on BTF availability to build their BPF applications.
We shouldn't expect developers to build their applications under root.
But that's what this patch is trying to do.

>
> Fixes: 341dfcf8d78e ("btf: expose BTF info through sysfs")
> Co-developed-by: Liran Alon <liran@amazon.com>
> Signed-off-by: Liran Alon <liran@amazon.com>
> Signed-off-by: Dan Aloni <dan@kernelim.com>
> ---
>  kernel/bpf/sysfs_btf.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/bpf/sysfs_btf.c b/kernel/bpf/sysfs_btf.c
> index 11b3380887fa..c985d42dfa49 100644
> --- a/kernel/bpf/sysfs_btf.c
> +++ b/kernel/bpf/sysfs_btf.c
> @@ -7,6 +7,7 @@
>  #include <linux/kobject.h>
>  #include <linux/init.h>
>  #include <linux/sysfs.h>
> +#include <linux/capability.h>
>
>  /* See scripts/link-vmlinux.sh, gen_btf() func for details */
>  extern char __weak __start_BTF[];
> @@ -17,6 +18,9 @@ btf_vmlinux_read(struct file *file, struct kobject *kobj,
>                  struct bin_attribute *bin_attr,
>                  char *buf, loff_t off, size_t len)
>  {
> +       if (!perfmon_capable())
> +               return -EACCES;
> +
>         memcpy(buf, __start_BTF + off, len);
>         return len;
>  }
> --
> 2.26.2
>

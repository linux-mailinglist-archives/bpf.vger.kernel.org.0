Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3EB688A10
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 23:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjBBWzR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 17:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjBBWzQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 17:55:16 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8411F5D7
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 14:55:14 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id mf7so10480939ejc.6
        for <bpf@vger.kernel.org>; Thu, 02 Feb 2023 14:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uXS/k4/seFW9OwNLkTtHOozQYuvTd8tNlw7HE8AfhzQ=;
        b=nouBc0bsnnjpEzAhEzScOoN7UGVBg8djWjTSag+o9rmXJxrOK8NGeCh+TDff/hOQgi
         pbrlmpPOAfCyy4Yj0yWcM9UV1pgsmw6D5ENyXuH+MF12S6Ymi34TMt0IADiWcuwA8g6f
         NpdcZovtN4LA7elAPIcEr3tHhMoYVUC2wYW9clbxMcrFWbp+Si3fA4hE+PzbcT7UZCPI
         p4wVdsXZFddl0nuYzudRnGCrl+hWWy0GlAuqBzV3aX6C+BZ9RtgKwrGzzrqp0Fe8y4Hk
         UkvLibbjnuz6tIEt6vPcjatQzR/1kaqsYZcaGFLRabcQ6NtTKTuujv2ambS2mFJSoMig
         tuGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uXS/k4/seFW9OwNLkTtHOozQYuvTd8tNlw7HE8AfhzQ=;
        b=oQp98Y+AXahhiWmOMkJP3ts8khqcyyJtmHqG5E4CjG1r6Te7qqDizmILIk8zl7iL+k
         6KYSZxWWxJpY9ejBjKz9eCv7qBFWDNetAGIk0PPATBhm1h3q/pcEJETzKMYnPa8N37j+
         S1mDq/cMPzH0mJj/0LH9gnbO0tKsnRxYoe9M7Bw7xRErR1ugZC0cf44n6MgxgN3NSt6z
         PH5HNefcRTxhOd2EnZHNe1MyD6er7Ma58EthRev3mU4ocO5LW2w2n3nnRnlA94QtGXU1
         agGd++INmwZNAc5UKnCmL7MLwhaTQPn8/m+3X8Xx7jQ6o3yFb7jAYiMbw4Jb/3mnpgQY
         g5UQ==
X-Gm-Message-State: AO0yUKV9WsIrVNZn+Q8u8flJgF6qwHQRQvVQieQ7vUvYxkO7yk9Fss+K
        9Vx4LVd0UDH+TkaBawtz91VOsgDk+h79GUH+ozdxcuevAE4=
X-Google-Smtp-Source: AK7set/WAEVYRZRZyW09kBdZ1ulkfbHKkZBt8O3RMSO90/fkxTjbgX3/pWuPhfFUuHazVrC2m/IFOo3RZYn1jEWK7pU=
X-Received: by 2002:a17:906:2bdb:b0:878:6f08:39ec with SMTP id
 n27-20020a1709062bdb00b008786f0839ecmr2514472ejg.233.1675378513128; Thu, 02
 Feb 2023 14:55:13 -0800 (PST)
MIME-Version: 1.0
References: <CAAYibXgCncBUj8m03iGvOgq8dt2evNHFh0BO1-EnAjtkf+c5yg@mail.gmail.com>
In-Reply-To: <CAAYibXgCncBUj8m03iGvOgq8dt2evNHFh0BO1-EnAjtkf+c5yg@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 2 Feb 2023 14:55:01 -0800
Message-ID: <CAEf4BzbmZQwL8xkEt4ybgVH8yMzKCWv9RDqQL30RG449zotoBQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/1] libbpf: Correctly set the kernel code
 version in Debian kernel.
To:     "Hao Xiang ." <hao.xiang@bytedance.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yifei Ma <yifeima@bytedance.com>,
        "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
        Xiaoning Ding <xiaoning.ding@bytedance.com>
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

On Wed, Feb 1, 2023 at 10:33 PM Hao Xiang . <hao.xiang@bytedance.com> wrote:
>
> In a previous commit, Ubuntu kernel code version is correctly set
> by retrieving the information from /proc/version_signature.
>
> commit<5b3d72987701d51bf31823b39db49d10970f5c2d>
> (libbpf: Improve LINUX_VERSION_CODE detection)
>
> The /proc/version_signature file doesn't present in at least the
> older versions of Debian distributions (eg, Debian 9, 10). The Debian
> kernel has a similar issue where the release information from uname()
> syscall doesn't give the kernel code version that matches what the
> kernel actually expects. Below is an example content from Debian 10.
>
> release: 4.19.0-23-amd64
> version: #1 SMP Debian 4.19.269-1 (2022-12-20) x86_64
>
> Debian reports incorrect kernel version in utsname::release returned
> by uname() syscall, which in older kernels (Debian 9, 10) leads to
> kprobe BPF programs failing to load due to the version check mismatch.
>
> Fortunately, the correct kernel code version presents in the
> utsname::version returned by uname() syscall in Debian kernels. This
> change adds another get kernel version function to handle Debian in
> addition to the previously added get kernel version function to handle
> Ubuntu. Some minor refactoring work is also done to make the code more
> readable.
>
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> ---

Are you basing your patches on top of bpf-next/master? BPF CI claims
that your patch has merge conflicts ([0])

  [0] https://patchwork.kernel.org/project/netdevbpf/patch/CAAYibXgCncBUj8m03iGvOgq8dt2evNHFh0BO1-EnAjtkf+c5yg@mail.gmail.com/


> tools/lib/bpf/libbpf.c        | 37 --------------
> tools/lib/bpf/libbpf_probes.c | 93 +++++++++++++++++++++++++++++++++++
> 2 files changed, 93 insertions(+), 37 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index eed5cec6f510..4191a78b2815 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -34,7 +34,6 @@
> #include <linux/limits.h>
> #include <linux/perf_event.h>
> #include <linux/ring_buffer.h>
> -#include <linux/version.h>
> #include <sys/epoll.h>
> #include <sys/ioctl.h>
> #include <sys/mman.h>
> @@ -870,42 +869,6 @@ bpf_object__add_programs(struct bpf_object *obj,
> Elf_Data *sec_data,
>         return 0;
> }
>
> -__u32 get_kernel_version(void)
> -{
> -        /* On Ubuntu LINUX_VERSION_CODE doesn't correspond to info.release,
> -         * but Ubuntu provides /proc/version_signature file, as described at
> -         * https://ubuntu.com/kernel, with an example contents below, which we
> -         * can use to get a proper LINUX_VERSION_CODE.
> -         *
> -         *   Ubuntu 5.4.0-12.15-generic 5.4.8
> -         *
> -         * In the above, 5.4.8 is what kernel is actually expecting, while
> -         * uname() call will return 5.4.0 in info.release.
> -         */
> -        const char *ubuntu_kver_file = "/proc/version_signature";
> -        __u32 major, minor, patch;
> -        struct utsname info;
> -
> -        if (faccessat(AT_FDCWD, ubuntu_kver_file, R_OK, AT_EACCESS) == 0) {
> -                FILE *f;
> -
> -                f = fopen(ubuntu_kver_file, "r");
> -                if (f) {
> -                        if (fscanf(f, "%*s %*s %d.%d.%d\n", &major,
> &minor, &patch) == 3) {
> -                                fclose(f);
> -                                return KERNEL_VERSION(major, minor, patch);
> -                        }
> -                        fclose(f);
> -                }
> -                /* something went wrong, fall back to uname() approach */
> -        }
> -
> -        uname(&info);
> -        if (sscanf(info.release, "%u.%u.%u", &major, &minor, &patch) != 3)
> -                return 0;
> -        return KERNEL_VERSION(major, minor, patch);
> -}
> -
> static const struct btf_member *
> find_member_by_offset(const struct btf_type *t, __u32 bit_offset)
> {
> diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
> index b44fcbb4b42e..8d2a2bc5eec9 100644
> --- a/tools/lib/bpf/libbpf_probes.c
> +++ b/tools/lib/bpf/libbpf_probes.c
> @@ -12,11 +12,104 @@
> #include <linux/btf.h>
> #include <linux/filter.h>
> #include <linux/kernel.h>
> +#include <linux/version.h>
>
> #include "bpf.h"
> #include "libbpf.h"
> #include "libbpf_internal.h"
>
> +/* On Ubuntu LINUX_VERSION_CODE doesn't correspond to info.release,
> + * but Ubuntu provides /proc/version_signature file, as described at
> + * https://ubuntu.com/kernel, with an example contents below, which we
> + * can use to get a proper LINUX_VERSION_CODE.
> + *
> + *   Ubuntu 5.4.0-12.15-generic 5.4.8
> + *
> + * In the above, 5.4.8 is what kernel is actually expecting, while
> + * uname() call will return 5.4.0 in info.release.
> + */
> +static __u32 get_ubuntu_kernel_version(void)
> +{
> +        const char *ubuntu_kver_file = "/proc/version_signature";
> +        __u32 major, minor, patch;
> +
> +        if (faccessat(AT_FDCWD, ubuntu_kver_file, R_OK, AT_EACCESS) == 0) {

nit: invert condition and exit early

> +                FILE *f;
> +
> +                f = fopen(ubuntu_kver_file, "r");
> +                if (f) {

same, invert and return


> +                        if (fscanf(f, "%*s %*s %d.%d.%d\n", &major,
> &minor, &patch) == 3) {

let's also use %u just like you do in the new code

> +                                fclose(f);
> +                                return KERNEL_VERSION(major, minor, patch);
> +                        }
> +                        fclose(f);
> +                }
> +                /* something went wrong, fall back to uname() approach */
> +        }
> +
> +        return 0;
> +}
> +
> +/* On Debian LINUX_VERSION_CODE doesn't correspond to info.release.
> + * Instead, it is provided in info.version. An example content of
> + * Debian 10 looks like the below.
> + *
> + *   utsname::release   4.19.0-22-amd64
> + *   utsname::version   #1 SMP Debian 4.19.260-1 (2022-09-29)
> + *
> + * In the above, 4.19.260 is what kernel is actually expecting, while
> + * uname() call will return 4.19.0 in info.release.
> + */
> +static __u32 get_debian_kernel_version(struct utsname *info)
> +{
> +        __u32 major, minor, patch;
> +        char *version;
> +        char *p;
> +
> +        version = info->version;
> +
> +        p = strstr(version, "Debian ");
> +        if (!p) {
> +                /* This is not a Debian kernel. */
> +                return 0;
> +        }
> +
> +        if (sscanf(p, "Debian %u.%u.%u", &major, &minor, &patch) != 3)
> +                return 0;
> +
> +        return KERNEL_VERSION(major, minor, patch);
> +}
> +
> +static __u32 get_general_kernel_version(struct utsname *info)
> +{
> +        __u32 major, minor, patch;
> +
> +        if (sscanf(info->release, "%u.%u.%u", &major, &minor, &patch) != 3)
> +                return 0;
> +
> +        return KERNEL_VERSION(major, minor, patch);
> +}

just put this at the bottom of get_kernel_version, not worth having a
separate function for generic case, IMO

> +
> +__u32 get_kernel_version(void)
> +{
> +        __u32 version;
> +        struct utsname info;
> +
> +        /* Check if this is an Ubuntu kernel. */
> +        version = get_ubuntu_kernel_version();
> +        if (version != 0)
> +                return version;
> +
> +        uname(&info);
> +
> +        /* Check if this is a Debian kernel. */
> +        version = get_debian_kernel_version(&info);
> +        if (version != 0)
> +                return version;
> +
> +        return get_general_kernel_version(&info);
> +}
> +
> static int probe_prog_load(enum bpf_prog_type prog_type,
>                            const struct bpf_insn *insns, size_t insns_cnt,
>                            char *log_buf, size_t log_buf_sz)
> --
> 2.30.2

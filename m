Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F8E68A280
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 20:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjBCTGD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Feb 2023 14:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjBCTGC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Feb 2023 14:06:02 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7EE677BD
        for <bpf@vger.kernel.org>; Fri,  3 Feb 2023 11:05:33 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id b5so6223776plz.5
        for <bpf@vger.kernel.org>; Fri, 03 Feb 2023 11:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RamiRxsXhiFuR30fEVbVLv/G9qWg+VoAl9d5xtm9EMw=;
        b=5fLOQt+qOwB6ULae8DYCUVf1Edol0ScjsmHKJNxsP2+866tYZdL/B62WY0CGfHlv4u
         RhFurh5I5YD8DP1tHXrYJIQRPir/oDvq89ofm3qj1CtkCC+xmvcy1WcgUN/soxIIgNEL
         AFpbS16pw3z62hVAYB8eR/H7evEmnbU+QQq4wA5He8O+Xc1AhQZNJYHDmky1PR9NiZOk
         g41p52FhvVQUOdO3YzpUrxYEgRI+fsHGXVEpUC7TJUN8zwIy1FBiSUAupIv8JE7108Pm
         wGfZ1soBDhWK5J39rh6IFvGFZiglUwEKu3ZetRNXjcNxbcWXLcYMZgCPzt4UxWMwRSLQ
         VS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RamiRxsXhiFuR30fEVbVLv/G9qWg+VoAl9d5xtm9EMw=;
        b=KuQ2hFMyzgyPQ4OSFqg/YGvWf+8fCqiIAa3Z6C/tClH3LetBs6iNOh9AC7TofuOZR3
         tiuwN8Ne54JAAWmQG4YQKkQJBhFxxz84V8V8qB4aKsOyr/1T0AjLC1shBJ4Lyl+O8Flo
         GR1k0KzZzH3LO44v/ckjCpr0N3nFmmKlAV0cVmp/VBc85MV5c0QuD3N45+GwFwGBF0+9
         XEAQHsBhN5Nl1Zrq55mbKOX/4FFh7+gr3QuZKYRSMOcrO1/msyGUmNRYpwVJQQIs4TFa
         x+LtOlTC9dwA3UGdJVd6r9cG+cJenOn4RmZM73u8cGp+7Ofwsemnz3UQOhYssFASeAvS
         eIAg==
X-Gm-Message-State: AO0yUKXbRzNz+H4qd0eun8QttvbW8p+vJnuULOMxVOPDEWbzXNFcJsQx
        aEQybhKZnoiG9i/BmljLm6JyVzd1EktDucKfJdBBjgLgsYuxd5fE
X-Google-Smtp-Source: AK7set+nPmH0M9Clj+hzhn0xvB9hmP7lt0Hi+Uesku6bSE1GUnUC96w2wE6hWuUmr/YUb+WuKqZFxOqKt0gGae+oqkM=
X-Received: by 2002:a17:902:c40b:b0:194:8e9a:a523 with SMTP id
 k11-20020a170902c40b00b001948e9aa523mr2565022plk.22.1675451132367; Fri, 03
 Feb 2023 11:05:32 -0800 (PST)
MIME-Version: 1.0
References: <CAAYibXgCncBUj8m03iGvOgq8dt2evNHFh0BO1-EnAjtkf+c5yg@mail.gmail.com>
 <CAEf4BzbmZQwL8xkEt4ybgVH8yMzKCWv9RDqQL30RG449zotoBQ@mail.gmail.com>
In-Reply-To: <CAEf4BzbmZQwL8xkEt4ybgVH8yMzKCWv9RDqQL30RG449zotoBQ@mail.gmail.com>
From:   "Hao Xiang ." <hao.xiang@bytedance.com>
Date:   Fri, 3 Feb 2023 11:05:21 -0800
Message-ID: <CAAYibXhYf9xsFdRjX8i-FM37LRp=x=259haJqKMma+gFz1axug@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next v2 1/1] libbpf: Correctly set the
 kernel code version in Debian kernel.
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yifei Ma <yifeima@bytedance.com>,
        "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
        Xiaoning Ding <xiaoning.ding@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 2, 2023 at 2:55 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Feb 1, 2023 at 10:33 PM Hao Xiang . <hao.xiang@bytedance.com> wrote:
> >
> > In a previous commit, Ubuntu kernel code version is correctly set
> > by retrieving the information from /proc/version_signature.
> >
> > commit<5b3d72987701d51bf31823b39db49d10970f5c2d>
> > (libbpf: Improve LINUX_VERSION_CODE detection)
> >
> > The /proc/version_signature file doesn't present in at least the
> > older versions of Debian distributions (eg, Debian 9, 10). The Debian
> > kernel has a similar issue where the release information from uname()
> > syscall doesn't give the kernel code version that matches what the
> > kernel actually expects. Below is an example content from Debian 10.
> >
> > release: 4.19.0-23-amd64
> > version: #1 SMP Debian 4.19.269-1 (2022-12-20) x86_64
> >
> > Debian reports incorrect kernel version in utsname::release returned
> > by uname() syscall, which in older kernels (Debian 9, 10) leads to
> > kprobe BPF programs failing to load due to the version check mismatch.
> >
> > Fortunately, the correct kernel code version presents in the
> > utsname::version returned by uname() syscall in Debian kernels. This
> > change adds another get kernel version function to handle Debian in
> > addition to the previously added get kernel version function to handle
> > Ubuntu. Some minor refactoring work is also done to make the code more
> > readable.
> >
> > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> > ---
>
> Are you basing your patches on top of bpf-next/master? BPF CI claims
> that your patch has merge conflicts ([0])
>
>   [0] https://patchwork.kernel.org/project/netdevbpf/patch/CAAYibXgCncBUj8m03iGvOgq8dt2evNHFh0BO1-EnAjtkf+c5yg@mail.gmail.com/

Yes, it is based on bpf-next/master. This is my first patch here and I
am still trying
to figure out a few logistics getting the patch correct. I figured out
that my patch has
some formatting issue that's not obvious and causing the patch apply
to fail. I was
"handcrafting" the patch email previously until I found out that this
could all be done by
tools. Please checkout the latest version of the patch. It applied successfully.

https://patchwork.kernel.org/project/netdevbpf/patch/20230203080210.2459384-1-hao.xiang@bytedance.com/

>
>
> > tools/lib/bpf/libbpf.c        | 37 --------------
> > tools/lib/bpf/libbpf_probes.c | 93 +++++++++++++++++++++++++++++++++++
> > 2 files changed, 93 insertions(+), 37 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index eed5cec6f510..4191a78b2815 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -34,7 +34,6 @@
> > #include <linux/limits.h>
> > #include <linux/perf_event.h>
> > #include <linux/ring_buffer.h>
> > -#include <linux/version.h>
> > #include <sys/epoll.h>
> > #include <sys/ioctl.h>
> > #include <sys/mman.h>
> > @@ -870,42 +869,6 @@ bpf_object__add_programs(struct bpf_object *obj,
> > Elf_Data *sec_data,
> >         return 0;
> > }
> >
> > -__u32 get_kernel_version(void)
> > -{
> > -        /* On Ubuntu LINUX_VERSION_CODE doesn't correspond to info.release,
> > -         * but Ubuntu provides /proc/version_signature file, as described at
> > -         * https://ubuntu.com/kernel, with an example contents below, which we
> > -         * can use to get a proper LINUX_VERSION_CODE.
> > -         *
> > -         *   Ubuntu 5.4.0-12.15-generic 5.4.8
> > -         *
> > -         * In the above, 5.4.8 is what kernel is actually expecting, while
> > -         * uname() call will return 5.4.0 in info.release.
> > -         */
> > -        const char *ubuntu_kver_file = "/proc/version_signature";
> > -        __u32 major, minor, patch;
> > -        struct utsname info;
> > -
> > -        if (faccessat(AT_FDCWD, ubuntu_kver_file, R_OK, AT_EACCESS) == 0) {
> > -                FILE *f;
> > -
> > -                f = fopen(ubuntu_kver_file, "r");
> > -                if (f) {
> > -                        if (fscanf(f, "%*s %*s %d.%d.%d\n", &major,
> > &minor, &patch) == 3) {
> > -                                fclose(f);
> > -                                return KERNEL_VERSION(major, minor, patch);
> > -                        }
> > -                        fclose(f);
> > -                }
> > -                /* something went wrong, fall back to uname() approach */
> > -        }
> > -
> > -        uname(&info);
> > -        if (sscanf(info.release, "%u.%u.%u", &major, &minor, &patch) != 3)
> > -                return 0;
> > -        return KERNEL_VERSION(major, minor, patch);
> > -}
> > -
> > static const struct btf_member *
> > find_member_by_offset(const struct btf_type *t, __u32 bit_offset)
> > {
> > diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
> > index b44fcbb4b42e..8d2a2bc5eec9 100644
> > --- a/tools/lib/bpf/libbpf_probes.c
> > +++ b/tools/lib/bpf/libbpf_probes.c
> > @@ -12,11 +12,104 @@
> > #include <linux/btf.h>
> > #include <linux/filter.h>
> > #include <linux/kernel.h>
> > +#include <linux/version.h>
> >
> > #include "bpf.h"
> > #include "libbpf.h"
> > #include "libbpf_internal.h"
> >
> > +/* On Ubuntu LINUX_VERSION_CODE doesn't correspond to info.release,
> > + * but Ubuntu provides /proc/version_signature file, as described at
> > + * https://ubuntu.com/kernel, with an example contents below, which we
> > + * can use to get a proper LINUX_VERSION_CODE.
> > + *
> > + *   Ubuntu 5.4.0-12.15-generic 5.4.8
> > + *
> > + * In the above, 5.4.8 is what kernel is actually expecting, while
> > + * uname() call will return 5.4.0 in info.release.
> > + */
> > +static __u32 get_ubuntu_kernel_version(void)
> > +{
> > +        const char *ubuntu_kver_file = "/proc/version_signature";
> > +        __u32 major, minor, patch;
> > +
> > +        if (faccessat(AT_FDCWD, ubuntu_kver_file, R_OK, AT_EACCESS) == 0) {
>
> nit: invert condition and exit early
>
> > +                FILE *f;
> > +
> > +                f = fopen(ubuntu_kver_file, "r");
> > +                if (f) {
>
> same, invert and return
>
>
> > +                        if (fscanf(f, "%*s %*s %d.%d.%d\n", &major,
> > &minor, &patch) == 3) {
>
> let's also use %u just like you do in the new code
>
> > +                                fclose(f);
> > +                                return KERNEL_VERSION(major, minor, patch);
> > +                        }
> > +                        fclose(f);
> > +                }
> > +                /* something went wrong, fall back to uname() approach */
> > +        }
> > +
> > +        return 0;
> > +}
> > +
> > +/* On Debian LINUX_VERSION_CODE doesn't correspond to info.release.
> > + * Instead, it is provided in info.version. An example content of
> > + * Debian 10 looks like the below.
> > + *
> > + *   utsname::release   4.19.0-22-amd64
> > + *   utsname::version   #1 SMP Debian 4.19.260-1 (2022-09-29)
> > + *
> > + * In the above, 4.19.260 is what kernel is actually expecting, while
> > + * uname() call will return 4.19.0 in info.release.
> > + */
> > +static __u32 get_debian_kernel_version(struct utsname *info)
> > +{
> > +        __u32 major, minor, patch;
> > +        char *version;
> > +        char *p;
> > +
> > +        version = info->version;
> > +
> > +        p = strstr(version, "Debian ");
> > +        if (!p) {
> > +                /* This is not a Debian kernel. */
> > +                return 0;
> > +        }
> > +
> > +        if (sscanf(p, "Debian %u.%u.%u", &major, &minor, &patch) != 3)
> > +                return 0;
> > +
> > +        return KERNEL_VERSION(major, minor, patch);
> > +}
> > +
> > +static __u32 get_general_kernel_version(struct utsname *info)
> > +{
> > +        __u32 major, minor, patch;
> > +
> > +        if (sscanf(info->release, "%u.%u.%u", &major, &minor, &patch) != 3)
> > +                return 0;
> > +
> > +        return KERNEL_VERSION(major, minor, patch);
> > +}
>
> just put this at the bottom of get_kernel_version, not worth having a
> separate function for generic case, IMO
>
> > +
> > +__u32 get_kernel_version(void)
> > +{
> > +        __u32 version;
> > +        struct utsname info;
> > +
> > +        /* Check if this is an Ubuntu kernel. */
> > +        version = get_ubuntu_kernel_version();
> > +        if (version != 0)
> > +                return version;
> > +
> > +        uname(&info);
> > +
> > +        /* Check if this is a Debian kernel. */
> > +        version = get_debian_kernel_version(&info);
> > +        if (version != 0)
> > +                return version;
> > +
> > +        return get_general_kernel_version(&info);
> > +}
> > +
> > static int probe_prog_load(enum bpf_prog_type prog_type,
> >                            const struct bpf_insn *insns, size_t insns_cnt,
> >                            char *log_buf, size_t log_buf_sz)
> > --
> > 2.30.2

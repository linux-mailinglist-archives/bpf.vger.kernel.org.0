Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FCB687326
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 02:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjBBBnl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 20:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBBBnk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 20:43:40 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5449B6FD3C
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 17:43:39 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id d26so221962eds.12
        for <bpf@vger.kernel.org>; Wed, 01 Feb 2023 17:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oK3JYgQm0N3IZTc8RrVtHb+GSDuynIT7ckQW/inKONI=;
        b=g+CBhltXCQcRrMQiOnT+i4N/CbMWBoEO/y3msPkw6vn76ZgDEoSbQhi74q2MfsVVe4
         5DVQZLDU0vY0ozarUnUYioaZ/ugT+O5pbYtzICu+/M4XwV2Y9cMWCU+l7jRFu8Kliv4b
         Y3Q3LDZa56cfOIVrDZYoTZJIrtjU7eaIS1ONOc/VjId9RlBknh6DyIc+Rrzbs3Pu+DBj
         1n22vHmAXz3j8WbuozE4RH5r3dfLPB6BgsHnTxhK8HoFl77VM59CYmmq7uUUxu5YLF0/
         HyfUst8CLA0qdmt8efiXhy3HdYhRBblWXqUiEXiaP967cNHGgk9ld4AwSKNtX/jf0FoU
         ZqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oK3JYgQm0N3IZTc8RrVtHb+GSDuynIT7ckQW/inKONI=;
        b=VTWkymXquAHcMlROqqwnDBEbI4ZgSnF6dWilgu+fYtXqfspMqyZpe6V6x4t7H6mxXR
         SYP0H8bBY3uiAZABgE9b1nsdVp4Z8/QAyF0EiH6HQgglzkgHSFrp5NVQIcjB4AQj9dFn
         J/ixJMCyhHqK5aOcdF5/1sX5evKADGZUu7uq2TxKORI+WqZbPiwru3MIZttIu6L8/j2K
         6A9Yhp2qi0JMXUZzieN3DfVhYfiXa7tBCwxu3VFQ4XI6uD8krwKizzxo2KwbitATakkn
         Cz6yJj5vl7w003VezdagtUlfPYn+rC0/LpsRgj0IH8EJVtrcpTFqWLJ2eBdniJEHGieU
         oeUQ==
X-Gm-Message-State: AO0yUKVATLGZ9nPKCPOXb402rZe6Ke6OYrEhImrscXhuBoMl/5ayuSRh
        vKlOA0nJQZhUZKROInqnwrbiWrSsTIda9kw97UI=
X-Google-Smtp-Source: AK7set9KgELVun+M+Bb7cRN4jJ13v0jXli2S3x7TEGpifnhsBlVk+dv+FfAr77FepGB/syn6RN99jE+VU+wNZlhAozM=
X-Received: by 2002:a05:6402:362:b0:499:f0f:f788 with SMTP id
 s2-20020a056402036200b004990f0ff788mr1308497edw.25.1675302217669; Wed, 01 Feb
 2023 17:43:37 -0800 (PST)
MIME-Version: 1.0
References: <CAAYibXg7VYj1maf4_h0ssXUwTLxFJpptekkQ_x7J7GjLtNHphA@mail.gmail.com>
In-Reply-To: <CAAYibXg7VYj1maf4_h0ssXUwTLxFJpptekkQ_x7J7GjLtNHphA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 1 Feb 2023 17:43:25 -0800
Message-ID: <CAEf4Bzb_HfDiP7Jz=4-cwNnVP9HSpbvAygQ2gj+2G1f_fw1hLA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/1] libbpf: Correctly set the kernel code
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

On Wed, Feb 1, 2023 at 4:09 PM Hao Xiang . <hao.xiang@bytedance.com> wrote:
>
> In a previous commit, Ubuntu kernel code version is correctly set by
> retrieving the information from /proc/version_signature.
>
>    commit<5b3d72987701d51bf31823b39db49d10970f5c2d>
>    (libbpf: Improve LINUX_VERSION_CODE detection)
>
> However, the /proc/version_signature file doesn't exist in at least the
> older versions of Debian distributions (eg, Debian 9, 10). The Debian
> kernel has a similar issue where the release information from uname()
> syscall doesn't give the kernel code version that matches what the kernel
> actually expects. Below is an example content from Debian 10.
>
>    release: 4.19.0-23-amd64
>    version: #1 SMP Debian 4.19.269-1 (2022-12-20) x86_64
>
> Debian reports incorrect kernel version in utsname::release returned
> by uname() syscall, which in older kernels (Debian 9, 10) leads to
> kprobe BPF programs failing to load due to the version check mismatch.
>
> Fortunately, the correct kernel code version presents in the
> utsname::version returned by uname() syscall in Debian kernels.
> This change adds another get kernel version function to handle
> Debian in addition to the previously added get kernel version function
> to handle Ubuntu. Some minor refactoring work is also done to make
> the code more readable.
>
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> ---
> tools/lib/bpf/libbpf.c | 92 +++++++++++++++++++++++++++++++++++-------

libbpf.c is already huge, let's move all this
get_kernel_version()-related code to libbpf_probes.c where it is also
used?

> 1 file changed, 78 insertions(+), 14 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index eed5cec6f510..bc022d0cd71f 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -870,21 +870,20 @@ bpf_object__add_programs(struct bpf_object *obj,
> Elf_Data *sec_data,
>         return 0;
> }
>

[...]

> +
> +#define VERSION_PREFIX_DEBIAN "Debian "

Not sure #define really helps here, just use "Debian " directly, as
this is a very localized use of this constant

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
> +        size_t len;
> +        char *version;
> +        char *find;
> +
> +        version = info->version;
> +
> +        find = strstr(version, VERSION_PREFIX_DEBIAN);
> +        if (!find) {

nit: find reads confusingly, "found" would be more meaningful, but we
often use short "p" (for position), please use that instead

> +              /* This is not a Debian kernel. */
>                 return 0;
> +        }
> +
> +        len = strlen(version);
> +        find += strlen(VERSION_PREFIX_DEBIAN);
> +        if (find - version >= len)
> +                return 0;

instead of these strlen() manipulations, can we do just

char *p = strstr(info->version, "Debian ");
if (!p)
    return 0;

if (sscanf(p, "Debian %u.%u.%u", ...

?

> +
> +        if (sscanf(find, "%u.%u.%u", &major, &minor, &patch) != 3)
> +                return 0;
> +
> +        return KERNEL_VERSION(major, minor, patch);
> +}
> +

[...]

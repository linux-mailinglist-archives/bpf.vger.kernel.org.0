Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9530E5E84AA
	for <lists+bpf@lfdr.de>; Fri, 23 Sep 2022 23:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbiIWVKx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Sep 2022 17:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbiIWVKw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 17:10:52 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA1A8E9AD
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 14:10:49 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id l14so3130113eja.7
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 14:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=gKBEmpE2rTZ/PVA0zvXhqjvW49702MtCA3dtiQdrkgE=;
        b=AG257Xa+h0ECXX8mNJx20MdsfTNE//+V4hdY8UQubXZgzCqPdPS6vKAplq+KjUSRhW
         vG/fnb2qV8ACKqvTocWLQeBjGxGSx1G/PcHLYY3mZ5Ke4A6qxjK9MZdhcS0DBuUK2b2t
         hlCH7OFAPFx9MCbgtRk16PAOYXwtEZQLAPjmNJ7UgxMe8t8Og5QPDJkS2qBc8EC6J1Q6
         mL3bOrVWSjBbtf+oryxdXavFAYFYL0KKJldCO4oM7isg6fnzoc/BjadX2Ka6grsKbhrl
         Bt2kIRVFsi9+eGY0xY39yHLzW0af19Twt7YCFLVN1B5ZaKM9FC8/FoZQzZEFAUnYBNbR
         13Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=gKBEmpE2rTZ/PVA0zvXhqjvW49702MtCA3dtiQdrkgE=;
        b=K7QZ0fmQyVgj7kBU/qJLx0sJPYpjXy9Pm8fRofzMFNNmtAi5csT+mENCC2yRaiRkMR
         KuNBgGkBT2wEYZFzSFiZh9brvzITgGZLefwMhRlxB5Ti51FoSsPntih9vtq6Sr6TdMQh
         jOpBc/zaVsKdAtepuVG3pniwADlQKi1dTufH4qy/UuDjAogEJtcp5lEWtPunBfbGdP6F
         /3bZCS8pxo1FihWs5ZaU4uGRvdcv9ESsxkO+MPKs5NM41yoHkyu+RGmsIgUVovgm2XWQ
         YrqlCcRBhdwfZ1SS7r5+zH//4+OFZ1YJXLiFocbgU67mx7i7fx2gIEfrbHuxtIgYLNIo
         5/eQ==
X-Gm-Message-State: ACrzQf3rAX0WOqhsWbVr2VkJoNmSuO8dpQuXXxBPokSWOoOPB6gH/h5T
        ge9NAuv4IRxP4T+o9YGMwngw93cdrPKQeLm//78=
X-Google-Smtp-Source: AMsMyM5Bmy0z7OZsg4lAfq6fQTZtqeOmKJ6WDQJAjRK17NmGkWolXIW/RdUmy/TQ4nxUtnqCBPBPXjhm41rQLeAT7B0=
X-Received: by 2002:a17:907:96a3:b0:780:633:2304 with SMTP id
 hd35-20020a17090796a300b0078006332304mr8928674ejc.115.1663967447461; Fri, 23
 Sep 2022 14:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220921084014.3744312-1-arilou@gmail.com>
In-Reply-To: <20220921084014.3744312-1-arilou@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 23 Sep 2022 14:10:35 -0700
Message-ID: <CAEf4Bza-0H+fWw3XS1wVtAToi2NRyKY28-MSxYG9Bot1LX8Efg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] libbpf: Fix the case of running as non-root
 with capabilities
To:     Jon Doron <arilou@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        Jon Doron <jond@wiz.io>
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

On Wed, Sep 21, 2022 at 1:40 AM Jon Doron <arilou@gmail.com> wrote:
>
> From: Jon Doron <jond@wiz.io>
>
> When running rootless with special capabilities like:
> FOWNER / DAC_OVERRIDE / DAC_READ_SEARCH
>
> The "access" API will not make the proper check if there is really
> access to a file or not.
>
> From the access man page:
> "
> The check is done using the calling process's real UID and GID, rather
> than the effective IDs as is done when actually attempting an operation
> (e.g., open(2)) on the file.  Similarly, for the root user, the check
> uses the set of permitted capabilities  rather than the set of effective
> capabilities; ***and for non-root users, the check uses an empty set of
> capabilities.***
> "
>
> What that means is that for non-root user the access API will not do the
> proper validation if the process really has permission to a file or not.
>
> To resolve this this patch replaces all the access API calls with stat.
>
> Signed-off-by: Jon Doron <jond@wiz.io>
> ---
>  tools/lib/bpf/btf.c    |  3 ++-
>  tools/lib/bpf/libbpf.c | 11 ++++++++---
>  tools/lib/bpf/usdt.c   |  4 +++-
>  3 files changed, 13 insertions(+), 5 deletions(-)
>

This patch doesn't apply cleanly onto bpf-next, please rebase. But
also see comments below.

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 2d14f1a52d7a..33ad4792d9e8 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -4663,13 +4663,14 @@ struct btf *btf__load_vmlinux_btf(void)
>         struct utsname buf;
>         struct btf *btf;
>         int i, err;
> +       struct stat sb;
>
>         uname(&buf);
>
>         for (i = 0; i < ARRAY_SIZE(locations); i++) {
>                 snprintf(path, PATH_MAX, locations[i].path_fmt, buf.release);
>
> -               if (access(path, R_OK))
> +               if (stat(path, &sb))
>                         continue;
>
>                 if (locations[i].raw_btf)
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 50d41815f431..c7fbce4225b5 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -875,8 +875,9 @@ __u32 get_kernel_version(void)
>         const char *ubuntu_kver_file = "/proc/version_signature";
>         __u32 major, minor, patch;
>         struct utsname info;
> +       struct stat sb;
>
> -       if (access(ubuntu_kver_file, R_OK) == 0) {
> +       if (stat(ubuntu_kver_file, &sb) == 0) {
>                 FILE *f;
>
>                 f = fopen(ubuntu_kver_file, "r");
> @@ -9877,9 +9878,10 @@ static int append_to_file(const char *file, const char *fmt, ...)
>  static bool use_debugfs(void)
>  {
>         static int has_debugfs = -1;
> +       struct stat sb;
>
>         if (has_debugfs < 0)
> -               has_debugfs = access(DEBUGFS, F_OK) == 0;
> +               has_debugfs = stat(DEBUGFS, &sb) == 0;
>
>         return has_debugfs == 1;
>  }
> @@ -10681,6 +10683,7 @@ static int resolve_full_path(const char *file, char *result, size_t result_sz)
>                 for (s = search_paths[i]; s != NULL; s = strchr(s, ':')) {
>                         char *next_path;
>                         int seg_len;
> +                       struct stat sb;
>
>                         if (s[0] == ':')
>                                 s++;
> @@ -10690,7 +10693,9 @@ static int resolve_full_path(const char *file, char *result, size_t result_sz)
>                                 continue;
>                         snprintf(result, result_sz, "%.*s/%s", seg_len, s, file);
>                         /* ensure it is an executable file/link */
> -                       if (access(result, R_OK | X_OK) < 0)
> +                       if (stat(result, &sb) < 0)
> +                               continue;
> +                       if ((sb.st_mode & (S_IROTH | S_IXOTH)) != (S_IROTH | S_IXOTH))

So this bit look a bit suspicious. Why are we only checking others
bits? And in general, it seems pretty unfortunate to check access bits
manually.

So two thoughts.

1. Have you tried using faccessat2() with AT_EACCESS flag? It seems
like that (apart from all the stuff in BUGS section in man page,
sigh...) delegate the actual permission checks using effective user to
kernel. This seems like a bit better and safer way?

2. Whichever way we go, I think let's add an internal wrapper that
will hide struct stat (which we almost never use) and will simulate
access just with proper checks? Like libbpf_faccess() or something
along those lines? You can expose it in libbpf_internal.h

>                                 continue;
>                         pr_debug("resolved '%s' to '%s'\n", file, result);
>                         return 0;
> diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> index d18e37982344..19a6fbcfe9c0 100644
> --- a/tools/lib/bpf/usdt.c
> +++ b/tools/lib/bpf/usdt.c
> @@ -7,6 +7,7 @@
>  #include <libelf.h>
>  #include <gelf.h>
>  #include <unistd.h>
> +#include <sys/stat.h>
>  #include <linux/ptrace.h>
>  #include <linux/kernel.h>
>
> @@ -257,6 +258,7 @@ struct usdt_manager *usdt_manager_new(struct bpf_object *obj)
>         static const char *ref_ctr_sysfs_path = "/sys/bus/event_source/devices/uprobe/format/ref_ctr_offset";
>         struct usdt_manager *man;
>         struct bpf_map *specs_map, *ip_to_spec_id_map;
> +       struct stat sb;
>
>         specs_map = bpf_object__find_map_by_name(obj, "__bpf_usdt_specs");
>         ip_to_spec_id_map = bpf_object__find_map_by_name(obj, "__bpf_usdt_ip_to_spec_id");
> @@ -282,7 +284,7 @@ struct usdt_manager *usdt_manager_new(struct bpf_object *obj)
>          * If this is not supported, USDTs with semaphores will not be supported.
>          * Added in: a6ca88b241d5 ("trace_uprobe: support reference counter in fd-based uprobe")
>          */
> -       man->has_sema_refcnt = access(ref_ctr_sysfs_path, F_OK) == 0;
> +       man->has_sema_refcnt = stat(ref_ctr_sysfs_path, &sb) == 0;
>
>         return man;
>  }
> --
> 2.37.3
>

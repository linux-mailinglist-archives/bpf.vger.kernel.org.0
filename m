Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D993A4F0CF5
	for <lists+bpf@lfdr.de>; Mon,  4 Apr 2022 01:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376665AbiDCXcZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Apr 2022 19:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239505AbiDCXcZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Apr 2022 19:32:25 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACF924BC8
        for <bpf@vger.kernel.org>; Sun,  3 Apr 2022 16:30:30 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id x4so9370271iop.7
        for <bpf@vger.kernel.org>; Sun, 03 Apr 2022 16:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u5rmRG/nWQ9OnNu/CAJllp2munnzn6lUfhctL4rnOCY=;
        b=WBVDBTqa5LOJHBkGZ//limsbWWKRNcG1cPZSnZ9Adc3GknuazuCNmpzONAF7GkUfs2
         ssmkJgmuaga71vCYA/Z6MebZhDBsMn3mtTs9NMjXiZX0p2sYypFQdiKan4m+N9e8FgTu
         TTtyDa7SoxRx4CY69UaKUv1l55/mWfvgah+bYhiG1K1w5iNSU4iymU6jtF8ietWvx6d4
         JiRfLrHy0ZzsT4ZmpkjTtwMKrYSkyBjbFLO5wkzwjxWn09YHWkOBhANZbrcXaNuEW/X9
         WfHJTLcTk43MwlYA/q5mk/mJn1P1bbMSv5VtwACbuWF3KJQ6oXPJFFD+kYXQLFa/m9Ev
         Fc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u5rmRG/nWQ9OnNu/CAJllp2munnzn6lUfhctL4rnOCY=;
        b=3qsjulCFq/7YRu2ph/501ze3WnnX/CAPtg9sHbU2/x0GfgsH+3xN2hv+FbmP7CL+Db
         AGcUCC/IpSPGpB6FfS0WC0tjILmuSB84LkQTtyjh4cuiJJfwVi/KnligqTz98LyxM9vK
         FZyAEDFkx1vpBBqo15h/Z/LDFyN8JS4thlbiIu6z1QHDtwLaAZ6ZoNiMMzmHRqwNEHhE
         rn1q8id6XzGUmdcm7JgDrdwd1wVK3vufhfYCiE69peZP7gOUOyKBfX61QgPy9C2CLxGM
         h+IJs2F/BfTFI//xmXeAXBIUTjnB4izXeIX8ccz/MTrx0HAiY+PphpBCUu8w/BVTRSdV
         DwIg==
X-Gm-Message-State: AOAM5319oI5WMpiQqX2HWGFeaeqV8nFHQ+f3cTsjkpEqmDznlFBFq6B9
        ybbWVR5Eh8gVI+MNjhg50SzpeRjU6pEebuwycCE=
X-Google-Smtp-Source: ABdhPJz1U6iXs6q3MLTuADRco315LHKsGg5+qNCWJE7NBQsB/RytOHWPOmhnqBlG13csxCZzXbgKLQmZ1dQv+PJWztQ=
X-Received: by 2002:a6b:8bd7:0:b0:646:2804:5c73 with SMTP id
 n206-20020a6b8bd7000000b0064628045c73mr4120401iod.112.1649028629381; Sun, 03
 Apr 2022 16:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220330075051.34326-1-puranjay12@gmail.com>
In-Reply-To: <20220330075051.34326-1-puranjay12@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sun, 3 Apr 2022 16:30:18 -0700
Message-ID: <CAEf4BzbpKX6EzJRS_VLjBjZHvbpeP07bFSBFHpQ+ifsHdKbXGQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Move spintest from samples/bpf to selftests
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 30, 2022 at 12:51 AM Puranjay Mohan <puranjay12@gmail.com> wrote:
>
> According to the discussions in [1] everything from the samples/bpf
> directory should be moved out or deleted.
>
> Move the spintest program from BPF samples to BPF selftests.
> There are no functional changes. BPF skeleton has been used for loading,
> etc.
>

Great that you are helping with selftests consolidation, thanks! I
have few comments which will require a new revision, but overall this
is moving in the right direction.

> [1] https://lore.kernel.org/all/CAEf4BzYv3ONhy-JnQUtknzgBSK0gpm9GBJYtbAiJQe50_eX7Uw@mail.gmail.com/
>
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  samples/bpf/Makefile                          |  3 --
>  .../selftests/bpf/prog_tests/spintest.c       | 43 +++++++------------
>  .../testing/selftests/bpf/progs/test_spin.c   | 15 +++----
>  3 files changed, 23 insertions(+), 38 deletions(-)
>  rename samples/bpf/spintest_user.c => tools/testing/selftests/bpf/prog_tests/spintest.c (63%)
>  rename samples/bpf/spintest_kern.c => tools/testing/selftests/bpf/progs/test_spin.c (86%)
>

[...]

>
> -       if (load_kallsyms()) {
> -               printf("failed to process /proc/kallsyms\n");
> -               return 2;
> -       }
> +       err = load_kallsyms();

do we need to use kallsyms? selftests generally follows the latest
kernel, so whatever attach target doesn't exist in the kernel we
should just remove

> +       if (!ASSERT_OK(err, "load_kallsyms"))
> +               return;
> +       skel = test_spin__open_and_load();
>
> -       snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
> -       obj = bpf_object__open_file(filename, NULL);
> -       if (libbpf_get_error(obj)) {
> -               fprintf(stderr, "ERROR: opening BPF object file failed\n");
> -               obj = NULL;
> -               goto cleanup;
> -       }
> +       if (!ASSERT_OK_PTR(skel, "test_spin__open_and_load"))
> +               return;
>
> -       /* load BPF program */
> -       if (bpf_object__load(obj)) {
> -               fprintf(stderr, "ERROR: loading BPF object file failed\n");
> -               goto cleanup;
> -       }
> -
> -       map_fd = bpf_object__find_map_fd_by_name(obj, "my_map");
> -       if (map_fd < 0) {
> -               fprintf(stderr, "ERROR: finding a map in obj file failed\n");
> -               goto cleanup;
> -       }
> +       map_fd = bpf_map__fd(skel->maps.my_map);
>
> -       bpf_object__for_each_program(prog, obj) {
> +       bpf_object__for_each_program(prog, skel->obj) {
>                 section = bpf_program__section_name(prog);
>                 if (sscanf(section, "kprobe/%s", symbol) != 1)
>                         continue;
> @@ -52,7 +41,8 @@ int main(int ac, char **argv)
>                 /* Attach prog only when symbol exists */
>                 if (ksym_get_addr(symbol)) {
>                         links[j] = bpf_program__attach(prog);
> -                       if (libbpf_get_error(links[j])) {
> +                       err = libbpf_get_error(links[j]);
> +                       if (!ASSERT_OK(err, "bpf_program__attach")) {
>                                 fprintf(stderr, "bpf_program__attach failed\n");
>                                 links[j] = NULL;
>                                 goto cleanup;

there are a bunch of leftover prints, let's get rid of them and/or
turn them into ASSERT_xxx()

there is sleep(1) in each of 5 iterations, this slows down the
selftests a lot. Let's get rid of it.


there is also assert(), there shouldn't be any calls to assert()
crashing the process in selftests

> @@ -89,5 +79,4 @@ int main(int ac, char **argv)
>                 bpf_link__destroy(links[j]);

let's use skeleton's links "storage" and simplify the cleanup significantly.

>
>         bpf_object__close(obj);

this should be test_spin__destroy() instead

> -       return 0;
>  }
> diff --git a/samples/bpf/spintest_kern.c b/tools/testing/selftests/bpf/progs/test_spin.c
> similarity index 86%
> rename from samples/bpf/spintest_kern.c
> rename to tools/testing/selftests/bpf/progs/test_spin.c
> index 455da77319d9..531783fe6cb9 100644
> --- a/samples/bpf/spintest_kern.c
> +++ b/tools/testing/selftests/bpf/progs/test_spin.c
> @@ -4,14 +4,14 @@
>   * modify it under the terms of version 2 of the GNU General Public
>   * License as published by the Free Software Foundation.
>   */
> -#include <linux/skbuff.h>
> -#include <linux/netdevice.h>
> -#include <linux/version.h>
> -#include <uapi/linux/bpf.h>
> -#include <uapi/linux/perf_event.h>
> +#include <vmlinux.h>
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
>
> +#ifndef PERF_MAX_STACK_DEPTH
> +#define PERF_MAX_STACK_DEPTH         127
> +#endif
> +
>  struct {
>         __uint(type, BPF_MAP_TYPE_HASH);
>         __type(key, long);
> @@ -27,8 +27,8 @@ struct {
>
>  struct {
>         __uint(type, BPF_MAP_TYPE_STACK_TRACE);
> -       __uint(key_size, sizeof(u32));
> -       __uint(value_size, PERF_MAX_STACK_DEPTH * sizeof(u64));
> +       __uint(key_size, sizeof(__u32));
> +       __uint(value_size, PERF_MAX_STACK_DEPTH * sizeof(__u64));
>         __uint(max_entries, 10000);
>  } stackmap SEC(".maps");
>
> @@ -66,4 +66,3 @@ SEC("kprobe/__htab_percpu_map_update_elem")PROG(p16)
>  SEC("kprobe/htab_map_alloc")PROG(p17)

I don't see why we need this PROG(pXX) magic instead of just doing a
function call. Let's have a common function called from each of the
defined kprobe program.

>
>  char _license[] SEC("license") = "GPL";
> -u32 _version SEC("version") = LINUX_VERSION_CODE;
> --
> 2.35.1
>

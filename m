Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F304A5712
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 06:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiBAFuO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 00:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbiBAFuO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Feb 2022 00:50:14 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE62C061714
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 21:50:13 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id q11so5217706ild.11
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 21:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2KHA7BkydmzBg2tGpIVbQsCK2ZlzH1qs5ahJoG0Cobk=;
        b=fo+U8PDqGdTAyPxwMPmK8x+LLHhm3w+7ytsJWSuCXuqj0HUWIKNTdTS9UPd1zN+VD/
         XkqhIjcyCUghR5Zmt4ham3iMCf8PKjkmbHGAFJkAZ52mdePdfrfnb8KQVOXsCUeeBvW2
         CrAc+Y3kT0wmpaGEwfdHGVi3SZzoJyqwXGqIxFMUGQJS3ht3vuPMy5DcECUZqrrwz8I+
         xiFvXgfjzBSXvajFBg9plCYdpQP+tf7VSfq7FsgFMWpuwTpK8uM0nM7SZgFoAPoRGSHI
         w+sNDVwzUalamNPgoyAdqn7ujhd/0uz+NbBo5nj6NUzshFCG6t8eWITTf/1J+JN66fYe
         J6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2KHA7BkydmzBg2tGpIVbQsCK2ZlzH1qs5ahJoG0Cobk=;
        b=NCJvPQaMNOA//QiQKHhNmcyUMS0n20fFkRsP5jrdr2PvIJLtPKmLr7jKZpdpsnwFjd
         fHAUpv1BOrJIp26xkZ8qRxtt00HrWZ8fyTWnh53rffY+iQN5MjuqzjkZCKXud0sxtOqI
         Zr93H2m03HEsEh/8x+xiYwmdOauQFSPGAn42wxcot2Up+ZXSE8MN4qF51EFRVb6IGdxb
         uc8dGk3vSDuqkOWR/VXMGhTOiGMa/LypizOJwkLIPdOQdikKk/uxdRK0/0958HkJzlPg
         3Xhhzqpdf1dEtcwWhWXQDWVeqtLkEN946NgFhpAKzNm828M0s1EIjcp13wV6QUL/pljM
         f1nQ==
X-Gm-Message-State: AOAM530JV5l/EEMQq2Wd1wdUccA8rdw3KLaCIYTLWFvMBthsUUX48A/u
        nTJAkDiuXIxmOc4ReUKxATKrXl3brCgoFJSpDZA=
X-Google-Smtp-Source: ABdhPJyZaztgXuDDoYcNQ3ArWT/8mJrd0nxTbfPyYNfQ8+Fky2VZdnUi0ZZL2jVnhrdmR5mwtSPSS/E5mM73s688i8E=
X-Received: by 2002:a05:6e02:190e:: with SMTP id w14mr14063363ilu.71.1643694612310;
 Mon, 31 Jan 2022 21:50:12 -0800 (PST)
MIME-Version: 1.0
References: <d456931681fe2344ae56225a698a0bd1d5c63b88.1643375942.git.lorenzo@kernel.org>
In-Reply-To: <d456931681fe2344ae56225a698a0bd1d5c63b88.1643375942.git.lorenzo@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 31 Jan 2022 21:50:01 -0800
Message-ID: <CAEf4Bzbt--iLcctUq+D_CXY0qyDRi3_uWc=vvOV4z-eQvum2cA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] libbpf: deprecate xdp_cpumap and xdp_devmap
 sec definitions
To:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        David Ahern <dsahern@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        john fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 28, 2022 at 5:29 AM Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> Deprecate xdp_cpumap xdp_devmap sec definitions.
> Introduce xdp/devmap and xdp/cpumap definitions according to the standard
> for SEC("") in libbpf:
> - prog_type.prog_flags/attach_place
> Update cpumap/devmap samples and kselftests
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Changes since v1:
> - refer to Libbpf-1.0-migration-guide in the warning rised by libbpf
> ---
>  samples/bpf/xdp_redirect_cpu.bpf.c                   |  8 ++++----
>  samples/bpf/xdp_redirect_map.bpf.c                   |  2 +-
>  samples/bpf/xdp_redirect_map_multi.bpf.c             |  2 +-
>  tools/lib/bpf/libbpf.c                               | 12 ++++++++++--
>  .../bpf/progs/test_xdp_with_cpumap_frags_helpers.c   |  2 +-
>  .../bpf/progs/test_xdp_with_cpumap_helpers.c         |  2 +-
>  .../bpf/progs/test_xdp_with_devmap_frags_helpers.c   |  2 +-
>  .../bpf/progs/test_xdp_with_devmap_helpers.c         |  2 +-
>  .../selftests/bpf/progs/xdp_redirect_multi_kern.c    |  2 +-

Please split samples/bpf, selftests/bpf, and libbpf changes into
separate patches. We keep them separate whenever possible.

>  9 files changed, 21 insertions(+), 13 deletions(-)
>

[...]

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 4ce94f4ed34a..ba003cabe4a4 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -237,6 +237,8 @@ enum sec_def_flags {
>         SEC_SLOPPY_PFX = 16,
>         /* BPF program support non-linear XDP buffer */
>         SEC_XDP_FRAGS = 32,
> +       /* deprecated sec definitions not supposed to be used */
> +       SEC_DEPRECATED = 64,
>  };
>
>  struct bpf_sec_def {
> @@ -6575,6 +6577,10 @@ static int libbpf_preload_prog(struct bpf_program *prog,
>         if (prog->type == BPF_PROG_TYPE_XDP && (def & SEC_XDP_FRAGS))
>                 opts->prog_flags |= BPF_F_XDP_HAS_FRAGS;
>
> +       if (def & SEC_DEPRECATED)
> +               pr_warn("sec '%s' is deprecated, please take a look at https://github.com/libbpf/libbpf/wiki/Libbpf-1.0-migration-guide\n",
> +                       prog->sec_name);
> +

Please add a link directly to [0]. I just added a new section listing
xdp_devmap and xdp_cpumap. I also added SEC("classifier") ->
SEC("tc"), so let's mark SEC("classifier") as deprecated as well in
the next revision?

Daniel, does that sound reasonable to you or should we leave
SEC("classifier") intact?

Let's use also the syntax consistent with the code people write.
Something like "SEC(\"%s\") is deprecated, please see
https://github.com/libbpf/libbpf/wiki/Libbpf-1.0-migration-guide#bpf-program-sec-annotation-deprecations
for details"?

  [0] https://github.com/libbpf/libbpf/wiki/Libbpf-1.0-migration-guide#bpf-program-sec-annotation-deprecations

>         if ((prog->type == BPF_PROG_TYPE_TRACING ||
>              prog->type == BPF_PROG_TYPE_LSM ||
>              prog->type == BPF_PROG_TYPE_EXT) && !prog->attach_btf_id) {
> @@ -8618,9 +8624,11 @@ static const struct bpf_sec_def section_defs[] = {
>         SEC_DEF("iter.s/",              TRACING, BPF_TRACE_ITER, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_iter),
>         SEC_DEF("syscall",              SYSCALL, 0, SEC_SLEEPABLE),
>         SEC_DEF("xdp.frags/devmap",     XDP, BPF_XDP_DEVMAP, SEC_XDP_FRAGS),
> -       SEC_DEF("xdp_devmap/",          XDP, BPF_XDP_DEVMAP, SEC_ATTACHABLE),
> +       SEC_DEF("xdp/devmap",           XDP, BPF_XDP_DEVMAP, SEC_ATTACHABLE),
> +       SEC_DEF("xdp_devmap/",          XDP, BPF_XDP_DEVMAP, SEC_ATTACHABLE | SEC_DEPRECATED),
>         SEC_DEF("xdp.frags/cpumap",     XDP, BPF_XDP_CPUMAP, SEC_XDP_FRAGS),
> -       SEC_DEF("xdp_cpumap/",          XDP, BPF_XDP_CPUMAP, SEC_ATTACHABLE),
> +       SEC_DEF("xdp/cpumap",           XDP, BPF_XDP_CPUMAP, SEC_ATTACHABLE),
> +       SEC_DEF("xdp_cpumap/",          XDP, BPF_XDP_CPUMAP, SEC_ATTACHABLE | SEC_DEPRECATED),
>         SEC_DEF("xdp.frags",            XDP, BPF_XDP, SEC_XDP_FRAGS),
>         SEC_DEF("xdp",                  XDP, BPF_XDP, SEC_ATTACHABLE_OPT | SEC_SLOPPY_PFX),
>         SEC_DEF("perf_event",           PERF_EVENT, 0, SEC_NONE | SEC_SLOPPY_PFX),

[...]

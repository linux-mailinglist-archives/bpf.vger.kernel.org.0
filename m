Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DE65FA971
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 02:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiJKAom (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Oct 2022 20:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJKAol (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 20:44:41 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF572814FD
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 17:44:33 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r14so3655987edc.7
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 17:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fiXi4k7ePf+USFfVdzzCjsbIt5OAJgkPWYTHAkhJLeY=;
        b=FpEi1X66BRAg+bX6AWgsCSUeF/ZtSDVnUFntXeIzSaoZzwuYypWrHR335RCB+YR4Np
         lfJ7j2ElYzvRc+c467ALLvBnJiG787EQpJdWXNviC1xWf++Klrz4d7CmVdNi+CaR84xf
         8S4zol4NIQJS4Rd4g/XEmBH16scp8BRP90B5/sK85RFuSu5a/54hax0Z4Degdgffr2/F
         bgboqPbv9WTsIyFaBtE47hAAMX0waaKYURVHVwJzzY2OZWSoRDrgGPtuyJoC+WRNnljN
         LT7QFe72vklxZvanrpUKpBhwI5aPveYnM2GlaRUftjWnvSCdzbn683GehBSgjLZy5TN9
         b/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fiXi4k7ePf+USFfVdzzCjsbIt5OAJgkPWYTHAkhJLeY=;
        b=EWNBfXw9UswJx6mRcNAgLQMS2y8t8ftkcEuXIEgRubw+KpCtfO1f9qLdbgSgSLvhlN
         ujucck9jMDklDhNl6Cjus9U6+gfl6+nMqQwOzFZH7ArcVFuNSrxBOyU7TK9/q4F1WJMQ
         H4dQVTjA4VsVLnH067JOgaqowaqJQBJhZUvoImWIpq7CFz1550DIVX1vX61YMDWB3T64
         8tcziY2qVcaq797xOs4o5PTVeY3sfeyiwrmCO/x7ul8C8JaKXLEllimJ3XBXpwHTYQL9
         A8Um0TMEs9gJIbcPui3DzrVxdcztW1/ESIgt2eKKvnyMoKSKGhjT023s9d3S6Ky0inbA
         vuog==
X-Gm-Message-State: ACrzQf1auUMh8FF6FRnSdTWaZsmXz3nbWj2LbeULxPQaf796gwVOobjC
        YgV/31KrFAmO/Z/wfBnJb8OGxGdk/THQIqscgzk=
X-Google-Smtp-Source: AMsMyM4WZbGxl3QqfgiE9J2LnGJb3+imoxv+HZYboamizzd1d8XdrpTZIlZvQLwkpTPzpv5ZsbEaj/5qzmXq99nBqi8=
X-Received: by 2002:a05:6402:1856:b0:458:db1e:20ec with SMTP id
 v22-20020a056402185600b00458db1e20ecmr20691254edy.14.1665449072058; Mon, 10
 Oct 2022 17:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <20221007174816.17536-1-shung-hsi.yu@suse.com> <20221007174816.17536-2-shung-hsi.yu@suse.com>
In-Reply-To: <20221007174816.17536-2-shung-hsi.yu@suse.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 10 Oct 2022 17:44:20 -0700
Message-ID: <CAEf4Bzb08aKQQCGozqcxe8c4Qj3Bna6v1AETat_vMm7L=ixcaA@mail.gmail.com>
Subject: Re: [PATCH bpf 1/3] libbpf: use elf_getshdrnum() instead of e_shnum
To:     Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc:     bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
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

On Fri, Oct 7, 2022 at 10:48 AM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
>
> This commit replace e_shnum with the elf_getshdrnum() helper to fix two
> oss-fuzz-reported heap-buffer overflow in __bpf_object__open. Both
> reports are incorrectly marked as fixed and while still being
> reproducible in the latest libbpf.
>
>   # clusterfuzz-testcase-minimized-bpf-object-fuzzer-5747922482888704
>   libbpf: loading object 'fuzz-object' from buffer
>   libbpf: sec_cnt is 0
>   libbpf: elf: section(1) .data, size 0, link 538976288, flags 2020202020202020, type=2
>   libbpf: elf: section(2) .data, size 32, link 538976288, flags 202020202020ff20, type=1
>   =================================================================
>   ==13==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x6020000000c0 at pc 0x0000005a7b46 bp 0x7ffd12214af0 sp 0x7ffd12214ae8
>   WRITE of size 4 at 0x6020000000c0 thread T0
>   SCARINESS: 46 (4-byte-write-heap-buffer-overflow-far-from-bounds)
>       #0 0x5a7b45 in bpf_object__elf_collect /src/libbpf/src/libbpf.c:3414:24
>       #1 0x5733c0 in bpf_object_open /src/libbpf/src/libbpf.c:7223:16
>       #2 0x5739fd in bpf_object__open_mem /src/libbpf/src/libbpf.c:7263:20
>       ...
>
> The issue lie in libbpf's direct use of e_shnum field in ELF header as
> the section header count. Where as libelf, on the other hand,
> implemented an extra logic that, when e_shnum is zero and e_shoff is not
> zero, will use sh_size member of the initial section header as the real
> section header count (part of ELF spec to accommodate situation where
> section header counter is larger than SHN_LORESERVE).
>
> The above inconsistency lead to libbpf writing into a zero-entry calloc
> area. So intead of using e_shnum directly, use the elf_getshdrnum()
> helper provided by libelf to retrieve the section header counter into
> sec_cnt.
>
> Link: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=40868
> Link: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=40957
> Fixes: 0d6988e16a12 ("libbpf: Fix section counting logic")
> Fixes: 25bbbd7a444b ("libbpf: Remove assumptions about uniqueness of .rodata/.data/.bss maps")
> Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> ---
>
> To be honest I'm not sure if any of the BPF toolchain will produce such
> ELF binary. Tools like readelf simply refuse to dump section header
> table when e_shnum==0 && e_shoff !=0 case is encountered.
>
> While we can use same approach as readelf, opting for a coherent view
> with libelf for now since that should be less confusing.
>
> ---
>  tools/lib/bpf/libbpf.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 184ce1684dcd..a64e13c654f3 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -597,7 +597,7 @@ struct elf_state {
>         size_t shstrndx; /* section index for section name strings */
>         size_t strtabidx;
>         struct elf_sec_desc *secs;
> -       int sec_cnt;
> +       size_t sec_cnt;
>         int btf_maps_shndx;
>         __u32 btf_maps_sec_btf_id;
>         int text_shndx;
> @@ -1369,6 +1369,13 @@ static int bpf_object__elf_init(struct bpf_object *obj)
>                 goto errout;
>         }
>
> +       if (elf_getshdrnum(obj->efile.elf, &obj->efile.sec_cnt)) {

It bothers me that sec_cnt is initialized in bpf_object__elf_init, but
secs are allocated a bit later in bpf_object__elf_collect(). What if
we move elf_getshdrnum() call and sec_cnt initialization into
bpf_object__elf_collect()?

> +               pr_warn("elf: failed to get the number of sections for %s: %s\n",
> +                       obj->path, elf_errmsg(-1));
> +               err = -LIBBPF_ERRNO__FORMAT;
> +               goto errout;
> +       }
> +
>         /* Elf is corrupted/truncated, avoid calling elf_strptr. */
>         if (!elf_rawdata(elf_getscn(elf, obj->efile.shstrndx), NULL)) {
>                 pr_warn("elf: failed to get section names strings from %s: %s\n",
> @@ -3315,7 +3322,6 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
>          * section. e_shnum does include sec #0, so e_shnum is the necessary
>          * size of an array to keep all the sections.
>          */
> -       obj->efile.sec_cnt = obj->efile.ehdr->e_shnum;
>         obj->efile.secs = calloc(obj->efile.sec_cnt, sizeof(*obj->efile.secs));
>         if (!obj->efile.secs)
>                 return -ENOMEM;
> --
> 2.37.3
>

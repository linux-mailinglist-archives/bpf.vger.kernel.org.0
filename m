Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCBC6260A9
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 18:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbiKKRrd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 12:47:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbiKKRrc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 12:47:32 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776D5193E5
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 09:47:31 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id k131-20020a628489000000b0056b3e1a9629so3036818pfd.8
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 09:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8D1kZh1leoO2ZCbFhqFSE+VcwIBIPBKirg4sZODP+18=;
        b=osr0stJt2iNGD9pYQmN3cHZv5wYstkKxOJQF6k7vB5m70R1y5O6CIUoJiNMf9f+4mM
         38+mbt++lpO9VWG8lkjnOyz7JwFGd2LE9nk9wU5nWE2JkWC87KGWhdXM0EkLM3c98CNc
         HgdhdAwu2ab5Eh920Xx/Pk7lENR6+TATg73o+hjABCaZDo+sADKFhN9OrzHSv8BFPRCs
         L59l7sK927XkAItVlklriL4DUxBn/xTUA47a5SPWtR83NDp46MLVr4Ztbldymty6at8I
         9JEvbpB2r7NMtdT4tDDN22oosgxe77n3r4MNOLle6y1cCxF00vvDJzHpDA7f60qQhDxb
         Hi9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8D1kZh1leoO2ZCbFhqFSE+VcwIBIPBKirg4sZODP+18=;
        b=hb9D1Z9zF9PFhEkcwsZWHwt9eifY9Rye/FLk0zAnAO3U3/zfCyr5y+JNfNU0MY+HwV
         FPShajVTnMnceg1WlNPau28UDIgfgHCYX0rlfzVOuAermRS5VA8wNOJ/FTz104YwDTDk
         RaD0kHlg1ft1jTPPxhwTj1cM8ur8bdvJyYgTXjkKY7VBilrjDwRayhdVr4UhZiVhpuDv
         UW2Nj9IobflutIO0/ka9MERERJLglz2YbpLjmaxpG6BDZi03HSp/LpjmIGTxvDEdkfft
         MhBC/9Ea2dmbwf9Fm+9IALeli/t7RTXhEjjBVoM2DpeMTphGWogo9KfCgLAVpX3OinnB
         u+yA==
X-Gm-Message-State: ANoB5pnm/NmEeAn2mwLUvRSL/tn6eFAmsy9vKtBEe1JWfn4SkKnXTUEb
        OiqlXNcFBwpNrkUqcRZxDtK/bNo=
X-Google-Smtp-Source: AA0mqf4w68Cr00TNnMXw14b7W7371i5ChTks0qDP32SIKRgiSSrjLpP9v2d+qZrjt5u9ceO/hrvx07A=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:d381:b0:186:5de3:8f10 with SMTP id
 e1-20020a170902d38100b001865de38f10mr3481665pld.92.1668188850963; Fri, 11 Nov
 2022 09:47:30 -0800 (PST)
Date:   Fri, 11 Nov 2022 09:47:29 -0800
In-Reply-To: <20221111092642.2333724-2-houtao@huaweicloud.com>
Mime-Version: 1.0
References: <20221111092642.2333724-1-houtao@huaweicloud.com> <20221111092642.2333724-2-houtao@huaweicloud.com>
Message-ID: <Y26KsQfOLGYeJJoo@google.com>
Subject: Re: [PATCH bpf 1/4] libbpf: Adjust ring buffer size when probing ring
 buffer map
From:   sdf@google.com
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/11, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>

> Adjusting the size of ring buffer when probing ring buffer map, else
> the probe may fail on host with 64KB page size (e.g., an ARM64 host).

> After the fix, the output of "bpftool feature" on above host will be
> correct.

> Before :
>      eBPF map_type ringbuf is NOT available
>      eBPF map_type user_ringbuf is NOT available

> After :
>      eBPF map_type ringbuf is available
>      eBPF map_type user_ringbuf is available

> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>   tools/lib/bpf/libbpf.c          | 2 +-
>   tools/lib/bpf/libbpf_internal.h | 2 ++
>   tools/lib/bpf/libbpf_probes.c   | 2 +-
>   3 files changed, 4 insertions(+), 2 deletions(-)

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 184ce1684dcd..907f735568ae 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -2353,7 +2353,7 @@ int parse_btf_map_def(const char *map_name, struct  
> btf *btf,
>   	return 0;
>   }

> -static size_t adjust_ringbuf_sz(size_t sz)
> +size_t adjust_ringbuf_sz(size_t sz)
>   {
>   	__u32 page_sz = sysconf(_SC_PAGE_SIZE);
>   	__u32 mul;
> diff --git a/tools/lib/bpf/libbpf_internal.h  
> b/tools/lib/bpf/libbpf_internal.h
> index 377642ff51fc..99dc4d6a19be 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -576,4 +576,6 @@ static inline bool is_pow_of_2(size_t x)
>   #define PROG_LOAD_ATTEMPTS 5
>   int sys_bpf_prog_load(union bpf_attr *attr, unsigned int size, int  
> attempts);

> +size_t adjust_ringbuf_sz(size_t sz);
> +
>   #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
> diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
> index f3a8e8e74eb8..29a1db2645fd 100644
> --- a/tools/lib/bpf/libbpf_probes.c
> +++ b/tools/lib/bpf/libbpf_probes.c
> @@ -234,7 +234,7 @@ static int probe_map_create(enum bpf_map_type  
> map_type)
>   	case BPF_MAP_TYPE_USER_RINGBUF:
>   		key_size = 0;
>   		value_size = 0;
> -		max_entries = 4096;
> +		max_entries = adjust_ringbuf_sz(4096);

Why not pass PAGE_SIZE directly here? Something like:

max_entries = sysconf(_SC_PAGE_SIZE);

?

>   		break;
>   	case BPF_MAP_TYPE_STRUCT_OPS:
>   		/* we'll get -ENOTSUPP for invalid BTF type ID for struct_ops */
> --
> 2.29.2


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D68E6067B7
	for <lists+bpf@lfdr.de>; Thu, 20 Oct 2022 20:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiJTSDn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Oct 2022 14:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiJTSDT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Oct 2022 14:03:19 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04139202720
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 11:02:40 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id r3so515003yba.5
        for <bpf@vger.kernel.org>; Thu, 20 Oct 2022 11:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Moz9mEOE8PRO8YTR3q1qOudY9duTlJQdyx4sySmJngs=;
        b=s/sgU1R5aiDV5sSrF+5+hKs18FyYWRZHEjIRbhoVbWqIFyhp9bsr1L/i0Yq9etl337
         uzGMgs24LDkgKqutbQp1bAGUG3lzna87g+ueGVguNzq1a3ANSt1dLKhfNkHAzhRONr9D
         q5HpxW89yUWSSMvIGvWpuGsQCrrv4lbtq7tWe7g42iNPALYH+NPHeHu2NtyTMOJ1IpKW
         WMXbhhWiAKOFeeY29ZMqnrdoVx0gZQpxIEdLZ+PdWu5cWHMJYz8NgPjFVP2Lo8KaeULc
         2bxJ6DOBKD2LnA0whtq/wS7Yh4FOxQcg79w5p0C1dyovALVZqhD2oOgUgYRXLGzNH3iK
         VCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Moz9mEOE8PRO8YTR3q1qOudY9duTlJQdyx4sySmJngs=;
        b=Mr+TYmwbOoQEXkCBVFEr/1sl3Zk4gMKB6ewvPdKb8UhT0yPLnxlQe535++7CTTlJqg
         2tbFtnjsqNkPhE0CD/7WfPyqZQ5d6XQ22n35mWfrs/1A9A7A0NQveYb3JoNWqkYW2zk8
         4cCEnmmu/lCdJ5zK7ndgOFjPVkv7yj0IuJk5l8eptBNKYfZHFXgY4R6S0HiW+eZLUgBG
         KEwAYFhNivVdaAWmTeFRpc8f4xRE0jvoRYz09i5W2HC3jmNmZGlY5o8R+22dVxaiZYYB
         BclCn3mPxVI2PzwHYopVRShiACUzbQf5i+bxrPaSsfiqAInzRjKSBCo3M6oSabTrIH6q
         B5Aw==
X-Gm-Message-State: ACrzQf01HDlgkO6mGANMtghWnqjKK1FfJaF5ikKFD9cqAXMzi+ry+anX
        Busddl83fTmlphGu3kLcMEoobDjJODi7aEsvrLxtgw==
X-Google-Smtp-Source: AMsMyM6FqF6mdKK1SFkEFj2gZ2CjOMnrYP2ZlDXAph44Sxdd6c/4Y6DnGBQPkBr/3YbzNddpS0SHPcTO5N//2dZR4Cg=
X-Received: by 2002:a25:2fc6:0:b0:6be:873a:d15c with SMTP id
 v189-20020a252fc6000000b006be873ad15cmr11910012ybv.577.1666288912887; Thu, 20
 Oct 2022 11:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <20221020142247.1682009-1-houtao@huaweicloud.com>
In-Reply-To: <20221020142247.1682009-1-houtao@huaweicloud.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 20 Oct 2022 11:01:41 -0700
Message-ID: <CA+khW7jE_inL9-66Cb_WAPey6YkY+yf1H+q2uASTQujNXbRF=Q@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Support for setting numa node in bpf memory allocator
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 20, 2022 at 6:57 AM Hou Tao <houtao@huaweicloud.com> wrote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> Since commit fba1a1c6c912 ("bpf: Convert hash map to bpf_mem_alloc."),
> numa node setting for non-preallocated hash table is ignored. The reason
> is that bpf memory allocator only supports NUMA_NO_NODE, but it seems it
> is trivial to support numa node setting for bpf memory allocator.
>
> So adding support for setting numa node in bpf memory allocator and
> updating hash map accordingly.
>
> Fixes: fba1a1c6c912 ("bpf: Convert hash map to bpf_mem_alloc.")
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---

Looks good to me with a few nits.

>
<...>
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index fc116cf47d24..44c531ba9534 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
<...>
> +static inline bool is_valid_numa_node(int numa_node, bool percpu)
> +{
> +       return numa_node == NUMA_NO_NODE ||
> +              (!percpu && (unsigned int)numa_node < nr_node_ids);

Maybe also check node_online? There is a similar helper function in
kernel/bpf/syscall.c.

It may help debugging if we could log the reason here, for example,
PERCPU map but with numa_node specified.

> +}
> +
> +/* The initial prefill is running in the context of map creation process, so
> + * if the preferred numa node is NUMA_NO_NODE, needs to use numa node of the
> + * specific cpu instead.
> + */
> +static inline int get_prefill_numa_node(int numa_node, int cpu)
> +{
> +       int prefill_numa_node;
> +
> +       if (numa_node == NUMA_NO_NODE)
> +               prefill_numa_node = cpu_to_node(cpu);
> +       else
> +               prefill_numa_node = numa_node;
> +       return prefill_numa_node;
>  }

nit: an alternative implementation is

 return numa_node == NUMA_NO_NODE ? cpu_to_node(cpu) : numa_node;

>
>  /* When size != 0 bpf_mem_cache for each cpu.
> @@ -359,13 +383,17 @@ static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
>   * kmalloc/kfree. Max allocation size is 4096 in this case.
>   * This is bpf_dynptr and bpf_kptr use case.
>   */

We added a parameter to this function, I think it is worth mentioning
the 'numa_node' argument's behavior under different values of
'percpu'.

> -int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
> +int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, int numa_node,
> +                      bool percpu)
>  {
<...>
> --
> 2.29.2
>

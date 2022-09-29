Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA665EEC63
	for <lists+bpf@lfdr.de>; Thu, 29 Sep 2022 05:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbiI2DW1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 23:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbiI2DW0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 23:22:26 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11AE126B7D
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 20:22:24 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x92so249258ede.9
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 20:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=79tPjxrL8l+ZngW4RI2F81e20BUojb52K+S7F81EuH8=;
        b=BGGA7nDu8fzU3ZoazP5LS1pUx8icqawXdndieOlXLg9BMgLKuTtzIR+m5Teog2VgxM
         FkCEux+bmc9sWlJX1BA2Rwrx6sMNGnbwWbU8Fn2YwG5ZBPLbG8ofNvC6rGc2XLxBjQxG
         FE8rQWQIYgJKiPgh0N/efbB1R9s0rwRYFz3zyBFV7Ux9R/Ctg3kmMz3YIZ621G6tfNqx
         oibUHRIum9w+u7OQNh8qtv4coztDgDxk6PK3Pf6+ShtftHFnShKdRWLmblRRtP+yWifK
         fjmBq/T1UFQE4v7k17vLuLhSHFreVJ6FwpQvTDN95sB2LZ+D0BxeTQVIYdvvZFq4q//2
         NILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=79tPjxrL8l+ZngW4RI2F81e20BUojb52K+S7F81EuH8=;
        b=yYvIVljKz93umVyZezofOLFhz+U4sUYbu2fjt1arxhFxD2GAIVal5AOhW58rxEeo9h
         MZP+6jWBMc/zvFKfaYaX0o7E8hzxFuXzYtYr6kcBWHMk6nCZRkQmofEo061HPiixtWP7
         2xpaySsG23TVfR3+vVFkCh62JfvDXUz9rY4eKdwAfrChLJ+iF4HR+4+SX09VIJqkSGVo
         E+8G3G11pa+3DoyhjUiUprcVJlDVwGNaaChJrLZE9fu9plys/l2ieOj2hueq/0QsHQ+U
         yASrLek6qEJmRd593cq9xhrM95sSzZFKdq4WUQ9/ls06rTrUUujSATM9nSQvKu3oUz/G
         s8lw==
X-Gm-Message-State: ACrzQf3zYL3fTxHZZ+rXswDW7yJWIhXS/ViA4O/O72kKueXXE0LV5Hsg
        OKxep84/0btpltd8GU4QNCDWStVfqsh4o9xTfK4=
X-Google-Smtp-Source: AMsMyM4Gic5aK1C73G1r/DN3dpF/5rdBKeYY5wxr9rH5MZl3vlTU47Lds+0f1nOZgasfZGWX8c2Kg+nEybnetEvTFDQ=
X-Received: by 2002:a05:6402:5406:b0:452:1560:f9d4 with SMTP id
 ev6-20020a056402540600b004521560f9d4mr1142477edb.333.1664421743067; Wed, 28
 Sep 2022 20:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220924133620.4147153-1-houtao@huaweicloud.com>
 <20220926012535.badx76iwtftyhq6m@MacBook-Pro-4.local> <ca0c97ae-6fd5-290b-6a00-fe3fe2e87aeb@huaweicloud.com>
 <20220927011949.sxxkyhjiig7wg7kv@macbook-pro-4.dhcp.thefacebook.com>
 <3c7cf1a8-16f2-5876-ff92-add6fd795caf@huaweicloud.com> <CAADnVQL_fMx3P24wzw2LMON-SqYgRKYziUHg6+mYH0i6kpvJcA@mail.gmail.com>
 <2d9c2c06-af12-6ad1-93ef-454049727e78@huaweicloud.com> <CAADnVQLWQcjYypR2+6UxhKrLOnpRQtB3PZ0=xOtjGpkEhWbH3g@mail.gmail.com>
 <2dda66a7-40f5-e595-48cf-b8588c70197a@huaweicloud.com>
In-Reply-To: <2dda66a7-40f5-e595-48cf-b8588c70197a@huaweicloud.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 28 Sep 2022 20:22:11 -0700
Message-ID: <CAADnVQKpNn47=2VCNK0BWVR23iwA_S3o3gW4WGuNRgLNzFLXog@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 00/13] Add support for qp-trie with dynptr key
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf <bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Hou Tao <houtao1@huawei.com>
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

On Wed, Sep 28, 2022 at 1:46 AM Hou Tao <houtao@huaweicloud.com> wrote:
>
> Hi,
>
> On 9/28/2022 9:08 AM, Alexei Starovoitov wrote:
> > On Tue, Sep 27, 2022 at 7:08 AM Hou Tao <houtao@huaweicloud.com> wrote:
> >
> SNIP
> >> I can not reproduce the phenomenon that call_rcu consumes 100% of all cpus in my
> >> local environment, could you share the setup for it ?
> >>
> >> The following is the output of perf report (--no-children) for "./map_perf_test
> >> 4 72 10240 100000" on a x86-64 host with 72-cpus:
> >>
> >>     26.63%  map_perf_test    [kernel.vmlinux]                             [k]
> >> alloc_htab_elem
> >>     21.57%  map_perf_test    [kernel.vmlinux]                             [k]
> >> htab_map_update_elem
> > Looks like the perf is lost on atomic_inc/dec.
> > Try a partial revert of mem_alloc.
> > In particular to make sure
> > commit 0fd7c5d43339 ("bpf: Optimize call_rcu in non-preallocated hash map.")
> > is reverted and call_rcu is in place,
> > but percpu counter optimization is still there.
> > Also please use 'map_perf_test 4'.
> > I doubt 1000 vs 10240 will make a difference, but still.
> >
> I have tried the following two setups:
> (1) Don't use bpf_mem_alloc in hash-map and use per-cpu counter in hash-map
> # Samples: 1M of event 'cycles:ppp'
> # Event count (approx.): 1041345723234
> #
> # Overhead  Command          Shared Object                                Symbol
> # ........  ...............  ...........................................
> ...............................................
> #
>     10.36%  map_perf_test    [kernel.vmlinux]                             [k]
> bpf_map_get_memcg.isra.0

That is per-cpu counter and it's consuming 10% ?!
Something is really odd in your setup.
A lot of debug configs?

>      9.82%  map_perf_test    [kernel.vmlinux]                             [k]
> bpf_map_kmalloc_node
>      4.24%  map_perf_test    [kernel.vmlinux]                             [k]
> check_preemption_disabled

clearly debug build.
Please use production build.

>      2.86%  map_perf_test    [kernel.vmlinux]                             [k]
> htab_map_update_elem
>      2.80%  map_perf_test    [kernel.vmlinux]                             [k]
> __kmalloc_node
>      2.72%  map_perf_test    [kernel.vmlinux]                             [k]
> htab_map_delete_elem
>      2.30%  map_perf_test    [kernel.vmlinux]                             [k]
> memcg_slab_post_alloc_hook
>      2.21%  map_perf_test    [kernel.vmlinux]                             [k]
> entry_SYSCALL_64
>      2.17%  map_perf_test    [kernel.vmlinux]                             [k]
> syscall_exit_to_user_mode
>      2.12%  map_perf_test    [kernel.vmlinux]                             [k] jhash
>      2.11%  map_perf_test    [kernel.vmlinux]                             [k]
> syscall_return_via_sysret
>      2.05%  map_perf_test    [kernel.vmlinux]                             [k]
> alloc_htab_elem
>      1.94%  map_perf_test    [kernel.vmlinux]                             [k]
> _raw_spin_lock_irqsave
>      1.92%  map_perf_test    [kernel.vmlinux]                             [k]
> preempt_count_add
>      1.92%  map_perf_test    [kernel.vmlinux]                             [k]
> preempt_count_sub
>      1.87%  map_perf_test    [kernel.vmlinux]                             [k]
> call_rcu
>
>
> (2) Use bpf_mem_alloc & per-cpu counter in hash-map, but no batch call_rcu
> optimization
> By revert the following commits:
>
> 9f2c6e96c65e bpf: Optimize rcu_barrier usage between hash map and bpf_mem_alloc.
> bfc03c15bebf bpf: Remove usage of kmem_cache from bpf_mem_cache.
> 02cc5aa29e8c bpf: Remove prealloc-only restriction for sleepable bpf programs.
> dccb4a9013a6 bpf: Prepare bpf_mem_alloc to be used by sleepable bpf programs.
> 96da3f7d489d bpf: Remove tracing program restriction on map types
> ee4ed53c5eb6 bpf: Convert percpu hash map to per-cpu bpf_mem_alloc.
> 4ab67149f3c6 bpf: Add percpu allocation support to bpf_mem_alloc.
> 8d5a8011b35d bpf: Batch call_rcu callbacks instead of SLAB_TYPESAFE_BY_RCU.
> 7c266178aa51 bpf: Adjust low/high watermarks in bpf_mem_cache
> 0fd7c5d43339 bpf: Optimize call_rcu in non-preallocated hash map.
>
>      5.17%  map_perf_test    [kernel.vmlinux]                             [k]
> check_preemption_disabled
>      4.53%  map_perf_test    [kernel.vmlinux]                             [k]
> __get_obj_cgroup_from_memcg
>      2.97%  map_perf_test    [kernel.vmlinux]                             [k]
> htab_map_update_elem
>      2.74%  map_perf_test    [kernel.vmlinux]                             [k]
> htab_map_delete_elem
>      2.62%  map_perf_test    [kernel.vmlinux]                             [k]
> kmem_cache_alloc_node
>      2.57%  map_perf_test    [kernel.vmlinux]                             [k]
> memcg_slab_post_alloc_hook
>      2.34%  map_perf_test    [kernel.vmlinux]                             [k] jhash
>      2.30%  map_perf_test    [kernel.vmlinux]                             [k]
> entry_SYSCALL_64
>      2.25%  map_perf_test    [kernel.vmlinux]                             [k]
> obj_cgroup_charge
>      2.23%  map_perf_test    [kernel.vmlinux]                             [k]
> alloc_htab_elem
>      2.17%  map_perf_test    [kernel.vmlinux]                             [k]
> memcpy_erms
>      2.17%  map_perf_test    [kernel.vmlinux]                             [k]
> syscall_exit_to_user_mode
>      2.16%  map_perf_test    [kernel.vmlinux]                             [k]
> syscall_return_via_sysret
>      2.14%  map_perf_test    [kernel.vmlinux]                             [k]
> _raw_spin_lock_irqsave
>      2.13%  map_perf_test    [kernel.vmlinux]                             [k]
> preempt_count_add
>      2.12%  map_perf_test    [kernel.vmlinux]                             [k]
> preempt_count_sub
>      2.00%  map_perf_test    [kernel.vmlinux]                             [k]
> percpu_counter_add_batch
>      1.99%  map_perf_test    [kernel.vmlinux]                             [k]
> alloc_bulk
>      1.97%  map_perf_test    [kernel.vmlinux]                             [k]
> call_rcu
>      1.52%  map_perf_test    [kernel.vmlinux]                             [k]
> mod_objcg_state
>      1.36%  map_perf_test    [kernel.vmlinux]                             [k]
> allocate_slab
>
> In both of these two setups, the overhead of call_rcu is about 2% and it is not
> the biggest overhead.
>
> Maybe add a not-immediate-reuse flag support to bpf_mem_alloc is reason. What do
> you think ?

We've discussed it twice already. It's not an option due to OOM
and performance considerations.
call_rcu doesn't scale to millions a second.

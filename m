Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFB45F8612
	for <lists+bpf@lfdr.de>; Sat,  8 Oct 2022 18:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiJHQkW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 8 Oct 2022 12:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiJHQkV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 8 Oct 2022 12:40:21 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161293137F
        for <bpf@vger.kernel.org>; Sat,  8 Oct 2022 09:40:18 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id b2so17162596eja.6
        for <bpf@vger.kernel.org>; Sat, 08 Oct 2022 09:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ewZX7Vv72hvDTyaPc1WL4Tz0zzjCjCaWHzCJK+2Vzoo=;
        b=IvCBTDjNPAEYbFW5gRkhlNmL8Tip0pek1OZspGUBVHdTTrjAL/QuUZqWvcoPR1In5l
         c6/wM713C1KeGV1An6LO8rHdDjug+Pv2dO+uNEsmXTAGyZgEZjoqdwGpMtFfJVAsPqH3
         0eSz3NY9ZfXLmmA2XV1PZONrmJIeREF0aFUbLJJAHLDun8ppfY5FkqdmWw3gDQ9bzaNo
         zdRV1nVZlkgLK0kjnjC0K9o44XmgMC7ZNiOX7FDtiYPKhjxZ0kg4sPbOkhnNBpzLaLmy
         Ef8/yJu5QQzgSoH9DX2NIhSz+mKO/PBXcWjW9HZ2gTIGYnLXp/u4C3+bew3WjIktWseC
         Y9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ewZX7Vv72hvDTyaPc1WL4Tz0zzjCjCaWHzCJK+2Vzoo=;
        b=MuafDHqrGbIF3ps8XNfxzSsQ+YqW0BXPS6+RspoC16f0OIqQzro7fMuVM1ao0rJcpZ
         msxFmOHmZptS8qH6sCna9mQTaGBpkOXWcfg6d6Myu3+BEASOpz8YFAp63eo24a+Rcp7t
         xKWl/ADdzOXrdh+7nIPWPac6X5NnP3pa4+3VELDw0NspZQbcIrwEyo05l1ykZO30xUQz
         j2pN7fX44yM9jnFSH1IX+sQYZw1xO1Eqc+jdrHDAEDxUVzn5NwNhoMv+1Cua1Y9vgZwz
         kR+chwhiAmpzADsYumOQoQ1keietEogmDtdmJvcBY4NvT2HULY/M55JrnrJz322sUfPX
         NYkg==
X-Gm-Message-State: ACrzQf1IGfOb4W81LjY5IooJPfxf6JzhuCDlqSVV8CCV1+MoFBHXVVqw
        9MbPXzC9DCzOdpzSP45YztIen5nUMj6ZbWAlWf3fSJqU
X-Google-Smtp-Source: AMsMyM7r3HJ5O92gFL526xaZnUTpkubOISyClWr1mhLE5WJaKeYwIEIkhgko+1XnhgrL3rdTmFFXUB8lzWuUl5/CNDk=
X-Received: by 2002:a17:907:7b94:b0:731:1b11:c241 with SMTP id
 ne20-20020a1709077b9400b007311b11c241mr8621911ejc.676.1665247216429; Sat, 08
 Oct 2022 09:40:16 -0700 (PDT)
MIME-Version: 1.0
References: <ca0c97ae-6fd5-290b-6a00-fe3fe2e87aeb@huaweicloud.com>
 <20220927011949.sxxkyhjiig7wg7kv@macbook-pro-4.dhcp.thefacebook.com>
 <3c7cf1a8-16f2-5876-ff92-add6fd795caf@huaweicloud.com> <CAADnVQL_fMx3P24wzw2LMON-SqYgRKYziUHg6+mYH0i6kpvJcA@mail.gmail.com>
 <2d9c2c06-af12-6ad1-93ef-454049727e78@huaweicloud.com> <CAADnVQLWQcjYypR2+6UxhKrLOnpRQtB3PZ0=xOtjGpkEhWbH3g@mail.gmail.com>
 <2dda66a7-40f5-e595-48cf-b8588c70197a@huaweicloud.com> <CAADnVQKpNn47=2VCNK0BWVR23iwA_S3o3gW4WGuNRgLNzFLXog@mail.gmail.com>
 <73d338d2-7030-e21a-409d-41e92d907a4f@huaweicloud.com> <CAADnVQKZQ+uBOjWkZ2k-cqHWujFsUKoP_ZHNnuo+vb8XpUoYjA@mail.gmail.com>
 <20221008132244.GL4196@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221008132244.GL4196@paulmck-ThinkPad-P17-Gen-1>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 8 Oct 2022 09:40:04 -0700
Message-ID: <CAADnVQLuo+aJ0ke5M3Oz6+B=VtFfD2Qr_9c6KDjfEwHUMsx58w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 00/13] Add support for qp-trie with dynptr key
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Hou Tao <houtao@huaweicloud.com>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
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

On Sat, Oct 8, 2022 at 6:22 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Fri, Oct 07, 2022 at 06:59:08PM -0700, Alexei Starovoitov wrote:
> > On Fri, Oct 7, 2022 at 6:56 PM Hou Tao <houtao@huaweicloud.com> wrote:
> > >
> > > Hi,
> > >
> > > On 9/29/2022 11:22 AM, Alexei Starovoitov wrote:
> > > > On Wed, Sep 28, 2022 at 1:46 AM Hou Tao <houtao@huaweicloud.com> wrote:
> > > >> Hi,
> > > >>
> > > >> On 9/28/2022 9:08 AM, Alexei Starovoitov wrote:
> > > >>> On Tue, Sep 27, 2022 at 7:08 AM Hou Tao <houtao@huaweicloud.com> wrote:
> > > >>>
> > > >>> Looks like the perf is lost on atomic_inc/dec.
> > > >>> Try a partial revert of mem_alloc.
> > > >>> In particular to make sure
> > > >>> commit 0fd7c5d43339 ("bpf: Optimize call_rcu in non-preallocated hash map.")
> > > >>> is reverted and call_rcu is in place,
> > > >>> but percpu counter optimization is still there.
> > > >>> Also please use 'map_perf_test 4'.
> > > >>> I doubt 1000 vs 10240 will make a difference, but still.
> > > >>>
> > > >> I have tried the following two setups:
> > > >> (1) Don't use bpf_mem_alloc in hash-map and use per-cpu counter in hash-map
> > > >> # Samples: 1M of event 'cycles:ppp'
> > > >> # Event count (approx.): 1041345723234
> > > >> #
> > > >> # Overhead  Command          Shared Object                                Symbol
> > > >> # ........  ...............  ...........................................
> > > >> ...............................................
> > > >> #
> > > >>     10.36%  map_perf_test    [kernel.vmlinux]                             [k]
> > > >> bpf_map_get_memcg.isra.0
> > > > That is per-cpu counter and it's consuming 10% ?!
> > > > Something is really odd in your setup.
> > > > A lot of debug configs?
> > > Sorry for the late reply. Just back to work from a long vacation.
> > >
> > > My local .config is derived from Fedora distribution. It indeed has some DEBUG
> > > related configs. Will turn these configs off to check it again :)
> > > >>      9.82%  map_perf_test    [kernel.vmlinux]                             [k]
> > > >> bpf_map_kmalloc_node
> > > >>      4.24%  map_perf_test    [kernel.vmlinux]                             [k]
> > > >> check_preemption_disabled
> > > > clearly debug build.
> > > > Please use production build.
> > > check_preemption_disabled is due to CONFIG_DEBUG_PREEMPT. And it is enabled on
> > > Fedora distribution.
> > > >>      2.86%  map_perf_test    [kernel.vmlinux]                             [k]
> > > >> htab_map_update_elem
> > > >>      2.80%  map_perf_test    [kernel.vmlinux]                             [k]
> > > >> __kmalloc_node
> > > >>      2.72%  map_perf_test    [kernel.vmlinux]                             [k]
> > > >> htab_map_delete_elem
> > > >>      2.30%  map_perf_test    [kernel.vmlinux]                             [k]
> > > >> memcg_slab_post_alloc_hook
> > > >>      2.21%  map_perf_test    [kernel.vmlinux]                             [k]
> > > >> entry_SYSCALL_64
> > > >>      2.17%  map_perf_test    [kernel.vmlinux]                             [k]
> > > >> syscall_exit_to_user_mode
> > > >>      2.12%  map_perf_test    [kernel.vmlinux]                             [k] jhash
> > > >>      2.11%  map_perf_test    [kernel.vmlinux]                             [k]
> > > >> syscall_return_via_sysret
> > > >>      2.05%  map_perf_test    [kernel.vmlinux]                             [k]
> > > >> alloc_htab_elem
> > > >>      1.94%  map_perf_test    [kernel.vmlinux]                             [k]
> > > >> _raw_spin_lock_irqsave
> > > >>      1.92%  map_perf_test    [kernel.vmlinux]                             [k]
> > > >> preempt_count_add
> > > >>      1.92%  map_perf_test    [kernel.vmlinux]                             [k]
> > > >> preempt_count_sub
> > > >>      1.87%  map_perf_test    [kernel.vmlinux]                             [k]
> > > >> call_rcu
> > > SNIP
> > > >> Maybe add a not-immediate-reuse flag support to bpf_mem_alloc is reason. What do
> > > >> you think ?
> > > > We've discussed it twice already. It's not an option due to OOM
> > > > and performance considerations.
> > > > call_rcu doesn't scale to millions a second.
> > > Understand. I was just trying to understand the exact performance overhead of
> > > call_rcu(). If the overhead of map operations are much greater than the overhead
> > > of call_rcu(), I think calling call_rcu() one millions a second will be not a
> > > problem and  it also makes the implementation of qp-trie being much simpler. The
> > > OOM problem is indeed a problem, although it is also possible for the current
> > > implementation, so I will try to implement the lookup procedure which handles
> > > the reuse problem.
> >
> > call_rcu is not just that particular function.
> > It's all the work rcu subsystem needs to do to observe gp
> > and execute that callback. Just see how many kthreads it will
> > start when overloaded like this.
>
> The kthreads to watch include rcu_preempt, rcu_sched, ksoftirqd*, rcuc*,
> and rcuo*.  There is also the back-of-interrupt softirq context, which
> requires some care to measure accurately.
>
> The possibility of SLAB_TYPESAFE_BY_RCU has been discussed.  I take it
> that the per-element locking overhead for exact iterations was a problem?
> If so, what exactly are the consistency rules for iteration?  Presumably
> stronger than "if the element existed throughout, it is included in the
> iteration; if it did not exist throughout, it is not included; otherwise
> it might or might not be included" given that you get that for free.
>
> Either way, could you please tell me the exact iteration rules?

The rules are the way we make them to be.
iteration will be under lock.
lookup needs to be correct. It can retry if necessary (like htab is doing).
Randomly returning 'noexist' is, of course, not acceptable.

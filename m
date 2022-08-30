Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B215A5903
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 03:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiH3BvW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 21:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiH3BvU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 21:51:20 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8468BA6C3B
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 18:51:18 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bu22so11930866wrb.3
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 18:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Q05G2zuncPpN5tmYJ7jQG6d9qUvvJiUejd0roDcqj9E=;
        b=tGK6VqsYBvmH9ycBcWO3t19n1kN5o7R6OtufsNYS+w5914lw3Hg2S+SaONPfMz+Wnu
         157LkgyFDSvMI1WBIoeZ6yw29Sk7Cy/3ks74pnhx2aABrV1SYr9wr0LJtZ8J+Rff+qwA
         /JhXcOv3L930UF3Hoa15NUIzWJ4OKhF8EYaOjbt0gmYvH6pJzJ/ieEMqarhFxbXeQ8zQ
         s3uPCzIVpfknRBIKEA798acz/vRRqaz0HamIW5VmS9lYEY3vt8nPwuyAlG1kSr16lC9P
         1NcyoS1H3VRmKyHBWqqQ0iDhy3WSRlZ9sEE5pmFYj5FzvXpP/G74phCUbK5yMVkBtk1f
         XusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Q05G2zuncPpN5tmYJ7jQG6d9qUvvJiUejd0roDcqj9E=;
        b=sQeprdEEewLFxBbB1blIQIqePsNTZ0M6eIqlZ+i32ggup/VfYO6yliuTrqzP3w8YAK
         Dh7+t/L1xnZONSDWEqWzOeInEAQ9eN/zJ733oF5bH3Y16UVVLV/tzXWXg/VpxqxqGuO9
         /UrsVXDDMfwSphKH4KraLw0gWRDruNqo+UVWqiktPBWNS25df3e9KN42ZK1HSO4FQSJI
         otwX2QAU9L4XSsyLftf5tWGartUI+BFyzhKYAK4P/TFZvggcVeUJbyejgemAVRAkPDgP
         EUgkRtdbcB9SzOvdngDGpDYrkwo0RbTxW1UCRP6Vd28egIn5S9hV62xYl8ObH92eOH2i
         hV0Q==
X-Gm-Message-State: ACgBeo18V8nqNkICpfQfU3+BQFf2vkI4nez+2HGo1ls2MG3Bg/C9Q5DD
        FyqHqk1d0alcY6GoZhvJPQjg8BMubwqk1RutTW1GaA==
X-Google-Smtp-Source: AA6agR5mXJrEV26XyK5LWMzqktTezuEYvByr6z1rzvf5kOhfA/GgHQlLShc9Oct06+8XRM37AJOQBV0ySnXwbNBjqjk=
X-Received: by 2002:a5d:6609:0:b0:226:ced9:be58 with SMTP id
 n9-20020a5d6609000000b00226ced9be58mr7252461wru.80.1661824276689; Mon, 29 Aug
 2022 18:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220826230639.1249436-1-yosryahmed@google.com>
 <CA+khW7iN6hyyBBR+4ey+9pNmEyKPZS82-C9kZ2NRXKMEOXHrng@mail.gmail.com>
 <CAJD7tkYKYv+SKhCJs2281==55sALTX_DXifaWPv1w5=xrJjqQA@mail.gmail.com>
 <CAJD7tkZg2jzDDR6vn5=-TS93Tm3P-YEQ+06KDsjg=Mzkt5LqsA@mail.gmail.com> <CA+khW7g-jeiXMM-K+KK7L3tzG0catFSM+x5vHKMs=PF=s+=Pag@mail.gmail.com>
In-Reply-To: <CA+khW7g-jeiXMM-K+KK7L3tzG0catFSM+x5vHKMs=PF=s+=Pag@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 29 Aug 2022 18:50:40 -0700
Message-ID: <CAJD7tkZ77JDt62CMw2AmpvTJ5fpVs0mkPdVqMJm8X8zCBq=LhA@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: simplify cgroup_hierarchical_stats selftest
To:     Hao Luo <haoluo@google.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Mykola Lysenko <mykolal@fb.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 29, 2022 at 6:42 PM Hao Luo <haoluo@google.com> wrote:
>
> On Mon, Aug 29, 2022 at 6:07 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > On Mon, Aug 29, 2022 at 3:15 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > >
> > > On Mon, Aug 29, 2022 at 1:08 PM Hao Luo <haoluo@google.com> wrote:
> > > >
> > > > On Fri, Aug 26, 2022 at 4:06 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > > >
> [...]
> > > > >
> > > > > -SEC("tp_btf/mm_vmscan_memcg_reclaim_begin")
> > > > > -int BPF_PROG(vmscan_start, int order, gfp_t gfp_flags)
> > > > > +SEC("fentry/cgroup_attach_task")
> > > >
> > > > Can we select an attachpoint that is more stable? It seems
> > > > 'cgroup_attach_task' is an internal helper function in cgroup, and its
> > > > signature can change. I'd prefer using those commonly used tracepoints
> > > > and EXPORT'ed functions. IMHO their interfaces are more stable.
> > > >
> > >
> > > Will try to find a more stable attach point. Thanks!
> >
> > Hey Hao,
> >
> > I couldn't find any suitable stable attach points under kernel/cgroup.
> > Most tracepoints are created using TRACE_CGROUP_PATH which only
> > invokes the tracepoint if the trace event is enabled, which I assume
> > is not something we can rely on. Otherwise, there is only
>
> Can we explicitly enable the cgroup_attach_task event, just for this
> test? If it's not easy, I am fine with using fentry.

I see a couple of tests that read from /sys/kernel/debug/tracing, but
they are mostly reading event ids, I don't see any tests enabling or
disabling a tracing event, so I am not sure if that's an accepted
pattern. Also I am not sure if we can rely on tracefs being in that
path. Andrii, is this considered acceptable?

>
> > trace_cgroup_setup_root() and trace_cgroup_destroy_root() which are
> > irrelevant here. A lot of EXPORT'ed functions are not called in the
> > kernel, or cannot be invoked from userspace (the test) in a
> > straightforward way. Even if they did, future changes to such code
> > paths can also change in the future, so I don't think there is really
> > a way to guarantee that future changes don't break the test.
> >
> > Let me know what you think.
> >

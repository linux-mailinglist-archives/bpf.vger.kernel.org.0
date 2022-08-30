Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9885A58EB
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 03:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiH3BmW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 21:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiH3BmV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 21:42:21 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BE87C1AD
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 18:42:20 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id h21so7554179qta.3
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 18:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Eq9oJONfbFs62JvZq36/1G/FIjacqvpRKeOI8NE7X8k=;
        b=eAbv2OL7hkEcq5Z3tIN/d7+/cxgVZGR9/HYsvWxzevSti25E529r7+xZ9ZPit3bC8J
         iIcAcLv1DKBpwbmVUeW9VfZt6uGteDyRiTsQ2PIy2ANtrtocZY7JDc5NjmW26CsodMEq
         83+Y5hbLzjhcQzi5sWJTBi9k5fDxFAxHcRHO6HHETkb0TfHbS9/4KnXByQUXaXx602s9
         MgWdd9uf8QLyWou1ZU1SOYsbt0qlMR9P7PSM92/eus3c65vVPBEczNfpatLwYWOvbTAp
         b7HMK2b2DNu/PmoA74bpyMZoQV+Vgy+fLKyfMr0eTsZTbXLRwWDm9z2hXlhxO+zBMb2b
         dMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Eq9oJONfbFs62JvZq36/1G/FIjacqvpRKeOI8NE7X8k=;
        b=cPQVowVWQrkomy31LENhBjSSg2j/UKbn3sR62LMSEv3OvQsFMYch7Dj6wjZX7o18Uq
         OBODlvyspoiOvg6YBzAyoHVcR4IVUU+FQJq60HG76l9GsW2i/AmtpoOAbkQYh66Y5iod
         FxvNjxZNmto+FDO1ky0vWoh3EMtPehuJs/6mAKcokqortCdxqRRF+ndayJKFr//cEQGa
         YxtEjHhNEK2BjFipJnYnd1hoxDfNGItu6qDzqReWL4NGzipNxRmneFwukrInPtsKJ7tr
         Z7fwGSEwqfKOVCMREW5Z57Ocl6BE7DbDtSZjPZFrRTcqdNsIh6I0IemQx7YTJRXjyP0S
         EISA==
X-Gm-Message-State: ACgBeo0lvjGNyVbcqNWWWVRP9MVRC+ou09S/PjfAWoZVn2AapfI1tp+Z
        VVd55qcOMUWG/EnKU1PIMnl4Xeo35OiNIX4fevo9iQ==
X-Google-Smtp-Source: AA6agR4PlTAdeqC2iyJKsqEiHgULZROru/dhMmZdcJ+39zkNHfH8fJBcYiEkBw+PkneTzvyr+OurP/4A8B5LbF90GhY=
X-Received: by 2002:a05:622a:8a:b0:344:5611:7a8a with SMTP id
 o10-20020a05622a008a00b0034456117a8amr12806416qtw.565.1661823739602; Mon, 29
 Aug 2022 18:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220826230639.1249436-1-yosryahmed@google.com>
 <CA+khW7iN6hyyBBR+4ey+9pNmEyKPZS82-C9kZ2NRXKMEOXHrng@mail.gmail.com>
 <CAJD7tkYKYv+SKhCJs2281==55sALTX_DXifaWPv1w5=xrJjqQA@mail.gmail.com> <CAJD7tkZg2jzDDR6vn5=-TS93Tm3P-YEQ+06KDsjg=Mzkt5LqsA@mail.gmail.com>
In-Reply-To: <CAJD7tkZg2jzDDR6vn5=-TS93Tm3P-YEQ+06KDsjg=Mzkt5LqsA@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 29 Aug 2022 18:42:08 -0700
Message-ID: <CA+khW7g-jeiXMM-K+KK7L3tzG0catFSM+x5vHKMs=PF=s+=Pag@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: simplify cgroup_hierarchical_stats selftest
To:     Yosry Ahmed <yosryahmed@google.com>
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

On Mon, Aug 29, 2022 at 6:07 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> On Mon, Aug 29, 2022 at 3:15 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > On Mon, Aug 29, 2022 at 1:08 PM Hao Luo <haoluo@google.com> wrote:
> > >
> > > On Fri, Aug 26, 2022 at 4:06 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > >
[...]
> > > >
> > > > -SEC("tp_btf/mm_vmscan_memcg_reclaim_begin")
> > > > -int BPF_PROG(vmscan_start, int order, gfp_t gfp_flags)
> > > > +SEC("fentry/cgroup_attach_task")
> > >
> > > Can we select an attachpoint that is more stable? It seems
> > > 'cgroup_attach_task' is an internal helper function in cgroup, and its
> > > signature can change. I'd prefer using those commonly used tracepoints
> > > and EXPORT'ed functions. IMHO their interfaces are more stable.
> > >
> >
> > Will try to find a more stable attach point. Thanks!
>
> Hey Hao,
>
> I couldn't find any suitable stable attach points under kernel/cgroup.
> Most tracepoints are created using TRACE_CGROUP_PATH which only
> invokes the tracepoint if the trace event is enabled, which I assume
> is not something we can rely on. Otherwise, there is only

Can we explicitly enable the cgroup_attach_task event, just for this
test? If it's not easy, I am fine with using fentry.

> trace_cgroup_setup_root() and trace_cgroup_destroy_root() which are
> irrelevant here. A lot of EXPORT'ed functions are not called in the
> kernel, or cannot be invoked from userspace (the test) in a
> straightforward way. Even if they did, future changes to such code
> paths can also change in the future, so I don't think there is really
> a way to guarantee that future changes don't break the test.
>
> Let me know what you think.
>

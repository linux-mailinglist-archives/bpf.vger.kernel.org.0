Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB77B5AF6E5
	for <lists+bpf@lfdr.de>; Tue,  6 Sep 2022 23:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiIFVfz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 17:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiIFVfy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 17:35:54 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A63B9E113
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 14:35:53 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id m17-20020a7bce11000000b003a5bedec07bso10464973wmc.0
        for <bpf@vger.kernel.org>; Tue, 06 Sep 2022 14:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=sR4MT10eKHhIVG2U6bD+uIMSzEVSnVDpJcLJ+SBSU/s=;
        b=cxvtWAjBYoEpUJxSiWS7AfLsCwWfpK9imxeDR5nZIU4ZjuYzLiAFHS0+9TzGEeojwQ
         mWIG427aEoJvB6gsed1m7r4hK7snMG+QKCME1m2v3wBIncorbHbPcEPVvEtJ/3VRdXP+
         QJJy7gT0s7piwIcKO7SGxr8TJJpEwFwDaQLv66iclbQaRsjgT2mkhOKrhjVD0QE9ZSyb
         YYTRrktm6/WG2mvL3CtFmF+0JzFAwT2GZP0kEeysbF4u90L5GIwES8KzvTEt84EhdoHu
         gNXtGIGoY0XT4UXgnwNRy1blbH52lZSoBol+rjZJR2r+EXzuOs2LvRQc26To5kkCqeED
         9asw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=sR4MT10eKHhIVG2U6bD+uIMSzEVSnVDpJcLJ+SBSU/s=;
        b=SrPSzVeDLsr2dbJCN8LXOkOQLS4AcNc7TWqu0wb7pz78BNrmvmVnxsQYJ7GtIIqxM4
         ixlLwGiZS/5E6Bn6GVnB8zRQ4RBF/fPrcH5mw/A35D++Gnc7kuVbI2m/6Ps7NR65fiZu
         IWXOMGtItfldrYGcqigVEx52izLpJkNL6fDNHJyfeF5ZsB0i1zNOeU9yi8N//ffwrvlN
         V5JpMQuIwHuQ/MsBHuq5zTG8aSS3h4GsD121RWG1PNfZU+YpXjyrcn0AjeXx0W8h2L+5
         5N2XVKJlBd7n2Lr/cY32qE2ektGFfSZOmlaSjF6HWK1lICGvDXrpbCfcWNjhejWKuljE
         XFwg==
X-Gm-Message-State: ACgBeo3DIoRgaC3NYlCWlBh84zsXcMcD09SP8kyaTz3WTgvKsFhbVejK
        LEtrrl9tfjtsommTR9WYU6E24zBR9cFL14jHlCThlQ==
X-Google-Smtp-Source: AA6agR4MXJa4fD8c9dto8Q/b/Ndb9B4dxTB/k0UBO0uHkojX2yRN4+4P8O1AicE75lbXkISbrKXhEhntE+5vsYia2mo=
X-Received: by 2002:a1c:3b04:0:b0:3a5:487c:6240 with SMTP id
 i4-20020a1c3b04000000b003a5487c6240mr14808609wma.152.1662500151465; Tue, 06
 Sep 2022 14:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220826230639.1249436-1-yosryahmed@google.com>
 <CA+khW7iN6hyyBBR+4ey+9pNmEyKPZS82-C9kZ2NRXKMEOXHrng@mail.gmail.com>
 <CAJD7tkYKYv+SKhCJs2281==55sALTX_DXifaWPv1w5=xrJjqQA@mail.gmail.com>
 <CAJD7tkZg2jzDDR6vn5=-TS93Tm3P-YEQ+06KDsjg=Mzkt5LqsA@mail.gmail.com>
 <CA+khW7g-jeiXMM-K+KK7L3tzG0catFSM+x5vHKMs=PF=s+=Pag@mail.gmail.com> <CAJD7tkZ77JDt62CMw2AmpvTJ5fpVs0mkPdVqMJm8X8zCBq=LhA@mail.gmail.com>
In-Reply-To: <CAJD7tkZ77JDt62CMw2AmpvTJ5fpVs0mkPdVqMJm8X8zCBq=LhA@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 6 Sep 2022 14:35:15 -0700
Message-ID: <CAJD7tkZz52GkTr+TuZnArEOsyxxMPnE5A1AKZfY-gjx0tUW6dQ@mail.gmail.com>
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

On Mon, Aug 29, 2022 at 6:50 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> On Mon, Aug 29, 2022 at 6:42 PM Hao Luo <haoluo@google.com> wrote:
> >
> > On Mon, Aug 29, 2022 at 6:07 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > >
> > > On Mon, Aug 29, 2022 at 3:15 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > >
> > > > On Mon, Aug 29, 2022 at 1:08 PM Hao Luo <haoluo@google.com> wrote:
> > > > >
> > > > > On Fri, Aug 26, 2022 at 4:06 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > > > >
> > [...]
> > > > > >
> > > > > > -SEC("tp_btf/mm_vmscan_memcg_reclaim_begin")
> > > > > > -int BPF_PROG(vmscan_start, int order, gfp_t gfp_flags)
> > > > > > +SEC("fentry/cgroup_attach_task")
> > > > >
> > > > > Can we select an attachpoint that is more stable? It seems
> > > > > 'cgroup_attach_task' is an internal helper function in cgroup, and its
> > > > > signature can change. I'd prefer using those commonly used tracepoints
> > > > > and EXPORT'ed functions. IMHO their interfaces are more stable.
> > > > >
> > > >
> > > > Will try to find a more stable attach point. Thanks!
> > >
> > > Hey Hao,
> > >
> > > I couldn't find any suitable stable attach points under kernel/cgroup.
> > > Most tracepoints are created using TRACE_CGROUP_PATH which only
> > > invokes the tracepoint if the trace event is enabled, which I assume
> > > is not something we can rely on. Otherwise, there is only
> >
> > Can we explicitly enable the cgroup_attach_task event, just for this
> > test? If it's not easy, I am fine with using fentry.
>
> I see a couple of tests that read from /sys/kernel/debug/tracing, but
> they are mostly reading event ids, I don't see any tests enabling or
> disabling a tracing event, so I am not sure if that's an accepted
> pattern. Also I am not sure if we can rely on tracefs being in that
> path. Andrii, is this considered acceptable?
>

Anyone with thoughts here? Is it acceptable to explicitly enable a
trace event in a BPF selftest to attach to a tracepoint that is only
invoked if the trace event is enabled (e.g. cgroup_attach_task) ?
Otherwise the test program would attach to the fentry of an internal
function, which is more vulnerable to being changed and breaking the
test (until someone updates the test with the new signature).

> >
> > > trace_cgroup_setup_root() and trace_cgroup_destroy_root() which are
> > > irrelevant here. A lot of EXPORT'ed functions are not called in the
> > > kernel, or cannot be invoked from userspace (the test) in a
> > > straightforward way. Even if they did, future changes to such code
> > > paths can also change in the future, so I don't think there is really
> > > a way to guarantee that future changes don't break the test.
> > >
> > > Let me know what you think.
> > >

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B13F4E9123
	for <lists+bpf@lfdr.de>; Mon, 28 Mar 2022 11:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239756AbiC1JY0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Mar 2022 05:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239309AbiC1JY0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Mar 2022 05:24:26 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCD09FE9
        for <bpf@vger.kernel.org>; Mon, 28 Mar 2022 02:22:43 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o3-20020a17090a3d4300b001c6bc749227so14872881pjf.1
        for <bpf@vger.kernel.org>; Mon, 28 Mar 2022 02:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tH6vHR9kCH+NPukJnjAaBd+mpjJ8sCuBLDfcwcVYg4I=;
        b=Gomwsgqcc5G4y4sCHxDYeBsL0kU62rY/xNhOxwhAcqftO8/kCgQ5J57BFSIgnhQiGf
         ubMotdKqupuh5Hzae+8D7+mnC+/IdK+hfC8qgCZkggge0kLvPM9ebDt8Yj22oguNZdQ9
         N6xNkTeXk0uFjLWtc7v8+UVuym6t96OzehARRawtd4H8hmQ9ctBNvjcgJc1T7hFlOLGC
         CMWEVKiehCtlseLN/+E+Hf3/4U+ho3QOgIdFR03zUb757cTkMPVui+WdgyVO1UL+mugy
         jRue3rN1i5bcrnohe8NFKWShUw9VGbbEJcuJSdOwfi250k4QUQsJXeWf/WJYwWg9vb8/
         j1bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tH6vHR9kCH+NPukJnjAaBd+mpjJ8sCuBLDfcwcVYg4I=;
        b=5CfwEIl5YOzadHx9P5/8M8wAEWPLRGsJMoPKp0pFQoISafPU224XYbX/KsUNvBSMRQ
         k/XQaTC5EPiUWMPUQmNB3ElNKyC4wGsjtzRFEryz8VW1hRU474S53Fi+Yiu6qmpq7HIv
         oxFDswLUiEcPKmFZs1nC50nq9kU7jLZK8LwsLcF7khSjnCqELpRr4RN9y0TBdsJ7V1Qo
         Yt49OwTjvAX2MfCm+nVoDlUzLGCS08DiKhxvJXGY9k9EvIc5puJwmnLQB3nLWWbRtin9
         Ewzp7sFfNFnba5KAL2+PCQsgZ8G5GhxIvcYxy3n5ngGlJxQwZBJHk0LKH05N19JV3K4i
         Sd3A==
X-Gm-Message-State: AOAM532VaVqZBSyC2IaPnZSpKsPPwA24zZTSSbdWeD01/pH+f5V2nAzp
        aQVhA+zAWPwfrPDmj6XV77ObhYyPlFIgf4T2lWD8gA==
X-Google-Smtp-Source: ABdhPJxWUfGIn8epdRIti+VLoKKHJZ2mD8kQKlwwmj143rS8qojVUag82QRaAB0zL9zm9z1GZWz4dgUUB+ZXX5hJLV4=
X-Received: by 2002:a17:902:b902:b0:154:bb05:ddb9 with SMTP id
 bf2-20020a170902b90200b00154bb05ddb9mr25759949plb.14.1648459362481; Mon, 28
 Mar 2022 02:22:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkbQNpeX8MGw9dXa5gi6am=VNXwgwUoTd6+K=foixEm1fw@mail.gmail.com>
 <Yi7ULpR70HatVP/8@slm.duckdns.org> <CAJD7tkYGUaeeFMJSWNbdgaoEq=kFTkZzx8Jy1fwWBvt2WEfqAA@mail.gmail.com>
 <f049c2f6-499b-ff7a-3910-38487878606a@fb.com>
In-Reply-To: <f049c2f6-499b-ff7a-3910-38487878606a@fb.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 28 Mar 2022 02:22:06 -0700
Message-ID: <CAJD7tkYK7A1Vn+LRo9xZA+K7BuRmWeUyLX6XE-g-MBf8myLn6Q@mail.gmail.com>
Subject: Re: [RFC bpf-next] Hierarchical Cgroup Stats Collection Using BPF
To:     Yonghong Song <yhs@fb.com>
Cc:     Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        David Rientjes <rientjes@google.com>,
        bpf <bpf@vger.kernel.org>, KP Singh <kpsingh@kernel.org>,
        cgroups@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 22, 2022 at 11:09 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 3/16/22 9:35 AM, Yosry Ahmed wrote:
> > Hi Tejun,
> >
> > Thanks for taking the time to read my proposal! Sorry for the late
> > reply. This email skipped my inbox for some reason.
> >
> > On Sun, Mar 13, 2022 at 10:35 PM Tejun Heo <tj@kernel.org> wrote:
> >>
> >> Hello,
> >>
> >> On Wed, Mar 09, 2022 at 12:27:15PM -0800, Yosry Ahmed wrote:
> >> ...
> >>> These problems are already addressed by the rstat aggregation
> >>> mechanism in the kernel, which is primarily used for memcg stats. We
> >>
> >> Not that it matters all that much but I don't think the above statement is
> >> true given that sched stats are an integrated part of the rstat
> >> implementation and io was converted before memcg.
> >>
> >
> > Excuse my ignorance, I am new to kernel development. I only saw calls
> > to cgroup_rstat_updated() in memcg and io and assumed they were the
> > only users. Now I found cpu_account_cputime() :)
> >
> >>> - For every cgroup, we will either use flags to distinguish BPF stats
> >>> updates from normal stats updates, or flush both anyway (memcg stats
> >>> are periodically flushed anyway).
> >>
> >> I'd just keep them together. Usually most activities tend to happen
> >> together, so it's cheaper to aggregate all of them in one go in most cases.
> >
> > This makes sense to me, thanks.
> >
> >>
> >>> - Provide flags to enable/disable using per-cpu arrays (for stats that
> >>> are not updated frequently), and enable/disable hierarchical
> >>> aggregation (for non-hierarchical stats, they can still make benefit
> >>> of the automatic entries creation & deletion).
> >>> - Provide different hierarchical aggregation operations : SUM, MAX, MIN, etc.
> >>> - Instead of an array as the map value, use a struct, and let the user
> >>> provide an aggregator function in the form of a BPF program.
> >>
> >> I'm more partial to the last option. It does make the usage a bit more
> >> compilcated but hopefully it shouldn't be too bad with good examples.
> >>
> >> I don't have strong opinions on the bpf side of things but it'd be great to
> >> be able to use rstat from bpf.
> >
> > It indeed gives more flexibility but is more complicated. Also, I am
> > not sure about the overhead to make calls to BPF programs in every
> > aggregation step. Looking forward to get feedback on the bpf side of
> > things.
>
> Hi, Yosry, I heard this was discussed in bpf office hour which I
> didn't attend. Could you summarize the conclusion and what is the
> step forward? We also have an internal tool which collects cgroup
> stats and this might help us as well. Thanks!
>
> >
> >>
> >> Thanks.
> >>
> >> --
> >> tejun

Hi Yonghong,

Hao has already done an excellent job summarizing the outcome of the meeting.

The idea I have is basically to introduce "rstat flushing" BPF
programs. BPF programs that collect and display stats would use
helpers to call cgroup_rstat_flush() and cgroup_rstat_updated() (or
similar). rstat would then make calls to the "rstat flushing" BPF
programs during flushes, similar to calls to css_rstat_flush().

I will work on an RFC patch(es) for this soon. Let me know if you have
any comments/suggestions/feedback.

Thanks!

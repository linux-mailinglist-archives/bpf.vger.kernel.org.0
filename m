Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FCC57A765
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 21:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239653AbiGSTry (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 15:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGSTrx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 15:47:53 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8E8491DC
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 12:47:52 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id w188so14271051vsb.6
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 12:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nboYEa7rJCR7CNGdTDaXIoV9fIPi91CmCuY7BiHHgHo=;
        b=BAfyUT9RiCWibO94CefV3FwsBy1jICTyq07/tU+6Vx39pg3dFWlCq5ndJXgr+QF7eK
         ORoA+nYLgOBFYUsVMWu4iDcR9dgc6EtHuBG7x+gOayvA4Ror3Wk3H5fdgmdY712uJ9UJ
         H8Lma3pfF6Ntl18zGZgo8KhM3nQXOd2S4M2OBlfc0XvXVQaXs0kYyEa3D5jkdLK3xNwc
         5reXSMBGQjTc7UBTblY2e9OgqlV84PhnpO/hPLmMYD5Lus10MLjEDB6C6p2NJFUqQNOM
         o+C2oRwbs4fwJnylPoBNxJjQYq1CqZlSdE9DKyQQkGLp65vdJ8xR/0MT+z9fK5YLWKHI
         dRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nboYEa7rJCR7CNGdTDaXIoV9fIPi91CmCuY7BiHHgHo=;
        b=iafSJNicGTWHo//LF592hQ/TXVk0bx36NK44VQieYtwN2cm4p47LWXgxhYdzQuJAY2
         S68+A8OKHXAeAQ+APkdeSxl+ahWMTMi58iPBrSkRTXeJe2Wrw10Lcskxnu/riV7qt13M
         k7j1mBS0D+YXSVws5MM5K4jZ3k148zr4NvvFtXkbPJSqqmIRfEtkekyxfXctnX4MneB4
         Za7QUhGjgSog8lkNoFVvx7vi7sYCNpu0B5kp1NOyN49viutK2q2dxVlXtzW/dyxhQgvK
         jiPNX/rWUalcIauFt9hzbesmQGCDVJxCWOBwUXrWExBBV1vDf2pP6n0Tw/ZT9H7yqNOR
         s17A==
X-Gm-Message-State: AJIora8gD4nyS/w0BqIFelFsa+reQanahUofpDeznDQQ8SkDwbscC8sd
        lNEq2W0f0rHsUT1kboaX3mYGcepuieFjoIptwOKZ1g==
X-Google-Smtp-Source: AGRyM1uk/F30eIWrOe+KR3j7evKm1u8f1CIe/rrQaFGwkhYiXPVA41KSu5BCM3I19yu9N8Vu7znxwHsI+IGLnuYctfM=
X-Received: by 2002:a05:6102:30a4:b0:357:ae78:c415 with SMTP id
 y4-20020a05610230a400b00357ae78c415mr6961650vsd.72.1658260071710; Tue, 19 Jul
 2022 12:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <Ys0lXfWKtwYlVrzK@dhcp22.suse.cz> <CALOAHbAhzNTkT9o_-PRX=n4vNjKhEK_09+-7gijrFgGjNH7iRA@mail.gmail.com>
 <Ys1ES+CygtnUvArz@dhcp22.suse.cz> <Ys4wRqCWrV1WeeWp@castle>
 <CAJD7tkb0OcVbUMxsEH-QyF08OabK5pQ-8RxW_Apy1HaHQtN0VQ@mail.gmail.com>
 <YtaV6byXRFB6QG6t@dhcp22.suse.cz> <CAJD7tkbieq_vDxwnkk_jTYz9Fe1t5AMY6b3Q=8O-ag9YLo9uZg@mail.gmail.com>
 <CAHS8izP-Ao7pYgHOuQ-8oE2f_xe1+tP6TQivDYovEOt+=_QC7Q@mail.gmail.com>
 <YtcDEpaHniDeN7fP@slm.duckdns.org> <CAJD7tkZkFnVqjkdOK3Wf8f1o3XmMWCmWkzHNQKh8Znh5dDF27w@mail.gmail.com>
 <YtcIJClKxUPntdM9@slm.duckdns.org>
In-Reply-To: <YtcIJClKxUPntdM9@slm.duckdns.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Tue, 19 Jul 2022 12:47:39 -0700
Message-ID: <CAHS8izOrGBLUGDAo0_7Y0_7y4+2BusFeqOMkxwbXUSvMTvTGDQ@mail.gmail.com>
Subject: Re: cgroup specific sticky resources (was: Re: [PATCH bpf-next 0/5]
 bpf: BPF specific memory allocator.)
To:     Tejun Heo <tj@kernel.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yafang Shao <laoar.shao@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        linux-mm <linux-mm@kvack.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
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

On Tue, Jul 19, 2022 at 12:38 PM Tejun Heo <tj@kernel.org> wrote:
>
> On Tue, Jul 19, 2022 at 12:30:17PM -0700, Yosry Ahmed wrote:
> > Is there a reason why these resources cannot be moved across cgroups
> > dynamically? The only scenario I imagine is if you already have tmpfs
> > mounted and files charged to different cgroups, but once you attribute
> > tmpfs to one cgroup.charge_for.tmpfs (or sticky,..), I assume that we
> > can dynamically move the resources, right?
> >
> > In fact, is there a reason why we can't move the tmpfs charges in that
> > scenario as well? When we move processes we loop their pages tables
> > and move pages and their stats, is there a reason why we wouldn't be
> > able to do this with tmpfs mounts or bpf maps as well?
>
> Nothing is impossible but nothing is free as well. Moving charges around
> traditionally caused a lot of headaches in the past and never became
> reliable. There are inherent trade-offs here. You can make things more
> dynamic usually by making hot paths more expensive or doing some
> synchronization dancing which tends to be pretty hairy. People generally
> don't wanna make hot paths slower, so we tend to end up with something
> twisted which unfortunately turns out to be a headache in the long term.
>
> In general, I'd rather keep resource associations as static as possible.
> It's okay if we do something neat inside the kernel but if we create
> userspace expectation that resources can be moved around dynamically, we'll
> be stuck with that for a long time likely forfeiting future simplification /
> optimization opportunities.
>
> So, that's gonna be a fairly strong nack from my end.
>

Hmm, sorry I might be missing something but I don't think we have the
same thing in mind?

My understanding is that the sysadmin can do something like this which
is relatively inexpensive to implement in the kernel:


mount -t tmpfs /mnt/mymountpoint
echo "/mnt/mymountpoint" > /path/to/cgroup/cgroup.charge_for.tmpfs


At that point all tmpfs charges for this tmpfs are directed to
/path/to/cgroup/memory.current.

Then the sysadmin can do something like:


echo "/mnt/mymountpoint" > /path/to/cgroup2/cgroup.charge_for.tmpfs


At that point all _future_ charges of that tmpfs will go to
cgroup2/memory.current. All existing charges remain at
cgroup/memory.current and get uncharged from there. Per my
understanding there is no need to move all the _existing_ charges from
cgroup/memory.current to cgroup2/memory.current.

Sorry, I don't mean to be insistent, just wanted to make sure we have
the same thing in mind. Speaking for ourselves we have a very similar
implementation locally and is perfectly usable (and in fact addresses
a number of pain points related to shared memory charging) without
dynamically moving existing charges on reassignment (the second echo
in my example).

> Thanks.

>
> --
> tejun

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9EA57A73B
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 21:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237282AbiGSTa4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 15:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbiGSTaz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 15:30:55 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCE92B27A
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 12:30:55 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id a11so3428066wmq.3
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 12:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IU/UXeFEVBdT1Z9tBh2cA7PGhMoCQZDbnozYynktpP8=;
        b=nw5j6HumBAcfcV3dNUP0PTt7kVt+ZtNphEeY5aExb+lSJXjTe1tBUjDCnM6u4T4p8C
         tDSjP1pnh4VSKEZMyPB8IgpGLyolm+FfhNCwxdulwNgTqerwQKo1d1+CzJQ3a9CNey3z
         c3diealW+YLikremcGB+mD4mvw+wd9pSgFuVGnSFWh22KHENKNLlZ/lMqt+ZVzItx789
         rdrNHsYwRb38YHUCaSNYxKaAD0DJeegExDhOvy5qiJdrwmVTY5JbF2VHxpYOZaq6VIlO
         ZRBYzS7HB0WasRQtQJUxmbkKNh/aaAbps61QqK8px3oHokdz7tadmI14LTzvLYMRcV2d
         /X3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IU/UXeFEVBdT1Z9tBh2cA7PGhMoCQZDbnozYynktpP8=;
        b=pY3zaroyPrZoJh4rIdxFidDbhpmKCEbOwyyI8zAiQIx6zM82qtfkcn8QygSJuvjJim
         HhD5MC2rwKqtruBydeB8BaWONrSyZmi8OatcDaxlzLVhydCmnO1Aa2OkETS6D1V1idM1
         yaeyYUf6bZ+Esket0xhoR11TcavZ/m1YaG0i66lgJxRS2OiJomPizZbevYez151qvLB9
         PWBEjjnVkx7c7J9drxW9ejbzo6JmfVXuyYo+KFMscLqswnyEWhKzxmC5U2t007nMNcrG
         e4TxCWamfpy7EtL/W2T0GffrhyvXRi/Pc55BS0xygTREAwAybq1R9QwSN0w7P7odWNq1
         6PDQ==
X-Gm-Message-State: AJIora+2vYHQ+iGUjuSD8qjicEAH83YVEw7glSFzl5SKAln7QbnjMKWj
        aIaialHCJctas0voUhBBj4fB/GIf5we+3Ndfgdgpog==
X-Google-Smtp-Source: AGRyM1t+urgwgqhfDqApEhoJzupTlWCjtPAtECd+qIo2VZ0WxF+HWQ6yvgLlyiTk/ABdUHbvJiAhAifSHYi9wB6FV6I=
X-Received: by 2002:a05:600c:1e8e:b0:3a2:c1b4:922c with SMTP id
 be14-20020a05600c1e8e00b003a2c1b4922cmr745201wmb.24.1658259053522; Tue, 19
 Jul 2022 12:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <YswUS/5nbYb8nt6d@dhcp22.suse.cz> <20220712043914.pxmbm7vockuvpmmh@macbook-pro-3.dhcp.thefacebook.com>
 <Ys0lXfWKtwYlVrzK@dhcp22.suse.cz> <CALOAHbAhzNTkT9o_-PRX=n4vNjKhEK_09+-7gijrFgGjNH7iRA@mail.gmail.com>
 <Ys1ES+CygtnUvArz@dhcp22.suse.cz> <Ys4wRqCWrV1WeeWp@castle>
 <CAJD7tkb0OcVbUMxsEH-QyF08OabK5pQ-8RxW_Apy1HaHQtN0VQ@mail.gmail.com>
 <YtaV6byXRFB6QG6t@dhcp22.suse.cz> <CAJD7tkbieq_vDxwnkk_jTYz9Fe1t5AMY6b3Q=8O-ag9YLo9uZg@mail.gmail.com>
 <CAHS8izP-Ao7pYgHOuQ-8oE2f_xe1+tP6TQivDYovEOt+=_QC7Q@mail.gmail.com> <YtcDEpaHniDeN7fP@slm.duckdns.org>
In-Reply-To: <YtcDEpaHniDeN7fP@slm.duckdns.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 19 Jul 2022 12:30:17 -0700
Message-ID: <CAJD7tkZkFnVqjkdOK3Wf8f1o3XmMWCmWkzHNQKh8Znh5dDF27w@mail.gmail.com>
Subject: Re: cgroup specific sticky resources (was: Re: [PATCH bpf-next 0/5]
 bpf: BPF specific memory allocator.)
To:     Tejun Heo <tj@kernel.org>
Cc:     Mina Almasry <almasrymina@google.com>,
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

On Tue, Jul 19, 2022 at 12:16 PM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Tue, Jul 19, 2022 at 11:46:41AM -0700, Mina Almasry wrote:
> > An interface like cgroup.sticky.[bpf/tmpfs/..] would work for us
> > similar to tmpfs memcg= mount option. I would maybe rename it to
> > cgroup.charge_for.[bpf/tmpfs/etc] or something.
>
> So, I'm not a fan because having this in cgroupfs would create the
> expectation that these resources can be moved across cgroups dynamically
> (and that's the only way the interface can be useful, right?). I'd much

Is there a reason why these resources cannot be moved across cgroups
dynamically? The only scenario I imagine is if you already have tmpfs
mounted and files charged to different cgroups, but once you attribute
tmpfs to one cgroup.charge_for.tmpfs (or sticky,..), I assume that we
can dynamically move the resources, right?

In fact, is there a reason why we can't move the tmpfs charges in that
scenario as well? When we move processes we loop their pages tables
and move pages and their stats, is there a reason why we wouldn't be
able to do this with tmpfs mounts or bpf maps as well?


> prefer something a lot more minimal - e.g. temporarily allow assuming an
> ancestor identity while creating a resource or sth along that line, and to
> add something like that, I think we need pretty strong arguments for why it
> can't be handled through cgroup layering in userspace.
>
> Thanks.
>
> --
> tejun

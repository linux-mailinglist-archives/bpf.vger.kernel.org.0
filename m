Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60003563CC4
	for <lists+bpf@lfdr.de>; Sat,  2 Jul 2022 01:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiGAX2Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Jul 2022 19:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiGAX2Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Jul 2022 19:28:24 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A7523145
        for <bpf@vger.kernel.org>; Fri,  1 Jul 2022 16:28:23 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id r2so1750161qta.0
        for <bpf@vger.kernel.org>; Fri, 01 Jul 2022 16:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vB+wIPmejTn5guDzm5cOLEtXJ3nVXhdD7b4J4pd+cFY=;
        b=g6OkOcxXIvG59akpnlImlIcETkdMs26zUNWZQ7dS0paRnswQFjyUzljmU0lm45Ib0h
         0G/oxnjfVsmFsfH9s8GG0BWyLSiR43LrciR6mGgnaBm1jZmpQxOM+VER18y0zlcr2kfM
         2/TQ/BiTV0uXVtJBx3k/DlrG4G5htuJ4I0T2sN4KYYSSQAGYRhaG3AuEkPZbLt3h5pXf
         5WALSJGk8C8SFulTVbniylYxiH6EBhxnRVlM/VcL3kHGVTyle1R047fofkkf62Bxghqo
         pqw/irKAUFGsBAXs+wUObzD/Q0FAxX1Hk8lrghs+vElBBVNb7lf7JhOHrcR9IpYWq4kn
         z9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vB+wIPmejTn5guDzm5cOLEtXJ3nVXhdD7b4J4pd+cFY=;
        b=TlAcWbgOIv2BlH8bY3ez2AQILgj2m7hPZORhtuJxxORUT5p154or9NSBVlPLf3vJQ0
         wf+1x/L4C6YB3n1sE2uVzb0+nJG+A4PX82ry3AoerS0FG+1hUffn7JKQqek134LOS2DH
         YY4W9he3/SEZ+S7zCPRMN+YZKzTsBzRWQnahgz0A6YRnb1pwduMV9z8T8Ey7l5A7i8BE
         MMovYdRYnRWGb9NpeWAKNpIEyzuOby7KUjlUvgCgCVHye9ay81AfWwgbxdu1dsEKyhCy
         moxUaQP2dS97aMYGulVY001+1D1OqhRLkV1x/nKdrP3MU4JuzFRLbkmuNWYAoAFpUETy
         t85w==
X-Gm-Message-State: AJIora978uZVx/1CyqMzOukmmfjRbZacpikF9DvM9yyy/W92pCZFKt1W
        FGDs9RidT3n5ziLX52ouRs7sOaK5pDhu1bhbV74IiA==
X-Google-Smtp-Source: AGRyM1syrEY6iPUk1ySOigzAfhn29UJW//l7jUCeAyTBPKAPp9fI/2FxH8eSUodfOrelgdQ9aHzBYPO6D0gD2l3ljtc=
X-Received: by 2002:a05:6214:202f:b0:432:4810:1b34 with SMTP id
 15-20020a056214202f00b0043248101b34mr18957932qvf.35.1656718102554; Fri, 01
 Jul 2022 16:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220610194435.2268290-1-yosryahmed@google.com>
 <20220610194435.2268290-9-yosryahmed@google.com> <00df1932-38fe-c6f8-49d0-3a44affb1268@fb.com>
 <CAJD7tkaNnx6ebFrMxWgkJbtx=Qoe+cEwnjtWeY5=EAaVktrenw@mail.gmail.com>
 <CAJD7tkbOztCEWgMzoCOdD+g3whMMQWW2e0gwo9p0tVK=3hqmcw@mail.gmail.com> <59376285-21bc-ff12-3d64-3ea7257becb2@fb.com>
In-Reply-To: <59376285-21bc-ff12-3d64-3ea7257becb2@fb.com>
From:   Hao Luo <haoluo@google.com>
Date:   Fri, 1 Jul 2022 16:28:11 -0700
Message-ID: <CA+khW7jLLwgLBxpyn5s6Nc8V=0fjfH22193kjP1STbU2A+3v6Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 8/8] bpf: add a selftest for cgroup
 hierarchical stats collection
To:     Yonghong Song <yhs@fb.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>
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

On Tue, Jun 28, 2022 at 11:27 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 6/28/22 12:43 AM, Yosry Ahmed wrote:
> > On Mon, Jun 27, 2022 at 11:47 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> >>
> >> On Mon, Jun 27, 2022 at 11:14 PM Yonghong Song <yhs@fb.com> wrote:
[...]
> >>> btf_dump_data:FAIL:ensure expected/actual match unexpected ensure
> >>> expected/actual match: actual '(union bpf_iter_link_info){.map =
> >>> (struct){.map_fd = (__u32)1,},.cgroup '
> >>> test_btf_dump_struct_data:PASS:find struct sk_buff 0 nsec
> >>>
> >>
> >> Yeah I see what happened there. bpf_iter_link_info was changed by the
> >> patch that introduced cgroup_iter, and this specific union is used by
> >> the test to test the "union with nested struct" btf dumping. I will
> >> add a patch in the next version that updates the btf_dump_data test
> >> accordingly. Thanks.
> >>
> >
> > So I actually tried the attached diff to updated the expected dump of
> > bpf_iter_link_info in this test, but the test still failed:
> >
> > btf_dump_data:FAIL:ensure expected/actual match unexpected ensure
> > expected/actual match: actual '(union bpf_iter_link_info){.map =
> > (struct){.map_fd = (__u32)1,},.cgroup = (struct){.cgroup_fd =
> > (__u32)1,},}'  != expected '(union bpf_iter_link_info){.map =
> > (struct){.map_fd = (__u32)1,},.cgroup = (struct){.cgroup_fd =
> > (__u32)1,.traversal_order = (__u32)1},}'
> >
> > It seems to me that the actual output in this case is not right, it is
> > missing traversal_order. Did we accidentally find a bug in btf dumping
> > of unions with nested structs, or am I missing something here?
>
> Probably there is an issue in btf_dump_data() function in
> tools/lib/bpf/btf_dump.c. Could you take a look at it?
>

Regarding this failure of btf_dump_data, the cause seems that:

I added a new struct in 'union bpf_iter_link_info' in this patch
series, which expanded bpf_iter_link_info's size from 32bit to 64bit.
However, the test still used the old struct to initialize, which makes
a temporary stack variable (of type bpf_iter_link_info) partially
initialized. If I initialize the type by the larger new struct only,
btf_dump_data will output the correct content and the said test will
pass.

Yosry, we need to fold the said solution in the patch which introduced
changes to bpf_iter_link_info, so that it won't break the test.

I haven't dug into btf_dump_data() on why partially initialized union
fails. I need to look at the get_cgroup_vmscan_delay selftest in this
patch now.

Hao

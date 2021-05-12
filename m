Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED25F37D4DA
	for <lists+bpf@lfdr.de>; Wed, 12 May 2021 23:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243360AbhELSdi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 May 2021 14:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351733AbhELSBs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 May 2021 14:01:48 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D80C061574
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 11:00:38 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id i4so31800623ybe.2
        for <bpf@vger.kernel.org>; Wed, 12 May 2021 11:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qH3z28b3z/vN5V0OTchX36YEmtt3sP2vV9txadNYBB0=;
        b=FB5VqJekQyN8QtU3XXWAOQaHBPmezJP6zxfhFLNVJyW6Y8NO/dZF9/i9SggPslUs/G
         2hq2b/pkVgQCFa36YFuR1wPAmC7aLDjXdwHfMQfHGmRBp58ncNu9zGxDFXH0fiTAxcqW
         3t6DONtObS23batRtCOCbnCOLVvsET1EwXWMR6oV+XDVuuxehpmF5TNuJqpZUgUHDHL0
         UrZ6MBy8A/Ct8TrbuYooCTDQjlGykLsMj5n9UF7Sf0X11anKDtFLr/X7uzVNROpoGQBA
         B3qx6Mntq0tA11lqEdn75tjHskio9O872S8UpV+mrolv5YnxvQmeJaFCQHoa4vkkGhEp
         frJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qH3z28b3z/vN5V0OTchX36YEmtt3sP2vV9txadNYBB0=;
        b=gdo8SHb3uHuuoHeGvhLbyiXlZUoc7diXupNF5vudT4hnW2+nNSn5notuFD5dAhEADG
         Jdtwpn9VG2d6q/XqEIafGn5T2lVRvQ3NnMENsiXiWsiy0zMXPgyFY1/Asf9Cc927Csdk
         WZccTDa6sQLQVCGwFvk7mmZ+HUSPeNoWtahfUaBYC8YUI+3r3oPA19+kTgoMkA1jwmT/
         xBV2UDbOWpoHTrFbn2/kGKhXh2L4N8yrpMjdeopAksn2o7OoXyk2ietsJDfxoa2KfJDg
         dpIO5OP0TY0WyUL09FF6QgN8y7MhufvwVyZyppEUgfWSJZEeWZesm/51JolJnhjxJVj2
         vruQ==
X-Gm-Message-State: AOAM533eYbCccRVTk2fDZAIliuEzlZedPYheR2HZ2DeAsUL3uOCeRoxp
        dDTkEQQaZukHNudl5kKrQvSxk04mr9S06pXa7zE=
X-Google-Smtp-Source: ABdhPJyuJQJBlszN02KyOMR8holaeq/IsS8XYSchKbsCjb3Fi6h2F2eOZ4wY2agaAsvt7pSkOQwEq1yoQgjo0NVQtZc=
X-Received: by 2002:a5b:d4c:: with SMTP id f12mr25184031ybr.510.1620842437541;
 Wed, 12 May 2021 11:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210508034837.64585-1-alexei.starovoitov@gmail.com>
 <20210508034837.64585-8-alexei.starovoitov@gmail.com> <CAEf4BzbJDRAVmjPSk6XWcfxuLUvymouN4G+-UYM1G9f=2pX-yA@mail.gmail.com>
 <bec3232d-b59d-9d89-fae5-795e2bd32556@fb.com>
In-Reply-To: <bec3232d-b59d-9d89-fae5-795e2bd32556@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 12 May 2021 11:00:26 -0700
Message-ID: <CAEf4BzYFBpKDMXqjji_o1cu0h0uFhWb74HX1+BaCUmqiF89oUA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 07/22] selftests/bpf: Test for btf_load command.
To:     Alexei Starovoitov <ast@fb.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 11, 2021 at 9:05 PM Alexei Starovoitov <ast@fb.com> wrote:
>
> On 5/11/21 3:45 PM, Andrii Nakryiko wrote:
> > On Fri, May 7, 2021 at 8:48 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >>
> >> From: Alexei Starovoitov <ast@kernel.org>
> >>
> >> Improve selftest to check that btf_load is working from bpf program.
> >>
> >> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> >> ---
> >>   tools/testing/selftests/bpf/progs/syscall.c | 48 +++++++++++++++++++++
> >>   1 file changed, 48 insertions(+)
> >>
> >
> > [...]
> >
> >>   SEC("syscall")
> >>   int bpf_prog(struct args *ctx)
> >>   {
> >> @@ -33,6 +73,8 @@ int bpf_prog(struct args *ctx)
> >>                  .map_type = BPF_MAP_TYPE_HASH,
> >>                  .key_size = 8,
> >>                  .value_size = 8,
> >> +               .btf_key_type_id = 1,
> >> +               .btf_value_type_id = 2,
> >>          };
> >>          static union bpf_attr map_update_attr = { .map_fd = 1, };
> >>          static __u64 key = 12;
> >> @@ -43,7 +85,13 @@ int bpf_prog(struct args *ctx)
> >>          };
> >>          int ret;
> >>
> >> +       ret = btf_load();
> >
> > Maybe let's move patch #11 (bpf_sys_close() helper) in front of these
> > selftests and call bpf_sys_close() appropriately on error and (if
> > success) after map is created?
>
> Interesting idea. I took a stab at it, but it's not unit-test like.
> That bpf_sys_close is going to be used assuming it's working.
> I'd rather add explicit test for bpf_sys_close eventually
> instead of mixing the two.
> Since your concern is fd leak I've added btf_fd to context instead
> and added explicit close() in user space.

Ok, that's fine. And yes, my concern was FD leak. But also having BPF
selftests that demonstrates how, when you create FD in a "syscall" BPF
program, such FDs can be closed inside "syscall" program as well.

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1213D7F92
	for <lists+bpf@lfdr.de>; Tue, 27 Jul 2021 22:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhG0U4f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Jul 2021 16:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhG0U4f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Jul 2021 16:56:35 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EA3C061757
        for <bpf@vger.kernel.org>; Tue, 27 Jul 2021 13:56:34 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id q15so271066ybu.2
        for <bpf@vger.kernel.org>; Tue, 27 Jul 2021 13:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lYMu/sY1z4ifRcW8GzBl3sFAq3YLkWqzKTTW/VVJUfQ=;
        b=ntmnfvE/uCne7Fcpx2gbt3g0r8W/bKFfFjshyjT+zji4mqN+YIfnpPVQ1VlUAAuWsU
         9vZHjuNAUR52PINM3xyksvj4qTGi+jQ2275CIr5Kc4exV5M6Kof796GZs5zIRW7lGb/Y
         u08li74k/8QVg5ooP+NZcCYr8xX9M+Wrgh3Qw44V4dyIbvad2+GOiSWtN6q8MQ6p9+h3
         9L1utrV1yC5qhwMOWgVmL71dG7+EtpPipeESLmvbGW5Tgz6LlvbNnFegZuya1XydpIQB
         /NR/nhZnSEUnfddXiBVM7hGgJOiGPuZga24hH8JCzMrL3y2y1UDijTVGYbk/1MGpFZLP
         P6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lYMu/sY1z4ifRcW8GzBl3sFAq3YLkWqzKTTW/VVJUfQ=;
        b=pXcsFUCx2dhOG+L/V+9UfP9Bl5AVSKtfkroYLosa1POfDQCZarkHGe8e3D2r9pizee
         mXJJPSUWrSt9RPIblHoocLH5dPs4WEVF00JwpvZ3wktoO4yvs/9yfvSJRA2A2ymOoeU3
         fXgAIdwYPsGn9WatU+yQUtg7LwSTDNAJH/J01KJmoFdihqpDUXLql/vvwgpv8BR7m/nE
         /8kvGhTDttCaKUczgsGsbGXHfun/Nas6QG+SDPOj2R1eBDl4ECiYRGaqiD/dfw4XYg41
         nUfAXt+2/CwTmwhzG8d3YQkO01EKnC/vCzajctTR7a1xGuZt7KtZNwxKBuWeZw7Ma3dg
         SgkA==
X-Gm-Message-State: AOAM53023KQcjpDaIxaSlrZwfqUv5fFq/iEtUfdLs08Q/BTWMDr57Va9
        EHvd0EtAZzAnZLU43m6RlqHsQr78LHgIKT2p+O4=
X-Google-Smtp-Source: ABdhPJxNt1H12qGb6lV/ojrbiYzF1EhZ/vCbkbUaT/GYRPBLmFmfj7CNmheKgGvFkorw7btl5uaScZTunZFxVVnHSEE=
X-Received: by 2002:a25:2901:: with SMTP id p1mr22851155ybp.459.1627419393225;
 Tue, 27 Jul 2021 13:56:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210726161211.925206-1-andrii@kernel.org> <20210726161211.925206-5-andrii@kernel.org>
 <YP/ODG1g0Z553x1I@hirez.programming.kicks-ass.net>
In-Reply-To: <YP/ODG1g0Z553x1I@hirez.programming.kicks-ass.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 27 Jul 2021 13:56:22 -0700
Message-ID: <CAEf4BzZ90qX2ua1h7Vui1gW=2CxvmwSSX7VK5Kwhiqj2zAMd6A@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 04/14] bpf: implement minimal BPF perf link
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 27, 2021 at 2:15 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jul 26, 2021 at 09:12:01AM -0700, Andrii Nakryiko wrote:
> > diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> > index ad413b382a3c..8ac92560d3a3 100644
> > --- a/include/linux/trace_events.h
> > +++ b/include/linux/trace_events.h
> > @@ -803,6 +803,9 @@ extern void ftrace_profile_free_filter(struct perf_event *event);
> >  void perf_trace_buf_update(void *record, u16 type);
> >  void *perf_trace_buf_alloc(int size, struct pt_regs **regs, int *rctxp);
> >
> > +int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog);
> > +void perf_event_free_bpf_prog(struct perf_event *event);
> > +
> >  void bpf_trace_run1(struct bpf_prog *prog, u64 arg1);
> >  void bpf_trace_run2(struct bpf_prog *prog, u64 arg1, u64 arg2);
> >  void bpf_trace_run3(struct bpf_prog *prog, u64 arg1, u64 arg2,
>
> Oh, I just noticed, is this the right header to put these in? Should
> this not go into include/linux/perf_event.h ?

Not that I care much, but this one has perf_event_attach_bpf_prog()
and perf_event_detach_bpf_prog(), so it felt appropriate to put it
here. perf_event.h only seems to have perf_event_bpf_event() for
BPF-related stuff (which seems to be just notification events, not
really BPF functionality per se). But let me know if you prefer to add
these new ones to perf_event.h.

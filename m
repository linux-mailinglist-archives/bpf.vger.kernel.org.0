Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C699D854ED
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2019 23:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbfHGVIR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Aug 2019 17:08:17 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40397 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729938AbfHGVIQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 7 Aug 2019 17:08:16 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 99E4222085;
        Wed,  7 Aug 2019 17:08:15 -0400 (EDT)
Received: from imap35 ([10.202.2.85])
  by compute4.internal (MEProxy); Wed, 07 Aug 2019 17:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=MVs99KE7dt0meIyu2owJltHACKSIp5Z
        pgOcBufeg8hA=; b=zRSQ/R4t0NTgKx/pnb5/9fe+gzNAS+buf1V5kYiCjeCH8J0
        sB4DLvERYdcpJdOY1LpPeCLu+pR9aY3AD4gtFu4QSTaCpoTEMlFk3bzzptmE2d3e
        t16ak+xpOgpzg7x4H89xZuwrzCAQi6BTzyl3hFzY/m/Jbt0aF6/OcP6dnjM0MZk1
        lRYdCj8ozkycyQeGZQ5OM17RynVU04HEa4TT8ZVlhuk0JtF0a4rqT0V9eE4zaouP
        L8dOsiFJ2LlCCppq95UwtU3icQ/nHGkOri7UQrbpSTVGkrKxuzV4sDj+wceGDntS
        hHAPxR1Ljw9aJiNMcQ560Af7OlTZKsibMwOw2SQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=MVs99K
        E7dt0meIyu2owJltHACKSIp5ZpgOcBufeg8hA=; b=X57R5F9mi5ojHI6pfl0ynm
        ocflBZ4cYixG2KW5bS3Ipef+YuYEElmxCVV8MHzhDVShkeMq+zctLEfUKMErXxSN
        p+tYOzFEr0b/MHhHPGWaZAWOOdRh8xduvkQQI6NlhrEILMxtDQNGvOUdkkH8SWwD
        c6kyRyWw+mQw3qnzZ4RZpOeo4+ge/9zdHZjlbm9rM0FgqYVHRhy/OwlrIyhi2GBy
        ByKPfnKwIjxpbP8bOEvt2radzNqgRTsIQNQVq2eK36RmvHwikZB2ShbtD1/Y9JIq
        5QPXHUxAYtcj2KDCPKxqONq8khXlmVEKOXfFA82z3Law4Qm9ZTOHL0lYt+lV5ctg
        ==
X-ME-Sender: <xms:vz1LXbcjkfCpZUVcEWiBuvZe7S4dGqov4Z9rXKiD3LvnkMflbUHd1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudduvddgudehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdefhedmnecujfgurhepofgfggfkjghffffhvffutgesthdtredt
    reertdenucfhrhhomhepfdffrghnihgvlhcuighufdcuoegugihusegugihuuhhurdighi
    iiqeenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihiienucev
    lhhushhtvghrufhiiigvpedu
X-ME-Proxy: <xmx:vz1LXYKgKWw_J7TAlNQSJiVifMzXDD1RbijuUb_n7CuQUUQFlTe-0g>
    <xmx:vz1LXa_OhrNiUV5_mSxU0ZhtXenMTQ2-LTFH4tkZVtT0SMVQciXnQg>
    <xmx:vz1LXbdD3hrQ__6Z-LwyrtPIbsvpFw9yzY3Tdr03yjgDUZiCPrBQww>
    <xmx:vz1LXZ187F3AZXAMgRZPczBnuXoIDr3KubrI8pSXBM2_c_srReiEbA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5753914C0062; Wed,  7 Aug 2019 17:08:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-808-g930a1a1-fmstable-20190805v2
Mime-Version: 1.0
Message-Id: <13659ba6-9af9-4502-9611-8ae98d5811c9@www.fastmail.com>
In-Reply-To: <CAPhsuW7z9A=5AtWaOEEfdhyV9CmWKYXRn5itOh2tcsOgbdxOiQ@mail.gmail.com>
References: <20190806234131.5655-1-dxu@dxuuu.xyz>
 <CAPhsuW7z9A=5AtWaOEEfdhyV9CmWKYXRn5itOh2tcsOgbdxOiQ@mail.gmail.com>
Date:   Wed, 07 Aug 2019 14:08:14 -0700
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Song Liu" <liu.song.a23@gmail.com>
Cc:     "Song Liu" <songliubraving@fb.com>, "Yonghong Song" <yhs@fb.com>,
        "Andrii Nakryiko" <andriin@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "Kernel Team" <kernel-team@fb.com>
Subject: Re: [PATCH 1/3] tracing/kprobe: Add PERF_EVENT_IOC_QUERY_KPROBE ioctl
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 7, 2019, at 11:14 AM, Song Liu wrote:
> On Tue, Aug 6, 2019 at 4:41 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > It's useful to know kprobe's nmissed and nhit stats. For example with
> > tracing tools, it's important to know when events may have been lost.
> > There is currently no way to get that information from the perf API.
> > This patch adds a new ioctl that lets users query this information.
> > ---
> 
> [...]
> > +
> >  /*
> >   * Ioctls that can be done on a perf event fd:
> >   */
> > @@ -462,6 +484,7 @@ struct perf_event_query_bpf {
> >  #define PERF_EVENT_IOC_PAUSE_OUTPUT            _IOW('$', 9, __u32)
> >  #define PERF_EVENT_IOC_QUERY_BPF               _IOWR('$', 10, struct perf_event_query_bpf *)
> >  #define PERF_EVENT_IOC_MODIFY_ATTRIBUTES       _IOW('$', 11, struct perf_event_attr *)
> > +#define PERF_EVENT_IOC_QUERY_KPROBE            _IOWR('$', 12, struct perf_event_query_kprobe *)
> 
> This should be _IOR().

Ok.

> 
> [...]
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index 9d483ad9bb6c..5449182f3056 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -196,6 +196,31 @@ bool trace_kprobe_error_injectable(struct trace_event_call *call)
> >         return within_error_injection_list(trace_kprobe_address(tk));
> >  }
> >
> > +int perf_event_query_kprobe(struct perf_event *event, void __user *info)
> 
> I think perf_kprobe_event_query() would be a better name, especially that we
> have struct perf_event_query_kprobe.

Ok.

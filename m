Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6513409B9A
	for <lists+bpf@lfdr.de>; Mon, 13 Sep 2021 20:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344671AbhIMSBX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Sep 2021 14:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239852AbhIMSBX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Sep 2021 14:01:23 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7854BC061574;
        Mon, 13 Sep 2021 11:00:07 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id f65so9588527pfb.10;
        Mon, 13 Sep 2021 11:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ar4axcEWPrCdTuBIYlAX+Qe5Dwg1m8PpYyueFWZ9yZQ=;
        b=GIepHmM3Nv01P4syO4b4WSy429ooFrVUkQPyjIgnmHdY1mruGmkNoK85n7l69tCgC2
         8wZcK9Ydfpxfml+gWuabiks5mVSgFNNLMneKKjw5SQMBTOsu0ZaPTg3Wsf8VyVxLyeb8
         1i8QfuAI2iRHlyjZ+WO04g5MoDEYjIz3FU6d2NvWDjR24D4aDeoiRX+ZPeNE/TbqT42i
         GHWNysyC6KqM1psELCXSTspqM5vngDszHHeCz10TZDvIG+XXtWRXsY/lakY1tqLdrnpd
         MYby3tcf890GQR9I81qPLNJRxvTeLOq4n5dKY/WHHdKXnxPbqo2Bs5lh7wlTblz77Zlr
         dXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ar4axcEWPrCdTuBIYlAX+Qe5Dwg1m8PpYyueFWZ9yZQ=;
        b=hoRO6u5Wn89LWoC7w/g9jPqPGDIxU+NlVzUa6wZ+7c4kBYXNArhxNQYhV/sBDqj4yv
         srzqo/buAV2Wq6CUKHdRIN3+oeVxWfOWSomnJIl11U5p1juGUbNQxm+O8QBEx7XLu9Ei
         J1LMUWI+J/4iiWKFrgSnihnxElcTLM84eerpblLFW0vw6vxhWx6yuDsBOxky+63GFzVH
         pRBsR6kR0+SM1+unPmcrnzXTCuQufoQH2AX5O4J0OCR+u48XCQ5aijjK3niiNNGCJ7+5
         /AlqbZXx28LUXHNSUoHyj4ggs57C/RfdQPLXCngDGrXmm0eO9RjxUZA8JzP6u2VbBY23
         uGFQ==
X-Gm-Message-State: AOAM532IvUK7bhuqJCC60Tq+teXCRAQH5W8WhgRb8spflMgoK7HKOWcV
        7jXfVURakBk7dNBKrGuitK1G9A6ZiZFUBxay6fiHCkk+
X-Google-Smtp-Source: ABdhPJx76g7XE+cm9Cy/u2amnPaDbEnbPyH+7Gbc2SQwtfOLMuma6c2aq/b/+k8WvDgrfxEFuG/oGYFdjaJYVA++srg=
X-Received: by 2002:a05:6a00:88b:b0:43d:e85f:e9ee with SMTP id
 q11-20020a056a00088b00b0043de85fe9eemr648919pfj.46.1631556006839; Mon, 13 Sep
 2021 11:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210910183352.3151445-1-songliubraving@fb.com>
In-Reply-To: <20210910183352.3151445-1-songliubraving@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 13 Sep 2021 10:59:55 -0700
Message-ID: <CAADnVQLLYQwMh-jUa7pJH9uwAhEyVhc1gGR+cnS_s-4YTPqpTQ@mail.gmail.com>
Subject: Re: [PATCH v7 bpf-next 0/3] bpf: introduce bpf_get_branch_snapshot
To:     Song Liu <songliubraving@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, kjain@linux.ibm.com,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 10, 2021 at 11:34 AM Song Liu <songliubraving@fb.com> wrote:
>
> Changes v6 => v7:
> 1. Improve/fix intel_pmu_snapshot_branch_stack() logic. (Peter).
>
> Branch stack can be very useful in understanding software events. For
> example, when a long function, e.g. sys_perf_event_open, returns an errno,
> it is not obvious why the function failed. Branch stack could provide very
> helpful information in this type of scenarios.
>
> This set adds support to read branch stack with a new BPF helper
> bpf_get_branch_trace(). Currently, this is only supported in Intel systems.
> It is also possible to support the same feaure for PowerPC.

Applied. Thanks

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5070630A490
	for <lists+bpf@lfdr.de>; Mon,  1 Feb 2021 10:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbhBAJnn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Feb 2021 04:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbhBAJnk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Feb 2021 04:43:40 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E92AC061573
        for <bpf@vger.kernel.org>; Mon,  1 Feb 2021 01:43:00 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id h16so10647376qth.11
        for <bpf@vger.kernel.org>; Mon, 01 Feb 2021 01:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2sHxy9y8qkhEHifIfAe0m1ot0K1d3d52OFzD+qlpuBU=;
        b=NeM9ON292bcd64Kcp1z5gL6seKO2huIT0uTkbIjuDyCv8g/B7hwOeO2OAamF9B2PEc
         ZbN3rq15lpmLJV5JUh3CfnQHd9b+YxMq+YDouvd5MsK+lD7L2Ow3FVdaW+XRHlDYD6/H
         WZVypjR7q4M6jZJbuSPLfv9fUnKjSsyRt/TTmDaYdWR/7zYJd72RrYEMvq0o33pqO4K5
         lbJBbkeRyO6N0No28SuLusfI0yy55S87qcE434y+K2PqoQt/6gIeyePbUOOuP/aymnBk
         7oPVPDckhy2fDc1Q/7+/etMpeJc8jE+vtf1E7T6slmA1BWrTkBsk9g0LTJujxL+N2liU
         63PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2sHxy9y8qkhEHifIfAe0m1ot0K1d3d52OFzD+qlpuBU=;
        b=NfT2lMV9Wv5qTJFzSpYXQTzYpX0R4Ucetj4Z+DfP9z6ZwoD/UbGzbK9ko/BuBDSZyb
         eTnrsTqfSvn1WMy6BeiO82BLBX68jtTeKxda6VRRVpTdl6ytP96PNwUyOEP7hxvHFtZQ
         bHFBmF6IJG0WFo9LZwxXgoR4KRUieLPAAfPsQ7tMKtQI92FOgGc3FokRZ/V4rLtpQiOn
         RnMnN5FTgDT1ZZ82/lz8kwxsHAZDJ/pWhAglUzC3A1oCuxG51U+oBvPmFRRtypWKAOnR
         f59e9eUHfzNCHGZIJ+vHZQ3YoDAPrllQO1SG+vDwCPKk0eMgHiczzGDaiRRW8H/4+vnh
         xl9Q==
X-Gm-Message-State: AOAM531vxEEckT6+PqGh3vS0fST9BTnIaKj6qonle1U1CmFD7LNE5ILV
        qdDtz97CsYWZKpdsQwPaN77i4Y5ttfaCnNoSZ7xmDQ==
X-Google-Smtp-Source: ABdhPJw/FU0ujXSBV1WzoDZvLs4yUz4Di0PBTFwg18+sWEkhAxDhgDVoLq4LU6FoT1MyO3nDH65GPEApRc4rxfiidFA=
X-Received: by 2002:ac8:480b:: with SMTP id g11mr14124931qtq.290.1612172579083;
 Mon, 01 Feb 2021 01:42:59 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+a7UBQpAY4vwT8Od0JhwbwcDrbJXZ_ULpPfJZ42Ew-yCQ@mail.gmail.com>
 <YBfIUwtK+QqVlfRt@hirez.programming.kicks-ass.net>
In-Reply-To: <YBfIUwtK+QqVlfRt@hirez.programming.kicks-ass.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 1 Feb 2021 10:42:47 +0100
Message-ID: <CACT4Y+Yq69nvj2KZUQrYqtyu+Low+jCCcH++U_vuiHkhezQHGw@mail.gmail.com>
Subject: Re: extended bpf_send_signal_thread with argument
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, andrii@kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        David Miller <davem@davemloft.net>, kpsingh@kernel.org,
        John Fastabend <john.fastabend@gmail.com>,
        netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 1, 2021 at 10:22 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sun, Jan 31, 2021 at 12:14:02PM +0100, Dmitry Vyukov wrote:
> > Hi,
> >
> > I would like to send a signal from a bpf program invoked from a
> > perf_event. There is:
>
> You can't. Sending signals requires sighand lock, and you're not allowed
> to take locks from perf_event context.


Then we just found a vulnerability because there is
bpf_send_signal_thread which can be attached to perf and it passes the
verifier :)
https://elixir.bootlin.com/linux/v5.11-rc5/source/kernel/trace/bpf_trace.c#L1145

It can defer sending the signal to the exit of irq context:
https://elixir.bootlin.com/linux/v5.11-rc5/source/kernel/trace/bpf_trace.c#L1108
Perhaps this is what makes it work?

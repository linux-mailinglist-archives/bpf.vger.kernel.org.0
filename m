Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8E9268E1
	for <lists+bpf@lfdr.de>; Wed, 22 May 2019 19:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbfEVRLX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 May 2019 13:11:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32987 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729155AbfEVRLX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 May 2019 13:11:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id z28so1673395pfk.0
        for <bpf@vger.kernel.org>; Wed, 22 May 2019 10:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mVlTJpxzfZ0C9GbqnMOqEkJrjw8EzvZweQIzEARpbMQ=;
        b=NkF6qPFH4H7psNNREA0ntZoKV9aZE5uYr0VY7W0qomqfGceotUEXPo/7fobRqw95VR
         xQkvckDM0qTYAJMSmK7+SHUZ+U3ta3DxxQONB7H3gJb4NUmRW6wKYwP0gJgnDzPtE/AB
         gRhVSLayfabI1haulCRHGVadWJiJFNixF6imCUojEWsxZa4TGvXnkuMNxq1Q5kKFbcW3
         cj7dMpReEsXNKRTKJRd+NZUBES+Y552GbG82WB65nLiqX2FpgXEjDTdPwv1OFxkMwGgM
         RLe8+ygK3iOXBVMnvb/4cpkiOXfg1RlZ5KHANb0iOB+oTemRl6rstRcvAEmLfZFwCeDY
         ruMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mVlTJpxzfZ0C9GbqnMOqEkJrjw8EzvZweQIzEARpbMQ=;
        b=OZENF0Sw5th6bmc8AMSc3R1z0kIwUYDxxVEDSqpDgzas6964DzgBFc+FhKIiN71Hfb
         vZwF4XBK2EHQZa40osRUOYwdi6kHg1chUBfNHwwcnpr82e5VhAEKBEYjtyWj9kupr6SC
         PU24PQbuuA0DW1U2zCNIOmrl63LKgYay/Ib3cQ0erV/MV95vTyP8qBk7xSkaqXZGb8el
         iWV8OKbUptbEHrMI9zGvVWGvVRnqpV4E+TAymrYTQw7Shk1Pz54ApWE2P5Z8L5tMfBNq
         0SsVSD+W0CyJlczDtfyAS8IAyr1kxrknNRU6jnrCtBhzbCkLZGNI2n6z+01osQZAeIk1
         tnGQ==
X-Gm-Message-State: APjAAAWbIwR7Zv4ii3RgyJ/dLAhdtALYQv56ld+dz4DCMBm9v7LXsZ1d
        w9GrRivKZ8BD8Pyt71l1oq7BmQ==
X-Google-Smtp-Source: APXvYqw9lKJzwtEdT5SRa0PjEq7lhKRSLRqmoYO3PBjGV+iwPFFPoDHeTx7AwwYRX2jZVtX9JSGfkg==
X-Received: by 2002:a65:6116:: with SMTP id z22mr91869626pgu.50.1558545082403;
        Wed, 22 May 2019 10:11:22 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id d13sm22870441pfh.113.2019.05.22.10.11.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 10:11:21 -0700 (PDT)
Date:   Wed, 22 May 2019 10:11:21 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Alexei Starovoitov <ast@fb.com>
Cc:     Yonghong Song <yhs@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH bpf-next v2 0/3] bpf: implement bpf_send_signal() helper
Message-ID: <20190522171121.GL10244@mini-arch>
References: <20190522053900.1663459-1-yhs@fb.com>
 <20190522163854.GJ10244@mini-arch>
 <01865520-1963-9acd-b404-8eac03905baf@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01865520-1963-9acd-b404-8eac03905baf@fb.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 05/22, Alexei Starovoitov wrote:
> On 5/22/19 9:38 AM, Stanislav Fomichev wrote:
> > On 05/21, Yonghong Song wrote:
> >> This patch tries to solve the following specific use case.
> >>
> >> Currently, bpf program can already collect stack traces
> >> through kernel function get_perf_callchain()
> >> when certain events happens (e.g., cache miss counter or
> >> cpu clock counter overflows). But such stack traces are
> >> not enough for jitted programs, e.g., hhvm (jited php).
> >> To get real stack trace, jit engine internal data structures
> >> need to be traversed in order to get the real user functions.
> >>
> >> bpf program itself may not be the best place to traverse
> >> the jit engine as the traversing logic could be complex and
> >> it is not a stable interface either.
> >>
> >> Instead, hhvm implements a signal handler,
> >> e.g. for SIGALARM, and a set of program locations which
> >> it can dump stack traces. When it receives a signal, it will
> >> dump the stack in next such program location.
> >>
> > 
> > [..]
> >> This patch implements bpf_send_signal() helper to send
> >> a signal to hhvm in real time, resulting in intended stack traces.
> > Series looks good. One minor nit/question: maybe rename bpf_send_signal
> > to something like bpf_send_signal_to_current/bpf_current_send_signal/etc?
> > bpf_send_signal is too generic now that you send the signal
> > to the current process..
> 
> bpf_send_signal_to_current was Yonghong's original name
> and I asked him to rename it to bpf_send_signal :)
> I don't see bpf sending signals to arbitrary processes
> in the near future.
:) I was thinking that it might be a bit more clear if we communicate
target process in the name, but I don't feel strongly about it.

So it's not about the future. OTOH, who knows, I remember when people
said there would not be any locking/loops in bpf. And here we are :)

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8886184CB6
	for <lists+bpf@lfdr.de>; Fri, 13 Mar 2020 17:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgCMQmk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Mar 2020 12:42:40 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45863 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbgCMQmk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Mar 2020 12:42:40 -0400
Received: by mail-lf1-f66.google.com with SMTP id b13so8411544lfb.12
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2020 09:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=Z1VxIXBv35KeFZt3+dBi/tUwb8bgwLuhRxYuPlHgzsc=;
        b=Xz98X0yXEPe1LumV9Ei3+6l9IIXcGbZ9Tw2yKHMJtVt5EZ3iEt6Q53kXCqmmRcCGBy
         mRa8pOOFhlmqeObpdCTx3FTCBLagJ0YGOlTGv+dwL4pCe9iYVHX8v8Vyl4YeGK/PxEMz
         wWZbDOys7OkLqQrmcL+fNCUm4AfwyAUAedFpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=Z1VxIXBv35KeFZt3+dBi/tUwb8bgwLuhRxYuPlHgzsc=;
        b=Frgsdo5ELMjMQ74QxkU4nK7OywWKFVz8IxDhXGFb96/1TLgESdul2gEVlUkraU07wx
         4IfxmCjrno/93leEP33Hfv2CbnVTFp3FGj2nlqRnr8CZoCVHcUNymG0lDbOB5fWUyOLv
         QVRBiU64wx/bkpNJ1rA/Y0vGLivA4oip1s/pqSVg7JZQWGuCtvvuwVH4PmxzF1HLMvqb
         VLp/a2eRanGw0DWWqEqwZLoGFgX0CcFQh/UHIirsYzzsNhDZ5+KViiaNQ93K9OOVd5WN
         RHgOYWjCkdT4pTuOiMMhHVeeIqJGrOrMd0Bp3jCdpGG/8pxCBEMG9TLUjPWtwCnA9HJl
         0wLw==
X-Gm-Message-State: ANhLgQ0dcnGSNWmXKsPQL2TjTkfMjM3Zm7GDwxGE2hC8CLLBVKuex0jJ
        UuICXPDbaM5QooH5Yu6Eq71qBQ==
X-Google-Smtp-Source: ADFU+vvvHY+hBwL7hPxvU+2mWXJQMUNzP5RPqDtQnTqSKVc6jkn4FyByjXpa8bqK0+yNAS+N+VuyNg==
X-Received: by 2002:a19:a401:: with SMTP id q1mr8860478lfc.157.1584117757875;
        Fri, 13 Mar 2020 09:42:37 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id y6sm2496989lfy.38.2020.03.13.09.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 09:42:37 -0700 (PDT)
References: <20200312171105.533690-1-jakub@cloudflare.com> <CAEf4BzbsDMbmury9Z-+j=egsfJf4uKxsu0Fsdr4YpP1FgvBiiQ@mail.gmail.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix spurious failures in accept due to EAGAIN
In-reply-to: <CAEf4BzbsDMbmury9Z-+j=egsfJf4uKxsu0Fsdr4YpP1FgvBiiQ@mail.gmail.com>
Date:   Fri, 13 Mar 2020 17:42:36 +0100
Message-ID: <87o8t0xl37.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 12, 2020 at 06:57 PM CET, Andrii Nakryiko wrote:
> Thanks for looking into this. Can you please verify that test
> successfully fails (not hangs) when, say, network is down (do `ip link
> set lo down` before running test?). The reason I'm asking is that I
> just fixed a problem in tcp_rtt selftest, in which accept() would
> block forever, even if listening socket was closed.

While on the topic writing network tests with test_progs.

There are a couple pain points because all tests run as one process:

1) resource cleanup on failure

   Tests can't simply exit(), abort(), or error() on failure. Instead
   they need to clean up all resources, like opened file descriptors and
   memory allocations, and propagate the error up to the main test
   function so it can return to the test runner.

2) terminating in timely fashion

   We don't have an option of simply setting alarm() to terminate after
   a reasnable timeout without worrying about I/O syscalls in blocking
   mode being stuck.

Careful error and timeout handling makes test code more complicated that
it really needs to be, IMHO. Making writing as well as maintaing them
harder.

What if we extended test_progs runner to support process-per-test
execution model? Perhaps as an opt-in for selected tests.

Is that in line with the plans/vision for BPF selftests?

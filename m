Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 795B5399C43
	for <lists+bpf@lfdr.de>; Thu,  3 Jun 2021 10:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbhFCIMI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Jun 2021 04:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhFCIMI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Jun 2021 04:12:08 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E1BC06174A
        for <bpf@vger.kernel.org>; Thu,  3 Jun 2021 01:10:23 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id w33so7515524lfu.7
        for <bpf@vger.kernel.org>; Thu, 03 Jun 2021 01:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=rhTLzLWry6rUKDh+sDZPBgmXQBrgzBnQ+CQuMTvie2k=;
        b=Kw+xxxAsk9BwiRRrWotbRV54oC60r0Ky/fLv5LC63l7HnUt6YWL4LbEDq4gWngM+6L
         M7IaCMb0Zs4wTbnU/ZbYwlzfjC5Dgtr+kIA/21Xy9u5v+TelG9blGoZDn+e5E1lkXu7e
         7RCiaD3H9q7LvaRmAsdq/hCjAiND8HzSJsh/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=rhTLzLWry6rUKDh+sDZPBgmXQBrgzBnQ+CQuMTvie2k=;
        b=K+hK4mvwMoJ1Zr5KvWuMnu9zihnmb4LgeodWnT0D1vI6iXNF7dX7kkT/hEi6f6aTgx
         492ZdisI7KZUxAvB3meOUzfVzugDTamaQWd2WovyzdW7rn8HAukwLo4lOujJXpo9X2yb
         OG7aNWwaTF8pBre8sI7hNCxv6C+zVkDLOcbb69o/ws6diiz0lRGFSUqCebatDwpDvYwq
         qLMO/4SW0tN1A+qbvNwbeJlniivamaUH6OVp6ztjOi3LAHRuS814nB2SHB+uQF/QpyfV
         IQSN+G8CHKjgsvBI2ybqEy9jo7OSgVGpH0HL+/eF1l/gzu9rVinv2qfDwf6gGy6tycY5
         adag==
X-Gm-Message-State: AOAM530tQibUBlb1i7tfoBWMx5v9jX+ZJI+hYTusJBOYbGcN7eTDI5YE
        rRcLOu2eY7haJF0jDmsz0QBUNA==
X-Google-Smtp-Source: ABdhPJxhzaejwJRFn/tNqlg4CTLa7SR0fYB0iJxAItX6qE8b7Q6lz1aScliGfNdMm6fC4dkaIEuRtg==
X-Received: by 2002:a05:6512:31d5:: with SMTP id j21mr24692938lfe.199.1622707821727;
        Thu, 03 Jun 2021 01:10:21 -0700 (PDT)
Received: from cloudflare.com (79.184.13.117.ipv4.supernova.orange.pl. [79.184.13.117])
        by smtp.gmail.com with ESMTPSA id z203sm261588lfa.30.2021.06.03.01.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 01:10:21 -0700 (PDT)
References: <20210519204132.107247-1-xiyou.wangcong@gmail.com>
 <60a5896ca080d_2aaa720821@john-XPS-13-9370.notmuch>
 <CAM_iQpUC6ZOiH=ifUe1+cdXtTgiBMwPVLSsWB9zwBA7gWh8mgA@mail.gmail.com>
 <CAEf4Bzb7+XrSbYx6x4hqsdfieJu6C5Ub6m4ptCO5v27dwbx_dA@mail.gmail.com>
 <CAM_iQpVAhOOP_PRsvL37J1WwOxHKmLEnRXVBYag1nNccHN7PYw@mail.gmail.com>
User-agent: mu4e 1.1.0; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Cong Wang <cong.wang@bytedance.com>,
        Jiang Wang <jiang.wang@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: Re: [Patch bpf] selftests/bpf: Retry for EAGAIN in
 udp_redir_to_connected()
In-reply-to: <CAM_iQpVAhOOP_PRsvL37J1WwOxHKmLEnRXVBYag1nNccHN7PYw@mail.gmail.com>
Date:   Thu, 03 Jun 2021 10:10:20 +0200
Message-ID: <87a6o774ib.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 20, 2021 at 10:44 PM CEST, Cong Wang wrote:
> On Thu, May 20, 2021 at 1:14 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> Bugs do happen though, so if you can detect some error condition
>> instead of having an infinite loop, then do it.
>
> You both are underestimating the problem. There are two different things
> to consider here:
>
> 1) Kernel bugs: This is known unknown, we certainly do not know
> how many bugs we have, otherwise they would have been fixed
> already. So we can not predict the consequence of the bug either,
> assuming a bug could only cause packet drop is underestimated.
>
> 2) Configurations: For instance, firewall rules. If the selftests are run
> in a weird firewall setup which drops all UDP packets, there is nothing
> we can do in the test itself. If we have to detect this, then we would
> have to detect netem cases too where packets can be held indefinitely
> or reordered arbitrarily. The possibilities here are too many to detect,
> hence I argue the selftests should setup its own non-hostile environment,
> which has nothing to do with any specific program.
>
> This is why I ask you to draw a boundary: what we can assume and
> what we can't. My boundary is obviously clear: we just assume the
> environment is non-hostile and we can't predict any kernel bugs,
> nor their consequences.
>
> Thanks.

(Sorry for the delay in reviews. I've been out.)

In my mind uAPI tests should not be tailored to the underlying
implementation (non-blocking read after write over loopback succeeds for
TCP), or the environment they run in (packets don't get dropped due to
OOM, signals don't interrupt syscalls).

If it's a non-blocking socket, then EAGAIN can happen. That's the
contract between the kernel and the user-space.

There is already a helper in this test case for polling and reading with
a timeout (see recv_timeout()). IMO we should be using it in all tests
that use non-blocking I/O.

If it's not being used already, that is most likely my fault.

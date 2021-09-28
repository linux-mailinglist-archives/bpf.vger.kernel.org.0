Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B4541AB5F
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 11:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239761AbhI1JEZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 05:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239813AbhI1JEY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Sep 2021 05:04:24 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC4DC061604
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 02:02:45 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id i25so90130351lfg.6
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 02:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7U3IsLEhAc3NNtaNLa10p/PtnKwn/xh1zEIhY+LzfEA=;
        b=dNzmP4NyMAfWxCGEhizylDiPzAIzCTmhqiShkiKXJgrZ3q/H9iTJ0/pUBKJqL0YT6d
         N0HcZorSfa/mJNVynggLRO3SUvx2NavkpNErN1bGatyNjKkYOKrfeQu32iMcntTR46C2
         FCZBWQRKLAIh9iuigapYqphe6M2atqm14pKrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7U3IsLEhAc3NNtaNLa10p/PtnKwn/xh1zEIhY+LzfEA=;
        b=hWFn/E2QKZxN/lDHiRQ+9cVZ0KlcOin7HvVN28qK1UI6y1qC1bXwPjqY+2KuSgsb1B
         DhaQR1o99zGcWWDtCMyfqtxqoQyJK1bc9GPZYIAEaXb+GwVe+pLNVtBaxdPeqWuiZWH2
         SMO4mWxemfAEN4AV+B400zVi6wtGJrifTnjctPgKUFOMZZVbKxv92ggIuo8ueZd6u8/t
         j0OQbjU+2CbcEuHDk+z+LczTvpEA2A8rn8IKnStWKwmwFFcGKLOd7mITePsf4pvxzDUF
         5YEWTro1wDxbl3iSwj3s/98nuaMaly4mHCG6lDjgnZ0tulrbLhfWXdve47HPZ/eszFfl
         GeIQ==
X-Gm-Message-State: AOAM530D+r3xVTA2H4I1hsEPQYN4IvFWPFKbXg0pk53F/x5pNO8+wpDZ
        8atoUnfS6XPPG2de5D0ZfGkBrFYy8NRaZwLwJP4vNQ==
X-Google-Smtp-Source: ABdhPJx5RkqJDOvtlGGV9JWMT/j9vLa1fIA/m1rWaiEYqhbYBlW0S9sKbPqrl63MfTYo9lSubHtmPfGT0idO7fjqsGo=
X-Received: by 2002:a05:6512:76:: with SMTP id i22mr4455442lfo.39.1632819763475;
 Tue, 28 Sep 2021 02:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210924095542.33697-1-lmb@cloudflare.com> <20210924095542.33697-5-lmb@cloudflare.com>
 <a076398b-f1da-c939-3c71-ac157ad96939@iogearbox.net> <871r5aglsh.fsf@cloudflare.com>
In-Reply-To: <871r5aglsh.fsf@cloudflare.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 28 Sep 2021 10:02:32 +0100
Message-ID: <CACAyw99LePDKKaL4wqYdU7tqj0S5VSGyR_iiu++MhcX3CuQynw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/4] bpf: export bpf_jit_current
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 27 Sept 2021 at 15:01, Jakub Sitnicki <jakub@cloudflare.com> wrote:
>
> I find exposing stats via system configuration variables a bit
> unexpected. Not sure if there is any example today that we're following.
>
> Maybe an entry under /sys/kernel/debug would be a better fit?
>
> That way we don't have to commit to a sysctl that might go away if we
> start charging JIT allocs against memory cgroup quota.

I had a look around, there are no other obvious places in debugfs or
proc where we already have bpf info exposed. It currently all goes via
sysctl.

There are examples of readonly sysctls:
$ sudo find /proc/sys -perm 0444 | wc -l
90

There are no examples of sysctls with mode 0400 however:
$ sudo find /proc/sys -perm 0400 | wc -l
0

I find it kind of weird that the bpf sysctls are so tightly locked
down (CAP_SYS_ADMIN && root) even for reading. Maybe something I can
change?

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com

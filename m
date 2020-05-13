Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303BE1D1042
	for <lists+bpf@lfdr.de>; Wed, 13 May 2020 12:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730570AbgEMKuz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 May 2020 06:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbgEMKuz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 May 2020 06:50:55 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC99C061A0C
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 03:50:55 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id g185so16780459qke.7
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 03:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o6RF/R6nRQ24p935e51htzLuDvkMpsHnIopBh1qLWjw=;
        b=NFawZPSY96WEDGV0An6C8cEVv9LnWtImKiszvdFNYCXVeQsIMqj0zPogcRzsak+YA2
         0l2tn3kPOa+7ZrmY02IwaRMihrn4W1zTvxSR95KNG+ZmaADaQ1DoT96Dd8P9rlHB2j5f
         eBiG0FyTo7b6QhaBbNw6G163MBBr5aSp6/SQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o6RF/R6nRQ24p935e51htzLuDvkMpsHnIopBh1qLWjw=;
        b=IfzI1gnMgqIjTvEra5eGZawliHFgwNV5RPTn70UrQ0z2H2PfJuosSUYv63Xz6aWm12
         iLcm+3Cueb1AbYkkj9Oo2MIPpN2u819za37fT3NtiUgeasAo0zLjOmz6oxCeEjhS9PoF
         gU5cqBMqn8BkN4KHzuThpoRJQKN7u4mkYs6Q5LaGc9w1EvqkGRC3e4T+o03TywxOkkrH
         0ne02VInrpObiU5UE+JZiGhM6fL9bWJx5aJjdha6nuH3xvnLlV49x/TT3J51vhfKxSxI
         1T0lRPFV0XUzTIMwpz6e78wl064bh7KSxw4gdpIl1pJen2nqvDRiklOE5sAterOOVA3H
         zyWw==
X-Gm-Message-State: AGi0Pubsg9hPf/JQp5W497ZKhd6QVyI7UHe0lFgIQvdIT9klh55NBONj
        xVLKov4bgzpsfaeVP4ZZTfu81+xjyUAY5c2MrEpR6w==
X-Google-Smtp-Source: APiQypLoXfq1+PMeeoxxa6kAuVOtGxB0PsKlzBMx4xsPyXCS3MOLmm8Q+KsbxzPd2hhJA2wOHbtUTs+v+GidleTZmcs=
X-Received: by 2002:a37:9d4f:: with SMTP id g76mr16242977qke.235.1589367054213;
 Wed, 13 May 2020 03:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200513031930.86895-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20200513031930.86895-1-alexei.starovoitov@gmail.com>
From:   Marek Majkowski <marek@cloudflare.com>
Date:   Wed, 13 May 2020 11:50:42 +0100
Message-ID: <CAJPywT+c8uvi2zgUD_jObmi9T6j50THzjQHg-mudNrEC2HuJvg@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 0/3] Introduce CAP_BPF
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        network dev <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        kernel-team@fb.com, linux-security-module@vger.kernel.org,
        acme@redhat.com, jamorris@linux.microsoft.com,
        Jann Horn <jannh@google.com>, kpsingh@google.com,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 13, 2020 at 4:19 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> CAP_BPF solves three main goals:
> 1. provides isolation to user space processes that drop CAP_SYS_ADMIN and switch to CAP_BPF.
>    More on this below. This is the major difference vs v4 set back from Sep 2019.
> 2. makes networking BPF progs more secure, since CAP_BPF + CAP_NET_ADMIN
>    prevents pointer leaks and arbitrary kernel memory access.
> 3. enables fuzzers to exercise all of the verifier logic. Eventually finding bugs
>    and making BPF infra more secure. Currently fuzzers run in unpriv.
>    They will be able to run with CAP_BPF.
>

Alexei, looking at this from a user point of view, this looks fine.

I'm slightly worried about REUSEPORT_EBPF. Currently without your
patch, as far as I understand it:

- You can load SOCKET_FILTER and SO_ATTACH_REUSEPORT_EBPF without any
permissions

- For loading BPF_PROG_TYPE_SK_REUSEPORT program and for SOCKARRAY map
creation CAP_SYS_ADMIN is needed. But again, no permissions check for
SO_ATTACH_REUSEPORT_EBPF later.

If I read the patchset correctly, the former SOCKET_FILTER case
remains as it is and is not affected in any way by presence or absence
of CAP_BPF.

The latter case is different. Presence of CAP_BPF is sufficient for
map creation, but not sufficient for loading SK_REUSEPORT program. It
still requires CAP_SYS_ADMIN. I think it's a good opportunity to relax
this CAP_SYS_ADMIN requirement. I think the presence of CAP_BPF should
be sufficient for loading BPF_PROG_TYPE_SK_REUSEPORT.

Our specific use case is simple - we want an application program -
like nginx - to control REUSEPORT programs. We will grant it CAP_BPF,
but we don't want to grant it CAP_SYS_ADMIN.

Marek

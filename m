Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA9348E0B0
	for <lists+bpf@lfdr.de>; Thu, 13 Jan 2022 23:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238126AbiAMW47 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Jan 2022 17:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238122AbiAMW45 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Jan 2022 17:56:57 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B432C06161C
        for <bpf@vger.kernel.org>; Thu, 13 Jan 2022 14:56:57 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id g14so19334886ybs.8
        for <bpf@vger.kernel.org>; Thu, 13 Jan 2022 14:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bon9YcmX/y5D1KBEnXS+OkpAMntSiR3cXQ8BTUvnYhM=;
        b=gJjEeWN2CtncUTotnkgzNkHxlG72MyBpgrLJb9Nl2PNDxicwcmCK0a9uCErJ06dpzA
         CQEXTevDF/ZVeyTZXMfu3luczwEvZKZB0OeYNXJzV21s9lo3uhsOj3wPSdSfLYJMeJ7M
         fvhD6aC7wD3rFe9beiG0O+3SYJv4WuEVkdGHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bon9YcmX/y5D1KBEnXS+OkpAMntSiR3cXQ8BTUvnYhM=;
        b=789pRNudHNrmXfI4ZMDQ1HgVOqaT1zyFYRO6SxGelgqbXCis95RB+EgATOHcnkn9JN
         7wz3EMf2xS0fk07IfJ8JV4J8NvAjba6kDZkWicnc0H63+Jer8UFDtxt3jSLt5ycZGzpV
         TjvkrsDmNOxs4aUpdfHXPkB6PPHgECcqxj/ofj1kX8bZn92FSCHYaGGVnHtzKICfSZwf
         NUvu5avpwdDYtKtmiDoeQSqE9gTiKIu7c72TGH7d7Vkpe3LYS7vKBY2LFKVNKi4QT5mC
         gbr8BI5EojJ+7O842nzy1dVOUXfb3FpNEdrKMJQCBmBFw2CX5JeSDYPdwO4KcS//Fb1n
         VdwQ==
X-Gm-Message-State: AOAM531F84yCzpX28emroYI3UVIBsLsylgnUKDzBMNqx8TgFZeuwwagh
        k0yHzGXA3kaLr+68VMTpMw0D7GuI69gwcymjq64SDQ==
X-Google-Smtp-Source: ABdhPJzjrCAifnr19GnfNi4829y4uYxHdb0KmI+Wiwk1pCGhRpocjwX2ciPGWC4WNw2pbw4hx/4vPh/xbofjDbU4c9o=
X-Received: by 2002:a25:5088:: with SMTP id e130mr9213643ybb.158.1642114616327;
 Thu, 13 Jan 2022 14:56:56 -0800 (PST)
MIME-Version: 1.0
References: <20220111192952.49040-1-ivan@cloudflare.com> <CAPhsuW5ynK+XZkUm2jDE2LcpMbqPcQJDJHmFyU_WbBQyBKN38g@mail.gmail.com>
In-Reply-To: <CAPhsuW5ynK+XZkUm2jDE2LcpMbqPcQJDJHmFyU_WbBQyBKN38g@mail.gmail.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Thu, 13 Jan 2022 14:56:45 -0800
Message-ID: <CABWYdi27jpMC=trg1PDzFVPkOUyMshWUzdmKLc7tq35hCnjdAA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] tcp: bpf: Add TCP_BPF_RCV_SSTHRESH for bpf_setsockopt
To:     Song Liu <song@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 11, 2022 at 1:48 PM Song Liu <song@kernel.org> wrote:
>
> I guess this is [1] mentioned above. Please use lore link instead, e.g.
>
> [1] https://lore.kernel.org/all/CABWYdi0qBQ57OHt4ZbRxMtdSzhubzkPaPKkYzdNfu4+cgPyXCA@mail.gmail.com/

Will do in the next iteration, thanks.

> Can we add a selftests for this? Something similar to
>
> tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c

I have the test based on the tcp_rtt selftest. Do you want me to amend
my commit with the test and resend it as v2 or make it a series of two
commits?

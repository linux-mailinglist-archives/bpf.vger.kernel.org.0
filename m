Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4685D1F934
	for <lists+bpf@lfdr.de>; Wed, 15 May 2019 19:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfEORQm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 May 2019 13:16:42 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:33041 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfEORQm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 May 2019 13:16:42 -0400
Received: by mail-lj1-f179.google.com with SMTP id w1so521939ljw.0
        for <bpf@vger.kernel.org>; Wed, 15 May 2019 10:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7IMAbpra3774p61L/4vDDB4PgyeRKUPUxnfljH7HjtQ=;
        b=xoMq/nOTpijLOnljxMxRW9lqGRMEGKLApvgH9TmypEsIWsK46gbZHqi1v6uFstztr9
         T/tMcxkWBArv/dZsjbLDKOR6l1fD1ogYGOoJEkRiQZUfH277khPgQFc6kcxJTXGrfDzg
         OHPY6bO6/lAp/+cC6yEG2DRIdzDWsbHGS6tfPXwpW+unxI+LWbvdNQQrTkt87BuIAYsw
         PSLR9mkCi7hcmTeG6IFEAgLUyHivRrNSp6dbPKjG8Mx9giEQr6VeO1KkSLb1tTB20ziz
         YKjEOCIVRRsftirq2s+mjUNqz/g82mrnai7Z+rJ1zqtCRkjfcz3npcKfqLh6ZBNhVFeN
         kdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7IMAbpra3774p61L/4vDDB4PgyeRKUPUxnfljH7HjtQ=;
        b=o961tqss1u6nc6Bu/D0IQmuzKxeHYElzPPuhSFUNyfLvzXjiNT3r9TBr4Ltcj0eeDB
         rPYOwK36QCrTISWcmieT1844zOB9/3PtzLx3Q2KclFgvRA4chXXs3eDjN3CT+PfxXOvF
         /0c+TWoIl3MDYiIlxJavLKemrF/2SXUwI8GB2uOvAUGwLckqEPtYnsAN4abdeQKz+KE0
         r3nCNmajZLbBCBoujQ1cA2jAST7YptAIy6q+3kAdcLjlMkdpSArmzFlYZuDvXfdpw5ro
         FX5nT5ygx3xrJL4zz3pK7Jw82Am4hmmd4a5o8Pix8DzUQl2zOjJHmAPGMDURdUsHkMuB
         cllg==
X-Gm-Message-State: APjAAAVPKzxM/gKORB79DFdHesSx3g7TCARc412Ul+sCMrZcJHWwHLJ6
        ioJlT6Q8cDCKUYw2QLc2XwOcePCBoXp20fQSOrtRxA==
X-Google-Smtp-Source: APXvYqyz7/kA5KfuOO18SbqqBo7rEHduAbQKnz90SKQefP4XJtZ0eyWNcuLRj1AwY+IB/PK+U1H9TYP1oVNmsh6DC08=
X-Received: by 2002:a2e:206:: with SMTP id 6mr19037300ljc.59.1557940600154;
 Wed, 15 May 2019 10:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <CACAyw98+qycmpQzKupquhkxbvWK4OFyDuuLMBNROnfWMZxUWeA@mail.gmail.com>
In-Reply-To: <CACAyw98+qycmpQzKupquhkxbvWK4OFyDuuLMBNROnfWMZxUWeA@mail.gmail.com>
From:   Joe Stringer <joe@isovalent.com>
Date:   Wed, 15 May 2019 10:16:28 -0700
Message-ID: <CADa=RyyuAOupK7LOydQiNi6tx2ELOgD+bdu+DHh3xF0dDxw_gw@mail.gmail.com>
Subject: Re: RFC: Fixing SK_REUSEPORT from sk_lookup_* helpers
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 15, 2019 at 8:11 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> In the BPF-based TPROXY session with Joe Stringer [1], I mentioned
> that the sk_lookup_* helpers currently return inconsistent results if
> SK_REUSEPORT programs are in play.
>
> SK_REUSEPORT programs are a hook point in inet_lookup. They get access
> to the full packet
> that triggered the look up. To support this, inet_lookup gained a new
> skb argument to provide such context. If skb is NULL, the SK_REUSEPORT
> program is skipped and instead the socket is selected by its hash.
>
> The first problem is that not all callers to inet_lookup from BPF have
> an skb, e.g. XDP. This means that a look up from XDP gives an
> incorrect result. For now that is not a huge problem. However, once we
> get sk_assign as proposed by Joe, we can end up circumventing
> SK_REUSEPORT.

To clarify a bit, the reason this is a problem is that a
straightforward implementation may just consider passing the skb
context into the sk_lookup_*() and through to the inet_lookup() so
that it would run the SK_REUSEPORT BPF program for socket selection on
the skb when the packet-path BPF program performs the socket lookup.
However, as this paragraph describes, the skb context is not always
available.

> At the conference, someone suggested using a similar approach to the
> work done on the flow dissector by Stanislav: create a dedicated
> context sk_reuseport which can either take an skb or a plain pointer.
> Patch up load_bytes to deal with both. Pass the context to
> inet_lookup.
>
> This is when we hit the second problem: using the skb or XDP context
> directly is incorrect, because it assumes that the relevant protocol
> headers are at the start of the buffer. In our use case, the correct
> headers are at an offset since we're inspecting encapsulated packets.
>
> The best solution I've come up with is to steal 17 bits from the flags
> argument to sk_lookup_*, 1 bit for BPF_F_HEADERS_AT_OFFSET, 16bit for
> the offset itself.

FYI there's also the upper 32 bits of the netns_id parameter, another
option would be to steal 16 bits from there.

> Thoughts?

Internally with skbs, we use `skb_pull()` to manage header offsets,
could we do something similar with `bpf_xdp_adjust_head()` prior to
the call to `bpf_sk_lookup_*()`?

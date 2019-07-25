Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E023E75512
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2019 19:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbfGYRF0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Jul 2019 13:05:26 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43790 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728144AbfGYRFZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Jul 2019 13:05:25 -0400
Received: by mail-qt1-f194.google.com with SMTP id w17so5470004qto.10
        for <bpf@vger.kernel.org>; Thu, 25 Jul 2019 10:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ut6hFBrFnGKe0mpKp6qcHRNZGdFalNpeh95hk6/89Ss=;
        b=ItPHLPmOwn5mUXNzueE9TRwwcQAQhJcH0Sv0IfwvePdyCoJv9IyEHnvLMH0BSvjJBZ
         3nrv+KtM63EY8uCQzyXZbvbaVWMUs72dp0NHpG7vxfMF/uB/vUoBPxe2IipeO79kUIKx
         iWPYW3XvpN4WgOl6PK3JhrgO1EZ6oqzVv2wi5vrxKqELpqmFGHbcT6Cd4CeBoV4DZaXq
         /gG9aGzTHHcKgWfKcSRx1VUXYARTqJWxdv+/CoBK/JyG+5AQ+PcE3tvE2TILMbBJhc7b
         R1kNwl843mauGbTCzBBvR9bEL6edSEytHdWsGWoNeVHCNXMaH95kQ1a1hL2tFvMAnfr6
         G7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ut6hFBrFnGKe0mpKp6qcHRNZGdFalNpeh95hk6/89Ss=;
        b=eq5Q8SPeSnT+P7kRokCc2+huQ4Sxm4TthfIP+oXVL4LSDK4Y3foLcDUtzUk8fhY5fC
         Jz8g2er3/L7UyYOPzny7uqxfMw/uZA85ZSWNTV7WadJ2As8EvXiap1BXvDgQZn5lE5tp
         DGVzbQJ5nAOP6waK/+vIjj/B+T4eOmFoTw6vOETi96BgQzbe98qDVVJ/VAqSYxo1ru0B
         TZ7cUlpsL46FIbODEQNyAEiZIxn2GUcN2ZyE/AHifOuv9mfTaAGSgrkvClhWX7Pmj5k8
         g+9nOeUHiRnK+Q5cOyCAYE+7qbOJc59YJ7pQyv0wIKPTBct4ULW8um+B9R6DEBuE/BLn
         nPrw==
X-Gm-Message-State: APjAAAVs95+ql2zz+BMEPZaG23SgJrUI2oTV7U4eyy6SkRWEO0M5SwME
        G3dxQxfug18hoi7C7UPKgI3y6xtzljaVYNIaiuMOetPosRw=
X-Google-Smtp-Source: APXvYqzgEoRAqKMO9PTHDW3sV+Uw58MVcPR9KD6txH/Ae/GwAGQtpefaeIvnWFCEInHk4TvYm1HwBeXWvjd36h644FM=
X-Received: by 2002:ac8:688f:: with SMTP id m15mr6753317qtq.26.1564074324811;
 Thu, 25 Jul 2019 10:05:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190725153342.3571-1-sdf@google.com>
In-Reply-To: <20190725153342.3571-1-sdf@google.com>
From:   Petar Penkov <ppenkov@google.com>
Date:   Thu, 25 Jul 2019 10:05:12 -0700
Message-ID: <CAG4SDVVe5s-MZJDQjMGS9_QkTnSsaP7MRuxXs-AHp8bA6sSiPA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/7] bpf/flow_dissector: support input flags
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thanks! For the series:

Acked-by: Petar Penkov <ppenkov@google.com>

On Thu, Jul 25, 2019 at 8:33 AM Stanislav Fomichev <sdf@google.com> wrote:
>
> C flow dissector supports input flags that tell it to customize parsing
> by either stopping early or trying to parse as deep as possible.
> BPF flow dissector always parses as deep as possible which is sub-optimal.
> Pass input flags to the BPF flow dissector as well so it can make the same
> decisions.
>
> Series outline:
> * remove unused FLOW_DISSECTOR_F_STOP_AT_L3 flag
> * export FLOW_DISSECTOR_F_XXX flags as uapi and pass them to BPF
>   flow dissector
> * add documentation for the export flags
> * support input flags in BPF_PROG_TEST_RUN via ctx_{in,out}
> * sync uapi to tools
> * support FLOW_DISSECTOR_F_PARSE_1ST_FRAG in selftest
> * support FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL in kernel and selftest
> * support FLOW_DISSECTOR_F_STOP_AT_ENCAP in selftest
>
> Pros:
> * makes BPF flow dissector faster by avoiding burning extra cycles
> * existing BPF progs continue to work by ignoring the flags and always
>   parsing as deep as possible
>
> Cons:
> * new UAPI which we need to support (OTOH, if we need to deprecate some
>   flags, we can just stop setting them upon calling BPF programs)
>
> Some numbers (with .repeat = 4000000 in test_flow_dissector):
>         test_flow_dissector:PASS:ipv4-frag 35 nsec
>         test_flow_dissector:PASS:ipv4-frag 35 nsec
>         test_flow_dissector:PASS:ipv4-no-frag 32 nsec
>         test_flow_dissector:PASS:ipv4-no-frag 32 nsec
>
>         test_flow_dissector:PASS:ipv6-frag 39 nsec
>         test_flow_dissector:PASS:ipv6-frag 39 nsec
>         test_flow_dissector:PASS:ipv6-no-frag 36 nsec
>         test_flow_dissector:PASS:ipv6-no-frag 36 nsec
>
>         test_flow_dissector:PASS:ipv6-flow-label 36 nsec
>         test_flow_dissector:PASS:ipv6-flow-label 36 nsec
>         test_flow_dissector:PASS:ipv6-no-flow-label 33 nsec
>         test_flow_dissector:PASS:ipv6-no-flow-label 33 nsec
>
>         test_flow_dissector:PASS:ipip-encap 38 nsec
>         test_flow_dissector:PASS:ipip-encap 38 nsec
>         test_flow_dissector:PASS:ipip-no-encap 32 nsec
>         test_flow_dissector:PASS:ipip-no-encap 32 nsec
>
> The improvement is around 10%, but it's in a tight cache-hot
> BPF_PROG_TEST_RUN loop.
>
> Cc: Song Liu <songliubraving@fb.com>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Petar Penkov <ppenkov@google.com>
>
> Stanislav Fomichev (7):
>   bpf/flow_dissector: pass input flags to BPF flow dissector program
>   bpf/flow_dissector: document flags
>   bpf/flow_dissector: support flags in BPF_PROG_TEST_RUN
>   tools/bpf: sync bpf_flow_keys flags
>   selftests/bpf: support FLOW_DISSECTOR_F_PARSE_1ST_FRAG
>   bpf/flow_dissector: support ipv6 flow_label and
>     FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL
>   selftests/bpf: support FLOW_DISSECTOR_F_STOP_AT_ENCAP
>
>  Documentation/bpf/prog_flow_dissector.rst     |  18 ++
>  include/linux/skbuff.h                        |   2 +-
>  include/net/flow_dissector.h                  |   4 -
>  include/uapi/linux/bpf.h                      |   6 +
>  net/bpf/test_run.c                            |  39 ++-
>  net/core/flow_dissector.c                     |  14 +-
>  tools/include/uapi/linux/bpf.h                |   6 +
>  .../selftests/bpf/prog_tests/flow_dissector.c | 242 +++++++++++++++++-
>  tools/testing/selftests/bpf/progs/bpf_flow.c  |  46 +++-
>  9 files changed, 359 insertions(+), 18 deletions(-)
>
> --
> 2.22.0.657.g960e92d24f-goog

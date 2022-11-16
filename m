Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553A862CC25
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 22:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239184AbiKPVDS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 16:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239388AbiKPVC3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 16:02:29 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1F99FFE
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 13:02:18 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id e205so15481185oif.11
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 13:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dJGyiz6sBw12AXz5rGCGf6xcUKkAjFEFJsumKIXyzec=;
        b=keCVkLq8bDSdd8IajRnq88FW2nMYq9qV0GSdzvWLnvi5OD9Rpt5QKcJhb8/cfAy46S
         vUAZdiqjnVxUYZDvBZms1YvulD5kGEzd2NBUi56kTWP9PrpLRz+7/tmJyXIUY2+RHCd6
         SNFxLtVICbeUq1j2N/UNLDehJO0D5V2j9iM9OQLayeYXA71cCMAI2Oq8NCidPaHibNlg
         A8zgTRgM1LZC6Kxr9hbOzgYQMrzesOjvMFXeE+bqiCNiMEI+CoC0ENJ4PZMuTjMOIVMZ
         KHMY4OSWqvtQkgDiqN9i6gDo89jXMMa1AY8ykjh5VDmFH74bCofhtx8rVwdg869o/xzs
         UGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dJGyiz6sBw12AXz5rGCGf6xcUKkAjFEFJsumKIXyzec=;
        b=NBP/N3JkcbSk+NW9YNG7TEF9S897XUto7CWerHiKAi+TXeyFS4iuU8/0gsu+7FXOZb
         j1s2a2GhTXoszrPhrJxKXBWuStzm4tElQcodLjrpBes63Xtrpnq7V0efDi1W8LxoxdeE
         5XFWakLUOqu98NI6MVgj1b8zAxYxfZH7+4tQ1DOHrfZnGXwSNYS+oyXRvjFwEB3dzE2d
         6emOtfju0Umu1ifwGYkuzyRnBvbP+ZGfzlsYOnoz4kokeF9CHLk3HwmxXZE5NxUo/pan
         zueZogvpk3AQadisWuiadzpFiS+YZvzWrULKGlh8xef/e63VgQip3nFfQeD+Gn3J4sSm
         0reg==
X-Gm-Message-State: ANoB5pm2je/Ei4ooYuzogCWNTEJ9TGsmbpaj6daM312tL3yaoqZa65iL
        Wn2401uV2pIppg+x30IHFKZvptZzq1DreoXHahTzJw==
X-Google-Smtp-Source: AA0mqf7taB/KSnDALJTWs7sNcF1giwfzNPf5lF9dlXI7f/eUKu8kenx9mrfSyTu1QUSckhTnhfxHY93L1qtj/zG0nio=
X-Received: by 2002:a05:6808:159c:b0:354:8922:4a1a with SMTP id
 t28-20020a056808159c00b0035489224a1amr2528717oiw.181.1668632537793; Wed, 16
 Nov 2022 13:02:17 -0800 (PST)
MIME-Version: 1.0
References: <20221115031031.3281094-1-sdf@google.com> <20221115031031.3281094-2-sdf@google.com>
 <b5540340-85a7-6809-5f37-1509bbf9a142@linux.dev>
In-Reply-To: <b5540340-85a7-6809-5f37-1509bbf9a142@linux.dev>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 16 Nov 2022 13:02:06 -0800
Message-ID: <CAKH8qBseAQn9VsrKFifF-CZou-MBzC8QNiGfuDSOVWQUsMrhUA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Make sure zero-len skbs
 aren't redirectable
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
        jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 16, 2022 at 12:38 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> On 11/14/22 7:10 PM, Stanislav Fomichev wrote:
> > LWT_XMIT to test L3 case, TC to test L2 case.
>
> It will be useful to add more details here to explain which test is testing the
> skb->len check in __bpf_redirect_no_mac() and __bpf_redirect_common() in patch 1.

SG, will try to annotate.

> >
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >   .../selftests/bpf/prog_tests/empty_skb.c      | 140 ++++++++++++++++++
> >   tools/testing/selftests/bpf/progs/empty_skb.c |  37 +++++
> >   2 files changed, 177 insertions(+)
> >   create mode 100644 tools/testing/selftests/bpf/prog_tests/empty_skb.c
> >   create mode 100644 tools/testing/selftests/bpf/progs/empty_skb.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/empty_skb.c b/tools/testing/selftests/bpf/prog_tests/empty_skb.c
> > new file mode 100644
> > index 000000000000..6e35739babed
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/empty_skb.c
> > @@ -0,0 +1,140 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <test_progs.h>
> > +#include <network_helpers.h>
> > +#include <net/if.h>
> > +#include "empty_skb.skel.h"
> > +
> > +#define SYS(cmd) ({ \
> > +     if (!ASSERT_OK(system(cmd), (cmd))) \
> > +             goto out; \
> > +})
> > +
> > +void test_empty_skb(void)
> > +{
> > +     LIBBPF_OPTS(bpf_test_run_opts, tattr);
> > +     struct empty_skb *bpf_obj = NULL;
> > +     struct nstoken *tok = NULL;
> > +     struct bpf_program *prog;
> > +     char eth_hlen_pp[15];
> > +     char eth_hlen[14];
> > +     int veth_ifindex;
> > +     int ipip_ifindex;
> > +     int err;
> > +     int i;
> > +
> > +     struct {
> > +             const char *msg;
> > +             const void *data_in;
> > +             __u32 data_size_in;
> > +             int *ifindex;
> > +             int err;
> > +             int ret;
> > +             bool success_on_tc;
> > +     } tests[] = {
> > +             /* Empty packets are always rejected. */
> > +
> > +             {
> > +                     .msg = "veth empty ingress packet",
> > +                     .data_in = NULL,
> > +                     .data_size_in = 0,
> > +                     .ifindex = &veth_ifindex,
> > +                     .err = -EINVAL,
> > +             },
> > +             {
> > +                     .msg = "ipip empty ingress packet",
> > +                     .data_in = NULL,
> > +                     .data_size_in = 0,
> > +                     .ifindex = &ipip_ifindex,
> > +                     .err = -EINVAL,
> > +             },
>
>
> > +
> > +             /* ETH_HLEN-sized packets:
> > +              * - can not be redirected at LWT_XMIT
> > +              * - can be redirected at TC
> > +              */
> > +
> > +             {
> > +                     .msg = "veth ETH_HLEN packet ingress",
> > +                     .data_in = eth_hlen,
> > +                     .data_size_in = sizeof(eth_hlen),
> > +                     .ifindex = &veth_ifindex,
> > +                     .ret = -ERANGE,
> > +                     .success_on_tc = true,
> > +             },
> > +             {
> > +                     .msg = "ipip ETH_HLEN packet ingress",
> > +                     .data_in = eth_hlen,
> > +                     .data_size_in = sizeof(eth_hlen),
> > +                     .ifindex = &veth_ifindex,
> > +                     .ret = -ERANGE,
> > +                     .success_on_tc = true,
> > +             },
>
>
> hmm... these two tests don't look right.  They are the same except the ".msg"
> part.  The latter one should use &ipip_ifindex?

Oh, good catch!

> > +
> > +             /* ETH_HLEN+1-sized packet should be redirected. */
> > +
> > +             {
> > +                     .msg = "veth ETH_HLEN+1 packet ingress",
> > +                     .data_in = eth_hlen_pp,
> > +                     .data_size_in = sizeof(eth_hlen_pp),
> > +                     .ifindex = &veth_ifindex,
> > +             },
> > +             {
> > +                     .msg = "ipip ETH_HLEN+1 packet ingress",
> > +                     .data_in = eth_hlen_pp,
> > +                     .data_size_in = sizeof(eth_hlen_pp),
> > +                     .ifindex = &veth_ifindex,
> > +             },
>
> Same here.
>

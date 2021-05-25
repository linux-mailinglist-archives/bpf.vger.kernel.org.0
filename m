Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6689D38FF76
	for <lists+bpf@lfdr.de>; Tue, 25 May 2021 12:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhEYKpX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 May 2021 06:45:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47417 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhEYKpX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 May 2021 06:45:23 -0400
Received: from mail-pg1-f200.google.com ([209.85.215.200])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1llUXQ-0003F1-9i
        for bpf@vger.kernel.org; Tue, 25 May 2021 10:43:52 +0000
Received: by mail-pg1-f200.google.com with SMTP id 1-20020a6306010000b0290215c617f0f8so20748457pgg.8
        for <bpf@vger.kernel.org>; Tue, 25 May 2021 03:43:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U7p+WdCrLEBx/FiI7skBf0U0P+IdeMCYAYyt9GXvbf4=;
        b=aREgRHe3ukqrj7yRWxiQJf6Mq11gxfJH7qx/2glxqL2uxUv2ErdML0kNg5DxOfZt2X
         NepgWFxP4mFSbXmz32r1PT7SAzqAej8OzodTVtkvwQb5YXrCyG2o9pzZCwhTpUr1S/ow
         d9AzXfb6xKMCdJht6x66/pCXGORiSM8r618hm9d6tvdVdKJVV2Cc3L0pQKRJy4MyuZlc
         IvlRsva+r6dxUR0K9GK5QOTSe7Eufk/RkpBRiryzm0iUix4wNSgnlAX0eHkveNls+fWg
         9pjigsG1/lsyeSgQwNsT4iVRCxfWAMVoqQ/5mhYd9jj10xBqgzSz8KUAj2mw6nZ7eP7U
         X00Q==
X-Gm-Message-State: AOAM533yYE0oosP4QZJmrQZYQ0kCwFXknPZnStSJvYiX7E1SVED4dPli
        TdrzuZK2RBeXJ4/JaNND5kCoAtJG9vZmI8XVZ28YV9wmqOu+K0RlvG3LoBhkE99rEf4dCqb7t9H
        rxu4qV0/ZM8jK1VL8fPhQd9aBgoC95BYA0mESWwaqUMYr
X-Received: by 2002:a17:90a:a395:: with SMTP id x21mr29859622pjp.63.1621939430967;
        Tue, 25 May 2021 03:43:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywHhaYkcm8fw4QivOp+4ibSJhb7az85BNgj13lNR58+4o7jczroKXrakihNHnjiG4KWZaVv+EJkjCk6vgwBtM=
X-Received: by 2002:a17:90a:a395:: with SMTP id x21mr29859587pjp.63.1621939430616;
 Tue, 25 May 2021 03:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210525061724.13526-1-po-hsu.lin@canonical.com> <87lf83cdyj.fsf@nvidia.com>
In-Reply-To: <87lf83cdyj.fsf@nvidia.com>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Tue, 25 May 2021 18:43:39 +0800
Message-ID: <CAMy_GT9iCU+BJLp_mVALkyBwnzV8fCJQawRJqk_pFvKV=7TU1A@mail.gmail.com>
Subject: Re: [PATCH] selftests: Use kselftest skip code for skipped tests
To:     Petr Machata <petrm@nvidia.com>
Cc:     linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, hawk@kernel.org,
        nikolay@nvidia.com, gnault@redhat.com, vladimir.oltean@nxp.com,
        idosch@nvidia.com, baowen.zheng@corigine.com, danieller@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 25, 2021 at 6:20 PM Petr Machata <petrm@nvidia.com> wrote:
>
>
> Po-Hsu Lin <po-hsu.lin@canonical.com> writes:
>
> > diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> > index 42e28c9..eed9f08 100644
> > --- a/tools/testing/selftests/net/forwarding/lib.sh
> > +++ b/tools/testing/selftests/net/forwarding/lib.sh
> > @@ -4,6 +4,9 @@
> >  ##############################################################################
> >  # Defines
> >
> > +# Kselftest framework requirement - SKIP code is 4.
> > +ksft_skip=4
> > +
> >  # Can be overridden by the configuration file.
> >  PING=${PING:=ping}
> >  PING6=${PING6:=ping6}
> > @@ -121,7 +124,7 @@ check_ethtool_lanes_support()
> >
> >  if [[ "$(id -u)" -ne 0 ]]; then
> >       echo "SKIP: need root privileges"
> > -     exit 0
> > +     exit $ksft_skip
> >  fi
> >
> >  if [[ "$CHECK_TC" = "yes" ]]; then
> > diff --git a/tools/testing/selftests/net/forwarding/router_mpath_nh.sh b/tools/testing/selftests/net/forwarding/router_mpath_nh.sh
> > index 76efb1f..bb7dc6d 100755
> > --- a/tools/testing/selftests/net/forwarding/router_mpath_nh.sh
> > +++ b/tools/testing/selftests/net/forwarding/router_mpath_nh.sh
> > @@ -1,6 +1,9 @@
> >  #!/bin/bash
> >  # SPDX-License-Identifier: GPL-2.0
> >
> > +# Kselftest framework requirement - SKIP code is 4.
> > +ksft_skip=4
> > +
> >  ALL_TESTS="
> >       ping_ipv4
> >       ping_ipv6
> > @@ -411,7 +414,7 @@ ping_ipv6()
> >  ip nexthop ls >/dev/null 2>&1
> >  if [ $? -ne 0 ]; then
> >       echo "Nexthop objects not supported; skipping tests"
> > -     exit 0
> > +     exit $ksft_skip
> >  fi
> >
> >  trap cleanup EXIT
>
> router_mpath_nh.sh sources lib.sh, which you changed above. This hunk
> should not be necessary.

Hello Petr,
Nice catch, I will remove the following lines in those script that
sources lib.sh:
 +# Kselftest framework requirement - SKIP code is 4.
 +ksft_skip=4
 +

Will prepare V2 later, thanks!

>
> > diff --git a/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh b/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh
> > index 4898dd4..e7bb976 100755
> > --- a/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh
> > +++ b/tools/testing/selftests/net/forwarding/router_mpath_nh_res.sh
> > @@ -1,6 +1,9 @@
> >  #!/bin/bash
> >  # SPDX-License-Identifier: GPL-2.0
> >
> > +# Kselftest framework requirement - SKIP code is 4.
> > +ksft_skip=4
> > +
> >  ALL_TESTS="
> >       ping_ipv4
> >       ping_ipv6
> > @@ -386,7 +389,7 @@ ping_ipv6()
> >  ip nexthop ls >/dev/null 2>&1
> >  if [ $? -ne 0 ]; then
> >       echo "Nexthop objects not supported; skipping tests"
> > -     exit 0
> > +     exit $ksft_skip
> >  fi
> >
> >  trap cleanup EXIT
>
> Likewise.
>
> Unless I'm missing some indirect dependency, no other selftests in your
> patch have this problem.

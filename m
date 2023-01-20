Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5721E6760AE
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 23:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjATWt5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 17:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjATWtt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 17:49:49 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29FA4F85A
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 14:49:07 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id jm10so6538542plb.13
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 14:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XJ/yFU30ZaQe7SL+ifPv01udy7zfExyq62P60UgZOOM=;
        b=EWy4p9fpkVDvnKrvL23gY7/UdWJ4nXCW8t95seG1lCX5b+N5ogCc13KaYYZmNUPrnw
         Wb48KEl99T9w6w33UffoirV7BYzVJbDWpDonfyn+5JuN8wLfk0ch/5vIpzN5IfV28+tj
         0oRRtfNLg2wf7UiRgZrfUIoU+JnsyVb9yCupDLYoQVQKBQkqpO3l/IKhupQY/f8aMUxc
         pbvdoJ0x1ilew29ZEJM2+0p4rJjwedBlxuu999V+j3pi6bZ0OUmU1sDXc0g9HoOwgBbP
         gUruZoXmYLlAZf+AlB/kYAsOjzR0fvYSOXC/h4SasTsWhEK/pzMkXfvCAGIz8T0Al1IC
         cRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XJ/yFU30ZaQe7SL+ifPv01udy7zfExyq62P60UgZOOM=;
        b=UytY5nI1DEGjPXCm4zzC49eZeFZJI5CP+q+mTCuxSUNYI1dUYPvhIerWepeDPj4fF3
         6neNQgd1QA/GCQRslaP/MvwD843mCcvUDNbB6+pij1pu34s52PuzzuO1K0oiZUZYrQzv
         xp/3cjpxz7/vjA/LYbSmp8NKxvhBozypzP+vGMr2cbuFtQvfCDsWKsD+oVjTVbRYFwH3
         qTpEDCqZ3rOz3WeWsHiMJH2d13wpw7qBQXDP+P8irlzIiZr3KgrtXSu2m9LJl4N2OC1u
         5h6GWld9x2NY8xr7eQOuPIBA3Vvb8u5R3z9Ba/k11FaymFg00VkdZIE9o0tpIEWR8zG0
         KYUg==
X-Gm-Message-State: AFqh2krhhU3MJwbgLNRtbZCKUsJaT6uiQgbGEr7P4MJGk9bIrrYaqc6s
        BpAH8Fmfx6A36XdFZ5mShBSoOxeBEEd0ubP+lniCbg==
X-Google-Smtp-Source: AMrXdXvQ0aVvDS0bOzE/h5aifh1HB4xJ8ZZ5kVJQikQZhvYxpafJo91ID7/8ufBLPKxHJ0ByucCr+0vV93sQkychbjg=
X-Received: by 2002:a17:90a:3fc1:b0:218:9107:381b with SMTP id
 u1-20020a17090a3fc100b002189107381bmr1734374pjm.75.1674254923608; Fri, 20 Jan
 2023 14:48:43 -0800 (PST)
MIME-Version: 1.0
References: <20230119221536.3349901-1-sdf@google.com> <20230119221536.3349901-12-sdf@google.com>
 <833e21d0-c320-7fac-0723-4791c9097f38@linux.dev>
In-Reply-To: <833e21d0-c320-7fac-0723-4791c9097f38@linux.dev>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 20 Jan 2023 14:48:31 -0800
Message-ID: <CAKH8qBtaH0uN9WJ_rhD5bHynvsGjrXK4X61fA+pa8kJwjxxwhQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 11/17] selftests/bpf: Verify xdp_metadata
 xdp->af_xdp path
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org
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

On Fri, Jan 20, 2023 at 2:19 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> On 1/19/23 2:15 PM, Stanislav Fomichev wrote:
> > - create new netns
> > - create veth pair (veTX+veRX)
> > - setup AF_XDP socket for both interfaces
> > - attach bpf to veRX
> > - send packet via veTX
> > - verify the packet has expected metadata at veRX
> >
> > Cc: John Fastabend <john.fastabend@gmail.com>
> > Cc: David Ahern <dsahern@gmail.com>
> > Cc: Martin KaFai Lau <martin.lau@linux.dev>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Willem de Bruijn <willemb@google.com>
> > Cc: Jesper Dangaard Brouer <brouer@redhat.com>
> > Cc: Anatoly Burakov <anatoly.burakov@intel.com>
> > Cc: Alexander Lobakin <alexandr.lobakin@intel.com>
> > Cc: Magnus Karlsson <magnus.karlsson@gmail.com>
> > Cc: Maryam Tahhan <mtahhan@redhat.com>
> > Cc: xdp-hints@xdp-project.net
> > Cc: netdev@vger.kernel.org
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >   tools/testing/selftests/bpf/Makefile          |   2 +-
> >   .../selftests/bpf/prog_tests/xdp_metadata.c   | 410 ++++++++++++++++++
> The test cannot be run in s390x, so it needs to be in DENYLIST.s390x.

Ahh, good point, will add, thanks!

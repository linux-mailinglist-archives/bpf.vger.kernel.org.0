Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46AD5786C5
	for <lists+bpf@lfdr.de>; Mon, 18 Jul 2022 17:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbiGRPx5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jul 2022 11:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiGRPx4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jul 2022 11:53:56 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00492602
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 08:53:51 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id b6so6872336wmq.5
        for <bpf@vger.kernel.org>; Mon, 18 Jul 2022 08:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=6Q1RAnyAxwLjG00r5y2VCpMSmEQovk1Zj9+ilrsOxdE=;
        b=7eMTPGp9S2ynWUngPjXvg/584bl+OFyZNXFRwPKegz8BO1CBZU16/VcWrOnDGus8Lp
         JrH3yWerWrK/KO13BFXjbY42aVCA9mIy54I/gEPdvrzZ+5YUJOI61xnX6JE8Fglmvg9f
         HOl5YKSqbSwtkrYyxKVWszeJHdzGNv+Dh/T3SBfAaAgrY736PDaXNDj2uF2hNIPYN0zp
         Q8dR3VPNU7AVVJ2jreOkbxovsQX9T4LSHtN+AwcfeGM1gsNEIxLyL7HaMiUTQuJeUMwf
         UmWfEi8XGHuJaEN+3cDUwhhuY3C1DE4p9ZCY6fHuz4gMXFr9omMrXnw28zzEcgKb+1bk
         CtdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=6Q1RAnyAxwLjG00r5y2VCpMSmEQovk1Zj9+ilrsOxdE=;
        b=QQwWdjUKhjsr079/6UkZN8In5s/VZzQqtPx2AVhX+e+bX3z/iB9WoQMI/xcGrukOHk
         DpRWiRgICJ7sZDJUBg3eQLgAUtOtDrCq79UEuJA/pVjRmrXmbLggRHN/t/FNTsdl/e9e
         QUcu4ZQcXxfP4Z94i6+w3h3me5w0vxSaY8UnHfNjGqdGmdLZw4MNwcKka9QqV4Wzh3Rr
         8SgnabT5u1g/T03EitBQAV9yYtK6CcgZ0preHOClkmF4PKnTQXvEC+MlBM5ZpksWR7ye
         cVEk5I0shVtTbdUJHb/RpNGQTGr26RtA6dT6BZfUjR2pp5IyP1jg6sjklyFblOGPr/vd
         6lug==
X-Gm-Message-State: AJIora/KwjdIWPvsXEIqvlgl22yKyqBOBSLbTr1WXln4rXi3W+l1rjhd
        14EIesoi0Tt8ylAFnSPvBy9B
X-Google-Smtp-Source: AGRyM1t+Y/Ql2ODu8Q+pRN463xBoeNGWsYMXH6kgELqNXXq0jJ1wR6pHuGQ7+ynq6PXZvQr+Nytl/Q==
X-Received: by 2002:a7b:ca57:0:b0:3a3:205d:2533 with SMTP id m23-20020a7bca57000000b003a3205d2533mr1938001wml.67.1658159630492;
        Mon, 18 Jul 2022 08:53:50 -0700 (PDT)
Received: from Mem (2a01cb088160fc006422ad4f4c265774.ipv6.abo.wanadoo.fr. [2a01:cb08:8160:fc00:6422:ad4f:4c26:5774])
        by smtp.gmail.com with ESMTPSA id q18-20020adfdfd2000000b0021bbdc3375fsm11058603wrn.68.2022.07.18.08.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 08:53:50 -0700 (PDT)
Date:   Mon, 18 Jul 2022 17:53:48 +0200
From:   Paul Chaignon <paul@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <martin.lau@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        Kaixi Fan <fankaixi.li@bytedance.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf v2 0/5] bpf: Allow any source IP in bpf_skb_set_tunnel_key
Message-ID: <cover.1658159533.git.paul@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 26101f5ab6bd ("bpf: Add source ip in "struct bpf_tunnel_key"")
added support for getting and setting the outer source IP of encapsulated
packets via the bpf_skb_{get,set}_tunnel_key BPF helper. This change
allows BPF programs to set any IP address as the source, including for
example the IP address of a container running on the same host.

In that last case, however, the encapsulated packets are dropped when
looking up the route because the source IP address isn't assigned to any
interface on the host. To avoid this, we need to set the
FLOWI_FLAG_ANYSRC flag.

Changes in v2:
  - Removed changes to IPv6 code paths as they are unnecessary.

Paul Chaignon (5):
  ip_tunnels: Add new flow flags field to ip_tunnel_key
  vxlan: Use ip_tunnel_key flow flags in route lookups
  geneve: Use ip_tunnel_key flow flags in route lookups
  bpf: Set flow flag to allow any source IP in bpf_tunnel_key
  selftests/bpf: Don't assign outer source IP to host

 drivers/net/geneve.c                                 |  1 +
 drivers/net/vxlan/vxlan_core.c                       | 11 +++++++----
 include/net/ip_tunnels.h                             |  1 +
 net/core/filter.c                                    |  1 +
 tools/testing/selftests/bpf/prog_tests/test_tunnel.c |  1 -
 5 files changed, 10 insertions(+), 5 deletions(-)

-- 
2.25.1


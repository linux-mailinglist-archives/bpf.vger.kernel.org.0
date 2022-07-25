Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40F85800BC
	for <lists+bpf@lfdr.de>; Mon, 25 Jul 2022 16:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbiGYObP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Jul 2022 10:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbiGYObO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jul 2022 10:31:14 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802ACBC1B
        for <bpf@vger.kernel.org>; Mon, 25 Jul 2022 07:31:11 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h8so16232305wrw.1
        for <bpf@vger.kernel.org>; Mon, 25 Jul 2022 07:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=SZEdKt3NPH9qVcYSfhPFXnFmaQRMdCaZikV9avg1yi0=;
        b=t4pUXQKxvv8PcOIu7CyQckFVJpxcGcEAiGGw/qdtQp6uBiE5Ebj8l0IVuodTkoNbdv
         t796lVFBHvD6Bo0jt3KpkiE4/tMfzD6kJYAnPpSxX74DrDbl7UctNhLFnB62L+Wqwxkr
         DbmRADXPd+iw7tPiHv8SJ9oik4uUtT9uzbfywlorjNn+a/nPvpkucZAyen1qdkSE2Epk
         41F2l0BZQCv9TH1NF7eOiD/+WUMUD2XsU1ktPCXgFT6HyGgyeoUtzqBvocE6mqtveWZg
         N1nv1lnre53hq9h/ARC//VgS/LMRfaPxVTFytyHOdctToDY4ACow0jxX2/fKJeBXPPwI
         KEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=SZEdKt3NPH9qVcYSfhPFXnFmaQRMdCaZikV9avg1yi0=;
        b=WkR5Q7YhrBbLCIIVlgV46Gkpteo+kezIN+j65LjPXQIHNw3YQ/ZfoPtAR+eq9LQ3XG
         zXdt5tWnLCyfjigbR+s3XM7nGldnQAXgX5Z3lbr2aIccoR2Io8D5Bwx8sGrICqTzA+X2
         IO5o4SnhYXFcc/O3qRhxZ4M+E9mrMIHVaw2nX3Xrgmo2Q/nbLwQ2PqI/c13z2G/adW8T
         Are4XCR7MXWvSbMsBxnsUrCoXwZIZDpleV2Cczib9LMLR98iiWa2aTbjdTENvfZWSP3D
         kKJCrWTqihmersDT/ycNTS6SdsrUGFN295kHyomKqyvkDbnzZluPLKhZ8Qe8/gKLldwU
         Z0KQ==
X-Gm-Message-State: AJIora9PlYdaCedyOBBw0UeZC1vOse9M00U/2UcN8yFgK/ZN/xrzDvBO
        T0iiTYlZxgYousHsn5pzcC9c
X-Google-Smtp-Source: AGRyM1tpPv6YnuXAkVsy6GXpaTyBFZoFtb4i/hhr6ApqgqnCEamHq8kadea+LusdLhkAxvcSAHDANg==
X-Received: by 2002:a05:6000:1f0c:b0:21e:8979:1f20 with SMTP id bv12-20020a0560001f0c00b0021e89791f20mr3457759wrb.714.1658759470075;
        Mon, 25 Jul 2022 07:31:10 -0700 (PDT)
Received: from Mem (pop.92-184-116-22.mobile.abo.orange.fr. [92.184.116.22])
        by smtp.gmail.com with ESMTPSA id m39-20020a05600c3b2700b003a2e1883a27sm22975495wms.18.2022.07.25.07.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 07:31:09 -0700 (PDT)
Date:   Mon, 25 Jul 2022 16:31:07 +0200
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
Subject: [PATCH bpf-next v3 0/5] bpf: Allow any source IP in
 bpf_skb_set_tunnel_key
Message-ID: <cover.1658759380.git.paul@isovalent.com>
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

Changes in v3:
  - Rebased on top of bpf-next.
  - Reworked the last patch, for the selftests. Several changes were
    required to the existing vxlan_tunnel test to be able to test the
    change in the bpf_skb_set_tunnel_key helper.
  - Apart from the rebase, only the last selftests patch changed, so
    I kept the Reviewed-by and Acked-by tags on other patches.
Changes in v2:
  - Removed changes to IPv6 code paths as they are unnecessary.

Paul Chaignon (5):
  ip_tunnels: Add new flow flags field to ip_tunnel_key
  vxlan: Use ip_tunnel_key flow flags in route lookups
  geneve: Use ip_tunnel_key flow flags in route lookups
  bpf: Set flow flag to allow any source IP in bpf_tunnel_key
  selftests/bpf: Don't assign outer source IP to host

 drivers/net/geneve.c                          |  1 +
 drivers/net/vxlan/vxlan_core.c                | 11 ++-
 include/net/ip_tunnels.h                      |  1 +
 net/core/filter.c                             |  1 +
 .../selftests/bpf/prog_tests/test_tunnel.c    | 17 +++-
 .../selftests/bpf/progs/test_tunnel_kern.c    | 80 ++++++++++++++++---
 6 files changed, 96 insertions(+), 15 deletions(-)

-- 
2.25.1


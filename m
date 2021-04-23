Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAAD3690C8
	for <lists+bpf@lfdr.de>; Fri, 23 Apr 2021 13:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhDWLF6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Apr 2021 07:05:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30088 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229928AbhDWLF5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 23 Apr 2021 07:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619175921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jr7f/c656B14iZH1W7iqJ5TVJAXFbRzcz+BEzN3sEdE=;
        b=E/spkWFwPfnlDdgUg8ECIhpnK3KJcFv/WI/Q/ldPGKyPltWclZgrJmyeuk7iKvEg4ttBM8
        ayruBDVB7Po+Kz8Ae7zmeSz77typpWNScLGsmEJJKzN0DKTc5c0VyzK41ZGwQRHd/9l78m
        EVta77BJsL0nQn+J0eTRN1LDghWEnY4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-Sw-pdbf9Nn-mSvDNjtVhsA-1; Fri, 23 Apr 2021 07:05:18 -0400
X-MC-Unique: Sw-pdbf9Nn-mSvDNjtVhsA-1
Received: by mail-ed1-f71.google.com with SMTP id w15-20020a056402268fb02903828f878ec5so18407109edd.5
        for <bpf@vger.kernel.org>; Fri, 23 Apr 2021 04:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=jr7f/c656B14iZH1W7iqJ5TVJAXFbRzcz+BEzN3sEdE=;
        b=Y7JZPQdS04+zZ3GpBWla7bSo77X052+wv3qGzKE/KcqxtQs+AD49G80ZqGzAploE5K
         pwmAy4PKu9xfxjamUwyFovragbNho9TotwHxQ1JlD+GIDGje4U18l/Nxc30hWOLb7+hb
         Dj7XRrptqzl8E/RkpxI6cCQiiyYZ6BmCMFAPd+js8/9kUe7NgabKerPAHkawCvDGHTQl
         JLboEs54DM+cZy+7e6YFC12UzCSRsS0gMk+0Bn5Bj+dMDZsQ65CLNGsQj1cBtxwThCd2
         Br8GUKI4s32Az2IEEE3aJSmt14G8yY935vKHXR5ylyh2cEZHkTrKl6ei9gBAmm1QMYzq
         mJsA==
X-Gm-Message-State: AOAM532xYO1p4pRBnHHLTXL4VNH/OV/DqcI7LNQdfS52CRSbdNCqYBFt
        eJY46DIozERfDQzZzPAEwNF9OjgPEaBbwh6hBnBQkr5Uqrb2xzGvgDom47ZXzf0dDQkdTdakQ10
        D8JFYEJsyoKfI
X-Received: by 2002:a50:e848:: with SMTP id k8mr3711098edn.179.1619175917567;
        Fri, 23 Apr 2021 04:05:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXXZ2dv5SzDhemDUOV/fCE22p57ll81ceIAP/uMuiIiYIkTTmOwirVTG7v6dZRooXO3JjS4A==
X-Received: by 2002:a50:e848:: with SMTP id k8mr3711072edn.179.1619175917300;
        Fri, 23 Apr 2021 04:05:17 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id gz10sm3720420ejc.25.2021.04.23.04.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 04:05:16 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A7A42180675; Fri, 23 Apr 2021 13:05:15 +0200 (CEST)
Subject: [PATCH RFC bpf-next 0/4] Clean up and document RCU-based object
 protection for XDP_REDIRECT
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Date:   Fri, 23 Apr 2021 13:05:15 +0200
Message-ID: <161917591559.102337.3558507780042453425.stgit@toke.dk>
User-Agent: StGit/1.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

During the discussion[0] of Hangbin's multicast patch series, Martin pointed out
that the lifetime of the RCU-protected  map entries used by XDP_REDIRECT is by
no means obvious. I promised to look into cleaning this up, and Paul helpfully
provided some hints and a new unrcu_pointer() helper to aid in this.

This is mostly a documentation exercise, clearing up the description of the
lifetime expectations and adding __rcu annotations so sparse and lockdep can
help verify it. I'm sending this as RFC since I don't have any i40e hardware to
test on. A complete submission would also involve going through all the drivers,
of course, but I wanted to get some feedback onthis first. I did test on mlx5,
but that uses an rhashtable in the driver code, so we can't actually remove the
top-level rcu_read_lock() from that without getting lockdep splats.

Patches 1-2 are prepatory: Patch 1 adds Paul's unrcu_pointer() helper and patch
2 is a small fix for dev_get_by_index_rcu() so lockdep understands _bh-disabled
access to it. Patch 3 is the main bit that adds the __rcu annotations and
updates documentation comments, and patch 4 is an example of driver changes,
removing the rcu_read_lock() from i40e.

Please take a look, and let me know if you think this is the right direction for
clarifying the usage.

Thanks,
-Toke

[0] https://lore.kernel.org/bpf/20210415173551.7ma4slcbqeyiba2r@kafai-mbp.dhcp.thefacebook.com/

---

Paul E. McKenney (1):
      rcu: Create an unrcu_pointer() to remove __rcu from a pointer

Toke Høiland-Jørgensen (3):
      dev: add rcu_read_lock_bh_held() as a valid check when getting a RCU dev ref
      xdp: add proper __rcu annotations to redirect map entries
      i40e: remove rcu_read_lock() around XDP program invocation


 drivers/net/ethernet/intel/i40e/i40e_txrx.c |  2 -
 drivers/net/ethernet/intel/i40e/i40e_xsk.c  |  6 +--
 include/net/xdp_sock.h                      |  2 +-
 kernel/bpf/cpumap.c                         | 14 ++++--
 kernel/bpf/devmap.c                         | 52 +++++++++------------
 net/core/dev.c                              |  2 +-
 net/core/filter.c                           | 28 +++++++++++
 net/xdp/xsk.c                               |  4 +-
 net/xdp/xsk.h                               |  4 +-
 net/xdp/xskmap.c                            | 29 +++++++-----
 10 files changed, 85 insertions(+), 58 deletions(-)


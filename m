Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C72203C0B
	for <lists+bpf@lfdr.de>; Mon, 22 Jun 2020 18:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbgFVQDF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Jun 2020 12:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729870AbgFVQDE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Jun 2020 12:03:04 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0759C061795
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 09:03:03 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id c11so9932798lfh.8
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 09:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n0x8JMyuQeWpT4jjHGqeBWL1VYHUNE3enc3T3KdEcmg=;
        b=vsz3cKLgjxDj6grniVMEROqGAK4H6uuP3XSrIDjMg7iLDFoKnzH6H6i9YruhHe/Hw2
         2LACgk0RKZS++vBMte6jLZrzA0qYWeLL3FZ9ycb3YWJtILegGIHw/SEX10Fv8ZwEoESa
         QiiuW2GPycTBQ03MAsW7RMf+9kOpNUe0/vvCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n0x8JMyuQeWpT4jjHGqeBWL1VYHUNE3enc3T3KdEcmg=;
        b=C4twdal2hnab9i/vzgHQ7Oyo0BPDVOoZVNJ+wJqi8vzxiJpLbmfDUdwZF+vbof8K1J
         Rwn7048hDLEu0+ko/Af6t8r3IMaZVwOnDfgg8G8VJ5VEKT55brP+9/Tyu4aDSr57p51p
         K3cwK9c+xjYb4fsXnMIto/YoiIcmYuwAMnFKGuKep78esdbijlsj3edkJj4Asw86j/8i
         6wk9sWuhW+8wcRQOJyp/XeKi+NerOUewpI0LouIEAsZvhM8Wpk5Y0hbRP8r9AeEajzCJ
         ULOSyxZSWstxrx8AJ7jyDDWwsi66EmL7ewuHi9ZPL+GucQ5x22DhtdP96tQaw6do6D2q
         IB5A==
X-Gm-Message-State: AOAM531N/lat8xnBV3tTIzvp0kksiBSKg5H5l9HfMHdlT99sswnuXq/b
        rpx7IcFC8LPH1K92FbF/AKkER5AbZ0wZxQ==
X-Google-Smtp-Source: ABdhPJwqspDF9rxVsAEIDWnONZikjWTjSiB7JQfI8uG/UdNDW8HPu9NwbZDETPaa6UQamECJBCwzog==
X-Received: by 2002:a05:6512:3049:: with SMTP id b9mr10124293lfb.44.1592841781607;
        Mon, 22 Jun 2020 09:03:01 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id t13sm2789827ljg.78.2020.06.22.09.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 09:03:00 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Stanislav Fomichev <sdf@google.com>
Subject: [PATCH bpf-next 0/3] bpf, netns: Prepare for multi-prog attachment
Date:   Mon, 22 Jun 2020 18:02:57 +0200
Message-Id: <20200622160300.636567-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set prepares ground for link-based multi-prog attachment for
future netns attach types, with BPF_SK_LOOKUP attach type in mind [0].

Two changes are needed in order to attach and run a series of BPF programs:

  1) an bpf_prog_array of programs to run (patch #2), and
  2) a list of attached links to keep track of attachments (patch #3).

I've been using these patches with the next iteration of BPF socket lookup
hook patches, and saw that they are self-contained and can be split out to
ease the review burden.

Nothing changes for BPF flow_dissector. That is at most one prog can be
attached.

Thanks,
-jkbs

[0] https://lore.kernel.org/bpf/20200511185218.1422406-1-jakub@cloudflare.com/

Cc: Stanislav Fomichev <sdf@google.com>

Jakub Sitnicki (3):
  flow_dissector: Pull BPF program assignment up to bpf-netns
  bpf, netns: Keep attached programs in bpf_prog_array
  bpf, netns: Keep a list of attached bpf_link's

 include/linux/bpf.h          |   3 +
 include/net/flow_dissector.h |   3 +-
 include/net/netns/bpf.h      |   7 +-
 kernel/bpf/core.c            |  19 +++-
 kernel/bpf/net_namespace.c   | 189 +++++++++++++++++++++++++----------
 net/core/flow_dissector.c    |  34 +++----
 6 files changed, 172 insertions(+), 83 deletions(-)

-- 
2.25.4


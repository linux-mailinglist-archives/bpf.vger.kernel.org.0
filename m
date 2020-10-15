Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D331528F614
	for <lists+bpf@lfdr.de>; Thu, 15 Oct 2020 17:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389713AbgJOPqz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Oct 2020 11:46:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21580 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731115AbgJOPqz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 15 Oct 2020 11:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602776813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=5M26P0L/YGQdFvGc6undAIPcG+PqLaKsMBaJzgIC8aQ=;
        b=Ao1tcFxopu8ZVj35PVUG5z4X3ccA6+SChXE9pDg21AbiD8vHkPlEW/ygjVrhTyoI97jtIg
        2N1BUPTcA+cE1t/yrtnWtU5bgKB4z/XOb+jUmI2cQC5Fiurm3RSt8fkChhz07sDUL5G8Uc
        fzYfrcnMR4+RaHyXB+MGRay6eJxb19A=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-iXle7uOnMGy94NCd6pbPtg-1; Thu, 15 Oct 2020 11:46:51 -0400
X-MC-Unique: iXle7uOnMGy94NCd6pbPtg-1
Received: by mail-vs1-f69.google.com with SMTP id k18so1089237vsm.4
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2020 08:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=5M26P0L/YGQdFvGc6undAIPcG+PqLaKsMBaJzgIC8aQ=;
        b=OfY7vw1qChPkZbee/bbQQdIrQ3Zi3BKzjAqL06zY47+LsElXvzH2zYV15IvU1Bl2vz
         YgUweFtN+0iuha3uz254KFRJhbwCqkXp6WuiMvYScvzEAg8vcSn+lexZL1r40XttgIvf
         do62S8jkGa+4A9Qnx+JuzTVSSWsNVumBgP85ZbFAff6F9BK1E2bp5BOu/cuwUkCb8mNA
         3sabr6wVneZt2pPRh39/P44WZSgwiahTagYR9QEIjfT2HjXllOeQcqgX2T7Adfvp/dg7
         +xE4QowqlgK5YMvHGvEOivzJi2aL/4wjvS8NNhqjpUnNtn8kpR03l4bqyYBPDVdJQBmy
         BISQ==
X-Gm-Message-State: AOAM532r4vy9UDoPqoZXOJEoJIIE9zHlN/eCYoytuP4ljtfbpA2zPG9+
        WRvNVbUms8uidMRRLAR8IrZZoL20jJvtXZd6xwxL4KyKnPV1j0F6eZUebgNvW5LBio8oNjgWWEl
        sYC2s9ZdkiU15
X-Received: by 2002:a1f:17d7:: with SMTP id 206mr1052469vkx.11.1602776810556;
        Thu, 15 Oct 2020 08:46:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwI0VuDWzILusDGXZ0tIAks8AjGvRmJ1jOE0El4f1vWL77qpiC/BUAAmmIC7nWeq7Gxg+5ieA==
X-Received: by 2002:a1f:17d7:: with SMTP id 206mr1052440vkx.11.1602776809959;
        Thu, 15 Oct 2020 08:46:49 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id l6sm439779vkk.56.2020.10.15.08.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 08:46:49 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9BFDD1837DD; Thu, 15 Oct 2020 17:46:47 +0200 (CEST)
Subject: [PATCH RFC bpf-next 0/2] bpf: Rework bpf_redirect_neigh() to allow
 supplying nexthop from caller
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Thu, 15 Oct 2020 17:46:47 +0200
Message-ID: <160277680746.157904.8726318184090980429.stgit@toke.dk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Based on previous discussion[0], we determined that it would be beneficial to
rework bpf_redirect_neigh() so the caller can supply the nexthop information
(e.g., from a previous call to bpf_fib_lookup()). This way, the two helpers can
be combined without incurring a second FIB lookup to find the nexthop, and
bpf_fib_lookup() becomes usable even if no nexthop entry currently exists.

This patch (and accompanying selftest update) accomplishes this by way of an
optional paramter to bpf_redirect_neigh(). This is an API change, and so should
really be merged into the bpf tree to be part of the 5.10 cycle; however, since
bpf-next has not yet been merged into bpf, I'm sending this as an RFC against
bpf-next for discussion, and will repost against bpf once that merge happens
(Daniel, unless you have a better way of doing this, of course).

-Toke

[0] https://lore.kernel.org/bpf/393e17fc-d187-3a8d-2f0d-a627c7c63fca@iogearbox.net/

---

Toke Høiland-Jørgensen (2):
      bpf_redirect_neigh: Support supplying the nexthop as a helper parameter
      selftests: Update test_tc_neigh to use the modified bpf_redirect_neigh()


 .../selftests/bpf/progs/test_tc_neigh.c       | 83 ++++++++++++++++---
 .../testing/selftests/bpf/test_tc_redirect.sh |  8 +-
 2 files changed, 78 insertions(+), 13 deletions(-)


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC36513DE5E
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2020 16:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgAPPOv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jan 2020 10:14:51 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37923 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726160AbgAPPOv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Jan 2020 10:14:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579187689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pjtm53aUp30xBuphAL9WhpWL4YeBtylyyJItZa1Xjcg=;
        b=JqrgrwWhTdE85BoHF04x2zsZRJnBiDI34DjnEHszDP3rJT6qThOmEze49Dv0Sqwh4LzZRL
        9JgwXFvueEIdCq17Ii9C+hip475qAtQYCafPO5eQ+ntj9zyjl+LxYXHETN0KW+dx0myey1
        x+xLdb465fBDUGEUCr3rABXsIRzJbeA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-NtSerOP6OgKJKQjjp6Gnow-1; Thu, 16 Jan 2020 10:14:47 -0500
X-MC-Unique: NtSerOP6OgKJKQjjp6Gnow-1
Received: by mail-lj1-f199.google.com with SMTP id m1so5258108lji.5
        for <bpf@vger.kernel.org>; Thu, 16 Jan 2020 07:14:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=pjtm53aUp30xBuphAL9WhpWL4YeBtylyyJItZa1Xjcg=;
        b=nY5v7AnqExnLYHkfxGveXkUMOy9dsPQj8+xv3onDJfxmIGhXMAnnptZN2RUbsmwOoy
         0TC8ncHTgp5oEt+Jt9NuvSp++kvBMjR/5mdYWpyqREnk9XC+HqjykEXcmzdB+SgUfAkS
         3SMGjapEtoyHgGB0Tzv7FR0mM+89H1j6TI5tC0f+JW6rUZVDhv2q5OsX5UHxgMjRXFbS
         utDC4IyP4+4KFht+WuR8u92101uReLtZ7W79zZBsSQyMHA4cZ7vuMWss8tLGxSLb0R3e
         C03tZIQhI8xHdy96YfGJkmbnMm2uojhI3up9bq+fYtY3PgfUTsD24ThERKzweAPqJ07M
         P0ug==
X-Gm-Message-State: APjAAAXnMHA9t3EnDjwfg9busmUJCkhBqDZhP0MmNuxnivtT0RkNuDBp
        rN9uzTa7W7Zztlb6MYjiDrUrb4Siy0ggkeZMf4Y0LWtfdOyvkqdREpqUiEMtq7l0iQHSqdkkKqk
        U2mpG1/14xPNz
X-Received: by 2002:a2e:9592:: with SMTP id w18mr2572270ljh.98.1579187684826;
        Thu, 16 Jan 2020 07:14:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqxm5Np/+faK07RT6GyJKD5qGqR6L3argCRqScUpgqfsvC36J5M5SoLLxghhjmi1MrgH3Qe6bA==
X-Received: by 2002:a2e:9592:: with SMTP id w18mr2572255ljh.98.1579187684636;
        Thu, 16 Jan 2020 07:14:44 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id w6sm10623704lfq.95.2020.01.16.07.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 07:14:43 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id EF8B61804D6; Thu, 16 Jan 2020 16:14:42 +0100 (CET)
Subject: [PATCH bpf-next v3 0/3] xdp: Introduce bulking for non-map
 XDP_REDIRECT
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        =?utf-8?b?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date:   Thu, 16 Jan 2020 16:14:42 +0100
Message-ID: <157918768284.1458396.8128704597152008763.stgit@toke.dk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Since commit 96360004b862 ("xdp: Make devmap flush_list common for all map
instances"), devmap flushing is a global operation instead of tied to a
particular map. This means that with a bit of refactoring, we can finally fix
the performance delta between the bpf_redirect_map() and bpf_redirect() helper
functions, by introducing bulking for the latter as well.

This series makes this change by moving the data structure used for the bulking
into struct net_device itself, so we can access it even when there is not
devmap. Once this is done, moving the bpf_redirect() helper to use the bulking
mechanism becomes quite trivial, and brings bpf_redirect() up to the same as
bpf_redirect_map():

                       Before:   After:
1 CPU:
bpf_redirect_map:      8.4 Mpps  8.4 Mpps  (no change)
bpf_redirect:          5.0 Mpps  8.4 Mpps  (+68%)
2 CPUs:
bpf_redirect_map:     15.9 Mpps  16.1 Mpps  (+1% or ~no change)
bpf_redirect:          9.5 Mpps  15.9 Mpps  (+67%)

After this patch series, the only semantics different between the two variants
of the bpf() helper (apart from the absence of a map argument, obviously) is
that the _map() variant will return an error if passed an invalid map index,
whereas the bpf_redirect() helper will succeed, but drop packets on
xdp_do_redirect(). This is because the helper has no reference to the calling
netdev, so unfortunately we can't do the ifindex lookup directly in the helper.

Changelog:

v3:
  - Switch two more fields to avoid a list_head spanning two cache lines
  - Include Jesper's tracepoint patch
  - Also rename xdp_do_flush_map()
  - Fix a few nits from Maciej

v2:
  - Consolidate code paths and tracepoints for map and non-map redirect variants
    (Björn)
  - Add performance data for 2-CPU test (Jesper)
  - Move fields to avoid shifting cache lines in struct net_device (Eric)

---

Jesper Dangaard Brouer (1):
      devmap: Adjust tracepoint for map-less queue flush

Toke Høiland-Jørgensen (2):
      xdp: Move devmap bulk queue into struct net_device
      xdp: Use bulking for non-map XDP_REDIRECT and consolidate code paths


 drivers/net/tun.c              |    4 +
 drivers/net/veth.c             |    2 -
 drivers/net/virtio_net.c       |    2 -
 include/linux/bpf.h            |   13 +++-
 include/linux/filter.h         |   10 ++-
 include/linux/netdevice.h      |   13 ++--
 include/trace/events/xdp.h     |  130 +++++++++++++++++-----------------------
 kernel/bpf/devmap.c            |   95 +++++++++++++++--------------
 net/core/dev.c                 |    2 +
 net/core/filter.c              |   90 ++++++----------------------
 samples/bpf/xdp_monitor_kern.c |    8 +-
 11 files changed, 160 insertions(+), 209 deletions(-)


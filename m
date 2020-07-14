Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE77A21FE3D
	for <lists+bpf@lfdr.de>; Tue, 14 Jul 2020 22:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgGNUNA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jul 2020 16:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgGNUNA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jul 2020 16:13:00 -0400
Received: from forwardcorp1p.mail.yandex.net (forwardcorp1p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b6:217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F2AC061794;
        Tue, 14 Jul 2020 13:13:00 -0700 (PDT)
Received: from iva8-d077482f1536.qloud-c.yandex.net (iva8-d077482f1536.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:2f26:0:640:d077:482f])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 26BC72E153C;
        Tue, 14 Jul 2020 23:12:56 +0300 (MSK)
Received: from iva8-88b7aa9dc799.qloud-c.yandex.net (iva8-88b7aa9dc799.qloud-c.yandex.net [2a02:6b8:c0c:77a0:0:640:88b7:aa9d])
        by iva8-d077482f1536.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id Ihpo24jY5Z-CtsCFCbF;
        Tue, 14 Jul 2020 23:12:56 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1594757576; bh=8h7YWC395s1JHchUOOnn4Nt4JnQ9iy5aa+WTT7W7ZUM=;
        h=Message-Id:Date:Subject:To:From:Cc;
        b=DkvrPfGxFZs6CywZYL/dDNnF3GPXYi6l8ChYku+GLefeydpxUYe9kMbGq7LS3Y84T
         5O/fcdRwfEj7/x/XoPKla2gu+2hpE8KzQpLAOjpUCt75QBqf35T7OMcR6IvjcIw1FQ
         qzJ379Bug4dxL+Gr4XHHfNtixu9+5rdsnEaQmwMk=
Authentication-Results: iva8-d077482f1536.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from 37.9.72.161-iva.dhcp.yndx.net (37.9.72.161-iva.dhcp.yndx.net [37.9.72.161])
        by iva8-88b7aa9dc799.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id PwhVeBFRq1-CtjCsXHH;
        Tue, 14 Jul 2020 23:12:55 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Dmitry Yakunin <zeil@yandex-team.ru>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     sdf@google.com
Subject: [PATCH bpf-next v2 0/4] bpf: cgroup skb improvements for bpf_prog_test_run
Date:   Tue, 14 Jul 2020 23:12:41 +0300
Message-Id: <20200714201245.99528-1-zeil@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset contains some improvements for testing cgroup/skb programs
through BPF_PROG_TEST_RUN command.

v2:
  - fix build without CONFIG_CGROUP_BPF (kernel test robot <lkp@intel.com>)

Dmitry Yakunin (4):
  bpf: setup socket family and addresses in bpf_prog_test_run_skb
  bpf: allow to specify ifindex for skb in bpf_prog_test_run_skb
  bpf: export some cgroup storages allocation helpers for reusing
  bpf: try to use existing cgroup storage in bpf_prog_test_run_skb

 include/linux/bpf-cgroup.h                         |  36 +++++++
 kernel/bpf/cgroup.c                                |  25 -----
 net/bpf/test_run.c                                 | 113 ++++++++++++++++++---
 .../selftests/bpf/prog_tests/cgroup_skb_prog_run.c |  78 ++++++++++++++
 tools/testing/selftests/bpf/prog_tests/skb_ctx.c   |   5 +
 5 files changed, 217 insertions(+), 40 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_skb_prog_run.c

-- 
2.7.4


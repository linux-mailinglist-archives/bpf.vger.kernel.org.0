Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C022EA0C6
	for <lists+bpf@lfdr.de>; Tue,  5 Jan 2021 00:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbhADX0j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Jan 2021 18:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbhADX0i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Jan 2021 18:26:38 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A0DC061795
        for <bpf@vger.kernel.org>; Mon,  4 Jan 2021 15:25:58 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id my8so554077pjb.3
        for <bpf@vger.kernel.org>; Mon, 04 Jan 2021 15:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=ptl9lvlNeQ8rb1QFATiaT3uH/4C0oopGRoPxfvyAb2c=;
        b=PSk2pLEREebJjCZgCidiMVgVTczCb9yXAsf7cDX6JwkPX/fXZIVH66P1pI+iCasrDz
         U1E4qLZHl1KuMxEwVjhfvMYGl8p1K4Ausimy3aqIS1e4+JUk5c2uz1ABNpKNW0u932bJ
         zWUwN9VfydzOvd6wwsGTh7w7Xsobn2xNioXavE91ZWbpB6VsqNl7Cq6ng8dQwRGIjvUe
         BFR3F2i3uSO1eXb7Mmyym7D2b+d95FVBwjTGm6XQcO8HeNEpaPX/Z3TwHo+tMMlWzU2l
         yxO+fM9ZYlHVdwKbKpwQTDYNLY1LgJXGThP3+T4Nc8hCV3PzohjqS9uVsDL+Hz5krlhu
         sw7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=ptl9lvlNeQ8rb1QFATiaT3uH/4C0oopGRoPxfvyAb2c=;
        b=qbk+rnznbFQfSzGvT1iSxyBAyGNOMViD4/IXM+bKbnjsDfcamyvXMXNrCNDyUHpAPM
         tqGYLBnZnCc64WHaDvGKFQFWqOENx2XshWaGJ/i3HEPN+zcXFQvFT0NzpxcNBHh3X90e
         cYjb8lN4oRBKUXTPbVRvVhs1qTbyt7D8VmbV+b8BZ7nLkL82LzkkuxDhjYOD8pBKcG8U
         qlygan6Kwp4/mM+6uFLLJpkJAbtDNud8WugbVKUKY51rTJtFhSOBFMczCr1bbHg2qQ+1
         0wks3RVK2AtUHiKU6LatvPna7WCQtxyHHcXtC8SdxKLJrSPcsY3c2NDWAms8359uTNjG
         g0Qg==
X-Gm-Message-State: AOAM533l4q0Np2u+pDltn0kRpN3NcW6/wqdNHI+YA03y6ii41Ho5QB71
        mZX2pH8ad6onkZ5zg8jjX+b/9Oo=
X-Google-Smtp-Source: ABdhPJzjaMED1n2APX00sZbDymFDwQSDI3BjsSgJNrEf5XTtzu0nfbCt88SbsYI4a4Pb7ZT91X4tN7Y=
Sender: "sdf via sendgmr" <sdf@sdf2.svl.corp.google.com>
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:7220:84ff:fe09:7732])
 (user=sdf job=sendgmr) by 2002:a05:6214:1887:: with SMTP id
 cx7mr78894414qvb.39.1609798496582; Mon, 04 Jan 2021 14:14:56 -0800 (PST)
Date:   Mon,  4 Jan 2021 14:14:52 -0800
Message-Id: <20210104221454.2204239-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH bpf-next v2 0/2] bpf: misc performance improvements for cgroup hooks
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

First patch tries to remove kzalloc/kfree from getsockopt for the
common cases.

Second patch switches cgroup_bpf_enabled to be per-attach to
to add only overhead for the cgroup attach types used on the system.

No visible user-side changes.

v2:
- perf numbers for getsockopt kmalloc reduction (Song Liu)
- (sk) in BPF_CGROUP_PRE_CONNECT_ENABLED (Song Liu)
- 128 -> 64 buffer size, BUILD_BUG_ON (Martin KaFai Lau)

Stanislav Fomichev (2):
  bpf: try to avoid kzalloc in cgroup/{s,g}etsockopt
  bpf: split cgroup_bpf_enabled per attach type

 include/linux/bpf-cgroup.h | 36 +++++++++++++------------
 include/linux/filter.h     |  3 +++
 kernel/bpf/cgroup.c        | 54 +++++++++++++++++++++++++++++++-------
 net/ipv4/af_inet.c         |  9 ++++---
 net/ipv4/udp.c             |  7 +++--
 net/ipv6/af_inet6.c        |  9 ++++---
 net/ipv6/udp.c             |  7 +++--
 7 files changed, 83 insertions(+), 42 deletions(-)

-- 
2.29.2.729.g45daf8777d-goog


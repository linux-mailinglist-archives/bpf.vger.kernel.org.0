Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 449C91918AA
	for <lists+bpf@lfdr.de>; Tue, 24 Mar 2020 19:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgCXSM6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Mar 2020 14:12:58 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:28856 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727034AbgCXSM5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 24 Mar 2020 14:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585073576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4mczQwa1X+bZj8aJ0jWpRNwTlrYNKYVpc82GHMIPVFQ=;
        b=Nxjrg0CFJAH6tU7VbefJhW1cjBOWWzUQWYOdsTMRvUChc3C8ArSdprmfhWd9p3BLA/EDOg
        F7Y8q9juWLcOejQ2hXm51BoYqYkhYdUNGPd80ledJDrmfAf1qbvqvOb8ZhJFf6v3JdqJWP
        k3hj60K3e7DGhVIGIZ/OfaVjZVJ91R0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-csXKA5Y4NkO6_QCApSeiKA-1; Tue, 24 Mar 2020 14:12:55 -0400
X-MC-Unique: csXKA5Y4NkO6_QCApSeiKA-1
Received: by mail-wr1-f70.google.com with SMTP id d17so9616826wrw.19
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2020 11:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=4mczQwa1X+bZj8aJ0jWpRNwTlrYNKYVpc82GHMIPVFQ=;
        b=Gkh7XNXYqzawU21GQuZdgyvRGYGjEt5oCqefHUbKDrrD8NQ96EDshlgwFhWCQV4Ug/
         Jy7Yh156UUOUeu/DQdIKwSYM1/UUK9Q8pPDWMofkNIjGYlCiskVs5m+Tz4wuBQaxfNDr
         CmvWdcWIYInlVCpTYz5Oxns9f0cfk+9p6k7DVJZgadpWu5I4zLxQ1xVXDpPZQNmahu1V
         lkf5oRRyAZfDXV/A6pCIPZsANKPEWOuChpc0E10l9WOlY0eAAmC1qQ/bk/tf1YcQU93i
         lQrsMBYx6orUhZXJFaLFwMqrMCVy0N+4qg4bV/pR+bAKMZV5JLpiaR1Lo3kDd8J6wX0H
         lg8w==
X-Gm-Message-State: ANhLgQ3Nwh7p5kjYA/ggZetES5n31kpIbQ9awCuJX+yPGdocp4NVwK32
        0+tiD4mmYDyZ2RD9GJLmH/1VDoEuWw84TAmh4VoMjMhPWOqJO8NLcBW+jOuRxOIk4/otYBH0UI9
        hvVzlcX0+h+Xj
X-Received: by 2002:adf:9796:: with SMTP id s22mr37311441wrb.31.1585073574076;
        Tue, 24 Mar 2020 11:12:54 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvbHgGSgZlwukSSqY1srvKdIOLLHUPuYtLWfIoqPtcygq7nnaHqztsiQjQcA8zv0M5lMc2ayA==
X-Received: by 2002:adf:9796:: with SMTP id s22mr37311407wrb.31.1585073573735;
        Tue, 24 Mar 2020 11:12:53 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id t126sm5604773wmb.27.2020.03.24.11.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 11:12:52 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2135C18158B; Tue, 24 Mar 2020 19:12:52 +0100 (CET)
Subject: [PATCH bpf-next v3 0/4] XDP: Support atomic replacement of XDP
 interface attachments
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>, Andrey Ignatov <rdna@fb.com>
Date:   Tue, 24 Mar 2020 19:12:52 +0100
Message-ID: <158507357205.6925.17804771242752938867.stgit@toke.dk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series adds support for atomically replacing the XDP program loaded on an
interface. This is achieved by means of a new netlink attribute that can specify
the expected previous program to replace on the interface. If set, the kernel
will compare this "expected id" attribute with the program currently loaded on
the interface, and reject the operation if it does not match.

With this primitive, userspace applications can avoid stepping on each other's
toes when simultaneously updating the loaded XDP program.

Changelog:

v3:
- Pass existing ID instead of FD (Jakub)
- Use opts struct for new libbpf function (Andrii)

v2:
- Fix checkpatch nits and add .strict_start_type to netlink policy (Jakub)

---

Toke Høiland-Jørgensen (4):
      xdp: Support specifying expected existing program when attaching XDP
      tools: Add EXPECTED_ID-related definitions in if_link.h
      libbpf: Add function to set link XDP fd while specifying old program
      selftests/bpf: Add tests for attaching XDP programs


 include/linux/netdevice.h                          |  2 +-
 include/uapi/linux/if_link.h                       |  4 +-
 net/core/dev.c                                     | 14 ++--
 net/core/rtnetlink.c                               | 13 ++++
 tools/include/uapi/linux/if_link.h                 |  4 +-
 tools/lib/bpf/libbpf.h                             |  8 +++
 tools/lib/bpf/libbpf.map                           |  1 +
 tools/lib/bpf/netlink.c                            | 34 +++++++++-
 .../testing/selftests/bpf/prog_tests/xdp_attach.c  | 74 ++++++++++++++++++++++
 9 files changed, 145 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_attach.c


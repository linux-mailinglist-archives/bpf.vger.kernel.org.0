Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6A0192F14
	for <lists+bpf@lfdr.de>; Wed, 25 Mar 2020 18:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgCYRXc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Mar 2020 13:23:32 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:46479 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727236AbgCYRXc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 25 Mar 2020 13:23:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585157010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ITiPYjFKTZt+q+w1K95YcV+C6+CVqFjp7kaW3PsE8LI=;
        b=a43XzW/RuQdCqKElY2SxobCnyNiQxbF/KT0UuNgyq3wCIllFiBNLlraKQm/j1Tu8qVLLGt
        tqrtLGE5vc7A7bzYdwt9Sw1foEae+rSMGjkilYm92oXNoEruiBIKMrWPa8GKbBPbAUj9ci
        V9/7KH1jYnfALMDW7NTvHIgdwpZrmgc=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-HERlzAYYOKqfOkN80s661Q-1; Wed, 25 Mar 2020 13:23:28 -0400
X-MC-Unique: HERlzAYYOKqfOkN80s661Q-1
Received: by mail-lf1-f70.google.com with SMTP id n16so399029lfq.18
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2020 10:23:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=ITiPYjFKTZt+q+w1K95YcV+C6+CVqFjp7kaW3PsE8LI=;
        b=TJu+VqDkBk6dK0YBzE5kD8t4PoPZ1vq1zk7703LcyZpjhwNt0hUk72fdqpRil0iN/w
         jpOB3HDr0vr5sDvhb4b0V7go5o6bMVgFqy+Z2OHnK0XQewPA9yHNw0hkzYdjfuWw7rMP
         v0fHJY1j0ROOvVGtCloEVgpLg2RH7F8ShnKePKSuSynMXkS5z36pLganGcW78JiP5ZLQ
         1GS5Mp/KYg/LfAReG1+VvFoX0m/VaKvdF8YInZCKGQ9BFqPM0ekkzUhQ5LWTzXprDHDA
         vzF/mNMbmRpxnUKe+6ZaTj7Bm0IPDLrIOv6Q25LFelHw2bwg+By4PQIdL1zHIFpdd2m/
         9iZA==
X-Gm-Message-State: ANhLgQ1amPD4iYVke8Lx7DeMxcjGsTj4sRxC90vJ97Q8p81R2zpo0JAF
        oRIiGw3t+OjW0uBDdyypc831JRRqAMLW7Yf9otbc23N9Klq57OAhl76YXaL2/imHmmcRS8fZKWV
        iLa/M/81DqLKU
X-Received: by 2002:a2e:8015:: with SMTP id j21mr2501386ljg.165.1585157007246;
        Wed, 25 Mar 2020 10:23:27 -0700 (PDT)
X-Google-Smtp-Source: APiQypIKiQhQJmAxRXHGX9rrAdTeaZce2lL1FiJy8kZSwzv96C/XMUUO72YLhPbDAtJIsWTB3J8iMg==
X-Received: by 2002:a2e:8015:: with SMTP id j21mr2501354ljg.165.1585157006865;
        Wed, 25 Mar 2020 10:23:26 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id v19sm5463366lfg.9.2020.03.25.10.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 10:23:26 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 6177918158B; Wed, 25 Mar 2020 18:23:25 +0100 (CET)
Subject: [PATCH bpf-next v4 0/4] XDP: Support atomic replacement of XDP
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
Date:   Wed, 25 Mar 2020 18:23:25 +0100
Message-ID: <158515700529.92963.17609642163080084530.stgit@toke.dk>
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

v4:
- Switch back to passing FD instead of ID (Andrii)
- Rename flag to XDP_FLAGS_REPLACE (for consistency with other similar uses)

v3:
- Pass existing ID instead of FD (Jakub)
- Use opts struct for new libbpf function (Andrii)

v2:
- Fix checkpatch nits and add .strict_start_type to netlink policy (Jakub)

---

Toke Høiland-Jørgensen (4):
      xdp: Support specifying expected existing program when attaching XDP
      tools: Add EXPECTED_FD-related definitions in if_link.h
      libbpf: Add function to set link XDP fd while specifying old program
      selftests/bpf: Add tests for attaching XDP programs


 include/linux/netdevice.h                          |  2 +-
 include/uapi/linux/if_link.h                       |  4 +-
 net/core/dev.c                                     | 26 +++++++--
 net/core/rtnetlink.c                               | 14 +++++
 tools/include/uapi/linux/if_link.h                 |  4 +-
 tools/lib/bpf/libbpf.h                             |  8 +++
 tools/lib/bpf/libbpf.map                           |  1 +
 tools/lib/bpf/netlink.c                            | 34 +++++++++++-
 .../testing/selftests/bpf/prog_tests/xdp_attach.c  | 62 ++++++++++++++++++++++
 9 files changed, 146 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_attach.c


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1259D4833F1
	for <lists+bpf@lfdr.de>; Mon,  3 Jan 2022 16:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbiACPIc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Jan 2022 10:08:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26246 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233865AbiACPI3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 3 Jan 2022 10:08:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641222508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0jGp0ekU1sNy+/+NzYRMKxpYrvK5+NAHhNduHrAwulI=;
        b=QiMbpJO8ddDHPwZgWP2cPKg7IuNJTFzttDgyiHUllk+5mvOXi39RGVnT0AJvA45nldYdQA
        tyZaKJU3t40WCCaNN5mmz4SvzDia0RVJPEFwsA+fZvaEamBtsBLoLiJVv1GQGKzAv51waM
        W8de2ObtZRrafCzqn50gGu6+rVcbPTQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-zRink-tRN-y1cPGeAiPOSQ-1; Mon, 03 Jan 2022 10:08:24 -0500
X-MC-Unique: zRink-tRN-y1cPGeAiPOSQ-1
Received: by mail-ed1-f71.google.com with SMTP id x19-20020a05640226d300b003f8b80f5729so21760292edd.13
        for <bpf@vger.kernel.org>; Mon, 03 Jan 2022 07:08:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0jGp0ekU1sNy+/+NzYRMKxpYrvK5+NAHhNduHrAwulI=;
        b=4K5Ydj83DZCodvD53bGJmpkZsGToicrkj3oSZXqqpKlo1mp50q/9J/799vGYhJdWCd
         hVzyfnMglMR2xcvf1UMO3tlHOWrpQFOCxS+aZc9GvLgvLI63bak45uuyhW6WMkKWHYgq
         2JZmxoRR0lesnv/b6AfrbpgJdzfWow7NdApVjEqmgvqyKsivrxWvIa7jhkO4ig8TcDe/
         Dx8n7SkZZw4irV6GDQxVG1Sy+9QZuYg+6xkEQQUQdqh0OYkMhEeVjykAQ+AhYrdygP6v
         ZpUmsh/OJgGHl61gAriDEDn+NGdxOmt7SGbN4dxchQkmIXopOO15f7eRFi1ADk66W7Y/
         C92A==
X-Gm-Message-State: AOAM5317fBxP0cADT9Edkf8ox65RTg/W4UuRk9gX48paIqLlLA00wB3n
        2Zjn0hp6N3JEetKkzfN0JhMailcp3R41My2v6l0EROgmMhkZHXfGoAxJCXizdfo28BZiKvuDDy3
        9X4nxcbQZgjxA
X-Received: by 2002:a05:6402:5214:: with SMTP id s20mr29636659edd.13.1641222501486;
        Mon, 03 Jan 2022 07:08:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwec5eh3EVvn4kJDWOZtCuMH1LwEB8KBdgVS4+o/Dw/WOqa8UADzmY9wjfol77O7IBsFoGtlg==
X-Received: by 2002:a05:6402:5214:: with SMTP id s20mr29636530edd.13.1641222499975;
        Mon, 03 Jan 2022 07:08:19 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id z26sm13552898edr.11.2022.01.03.07.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 07:08:19 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E997C180300; Mon,  3 Jan 2022 16:08:18 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH bpf-next v5 0/7] Add support for transmitting packets using XDP in bpf_prog_run()
Date:   Mon,  3 Jan 2022 16:08:05 +0100
Message-Id: <20220103150812.87914-1-toke@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series adds support for transmitting packets using XDP in
bpf_prog_run(), by enabling a new mode "live packet" mode which will handle
the XDP program return codes and redirect the packets to the stack or other
devices.

The primary use case for this is testing the redirect map types and the
ndo_xdp_xmit driver operation without an external traffic generator. But it
turns out to also be useful for creating a programmable traffic generator
in XDP, as well as injecting frames into the stack. A sample traffic
generator, which was included in previous versions of the series, but now
moved to xdp-tools, transmits up to 11.5 Mpps/core on my test machine.

To transmit the frames, the new mode instantiates a page_pool structure in
bpf_prog_run() and initialises the pages to contain XDP frames with the
data passed in by userspace. These frames can then be handled as though
they came from the hardware XDP path, and the existing page_pool code takes
care of returning and recycling them. The setup is optimised for high
performance with a high number of repetitions to support stress testing and
the traffic generator use case; see patch 6 for details.

The series is structured as follows: Patches 1-5 adds a few features to
page_pool that are needed for the usage in bpf_prog_run() and perform a
couple of preparatory refactorings of the XDP redirect and memory
management code. Patch 6 adds the support to bpf_prog_run() itself and
patch 7 adds a selftest that exercises all the XDP return codes.

v5:
- Rebase to current bpf-next

v4:
- Fix a few code style issues (Alexei)
- Also handle the other return codes: XDP_PASS builds skbs and injects them
  into the stack, and XDP_TX is turned into a redirect out the same
  interface (Alexei).
- Drop the last patch adding an xdp_trafficgen program to samples/bpf; this
  will live in xdp-tools instead (Alexei).
- Add a separate bpf_test_run_xdp_live() function to test_run.c instead of
  entangling the new mode in the existing bpf_test_run().

v3:
- Reorder patches to make sure they all build individually (Patchwork)
- Remove a couple of unused variables (Patchwork)
- Remove unlikely() annotation in slow path and add back John's ACK that I
  accidentally dropped for v2 (John)

v2:
- Split up up __xdp_do_redirect to avoid passing two pointers to it (John)
- Always reset context pointers before each test run (John)
- Use get_mac_addr() from xdp_sample_user.h instead of rolling our own (Kumar)
- Fix wrong offset for metadata pointer

Toke Høiland-Jørgensen (7):
  xdp: Allow registering memory model without rxq reference
  page_pool: Add callback to init pages when they are allocated
  page_pool: Store the XDP mem id
  xdp: Move conversion to xdp_frame out of map functions
  xdp: add xdp_do_redirect_frame() for pre-computed xdp_frames
  bpf: Add "live packet" mode for XDP in bpf_prog_run()
  selftests/bpf: Add selftest for XDP_REDIRECT in bpf_prog_run()

 include/linux/bpf.h                           |  20 +-
 include/linux/filter.h                        |   4 +
 include/net/page_pool.h                       |  11 +-
 include/net/xdp.h                             |   3 +
 include/uapi/linux/bpf.h                      |   2 +
 kernel/bpf/Kconfig                            |   1 +
 kernel/bpf/cpumap.c                           |   8 +-
 kernel/bpf/devmap.c                           |  32 +-
 net/bpf/test_run.c                            | 287 +++++++++++++++++-
 net/core/filter.c                             |  73 ++++-
 net/core/page_pool.c                          |   6 +-
 net/core/xdp.c                                |  94 ++++--
 tools/include/uapi/linux/bpf.h                |   2 +
 .../bpf/prog_tests/xdp_do_redirect.c          | 118 +++++++
 .../bpf/progs/test_xdp_do_redirect.c          |  39 +++
 15 files changed, 610 insertions(+), 90 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_do_redirect.c

-- 
2.34.1


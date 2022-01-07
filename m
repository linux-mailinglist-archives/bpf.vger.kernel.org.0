Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD9B487E9F
	for <lists+bpf@lfdr.de>; Fri,  7 Jan 2022 22:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiAGVyy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Jan 2022 16:54:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:21215 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230256AbiAGVyu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 7 Jan 2022 16:54:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641592490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=I2MnAR9Y7aMHYv+JUS1Vt9RjxknpZXBTx5MkLEXS6D0=;
        b=eR+/fzbNkRVrgD16a/921+4xUG2yzaSk/O1lWom5+xtSAUdyh6qWZNpZtn2iPriKchSa/V
        X3DjwPho3/54vh9PHuywAcKdEwokK5HFQ7kN8BLkUUDaK5CGMA6gkXg2+04lZo5p+8lEdq
        CpwGGML04ewBCCLQYsw6fC06pDZmcnc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-9LGyEF7kPmiQNKcrzeQ4Ig-1; Fri, 07 Jan 2022 16:54:49 -0500
X-MC-Unique: 9LGyEF7kPmiQNKcrzeQ4Ig-1
Received: by mail-ed1-f70.google.com with SMTP id v18-20020a056402349200b003f8d3b7ee8dso5718111edc.23
        for <bpf@vger.kernel.org>; Fri, 07 Jan 2022 13:54:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I2MnAR9Y7aMHYv+JUS1Vt9RjxknpZXBTx5MkLEXS6D0=;
        b=4rjJkFiahlVKF7tr3zmRylRyTfBGAJx+9794qk3Pw4lFixLPSeXExkZkQ6X3fqw7vt
         LQAunr4N321Sz8pc7g219xloLGpOlOf6xb+U1oiReI4Jn5wDenFy/IWttOcX3yQVjW1m
         bJMupd5cfNRRnrA1eukt+EA4eLLTRAAscWJtVko+ymtWF+ZIf8jhqwpygry4QGszDblg
         LNbWABg+emBhXFVNbcAHE2DU0RgfDLTQpEUWrt3NuKuhXnfZHBN1Jremp0DgsPx0C2TG
         gFH8MxRzOHWz3yjGoQ3E/R0wFC5JZbFOya6wQFgJk4PQKopObny9n5i9Kmy0sSY5VYpw
         Pqyg==
X-Gm-Message-State: AOAM530dNfF6EuhAhGB3f1oecB8fOCZWh9VDKr2LVNTPnSEK5bVTW/0G
        4YzX2AywZMsnOdQhx7jeWOf5rCCidyH5grSKemd5/i8DDRPJOyWHej5OZ6kAc8HaC6OXf1ea4Hs
        0+6NLyq0aXSYU
X-Received: by 2002:a17:906:254d:: with SMTP id j13mr1556270ejb.628.1641592485497;
        Fri, 07 Jan 2022 13:54:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyv+AHvA4YphR22sA37+/rWCx2iHtHzBk32Z3OqOqTRI2TUVz2cVUCihnvPdxzOSKmkwlrwxw==
X-Received: by 2002:a17:906:254d:: with SMTP id j13mr1556184ejb.628.1641592483276;
        Fri, 07 Jan 2022 13:54:43 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id oz7sm1735467ejc.81.2022.01.07.13.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 13:54:42 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id AE14E181F2A; Fri,  7 Jan 2022 22:54:40 +0100 (CET)
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
Subject: [PATCH bpf-next v7 0/3] Add support for transmitting packets using XDP in bpf_prog_run()
Date:   Fri,  7 Jan 2022 22:54:35 +0100
Message-Id: <20220107215438.321922-1-toke@redhat.com>
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
the traffic generator use case; see patch 1 for details.

v7:
- Extend the local_bh_disable() to cover the full test run loop, to prevent
  running concurrently with the softirq. Fixes a deadlock with veth xmit.
- Reinstate the forwarding sysctl setting in the selftest, and bump up the
  number of packets being transmitted to trigger the above bug.
- Update commit message to make it clear that user space can select the
  ingress interface.

v6:
- Fix meta vs data pointer setting and add a selftest for it
- Add local_bh_disable() around code passing packets up the stack
- Create a new netns for the selftest and use a TC program instead of the
  forwarding hack to count packets being XDP_PASS'ed from the test prog.
- Check for the correct ingress ifindex in the selftest
- Rebase and drop patches 1-5 that were already merged

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

Toke Høiland-Jørgensen (3):
  bpf: Add "live packet" mode for XDP in bpf_prog_run()
  selftests/bpf: Move open_netns() and close_netns() into
    network_helpers.c
  selftests/bpf: Add selftest for XDP_REDIRECT in bpf_prog_run()

 include/uapi/linux/bpf.h                      |   2 +
 kernel/bpf/Kconfig                            |   1 +
 net/bpf/test_run.c                            | 290 +++++++++++++++++-
 tools/include/uapi/linux/bpf.h                |   2 +
 tools/testing/selftests/bpf/network_helpers.c |  86 ++++++
 tools/testing/selftests/bpf/network_helpers.h |   9 +
 .../selftests/bpf/prog_tests/tc_redirect.c    |  87 ------
 .../bpf/prog_tests/xdp_do_redirect.c          | 175 +++++++++++
 .../bpf/progs/test_xdp_do_redirect.c          |  85 +++++
 9 files changed, 642 insertions(+), 95 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_do_redirect.c

-- 
2.34.1


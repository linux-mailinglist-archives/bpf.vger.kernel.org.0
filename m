Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7394D1B1B
	for <lists+bpf@lfdr.de>; Tue,  8 Mar 2022 15:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347685AbiCHO7G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Mar 2022 09:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347606AbiCHO7F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Mar 2022 09:59:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD0DE1A816
        for <bpf@vger.kernel.org>; Tue,  8 Mar 2022 06:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646751486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/OWLVQ18t0uphV9wxWQlSX9R4LKfVH7UBRJPa8ZTzes=;
        b=Ekr8mLUwGc6PU4ioA3o8EPds8+iCO+cC3qUOL66vuOZK4TLIwb+WTqh+mZ5zu4/wZElpn5
        QnePDjKURIfDQKAA+gRjPJO/qa2YC5PS57K+Wsy+uxvPA/mbFkV6SW9eFpIZOoetqt3Uk1
        1Tj0QevYLMs453FeTBWswvS3qVwRA6o=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-202-BuI6o6IEOOio5j6UQhU6jQ-1; Tue, 08 Mar 2022 09:58:05 -0500
X-MC-Unique: BuI6o6IEOOio5j6UQhU6jQ-1
Received: by mail-ej1-f71.google.com with SMTP id q22-20020a1709064cd600b006db14922f93so2901323ejt.7
        for <bpf@vger.kernel.org>; Tue, 08 Mar 2022 06:58:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/OWLVQ18t0uphV9wxWQlSX9R4LKfVH7UBRJPa8ZTzes=;
        b=s838A0hqypcs3VjalX/st74pv0dVV711qsgHnzo9h8DnygwKdC17wHh9xb+vGX+E+x
         fVuxXfr8Op3mIFS+PCClr8ofSS9WRdTA0vOeWi3rdiebe0P2VKCO9IDcZ81ZopHrlzmR
         6Q8janCOBAbFfwHpYXgNzdfy5CTcV7dmprC7qfRAa/8U+cjLCpLmiaLxVjq1RKVCkFDU
         Z231U+IOGuj0CpmZDpTW73cSAbukz16gdvidXhKhdh9LTX1PBEeVlUR41AlBsGpzK1nq
         8nBIhO9mIO0VQooecgVHsC2Xodvx5EAr6u1PvsmsCCs29vw8a7EqsTEAZO2WLNGq8W3u
         V/TQ==
X-Gm-Message-State: AOAM531kP5tAjZmd7uFhhlOdzzHXHnga0AOyNMux5yDVCRoa35ubqlRa
        /Xgda6xk9Cxxy8nyO11iSN4RwTSfigBcRxX2580JOrIFvC/CmcaDeKedJ02+zVhAy/pwGVY8UgX
        HUDB4yxkXKTSl
X-Received: by 2002:a05:6402:4406:b0:415:c310:8e4b with SMTP id y6-20020a056402440600b00415c3108e4bmr16768668eda.249.1646751484355;
        Tue, 08 Mar 2022 06:58:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzIBrPquvA4Y829P2dZdgww5niIW+SjG8R60ID2ACmZipx5DAdUuXivL6xbhwZ0uRg9y/EjMw==
X-Received: by 2002:a05:6402:4406:b0:415:c310:8e4b with SMTP id y6-20020a056402440600b00415c3108e4bmr16768630eda.249.1646751483859;
        Tue, 08 Mar 2022 06:58:03 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id d4-20020a1709067a0400b006d6e3ca9f71sm6041822ejo.198.2022.03.08.06.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 06:58:03 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 91FBF1928D0; Tue,  8 Mar 2022 15:58:02 +0100 (CET)
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
Subject: [PATCH bpf-next v10 0/5] Add support for transmitting packets using XDP in bpf_prog_run()
Date:   Tue,  8 Mar 2022 15:57:56 +0100
Message-Id: <20220308145801.46256-1-toke@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
moved to xdp-tools, transmits up to 9 Mpps/core on my test machine.

To transmit the frames, the new mode instantiates a page_pool structure in
bpf_prog_run() and initialises the pages to contain XDP frames with the
data passed in by userspace. These frames can then be handled as though
they came from the hardware XDP path, and the existing page_pool code takes
care of returning and recycling them. The setup is optimised for high
performance with a high number of repetitions to support stress testing and
the traffic generator use case; see patch 1 for details.

v10:
- Only propagate memory allocation errors from xdp_test_run_batch()
- Get rid of BPF_F_TEST_XDP_RESERVED; batch_size can be used to probe
- Check that batch_size is unset in non-XDP test_run funcs
- Lower the number of repetitions in the selftest to 10k
- Count number of recycled pages in the selftest
- Fix a few other nits from Martin, carry forward ACKs

v9:
- XDP_DROP packets in the selftest to ensure pages are recycled
- Fix a few issues reported by the kernel test robot
- Rewrite the documentation of the batch size to make it a bit clearer
- Rebase to newest bpf-next

v8:
- Make the batch size configurable from userspace
- Don't interrupt the packet loop on errors in do_redirect (this can be
  caught from the tracepoint)
- Add documentation of the feature
- Add reserved flag userspace can use to probe for support (kernel didn't
  check flags previously)
- Rebase to newest bpf-next, disallow live mode for jumbo frames

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

Toke Høiland-Jørgensen (5):
  bpf: Add "live packet" mode for XDP in BPF_PROG_RUN
  Documentation/bpf: Add documentation for BPF_PROG_RUN
  libbpf: Support batch_size option to bpf_prog_test_run
  selftests/bpf: Move open_netns() and close_netns() into
    network_helpers.c
  selftests/bpf: Add selftest for XDP_REDIRECT in BPF_PROG_RUN

 Documentation/bpf/bpf_prog_run.rst            | 117 +++++++
 Documentation/bpf/index.rst                   |   1 +
 include/uapi/linux/bpf.h                      |   3 +
 kernel/bpf/Kconfig                            |   1 +
 kernel/bpf/syscall.c                          |   2 +-
 net/bpf/test_run.c                            | 331 +++++++++++++++++-
 tools/include/uapi/linux/bpf.h                |   3 +
 tools/lib/bpf/bpf.c                           |   1 +
 tools/lib/bpf/bpf.h                           |   3 +-
 tools/testing/selftests/bpf/network_helpers.c |  86 +++++
 tools/testing/selftests/bpf/network_helpers.h |   9 +
 .../selftests/bpf/prog_tests/tc_redirect.c    |  89 -----
 .../bpf/prog_tests/xdp_do_redirect.c          | 177 ++++++++++
 .../bpf/progs/test_xdp_do_redirect.c          | 100 ++++++
 14 files changed, 818 insertions(+), 105 deletions(-)
 create mode 100644 Documentation/bpf/bpf_prog_run.rst
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_do_redirect.c

-- 
2.35.1


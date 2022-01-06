Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C25E486AB9
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 20:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243501AbiAFT7o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 14:59:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50074 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243460AbiAFT7o (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 Jan 2022 14:59:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641499183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+UT7ahSyEvqF0vyXZzW9uwguimJumnfjaEwsrTCo3Bs=;
        b=H9d5e/f+Liw7v6vEKMvVu51D4kGhQwGNpiRt7mkFxkymMo6kf3QYUf8EZrxgvoX35IzBkX
        JFtS3C32ZaXSNG05Nxx2/CGlbS2QoNtpGsP9InH7Di0VmC1IaJbNqZid7Xu+vy9O7sC0/8
        95Gk0qs68NXHwmFeE2PozLuGWV6lyQQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-220-xpSR0-eiNE-z6MnfCqdW6g-1; Thu, 06 Jan 2022 14:59:42 -0500
X-MC-Unique: xpSR0-eiNE-z6MnfCqdW6g-1
Received: by mail-ed1-f72.google.com with SMTP id r8-20020a05640251c800b003f9a52daa3fso2737360edd.22
        for <bpf@vger.kernel.org>; Thu, 06 Jan 2022 11:59:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+UT7ahSyEvqF0vyXZzW9uwguimJumnfjaEwsrTCo3Bs=;
        b=UR1B67wGjN1jZ7F5oveLyOzVZ3ABX5jd0BpxG5DWEEv49a0rYZvHRN5AKnwtXzm2PK
         RYSNaDYpRMj+0TUrUu4hIOSwhuyUovovXxzXbxSWyEe/s+VIBf2/73P+xO26IcbjkD0+
         sCR4oOnCeaQYY3se1vDeb8ZK/AIUYfOE17lHg0ZBoifG1eoSHRrGsD1H55/UG1u/s24E
         18WK0CueJc296w6wbu3CXy+NddbJAb2Z0sRltoOjGcbxZGt/fOg9cS1l6j/9gAYW7eAa
         J1HOgP/kHFDo7SR2f7iCMU/yBNLLXCacjw4RkFRmC48cI2g0r5/3ER4dc5JxWG04s2gQ
         Rp8Q==
X-Gm-Message-State: AOAM533G29498xM+B7+KOdW0sm2pQgIJOyxl39WiZ6qYoYE9Kz5tExO8
        Q8eylgZ50QBTTt2NmcrXvR/kdS1HlSjT3U8Q7isTUI4HSZADA1WsZRJ0nV87N/q3XvN3jzHoTea
        gXF9M4URWn0ZK
X-Received: by 2002:a17:906:c111:: with SMTP id do17mr45492396ejc.270.1641499181336;
        Thu, 06 Jan 2022 11:59:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx3luHYq5Qxcet+Tu4cqsJmhAiNuDJ0Jxafs3mO7aeXC8GfLhnfjGJJmg4iFSOJ+QRgdkm4bw==
X-Received: by 2002:a17:906:c111:: with SMTP id do17mr45492370ejc.270.1641499180881;
        Thu, 06 Jan 2022 11:59:40 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 16sm755814ejx.149.2022.01.06.11.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 11:59:40 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9B326181F2A; Thu,  6 Jan 2022 20:59:39 +0100 (CET)
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
Subject: [PATCH bpf-next v6 0/3] Add support for transmitting packets using XDP in bpf_prog_run()
Date:   Thu,  6 Jan 2022 20:59:35 +0100
Message-Id: <20220106195938.261184-1-toke@redhat.com>
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
 .../bpf/prog_tests/xdp_do_redirect.c          | 151 +++++++++
 .../bpf/progs/test_xdp_do_redirect.c          |  78 +++++
 9 files changed, 611 insertions(+), 95 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_do_redirect.c

-- 
2.34.1


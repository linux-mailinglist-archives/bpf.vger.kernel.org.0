Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3D1471564
	for <lists+bpf@lfdr.de>; Sat, 11 Dec 2021 19:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhLKSnc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Dec 2021 13:43:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:39155 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231758AbhLKSna (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 11 Dec 2021 13:43:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639248209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Eu8tHVFbR3OhhxKHk08d7P6coxTGoivQlep7ShPJrZE=;
        b=M9t113zDzrBcoTGcxJJm9x3IVbkgkQPr4zZw22oVsehj6VH8FXBFmte7xk4B5rElDhqZk9
        c9opLHdHiELDdNakGIlAX6oS2yGTVr82sw1UqDaR+t9qX4zsjNKVt/M+UL4a7Eo65ep8LP
        caXn+F2AsdSPogBKoFJx2RRYdy2i4eE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-383-CNyMx0n7N92cxgVbG6eJ8A-1; Sat, 11 Dec 2021 13:43:28 -0500
X-MC-Unique: CNyMx0n7N92cxgVbG6eJ8A-1
Received: by mail-ed1-f72.google.com with SMTP id l15-20020a056402124f00b003e57269ab87so10757263edw.6
        for <bpf@vger.kernel.org>; Sat, 11 Dec 2021 10:43:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Eu8tHVFbR3OhhxKHk08d7P6coxTGoivQlep7ShPJrZE=;
        b=HmD8WnacUr7NHNaA4Vzp1Gpn6xQ28J40TO8Ryz49oSM2sQK92YAaOdrZ4Vkd50VcYc
         6AIO07qz1RwdDKaQ1wIOJuBqKU7OCGlvxKniRF5LUmpr/QxasWZ9viHyiDPxHQaP8y6n
         FdGaW31JUTshlEwihV5+nDYfTiuAnTKKfDzWId2XGu/Wqk6szOtDT/A0lQc+AbL7lpjz
         0e4nlT609W4w/RCUDGCupjTZqVXslplpVdE537Km+YgjJ0NdlBCV6llOsa7W/eRFv5yw
         mnkuKRxpcYy0ZmUVhq8XH2bI8e7JbY9qPvnYRQ6SPKUy+Om3raBLkL7OYAJel0FmLKQb
         HsFg==
X-Gm-Message-State: AOAM5305IBeXN5iu1WrL2loVT+qmy7U9Cs820t8ovOwIC2D+m1XjVDgw
        UMjsaTEneVd9c00BhWCBhJ2zQtXLYvd/Uf08al91RurjnZfnwW3ZSfhto/nGvChzlJdFqQtADLF
        TZipKko8E6f1u
X-Received: by 2002:a17:906:7109:: with SMTP id x9mr31813414ejj.559.1639248205812;
        Sat, 11 Dec 2021 10:43:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw27h0xuBSmxD9o3caYYK1urvEKCVvaXzV1wyUbxugqm8Q90giGbsI/T1mzl0ldfJ/5iipfUA==
X-Received: by 2002:a17:906:7109:: with SMTP id x9mr31813341ejj.559.1639248204962;
        Sat, 11 Dec 2021 10:43:24 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id d18sm3460679edj.23.2021.12.11.10.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 10:43:24 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 7D8C4180471; Sat, 11 Dec 2021 19:43:22 +0100 (CET)
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
Subject: [PATCH bpf-next v3 0/8] Add support for transmitting packets using XDP in bpf_prog_run()
Date:   Sat, 11 Dec 2021 19:41:34 +0100
Message-Id: <20211211184143.142003-1-toke@redhat.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series adds support for transmitting packets using XDP in
bpf_prog_run(), by enabling the xdp_do_redirect() callback so XDP programs
can perform "real" redirects to devices or maps, using an opt-in flag when
executing the program.

The primary use case for this is testing the redirect map types and the
ndo_xdp_xmit driver operation without generating external traffic. But it
turns out to also be useful for creating a programmable traffic generator.
The last patch adds a sample traffic generator to bpf/samples, which
can transmit up to 11.5 Mpps/core on my test machine.

To transmit the frames, the new mode instantiates a page_pool structure in
bpf_prog_run() and initialises the pages with the data passed in by
userspace. These pages can then be redirected using the normal redirection
mechanism, and the existing page_pool code takes care of returning and
recycling them. The setup is optimised for high performance with a high
number of repetitions to support stress testing and the traffic generator
use case; see patch 6 for details.

The series is structured as follows: Patches 1-2 adds a few features to
page_pool that are needed for the usage in bpf_prog_run(). Similarly,
patches 3-5 performs a couple of preparatory refactorings of the XDP
redirect and memory management code. Patch 6 adds the support to
bpf_prog_run() itself, patch 7 adds a selftest, and patch 8 adds the
traffic generator example to samples/bpf.

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

Toke Høiland-Jørgensen (8):
  xdp: Allow registering memory model without rxq reference
  page_pool: Add callback to init pages when they are allocated
  page_pool: Store the XDP mem id
  xdp: Move conversion to xdp_frame out of map functions
  xdp: add xdp_do_redirect_frame() for pre-computed xdp_frames
  bpf: Add XDP_REDIRECT support to XDP for bpf_prog_run()
  selftests/bpf: Add selftest for XDP_REDIRECT in bpf_prog_run()
  samples/bpf: Add xdp_trafficgen sample

 include/linux/bpf.h                           |  20 +-
 include/linux/filter.h                        |   4 +
 include/net/page_pool.h                       |  11 +-
 include/net/xdp.h                             |   3 +
 include/uapi/linux/bpf.h                      |   2 +
 kernel/bpf/Kconfig                            |   1 +
 kernel/bpf/cpumap.c                           |   8 +-
 kernel/bpf/devmap.c                           |  32 +-
 net/bpf/test_run.c                            | 217 ++++++++-
 net/core/filter.c                             |  73 ++-
 net/core/page_pool.c                          |   6 +-
 net/core/xdp.c                                |  94 ++--
 samples/bpf/.gitignore                        |   1 +
 samples/bpf/Makefile                          |   4 +
 samples/bpf/xdp_redirect.bpf.c                |  34 ++
 samples/bpf/xdp_trafficgen_user.c             | 421 ++++++++++++++++++
 tools/include/uapi/linux/bpf.h                |   2 +
 .../bpf/prog_tests/xdp_do_redirect.c          |  74 +++
 .../bpf/progs/test_xdp_do_redirect.c          |  34 ++
 19 files changed, 947 insertions(+), 94 deletions(-)
 create mode 100644 samples/bpf/xdp_trafficgen_user.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_do_redirect.c

-- 
2.34.0


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1EA465A4F
	for <lists+bpf@lfdr.de>; Thu,  2 Dec 2021 01:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354014AbhLBAHV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Dec 2021 19:07:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46775 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344222AbhLBAHS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 1 Dec 2021 19:07:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638403436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=fSr+KoEIWo8E81JSKgnaP/OFNTm6nID/Hkd90v+JLcg=;
        b=AEi6sN2z4ZvDy01bsGKhtxMl9eCmfMXxPMwMnrb6skij3+dzPqPffneMICbNuGM3ExR/bo
        8WIwEXQm8oTwlZ2czaF6BLH834h/UmHmPAetamo6qtReqc81sUriY4qSLIPMAPwy63QIEG
        KOMoKzFziFdiKrdcUy31GHDkpVNh2IA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-10-V8HEL1xlNmej0ehAuhoRtg-1; Wed, 01 Dec 2021 19:03:55 -0500
X-MC-Unique: V8HEL1xlNmej0ehAuhoRtg-1
Received: by mail-ed1-f70.google.com with SMTP id q17-20020aa7da91000000b003e7c0641b9cso21843537eds.12
        for <bpf@vger.kernel.org>; Wed, 01 Dec 2021 16:03:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fSr+KoEIWo8E81JSKgnaP/OFNTm6nID/Hkd90v+JLcg=;
        b=k7w/pLTztmsPhyx1F3h857PZ/Pli5R6RjCDCipFbD+o8n1rLvsnfYo3XRVLM+z+wwS
         ND4eMvswFNckP92IuNwTHznWP7k++OieYjumnuQ3LV7A2Tog+bQxcS+141ZHfT4XRP+H
         Ldtgm/4Mas0C/6HspRzej+HoUmYvHkAfcsqz6w99CXPydqIHtSj6k/lPAYsZ3vren+/6
         nRg9YA93YZFJWMb8WPbAA7uQU+uRHC1mUwHEG303SYvT8gSKVqreyipVWlvkKY8+Vmdy
         0uFiWXS9M91q3lXzuQkdj9xcJYr0iZfPwboprkAAZ62RkJPqYjtozm9FggffQdZlKcMB
         XrNA==
X-Gm-Message-State: AOAM5300/6tOy9KJxXZdVN/KfbadaoKvvC78V75dCp2BEH0TFg3m2Zqk
        7RcslAJYroAK+dr/PoMD7K9xQjcuPkjRhKkM0Gl0UTXPeIx7IK96Ad78XJu1whqeLLp4oAjbU9l
        0qjA4o1YXKL2k
X-Received: by 2002:a50:ec16:: with SMTP id g22mr12502163edr.214.1638403433485;
        Wed, 01 Dec 2021 16:03:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyu1r8ybiI3w4s1N7qY0K+P1bCSCb7+/OV7H9aieQDcNQt9JLQxWIcdvoO+IZoJvKC2UpE0TA==
X-Received: by 2002:a50:ec16:: with SMTP id g22mr12502024edr.214.1638403432375;
        Wed, 01 Dec 2021 16:03:52 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id sa3sm625053ejc.113.2021.12.01.16.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 16:03:51 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3C7C81802A0; Thu,  2 Dec 2021 01:03:50 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH bpf-next 0/8] Add support for transmitting packets using XDP in bpf_prog_run()
Date:   Thu,  2 Dec 2021 01:02:21 +0100
Message-Id: <20211202000232.380824-1-toke@redhat.com>
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

Toke Høiland-Jørgensen (8):
  page_pool: Add callback to init pages when they are allocated
  page_pool: Store the XDP mem id
  xdp: Allow registering memory model without rxq reference
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
 net/bpf/test_run.c                            | 197 +++++++-
 net/core/filter.c                             |  41 +-
 net/core/page_pool.c                          |   6 +-
 net/core/xdp.c                                |  94 ++--
 samples/bpf/.gitignore                        |   1 +
 samples/bpf/Makefile                          |   4 +
 samples/bpf/xdp_redirect.bpf.c                |  34 ++
 samples/bpf/xdp_trafficgen_user.c             | 444 ++++++++++++++++++
 tools/include/uapi/linux/bpf.h                |   2 +
 .../bpf/prog_tests/xdp_do_redirect.c          |  74 +++
 .../bpf/progs/test_xdp_do_redirect.c          |  34 ++
 19 files changed, 920 insertions(+), 92 deletions(-)
 create mode 100644 samples/bpf/xdp_trafficgen_user.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_do_redirect.c

-- 
2.34.0


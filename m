Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7A643606E
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 13:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhJULnw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 07:43:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24806 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229765AbhJULnv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 21 Oct 2021 07:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634816495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=L2e4spOXfMpskoS1N0H4A7qUNY78c1wAiks2CIeTGAQ=;
        b=ZRIGxZA4avtHmPI3RprqMo8IHRb1ouFAxxkoGlsUmBV3h9caWYMh8I3f5KjNniVIp1JWgd
        LHge+0YTA3jF6oCY41gRLtJsQ0lXuvXDlfPO/BixzdKlFQTMA8UTIrlKVJsm4LmOuBe7vD
        f8aFv/o6kdtnApL7HkFTg8+QHO7hVj8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-599-VB3jZMw7NxS7840b9G-2SA-1; Thu, 21 Oct 2021 07:41:34 -0400
X-MC-Unique: VB3jZMw7NxS7840b9G-2SA-1
Received: by mail-ed1-f71.google.com with SMTP id g28-20020a50d0dc000000b003dae69dfe3aso35674edf.7
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 04:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L2e4spOXfMpskoS1N0H4A7qUNY78c1wAiks2CIeTGAQ=;
        b=1oa41hbedyXawAOpWpzEm1NAAxv2HA53VH+Mwy3ng2xGU+zaJKRjBCjn0SxAlKVaEp
         k5N28Vn34UBWoGrUgY9B2/jkfxbRcT7CDJzq+uZa0BLwgaEqfztigoNlE5ZnSbqcs191
         wy+8rWy00GKHqhQ9qIvyGf4kRA9jM4q/Pj/64kNIwmUytKfDuAiHYefyvO4TLTW8ojzL
         TlOOnLZez8crM413I6qB9C83xDl6fvw3yjMw4FXzWI81EjAFAXrU6RegVpBbQC7Nv6Ht
         vW3kpH++M45IMNdOSIwp28an5xjeSqgL8niojZR1HN+uXSWoNOL1MmclSSiu++EJn4Ny
         zHdA==
X-Gm-Message-State: AOAM531izf1U6eT0JoqDAV8eh9TTxJEM9ml12ULZRc2joHB4PowCCTBT
        pwfQHcMF9OQB1Q2Uv8a6aVL6PZWGCwDoInGhvTnV7WyH3ucBNkgn7OPqmb/8hr1m9w8JHv/HRTf
        VbSx9H9vBvnK7
X-Received: by 2002:a05:6402:2553:: with SMTP id l19mr6934937edb.321.1634816493338;
        Thu, 21 Oct 2021 04:41:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0/PpaJBgA3ZF+GNCyLqQ+YOun7Y/ZtdJIj1MoEWgtX6K0YICG+8Suaaa0E9xfjgwyIjkUAg==
X-Received: by 2002:a05:6402:2553:: with SMTP id l19mr6934908edb.321.1634816493207;
        Thu, 21 Oct 2021 04:41:33 -0700 (PDT)
Received: from krava.cust.in.nbox.cz ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id y6sm2459996ejf.58.2021.10.21.04.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 04:41:32 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: [PATCH bpf-next 0/3] selftests/bpf: Fixes for perf_buffer test
Date:   Thu, 21 Oct 2021 13:41:29 +0200
Message-Id: <20211021114132.8196-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

hi,
sending fixes for perf_buffer test on systems
with offline cpus.

v2:
  - resend due to delivery issues, no changes

thanks,
jirka


---
Jiri Olsa (3):
      selftests/bpf: Fix perf_buffer test on system with offline cpus
      selftests/bpf: Fix possible/online index mismatch in perf_buffer test
      selftests/bpf: Use nanosleep tracepoint in perf buffer test

 tools/testing/selftests/bpf/prog_tests/perf_buffer.c | 17 +++++++++--------
 tools/testing/selftests/bpf/progs/test_perf_buffer.c |  2 +-
 2 files changed, 10 insertions(+), 9 deletions(-)


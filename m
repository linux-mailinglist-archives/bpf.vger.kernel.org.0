Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28034AAF7C
	for <lists+bpf@lfdr.de>; Sun,  6 Feb 2022 14:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239931AbiBFNlM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 6 Feb 2022 08:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234549AbiBFNlL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 6 Feb 2022 08:41:11 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34CBC06173B
        for <bpf@vger.kernel.org>; Sun,  6 Feb 2022 05:41:09 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id y15-20020a17090a474f00b001b88562650aso1852192pjg.0
        for <bpf@vger.kernel.org>; Sun, 06 Feb 2022 05:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7MdgxYw+wYZgp12jhKedSB9Ak7hju2GWIc/H6lHz74w=;
        b=mvkxnUszZYptot4wafSVqlQmcH7ACYQ6BakOyTJ6xQw1pcQmSsM2W7JTPQAtewmHz8
         vCsYtZ46Ip+R4/Sngm02w0RZfBXsVy1FV4uHqZe6JlVneVyX5+/wq007CtmJVzdjtkBC
         bfdLbCcVKnODhB10Cp3gV26ZKP7mGbB/bZgMNHL4aeoeWo5kZdIPNCZpfVzoN2z8zd3U
         Ylz+5qPQYBDyKKic4LH4ARquoYpPaQT8+skeAikQSFmJuTFKTglqFszDi/qiryWDPwgZ
         le1Wpir/gDyyNlAzMaeHo+nn1K9pEv/FAQzFViYVwBXQVR7LK2fvh8B7FS0EkvN0XFzP
         CsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7MdgxYw+wYZgp12jhKedSB9Ak7hju2GWIc/H6lHz74w=;
        b=yRR1Ac+WXs+t1F/BG6L315t4lfNeVvq5DFPOkMOR96BDIG99JgXvc+5aOtZgT/X4RL
         HzptYskZy1prYhkbDQuotimic2etM5r3yEwybScFAscD1Fpb2OMq/tqqMigZvDOVtUhg
         oN9Boa/c2ajA4IkEdFPEGQSSSFmNzGKLAR3AaPv34B6BapoXOgTR+pMWGYUtSYfrEO0c
         GeLAHA4tHXzEKXFMAbPypSYwrA0VSOY41XS4Pcv3wnr/HPk1CEFUJRhrIk0latLE6qpK
         rWVHVR3zvM0jW9PmGMP+xbGDU24cN6rew0AAYTcWMGawRqL2heLpOw12IzDwLSHWEmbp
         LXVg==
X-Gm-Message-State: AOAM532UlLGkd2wn1Apbr2mecFQm9WXlt6S8eIPgSGZaJnEeiYxB8dL/
        A7kb94/Wn30Gktktv1QjmB2wSxBy/Vnat/YM
X-Google-Smtp-Source: ABdhPJwTBm8rc8fX5++Tcn8adk/8qQt6tVrkabLGp5Pr0G6HLj6sa38nhY3U7eodSXXoeDJ19sDIwg==
X-Received: by 2002:a17:903:234b:: with SMTP id c11mr12183642plh.157.1644154869351;
        Sun, 06 Feb 2022 05:41:09 -0800 (PST)
Received: from chenhengqi-X1.. ([113.64.186.12])
        by smtp.gmail.com with ESMTPSA id e17sm8500982pfv.101.2022.02.06.05.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 05:41:09 -0800 (PST)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, hengqi.chen@gmail.com
Subject: [PATCH bpf-next v2 0/2] libbpf: Add syscall-specific variant of BPF_KPROBE
Date:   Sun,  6 Feb 2022 21:40:49 +0800
Message-Id: <20220206134051.721574-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add new macro BPF_KPROBE_SYSCALL, which provides easy access to syscall
input arguments. See [0] and [1] for background.

  [0]: https://github.com/libbpf/libbpf-bootstrap/issues/57
  [1]: https://github.com/libbpf/libbpf/issues/425

Hengqi Chen (2):
  libbpf: Add BPF_KPROBE_SYSCALL macro
  selftests/bpf: Test BPF_KPROBE_SYSCALL macro

 tools/lib/bpf/bpf_tracing.h                   | 39 +++++++++++++++++++
 .../selftests/bpf/prog_tests/kprobe_syscall.c | 37 ++++++++++++++++++
 .../selftests/bpf/progs/test_kprobe_syscall.c | 34 ++++++++++++++++
 3 files changed, 110 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kprobe_syscall.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_kprobe_syscall.c

--
2.30.2

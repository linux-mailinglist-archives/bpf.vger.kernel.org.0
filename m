Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08EE047B9B5
	for <lists+bpf@lfdr.de>; Tue, 21 Dec 2021 06:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbhLUFxl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Dec 2021 00:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbhLUFxk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Dec 2021 00:53:40 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF56C06173E
        for <bpf@vger.kernel.org>; Mon, 20 Dec 2021 21:53:40 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id c7so1108667plg.5
        for <bpf@vger.kernel.org>; Mon, 20 Dec 2021 21:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FyC15crtzSFmHOKCdBwsbLTxYDVHhZcJXTMkJlICNzg=;
        b=oRyDXuqxvY79O57LgME81lt2gvpC9Jh36ZUdw6W7l8w62Vnks0pOixoEJ0Z0aRDS4v
         P7JrWeAks4u7lqAdE1BiWYNJ9UJqLxJKxDXVtC5aBDrTs5kLgpdEdpbGep2uLQYojBeo
         /oGPM1Nl7FkvcXtm+pHqtUD76FAySBXhK0G6R9zhHXNQOd3XBi2n4il+prY5cbqbwMob
         5F9mmCYKRECfrjCpI7YOMUTZdeKa0M3UmjfhoF8JgG1jrGQuUs1ZpkyEK6N8sn7YSRIU
         Evtnoz0SsNXarrCGNM7udQJnqcfdG6tMmICVFmmBFm1dFZU1YLn7oq2IiefsU/vft+re
         Fi2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FyC15crtzSFmHOKCdBwsbLTxYDVHhZcJXTMkJlICNzg=;
        b=63pkFa6iUSDI41QX5+BBNyy87OtCNV4X2+87TbFVIeXLSqB7pjE/xjXRgeO5/VPLkl
         4aCPnWg2Yqdcl0wHN1woSgiC57z9eN8C+tBvGEZgvn+u4c1qGqoWMACM8AwvGg2ItwaS
         HiyNWY5s2owlFB8nY5acoITcwcGvQNGzogoaj5T49gCPG2O7vTRvtKHr2yawDfG1trY6
         eL+bG8Nx9Krck+Sykg8XXo42EgmbOcYqHCQy8lDmyU6YkMNDJXf3r0DOyIvIjRIc+j52
         fwuHiGlI5R20GbpHzwheuEd4x6037Juw2kzlWnPVx2PhV/lRWs6nv/go16+K7+Mxl+NM
         TVRQ==
X-Gm-Message-State: AOAM533hmlbnqVR4O8Ghn4UIGRmeXB0i4hyCh+0dg8SemUCIGl3AsboO
        A3QEJnMbIqQEtMRqcYzYw3oV0T0TtwVHJw==
X-Google-Smtp-Source: ABdhPJweBgQMUMrmuRa0Eki7/L97tAMQD1epC4e9/++Sx2sxFLweid12Y8iD+Bb7lybuYfTy6ERvwA==
X-Received: by 2002:a17:90a:7d09:: with SMTP id g9mr2041109pjl.199.1640066020127;
        Mon, 20 Dec 2021 21:53:40 -0800 (PST)
Received: from VM-32-4-ubuntu.. ([43.132.164.184])
        by smtp.gmail.com with ESMTPSA id s16sm20441330pfu.109.2021.12.20.21.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 21:53:39 -0800 (PST)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org, andrii@kernel.org, hengqi.chen@gmail.com
Subject: [PATCH bpf-next 0/2] libbpf: Add syscall-specific variants of BPF_KPROBE/BPF_KRETPROBE
Date:   Tue, 21 Dec 2021 05:53:10 +0000
Message-Id: <20211221055312.3371414-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add new macros BPF_KPROBE_SYSCALL/BPF_KRETPROBE_SYSCALL, which provides
easy access to syscall input arguments and return values. See [0] and [1]
for background.

  [0]: https://github.com/libbpf/libbpf-bootstrap/issues/57
  [1]: https://github.com/libbpf/libbpf/issues/425

Hengqi Chen (2):
  libbpf: Add BPF_KPROBE_SYSCALL/BPF_KRETPROBE_SYSCALL macros
  selftests/bpf: Test BPF_KPROBE_SYSCALL/BPF_KRETPROBE_SYSCALL macros

 tools/lib/bpf/bpf_tracing.h                   | 45 +++++++++++++++++++
 .../selftests/bpf/prog_tests/kprobe_syscall.c | 40 +++++++++++++++++
 .../selftests/bpf/progs/test_kprobe_syscall.c | 41 +++++++++++++++++
 3 files changed, 126 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kprobe_syscall.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_kprobe_syscall.c

--
2.30.2

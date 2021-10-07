Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1216425518
	for <lists+bpf@lfdr.de>; Thu,  7 Oct 2021 16:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241991AbhJGOPm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Oct 2021 10:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241995AbhJGOPl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Oct 2021 10:15:41 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5144C061570
        for <bpf@vger.kernel.org>; Thu,  7 Oct 2021 07:13:47 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id c4so4033146pls.6
        for <bpf@vger.kernel.org>; Thu, 07 Oct 2021 07:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SnDvlPrqtqpX2g+3zAQdpKtOq6c2S89TdaZwJVxitW0=;
        b=IC1io3K3jxybX+9a6fX2BA7kGSKI0A2Cf5KpjwdoPiCqzXksLnt0Ii86QcPhjc3ubs
         hAkkF0RkKckwgfk/APOGDvaA83jtF7xMtyxebeGFUIOGiG/0cnISY9/29gmXXE0xuy1e
         WSOBJOlL2BfJDXYenbXqVSY82CbAt8eXc+juPVGyC1k7V7oa2VCebe5dSiSvYNAh9Kv6
         L0xordWwNogUdIqZxO510jbMprDgAYyPvtzYx6yTEsGrHcoRXTO9D4Fii+MKCf6tiLQH
         uuq2vV40Y+mySmJmftudwAwX2F0CZB27NBTEitwUetoGLh/T3emykqL5eUbmq+KXqa9X
         sYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SnDvlPrqtqpX2g+3zAQdpKtOq6c2S89TdaZwJVxitW0=;
        b=eb3ZE8A3AUxDPJu/GddwFmifUobCCcScpdwv6MH4kBnO8OWwMOL60ChuaOyrkDS2Mr
         ZF/VuK9d2n+yK4XzP7Tr/UQ+dKUhqDp+yYt3U+JKxIcMFepIXIDQ97HhnjdPBn90wJnO
         uW9Qrd9dsIEKPx5PxuMDugg6xa5BEY+ePVxTWl/ahgWYrXbHAIyf96FYIPJvloxsgeer
         UemmsJG/D+C73uZedScIkd/ZT0JMKetVOwleaNHh61ZIX7bsLjuVlPh4eqKGn1ikStra
         Brs26pBqPg1KKab9VA20dX/zis+mkWzQS4oQC3D9js/HtDaX+bJ9yo3qSg2pHZ1HJYv+
         rTHw==
X-Gm-Message-State: AOAM5307O4HgXkFtZZOfk+AhpyEzyPah2iWDX+QesDSVQAWzFWadPihx
        dpBsAEOTxN4alqQO9lhubjCeOERVSzJo8A==
X-Google-Smtp-Source: ABdhPJyShS4HRu/eQta26E6hmqilGNNErCTKhHLWx/zftQrhI4U5ToDnjtLVJeDEkm8iBKP47V6bdA==
X-Received: by 2002:a17:90b:3852:: with SMTP id nl18mr5037969pjb.94.1633616027335;
        Thu, 07 Oct 2021 07:13:47 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id rm6sm3102699pjb.18.2021.10.07.07.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 07:13:47 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kafai@fb.com,
        songliubraving@fb.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next 0/2 v2] Add bpf_skc_to_unix_sock() helper
Date:   Thu,  7 Oct 2021 22:13:29 +0800
Message-Id: <20211007141331.723149-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set adds a new BPF helper bpf_skc_to_unix_sock().
The helper is used in tracing programs to cast a socket
pointer to a unix_sock pointer.

v1->v2:
 - Update selftest, remove trailing spaces changes (Song)

Hengqi Chen (2):
  bpf: Add bpf_skc_to_unix_sock() helper
  selftests/bpf: Test bpf_skc_to_unix_sock() helper

 include/linux/bpf.h                           |  1 +
 include/uapi/linux/bpf.h                      |  7 +++
 kernel/trace/bpf_trace.c                      |  2 +
 net/core/filter.c                             | 23 ++++++++
 scripts/bpf_doc.py                            |  2 +
 tools/include/uapi/linux/bpf.h                |  7 +++
 .../bpf/prog_tests/skc_to_unix_sock.c         | 54 +++++++++++++++++++
 .../bpf/progs/test_skc_to_unix_sock.c         | 29 ++++++++++
 8 files changed, 130 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/skc_to_unix_sock.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_skc_to_unix_sock.c

--
2.25.1

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC877420302
	for <lists+bpf@lfdr.de>; Sun,  3 Oct 2021 18:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbhJCRAy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Oct 2021 13:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbhJCRAx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Oct 2021 13:00:53 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D813DC0613EC
        for <bpf@vger.kernel.org>; Sun,  3 Oct 2021 09:59:05 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 75so14354481pga.3
        for <bpf@vger.kernel.org>; Sun, 03 Oct 2021 09:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sns/D/csbbuS4NoPXV/mjUYECM6qPCQZ0P6hnA06ZbI=;
        b=R1IdyJFtMetdDwbD5U2HimE9Ogg80WbdlYfZ2K3ebxtJub0OFiCMHCU9fy6CLV0mJk
         23LfgPeRoj7kI3eUs57Z8REEEdauLUYAyL6tOpRNemJI4xFhbAMcNAfuv1r4NGIfky4w
         FL8eKQDFJqwmB8s6vTi7hol9yjGzqmAab/khyGrn0waU4GrRa2d1Q+DO8Uij7tCDPnm1
         GopSW61CSrF2yFyf/pUHxycDGXcEpLhcZKDgEH7X4h4id8IdBvJUwSSOlZ7AqWLFbu0z
         0Ks153He/LbPqKm4+D5306rVu35CJiyfY5aUaMtB6IRQXrfEXmLzIz45RBeVr/VdbSAK
         c80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sns/D/csbbuS4NoPXV/mjUYECM6qPCQZ0P6hnA06ZbI=;
        b=beQQdQMeMNS7FbW4O9bxsphfHVz5YGKwzw3E7iq/IXTrFT0XEk4yTuhCk4FPoNZFCu
         sPygHyCVz2wO1lUzX8GeYG1XVDH/ACXDmTBtqOAQ3QwvACIAjbPIqddUD5+SOTTpLqqp
         PBoqDAw49IjmS76wLKepDrC+6egfbE/6NmPy7r8humCqWmpZtX3bIhixzU6MKoePrJpZ
         fH48rau7xini2TiH9Zy7RKl+/pMufznXVF49BGvxuHXxff5iXq9yamGurubWI4iJYXZ8
         OlkLhqw7wLiE85pSSZ+JDYphQf9FvnI/w/qsiYLfT0kXtNMSiohI0dyjm3EDuMbPNX25
         QvDQ==
X-Gm-Message-State: AOAM533tvNQIPDxrkWKURHUUKmMCHrm675z5uAM5dUz+8c/9Twc0jh3G
        Zo9r+cbGYQSjkl4x1+9ejcR0KFT/V9qeFQ==
X-Google-Smtp-Source: ABdhPJzam0tP+uF5zXH1wXin0PszX3jn48fDJRpL5kP+A6XexnsxDS+bvxgqr0wmJtEcPrYaEpczYA==
X-Received: by 2002:a63:8c4d:: with SMTP id q13mr7232673pgn.92.1633280345163;
        Sun, 03 Oct 2021 09:59:05 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id e11sm11592296pfm.79.2021.10.03.09.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 09:59:04 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next 0/2 v2] libbpf: Deprecate bpf_{map,program}__{prev,next} APIs since v0.7
Date:   Mon,  4 Oct 2021 00:58:42 +0800
Message-Id: <20211003165844.4054931-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_{map,program}__{prev,next} don't follow the libbpf API naming
convention. Deprecate them and replace them with a new set of APIs
named bpf_object__{prev,next}_{program,map}.

v1->v2: [0]
  * Addressed Andrii's comments

  [0]: https://patchwork.kernel.org/project/netdevbpf/patch/20210906165456.325999-1-hengqi.chen@gmail.com/

Hengqi Chen (2):
  libbpf: Deprecate bpf_{map,program}__{prev,next} APIs since v0.7
  selftests/bpf: Switch to new bpf_object__next_{map,program} APIs

 tools/lib/bpf/libbpf.c                        | 24 +++++++++++++
 tools/lib/bpf/libbpf.h                        | 35 ++++++++++++-------
 tools/lib/bpf/libbpf.map                      |  4 +++
 tools/testing/selftests/bpf/prog_tests/btf.c  |  2 +-
 .../selftests/bpf/prog_tests/fexit_bpf2bpf.c  |  6 ++--
 .../bpf/prog_tests/select_reuseport.c         |  2 +-
 .../selftests/bpf/prog_tests/tcp_rtt.c        |  2 +-
 tools/testing/selftests/bpf/xdping.c          |  2 +-
 8 files changed, 58 insertions(+), 19 deletions(-)

--
2.25.1

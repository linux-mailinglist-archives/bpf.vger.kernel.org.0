Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B053D4E13
	for <lists+bpf@lfdr.de>; Sun, 25 Jul 2021 16:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhGYNiS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 25 Jul 2021 09:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhGYNiR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 25 Jul 2021 09:38:17 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24914C061757
        for <bpf@vger.kernel.org>; Sun, 25 Jul 2021 07:18:47 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id t21so8428564plr.13
        for <bpf@vger.kernel.org>; Sun, 25 Jul 2021 07:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZoUqLLgy7AASWflOJhcHCQKxuW5WVW+OW0zvVYdXUTA=;
        b=kuERn2aH2htcfCLC3Co1BG9D45ebtyWtaIDx9GH2SmQppa4ihWro4NXvZy9G3l8YQQ
         EyMtG2ntmeUWsS26+91mLcOJpa5h+uKd/S0XzrtUPVX3nIh46+y6gKGv7nDbMTSxOfYA
         EhESZO6znxaWeCouWcRVsgdi+iRp5reYVYOqGkdWWzNMW3WAJydLxCLCmI0Gx2Gluh44
         Eu6YAMLU86Fqs/hX3KxjqastJT+hssKZWd6p/V9G1e/yfBfK+otYJ0Y8LG9dBamOH7dP
         /+S83UaDLK5JwjMOSjNf669jorQrCITWbPQ00zwFv/wT+/eyGVZtCDQA5ErTeMNCdxdO
         bnwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZoUqLLgy7AASWflOJhcHCQKxuW5WVW+OW0zvVYdXUTA=;
        b=sqWCkb7zdw+hPDsFadLxNeZdS5+qklDIqIDMXMT1RpERmeIjZ1loRDPsw6R9Z0xrpY
         uuLMoHOoREoY1AVTHvyt4QRfrPEQlEVIt8Xwnm2mlL6beAWKxYqTl0Q008PXWkuShLrR
         SBr5A6Ao/qZdb0+pa1nqUKDnfMWVeRldnTvfhbovAHaIszVF2nNc1Sok0+dgipTCwlDR
         C9bBmINrzGYZg7Ixa7MZYyedMAF1mKBoJamP3ICiIfL2q9anrE3KgYSYUE0EYc5QNfDV
         p/TCMZNoMD16dnryWNH9HDyJ6/n/BoYeqUA9kdOj5tz1Ddap7TOHhF25CiD+9M7ieIaC
         3iXQ==
X-Gm-Message-State: AOAM531ssX8SmP8Ftpyz9x+5VupRMu0QxzAmKWyJVVDAOme+tcvQgTso
        wS6K4BxGbuM9aQIm8YOv/AeZRwaWX6dKnA==
X-Google-Smtp-Source: ABdhPJw6qfIsvOHX1/8292I6btvJaQ3F6qUxDDsxbU63Spk9YPaJlLtmfHk0KerVJN+4M3/BzMjF5Q==
X-Received: by 2002:a63:550c:: with SMTP id j12mr13838197pgb.31.1627222726557;
        Sun, 25 Jul 2021 07:18:46 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id q17sm48055188pgd.39.2021.07.25.07.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 07:18:46 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, jolsa@kernel.org,
        yanivagman@gmail.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next 0/2] expand bpf_d_path helper allowlist
Date:   Sun, 25 Jul 2021 22:18:12 +0800
Message-Id: <20210725141814.2000828-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch series adds more functions to bpf_d_path allowlist.

Patch 1 resolves an issue of missing symbols of .BTF_ids.
Patch 2 expands bpf_d_path allowlist.

Changes since v2: [2]
 - Andrii suggested that we should first address an issue of .BTF_ids
   before adding more symbols to .BTF_ids. Fixed that.
 - Yaniv proposed adding security_sb_mount and security_bprm_check.
   Added them.

Changes since v1: [1]
 - Alexei and Yonghong suggested that bpf_d_path helper could also
   apply to vfs_* and security_file_* kernel functions. Added them.

[1] https://lore.kernel.org/bpf/20210712162424.2034006-1-hengqi.chen@gmail.com/
[2] https://lore.kernel.org/bpf/20210719151753.399227-1-hengqi.chen@gmail.com/
[3] https://github.com/iovisor/bcc/issues/3527

Hengqi Chen (2):
  tools/resolve_btfids: emit warnings and patch zero id for missing
    symbols
  bpf: expose bpf_d_path helper to vfs_* and security_* functions

 kernel/trace/bpf_trace.c        | 52 +++++++++++++++++++++++++++++++--
 tools/bpf/resolve_btfids/main.c | 13 +++++----
 2 files changed, 57 insertions(+), 8 deletions(-)

--
2.25.1

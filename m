Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D948D1CDB5E
	for <lists+bpf@lfdr.de>; Mon, 11 May 2020 15:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbgEKNiX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 May 2020 09:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729811AbgEKNiX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 11 May 2020 09:38:23 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95477C061A0C
        for <bpf@vger.kernel.org>; Mon, 11 May 2020 06:38:21 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k1so11019066wrx.4
        for <bpf@vger.kernel.org>; Mon, 11 May 2020 06:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=64dH7k/24xZ4jVI8LxHVBAZVy8cSzWn/fWZN7HAScFI=;
        b=qwSHPcGEIk8e2h6G5tY0AjoguHsRhGqE5DKTV+yN34nuLwCZM5D9s4d1gzthMzZjWB
         MBFS/JCnC547PqGQ42rFz434RtY0S87qSeupCsvkAboN5MiXRnH9IvZogwGry6rYSXmV
         uJZz1V+NlWjWeZDZCjAH24mnGSkVA8IjoDYGHHLYR+UGxIj6ow6iKXz4vCVgPQXBujo0
         Ue+Nkx16ACAiw1Lv/EasuecIbEoeg3q+e4iZTxRZC4bWthXEduIfn5EKKP4zmbNDtQw9
         EMc28WpeyRY+J6Nf/r5R4u7i9LJaF7qkpLodZNjEpTa6c6AH6qrEegb1TygcZ5ndoYoh
         7SIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=64dH7k/24xZ4jVI8LxHVBAZVy8cSzWn/fWZN7HAScFI=;
        b=ryGGCRXoHbKWodCmsDX9npchbnD6ZEwmQzVui6ogmCmkFHUgZBSzCylspHtLC+dmZf
         A/2JgYnZXWQ5RXiRHRONekPaf5SyrLiCTC6vsDq6nRWkg69EwhvLuz1bBLHWchYfbjay
         T+LbyL5rGvB0hhmQR4RQYTGUvShEe4wITfflh1acqM1Z7BZHRF421jOf8qhhSIxmDabn
         M4Q/dxzfOs0M0Fi5der6y3QyFmT8IRsJSPggL4OjYlFMKH7BqQTryvt736wipfbgGsiT
         Q+K3nLMaqK0sbjXhoWvbWXgIa7FNBz6Q5wZsoWHIkkQjW95ba7gc738r16mvYyEdP3sC
         j7sw==
X-Gm-Message-State: AGi0PubPxlVjK+NT+vr4m69IjRhNzt1iKqNoJMMrYpjclx59VDZF6+4U
        n69wTmiZeTMNoAE7wi2w5brrEQ==
X-Google-Smtp-Source: APiQypLKEerazrN93vyAeRHEvymUyXskCNGYpHoRX+sk6FF55hBcA5eMD7HZILe/y/Q6wgN5VBhG6w==
X-Received: by 2002:a5d:4d46:: with SMTP id a6mr19930724wru.188.1589204300342;
        Mon, 11 May 2020 06:38:20 -0700 (PDT)
Received: from localhost.localdomain ([194.53.185.84])
        by smtp.gmail.com with ESMTPSA id p4sm6932371wrq.31.2020.05.11.06.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 06:38:19 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 0/4] bpf: clean up bpftool, bpftool doc, bpf-helpers doc
Date:   Mon, 11 May 2020 14:38:03 +0100
Message-Id: <20200511133807.26495-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This set focuses on cleaning-up the documentation for bpftool and BPF
helpers.

The first patch is actually a clean-up for bpftool itself: it replaces
kernel integer types by the ones that should be used in user space, and
poisons kernel types to avoid reintroducing them by mistake in the future.

Then come the documentation fixes: bpftool, and BPF helpers, with the usual
sync up for the BPF header under tools/. Please refer to individual commit
logs for details.

Quentin Monnet (4):
  tools: bpftool: poison and replace kernel integer typedefs
  tools: bpftool: minor fixes for documentation
  bpf: minor fixes to BPF helpers documentation
  tools: bpf: synchronise BPF UAPI header with tools

 include/uapi/linux/bpf.h                      | 109 ++++++++++--------
 scripts/bpf_helpers_doc.py                    |   6 +
 .../bpf/bpftool/Documentation/bpftool-btf.rst |  11 +-
 .../bpftool/Documentation/bpftool-cgroup.rst  |  12 +-
 .../bpftool/Documentation/bpftool-feature.rst |  12 +-
 .../bpf/bpftool/Documentation/bpftool-gen.rst |  21 ++--
 .../bpftool/Documentation/bpftool-iter.rst    |  12 +-
 .../bpftool/Documentation/bpftool-link.rst    |   9 +-
 .../bpf/bpftool/Documentation/bpftool-map.rst |  35 ++++--
 .../bpf/bpftool/Documentation/bpftool-net.rst |  12 +-
 .../bpftool/Documentation/bpftool-perf.rst    |  12 +-
 .../bpftool/Documentation/bpftool-prog.rst    |  23 ++--
 .../Documentation/bpftool-struct_ops.rst      |  11 +-
 tools/bpf/bpftool/Documentation/bpftool.rst   |  11 +-
 tools/bpf/bpftool/btf_dumper.c                |   4 +-
 tools/bpf/bpftool/cfg.c                       |   4 +-
 tools/bpf/bpftool/main.h                      |   3 +
 tools/bpf/bpftool/map.c                       |   3 +-
 tools/bpf/bpftool/map_perf_ring.c             |   2 +-
 tools/bpf/bpftool/prog.c                      |   2 +-
 tools/include/uapi/linux/bpf.h                | 109 ++++++++++--------
 21 files changed, 248 insertions(+), 175 deletions(-)

-- 
2.20.1


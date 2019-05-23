Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67C9B27B1C
	for <lists+bpf@lfdr.de>; Thu, 23 May 2019 12:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbfEWKyi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 May 2019 06:54:38 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53244 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729361AbfEWKyi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 May 2019 06:54:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id y3so5338102wmm.2
        for <bpf@vger.kernel.org>; Thu, 23 May 2019 03:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=jWt3hCSKOekJDy2apI7w+4w9KiWdv4oJSw1MUBdXSeA=;
        b=L5ZV8Q/xja2Oi+RYlFhiWPdqSnBPMmKFS116YfOkoCAs2HXijfMPhU4nUvgL2ndeDa
         /32vuiKqYMu7mL8bdYIM8xGbfjiHhvFn3QB8ihf60pWb8N+IAQUXFL3KEePcs1tOljrJ
         qQAubW6o0odIInKCZ6yaFBV9WDrGBU5NF3VOqnTdhAO4YTg5VfD/e3GkF5gxxSx/PP5M
         qsIXFGE26/A0qPOOHQ6TXIhHZ534dDmKaxjBxUpxQTCK/ueoUrJaRDLOxP6Jem5IsCf7
         fUztCjFjogVOCx+yb8F7KzhUJ8g9DCDJxfczQ2FxD+Yfb4ExMqyovRvAXPcCE8Rr3a0k
         MdeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jWt3hCSKOekJDy2apI7w+4w9KiWdv4oJSw1MUBdXSeA=;
        b=Co/PIK/9bgGud9U4ta770fWu+mdEeVcSirZfPNzi3wVREBgmROm8JzvE+nTVEifWlj
         T+sHlinOSHbbabwjWvYBGVVT4fvE+PLJwFoA7a/bQujoxEQdMTqMpj/+RBe1bZA8Gpma
         eLOZ9LoHJLKqlw/QxUsyJeq5L5/j3PYwhQ3lUl1xIJSy0F0Fva027PKdb5zyh04eQIYa
         RyyXrk0X/HpyPTrMAkXGCZhFpLy0XgC46eW4V2ucF8UHyZiQ/kyVel7dex9ySRe80DWN
         R07P8zYmDFBDGrvXYJ6b5PZv/Puz0OR/fyWdwDnN1yB+Dq7MNPY3r7ARUh0ukskzwrhN
         FiPQ==
X-Gm-Message-State: APjAAAXVy570z5IXevhOAlHF1UYz8vm9vBGbH8sXno1rW+q2IDLZ0ZbG
        4iVX8paHjnOOp+X21f94IzbAtQ==
X-Google-Smtp-Source: APXvYqxrn2TAh2M6OFwBWYQCzCftF1+jzFM2PfgugeC0sFgL6vUSOUI823lttwuKgxLLT2tsEmImyA==
X-Received: by 2002:a1c:4107:: with SMTP id o7mr11530574wma.122.1558608876366;
        Thu, 23 May 2019 03:54:36 -0700 (PDT)
Received: from cbtest32.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id p8sm21285740wro.0.2019.05.23.03.54.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 03:54:35 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf-next v2 0/3] tools: bpftool: add an option for debug output from libbpf and verifier
Date:   Thu, 23 May 2019 11:54:23 +0100
Message-Id: <20190523105426.3938-1-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.17.1
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,
This series adds an option to bpftool to make it print additional
information via libbpf and the kernel verifier when attempting to load
programs.

A new API function is added to libbpf in order to pass the log_level from
bpftool with the bpf_object__* part of the API.

Options for a finer control over the log levels to use for libbpf and the
verifier could be added in the future, if desired.

v2:
- Do not add distinct options for libbpf and verifier logs, just keep the
  one that sets all log levels to their maximum. Rename the option.
- Do not offer a way to pick desired log levels. The choice is "use the
  option to print all logs" or "stick with the defaults".
- Do not export BPF_LOG_* flags to user header.
- Update all man pages (most bpftool operations use libbpf and may print
  libbpf logs). Verifier logs are only used when attempting to load
  programs for now, so bpftool-prog.rst and bpftool.rst remain the only
  pages updated in that regard.

Previous discussion available at:
https://lore.kernel.org/bpf/20190429095227.9745-1-quentin.monnet@netronome.com/

Quentin Monnet (3):
  tools: bpftool: add -d option to get debug output from libbpf
  libbpf: add bpf_object__load_xattr() API function to pass log_level
  tools: bpftool: make -d option print debug output from verifier

 .../bpf/bpftool/Documentation/bpftool-btf.rst |  4 +++
 .../bpftool/Documentation/bpftool-cgroup.rst  |  4 +++
 .../bpftool/Documentation/bpftool-feature.rst |  4 +++
 .../bpf/bpftool/Documentation/bpftool-map.rst |  4 +++
 .../bpf/bpftool/Documentation/bpftool-net.rst |  4 +++
 .../bpftool/Documentation/bpftool-perf.rst    |  4 +++
 .../bpftool/Documentation/bpftool-prog.rst    |  5 ++++
 tools/bpf/bpftool/Documentation/bpftool.rst   |  4 +++
 tools/bpf/bpftool/bash-completion/bpftool     |  2 +-
 tools/bpf/bpftool/main.c                      | 16 ++++++++++-
 tools/bpf/bpftool/main.h                      |  1 +
 tools/bpf/bpftool/prog.c                      | 27 ++++++++++++-------
 tools/lib/bpf/Makefile                        |  2 +-
 tools/lib/bpf/libbpf.c                        | 20 +++++++++++---
 tools/lib/bpf/libbpf.h                        |  6 +++++
 tools/lib/bpf/libbpf.map                      |  5 ++++
 16 files changed, 96 insertions(+), 16 deletions(-)

-- 
2.17.1


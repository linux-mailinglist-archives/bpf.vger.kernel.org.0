Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86DF9295F0
	for <lists+bpf@lfdr.de>; Fri, 24 May 2019 12:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390653AbfEXKg4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 May 2019 06:36:56 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36939 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390410AbfEXKg4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 May 2019 06:36:56 -0400
Received: by mail-wm1-f67.google.com with SMTP id 7so8693768wmo.2
        for <bpf@vger.kernel.org>; Fri, 24 May 2019 03:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=eebsp9j4SRQ4OVvADVlci3LjCudNm6BEg6h6cyk5mow=;
        b=cX++ajwOVa9W6VsSKah+70jKqEuqUEosWH+2NnHeCIOlnHh2c9H/T/n/tTScTbtQU2
         cxW8bT5Na3qKRzdzffwHEW2OearuqM6MGtmMi/LjzoO24yOaTpPq+glwz1lmYuwayN79
         R8JMBXcjw6p1mZw/8U73uR+1tl2jzmm0L1oLihFTNyzJAbxslFUEP9Q6viVpOcuJvxfO
         bbtEabBkLhxN+oa4uNIyyCLb7VoBKtyXG9sYfBLRGwmGvB6JaKxZyCRwfAT0cSize02+
         FTV6FlOZYc3isFCk+U8YFhMAOH2CHxNJonmO8AHzEtk/yg6vc0trqQQJz9W+FJlYrhUC
         XKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eebsp9j4SRQ4OVvADVlci3LjCudNm6BEg6h6cyk5mow=;
        b=Ca/FM1HUIAC4Wv9hNPONes1GPAyXlVzRTYzA33vD+GDXVrvTANAzmBOfVC0zFEmw2M
         IPMUcvui2qk7A54eGQutBNcu33tbPsoZJGLxFB6LKbwHOsyvBThr2LgNsVN8GgN3mOj/
         y1ZQ3VAOXPQoE1Jv83BF7NevHxGII8K3mNQfPgj8bWEhLJ3jXVMxeEQZczlRXns0BZfM
         YFDomEVGDfqnM0acE+ZD6fM5x3JMTC04GwN3KsZJTxF2hEIiLzuNuU/5DN7jGJIjefMU
         xZRh27hve/T6mlQA1Xd26BiDyPSUufpLNWSc061Amrf+DxqETuqlOAQp8nmBqUOBRPhM
         zuIQ==
X-Gm-Message-State: APjAAAXHhz1VyBvX67Q65kFIGbmmhXOW+FqaHk2yWV1tgvmkcEw42B9g
        Snose0esp47Aj0Cb9i/OD/8j2A==
X-Google-Smtp-Source: APXvYqzy8xhigW1F/bvL+NSJzuBZohWTfvAU/hJXO4uctj5OYH8oIp2/LdyMMXXBJ3DhvuAe9FfP4A==
X-Received: by 2002:a7b:c442:: with SMTP id l2mr1620973wmi.50.1558694214541;
        Fri, 24 May 2019 03:36:54 -0700 (PDT)
Received: from cbtest32.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id g2sm1955759wru.37.2019.05.24.03.36.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 03:36:53 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH bpf-next v3 0/3] tools: bpftool: add an option for debug output from libbpf and verifier
Date:   Fri, 24 May 2019 11:36:45 +0100
Message-Id: <20190524103648.15669-1-quentin.monnet@netronome.com>
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

v3:
- Fix and clarify commit logs.

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
https://lore.kernel.org/bpf/20190523105426.3938-1-quentin.monnet@netronome.com/
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


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2469263259
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 18:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730957AbgIIQlH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 12:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729298AbgIIQZF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 12:25:05 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A297AC061757
        for <bpf@vger.kernel.org>; Wed,  9 Sep 2020 09:25:04 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id s13so2882621wmh.4
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2020 09:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ix+MU4cvPNIz6u3CoOIKbzdQmGESphnJbN4BB/aC/4A=;
        b=RZ7sHxLaPVvHNd6Q1+E6yU36+g9EQTVaHi6wklS/XWqU1LvFanhemCuTJchygTZU79
         c55Iquw6UEABWle2OmkTbyJa0NSHhzQtq1JgrUKF7zgjtoS6YTd4AWtfS9LbnczYz8Dg
         9bOOkXbwI9mJXJLvVT1DDrk5rYGDlq8XLXdD1TMncKSiFhfoqG1gbriIThnar2SzHg//
         idlDeYG0+FVlK7HMFES2sauBwOMVG2at13mbE6TuJW1cziTd1+rUHeC7jm3PrKqwCf9d
         SY4VbKELLIjr2Et5ubZaOSZUsm4cGYjD91Qu4/7azV9edGNR3VMb/l5Il72Iy4+cEvwS
         ZRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ix+MU4cvPNIz6u3CoOIKbzdQmGESphnJbN4BB/aC/4A=;
        b=XCJzkB0ckrCkkvIJPlGwFWh82JtiBnX8tEfvXjad/uvElXK0XTPSQw7VNQDIrGZB/s
         WNkrKL7J68P55G6k+cspb3KClkFsRc7xu4vjyJvuod6RTLv0gkvtqMuoYVX4XICARItZ
         3oxlozHanaYZdjT/VGfu1XzsLfBffiU8lVlGpisR7KLSGKZGjPLoqRkgekCt00+vQCfu
         CBCbk0CCBD6UdgXlEnSy+lr4gPwsvlH8U7jTu2s0G7xas/Adtx597YHL801vUw4nfbok
         sPoAyIv00xOAjyv+AgOCBX9sRM3nohv8cYgRafkqMQzzgXlAcs9uiouFwaGWCylYyFXD
         TZdw==
X-Gm-Message-State: AOAM530173hGEbWjNTO0rfEIzm2FkGksTFce1kbgnM/XUklQP+8qgtbc
        jZVt55rrVRminbux6a+DVOXJnA==
X-Google-Smtp-Source: ABdhPJyCooJk5TgGFn7FWe5TWJ2t6lwVp7AyqY2PZXycg17LJK4sDfWGN9KbSq3zi+OjdWFgnRRSgQ==
X-Received: by 2002:a05:600c:28d:: with SMTP id 13mr4243445wmk.69.1599668702953;
        Wed, 09 Sep 2020 09:25:02 -0700 (PDT)
Received: from localhost.localdomain ([194.35.119.56])
        by smtp.gmail.com with ESMTPSA id d3sm4821445wrr.84.2020.09.09.09.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 09:25:02 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v3 0/3] tools: bpftool: print built-in features, automate some of the documentation
Date:   Wed,  9 Sep 2020 17:24:57 +0100
Message-Id: <20200909162500.17010-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There are two changes for bpftool in this series.

The first one is a modification to the "version" command, to have it print
the status (compiled or not) of some of the optional features for bpftool.
This is to help determine if a bpftool binary is able to, for example,
disassemble JIT-compiled programs.

The last two patches try to automate the generation of some repetitive
sections in the man pages for bpftool, namely the description of the
options shared by all commands, and the "see also" section. The objective
is to make it easier to maintain the pages and to reduce the risk of
omissions when adding the documentation for new commands.

v3:
- Use a simple list of features (no boolean values) for plain output when
  dumping built-in features.

v2:
- Fix incorrect JSON output.
- Use "echo -n" instead of "printf" in Makefile to avoid the risk of
  passing and evaluating formatting strings.

Quentin Monnet (3):
  tools: bpftool: print optional built-in features along with version
  tools: bpftool: include common options from separate file
  tools: bpftool: automate generation for "SEE ALSO" sections in man
    pages

 tools/bpf/bpftool/Documentation/Makefile      | 14 ++++++--
 .../bpf/bpftool/Documentation/bpftool-btf.rst | 34 +-----------------
 .../bpftool/Documentation/bpftool-cgroup.rst  | 33 +----------------
 .../bpftool/Documentation/bpftool-feature.rst | 33 +----------------
 .../bpf/bpftool/Documentation/bpftool-gen.rst | 33 +----------------
 .../bpftool/Documentation/bpftool-iter.rst    | 27 +-------------
 .../bpftool/Documentation/bpftool-link.rst    | 34 +-----------------
 .../bpf/bpftool/Documentation/bpftool-map.rst | 33 +----------------
 .../bpf/bpftool/Documentation/bpftool-net.rst | 34 +-----------------
 .../bpftool/Documentation/bpftool-perf.rst    | 34 +-----------------
 .../bpftool/Documentation/bpftool-prog.rst    | 34 +-----------------
 .../Documentation/bpftool-struct_ops.rst      | 35 +------------------
 tools/bpf/bpftool/Documentation/bpftool.rst   | 34 +-----------------
 .../bpftool/Documentation/common_options.rst  | 22 ++++++++++++
 tools/bpf/bpftool/main.c                      | 33 +++++++++++++++--
 15 files changed, 77 insertions(+), 390 deletions(-)
 create mode 100644 tools/bpf/bpftool/Documentation/common_options.rst

-- 
2.25.1


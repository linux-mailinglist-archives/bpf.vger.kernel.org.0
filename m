Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B20B6D7D94
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 15:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238240AbjDENVk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 09:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237944AbjDENVj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 09:21:39 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252DB5FDC
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 06:21:25 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n19so20885375wms.0
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 06:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680700883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MOoqnom5c2K3VEepuhdI5k4ccnMaplRWo7CQ6qhXGqg=;
        b=f6ODsvEa547xPyd6OFDdAcc/Z3rkwv6Azy4/QC4xdFaahdNQrDe6/9G57JqqEL6Dcg
         cas+Awi2pLztrk6f98d12ryQMywFFqsjlzXRgILX0QPyHiCUlBQXfXE3Vam6LSDlIDAY
         QuvO6F7o9ajcaugUI2IjvN+j6HSZIXSHs8jpYgTxHDpldQWciX+HhS6Qu9xTjrJUeSPE
         fCWfyy8QAeqzsbZpyQB7hBq1u4eRmjcLnhWH+TDgZ1WsayzHBHSBzkb762No+a+ONmZV
         4I6/PM7dZPEOhHxTlPPtiCxNlNYxTnYDwQriCCq6Bv+j5QUXofphQLrwwebqNNOfQSrq
         w4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680700883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MOoqnom5c2K3VEepuhdI5k4ccnMaplRWo7CQ6qhXGqg=;
        b=lwWjOf4eu5BHhLPEzApGUWp5VwLVnmLWCzhuEMujKM4vvqejY0iidynBP7TU5dPZ6y
         lBJcnR7ey9S5KX682fNpWx0QwdYl10GtFV7ipIy9Um7fZud8udNebcyQ9y1Fn8QgcDSv
         lAlF+YtfBgxCfznqQgSrnRdk8brWBJjOomi9tSnbxJ3eJyPs1O2MRdNjz1JN4/y/DKYf
         PJ3oIu7vltZcMRRonl/WvyYkyzXETIqRUDVrGPyhPBabCU0UIo8Nls7vdUYy2UBoawEq
         Ct9ZnyT1LphTfbhv1jxlFSOZbJffHjA70YEtTbnVVOVuNmntHU+lgi0IKL5b6oZa82m1
         /THA==
X-Gm-Message-State: AAQBX9cfHyfzVwU32yFadZ5NkqvRNFRG/hX6ecNhnbSPjr6fNDmRoucM
        0wcSLC/ewPYoSZ/FhjYqB9Kj5Q==
X-Google-Smtp-Source: AKy350ZGPT39Gup6G6jUdI3ViH69UJeonFS6asumZV8yc1NLo0onRWAVaa/E8WzN5pjvv7qV8Zb3Kg==
X-Received: by 2002:a05:600c:288:b0:3ea:d620:570a with SMTP id 8-20020a05600c028800b003ead620570amr4708656wmk.38.1680700883569;
        Wed, 05 Apr 2023 06:21:23 -0700 (PDT)
Received: from harfang.fritz.box ([2a02:8011:e80c:0:8147:b5f5:f4cc:b39b])
        by smtp.gmail.com with ESMTPSA id c22-20020a05600c0ad600b003ed243222adsm2147306wmr.42.2023.04.05.06.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 06:21:23 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, Eduard Zingerman <eddyz87@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v3 0/7] bpftool: Add inline annotations when dumping program CFGs
Date:   Wed,  5 Apr 2023 14:21:13 +0100
Message-Id: <20230405132120.59886-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This set contains some improvements for bpftool's "visual" program dump
option, which produces the control flow graph in a DOT format. The main
objective is to add support for inline annotations on such graphs, so that
we can have the C source code for the program showing up alongside the
instructions, when available. The last commits also make it possible to
display the line numbers or the bare opcodes in the graph, as supported by
regular program dumps.

v3:
- Fixed formatting of DOT graph: escape spaces, and remove indent that
  would cause some unwanted spaces to show up in the resulting graph.
- Don't print line information if the record is empty.
- Add '<' and ' ' to the list of escaped characters for generting the
  DOT graph.
- Truncate long file paths, use shorter field names ("line", "col") for
  code location information in the graph, add missing separator space.
- Add a commit to return an error if JSON output and CFG are both
  required.
- Add a drive-by, clean up commit for bash completion (avoid unnecessary
  calls to _bpftool_once_attr()).

v2: Replace fputc(..., stdout) with putchar(...) in dotlabel_puts().

Quentin Monnet (7):
  bpftool: Fix documentation about line info display for prog dumps
  bpftool: Fix bug for long instructions in program CFG dumps
  bpftool: Support inline annotations when dumping the CFG of a program
  bpftool: Return an error on prog dumps if both CFG and JSON are
    required
  bpftool: Support "opcodes", "linum", "visual" simultaneously
  bpftool: Support printing opcodes and source file references in CFG
  bpftool: Clean up _bpftool_once_attr() calls in bash completion

 .../bpftool/Documentation/bpftool-prog.rst    | 18 ++--
 tools/bpf/bpftool/bash-completion/bpftool     | 42 +++++-----
 tools/bpf/bpftool/btf_dumper.c                | 83 +++++++++++++++++++
 tools/bpf/bpftool/cfg.c                       | 29 ++++---
 tools/bpf/bpftool/cfg.h                       |  5 +-
 tools/bpf/bpftool/main.h                      |  2 +
 tools/bpf/bpftool/prog.c                      | 78 ++++++++---------
 tools/bpf/bpftool/xlated_dumper.c             | 54 +++++++++++-
 tools/bpf/bpftool/xlated_dumper.h             |  3 +-
 9 files changed, 226 insertions(+), 88 deletions(-)

-- 
2.34.1


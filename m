Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D5125E31D
	for <lists+bpf@lfdr.de>; Fri,  4 Sep 2020 22:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgIDU5O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Sep 2020 16:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbgIDU5M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Sep 2020 16:57:12 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60091C061244
        for <bpf@vger.kernel.org>; Fri,  4 Sep 2020 13:57:12 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id w5so8537079wrp.8
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2020 13:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s2VbCfmfs/2EKPhU6uZ6dyMExo1mi3OXRSsv4NCSYQE=;
        b=j9ngwIedSaoYiq0eW5bXcwSkf0Vu3hKWRNw+lJX8H9alkpcwzkJd7WoXOOYvpxMmF8
         57gmGz/YyVFhi+cB1dPhcBG4Pl73OlaJnGfR7h9aSNQ2Zi8SGGB4Srv+orgR/YSIhbuJ
         YKi7InR/JeLZgXlu17YaSmdizrVjGGiimGn6MM9zF2fefMSlhSukaLlP4duFYp+HUYVD
         g6xn5YthgzIxgsAIy4g7LIo43spm4eaU3w5lGqEAx1jkOcyGx06/k3mjzCOt5oFDwkoG
         m6j/MWFnVTSgQoEptzgea4ZsZaGpN80wiACDxeYmW5iRp2S3EWKTR9JSLgt1djVKdib7
         fjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s2VbCfmfs/2EKPhU6uZ6dyMExo1mi3OXRSsv4NCSYQE=;
        b=KWzOalJAwyzGSUJbfG9HybsTsLeB8p/C9GFs0CQC/W8jSvd8kvwJMXcIQXI4H6a9IC
         z9YKjWso8CsP+7XcrUoAVcQ7bunbyzlxz6JqfM4KBCY8FVdJjQg+LIaVEI/K3Pc2RfDk
         BsytOv2AllvpENe7mDZ9bYmTl2voq4f00Kfhhc79m2mqhcTSefpo/J6wEwijiC8eoFtb
         Ah4gdDkkcbtu1gd4Bp1UPs77ziQ+3yQhcDApsuyEhQnlu7LjP45dGab9YGbqur8vNC6z
         AzZddOxeZKMrBZciGNtD50rwy1z9H4IPgjrjlhaVeojs/jt1fYwkuAR7IuqxOOoUc1Q0
         vQzg==
X-Gm-Message-State: AOAM5329sTCIAP2GYlx+FzLwmYKZO8vaFbSouiwcDoL2+prKyY/y8+KT
        RtpV+lci1kpW+V0xaQPx83w9aw==
X-Google-Smtp-Source: ABdhPJzffKSbbyulDjS5IdK2q00UuTG/fAXD41vOAAQ1/E+3KStJE7tT6bAIAk0gOxfNewbg9J14ew==
X-Received: by 2002:a5d:560d:: with SMTP id l13mr9054061wrv.49.1599253030911;
        Fri, 04 Sep 2020 13:57:10 -0700 (PDT)
Received: from localhost.localdomain ([194.35.117.177])
        by smtp.gmail.com with ESMTPSA id u17sm12985395wmm.4.2020.09.04.13.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 13:57:10 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 0/3] tools: bpftool: print built-in features, automate some of the documentation
Date:   Fri,  4 Sep 2020 21:56:54 +0100
Message-Id: <20200904205657.27922-1-quentin@isovalent.com>
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
 tools/bpf/bpftool/main.c                      | 22 ++++++++++++
 15 files changed, 68 insertions(+), 388 deletions(-)
 create mode 100644 tools/bpf/bpftool/Documentation/common_options.rst

-- 
2.25.1


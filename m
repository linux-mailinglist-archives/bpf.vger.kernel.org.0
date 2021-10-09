Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA161427B0E
	for <lists+bpf@lfdr.de>; Sat,  9 Oct 2021 17:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbhJIPCu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 Oct 2021 11:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbhJIPCu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Oct 2021 11:02:50 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F747C061570
        for <bpf@vger.kernel.org>; Sat,  9 Oct 2021 08:00:53 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id q19so10207441pfl.4
        for <bpf@vger.kernel.org>; Sat, 09 Oct 2021 08:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tBp+HApqYOGPfGxzUPMdlf4FHEHb2QIShMhxU9sy+ws=;
        b=HP2fEFnOYHtITzNboSJs7uzzyT53Ocr3ez1HlSEp70WWsfaYold9nxoy/JiZScIUut
         6omC2uc5T53jt4j3cLK1n3KccZsryTPwpkz6EuFgrOp4QekDGj9O5VsYNLgzITKKvGZ6
         n3s+IYFk3ZEC7ZxxaI/tgPsq8x1mj4fVGWwqQomhuyNCeeTXAYBXFlltZG+TsQHQkaUU
         OUCqZLpPh33764FKWGYIRH0swVUfNM1kC4dXv2udIwdOd9KgbE2lWbHA6zSYqZhEQZLk
         5yYxze81grc/+Ec4/PXObc6umZvkPGP9QEYprGuhIIMdodCYUqawKqbqV4UlkL0IP5mc
         0muQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tBp+HApqYOGPfGxzUPMdlf4FHEHb2QIShMhxU9sy+ws=;
        b=v5kR0DMFJ8Eo40SlXv2FOMToMAkcZBS03tJuwcYMhvD8Q5p1QLuox4MF69ExpuP6Cr
         vjweBpgI/ULIa9kTtrn5Be2ISce7gEfqTiBmaMuTGJCtvjO7BAWXpP2BCTKywnfplkeX
         cIfKG7HFtzBRTKMn8QA1otGqIbUPZClbggqOOottYNZdsbI3ciSEA8Xq8CwwnCaobExv
         +KVj4+4JZ9v/B2cWpjRJ+AawwYS/kEweZ306oZSLnQGeRLjLmIy5T2Zg1FNpsDbzGEB6
         biPclSwDVZCqG7nqWwRQeV8xS2TPJGF+u+GotVTo0irCe03Pv9G7gTfjB+GdcCbwtkFp
         D5Qg==
X-Gm-Message-State: AOAM530URUUaM0IAgo2Lxrk4i9ZVUfMAo3plB5BsdO6TT8Pm+trO41Ci
        uzt67UF45at6JJ8c3xG8+OO45xliyIb3zbgm
X-Google-Smtp-Source: ABdhPJx+rxcHaimRTXAktmorIjvZdYVgfUElAutKZiWtjK0zmIZjvJ7/Dd1Li5J+zG6cOUQ7kbW5WQ==
X-Received: by 2002:aa7:9e49:0:b0:44b:2a06:715e with SMTP id z9-20020aa79e49000000b0044b2a06715emr16197754pfq.78.1633791652329;
        Sat, 09 Oct 2021 08:00:52 -0700 (PDT)
Received: from VM-32-4-ubuntu.. ([43.132.164.184])
        by smtp.gmail.com with ESMTPSA id w8sm2659331pfd.4.2021.10.09.08.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 08:00:52 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kafai@fb.com,
        songliubraving@fb.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next 0/2] libbpf: Add btf__type_cnt() and btf__raw_data() APIs
Date:   Sat,  9 Oct 2021 23:00:27 +0800
Message-Id: <20211009150029.1746383-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add btf__type_cnt() and btf__raw_data() APIs and deprecate
btf__get_nr_type() and btf__get_raw_data() since the old APIs
don't follow libbpf naming convention. Also update tools
to use these new APIs. This is part of effort towards libbpf v1.0

Hengqi Chen (2):
  libbpf: Add btf__type_cnt() and btf__raw_data() APIs
  tools: Switch to new btf__type_cnt/btf__raw_data APIs

 tools/bpf/bpftool/btf.c                       | 12 +++----
 tools/bpf/bpftool/gen.c                       |  4 +--
 tools/bpf/resolve_btfids/main.c               |  4 +--
 tools/lib/bpf/btf.c                           | 36 +++++++++++--------
 tools/lib/bpf/btf.h                           |  4 +++
 tools/lib/bpf/btf_dump.c                      |  8 ++---
 tools/lib/bpf/libbpf.c                        | 32 ++++++++---------
 tools/lib/bpf/libbpf.map                      |  2 ++
 tools/lib/bpf/linker.c                        | 28 +++++++--------
 tools/perf/util/bpf-event.c                   |  2 +-
 tools/testing/selftests/bpf/btf_helpers.c     |  4 +--
 tools/testing/selftests/bpf/prog_tests/btf.c  | 10 +++---
 .../selftests/bpf/prog_tests/btf_dump.c       |  8 ++---
 .../selftests/bpf/prog_tests/btf_endian.c     | 12 +++----
 .../selftests/bpf/prog_tests/btf_split.c      |  2 +-
 .../selftests/bpf/prog_tests/core_autosize.c  |  2 +-
 .../selftests/bpf/prog_tests/core_reloc.c     |  2 +-
 .../selftests/bpf/prog_tests/resolve_btfids.c |  4 +--
 18 files changed, 95 insertions(+), 81 deletions(-)

-- 
2.30.2


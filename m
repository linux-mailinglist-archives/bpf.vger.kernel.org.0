Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26034377A9
	for <lists+bpf@lfdr.de>; Fri, 22 Oct 2021 15:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbhJVNI4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Oct 2021 09:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbhJVNIy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Oct 2021 09:08:54 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFEFC061767
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 06:06:37 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id u6-20020a17090a3fc600b001a00250584aso5665720pjm.4
        for <bpf@vger.kernel.org>; Fri, 22 Oct 2021 06:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JrDslnn2Z3xESZGwzLuhD+8jqJwRbm/R4ArO6MI7u44=;
        b=a+ceSIOTRVU5PlXnMZ7HOSxR1eM6Rs0fmAIeyxVJv9TWisDxjyCYCU+653pthjR9lr
         oRCf98yMlBI42/0OFI+x6gD6QlOkNUsiDu6payU8J3ykJpdHjAfRiiNrVkBMJkfgnSqI
         iyymSyIOTLDFSl6NfIApXaTI661sHLq8icbX6A/C33mw1BZoU9jV6m4TUI4Ww1Ac60XA
         L2Kx1XHruUxYGx6qAIgVUxsnx5axBaXctLyVbVfJIGyY7fG0Cwpp2Mv4mZ9aWpRFQkdu
         +MqJlkjvMAMmwyTpZUo5jjWY5j4ul8pKFdRRfD/pcYYvnRbkgC0kEiPN12TuChtTxhOe
         dstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JrDslnn2Z3xESZGwzLuhD+8jqJwRbm/R4ArO6MI7u44=;
        b=Diyle5obXgEwAvuqPcqXfwfPD9idtGElmChqFnILQHyoGa/9ZzZfvzMtr4HEd3qaQK
         VaggPxmae/q92XFFQsmK0L9zHf18Xr9B2SpSxI389YPqYiEjSl6+GLofMuuvlNOpnDkU
         DMSjw+ZQwgj1pfsHkqIp6y8tKasbR2pY2USVAHs7XpWZ/H8fkPzijnLqyZYQkL3mo7fi
         565arL1H7Vy4C/8ViE+ipQ66DRDCtBtwIJCNUWHQZ3DCoZGDcC4Hx61wYnvxE0S+dPMs
         YBTMtCZeq6TLqkgoYsz9h/zfj5kMPwhUUhN04z7sYS9JQe5CsqC+JrhpDh3X9YiHb1zm
         GMpQ==
X-Gm-Message-State: AOAM530W/4UrVA87aDpLZUQxsfwnrT6x5759Tc+rn7jCcO750nW3fgwg
        BWpuVVuCTFWMV5jFZYn5qtxZtC837dcpIA==
X-Google-Smtp-Source: ABdhPJy6E9Cng289bZ6Q9JHgYPXXp9twBNarAmic2qWeBP+b46ypP380rTJZNR8kiiHGPMXD0jIn7w==
X-Received: by 2002:a17:90a:644d:: with SMTP id y13mr14580471pjm.10.1634907996861;
        Fri, 22 Oct 2021 06:06:36 -0700 (PDT)
Received: from VM-32-4-ubuntu.. ([43.132.164.184])
        by smtp.gmail.com with ESMTPSA id k22sm9632083pfi.149.2021.10.22.06.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 06:06:36 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kafai@fb.com,
        songliubraving@fb.com, hengqi.chen@gmail.com
Subject: [PATCH bpf-next 0/5 v2] libbpf: Add btf__type_cnt() and btf__raw_data() APIs
Date:   Fri, 22 Oct 2021 21:06:18 +0800
Message-Id: <20211022130623.1548429-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add btf__type_cnt() and btf__raw_data() APIs and deprecate
btf__get_nr_type() and btf__get_raw_data() since the old APIs
don't follow libbpf naming convention. Also update tools/selftests
to use these new APIs. This is part of effort towards libbpf v1.0

v1->v2:
 - Update commit message, deprecate the old APIs in libbpf v0.7 (Andrii)
 - Separate changes in tools/ to individual patches (Andrii)

Hengqi Chen (5):
  libbpf: Add btf__type_cnt() and btf__raw_data() APIs
  perf bpf: Switch to new btf__raw_data API
  tools/resolve_btfids: Switch to new btf__type_cnt API
  bpftool: Switch to new btf__type_cnt API
  selftests/bpf: Switch to new btf__type_cnt/btf__raw_data APIs

 tools/bpf/bpftool/btf.c                       | 12 +++----
 tools/bpf/bpftool/gen.c                       |  4 +--
 tools/bpf/resolve_btfids/main.c               |  4 +--
 tools/lib/bpf/btf.c                           | 36 +++++++++++--------
 tools/lib/bpf/btf.h                           |  4 +++
 tools/lib/bpf/btf_dump.c                      |  8 ++---
 tools/lib/bpf/libbpf.c                        | 36 +++++++++----------
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
 18 files changed, 97 insertions(+), 83 deletions(-)

--
2.30.2

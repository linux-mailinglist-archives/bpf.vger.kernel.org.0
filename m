Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA86525FDDC
	for <lists+bpf@lfdr.de>; Mon,  7 Sep 2020 18:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbgIGQAN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Sep 2020 12:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729996AbgIGOsa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Sep 2020 10:48:30 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4F8C061755
        for <bpf@vger.kernel.org>; Mon,  7 Sep 2020 07:48:28 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e16so16090590wrm.2
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2020 07:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yF7Oj8Xzl9YcsssWtQRfNaxtAUmkzCjL1OJNCKC79AU=;
        b=UJTmLlRCQSDDMZLMfoAEiPZTYhqNGmQcX5BBsW6rtubtdVBfkJAF0YvUdPVG0LgSWt
         jePLAWNH9Z+0CLqvolCI4gTJDWq6sRsAkY3Xig8uJEe6e4/JsxL1DYC78DSK7SReIjW5
         1oglEI5flVoiwflCpiNH9WSc0xtUZvITTKW10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yF7Oj8Xzl9YcsssWtQRfNaxtAUmkzCjL1OJNCKC79AU=;
        b=IK7JRRRVckggDhUMuLkwpxvuUDZR4wsA8w/C1K8rxE8CCqKArbKoyrLNAQ2w+t06tm
         2qH3rf/snJ8r3WAnK586douNQ+vINSx7nrzmszx365++WMFCrw6UdnEAlLaKLXfESCuz
         OvOe2cn20Ltw+A+UxlE7oxMZBa1dVNf9j7Q3/u6Ppr2pzH8oop3hFWRM1BGVTYzazHI5
         MAQsl2Ed9tr8pz8L/5iK08OvtR1iL2tW5TEzmxv0uJkA8fACnGfcSgT+TtSW/eXRJCIp
         Zbc1+MpzkXlUnYKmQjyP5nSgoi6V3zA6pplktFVyh9XXcxwPCi8ID4P6mxtNxXOBKZy6
         1fUQ==
X-Gm-Message-State: AOAM530StZhLoUi5eFOrMwo5ceFB/0zG2ExaAZlX5ncKeqR5JyNfiYTn
        fI5hef0dUuU2vNI1DiSXnROMFA==
X-Google-Smtp-Source: ABdhPJyBV3JV2bKh8nPH8CxOCluqf1rV4B8nkZUWprcQzcILCwnhl/J2L8p1Qh2rJwXX/Uakz2xfEA==
X-Received: by 2002:adf:f78c:: with SMTP id q12mr22113404wrp.6.1599490106899;
        Mon, 07 Sep 2020 07:48:26 -0700 (PDT)
Received: from antares.lan (2.e.3.8.e.0.6.b.6.2.5.e.8.e.4.b.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:b4e8:e526:b60e:83e2])
        by smtp.gmail.com with ESMTPSA id 59sm8816834wro.82.2020.09.07.07.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 07:48:26 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net,
        jakub@cloudflare.com, john.fastabend@gmail.com, kafai@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v4 0/7] Sockmap iterator
Date:   Mon,  7 Sep 2020 15:46:54 +0100
Message-Id: <20200907144701.44867-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Martin pointed out that a struct sock pointer may not be a full socket.
It's therefore invalid to accept such a pointer in lieu of PTR_TO_SOCKET.
Instead, we can allow passing it instead of PTR_TO_SOCK_COMMON. The sockmap
helpers are then adjusted to accept PTR_TO_SOCK_COMMON. This requires no
changes to the sockmap code itself since it already checks for fullsocks.

Changes in v4:
- Alias struct sock* to PTR_TO_SOCK_COMMON instead of PTR_TO_SOCKET (Martin)

Changes in v3:
- Use PTR_TO_BTF_ID in iterator context (Yonghong, Martin)
- Use rcu_dereference instead of rcu_dereference_raw (Jakub)
- Fix various test nits (Jakub, Andrii)

Changes in v2:
- Remove unnecessary sk_fullsock checks (Jakub)
- Nits for test output (Jakub)
- Increase number of sockets in tests to 64 (Jakub)
- Handle ENOENT in tests (Jakub)
- Actually test SOCKHASH iteration (myself)
- Fix SOCKHASH iterator initialization (myself)

v1: https://lore.kernel.org/bpf/20200828094834.23290-1-lmb@cloudflare.com/
v2: https://lore.kernel.org/bpf/20200901103210.54607-1-lmb@cloudflare.com/

Lorenz Bauer (7):
  bpf: Allow passing BTF pointers as PTR_TO_SOCK_COMMON
  net: sockmap: Remove unnecessary sk_fullsock checks
  net: Allow iterating sockmap and sockhash
  bpf: sockmap: accept sock_common pointer when updating
  selftests: bpf: Ensure that BTF sockets cannot be released
  selftests: bpf: Add helper to compare socket cookies
  selftests: bpf: Test copying a sockmap via bpf_iter

 kernel/bpf/verifier.c                         |  63 ++--
 net/core/sock_map.c                           | 284 +++++++++++++++++-
 .../bpf/prog_tests/reference_tracking.c       |  20 +-
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 138 ++++++++-
 tools/testing/selftests/bpf/progs/bpf_iter.h  |   9 +
 .../selftests/bpf/progs/bpf_iter_sockmap.c    |  57 ++++
 .../selftests/bpf/progs/bpf_iter_sockmap.h    |   3 +
 .../bpf/progs/test_sk_ref_track_invalid.c     |  20 ++
 8 files changed, 549 insertions(+), 45 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_sockmap.h
 create mode 100644 tools/testing/selftests/bpf/progs/test_sk_ref_track_invalid.c

-- 
2.25.1


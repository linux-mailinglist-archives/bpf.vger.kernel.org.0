Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4D527C138
	for <lists+bpf@lfdr.de>; Tue, 29 Sep 2020 11:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgI2JbM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Sep 2020 05:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbgI2JbH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Sep 2020 05:31:07 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2550FC0613D0
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2020 02:31:07 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z4so4577652wrr.4
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2020 02:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=20Opd1KbzfKVWbWB380MJLXU/LCIpN0t6D10z4zpmZQ=;
        b=HBkYIFLPztSezAegjoJa7iMD9U2nkk04r7vRSAk8kgQchwzCGVULYayP4W1NRnYEEc
         e7kIPUc50JrKrTNr9fVGYSWZpoXpaTEf+dcMXiYm3ZcMBiBdlmWFxq9qVezGNvTzVe0V
         1bQ3KHHT6rWvgClmFFv5i9pwuSP6gFBjjmhXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=20Opd1KbzfKVWbWB380MJLXU/LCIpN0t6D10z4zpmZQ=;
        b=L1O1S8mfCo2vi9J46w6oEw/MXDbxg4BArlHS02zMEkjJo09X7Pq3j2gvTeu04DHdkt
         a8wwLMBLjl3Tz6KZWxd8nb5iZdOudGTmJ62UkMjKT9CnHE6Cw4+mkjmqiwQOTz9j51eM
         6+2nPwroTxDDb1gRViB8Qn6pxt1NiDM+qWWbcn3J1ofbDF0Lnbm98IgJWI0xDQvX5Txl
         CCTOv4kR+lMvNoTV/HkXlRJwcw/orwOx+8D46eku6kP2dh9NF+DF8kXZD1Gv/7jG4YCZ
         nr0Sz9ESgSUfIOcKuLbvtgivrR1k6d5MqRAZt7lWvWi7SKx/BQB67sNMzRGp2u0I9mb4
         i+wA==
X-Gm-Message-State: AOAM530vK/HXzzQwmwix4D5J/GnrNWpMEgQqUkGCYZYKFvk8quTrVRbM
        qKSwGX3eT63o1V84KbwH/vNVMw==
X-Google-Smtp-Source: ABdhPJy6LeWn0GIvYRj+CvOBY6F5jYDGyylJ5di7VMpxdpfAqQg4f/hqfEe/iKlMRH/F8P77Gy9brQ==
X-Received: by 2002:a5d:470f:: with SMTP id y15mr3143091wrq.420.1601371865690;
        Tue, 29 Sep 2020 02:31:05 -0700 (PDT)
Received: from antares.lan (1.f.1.6.a.e.6.5.a.0.3.2.4.7.4.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:474:230a:56ea:61f1])
        by smtp.gmail.com with ESMTPSA id i16sm5246798wrq.73.2020.09.29.02.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 02:31:04 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     kafai@fb.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 0/4] [PATCH bpf-next v2 0/4] Sockmap copying
Date:   Tue, 29 Sep 2020 10:30:35 +0100
Message-Id: <20200929093039.73872-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Changes in v3:
- Initialize duration to 0 in selftests (Martin)

Changes in v2:
- Check sk_fullsock in map_update_elem (Martin)

Enable calling map_update_elem on sockmaps from bpf_iter context. This
in turn allows us to copy a sockmap by iterating its elements.

The change itself is tiny, all thanks to the ground work from Martin,
whose series [1] this patch is based on. I updated the tests to do some
copying, and also included two cleanups.

1: https://lore.kernel.org/bpf/20200925000337.3853598-1-kafai@fb.com/

Lorenz Bauer (4):
  bpf: sockmap: enable map_update_elem from bpf_iter
  selftests: bpf: Add helper to compare socket cookies
  selftests: bpf: remove shared header from sockmap iter test
  selftest: bpf: Test copying a sockmap and sockhash

 kernel/bpf/verifier.c                         |   2 +-
 net/core/sock_map.c                           |   3 +
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 100 +++++++++++-------
 .../selftests/bpf/progs/bpf_iter_sockmap.c    |  32 ++++--
 .../selftests/bpf/progs/bpf_iter_sockmap.h    |   3 -
 5 files changed, 90 insertions(+), 50 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_sockmap.h

-- 
2.25.1


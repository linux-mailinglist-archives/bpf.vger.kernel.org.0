Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0258027AA3F
	for <lists+bpf@lfdr.de>; Mon, 28 Sep 2020 11:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgI1JIk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Sep 2020 05:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgI1JIj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Sep 2020 05:08:39 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90229C0613CE
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2020 02:08:39 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d4so258915wmd.5
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2020 02:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EKVPdZy/sjSkGpbl4mmaWgA3/1wInIBCoopNG3gWUyk=;
        b=aaYblTnwpHARbTMEbMzlRDkO9zJTdrVxObJrgHKZ30e5zZvd3lQvTR4jA7xKSiPsXP
         xsbrQvut1WGgZdQD0E0eT54hhJw+DovP57rQhomTRfZo/saaXekvVKEj2QwWMv9TnghG
         Ffx086TfGM958gRhPOaPxzkhWeBBRuFG27i5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EKVPdZy/sjSkGpbl4mmaWgA3/1wInIBCoopNG3gWUyk=;
        b=RpgAw19gQmiMgvxNG6al3N9u4JNGWLtdCxiosHspWc6n7dX9Z0UEO3+kmA/InvIPRC
         7MXMNF4//wsSja7BLUJl17ZRMJN8xwbvLUqPdUfRMWx4TtuxM2e/Ditoxu1WosaRr/5i
         HhVyC7U1uV2NhbZoBu29vfYZkD9sJ+73pTU6Tr7SFHg2q3++N6BMq28GKKV3Ic0ax9sx
         Pi7JeRO1rg8WfAnQ8rr7CuyKbgRJz+lLyGjOqjgZqrtVV130r9AKOdIjm1akL2QEivVV
         7QkNERR1xwfgXQ6Te2e7WHbBkeTPiRt3u8qX4WqDawrPLioM2T7sivh4rOyfTjLTr+FH
         NFLQ==
X-Gm-Message-State: AOAM5322ib/M57FosU6sP7Ync+LB0ZpecjaA4Vg29hsFd8rUUYsUeZHj
        LcQxQN5Ewe/6F/wA52dUPHgDog==
X-Google-Smtp-Source: ABdhPJy5h6LN59OS60mMZGMU5YEr1O4Ubdjy8bMmkjK3hyk0W591Z7KG/vI4n8oqrT0qmLVi7ahWtw==
X-Received: by 2002:a1c:4885:: with SMTP id v127mr583443wma.129.1601284118067;
        Mon, 28 Sep 2020 02:08:38 -0700 (PDT)
Received: from antares.lan (1.f.1.6.a.e.6.5.a.0.3.2.4.7.4.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:474:230a:56ea:61f1])
        by smtp.gmail.com with ESMTPSA id u13sm479631wrm.77.2020.09.28.02.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 02:08:37 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     kafai@fb.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 0/4] Sockmap copying
Date:   Mon, 28 Sep 2020 10:08:01 +0100
Message-Id: <20200928090805.23343-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Changes in v2:
- Check sk_fullsock in map_update_elem (Martin)

Enable calling map_update_elem on sockmaps from bpf_iter context. This
in turn allows us to copy a sockmap by iterating its elements.

The change itself is tiny, all thanks to the ground work from Martin,
whose series [1] this patch is based on. I updated the tests to do some
copying, and also included two cleanups.

I'm sending this out now rather than when Martin's series has landed
because I hope this can get in before the merge window (potentially)
closes this weekend.

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


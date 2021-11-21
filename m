Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A844583E9
	for <lists+bpf@lfdr.de>; Sun, 21 Nov 2021 14:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238247AbhKUN6C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Nov 2021 08:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234993AbhKUN6C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 21 Nov 2021 08:58:02 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5063DC061574
        for <bpf@vger.kernel.org>; Sun, 21 Nov 2021 05:54:57 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id f65so3272693pgc.0
        for <bpf@vger.kernel.org>; Sun, 21 Nov 2021 05:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J5rJp8f/DY6DNbx+kzhTrwzv0zcNq0BAc0dxmHE7V1E=;
        b=FTtZ62/G9UCRQAKvqG6ZFDZSrZoZIGA3Zq5SC9wFQigpcFLI2y+vlc9ISJ6ktGZmxO
         oiNEmJnTW1PZsLdGQJBYOl6DLY8hVNPgBnhQUzOiLdApJ405LHeI3v+D+lqxUPvWWdYk
         3G5zo0gjvBjlfUw2l3cV+vryRnH96yneZZ5NH69zu7xZ9lyUEs6ItGTzajpJJNwpNSDG
         5TIhqdVv//EJGghLjDSaiGvPF+z7JiDBW1gQ8f8iWY/5c/efktiTv4GKro+IvGCZ+kYU
         EDt8xkxwKFJE2KlOqQnp8VhOahlFRXIwZCdj2dFW2etTXHqsey06ld1ywlrejrecW6rK
         LpzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J5rJp8f/DY6DNbx+kzhTrwzv0zcNq0BAc0dxmHE7V1E=;
        b=evKG/RLGz8V1AAzFnkpKtnMa1hFuDlKQMe+175Hu3eetHT/I6fXPb0mC0YdFqsEEE6
         c2RI9YzXH6pDEdoGIUqSRZr3UNUFFMz8pgwyilyoCO7OQGhUcP6MCVmIhq5Gq/2xq2b2
         QO9oHUuXoj7R4p9CETIoWwHIW8Rne5y0GNJL5Q8zuTKeN9W0RiGfFKJPQSxtQ0Ew/Sik
         3BNED3Ow+GCZzjhRorL9dxDguzKmasGN8vcBT7KeedjU8dFIweWxh2ZnkIVAG3+wfmJt
         mQ4B2hJ6C36wUalwvF0DgrpqrpGzTzEqPzYiGY4r74JKdz83wBHMuNa+ZrjNVDgJwLbE
         5stw==
X-Gm-Message-State: AOAM530QmFHGrVqy8dJaanh63SJ6KOETJxMFmS+81Ud6ssz/LovX/c+c
        nPKYyKEx4iC6+HpL1D5qsYPQxSDnLns=
X-Google-Smtp-Source: ABdhPJyz5Kv7V68Eul1GVGFRIVCWANK8VaKNziKB2GmN1/rMZbvR1my4U2346GYrqFVQIwXxkME0cA==
X-Received: by 2002:a05:6a00:22d2:b0:4a0:93a:e165 with SMTP id f18-20020a056a0022d200b004a0093ae165mr36957251pfj.68.1637502896735;
        Sun, 21 Nov 2021 05:54:56 -0800 (PST)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id u38sm6061073pfg.0.2021.11.21.05.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 05:54:56 -0800 (PST)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        hengqi.chen@gmail.com
Subject: [PATCH bpf-next 0/2] Support static initialization of BPF_MAP_TYPE_PROG_ARRAY
Date:   Sun, 21 Nov 2021 21:54:38 +0800
Message-Id: <20211121135440.3205482-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make libbpf support static initialization of BPF_MAP_TYPE_PROG_ARRAY
with a syntax similar to map-in-map initialization:

    SEC("socket")
    int tailcall_1(void *ctx)
    {
        return 0;
    }

    struct {
        __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
        __uint(max_entries, 2);
        __uint(key_size, sizeof(__u32));
        __array(values, int (void *));
    } prog_array_init SEC(".maps") = {
        .values = {
            [1] = (void *)&tailcall_1,
        },
    };

Hengqi Chen (2):
  libbpf: Support static initialization of BPF_MAP_TYPE_PROG_ARRAY
  selftests/bpf: Test BPF_MAP_TYPE_PROG_ARRAY static initialization

 tools/lib/bpf/libbpf.c                        | 146 +++++++++++++++---
 .../bpf/prog_tests/prog_array_init.c          |  27 ++++
 .../bpf/progs/test_prog_array_init.c          |  30 ++++
 3 files changed, 179 insertions(+), 24 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/prog_array_init.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_prog_array_init.c

--
2.30.2

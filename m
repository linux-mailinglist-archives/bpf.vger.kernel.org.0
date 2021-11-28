Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E314606C4
	for <lists+bpf@lfdr.de>; Sun, 28 Nov 2021 15:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346127AbhK1OWB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Nov 2021 09:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbhK1OUA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 28 Nov 2021 09:20:00 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE28C061746
        for <bpf@vger.kernel.org>; Sun, 28 Nov 2021 06:16:44 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id y7so10029525plp.0
        for <bpf@vger.kernel.org>; Sun, 28 Nov 2021 06:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t0sYdOSJZ32pMItl1VOcqqryYD315WO5Ig8t3yxisus=;
        b=FIyfCVmagtmsQ5c/Zjhv8eO+00hBAcM5xU/77KQcl3wHgtyyTtjk/qibDMfqUHC6WI
         vihCP5dY5G6Wv3qc80kF0j8oEQ9L30y/dNBXYMQnQtzncGmcTedxlmRvZyp/BA1AE/db
         7yQB9RBoSG2HobT29TsCFLogqwtVWRHo+gpGxvV1BMH2PND+9tVwG0DE5Weat0XCylWX
         XqP+ZKVgaQIaH1TRbggEEX3x8hk3CJ4VLR1cbAVWxaFRYUdyg0osviVjc+LKpxk/bPzm
         v4P2XF2f92i+zkRn0vScg/lHcigUL9f0eR+8JX8oR8CT0AeG4bxSCLN+ljbF2YkQGzxV
         Bb5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t0sYdOSJZ32pMItl1VOcqqryYD315WO5Ig8t3yxisus=;
        b=YXlGrUOXVHzwVZUgxiu54dkk3EVe+WKnlVIeZVztuEx0vYYMmCwMVxqr4eGTK9x0pe
         dZ0nMdUXF8UsooosC09Ibio0HzAEkmzhtPqDqFWa0SgJ22pdOyFiccuhkRIMrFT7hSVy
         0SayqP/0wE5d96GO3xNKg0pdGqrss0Cu2025rX8REZd1ZQx2RibbT44v+1nD5m71sPCY
         celPey4oCL1aMHQ4+5/OTOvttGLcpoPo9iZp/v8RMZ6+WgWcjEpCT4VJ9d9Qn0P1Yi8m
         bbrP9VfiiqewYYj3QaUTOhUIC2t8rs0QDGlD3zauhwnP5Vq8yX68OCRJPhYtkYCzmHO9
         nkHQ==
X-Gm-Message-State: AOAM530bwsXKGd83hyxFnzvpKOzh4F+OFAxKnjySk2qulbdw4h/ZUp8G
        SV61HEmqG8Tk7JG8J/skhU8LqBEGF28=
X-Google-Smtp-Source: ABdhPJysA/3e0+No/nIA+r24wx3TnOaOeol7l+F9O541swcEsai+CWMvMP7F2yBTi4tvTbjudvXd4w==
X-Received: by 2002:a17:903:408c:b0:142:45a9:672c with SMTP id z12-20020a170903408c00b0014245a9672cmr52695995plc.7.1638109004285;
        Sun, 28 Nov 2021 06:16:44 -0800 (PST)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id b6sm14513583pfm.170.2021.11.28.06.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 06:16:44 -0800 (PST)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        hengqi.chen@gmail.com
Subject: [PATCH bpf-next v2 0/2] Support static initialization of BPF_MAP_TYPE_PROG_ARRAY
Date:   Sun, 28 Nov 2021 22:16:31 +0800
Message-Id: <20211128141633.502339-1-hengqi.chen@gmail.com>
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

v1->v2:
  - Add stricter checks on relos collect, some renamings (Andrii)
  - Update selftest to check tailcall result (Andrii)

Hengqi Chen (2):
  libbpf: Support static initialization of BPF_MAP_TYPE_PROG_ARRAY
  selftests/bpf: Test BPF_MAP_TYPE_PROG_ARRAY static initialization

 tools/lib/bpf/libbpf.c                        | 139 ++++++++++++++----
 .../bpf/prog_tests/prog_array_init.c          |  32 ++++
 .../bpf/progs/test_prog_array_init.c          |  39 +++++
 3 files changed, 182 insertions(+), 28 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/prog_array_init.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_prog_array_init.c

--
2.30.2

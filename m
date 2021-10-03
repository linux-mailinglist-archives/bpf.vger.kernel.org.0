Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCC14203A5
	for <lists+bpf@lfdr.de>; Sun,  3 Oct 2021 21:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbhJCTYX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 3 Oct 2021 15:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbhJCTYV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Oct 2021 15:24:21 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CCCC061797
        for <bpf@vger.kernel.org>; Sun,  3 Oct 2021 12:22:27 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l18-20020a05600c4f1200b002f8cf606262so17206464wmq.1
        for <bpf@vger.kernel.org>; Sun, 03 Oct 2021 12:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PNpnL8ZQsgPH+z/F1sT0I4BRmDeqtk9e85L/4fLHn7U=;
        b=qHk0pFUmQaua9Z6qCkrmlYzQsSD1RtUmCaQ2wYUEv0R94CAABxOlNnaM/S4Lc2Boll
         R0Nr9qFIQRSrU0veduqtWRy8S/SxNHEzAHMizBbuHysz2YAZZkUtAQQJ/4cCegyYwuyF
         iMuDuwKQm4MyR9YtHYSRAwwZftV6+jFXY9eRd/vOHHlzQc2ZBHQVLiAiEVGO3nnc3Kax
         rBGwy7/t+7n9IkgQ/jfJlIA+woTMnsVGc2cAO6txXdjem9/KO3En+KzMmAn/ojWTYIDa
         WW8z0kCHVIdT21TBsTM2XhebY23GZEitRXLJ8CmYd72rUdwbE4NnkkMCPsrgPFDdSsMP
         vhQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PNpnL8ZQsgPH+z/F1sT0I4BRmDeqtk9e85L/4fLHn7U=;
        b=hWAZ/EG4piLJeu4TjXY2a8+fKBtaXjBNA6gBHct/JpFFC2+FZJhHeKday301OhXxlf
         AUcb0W24gu9FjJPszVxtTeum7A5lZMzLtteyzSeB5wcxjgTZm+/1UZIMQlxg4vpR4ZAb
         LPA0fAZ3R6gItsliE+1qhR0ruNf7Vz0bP4n1GY2JLpJA7AI2Vk70SPyTVb8MjOOiEm+h
         YQnWRrynns7Xb/LExmVI6Cm+FWJXhvGRb/3t6cr6egJnKyedZCIH2vdtE0cFhMFclx73
         +QV5qzsMm9YfKi2YlnrtXj5CedEJOW3tyZedtTsxCPdTAx0C+d1vljL3j1aD4vMx6NfC
         iSQA==
X-Gm-Message-State: AOAM532cj4vZz2DG7TALuilKcSbPrxIr4Dz+S0xhTpyY53mQl+0QSA9L
        xI4ywXGnn6DSlJgElpaDyI7bOA==
X-Google-Smtp-Source: ABdhPJzvY4ZHRSimMrDe1tSIQAGyULfdDHglxmmujPfI+cMx5/fKYCELvzLpHfL4QTRb0agzGoVtJA==
X-Received: by 2002:a05:600c:210d:: with SMTP id u13mr5374985wml.146.1633288946586;
        Sun, 03 Oct 2021 12:22:26 -0700 (PDT)
Received: from localhost.localdomain ([149.86.88.77])
        by smtp.gmail.com with ESMTPSA id d3sm14124642wrb.36.2021.10.03.12.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 12:22:26 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v3 08/10] samples/bpf: update .gitignore
Date:   Sun,  3 Oct 2021 20:22:06 +0100
Message-Id: <20211003192208.6297-9-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211003192208.6297-1-quentin@isovalent.com>
References: <20211003192208.6297-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Update samples/bpf/.gitignore to ignore files generated when building
the samples. Add:

  - vmlinux.h
  - the generated skeleton files (*.skel.h)
  - the samples/bpf/libbpf/ and .../bpftool/ directories, recently
    introduced as an output directory for building libbpf and bpftool.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 samples/bpf/.gitignore | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/samples/bpf/.gitignore b/samples/bpf/.gitignore
index fcba217f0ae2..09a091b8a4f3 100644
--- a/samples/bpf/.gitignore
+++ b/samples/bpf/.gitignore
@@ -57,3 +57,7 @@ testfile.img
 hbm_out.log
 iperf.*
 *.out
+*.skel.h
+vmlinux.h
+bpftool/
+libbpf/
-- 
2.30.2


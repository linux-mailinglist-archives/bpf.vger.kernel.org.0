Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A808425C82
	for <lists+bpf@lfdr.de>; Thu,  7 Oct 2021 21:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241767AbhJGTq6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Oct 2021 15:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241378AbhJGTqt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Oct 2021 15:46:49 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70403C061770
        for <bpf@vger.kernel.org>; Thu,  7 Oct 2021 12:44:54 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id s15so22510881wrv.11
        for <bpf@vger.kernel.org>; Thu, 07 Oct 2021 12:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GrGLJnKzdw7MgtjqmK7w9AbZFbv0l9QWOc/N5D8CVnQ=;
        b=BaVh9DVsyLKPKMD00J9pf5ZPM29gDqNwNGLATSYsTuovy0VV52ie5aq+/y0WEMB1VN
         MuuYneac2e/Ff8pZwjjDHrzNJp7P7jJgb6LFNBPjMwhvgEeRPASjdMt9J6i/wM8dbedP
         USxyv5Uc34S517s9NS05aiwclZFoDC6MjezHhSdJReZZERDFkDI4uocRErX4QweAXwHH
         U2Y9tATEBFysrfxnQaf0ZNiM1rhXLjIha7IHTxBBht7X3/snMnCjjp6uLerwRTXG5fh2
         l88p5xHuPrdW//hyN0UDTp1x8SqZfQRa9KCLtgsmVxCHLR2x/i7Lz1M5Qt7FuemelsQJ
         cqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GrGLJnKzdw7MgtjqmK7w9AbZFbv0l9QWOc/N5D8CVnQ=;
        b=gOAdR6qHzMEACNuyEWhiys1qJ1up5u0a5heJFTRrXv+UEIhKBZ4lesSwB7vzTkPnnQ
         9pF5miTVKCyH1Su7MqMMSl3YuhX76OIZo/hlBpP22ZLiZ45zN4RcHYo6UXvDQfi5txHl
         94v8QBJ9b+t5HIMZnep6qMYSTAPdH0TxPInCui6nivBf3PlewlMe+ASzWoUfBVubOMOd
         hAst7Z6I98LsEO2C3sAyS1I+OJ3IQ2kZOgnnFxOaj5nEEcrwGsTweGClX/TEZXQgoN1e
         DJnEclsYEXd/Qb+Nmvg18ctGgco4JjLLzaFHuDa/yP8Yhi9zXSqqPca4eMhN3tKe1fzy
         epsg==
X-Gm-Message-State: AOAM532QGfy5UPGyYGSzRVSBK3ax6VxK63+xhVoIHWS5Wy6Ins6yQ4OJ
        mI12IJ5+4Yj5IbZd9fJTfdUY9g==
X-Google-Smtp-Source: ABdhPJzZiJME/nEwN6LSH7cisjjo0oxI58ZP49a3745NxcWYaa++amax+GnctgzyDWa//qNwd9AK1A==
X-Received: by 2002:a05:600c:4142:: with SMTP id h2mr18672765wmm.35.1633635893102;
        Thu, 07 Oct 2021 12:44:53 -0700 (PDT)
Received: from localhost.localdomain ([149.86.87.165])
        by smtp.gmail.com with ESMTPSA id u2sm259747wrr.35.2021.10.07.12.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 12:44:52 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v4 08/12] samples/bpf: update .gitignore
Date:   Thu,  7 Oct 2021 20:44:34 +0100
Message-Id: <20211007194438.34443-9-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211007194438.34443-1-quentin@isovalent.com>
References: <20211007194438.34443-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Update samples/bpf/.gitignore to ignore files generated when building
the samples. Add:

  - vmlinux.h
  - the generated skeleton files (*.skel.h)
  - the samples/bpf/libbpf/ and .../bpftool/ directories, in preparation
    of a future commit which introduces a local output directory for
    building libbpf and bpftool.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 samples/bpf/.gitignore | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/samples/bpf/.gitignore b/samples/bpf/.gitignore
index fcba217f0ae2..0e7bfdbff80a 100644
--- a/samples/bpf/.gitignore
+++ b/samples/bpf/.gitignore
@@ -57,3 +57,7 @@ testfile.img
 hbm_out.log
 iperf.*
 *.out
+*.skel.h
+/vmlinux.h
+/bpftool/
+/libbpf/
-- 
2.30.2


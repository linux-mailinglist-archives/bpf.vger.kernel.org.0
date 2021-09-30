Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61BB941D8E0
	for <lists+bpf@lfdr.de>; Thu, 30 Sep 2021 13:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350547AbhI3Lfx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Sep 2021 07:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350531AbhI3Lfw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Sep 2021 07:35:52 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821B4C06176A
        for <bpf@vger.kernel.org>; Thu, 30 Sep 2021 04:34:09 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u18so9519341wrg.5
        for <bpf@vger.kernel.org>; Thu, 30 Sep 2021 04:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LZNCtgJESuuBglLRSxSP+yMWbcKos3toNZIRMOdvxc4=;
        b=AXtmHBiglxP2sf0bb8bFRuOONwWeS0JUyZOEZkgTqNNo7Z0jdwvgNHdftkKjihGTe2
         /Rj/Sq7XVO+4PYPsfNZMMjDZO066LF+hkUPgX/AwHw228HovYxLs+fKv8Q5wU1jED0be
         +FF7uyk24TUguJKtyUU2PxQtCUQDrzwd3Rx0Bi3kJUzDfVuqveKi5E8i0qUL/ghOaNb+
         8aVhdvfgzYjTb0JiGdZm+vtRRrZjlY0CgLtKaFwrT6RBl1u+6i8d5ZRrTr3AKsDEdgrd
         +1msvA3L44KPciyF7nuD27GCjbswH1xNC3VmkkRRLswnlU2cNRf6EkOO447/FQAT4eHH
         I26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LZNCtgJESuuBglLRSxSP+yMWbcKos3toNZIRMOdvxc4=;
        b=xYSdavmrheUilRy6HgQetyuZAjoOnGtRQsaqg5GXneyYLXBolZrNsqNTge8Hq8g4wb
         AE5cAc430+mRZukWnADF8NLzJEqWQC+44cNdiEKaJE1IkKnRQVYGNEPiAf0Zxuy3WLzn
         5pZXKBqCyTgda0wbTJ+3XVB/4TmbYnULYOLVHTeW/MyRI80NyTk2c1Z1LGmtD6hlPMrK
         OqxOjvcRGljuLUGG9So6ItUdUWhwZ1s8qu4pzCSQc0BJbZcZ0BEICLGBQc1GlotkZewu
         R35IdqYrafiL5VPfl4jkoyJZX7OuSuLwfoOJN0VEzBv+aF9my8OWC4BCUps5Ct0AAZCr
         8Jbw==
X-Gm-Message-State: AOAM531lD+a+UwEOoKtAFKItmIcTw7uADAcNNz1TbUpXSx5HWIoFxKFl
        X4gOW8yFYChcuwBE6x9oVRaCEQ==
X-Google-Smtp-Source: ABdhPJx6HpQ6sHYF3ffSwyDP+oQd6oZ9o1JfsYvbPEOzhMCKP0wYlXbvH+Ig7FjxAfDDj9mu4zHYSw==
X-Received: by 2002:a05:6000:2af:: with SMTP id l15mr5527470wry.129.1633001648184;
        Thu, 30 Sep 2021 04:34:08 -0700 (PDT)
Received: from localhost.localdomain ([149.86.91.95])
        by smtp.gmail.com with ESMTPSA id v10sm2904660wrm.71.2021.09.30.04.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 04:34:07 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 8/9] samples/bpf: update .gitignore
Date:   Thu, 30 Sep 2021 12:33:05 +0100
Message-Id: <20210930113306.14950-9-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210930113306.14950-1-quentin@isovalent.com>
References: <20210930113306.14950-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Update samples/bpf/.gitignore to ignore files generated when building
the samples. Add:

  - vmlinux.h
  - the generated skeleton files (*.skel.h)
  - the samples/bpf/libbpf/ directory, recently introduced as an output
    directory for building libbpf and installing its headers.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 samples/bpf/.gitignore | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/samples/bpf/.gitignore b/samples/bpf/.gitignore
index fcba217f0ae2..01f94ce79df8 100644
--- a/samples/bpf/.gitignore
+++ b/samples/bpf/.gitignore
@@ -57,3 +57,6 @@ testfile.img
 hbm_out.log
 iperf.*
 *.out
+*.skel.h
+vmlinux.h
+libbpf/
-- 
2.30.2


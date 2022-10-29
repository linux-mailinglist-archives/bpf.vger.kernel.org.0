Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C8C612585
	for <lists+bpf@lfdr.de>; Sat, 29 Oct 2022 23:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiJ2VP2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 29 Oct 2022 17:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiJ2VP1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 29 Oct 2022 17:15:27 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E405C1B797;
        Sat, 29 Oct 2022 14:15:25 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o7so4225253pjj.1;
        Sat, 29 Oct 2022 14:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BoZFHsbnCAXJz2KAVMAI13fGcdcRoJSAkuerX6gwy9E=;
        b=bezEOlkHAMtFH3Y0BskqrL9q2CLmM2xcnVY2n1zTSdLjer89JD551XDKwnb9smL2Rf
         AD0lUOjO+QU1M+R4y7hqy0arVUhZ+UflepYaHPiEQ7AgyvBCLyHp8YJxIs2XJouzpZyp
         KWwZKqkFdJCkiqNFhLQiOx8q5ewaV5DOPJh8Opi/DUZWNgzsWBH1inO6+W0ZK3HoMfYN
         TrfERHl7a+zxw4WB/pnHDgP2eT84ypT5VxcHWHm68kHpmjl/3UXK+peJwZGfL6y0gt2N
         Rx6IE6DIMtQ8i1sit5o69wqnEe6p22v2SyIjnj2csnn37SCgiRbdCeTjVVfVRf7v8zqU
         A+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BoZFHsbnCAXJz2KAVMAI13fGcdcRoJSAkuerX6gwy9E=;
        b=MJG81kvFo9akW1PziCYGhaeBKBI4u9QKuy7+qLBLKDF0t1ThjTQRcaaSv/88gyQ4Le
         NRqW+XPR3l+e6O1XPRjPiAd1PiUewX8cQ8hW9M9fV40XHYQG6R97djMyOXesFFwmg8wy
         BPKGlwcmoPitNg2gpnTaqyg6xdSxax2R5vU5rbs6DCYdXomqoKYMQwF1HLxD4eSGs297
         GhPgomqjqmaomQqWGom/PzZopLwY0A0jyqY83Sl15LIdU0Y/I8NKlsOOMzvvPoiy+RkL
         7BoOHDy2rd4NkB6ZUb6ehedEov7cvJfblCy6H5rygU0/QWoLCksyz+76EYzMah2ByD0T
         kKUQ==
X-Gm-Message-State: ACrzQf3P7a94HU6TG2qadS38lz8sdYNpY1dj66qWKpUbqmpM15dqwshg
        oxlFYxgvZhBWHE3e0QDm2lM=
X-Google-Smtp-Source: AMsMyM5dKegnN/fqhoTPWRdtYQ3z0jZ7g52Fk7qf7b5ezhs06/iVBeEXOpgME6HReXw6+CqZlNVxmQ==
X-Received: by 2002:a17:902:da88:b0:187:3d6:4c6b with SMTP id j8-20020a170902da8800b0018703d64c6bmr6125650plx.85.1667078125347;
        Sat, 29 Oct 2022 14:15:25 -0700 (PDT)
Received: from uftrace.. ([14.5.161.231])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902680d00b00174d9bbeda4sm1696483plk.197.2022.10.29.14.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 14:15:25 -0700 (PDT)
From:   Kang Minchul <tegongkang@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kang Minchul <tegongkang@gmail.com>
Subject: [PATCH] samples: bpf: fix typo in README
Date:   Sun, 30 Oct 2022 06:15:20 +0900
Message-Id: <20221029211520.24033-1-tegongkang@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This commit fixes a simple typo in samples/bpf/README.rst

changed cofiguration to configuration.

Signed-off-by: Kang Minchul <tegongkang@gmail.com>
---
 samples/bpf/README.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/README.rst b/samples/bpf/README.rst
index 60c6494adb1b..af4934639133 100644
--- a/samples/bpf/README.rst
+++ b/samples/bpf/README.rst
@@ -87,7 +87,7 @@ Cross compiling samples
 -----------------------
 In order to cross-compile, say for arm64 targets, export CROSS_COMPILE and ARCH
 environment variables before calling make. But do this before clean,
-cofiguration and header install steps described above. This will direct make to
+configuration and header install steps described above. This will direct make to
 build samples for the cross target::
 
  export ARCH=arm64
-- 
2.34.1


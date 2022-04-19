Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666FE50758D
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 18:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350376AbiDSQuZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Apr 2022 12:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351107AbiDSQsp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Apr 2022 12:48:45 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA04AB7D4
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 09:46:00 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id l127so7120928pfl.6
        for <bpf@vger.kernel.org>; Tue, 19 Apr 2022 09:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/yzCLf1o8B2GddY/RYQRuwVjWPPM27OfwrXrFmy8RJg=;
        b=n10OUCd5lwLOoJGCzudzpwjAkRB0hAflZBvs1W5zjz0GojZ4EE9CPZpngvXvYGKCmJ
         LPrqfbwh2A06SUNzlp4B9owLDfKs5Ud8Ga9zbQjrRwo1rMPb1bmeGwfF3lKzdw6Cp/FL
         U4kN7PFArqvWw1CWJBOYQs1rMEUmyklSRCPqWJgdLyYmMLe9F2fY8wNwqvYUcOYnw7lD
         VgkzGykMe3/+rpAUr/y4yY4gyrqv2tgFGEiwW4IwWDBwc8YDOD6wBWCf1pwmZ4W1iFvF
         ZX0E2GScEJjoCX/zU8wp6C0SAKpztXtSq0huvNTkza9Zh70QluhdkepaXByOjqgRP7E/
         11Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/yzCLf1o8B2GddY/RYQRuwVjWPPM27OfwrXrFmy8RJg=;
        b=5vFw0Zv6jb4zCVACK4+wsM0oK/4NILCyEDXDVysF5BLUo9F7C8PLEbklNk101u7G7v
         dRij0vOO2alxOSk1LjUTNi4F8/9ROoYOOyPcL0C8c9mGik3Vdaj4qcxLyZJAwvuImV/I
         B6StHWmKKtsMTo89VhGPHjYlkJrksj4U3wsNdqVtDl/cC5GW2HPn2ga4+WHZaiPaw8+x
         MCGcsAnXc5+3hHe0Ga9wPpCtSjYeLJB9Y97i5LYOobzTw/dphel//rM6EpBGSaW44UUH
         QZxKSMzJtd8O9TS0Hlof4Tq4rVPyE/ZcGgY3Br8zS6Lpw+wf3TnCbLiaBuXu32cxxrgg
         xjoQ==
X-Gm-Message-State: AOAM533c/QYx8Kx8I9LKxeIlQ6ZDKBFvKN0JrQU3Qkl0Fn9P2dtdRsCz
        xp66Qdj4S/MkhZTbMcZ3z5zyK6fV7cZNKQ==
X-Google-Smtp-Source: ABdhPJxZD/oeqq66MW2Zh1rW8kc7L6Rdojj26VOWYKML1Rm6Ts+m++175DzoT3+MO9hp5xRd0PAddA==
X-Received: by 2002:a63:ec05:0:b0:3aa:2210:a5f with SMTP id j5-20020a63ec05000000b003aa22100a5fmr6112212pgh.128.1650386760273;
        Tue, 19 Apr 2022 09:46:00 -0700 (PDT)
Received: from localhost ([112.79.142.99])
        by smtp.gmail.com with ESMTPSA id d141-20020a621d93000000b00505aa1026f1sm17100938pfd.51.2022.04.19.09.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 09:45:59 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf-next v3 0/2] Ensure type tags are always ordered first in BTF
Date:   Tue, 19 Apr 2022 22:16:06 +0530
Message-Id: <20220419164608.1990559-1-memxor@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1023; h=from:subject; bh=RI7b3Y0EILFDlRhK1ya4EkJ4L7QwOl43XhiS2VxiKio=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBiXucwY4g4jQ4XYjkYI9xzuGK59B3AI0Dxk6YcjX4i 5sQxSsSJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYl7nMAAKCRBM4MiGSL8Ryho+EA CywsAqUckeSftp1p8zq+OXWwaTO20FrkOwWvEQ7x8uGjaOehqc/3myDksmcH5Tdg1wpooAObO49OR4 0VrTEAQJdNgh5zUOKqENlEBImJBTTAZ5fkvoR9HEGblw+a6R5EYQUwLqhRb4Q3Rl465TP7cH5mjmI9 4BoR9q81i8vpJBvHCiPNzrzs7AEtphPLzRug8in+9z0iWCDTszviuM3kdthp8qv2fc7xe8Ww+I6hag y9LpUYU6n4Tmo5egwxRxzU7tlVKf/Sud+rJ1sCp3j/EV3dEPNNJYfNfjW957azE71pMteiTMIkpwVb XaFfltvFA/ZsxfNvN1jJ24wgBn73DIr2fCRhfsFEWa8jAPcKsNKrAqp48kkyhdZnPsZsfYdAXTf/ot ZiS//XUaguxyFQJ4REGy6NzjoTpG91DoB8jzTUunfJqgpa9y7o0SLTFPyBhSDfGgGsR2GPAEoyaFdn B3ZaOZAhqFcBG9obFUqgkydVwYAbvGfvZMvHctKqELznKq3VONzBUR/mbsvNV23yPu70tIGY5bllRd Uy3jS9aCFVYy5RYCv79AcDUbAvPJurxdXcK2Ru/GayOzBW1OPgG10uaWDOcmqZQkDiYpTgvRZ+rfYy 2C+rhQZS2w0R+y6rY3yakjQUooslKgFZhazqj/kCEba3xEgn44OQlW17yQ7w==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When iterating over modifiers, ensure that type tags can only occur at head of
the chain, and don't occur later, such that checking for them once in the start
tells us there are no more type tags in later modifiers. Clang already ensures
to emit such BTF, but user can craft their own BTF which violates such
assumptions if relied upon in the kernel.

Changelog:
----------
v2 -> v3
v2: https://lore.kernel.org/bpf/20220418224719.1604889-1-memxor@gmail.com

 * Address nit from Yonghong, add Acked-by

v1 -> v2
v1: https://lore.kernel.org/bpf/20220406004121.282699-1-memxor@gmail.com

 * Fix for bug pointed out by Yonghong
 * Update selftests to include Yonghong's example

Kumar Kartikeya Dwivedi (2):
  bpf: Ensure type tags precede modifiers in BTF
  selftests/bpf: Add tests for type tag order validation

 kernel/bpf/btf.c                             | 54 +++++++++++
 tools/testing/selftests/bpf/prog_tests/btf.c | 99 ++++++++++++++++++++
 2 files changed, 153 insertions(+)

-- 
2.35.1


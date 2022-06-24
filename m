Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E08B558D1A
	for <lists+bpf@lfdr.de>; Fri, 24 Jun 2022 04:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiFXCHA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jun 2022 22:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiFXCHA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jun 2022 22:07:00 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A1B4D608
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 19:06:57 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ay16so1800957ejb.6
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 19:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=En1l5TZ47hr6UBhc5Y7uiHybYqaPJ5MRrX6K+1xlDmY=;
        b=coto7lIYTIgt5/6uXJNz9ScbPVLoMMXxb9OmmrjQaEznIFb1/mgVBuYa5BiQzK94YO
         Rl/Txcj3XUSU+sE9xbnqRNPDnnfL+kWaDOxijvvDHrRu2aoiM2tduJhKak/exlpCH8Pa
         gc7NxrPPV3f0X3xOT8fPd+7+aYhDElnwrWRQYfZQmt51ayQ/sRtk/W/RBD0CqdQDWg70
         ozECQ6IrgH9hz8z2e63NDyBjEYH5L9ZBOkWX2KYPSgaU22XxjX9M6z2xh+iVbnwtNz+H
         pQwzh/9+hOGjm/KvC5jcpcd3GbvRQQsN1iJTLGR+eXv493l9bOO+mnmUoxm7vLocRAa1
         LROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=En1l5TZ47hr6UBhc5Y7uiHybYqaPJ5MRrX6K+1xlDmY=;
        b=Mxvvjnkj9K+gi8+pnoE1ekXjj1ZWNQYHkFfXHmQ9H+vhXKtqk2Af2Npxz71JNuAfT8
         u/hFAN3lAsC6QrZz5kPSZKggJrf8+Q/GaQQuRrYdin16/I51DD5K67mSmIZmRIX8o+oq
         IlyTtzFqNCEh09dalFeUUofU3B+HTt+FXnHDBWG70lT0O9cKBtP8SIXyzoT5DZF1QZtV
         YDLKBjyMIZc6T5I2LFEtnD/FctZsJZrZI9U0A1V1p59ZkXGu+nVO5BY6J8whDKyherXF
         5V2tqMLph9cVwITGadAai3HvwJ7h7JbVAG8MGnNszUWTNgIlFKkgRS1dgVLhaLiuuqtc
         mcMg==
X-Gm-Message-State: AJIora+85Gajd4o9KXJX5+uE04sN17I1DHK5wjgRzvDVQfALGL/U301c
        XvUxwzz4kDMAV06skXgkRYIXn04AFjNzSZSv
X-Google-Smtp-Source: AGRyM1s2zeG6rvZR/G76LEYqbF915OHLkYKEKu4OiHKLwAREHdhIKESq+/txqVZPRGbnBPvDuts+QQ==
X-Received: by 2002:a17:907:ea6:b0:708:1282:cbe8 with SMTP id ho38-20020a1709070ea600b007081282cbe8mr11566112ejc.520.1656036415641;
        Thu, 23 Jun 2022 19:06:55 -0700 (PDT)
Received: from localhost.localdomain (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id h10-20020a50ed8a000000b00435728cd12fsm856595edr.18.2022.06.23.19.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 19:06:55 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, dan.carpenter@oracle.com
Cc:     eddyz87@gmail.com
Subject: [PATCH bpf-next 0/2] bpf: fix for use after free bug in inline_bpf_loop
Date:   Fri, 24 Jun 2022 05:06:11 +0300
Message-Id: <20220624020613.548108-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

These two patches fix the use after free bug in inline_bpf_loop()
reported by Dan Carpenter. The fix for verifier.c and the test case in
test_verifier.c are split into separate commits.

While the first patch is necessary, I'm not sure about the second. The
test case is somewhat fragile because of the following line:

	const int len = getpagesize() - 25;

Here 25 is a magical number that allows env->prog to fit in one page
before bpf_loop inlining and don't fit after the bpf_loop
inlining. I'd prefer to use sizeof(struct bpf_prog) instead of this
constant, but definition of the struct bpf_prog is not available in
test_verifier.c.

Eduard Zingerman (2):
  bpf: fix for use after free bug in inline_bpf_loop
  selftest/bpf: test for use after free bug fix in inline_bpf_loop

 kernel/bpf/verifier.c                         |  2 +-
 tools/testing/selftests/bpf/test_verifier.c   | 39 +++++++++++++++++++
 .../selftests/bpf/verifier/bpf_loop_inline.c  | 11 ++++++
 3 files changed, 51 insertions(+), 1 deletion(-)

-- 
2.25.1


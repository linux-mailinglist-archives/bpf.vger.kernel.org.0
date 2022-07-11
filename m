Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6F656D773
	for <lists+bpf@lfdr.de>; Mon, 11 Jul 2022 10:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiGKIM1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jul 2022 04:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiGKIM1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jul 2022 04:12:27 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A284B1D0CF
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 01:12:25 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v16so5905983wrd.13
        for <bpf@vger.kernel.org>; Mon, 11 Jul 2022 01:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MPFKY/bHlsQhtgUJcy9UK+LhK0GjolHXo8PsK9MTO74=;
        b=3dWItNH/NrG2UXqFVsxOXWN+q2qqBj4vzooK3M0fqc0NW7nFtkiqcvWaIp93vV4X5t
         cvuXswhlr6y8zqUrdIAnLYVuT0/bBNWWTBvXhoMuA9ghuCH4JYnL2Co6bcDvoOC4NyNL
         9bCZmbb8jxOvLj1zTcOoMyjoZjIdOAHWBXpO4ssyke6GlXpC73oLnxfit7nnRfO6iB7i
         256ylzPv5rvMS0FCWr1MXcdyFEWc5plJLs5nVT7L83L2EGX4IHqfxBkkHMgW6NlmQk7h
         zCrXXf4WDBzabyhGC8I3ECzVLJqbg7Zl72pFR5tKA6tbrSzAQECZD2fYwxRbLLd9YFX/
         FFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MPFKY/bHlsQhtgUJcy9UK+LhK0GjolHXo8PsK9MTO74=;
        b=K0KquDb0lKnh0dlE6PYtJw9zectUNyYwDMlBYBmxuTWQ6ydKLo9E9tc3l0uzj1YKWC
         0ceKYtoQl2hMBCrBW8N61PGvDhZQxiq+gaGRvyuMCsr5Lc3Jth7ju0I7P1RcPP55h/ej
         WgrHb2qyKss8LEUdOiCFS9qceK2xjfWQYvDpdASaMdWSGk9cpQimdUXc6EIb7KIL5I58
         xyvPNCULOQfijOm0sALeOWxDtLjvbYXXl8+YWSjsspFFExxyuMqhWKL69U7AxWEyKdNm
         s4GMQbc1tSi/lg1inbXtlq/4C0j4kTBYCIldR8KO2HSpIbUYNv7Kt0vmy24cJlU9eFUv
         tpMg==
X-Gm-Message-State: AJIora8xJRkeUm3+Qfc2PzrVhDQE9uQ7TPhPAEAI0z/SE4YzvFUOSto4
        Vmi9SKyKLdVax8o3PVQ8YxFgnw==
X-Google-Smtp-Source: AGRyM1tyUmKFNUbH8YgWNHHNsuw6XFvycdzRT3nCgIcwAJdtGiyuk4Xct3kq4NBg+aexVIJb1PXCpg==
X-Received: by 2002:adf:e111:0:b0:21d:665e:2fa5 with SMTP id t17-20020adfe111000000b0021d665e2fa5mr16086610wrz.652.1657527144170;
        Mon, 11 Jul 2022 01:12:24 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d6604000000b0021d650e4df4sm5159809wru.87.2022.07.11.01.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 01:12:23 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>
Cc:     mptcp@lists.linux.dev,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2] bpf: Fix 'dubious one-bit signed bitfield' warnings
Date:   Mon, 11 Jul 2022 10:12:00 +0200
Message-Id: <20220711081200.2081262-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Our CI[1] reported these warnings when using Sparse:

  $ touch net/mptcp/bpf.c
  $ make C=1 net/mptcp/bpf.o
  net/mptcp/bpf.c: note: in included file:
  include/linux/bpf_verifier.h:348:26: error: dubious one-bit signed bitfield
  include/linux/bpf_verifier.h:349:29: error: dubious one-bit signed bitfield

Set them as 'unsigned' to avoid warnings.

[1] https://github.com/multipath-tcp/mptcp_net-next/actions/runs/2643588487

Fixes: 1ade23711971 ("bpf: Inline calls to bpf_loop when callback is known")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    v2: switch from 'bool' to 'unsigned int' (Yonghong Song)

 include/linux/bpf_verifier.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 81b19669efba..2e3bad8640dc 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -345,10 +345,10 @@ struct bpf_verifier_state_list {
 };
 
 struct bpf_loop_inline_state {
-	int initialized:1; /* set to true upon first entry */
-	int fit_for_inline:1; /* true if callback function is the same
-			       * at each call and flags are always zero
-			       */
+	unsigned int initialized:1; /* set to true upon first entry */
+	unsigned int fit_for_inline:1; /* true if callback function is the same
+					* at each call and flags are always zero
+					*/
 	u32 callback_subprogno; /* valid when fit_for_inline is true */
 };
 
-- 
2.36.1


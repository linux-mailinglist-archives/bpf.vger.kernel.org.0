Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2789256CDCB
	for <lists+bpf@lfdr.de>; Sun, 10 Jul 2022 10:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbiGJIfd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 10 Jul 2022 04:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiGJIfc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 10 Jul 2022 04:35:32 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FB813F20
        for <bpf@vger.kernel.org>; Sun, 10 Jul 2022 01:35:30 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so3401762wme.0
        for <bpf@vger.kernel.org>; Sun, 10 Jul 2022 01:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=orIIFdtRbt6cm/l/3AlelKzIyuzEuMYVC6VdEiG/HhE=;
        b=xw92GhKX4WJO8whQD7utDC8+8bFUEokf6yXN1jTy1b8fK7xUW6SB6d3+HjS0DvXLln
         bu2CcR2YFRaQZFjV19f90BQSnxs/vaoHsaybo7j3aeVfpytGIIkW/Xvu6uexB8PrE/Ge
         XpYOfxY7hQT9u0RvKILf+GBEYrXwvGdduWd9tyDOcEztbS14h6uOF50qQmRSixwuhmaQ
         jGpgJfWQZidxD74rkU11R6urlWEKy51jhcyDMa0ZO0DyHjFSy7mzxI64jEn52drPB0kz
         7Ydd2tQlZibBTDjy+AbGQ3K1FhRIf5cOSzCjwF5S/q3gOwoMi+NmYGtAUf7DVfmfKZL3
         PDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=orIIFdtRbt6cm/l/3AlelKzIyuzEuMYVC6VdEiG/HhE=;
        b=OMGh+tRln1r3A+wC0HIWTH7Z3+D68OxVPwTsJp6UK5juAAx+5e3aUgPJQUURL+qC7E
         iZpqdwPDoM7pTGAyYqB4j+o8f0SOIqxtckpjKeQm0AOkZ3ngalAVIJLXj/vcVaF6FlfH
         R3VO5WApOAFyXCrP02c+bExDswAsym713utxoQR2cIViP2M007MaOIoD4OT51QlUDdmR
         zGnDjxWkOXzAEctsZiyfe1aU9Ks2+Uky0k7e7/a/wKhrd0uReEAaGthBRz/tTUAqHNPE
         HYWFNsZ/1FUwfjLHhNHXf0nU2v+4Tq1bwZPqTHKPPRV4qncxEXAaRUHD9UCzR8QbER4N
         qZvw==
X-Gm-Message-State: AJIora/rXdNy8ICNZQ+YlFK3w7JnmQoyfnJRN5T7jIp3VpYT+iYfYSJu
        cg/Ick0noo6STvDI0yI2FEQu4g==
X-Google-Smtp-Source: AGRyM1tfaaudoS0WgFrUsnxUfK8M9lLdROl46O50ihd3Xfy0Amv5OvYdh8xbcdjuftlmcbSlpL7aYw==
X-Received: by 2002:a05:600c:4e54:b0:3a0:4e07:ce with SMTP id e20-20020a05600c4e5400b003a04e0700cemr9652537wmq.37.1657442128721;
        Sun, 10 Jul 2022 01:35:28 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id b17-20020adff911000000b0021d819c8f6dsm3120944wrr.39.2022.07.10.01.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 01:35:28 -0700 (PDT)
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
Subject: [PATCH bpf-next] bpf: fix 'dubious one-bit signed bitfield' warnings
Date:   Sun, 10 Jul 2022 10:35:23 +0200
Message-Id: <20220710083523.1620722-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

These two fields from the new 'bpf_loop_inline_state' structure are used
as booleans. Instead of declaring two 'unsigned int', we can declare
them as 'bool'.

While at it, also set 'state->initialized' to 'true' instead of '1' to
make it clearer it is linked to a 'bool' type.

[1] https://github.com/multipath-tcp/mptcp_net-next/actions/runs/2643588487

Fixes: 1ade23711971 ("bpf: Inline calls to bpf_loop when callback is known")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 include/linux/bpf_verifier.h | 8 ++++----
 kernel/bpf/verifier.c        | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 81b19669efba..2ac424641cc3 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -345,10 +345,10 @@ struct bpf_verifier_state_list {
 };
 
 struct bpf_loop_inline_state {
-	int initialized:1; /* set to true upon first entry */
-	int fit_for_inline:1; /* true if callback function is the same
-			       * at each call and flags are always zero
-			       */
+	bool initialized; /* set to true upon first entry */
+	bool fit_for_inline; /* true if callback function is the same
+			      * at each call and flags are always zero
+			      */
 	u32 callback_subprogno; /* valid when fit_for_inline is true */
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 328cfab3af60..4fa49d852a59 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7144,7 +7144,7 @@ static void update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno
 	struct bpf_loop_inline_state *state = &cur_aux(env)->loop_inline_state;
 
 	if (!state->initialized) {
-		state->initialized = 1;
+		state->initialized = true;
 		state->fit_for_inline = loop_flag_is_zero(env);
 		state->callback_subprogno = subprogno;
 		return;
-- 
2.36.1


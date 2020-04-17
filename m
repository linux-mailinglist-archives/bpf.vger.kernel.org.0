Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6C61AD383
	for <lists+bpf@lfdr.de>; Fri, 17 Apr 2020 02:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgDQAAU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Apr 2020 20:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727949AbgDQAAT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Apr 2020 20:00:19 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21016C061A0F
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2020 17:00:19 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id h95so95762wrh.11
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2020 17:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+ycVrA9x9/lbPMU6D45f41mp9d39r5v4CO2ML0Q9iI0=;
        b=u9dO5OlpibvSnZ6UZGy9h+vW8LkUfC7jr1uL1/uE6SSZg8XpshUo9dhyJ2OPzWAUwR
         xPs5E7Gx0euqcWuFSUbOrhA2evicj65BRJjanLETMEL8a2ARMuLH7/x4r6d8VrWXiyb/
         IwL38+iqy2XRc1rkwTnLQsl6cWcikLR4td5RRNWHkLgus4ZPgRdSrD6PDtoQ/Ky+uoLj
         LROycJyfGTgzhrVY5fJvbBWqIZ7JKQHrvcM7OIAPamMYH3jFCBdreO5Bw8GG0o5rMWeC
         fJ8N0Qo+BBVyyoYicLhh4JgiFBbaC7EWVTxOxy93jLhNdEdXxle0eyw2LtJ2vEkkJ7s3
         QVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+ycVrA9x9/lbPMU6D45f41mp9d39r5v4CO2ML0Q9iI0=;
        b=CHoN6Nw9x5aPZoDqkePxQk+vpaCvP+MhMsGp7aedk2C7T2V9al8XQYkNuYd9mi4VOn
         vycHirVRX47ByX28ByeXIo0IWcLOVGmfTmf+FfNXvu63dCo1DpOG0CN+bJUXhtOjWUr5
         oR8a+dWUAkxhDL9DOx2SpwMHDofEa8mp6NCU9duj+Sk0PRjkATcKEPj8MVjK0TV8uVMC
         sfEnofNHonBTDSzV6VPM+2SM8jnPSM68gA2dHQAwCxJiX06LHuMhgYNi0NtCopbXn/Db
         NiuF3lECiy941iqFqc02hp2Xr0936c+Qe6TZ3vNiCjKhEsgh7nZtq8ZtU6FTWZaqd2B3
         Y88w==
X-Gm-Message-State: AGi0PuZA23g4+tZpiEwo8Ys+zbZA1w0HhLNe8HJHInbRdwcrrrYgvuWG
        8YmxV1FB9sd9oK+ialrK6rtk7upBEWVpC5G+s6B923/vlZCnq1hRdnyty7l7g0wIVJf5guLM8HM
        K1TQLWp/u3hJDxCrn0ujpotBK+6o7JvOaFcCF6qnlFnhTrzVCwPWFvng=
X-Google-Smtp-Source: APiQypJsAOlXcddQ3BNtnAQBMQ5J659Iy5S6myTav7GnL47MbsPq5oFxHzOknl+tgOGOrWL5YsCVhfu2Aw==
X-Received: by 2002:adf:dd10:: with SMTP id a16mr814868wrm.26.1587081616972;
 Thu, 16 Apr 2020 17:00:16 -0700 (PDT)
Date:   Fri, 17 Apr 2020 02:00:07 +0200
In-Reply-To: <20200417000007.10734-1-jannh@google.com>
Message-Id: <20200417000007.10734-2-jannh@google.com>
Mime-Version: 1.0
References: <20200417000007.10734-1-jannh@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v2 2/2] bpf: Fix handling of XADD on BTF memory
From:   Jann Horn <jannh@google.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

check_xadd() can cause check_ptr_to_btf_access() to be executed with
atype==BPF_READ and value_regno==-1 (meaning "just check whether the access
is okay, don't tell me what type it will result in").
Handle that case properly and skip writing type information, instead of
indexing into the registers at index -1 and writing into out-of-bounds
memory.

Note that at least at the moment, you can't actually write through a BTF
pointer, so check_xadd() will reject the program after calling
check_ptr_to_btf_access with atype==BPF_WRITE; but that's after the
verifier has already corrupted memory.

This patch assumes that BTF pointers are not available in unprivileged
programs.

Fixes: 9e15db66136a ("bpf: Implement accurate raw_tp context access via BTF")
Signed-off-by: Jann Horn <jannh@google.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9e92d3d5ffd17..9382609147f53 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3099,7 +3099,7 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 	if (ret < 0)
 		return ret;
 
-	if (atype == BPF_READ) {
+	if (atype == BPF_READ && value_regno >= 0) {
 		if (ret == SCALAR_VALUE) {
 			mark_reg_unknown(env, regs, value_regno);
 			return 0;
-- 
2.26.1.301.g55bc3eb7cb9-goog


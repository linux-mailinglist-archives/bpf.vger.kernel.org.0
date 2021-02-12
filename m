Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173EC3197AA
	for <lists+bpf@lfdr.de>; Fri, 12 Feb 2021 02:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhBLBBh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Feb 2021 20:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhBLBBf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Feb 2021 20:01:35 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4679C061756
        for <bpf@vger.kernel.org>; Thu, 11 Feb 2021 17:00:55 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id e9so3285489qvf.21
        for <bpf@vger.kernel.org>; Thu, 11 Feb 2021 17:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=VhboEOwx90BA2VHngd4xRHbJOwfjOuGwRxlUkSaq3fM=;
        b=fyedVPfHhqDHv2xDsMVGA6EK/KlKoyvf7RGTcLWnRsvs41vPyjYrNTXH95nYa4SKHh
         Xx4pNKV60FiTS8Z/iWnBZF+nx+Agtf8KWjsGOIaFAzDHMZXBjylKiFZbrrlZdm9hwI7K
         F06xvD+c1iTtXjFKdhBGBuJ9LLgxmYNpVxnmxyl9XXTkWoM2fI9Pnw39n1TFluWA/YPJ
         94A/Au4eRmXPzN0fcUiNfsiq13+Vz4B0BZWKmDtVQJaHdIRk3jEl4IRVyUF1jZqJwoC6
         9/3cI1zPKTm7T2HZ7ZsEpQml3v9+j/1JYxZEsCgJdMma6bLbChrcJIsoA5VCayy4XfRf
         wWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=VhboEOwx90BA2VHngd4xRHbJOwfjOuGwRxlUkSaq3fM=;
        b=plfUPJaxveCAcYqSiGbvcb4I9RtJDhpb7YOyhbhsRMCh5jHg4uEDMmclMx7Nq0ZIy5
         4no6B64NOmhMM1RSgWW+QZeyYK0MjxENrz9j+arenXXGJj/Ky+qS4sY2DFoCg/MSFsLD
         azw78R5jLuma8CmxtxM0FlBiLKuTV7ZbwHnxI/zoW+bITmE4gaFRjPeoj0Sz5ikwVV0L
         n8PYWojZxX71Q9J4ioVHnnDq8hyVWsCsml9Rwa+lHFoG4oOFuFwNTn0Fj12mOuPDZNET
         uH+Dx9jt7iu2lZDA/NDnjN/GUWCkF69p/ZrMV9BnmDWoSVVe6/eB8qZ99FdyjoR5DgXW
         l9kQ==
X-Gm-Message-State: AOAM531M2c6y7cVClzQJPLVUyXl9/hrFXTUKkeOF8jCWG4oU3rKxYTTX
        0J4pOD/gjj1YQ3Iae63r0hu4JcM=
X-Google-Smtp-Source: ABdhPJwJhORgqxY2A6kqpp1ozJ3gJSNQulV/5xCjGEnGp61j5/nxuOdBL/4rLC3L4dAgGH1MwDetvlU=
Sender: "sdf via sendgmr" <sdf@sdf2.svl.corp.google.com>
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:7009:7a82:4a5c:f303])
 (user=sdf job=sendgmr) by 2002:a0c:8ec7:: with SMTP id y7mr508170qvb.9.1613091654763;
 Thu, 11 Feb 2021 17:00:54 -0800 (PST)
Date:   Thu, 11 Feb 2021 17:00:53 -0800
Message-Id: <20210212010053.668700-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH bpf-next] tools/resolve_btfids: add /libbpf to .gitignore
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There is what I see after compiling the kernel:

 # bpf-next...bpf-next/master
 ?? tools/bpf/resolve_btfids/libbpf/

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/bpf/resolve_btfids/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/resolve_btfids/.gitignore b/tools/bpf/resolve_btfids/.gitignore
index 25f308c933cc..16913fffc985 100644
--- a/tools/bpf/resolve_btfids/.gitignore
+++ b/tools/bpf/resolve_btfids/.gitignore
@@ -1,2 +1,3 @@
 /fixdep
 /resolve_btfids
+/libbpf/
-- 
2.30.0.478.g8a0d178c01-goog


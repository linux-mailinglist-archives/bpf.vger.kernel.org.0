Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3742454AB
	for <lists+bpf@lfdr.de>; Sun, 16 Aug 2020 00:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgHOWfp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 15 Aug 2020 18:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbgHOWfn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 15 Aug 2020 18:35:43 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504DDC0045B2
        for <bpf@vger.kernel.org>; Sat, 15 Aug 2020 12:57:59 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k8so10676435wma.2
        for <bpf@vger.kernel.org>; Sat, 15 Aug 2020 12:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f0mMsAj1lSg7GPakykMGfErTBU0jbBblfsVFAwkyqoI=;
        b=W4T3vQlyl2w2nkNf0HBa44C+rX+2QYZ20A/oYFCUhpPWgjzv1LflBS7bALC2uJfRWr
         FgqtZcLXii8cNMlBj+b9wFqNVZSRZwL5cVyP3prF55Eovky4SIq9O8VRxERgR/eBkgGX
         VmPTjDls2DbAYLTFoyopPB9FoO2Q3EPOsm7z2jtDMdM86LNYu9GtSceYMShMLXVneh1/
         KHlRa2BSICWgNw9cUdSRwfHdYb4SHLpFmkZs+JxsJknf4cOJfq63c0ZoA6y2edZe3uMH
         ESkeP7OdMpnFue1M06w3vdzTjrDjniAJTemQDNj196j2OsiuMEpzAYUlaDb8cc7k0P3y
         0GEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f0mMsAj1lSg7GPakykMGfErTBU0jbBblfsVFAwkyqoI=;
        b=KdrCPElA6RVntNGOhItaM5lqrO47IV1VnQDRAfkKsOXZsak4KiDePpKhPKWe5RzfM8
         2sFV28yIF4EMWJsaohdspj2nINKFdTVIUSELpqcp/X4owYeNe1jiYRjrwcPhlak9eXQg
         PXASUaUfzWL+6ivR670lRtBDnrBUMFJBYorzVduWmN0tqBuenCF6eqtY6jajrQupScXc
         cZDmy3/WbTte+tx582UDi7ICgzyP6HDXMCe1lkiSYfaE7nmqlFmYYE5E7V1UmNfN8Nu1
         4zn6392YFfvNExEIEfyNgPiGUwl3cZi/1aVq6bjDXywm0jx5FKZX693PxDjJrkDWPGo9
         +Y/Q==
X-Gm-Message-State: AOAM5303Ys7bW6SSjArgEfFexMaMp+1OQY6fCWp6dVXLwRXKRLHN3OWB
        HPFn2he8dKq5uDgUlzXof98=
X-Google-Smtp-Source: ABdhPJxXcTps2zVdaVr3W0+E+msUx/x2J38p7/p2P7J3HQYhnEaNvAUmdV+15lWq6/dVNGYgGIo/mg==
X-Received: by 2002:a1c:740e:: with SMTP id p14mr7691472wmc.179.1597521478077;
        Sat, 15 Aug 2020 12:57:58 -0700 (PDT)
Received: from localhost.localdomain (bzq-109-67-21-91.red.bezeqint.net. [109.67.21.91])
        by smtp.googlemail.com with ESMTPSA id c10sm25065982wrn.24.2020.08.15.12.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 12:57:57 -0700 (PDT)
From:   Lior Ribak <liorribak@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Cc:     bpf@vger.kernel.org, Lior Ribak <liorribak@gmail.com>
Subject: [PATCH] samples/bpf: Support both enter and exit kprobes in helper
Date:   Sat, 15 Aug 2020 12:57:26 -0700
Message-Id: <20200815195726.305131-1-liorribak@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, in bpf_load.c, the function write_kprobe_events sets
the function name to probe as the probe name.
Even though it's valid to set one kprobe on enter and another on exit,
bpf_load.c won't handle it, and will return an error 'File exists'.

Add a prefix to the event name to indicate if it's on enter or exit,
so both an enter and an exit kprobes can be attached.

Signed-off-by: Lior Ribak <liorribak@gmail.com>
---
 samples/bpf/bpf_load.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/samples/bpf/bpf_load.c b/samples/bpf/bpf_load.c
index c5ad528f046e..69102358e91a 100644
--- a/samples/bpf/bpf_load.c
+++ b/samples/bpf/bpf_load.c
@@ -184,18 +184,24 @@ static int load_and_attach(const char *event, struct bpf_insn *prog, int size)
 
 #ifdef __x86_64__
 		if (strncmp(event, "sys_", 4) == 0) {
-			snprintf(buf, sizeof(buf), "%c:__x64_%s __x64_%s",
-				is_kprobe ? 'p' : 'r', event, event);
+			if (is_kprobe)
+				event_prefix = "__x64_enter_";
+			else
+				event_prefix = "__x64_exit_";
+			snprintf(buf, sizeof(buf), "%c:%s%s __x64_%s",
+				is_kprobe ? 'p' : 'r', event_prefix, event, event);
 			err = write_kprobe_events(buf);
-			if (err >= 0) {
+			if (err >= 0)
 				need_normal_check = false;
-				event_prefix = "__x64_";
-			}
 		}
 #endif
 		if (need_normal_check) {
-			snprintf(buf, sizeof(buf), "%c:%s %s",
-				is_kprobe ? 'p' : 'r', event, event);
+			if (is_kprobe)
+				event_prefix = "enter_";
+			else
+				event_prefix = "exit_";
+			snprintf(buf, sizeof(buf), "%c:%s%s %s",
+				is_kprobe ? 'p' : 'r', event_prefix, event, event);
 			err = write_kprobe_events(buf);
 			if (err < 0) {
 				printf("failed to create kprobe '%s' error '%s'\n",
-- 
2.25.1


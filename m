Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57CE30352C
	for <lists+bpf@lfdr.de>; Tue, 26 Jan 2021 06:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732849AbhAZFgz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jan 2021 00:36:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728593AbhAYNH6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jan 2021 08:07:58 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF63EC061788
        for <bpf@vger.kernel.org>; Mon, 25 Jan 2021 05:06:38 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id w5so7962111wrl.9
        for <bpf@vger.kernel.org>; Mon, 25 Jan 2021 05:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=gPE7b3/M6uCT5ZEUoYFVzS554jwY/Cx+KLicb2SXbs0=;
        b=qt1z7TkNoS9LG+sx0K0P2/jQ07smZJ2i7rZJ+/ppPnkhnkD/VRRQKBlBnCwbtrmA0V
         izVEVH/olwD1HuRV7zRoly2WCQ9PDzLXooovKlvr2DsjBImzmVs6Dgk0ppRAFvPZ81vy
         BuIbhkeZVS4FQK+JG/afbflq4vkYCfyWEZAyMlpbKdn99ljHtMYvLUZflECLPmC+SEhB
         zX8gKtdkFMBUn5Ihk/H+kpa9DbpGCYKuA5zBnMN9XiFmx0N0gE91H0eEwgJn+Oy9eCbj
         HzZg3wVHo7jj9FMk4mTYmmLvL+GVPoteCCrqySCQZBwAOyx0DPI0yCl7J1QRF+tWaw5Q
         XwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gPE7b3/M6uCT5ZEUoYFVzS554jwY/Cx+KLicb2SXbs0=;
        b=PU8MsHqVRjNuCmuvlCmK6u1Mjs3rw2R1jBF2VD/31jkIjKeztbYsT88YQG00Z7/Vo7
         PkQDqZux8Q9YccIMAYlQIpUZPtGEMuB7lFJM4QTBN8/dXIHnBup/YoexsUv7YTCEKo2Q
         RD/CQmiurDaVLrR2KXnPoahKQ6hTsZboBLVDQHbZcawC22LnyQkAYzU/2S9AsrvaHIDG
         6SkahDZdMPYXkooV6eIJVnkwEzptsxgyR9DYQXFXl7qI+skeyXdyMoin2p6BQ5Uhlsk7
         v08FTrRl/Y+Vap80njJUHxSWbFGH680Z63hl/Ynq1XtXI5zNC3nD/+pc6JzKuUBSlZiB
         y4tw==
X-Gm-Message-State: AOAM533xn+u+bVEfANHsnYcy7lkTqA8WT04AF1C1VOOaw98JiWmxPsLB
        J4zoJrNc+8+ofn9hnUEPAIDMkJwXEfAhPg==
X-Google-Smtp-Source: ABdhPJwqUswTeWhqfYqtt3aXneF0oEqCmZ9xQz2yt3073LrQB25loOFYEchMfmwmuQ6wi3mE576iHo6J2Uyt3w==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:a6ae:11ff:fe11:4f04])
 (user=gprocida job=sendgmr) by 2002:adf:a11d:: with SMTP id
 o29mr882505wro.45.1611579997395; Mon, 25 Jan 2021 05:06:37 -0800 (PST)
Date:   Mon, 25 Jan 2021 13:06:22 +0000
In-Reply-To: <20210125130625.2030186-1-gprocida@google.com>
Message-Id: <20210125130625.2030186-2-gprocida@google.com>
Mime-Version: 1.0
References: <20210125130625.2030186-1-gprocida@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH dwarves 1/4] btf_encoder: Improve ELF error reporting
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org
Cc:     acme@kernel.org, andrii@kernel.org, ast@kernel.org,
        gprocida@google.com, maennich@google.com, kernel-team@android.com,
        kernel-team@fb.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

libelf provides an errno/strerror-like facility. This commit updates
various error messages to include helpful error text.

Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 libbtf.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/libbtf.c b/libbtf.c
index 7552d8e..9f76283 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -110,8 +110,8 @@ try_as_raw_btf:
 
 		btfe->elf = elf_begin(btfe->in_fd, ELF_C_READ_MMAP, NULL);
 		if (!btfe->elf) {
-			fprintf(stderr, "%s: cannot read %s ELF file.\n",
-				__func__, filename);
+			fprintf(stderr, "%s: cannot read %s ELF file: %s.\n",
+				__func__, filename, elf_errmsg(elf_errno()));
 			goto errout;
 		}
 	}
@@ -707,13 +707,15 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 	}
 
 	if (elf_version(EV_CURRENT) == EV_NONE) {
-		fprintf(stderr, "Cannot set libelf version.\n");
+		fprintf(stderr, "Cannot set libelf version: %s.\n",
+			elf_errmsg(elf_errno()));
 		goto out;
 	}
 
 	elf = elf_begin(fd, ELF_C_RDWR, NULL);
 	if (elf == NULL) {
-		fprintf(stderr, "Cannot update ELF file.\n");
+		fprintf(stderr, "Cannot update ELF file: %s.\n",
+			elf_errmsg(elf_errno()));
 		goto out;
 	}
 
@@ -721,7 +723,8 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 
 	ehdr = gelf_getehdr(elf, &ehdr_mem);
 	if (ehdr == NULL) {
-		fprintf(stderr, "%s: elf_getehdr failed.\n", __func__);
+		fprintf(stderr, "%s: elf_getehdr failed: %s.\n", __func__,
+			elf_errmsg(elf_errno()));
 		goto out;
 	}
 
@@ -764,6 +767,9 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 		if (elf_update(elf, ELF_C_NULL) >= 0 &&
 		    elf_update(elf, ELF_C_WRITE) >= 0)
 			err = 0;
+		else
+			fprintf(stderr, "%s: elf_update failed: %s.\n",
+				__func__, elf_errmsg(elf_errno()));
 	} else {
 		const char *llvm_objcopy;
 		char tmp_fn[PATH_MAX];
-- 
2.30.0.280.ga3ce27912f-goog


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8132FE8EC
	for <lists+bpf@lfdr.de>; Thu, 21 Jan 2021 12:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbhAULgr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jan 2021 06:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730477AbhAULgN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jan 2021 06:36:13 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664E8C061794
        for <bpf@vger.kernel.org>; Thu, 21 Jan 2021 03:35:31 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id q24so412523wmc.1
        for <bpf@vger.kernel.org>; Thu, 21 Jan 2021 03:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=tHm4aawgl4upxAANEu6km7IPT8qo7sF57UAGh5jcpEQ=;
        b=Ds0HNmp+7d57PEygc5eJeuDPMs2K36GpyTgvXuI+sYnvLHDRl4l47t84aX6pqaOUyN
         M0cqR7DNwQdUFHH+U7RNJYRbRfePFqBPHiKCBVXGiMUt1mPvM3LgLWVDcqqwiTKerhNV
         yYFLIRDLzcO7VtceJd29Dm1Kyi5aIytZjBpTfHkW+T1wyed2Gvueb08kJqPdQjaDqlHX
         gwE8jpy9C7X7QxUH2bqooA80qU3E+A3NdGgz15Tf5EKlqB9Hl+JgHnNHnN2XBHvtyaAx
         g3TiIHdXrlEDWjy8aLL5wdQWKGRWBHYS6XHEZbyrq3JseIowte/ev73FyiyQT1Oh5t0u
         Vn/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tHm4aawgl4upxAANEu6km7IPT8qo7sF57UAGh5jcpEQ=;
        b=rBy7gyQAK+dGt5yddKyg4v3fXUz1zW/o6hwN4m1BqDbDU3RYEvfnSjDO23krXJcVpl
         CBF9Bpcnh7h868GnM21nDfgFyPjmU1HhamE4t5FuowUe7lTnyt7YzvzBkEnleUgB4/6y
         JRKLmxoVYyQsmJGsER3qrpkgL+WkzQ3aMy8UYIU6qxdSn2S6qpMyn2nP8OEvbYTTfR0a
         Qlie6zNuClxpq/D7N6tX/jkI0/V8iyjK5cuRuSu4uBeK6vdaVUT9CeQ3lPRKlUQ0uqn7
         VyF2P8ntgZ8MgAsu3DusNjjVLABmO/s/zbJiuWkc0z2lc2nO2ZTBjkCF+lSY9pXXx73t
         IIXQ==
X-Gm-Message-State: AOAM532GbSuhuiqG9bLg6dqkKrpcvUskcFv3e4RX28JSbmi1y1vDClDD
        aqNbsv0clRU5FcgCkbj/tL1BarZS0stabw==
X-Google-Smtp-Source: ABdhPJwkT3VH4D3ylEUPgDZEGZQ7ElFObJ8fc1L0AgD7z8Ml7WHUWCN/ZDwWYaaUpj/nBbu9yEwa89ciGUC+dA==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:a6ae:11ff:fe11:4f04])
 (user=gprocida job=sendgmr) by 2002:a5d:4806:: with SMTP id
 l6mr11402294wrq.389.1611228930100; Thu, 21 Jan 2021 03:35:30 -0800 (PST)
Date:   Thu, 21 Jan 2021 11:35:20 +0000
In-Reply-To: <20210121113520.3603097-1-gprocida@google.com>
Message-Id: <20210121113520.3603097-4-gprocida@google.com>
Mime-Version: 1.0
References: <20210118160139.1971039-1-gprocida@google.com> <20210121113520.3603097-1-gprocida@google.com>
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
Subject: [PATCH dwarves v2 3/3] btf_encoder: Set .BTF section alignment to 16
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org
Cc:     kernel-team@android.com, maennich@google.com, ast@kernel.org,
        andrii@kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        Giuliano Procida <gprocida@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

NOTE: Do not apply. I will try to eliminate the dependency on objcopy
instead and achieve what's needed directly using libelf.

This is to avoid misaligned access when memory-mapping ELF sections.

Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 libbtf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/libbtf.c b/libbtf.c
index 7552d8e..2f12d53 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -797,6 +797,14 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 			goto unlink;
 		}
 
+		snprintf(cmd, sizeof(cmd), "%s --set-section-alignment .BTF=16 %s",
+			 llvm_objcopy, filename);
+		if (system(cmd)) {
+			/* non-fatal, this is a nice-to-have and it's only supported from LLVM 10 */
+			fprintf(stderr, "%s: warning: failed to align .BTF section in '%s': %d!\n",
+				__func__, filename, errno);
+		}
+
 		err = 0;
 	unlink:
 		unlink(tmp_fn);
-- 
2.30.0.296.g2bfb1c46d8-goog


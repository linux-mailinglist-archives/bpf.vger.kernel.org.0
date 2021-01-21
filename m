Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C6D2FE8EF
	for <lists+bpf@lfdr.de>; Thu, 21 Jan 2021 12:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbhAULgx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jan 2021 06:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730421AbhAULgL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jan 2021 06:36:11 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89152C061786
        for <bpf@vger.kernel.org>; Thu, 21 Jan 2021 03:35:28 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id s26so1200420qtq.21
        for <bpf@vger.kernel.org>; Thu, 21 Jan 2021 03:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=7/SN6szQNLLz010hJwo1UBS9+/YFLEy0oZww8gtGTAU=;
        b=seF3tjBBjQMRwwhd0avsnTQmHfvFUYS4OYKRdUMscToC4Uu8WRTQYW983GuAV9Wcg8
         ENe749X+TStHaEzNebOazoh2PuO6m4SVgj5P3qISO08+nD2cKxi22mJsuYMGxqujMZiF
         H+WuYXaQXSe862t5kLpFcdSyyfGVtsUQSMuaiwxq1ZPMGHKl4L46ujOWZbtMz2y0ZKi+
         HYb+Q3wiG0kD0Bv6/g1EpdDkwsZh97CRTSfofMh5GC1eYHrQxU6zMohB71irEWSIT0Pb
         EzjqqaMMltxoUtJqAcn4PwSPjQlXpEPlYsVclPFkYUuNktJGzow/6twND3fltFQd9Jag
         My9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7/SN6szQNLLz010hJwo1UBS9+/YFLEy0oZww8gtGTAU=;
        b=PFz8oIXuoOUD0hBayllahPx5/c/eNOMdY5/4qR0JqhdJct0FKKjMQUi9zAy8MH5eye
         zZmauAOuKLV+t2mLDDe1kFCNz8p/bbN/0xBmpqtzRPpwo2863hIGv38CvVVyuYa20wad
         hDx6Oh1cawHiaH5j3Ahe5wBBmTevynIz9tEnQMlV+RuVN0RuJc/7YxEjBNNdAX9WPNlj
         /v8jDc9HCG5UzFc7FJvMrDL8ijHOK5u8452/nnHn546IgB3hcOwxZ/LJi502Ln12nXRX
         UCDwM2UfdGEN7IH+cBrLy62TlPkAbBfNqlU4K4QGeRnhNV1VIHq3phhEYDPIAmY1HL3q
         EzyA==
X-Gm-Message-State: AOAM532aMMPMeT062kYogre8MfleHm/DTFq9TAMTvvhTRX+14uSRoknO
        R+7cWgqOEjr/VU1xfXMDZEUhQNFzn8KOqA==
X-Google-Smtp-Source: ABdhPJzthVyDCUNV6p2fUfYujC2TY5GSWxY3hDjK2c2w7JAUffTUcdFFeJpajHn0lFik4BMRSFbdEDISapsCJA==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:a6ae:11ff:fe11:4f04])
 (user=gprocida job=sendgmr) by 2002:a05:6214:a03:: with SMTP id
 dw3mr13807575qvb.24.1611228927732; Thu, 21 Jan 2021 03:35:27 -0800 (PST)
Date:   Thu, 21 Jan 2021 11:35:19 +0000
In-Reply-To: <20210121113520.3603097-1-gprocida@google.com>
Message-Id: <20210121113520.3603097-3-gprocida@google.com>
Mime-Version: 1.0
References: <20210118160139.1971039-1-gprocida@google.com> <20210121113520.3603097-1-gprocida@google.com>
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
Subject: [PATCH dwarves v2 2/3] btf_encoder: Improve error-handling around objcopy
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org
Cc:     kernel-team@android.com, maennich@google.com, ast@kernel.org,
        andrii@kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        Giuliano Procida <gprocida@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

* Report the correct filename when objcopy fails.
* Unlink the temporary file on error.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 libbtf.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/libbtf.c b/libbtf.c
index 3709087..7552d8e 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -786,18 +786,19 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 		if (write(fd, raw_btf_data, raw_btf_size) != raw_btf_size) {
 			fprintf(stderr, "%s: write of %d bytes to '%s' failed: %d!\n",
 				__func__, raw_btf_size, tmp_fn, errno);
-			goto out;
+			goto unlink;
 		}
 
 		snprintf(cmd, sizeof(cmd), "%s --add-section .BTF=%s %s",
 			 llvm_objcopy, tmp_fn, filename);
 		if (system(cmd)) {
 			fprintf(stderr, "%s: failed to add .BTF section to '%s': %d!\n",
-				__func__, tmp_fn, errno);
-			goto out;
+				__func__, filename, errno);
+			goto unlink;
 		}
 
 		err = 0;
+	unlink:
 		unlink(tmp_fn);
 	}
 
-- 
2.30.0.296.g2bfb1c46d8-goog


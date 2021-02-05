Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAB33115D8
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 23:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbhBEWn0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Feb 2021 17:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhBENnL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Feb 2021 08:43:11 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD876C06121E
        for <bpf@vger.kernel.org>; Fri,  5 Feb 2021 05:42:43 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 134so7094145ybd.3
        for <bpf@vger.kernel.org>; Fri, 05 Feb 2021 05:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=IfrsKiM9qTPCm/mu8IvDda9E8qIyarKKAm3lIwYPM20=;
        b=kw2tnKgzpXRLq/FqFTSuKJnVTUwBFoe6uff7J2jbvTcndve02E6mDJ8rCruNugyAts
         rlS8Kvjxzr6gfSq1DDmlFxih48bdx0gJhhwGihjxmfB1Q5YxUPbFzCFxjFX2rCuhzUaw
         WNGY8moTkd6Nhlq313HeCqdYi/orDKDKiQgJo558nRTYgkCjdOOF/TRrJ7rp519idd9e
         yyS855aB5dsK2wBQl8jaqrqJvGjIsXVFrHvKdDbbw3BUW9pdT4LQ2b6iLx2m9lIA19Vq
         Gylnftm4KHwIJsQHEWQtTyI4lq4eUmQN21aLMT7Cg3D+O4KZCxipK2Z2wktGENEIZusN
         ieag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IfrsKiM9qTPCm/mu8IvDda9E8qIyarKKAm3lIwYPM20=;
        b=s3pbQ4PywhIAaZalWEktMgKzcJvxpvcySTE9YZq+D9dJFwWvWh3T2JcqvIJ6gah5/F
         ji1QPBIZORswvb/EiDxkrq2VpPtOaf5zjY0jQFXA3J+Tcb98fMX0MwRnIq9aCah0atH7
         /GNFEolVhzdw0p9YIpGIXQFu9HSSBdslMfjIOsbbVCRcZy2NHzGFmzLFo0uCCMgqyoaZ
         djR/Ch1j8MyljdUxcp13C1ZBvxp4SfvDxhyhKwQzmoarzysgmRhHCDkkt3tt5PTxwN6R
         PccPpR1D79+PSoLg5LEWaGTBmEsr3PcIq5bBZEBj0HfpYXxH22ngFZcq6BsrjwcJsvGt
         4sOA==
X-Gm-Message-State: AOAM533TMhCzgxolFuSDaq+3qvBZ/N4q+SpLw4E4DglFcYIFXe7BrKks
        +z8pG2aJl3Uu4nOVK5RXC1yU2LxwN/2CHA==
X-Google-Smtp-Source: ABdhPJyI1NCzzeWtf0SgohHDK9KQ1fbnKF8fZb+IoqC/+CQBb5mfhvDAQak9cwHQ8DFF/jncptcNKBvQNRZEkA==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:656b:9716:1ea:3de6])
 (user=gprocida job=sendgmr) by 2002:a25:3610:: with SMTP id
 d16mr6573081yba.454.1612532563011; Fri, 05 Feb 2021 05:42:43 -0800 (PST)
Date:   Fri,  5 Feb 2021 13:42:19 +0000
In-Reply-To: <20210205134221.2953163-1-gprocida@google.com>
Message-Id: <20210205134221.2953163-4-gprocida@google.com>
Mime-Version: 1.0
References: <20210201172530.1141087-1-gprocida@google.com> <20210205134221.2953163-1-gprocida@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH dwarves v3 3/5] btf_encoder: Traverse sections using a for-loop
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org
Cc:     acme@kernel.org, andrii@kernel.org, ast@kernel.org,
        gprocida@google.com, maennich@google.com, kernel-team@android.com,
        kernel-team@fb.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The pointer (iterator) scn can be made local to the loop and a more
general while-loop is not needed.

Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 libbtf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/libbtf.c b/libbtf.c
index ace8896..4ae7150 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -700,7 +700,6 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 {
 	GElf_Ehdr ehdr;
 	Elf_Data *btf_data = NULL;
-	Elf_Scn *scn = NULL;
 	Elf *elf = NULL;
 	const void *raw_btf_data;
 	uint32_t raw_btf_size;
@@ -748,7 +747,7 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 	 */
 
 	elf_getshdrstrndx(elf, &strndx);
-	while ((scn = elf_nextscn(elf, scn)) != NULL) {
+	for (Elf_Scn *scn = elf_nextscn(elf, NULL); scn; scn = elf_nextscn(elf, scn)) {
 		GElf_Shdr shdr;
 		if (!gelf_getshdr(scn, &shdr))
 			continue;
-- 
2.30.0.478.g8a0d178c01-goog


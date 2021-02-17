Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426C631D7F4
	for <lists+bpf@lfdr.de>; Wed, 17 Feb 2021 12:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhBQLJe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Feb 2021 06:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbhBQLJC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Feb 2021 06:09:02 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59F7C06178C
        for <bpf@vger.kernel.org>; Wed, 17 Feb 2021 03:08:21 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id y16so9715396qvs.12
        for <bpf@vger.kernel.org>; Wed, 17 Feb 2021 03:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=IfrsKiM9qTPCm/mu8IvDda9E8qIyarKKAm3lIwYPM20=;
        b=inbroXb8rNUuFuFw3kMiTs2hMpy6Pj1G6RKGaHjP7A9qVkb/BIEEMVUBll3DeGv+oL
         65IavyDeNsBiWjbjbiZGi3BdHZEs38HEaVioWRqUM93C00FL7UcCeQvgtoLo4yGtH+AB
         Gk+9l7rwQ1ZazlNx3ElOaBHn8hD6idoHjb+Ew5NcsfMIC53Fe3kgXP7swcrvBfw76jEQ
         +ybbbNnNjvxkYXvHUFxA5ypZt3YP4hPH+YFSMhv0HTO+l/JGwQPHeaAx8jkGGPHw+tY9
         UUSGcKK1MaUEAgfAiDddInmT0BBFGvSGvQyUfOYOj9J/cG0963g9pGCkOHU09h8GAmpY
         26OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IfrsKiM9qTPCm/mu8IvDda9E8qIyarKKAm3lIwYPM20=;
        b=KejZMJXV9zhEFirphNW3bItp9FuyqAsRcccNLBXFcOql0MgmGj4RtZAvyH7WOAlDmv
         4WFRp//D9zeaoPIq4dRHqIWeYEhrbjtV1YFkYh7Tw+EKffmcYDaBJq8VufHqV3Y97pLi
         /2PYRAvv/irodw2kDKkSuegtxvHHaEAC5SAgm43oyrMlXKfgJsfFDok+c01OjL4yoIlQ
         GXJG0QroPBJHO8uQ8/nOSPQI2wmgfT5ZdwDCgAgI56gnT6UQkzK+r4bk/D0heby8skst
         YX2cqbujVsKym5j/QLbrtP/Nlp/S46AIqy5t+VuU2NY68GZT3OAYQsj14Gok/BnM3poG
         LE8Q==
X-Gm-Message-State: AOAM531A/9aRqt89eHZY6u1xgcY90QSIyfJsoTPc/M+gMCdQYcC0LyTB
        /COR0MZ9X7y84DGxvHaWcHWpd5yGjbHjGw==
X-Google-Smtp-Source: ABdhPJxZIxtFwhvPKVtmI3xcKyLpDdQKBhyOFBS5FG4Qyf3pD4m41kvSNZBEpagTy5xgzrfoQaCwblzdYBSHPA==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:61b3:1cb2:c180:c3f])
 (user=gprocida job=sendgmr) by 2002:ad4:4e14:: with SMTP id
 dl20mr1895136qvb.51.1613560101098; Wed, 17 Feb 2021 03:08:21 -0800 (PST)
Date:   Wed, 17 Feb 2021 11:08:02 +0000
In-Reply-To: <20210217110804.75923-1-gprocida@google.com>
Message-Id: <20210217110804.75923-4-gprocida@google.com>
Mime-Version: 1.0
References: <20210205134221.2953163-1-gprocida@google.com> <20210217110804.75923-1-gprocida@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH dwarves v4 3/5] btf_encoder: Traverse sections using a for-loop
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org, acme@kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, gprocida@google.com,
        maennich@google.com, kernel-team@android.com, kernel-team@fb.com,
        bpf@vger.kernel.org
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


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A7558B502
	for <lists+bpf@lfdr.de>; Sat,  6 Aug 2022 12:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiHFKUn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Aug 2022 06:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiHFKUl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Aug 2022 06:20:41 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C5FA1A9
        for <bpf@vger.kernel.org>; Sat,  6 Aug 2022 03:20:38 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id p18so4601882plr.8
        for <bpf@vger.kernel.org>; Sat, 06 Aug 2022 03:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=9IljpOeu8eCITNJyzH+yb2lHTAMJQQU9/9KkdpLFn2g=;
        b=p0q92ZBMbQfpZZ/sffvFRaRa7aukiJS2aP7wjkiA7I0WUVa/Qhj4zaKkCiVaGlnwNl
         UtZLR/I4dQ33i3+9+6ZVrp4HlvqeTFonBFLLmOQk/lMG1rr51r+zJOZkjaNJIi1lU4nc
         6ryXLEkUUxjJXHwCkBANgpSQNVHlOdqY/SSv9s/XsijMFDkUDojWo52fBONkChwgVvKV
         kUuPOWuBFz0sNxTg6zAinstzG4/fg3kOYwu8+xZT2AKeNE/Es1RNERkOilrbeE6FhKTO
         Vl6UDbM0UH4C2uddBQe8KFURp3YVTLYbM4YC4TSZclXcc+BEpf41hyRoJHgvsEnSCIoD
         hLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=9IljpOeu8eCITNJyzH+yb2lHTAMJQQU9/9KkdpLFn2g=;
        b=j9P9aVobAxpsmyHxne1nA++IcGKBAKbidgjYhoAwYYTnhCBwsPDHSNB7mDxESxYvVt
         zpy/XRReP8kWuWzxiSmtVWRCVFR3sDHFViXKS3V1v6wPHADzlB9RO4WGfuj78Y3fTsvg
         AtNshfd7Di9YSwyHki0sMKzNJxZWMEn29HxbTWwyD9WmY5mXsR9AX/OcQNffpioU3/EQ
         7PTIGHpuq8jtRWagHFun4crrPdgrXwaMF28NZ7vqTjaAW14B+5cezzpp23PaozZb4B1o
         RcHtzhKZaKE1T4g+8mgjjuf4VjZ28YQPFh8gSJD2iMjbDXGAsEhprWcJOJYI/k+vdAwZ
         EhUQ==
X-Gm-Message-State: ACgBeo1qKPNTvovVih2vNMfoMGpvUuxj9RlEAwSy6B+YifmkTAn8ccdi
        qNn8hW+632ZqUyqy9EYliin7ubRDBhw=
X-Google-Smtp-Source: AA6agR7UUgjZ+OxLBNTH8C7I/HKxSrquDyry9pUck07xVH67P++PdSC8Fedoy3idPfJ9CErlIij9iA==
X-Received: by 2002:a17:90b:1b11:b0:1f2:2d70:70d7 with SMTP id nu17-20020a17090b1b1100b001f22d7070d7mr20221724pjb.59.1659781238151;
        Sat, 06 Aug 2022 03:20:38 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id 204-20020a6218d5000000b00528c22fbb45sm4759320pfy.141.2022.08.06.03.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 03:20:37 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org, andrii@kernel.org
Cc:     hengqi.chen@gmail.com, Goro Fuji <goro@fastly.com>
Subject: [PATCH bpf-next] libbpf: Do not require executable permission for shared libraries
Date:   Sat,  6 Aug 2022 18:20:21 +0800
Message-Id: <20220806102021.3867130-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Currently, resolve_full_path() requires executable permission for both
programs and shared libraries. This causes failures on distos like Debian
since the shared libraries are not installed executable ([0]). Let's remove
executable permission check for shared libraries.

  [0]: https://www.debian.org/doc/debian-policy/

Reported-by: Goro Fuji <goro@fastly.com>
Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/lib/bpf/libbpf.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 77e3797cf75a..f0ce7423afb8 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10666,7 +10666,7 @@ static const char *arch_specific_lib_paths(void)
 static int resolve_full_path(const char *file, char *result, size_t result_sz)
 {
 	const char *search_paths[3] = {};
-	int i;
+	int i, perm = R_OK;
 
 	if (str_has_sfx(file, ".so") || strstr(file, ".so.")) {
 		search_paths[0] = getenv("LD_LIBRARY_PATH");
@@ -10675,6 +10675,7 @@ static int resolve_full_path(const char *file, char *result, size_t result_sz)
 	} else {
 		search_paths[0] = getenv("PATH");
 		search_paths[1] = "/usr/bin:/usr/sbin";
+		perm |= X_OK;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(search_paths); i++) {
@@ -10693,8 +10694,8 @@ static int resolve_full_path(const char *file, char *result, size_t result_sz)
 			if (!seg_len)
 				continue;
 			snprintf(result, result_sz, "%.*s/%s", seg_len, s, file);
-			/* ensure it is an executable file/link */
-			if (access(result, R_OK | X_OK) < 0)
+			/* ensure it has required permissions */
+			if (access(result, perm) < 0)
 				continue;
 			pr_debug("resolved '%s' to '%s'\n", file, result);
 			return 0;
-- 
2.27.0



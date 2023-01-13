Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBFB66A197
	for <lists+bpf@lfdr.de>; Fri, 13 Jan 2023 19:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjAMSKA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 13:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjAMSJN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 13:09:13 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBC28BA9A
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 10:03:17 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id v65so6521952ioe.4
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 10:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=531BBPkt1DmHWyMU4u+I3syaYyiTCwRCCzBUbOgC11U=;
        b=A9v+HRQbLiepEx8J67+/qbI7nwSx0aT72sv8ruifGJj0sV/ePmjoVynqMgVnshZXRn
         FzBeLtfrtxLcSZq1p30YR30K1rOMorxI3lmvXV6kpgWXTLkVKJ2vsQQe4SJ9TRADeAAM
         VioFUN1T9CUN9CzxClEAFuCBRym94KMEH6vwT4X0bzdoErNAT3XXBJ0Nlx90E/pEKmHt
         SreQjSMsTm5ZwakMDnhjTXUAKDK6Gg3haZj9vTO6i8o9Iz5Pq4IhUfuKXNHryQikZEQ0
         1c2PgbJn+Q0D8mWI4SHUWtsMsjDE0GDr7hehSVJh3w3EWAajuJ1T1+POYbRgQ1cbZzs2
         71kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=531BBPkt1DmHWyMU4u+I3syaYyiTCwRCCzBUbOgC11U=;
        b=7PvFXq0mRfeydNMhqYJuPaW91PdWo7oLpGSlGNCqaUW/qZoMVG3/hUgUnGY9RrI1ze
         vw0uaSKqG6yTP/mB4Hoe/SQ45MWtnkYzfFXdPu3ci967BqHbnMHO6EkAIkKZCcUXcc7u
         1B2s35MWUZUdMd8q5CS2NMo6FLZL4YknHvG/QNXMiKlygqBOAnZtMTffDaNUs3GQHYE1
         cDqPQlMLKMjw0q3Zu9gFbAJjegMX5dZAMR/AamFtGnvbZGnfohJ6PUsxzZAwPboSbdxN
         4zZxzDjYoLt6SlE2sawzZnh55YSbeBgR97kLpA9rmQ/HiPg+X/h0ApQlwExxjV643Fio
         9VdA==
X-Gm-Message-State: AFqh2kpC6/lafbI0QXiduJMIckljt3L9pH5o4YFgtyolET6j1/5tLYK/
        xLqJVDNBYW9WWscRbVeG5weZz0y0A29GsA==
X-Google-Smtp-Source: AMrXdXvErK78eehKFRdGNLuHywneRGxtCp9CCPQeIIBmjCD/3pu0kVDYnDmD7wjsHarwypm5pKRt9Q==
X-Received: by 2002:a6b:d605:0:b0:6bb:df57:d586 with SMTP id w5-20020a6bd605000000b006bbdf57d586mr54284381ioa.0.1673632995676;
        Fri, 13 Jan 2023 10:03:15 -0800 (PST)
Received: from thinkpad.. ([207.107.159.62])
        by smtp.gmail.com with ESMTPSA id z3-20020a05663822a300b003a07b44ef09sm269138jas.67.2023.01.13.10.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 10:03:15 -0800 (PST)
From:   Roberto Valenzuela <valenzuelarober@gmail.com>
To:     andrii@kernel.org, mykolal@fb.com
Cc:     Roberto Valenzuela <valenzuelarober@gmail.com>, shuah@kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH] selftests/bpf: Fix missing space error
Date:   Fri, 13 Jan 2023 13:02:57 -0500
Message-Id: <20230113180257.39769-1-valenzuelarober@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add the missing space after 'dest' variable assignment.
This change will resolve the following checkpatch.pl
script error:

ERROR: spaces required around that '+=' (ctx:VxW)
Signed-off-by: Roberto Valenzuela <valenzuelarober@gmail.com>
---
 tools/testing/selftests/bpf/progs/test_xdp_vlan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_xdp_vlan.c b/tools/testing/selftests/bpf/progs/test_xdp_vlan.c
index 134768f6b788..cdf3c48d6cbb 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_vlan.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_vlan.c
@@ -195,7 +195,7 @@ int  xdp_prognum2(struct xdp_md *ctx)
 
 	/* Moving Ethernet header, dest overlap with src, memmove handle this */
 	dest = data;
-	dest+= VLAN_HDR_SZ;
+	dest += VLAN_HDR_SZ;
 	/*
 	 * Notice: Taking over vlan_hdr->h_vlan_encapsulated_proto, by
 	 * only moving two MAC addrs (12 bytes), not overwriting last 2 bytes
-- 
2.34.1


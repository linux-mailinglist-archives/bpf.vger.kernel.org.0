Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE8A33001F
	for <lists+bpf@lfdr.de>; Sun,  7 Mar 2021 11:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhCGKda (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 7 Mar 2021 05:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbhCGKd2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 7 Mar 2021 05:33:28 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D7CC06174A
        for <bpf@vger.kernel.org>; Sun,  7 Mar 2021 02:33:27 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id u14so8220173wri.3
        for <bpf@vger.kernel.org>; Sun, 07 Mar 2021 02:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kk4+yyzIS3gJC3x4AIFZbwm/LX1sung9S1/jftNT35I=;
        b=fJsWF6RQa81gj7UzE6rmUEpysFkm1z1cfkGb2G8Jz9fyDMnGRKvkwUo6DCyLCPLIur
         NrgVRK6qDTykcZt6/HQFd24oZyrM9lvLZs7q64ZLndJEjbEfv8YHLuZ/TUtDpx3IW5Kw
         K6xk/OrweO8QrqdnVCxoaEKXKlQw78R6mpq3kj0OIAw+NHynaTWkANia16BtwPwlWRwL
         c/ikwsiEmhjY+h5oJgKUSrrkpqhfgyX+2p9FNVw3KETNWa5mQNdXldTjFXKUubliGKeo
         tVYJ0ryxwdL8YrBpHlQM6B7s2KGFPNyiqR63RlI0pcPPS0O//fxg6weNzylFa6kTCwp2
         FPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kk4+yyzIS3gJC3x4AIFZbwm/LX1sung9S1/jftNT35I=;
        b=Ph7da3FpKSpsfpe38a+UsvovMJvd6yoB0M4dVI6FrnfayzN9qF2QkyznSrqHm3Lv39
         qwI/h32Kiv3qCdVmYEDAjbwyp3k7WK/HOYr1BwpWMm/RIASbqmtBEZFoWleWPrPEoSFZ
         q02XAUZ72kLB4/7CinXMbwPuqov8TTN9Y6NgvvLldgeDPZpLZHmLM9KUj9tucD6ZmK4W
         DUVS+nQ1FXyLNlYGSJo6JZOn7W4jbkZkVBYDElfpMmsgkmHbuGW0RHiXecZMEEqLIl0b
         xCtFbfApkJKgiFcr2KpHtVNdYoiY5HWEcczMZmih8tOBqxKRvDvN13IovFatb/G2QbDL
         PlxA==
X-Gm-Message-State: AOAM533EmRjhQ7AoTgDMpkiq+vYuBh/zXaRXOsodn3JFi4GR3AVNultE
        Cbqu5r2e0uoKWCq445klByjPXEAyymyKYfQ=
X-Google-Smtp-Source: ABdhPJxop+pXjx0Ch3rZ1z3SdhMecrwKW10GYFZxPzktSC3sQRidbHPXc46gJto/xwHG2cQHaS9FDw==
X-Received: by 2002:a5d:6989:: with SMTP id g9mr816017wru.198.1615113206123;
        Sun, 07 Mar 2021 02:33:26 -0800 (PST)
Received: from localhost.localdomain ([192.116.60.117])
        by smtp.gmail.com with ESMTPSA id c3sm12589964wrr.29.2021.03.07.02.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 02:33:25 -0800 (PST)
From:   Tal Lossos <tallossos@gmail.com>
To:     bpf@vger.kernel.org
Cc:     yhs@fb.com, kpsingh@kernel.org, gilad.reti@gmail.com,
        Tal Lossos <tallossos@gmail.com>
Subject: [PATCH bpf-next] bpf: Change inode_storage's lookup_elem return value from NULL to -EBADF.
Date:   Sun,  7 Mar 2021 12:32:24 +0200
Message-Id: <20210307103224.60366-1-tallossos@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_fd_inode_storage_lookup_elem returned NULL when getting a bad FD which caused -ENOENT in bpf_map_copy_value.
EBADF is better than ENOENT for a bad FD behaviour.

The patch was partially contributed by CyberArk Software, Inc.

Signed-off-by: Tal Lossos <tallossos@gmail.com>
---
 kernel/bpf/bpf_inode_storage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index da753721457c..0ca25e9549d8 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -109,7 +109,7 @@ static void *bpf_fd_inode_storage_lookup_elem(struct bpf_map *map, void *key)
 	fd = *(int *)key;
 	f = fget_raw(fd);
 	if (!f)
-		return NULL;
+		return -EBADF;
 
 	sdata = inode_storage_lookup(f->f_inode, map, true);
 	fput(f);
-- 
2.27.0


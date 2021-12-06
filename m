Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2266468EA5
	for <lists+bpf@lfdr.de>; Mon,  6 Dec 2021 02:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhLFBut (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Dec 2021 20:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbhLFBut (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Dec 2021 20:50:49 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29BDC061751;
        Sun,  5 Dec 2021 17:47:21 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id n26so8730581pff.3;
        Sun, 05 Dec 2021 17:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=EhVMMR+fFkIj7zGcSRQ6PecUEcAjAjCdlTv+SzMTZCM=;
        b=FfXjAsS9E9wQYs3hPSmaOqIQJWNUIVTx4jZ+8pwz/Ml8cF/Rr6Yy8A6I3cZcHET+RR
         svFtqGfZbg80OUMmLdpewS0wHclq/0mU5TW4eFkp0IvmDmzpvEV27Oj+u84IeHB8T8hK
         YK9qWskXACXvuvNHtTXwcHuHKLbf0vIovaHFLK6EgUernO6tSG9gMUZ7WbOQHz+2SMTo
         MiKilPiW02Vw+8reMsjV575/PQjrPRqgrAi2tn84qEumwmwtGTI4Y12chjMK0kJ3i9v9
         4yDQL11vhXUH9qnN2oDxfGO8/3ux+P1libvyqnDobUnROES+D6hca8FbqXF0jtuWSdzt
         bG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EhVMMR+fFkIj7zGcSRQ6PecUEcAjAjCdlTv+SzMTZCM=;
        b=u1PY6M8VqoJjzhva4mthU1OYMyW8dF6luSXotxoJaPh2uVl9Vib2OBrJpnCH6ndMxB
         aXip3gttPSIAv9vBuGWx+61Z4l3VZordhKjmkLKV8PmaRgQJBLBvTAQWv2u//tLT+8TM
         SqUKF90vvShhfE3VsOSK69PJ3XWJnXy98iVI8IGWul7b/XRwvh/10+yrQBQvlcTSDo1z
         LdRDsXa3h5KAvmUd91miClAOodHPbMeY1mDfRKrn3ZzPAHTycWZSI+g1Uk+PExr6VmoE
         VWBD+L7gzoHwc+AgUBW5J8X876FyxHpEjcgM4gNbzrSGDxOckBReQi56Ftm+62NPd7aL
         /kbQ==
X-Gm-Message-State: AOAM5339rYLbJiG+tw5VUZTFzWfwuH9tHw6EtZV3hpBSUDKDGpSMQltp
        oDrDP0yiCFmdVuafkmhco3PFMMGHt5DjUw==
X-Google-Smtp-Source: ABdhPJyxWabRiG5YSgBwY9GnobMvBp/EwEMILzisGP4oNNMuJGGcWUcjp05YrCDoRPTUhnjDK6Yj0Q==
X-Received: by 2002:a63:1554:: with SMTP id 20mr2893292pgv.617.1638755241467;
        Sun, 05 Dec 2021 17:47:21 -0800 (PST)
Received: from sd-bjpg-k14.yz02 ([103.102.200.235])
        by smtp.gmail.com with ESMTPSA id l6sm10495772pfu.129.2021.12.05.17.47.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Dec 2021 17:47:20 -0800 (PST)
From:   huangxuesen <hxseverything@gmail.com>
To:     andrii@kernel.org
Cc:     ast@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        huangxuesen <huangxuesen@kuaishou.com>
Subject: [PATCH] libbpf: Fix trivial typo
Date:   Mon,  6 Dec 2021 09:47:16 +0800
Message-Id: <1638755236-3851199-1-git-send-email-hxseverything@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: huangxuesen <huangxuesen@kuaishou.com>

Fix typo in comment from 'bpf_skeleton_map' to 'bpf_map_skeleton'
and from 'bpf_skeleton_prog' to 'bpf_prog_skeleton'.

Signed-off-by: huangxuesen <huangxuesen@kuaishou.com>
---
 tools/lib/bpf/libbpf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index c0d62dd..2fa046a9 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -1038,11 +1038,11 @@ struct bpf_object_skeleton {
 	struct bpf_object **obj;
 
 	int map_cnt;
-	int map_skel_sz; /* sizeof(struct bpf_skeleton_map) */
+	int map_skel_sz; /* sizeof(struct bpf_map_skeleton) */
 	struct bpf_map_skeleton *maps;
 
 	int prog_cnt;
-	int prog_skel_sz; /* sizeof(struct bpf_skeleton_prog) */
+	int prog_skel_sz; /* sizeof(struct bpf_prog_skeleton) */
 	struct bpf_prog_skeleton *progs;
 };
 
-- 
1.8.3.1


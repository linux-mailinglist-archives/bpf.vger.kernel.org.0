Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F30DF100FCF
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2019 01:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfKSAT7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Nov 2019 19:19:59 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:56374 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfKSAT7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Nov 2019 19:19:59 -0500
Received: by mail-pj1-f74.google.com with SMTP id 6so846694pja.23
        for <bpf@vger.kernel.org>; Mon, 18 Nov 2019 16:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=VvQgGDe+hmOgI9C/B8EM+92sDwQj4yhDGdjV423Q5zg=;
        b=aYz6/cd5U1jOehyCj/fikIRi6p8WiCTQL+oh3HLi3qqDa2r/hLN9twQdlXIxCAxAd9
         JdmNp5tL5IT1ghbfN5HsiHrlr6Xu1w+3AUXlf/dYTl1xXgELVdJXA0GooWc+C5T5at0m
         lZlIxmnim6FS+r+M1wF4Z4cvHmMkx4fu1ZwNz+f/GoBJg4JoCi9PcdIA2QRM/NygS/DI
         ecddcZ0ZmFSrpwoLCl4x7YQd4PRlOLVxIOIta0iOdLUO6K0ILKTpH/ty+NuM1ZPHgBSp
         5sn6WNdfrXwAQZFTYI6Wys7C+emme/vdIGdLIxEqYTjGCyiGH8GPMmsI9Qhw95D7PgrN
         Evbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=VvQgGDe+hmOgI9C/B8EM+92sDwQj4yhDGdjV423Q5zg=;
        b=bL02g/fguDQCgnJbx1E4pG316yunS5RUbTw9SK2kg/TpsNqM2tPnKrds4bf82wToL9
         FW8B35oYY+4lYA40E80X0XGz7ucmM+6eSB2rib4CDcI7ZQBOdJHMg7aKgpj+5RBHKRJi
         EoMKwJvPFFBpAaa4WheKNnAlIW6fNNDQd+PtI8zcufX0vmm+LaqNU9g3CmIQ12/Z+e47
         P81tZ0Dvpvpj1V4TCtNWcHKzVoh/YiZqFm53KBvD/BFTS38k8yNNLdPnOxZ9Gm64GILt
         heZvLnT7iWoxCvbW0KpdzW+9FdpzHKYc747pAVLosg/kaRQd3GEjwshto8g5RrmytKm1
         USGw==
X-Gm-Message-State: APjAAAXVE4+NHVi0Uy+mAEZr7/p8ngndmxlrrIZyAA29NGtw/bHxbUKA
        6wWuBmgA953ZzNuAWIRo6ZIYdF5zngo=
X-Google-Smtp-Source: APXvYqyhqWBjwyTEBEnIiu55yVgbyYn9icIGoCmfZtWwtVHC4gvJnfqcHVnVV+EIVPy2EXEMMWo/onBCKd4=
X-Received: by 2002:a63:b047:: with SMTP id z7mr2251683pgo.224.1574122798219;
 Mon, 18 Nov 2019 16:19:58 -0800 (PST)
Date:   Mon, 18 Nov 2019 16:19:51 -0800
Message-Id: <20191119001951.92930-1-lrizzo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v2] net-af_xdp: use correct number of channels from ethtool
From:   Luigi Rizzo <lrizzo@google.com>
To:     magnus.karlsson@intel.com, bjorn.topel@intel.com,
        jonathan.lemon@gmail.com, netdev@vger.kernel.org
Cc:     bpf@vger.kernel.org, rizzo@iet.unipi.it,
        Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Drivers use different fields to report the number of channels, so take
the maximum of all data channels (rx, tx, combined) when determining the
size of the xsk map. The current code used only 'combined' which was set
to 0 in some drivers e.g. mlx4.

Tested: compiled and run xdpsock -q 3 -r -S on mlx4
Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 tools/lib/bpf/xsk.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/xsk.c b/tools/lib/bpf/xsk.c
index 74d84f36a5b24..37921375f4d45 100644
--- a/tools/lib/bpf/xsk.c
+++ b/tools/lib/bpf/xsk.c
@@ -431,13 +431,18 @@ static int xsk_get_max_queues(struct xsk_socket *xsk)
 		goto out;
 	}
 
-	if (err || channels.max_combined == 0)
+	if (err) {
 		/* If the device says it has no channels, then all traffic
 		 * is sent to a single stream, so max queues = 1.
 		 */
 		ret = 1;
-	else
-		ret = channels.max_combined;
+	} else {
+		/* Take the max of rx, tx, combined. Drivers return
+		 * the number of channels in different ways.
+		 */
+		ret = max(channels.max_rx, channels.max_tx);
+		ret = max(ret, (int)channels.max_combined);
+	}
 
 out:
 	close(fd);
-- 
2.24.0.432.g9d3f5f5b63-goog


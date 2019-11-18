Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7364C100EFD
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2019 23:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfKRWze (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Nov 2019 17:55:34 -0500
Received: from mail-qk1-f202.google.com ([209.85.222.202]:42300 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbfKRWzd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Nov 2019 17:55:33 -0500
Received: by mail-qk1-f202.google.com with SMTP id p68so12460476qkf.9
        for <bpf@vger.kernel.org>; Mon, 18 Nov 2019 14:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=T32Rb6g2SHamfdiMAguvghJ70n8sNGBtor6Z7vA/pVE=;
        b=Xd/9mGAk975A7EnlmwTCTWXg1Ew73ijveVbvpIPTfZdKVWbTJrEGLXfcLQwx4Wn3jU
         Sets0gqPv0zrJv9/WnzaoJY+rSrqbhlVEUN5WGxujBtxABTjSEva2smGUBJFptyLCKb3
         fVGJ0xTWnhB4C2zCvcJQuLJ3pb+/1H5c5HXcZkPT2XbiaElzOEyOgGraKEFZfSiCgM8W
         T1OnLDfA1nMoOf5B9tMcbno9BKmOSarO8rH6sz547/u7rMCAf8INJnXB/QgDQvbUqlCM
         k589p5niyRXGkyXIzTqDvgRY2bZc47AvSWF7ihzGwlBmLunIZFF2AOMowwBoVb4Kq8sj
         lFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=T32Rb6g2SHamfdiMAguvghJ70n8sNGBtor6Z7vA/pVE=;
        b=hmosKFpx+fo0nPe6Bu07W85p4LtsR9fnnX5XqGOgRotL/6Bj/UMa+oEowN6g0aaeoV
         mvU0Knr3eHj3MwFh3tWt9GBvndS/riHyr4yMunMKI5KGas9ALtWPCYinCs/FSozv9qKO
         XXTWU9TP6KD+gVdJMacA4MuUOcZKa5M/BKSuKepszFX2OdDhOl1KQjB1szclRzcK5CAY
         pXqiuDI0ayeF3SHqAdjbQF5m4kzi7kfhk+hPhsB7uzorLPQR65irUL6qux3i1el5ING1
         Is2ifeIii+doKm9FEOzeqyh3yVYLD3j0XzES1olIzEiypdr1aOIAxtbBJBVzdEjIZTd4
         F5SA==
X-Gm-Message-State: APjAAAWirB2VRY5SDtm4K9L7O79MuBS/WynOhzDAi4ppL5TBFWde0tLW
        SgtceZ2zUkfwAmO2jFS39ZxH5BqnfbM=
X-Google-Smtp-Source: APXvYqzjGajv3e44C7N5V7bO1h7NEzSi6kSFeUIiJ6Lev7MjXXPlxmqfsZUQNSArrHpqBEMPgMfezJDQ33Q=
X-Received: by 2002:a0c:94fb:: with SMTP id k56mr28781169qvk.127.1574117732372;
 Mon, 18 Nov 2019 14:55:32 -0800 (PST)
Date:   Mon, 18 Nov 2019 14:55:23 -0800
Message-Id: <20191118225523.41697-1-lrizzo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH] net-af_xdp: use correct number of channels from ethtool
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
the maximum of all fields (rx, tx, other, combined) when determining the
size of the xsk map. The current code used only 'combined' which was set
to 0 in some drivers e.g. mlx4.

Tested: compiled and run xdpsock -q 3 -r -S on mlx4
Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 tools/lib/bpf/xsk.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/xsk.c b/tools/lib/bpf/xsk.c
index 74d84f36a5b24..8e12269428d08 100644
--- a/tools/lib/bpf/xsk.c
+++ b/tools/lib/bpf/xsk.c
@@ -412,6 +412,11 @@ static int xsk_load_xdp_prog(struct xsk_socket *xsk)
 	return 0;
 }
 
+static inline int max_i(int a, int b)
+{
+	return a > b ? a : b;
+}
+
 static int xsk_get_max_queues(struct xsk_socket *xsk)
 {
 	struct ethtool_channels channels = { .cmd = ETHTOOL_GCHANNELS };
@@ -431,13 +436,18 @@ static int xsk_get_max_queues(struct xsk_socket *xsk)
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
+		/* Take the max of rx, tx, other, combined. Drivers return
+		 * the number of channels in different ways.
+		 */
+		ret = max_i(max_i(channels.max_rx, channels.max_tx),
+			      max_i(channels.max_other, channels.max_combined));
+	}
 
 out:
 	close(fd);
-- 
2.24.0.432.g9d3f5f5b63-goog


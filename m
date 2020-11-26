Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1462C55E6
	for <lists+bpf@lfdr.de>; Thu, 26 Nov 2020 14:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390412AbgKZNjD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Nov 2020 08:39:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390406AbgKZNjC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Nov 2020 08:39:02 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406BDC061A04
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2020 05:39:01 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id t4so2154336wrr.12
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2020 05:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PvDQ8jiSdggfocg7QevhSStHyCThX2E8vELTACyHnVM=;
        b=hfIUxVh9cOOEk1+Xnm9Js0JYx8f+4mDVffWLE+RpCmxL0UzygV22nLn5ImHdR94WtJ
         V84dJowMWFbBc/vOV5VcNtNwABoiSipolRFrT0sotRub7aAlqP7agQXikgVrvCdA2QhE
         1XMvyzZ2DaV11usuc9FgvVwCcGCAeKOuUfuG2YhlvYZaw/Cosi3dFUAOofTHESywFkhR
         lXBStbyPFd9fMWdFbVbWSRWZUoZaIwrvHuPNfaOuddOq/VwH+UM2FYbBPeQvNclUYX3v
         bWqIk2ZR8IZOZymlbf8n4zvsR+avPkwgP+ylWMDUOng9/e7F1EqjwxWl5IwWm0RAijtc
         4L4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PvDQ8jiSdggfocg7QevhSStHyCThX2E8vELTACyHnVM=;
        b=AnlxiXg8reUMOxnTFX7GdoFvcK+SNDuv2EhYvlhWp4rUi+U0miUhEh+4fRizGrvyCu
         bpTwNxaPlUZ9amMMQ9rZUn+XBmd80StBPUlTrgN+6/LYWG5JWHovafPQjrqoOVzyAy6a
         D7Kyf5nQl9Qc+2ySibPD4o+UoePDVJKW6btR/iSA+evze+z7z0r9xcvb1lvyBQqoIRYY
         AEBraQyzc6gZBcdrcUn3UZpOxp4XPLZVEnoZMxVZqGDApw/U5lhxZ4SVDE2H8eeIU4Iy
         o2KKbPWhLUEgQL7qmcnXtI16dAfBpDyuLLXWmrxp+zOtZZl2Z+ffPk3gXMlHzS+wznPn
         pxVA==
X-Gm-Message-State: AOAM533oGuN/oo9mMbASDZ3on4EM+nkZGA0ffv8QjFWiOSPRNAEyXyHO
        zD2bVOBmevasSYBlReHev+qKNw==
X-Google-Smtp-Source: ABdhPJxxuDr0CFihwvoh9qXdvCtCohE03uRRltH7bO3tWEys9Iub2oFH9hIvPdZDltlla0WbomeVaw==
X-Received: by 2002:adf:ed12:: with SMTP id a18mr3939773wro.5.1606397940009;
        Thu, 26 Nov 2020 05:39:00 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id s133sm7035825wmf.38.2020.11.26.05.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:38:59 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        Paul Durrant <paul@xen.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH 2/8] net: xen-netback: xenbus: Demote nonconformant kernel-doc headers
Date:   Thu, 26 Nov 2020 13:38:47 +0000
Message-Id: <20201126133853.3213268-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126133853.3213268-1-lee.jones@linaro.org>
References: <20201126133853.3213268-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/xen-netback/xenbus.c:419: warning: Function parameter or member 'dev' not described in 'frontend_changed'
 drivers/net/xen-netback/xenbus.c:419: warning: Function parameter or member 'frontend_state' not described in 'frontend_changed'
 drivers/net/xen-netback/xenbus.c:1001: warning: Function parameter or member 'dev' not described in 'netback_probe'
 drivers/net/xen-netback/xenbus.c:1001: warning: Function parameter or member 'id' not described in 'netback_probe'

Cc: Wei Liu <wei.liu@kernel.org>
Cc: Paul Durrant <paul@xen.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: xen-devel@lists.xenproject.org
Cc: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/xen-netback/xenbus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/xen-netback/xenbus.c b/drivers/net/xen-netback/xenbus.c
index f1c1624cec8f5..de1b5471d929b 100644
--- a/drivers/net/xen-netback/xenbus.c
+++ b/drivers/net/xen-netback/xenbus.c
@@ -411,7 +411,7 @@ static void read_xenbus_frontend_xdp(struct backend_info *be,
 	vif->xdp_headroom = headroom;
 }
 
-/**
+/*
  * Callback received when the frontend's state changes.
  */
 static void frontend_changed(struct xenbus_device *dev,
@@ -992,7 +992,7 @@ static int netback_remove(struct xenbus_device *dev)
 	return 0;
 }
 
-/**
+/*
  * Entry point to this code when a new device is created.  Allocate the basic
  * structures and switch to InitWait.
  */
-- 
2.25.1


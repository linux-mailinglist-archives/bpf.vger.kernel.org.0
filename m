Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD69F2A6044
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 10:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgKDJJY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Nov 2020 04:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728817AbgKDJGb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Nov 2020 04:06:31 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D406AC0401C1
        for <bpf@vger.kernel.org>; Wed,  4 Nov 2020 01:06:30 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id c17so1814916wrc.11
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2020 01:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PvDQ8jiSdggfocg7QevhSStHyCThX2E8vELTACyHnVM=;
        b=O+gghJDvfp86xHKWNgfCUbwJBZer6plfg8irRb7mhXGvdo7nvbxcHUd63h6bvqOdkS
         tSUboDCoCYlt9DCY7qiK941vY9cWWcrT5dhUFhaoj+IwczKKPvBRX+IcCuLvSThGRsjC
         D58ezTytuMvEmOQY2bTv2oJzSy7M8A1Ra31v/4WhDJ/gdw2Ed9Acb+z0jHdgaSO/RfzF
         aUbBPxkvtygM9zIr6Vg1dDhySOxbbryxrnmEFSg9EURVG1o51j2usPgmkNmwHgmn7/fp
         pBtT9CLc2nU/2WTyzWyLqGfkFnDvqMLpQf/WYFc17TlKpg2vLmamvONRa7oY8mjJW1dG
         wp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PvDQ8jiSdggfocg7QevhSStHyCThX2E8vELTACyHnVM=;
        b=Lk1hbtMZe+FhNu724fMOAAFw0XDzUHaFw3AqYOkUvijLJQwXkbIJ95R2YAS6QeZOdD
         KcUfXl02iMYcKpdcKyC1Ip51lgo4tid+hGmWf/wr9RL4v6nuehU746EshUc3S7FMbGPT
         CkNqmJpj4ASORCRx42GfB4bOw3I3mlNyHfbe2z8tqQ4D5tFF+B4gjoiH72GZMpq51KNr
         ID1AwKGsL1RVOJjVZSdGnE0yw9MDHPE04H6pa3bceIhaLA6nCCMzDeIlCn8uMH3lFsov
         O/VIHKtDLv16lY4zFvELGfo8ZP2haplAx8eyty2F+scBYwv+8s/6rn9FzEh0bDcscB+B
         OkBQ==
X-Gm-Message-State: AOAM533MQHEpCpad/mSfw9t6qcptOgPeEKvukSiXrLGixHkR5qZtF4y3
        4eswTRxcXb9WolUPW+psEhjLBg==
X-Google-Smtp-Source: ABdhPJxJr4EKzyziM/kfu7bfvSRJog/0BPh5wKW3PHtRCRM2FSGZw1LpbirvmDeO5VkFIi4ChKf8FQ==
X-Received: by 2002:a5d:490a:: with SMTP id x10mr30228709wrq.289.1604480789629;
        Wed, 04 Nov 2020 01:06:29 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id e25sm1607823wrc.76.2020.11.04.01.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 01:06:29 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, Wei Liu <wei.liu@kernel.org>,
        Paul Durrant <paul@xen.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH 05/12] net: xen-netback: xenbus: Demote nonconformant kernel-doc headers
Date:   Wed,  4 Nov 2020 09:06:03 +0000
Message-Id: <20201104090610.1446616-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104090610.1446616-1-lee.jones@linaro.org>
References: <20201104090610.1446616-1-lee.jones@linaro.org>
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


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB8621BD56
	for <lists+bpf@lfdr.de>; Fri, 10 Jul 2020 21:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgGJTG1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jul 2020 15:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbgGJTFc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jul 2020 15:05:32 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A626C08C5DC
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2020 12:05:32 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 5F7F1BC070;
        Fri, 10 Jul 2020 19:04:16 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
        mchehab+huawei@kernel.org, robh@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH v2] MAINTAINERS: XDP: restrict N: and K:
Date:   Fri, 10 Jul 2020 21:04:07 +0200
Message-Id: <20200710190407.31269-1-grandmaster@al2klimov.de>
In-Reply-To: <87tuyfi4fm.fsf@toke.dk>
References: <87tuyfi4fm.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spamd-Bar: /
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Rationale:
Documentation/arm/ixp4xx.rst contains "xdp" as part of "ixdp465"
which has nothing to do with XDP.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Better?

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1d4aa7f942de..735e2475e926 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18708,8 +18708,8 @@ F:	include/trace/events/xdp.h
 F:	kernel/bpf/cpumap.c
 F:	kernel/bpf/devmap.c
 F:	net/core/xdp.c
-N:	xdp
-K:	xdp
+N:	(?:\b|_)xdp
+K:	(?:\b|_)xdp
 
 XDP SOCKETS (AF_XDP)
 M:	Björn Töpel <bjorn.topel@intel.com>
-- 
2.27.0


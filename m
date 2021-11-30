Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3494630B2
	for <lists+bpf@lfdr.de>; Tue, 30 Nov 2021 11:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240656AbhK3KMG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Nov 2021 05:12:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51916 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240638AbhK3KME (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 30 Nov 2021 05:12:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638266925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VP2wsyySLKig79PhgG1vpE6dmyB/yBoLf1Bs2JAB+/A=;
        b=ScE1IorDUUaA78p7NjkIeM7KTpk0ldWIhppo0NH6GEWghUT/x9OZjWO9Ft7S4pOllMW9OJ
        HjgtnogX+UKGZfeHmZWnircx1G6jcDSHl3J2Q/PcLqKnU6J3w0+8RJQGiUSzjUb30fdUCo
        ucHhDuDK2IWHdBA3JgxO4UlUnAtqXeU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-18-N0OujwZAO1OosMP5R-vQnw-1; Tue, 30 Nov 2021 05:08:42 -0500
X-MC-Unique: N0OujwZAO1OosMP5R-vQnw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D01C28189F9;
        Tue, 30 Nov 2021 10:08:27 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.199])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D75C145D67;
        Tue, 30 Nov 2021 10:08:19 +0000 (UTC)
From:   Paolo Abeni <pabeni@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH v3 net-next 1/2] bpf: do not WARN in bpf_warn_invalid_xdp_action()
Date:   Tue, 30 Nov 2021 11:08:06 +0100
Message-Id: <016ceec56e4817ebb2a9e35ce794d5c917df572c.1638189075.git.pabeni@redhat.com>
In-Reply-To: <cover.1638189075.git.pabeni@redhat.com>
References: <cover.1638189075.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The WARN_ONCE() in bpf_warn_invalid_xdp_action() can be triggered by
any bugged program, and even attaching a correct program to a NIC
not supporting the given action.

The resulting splat, beyond polluting the logs, fouls automated tools:
e.g. a syzkaller reproducers using an XDP program returning an
unsupported action will never pass validation.

Replace the WARN_ONCE with a less intrusive pr_warn_once().

Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/core/filter.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 8271624a19aa..5631acf3f10c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8185,9 +8185,9 @@ void bpf_warn_invalid_xdp_action(u32 act)
 {
 	const u32 act_max = XDP_REDIRECT;
 
-	WARN_ONCE(1, "%s XDP return value %u, expect packet loss!\n",
-		  act > act_max ? "Illegal" : "Driver unsupported",
-		  act);
+	pr_warn_once("%s XDP return value %u, expect packet loss!\n",
+		     act > act_max ? "Illegal" : "Driver unsupported",
+		     act);
 }
 EXPORT_SYMBOL_GPL(bpf_warn_invalid_xdp_action);
 
-- 
2.33.1


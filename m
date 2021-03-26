Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B59A34A697
	for <lists+bpf@lfdr.de>; Fri, 26 Mar 2021 12:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhCZLrj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 07:47:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54669 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229826AbhCZLrf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Mar 2021 07:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616759254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ONMwwggOPA4PUs4JSBeo1Fh+t/y79K7nhlnXHEaYcI0=;
        b=WrrjktyImPOZVJXY89TbmXtd76vrkdHgc1EL0BLZ8KWKsuH/uhxmkDNCBbV1KnCZowBsbh
        J+P6kVLmzXHIjB7y9ba93t9ub5ClMI7dvcqv5b0rcwJIU0E8R2zUuZSiJyXGTRcNCiNA/V
        FWr3NjxRfT5MGmMw0nJ0LlObgtiDrLE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513--Nn0T8xnNJ-NWOsOX4OI2A-1; Fri, 26 Mar 2021 07:47:30 -0400
X-MC-Unique: -Nn0T8xnNJ-NWOsOX4OI2A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9732010866A4;
        Fri, 26 Mar 2021 11:47:29 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-114-130.ams2.redhat.com [10.36.114.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B5A860CE9;
        Fri, 26 Mar 2021 11:47:27 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, jolsa@redhat.com,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH 2/3] bpf: selftests: test_progs/sockopt_sk: remove version
Date:   Fri, 26 Mar 2021 13:47:21 +0200
Message-Id: <20210326114722.210109-2-yauheni.kaliuta@redhat.com>
In-Reply-To: <20210326114722.210109-1-yauheni.kaliuta@redhat.com>
References: <20210326114658.210034-1-yauheni.kaliuta@redhat.com>
 <20210326114722.210109-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As pointed by Andrii Nakryiko, _version is useless now, remove it.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 tools/testing/selftests/bpf/progs/sockopt_sk.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/sockopt_sk.c b/tools/testing/selftests/bpf/progs/sockopt_sk.c
index 55dfbe53c24e..d6d03f64e2e4 100644
--- a/tools/testing/selftests/bpf/progs/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/progs/sockopt_sk.c
@@ -6,7 +6,6 @@
 #include <bpf/bpf_helpers.h>
 
 char _license[] SEC("license") = "GPL";
-__u32 _version SEC("version") = 1;
 
 int page_size; /* userspace should set it */
 
-- 
2.29.2


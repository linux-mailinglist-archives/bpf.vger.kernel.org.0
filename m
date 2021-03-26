Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9CE34A71B
	for <lists+bpf@lfdr.de>; Fri, 26 Mar 2021 13:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhCZMZN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 08:25:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45897 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229969AbhCZMYr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Mar 2021 08:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616761487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ONMwwggOPA4PUs4JSBeo1Fh+t/y79K7nhlnXHEaYcI0=;
        b=df8e3jdGNRGEetYfgbrpCTf3Qdxfn0PawtkMele+7XCLXXZl+RcBDwQEdPyAze7ILKbgBL
        tphJnN9iq3Kdd4iPTRFZQXzPFDvZK2wdTU2EC2C4lokY/PWJogOFCvChP2juL8gp+zTuCE
        2QOm4mPMwvgdYQSiktlPo6d3KgpBAKA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-GtoiApcHMZCHfWdpHtbc9g-1; Fri, 26 Mar 2021 08:24:45 -0400
X-MC-Unique: GtoiApcHMZCHfWdpHtbc9g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CD0794DC0;
        Fri, 26 Mar 2021 12:24:44 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-114-130.ams2.redhat.com [10.36.114.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F6DC5D9E3;
        Fri, 26 Mar 2021 12:24:42 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, jolsa@redhat.com,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH v2 3/4] bpf: selftests: test_progs/sockopt_sk: remove version
Date:   Fri, 26 Mar 2021 14:24:37 +0200
Message-Id: <20210326122438.211242-3-yauheni.kaliuta@redhat.com>
In-Reply-To: <20210326122438.211242-1-yauheni.kaliuta@redhat.com>
References: <20210326114658.210034-1-yauheni.kaliuta@redhat.com>
 <20210326122438.211242-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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


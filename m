Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11813357C3C
	for <lists+bpf@lfdr.de>; Thu,  8 Apr 2021 08:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhDHGO2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Apr 2021 02:14:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53592 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229936AbhDHGOZ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 8 Apr 2021 02:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617862454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lfCtnOOOaH4oxg255il0FTnmQbHOXUryUVB+jsJ/qzk=;
        b=Fpy6WSRT03XJtvYa0l1Vu1HsPqBmV9fxeLDrhaCWxDTP9lYWvNAEVF7EuTuBhxooqLdu8b
        Q6gQeOLNr5e+uGIo5DnMSehuSzMO/JlxqBJd3TQoc1Jno3yNE7VHsI+oyB82hewGsP2pGS
        xG5EPyt17P/r6msrpHnA3sLQ2w6+lYo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-spXxx_DcM7GAvd07tpf9BQ-1; Thu, 08 Apr 2021 02:14:12 -0400
X-MC-Unique: spXxx_DcM7GAvd07tpf9BQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E65B1922964;
        Thu,  8 Apr 2021 06:14:11 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-182.ams2.redhat.com [10.36.112.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 707367A3A0;
        Thu,  8 Apr 2021 06:13:12 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, jolsa@redhat.com,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH bpf-next v4 1/9] selftests/bpf: test_progs/sockopt_sk: remove version
Date:   Thu,  8 Apr 2021 09:13:02 +0300
Message-Id: <20210408061310.95877-1-yauheni.kaliuta@redhat.com>
In-Reply-To: <20210408061238.95803-1-yauheni.kaliuta@redhat.com>
References: <20210408061238.95803-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As pointed by Andrii Nakryiko, _version is useless now, remove it.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 tools/testing/selftests/bpf/progs/sockopt_sk.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/sockopt_sk.c b/tools/testing/selftests/bpf/progs/sockopt_sk.c
index d3597f81e6e9..978a68005966 100644
--- a/tools/testing/selftests/bpf/progs/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/progs/sockopt_sk.c
@@ -6,7 +6,6 @@
 #include <bpf/bpf_helpers.h>
 
 char _license[] SEC("license") = "GPL";
-__u32 _version SEC("version") = 1;
 
 #ifndef PAGE_SIZE
 #define PAGE_SIZE 4096
-- 
2.31.1


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6A53504EE
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 18:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbhCaQpq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 12:45:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41135 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232406AbhCaQpU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 31 Mar 2021 12:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617209120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lfCtnOOOaH4oxg255il0FTnmQbHOXUryUVB+jsJ/qzk=;
        b=Y1BfsGSJ+HFd4lU3sMM+z7X/bt3T/d9I4lzmelE7Ij9gLMVJ2dDmnUBEhw4RAK4i9ZbaLA
        M8S/os/OS0U7QYiQp6d4ibibk6cQUG89iNHPrpPpRQmh2fDjbM8aMgvp70ISlmHAOOWJjM
        3YS+dV4AEoJAUtZCYHesnjvAewEQclk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-ayk3e8yqNXGtqWq8cNZVhg-1; Wed, 31 Mar 2021 12:45:18 -0400
X-MC-Unique: ayk3e8yqNXGtqWq8cNZVhg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 447E61084C8C;
        Wed, 31 Mar 2021 16:45:17 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-114-48.ams2.redhat.com [10.36.114.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 31C01A8438;
        Wed, 31 Mar 2021 16:45:05 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, jolsa@redhat.com,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH bpf-next v3 1/8] selftests/bpf: test_progs/sockopt_sk: remove version
Date:   Wed, 31 Mar 2021 19:44:57 +0300
Message-Id: <20210331164504.320614-1-yauheni.kaliuta@redhat.com>
In-Reply-To: <20210331164433.320534-1-yauheni.kaliuta@redhat.com>
References: <20210331164433.320534-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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


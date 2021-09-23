Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5C5415A2A
	for <lists+bpf@lfdr.de>; Thu, 23 Sep 2021 10:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239977AbhIWImZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Sep 2021 04:42:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20310 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239825AbhIWImU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Sep 2021 04:42:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632386449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=9dF2fUEZWycIGwZ53hEpFFIfueXLgIP+J7ThTRLO4uA=;
        b=X3dGoJWXT8vpC+dJH7rvd+P6axvKWZqLM8ypkC8h85FVbo0kTN6qUP8P/hwRaYzGAe3Xvl
        nPyzJ+uE4osvhn7zKuvqoJCHJVVrf+xCcQiq6TaA/FHtkk1la/IZK+enpZ46QdmhpN2hdw
        7MehlI0BUtGZR+ZOdxWDCs2pF0wQIlc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-NDmQ4V0aOGuX1Ft4LpDTpA-1; Thu, 23 Sep 2021 04:40:47 -0400
X-MC-Unique: NDmQ4V0aOGuX1Ft4LpDTpA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A53ECC622;
        Thu, 23 Sep 2021 08:40:46 +0000 (UTC)
Received: from griffin.upir.cz (unknown [10.40.194.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94FD860BF4;
        Thu, 23 Sep 2021 08:40:44 +0000 (UTC)
From:   Jiri Benc <jbenc@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Peter Oskolkov <posk@google.com>, netdev@vger.kernel.org
Subject: [PATCH bpf] selftests: bpf: test_lwt_ip_encap: really disable rp_filter
Date:   Thu, 23 Sep 2021 10:40:22 +0200
Message-Id: <b1cdd9d469f09ea6e01e9c89a6071c79b7380f89.1632386362.git.jbenc@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It's not enough to set net.ipv4.conf.all.rp_filter=0, that does not override
a greater rp_filter value on the individual interfaces. We also need to set
net.ipv4.conf.default.rp_filter=0 before creating the interfaces. That way,
they'll also get their own rp_filter value of zero.

Fixes: 0fde56e4385b0 ("selftests: bpf: add test_lwt_ip_encap selftest")
Signed-off-by: Jiri Benc <jbenc@redhat.com>
---
 tools/testing/selftests/bpf/test_lwt_ip_encap.sh | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_lwt_ip_encap.sh b/tools/testing/selftests/bpf/test_lwt_ip_encap.sh
index 59ea56945e6c..b497bb85b667 100755
--- a/tools/testing/selftests/bpf/test_lwt_ip_encap.sh
+++ b/tools/testing/selftests/bpf/test_lwt_ip_encap.sh
@@ -112,6 +112,14 @@ setup()
 	ip netns add "${NS2}"
 	ip netns add "${NS3}"
 
+	# rp_filter gets confused by what these tests are doing, so disable it
+	ip netns exec ${NS1} sysctl -wq net.ipv4.conf.all.rp_filter=0
+	ip netns exec ${NS2} sysctl -wq net.ipv4.conf.all.rp_filter=0
+	ip netns exec ${NS3} sysctl -wq net.ipv4.conf.all.rp_filter=0
+	ip netns exec ${NS1} sysctl -wq net.ipv4.conf.default.rp_filter=0
+	ip netns exec ${NS2} sysctl -wq net.ipv4.conf.default.rp_filter=0
+	ip netns exec ${NS3} sysctl -wq net.ipv4.conf.default.rp_filter=0
+
 	ip link add veth1 type veth peer name veth2
 	ip link add veth3 type veth peer name veth4
 	ip link add veth5 type veth peer name veth6
@@ -236,11 +244,6 @@ setup()
 	ip -netns ${NS1} -6 route add ${IPv6_GRE}/128 dev veth5 via ${IPv6_6} ${VRF}
 	ip -netns ${NS2} -6 route add ${IPv6_GRE}/128 dev veth7 via ${IPv6_8} ${VRF}
 
-	# rp_filter gets confused by what these tests are doing, so disable it
-	ip netns exec ${NS1} sysctl -wq net.ipv4.conf.all.rp_filter=0
-	ip netns exec ${NS2} sysctl -wq net.ipv4.conf.all.rp_filter=0
-	ip netns exec ${NS3} sysctl -wq net.ipv4.conf.all.rp_filter=0
-
 	TMPFILE=$(mktemp /tmp/test_lwt_ip_encap.XXXXXX)
 
 	sleep 1  # reduce flakiness
-- 
2.18.1


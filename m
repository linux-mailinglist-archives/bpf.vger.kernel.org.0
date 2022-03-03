Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00FB4CBC40
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 12:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbiCCLQt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Mar 2022 06:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbiCCLQs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Mar 2022 06:16:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C1D41688DF
        for <bpf@vger.kernel.org>; Thu,  3 Mar 2022 03:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646306162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EknSs7fBWtKFNuwWY8m+meGhqQWXD74hmXRaXtGZvUw=;
        b=XiFUuumfOkM+nu5rAClKRH0d99LtamBJndadiYtV0Oz6yMZzBkrfba1LG8Wt4edFSQZlLj
        lcZHNNcRw77vTH/ZHSak/nkIcR/LzMimhTOydV4E3xHqyRUkaZ2szp2bvmvlQm6C/o9LLs
        UxS6l99qpRVU3JN5A91DoKcohXsxvGQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-190-ZPctQ_T4NCuhtt93trTvmA-1; Thu, 03 Mar 2022 06:15:59 -0500
X-MC-Unique: ZPctQ_T4NCuhtt93trTvmA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 446E21006AA5;
        Thu,  3 Mar 2022 11:15:57 +0000 (UTC)
Received: from thinkpad.fritz.box (unknown [10.40.193.220])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E1CA883062;
        Thu,  3 Mar 2022 11:15:54 +0000 (UTC)
From:   Felix Maurer <fmaurer@redhat.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, posk@google.com
Subject: [PATCH bpf-next] selftests: bpf: Make test_lwt_ip_encap more stable and faster
Date:   Thu,  3 Mar 2022 12:15:26 +0100
Message-Id: <4987d549d48b4e316cd5b3936de69c8d4bc75a4f.1646305899.git.fmaurer@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In test_lwt_ip_encap, the ingress IPv6 encap test failed from time to
time. The failure occured when an IPv4 ping through the IPv6 GRE
encapsulation did not receive a reply within the timeout. The IPv4 ping
and the IPv6 ping in the test used different timeouts (1 sec for IPv4
and 6 sec for IPv6), probably taking into account that IPv6 might need
longer to successfully complete. However, when IPv4 pings (with the
short timeout) are encapsulated into the IPv6 tunnel, the delays of IPv6
apply.

The actual reason for the long delays with IPv6 was that the IPv6
neighbor discovery sometimes did not complete in time. This was caused
by the outgoing interface only having a tentative link local address,
i.e., not having completed DAD for that lladdr. The ND was successfully
retried after 1 sec but that was too late for the ping timeout.

The IPv6 addresses for the test were already added with nodad. However,
for the lladdrs, DAD was still performed. We now disable DAD in the test
netns completely and just assume that the two lladdrs on each veth pair
do not collide. This removes all the delays for IPv6 traffic in the
test.

Without the delays, we can now also reduce the delay of the IPv6 ping to
1 sec. This makes the whole test complete faster because we don't need
to wait for the excessive timeout for each IPv6 ping that is supposed
to fail.

Fixes: 0fde56e4385b0 ("selftests: bpf: add test_lwt_ip_encap selftest")
Signed-off-by: Felix Maurer <fmaurer@redhat.com>
---
 tools/testing/selftests/bpf/test_lwt_ip_encap.sh | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_lwt_ip_encap.sh b/tools/testing/selftests/bpf/test_lwt_ip_encap.sh
index b497bb85b667..6c69c42b1d60 100755
--- a/tools/testing/selftests/bpf/test_lwt_ip_encap.sh
+++ b/tools/testing/selftests/bpf/test_lwt_ip_encap.sh
@@ -120,6 +120,14 @@ setup()
 	ip netns exec ${NS2} sysctl -wq net.ipv4.conf.default.rp_filter=0
 	ip netns exec ${NS3} sysctl -wq net.ipv4.conf.default.rp_filter=0
 
+	# disable IPv6 DAD because it sometimes takes too long and fails tests
+	ip netns exec ${NS1} sysctl -wq net.ipv6.conf.all.accept_dad=0
+	ip netns exec ${NS2} sysctl -wq net.ipv6.conf.all.accept_dad=0
+	ip netns exec ${NS3} sysctl -wq net.ipv6.conf.all.accept_dad=0
+	ip netns exec ${NS1} sysctl -wq net.ipv6.conf.default.accept_dad=0
+	ip netns exec ${NS2} sysctl -wq net.ipv6.conf.default.accept_dad=0
+	ip netns exec ${NS3} sysctl -wq net.ipv6.conf.default.accept_dad=0
+
 	ip link add veth1 type veth peer name veth2
 	ip link add veth3 type veth peer name veth4
 	ip link add veth5 type veth peer name veth6
@@ -289,7 +297,7 @@ test_ping()
 		ip netns exec ${NS1} ping  -c 1 -W 1 -I veth1 ${IPv4_DST} 2>&1 > /dev/null
 		RET=$?
 	elif [ "${PROTO}" == "IPv6" ] ; then
-		ip netns exec ${NS1} ping6 -c 1 -W 6 -I veth1 ${IPv6_DST} 2>&1 > /dev/null
+		ip netns exec ${NS1} ping6 -c 1 -W 1 -I veth1 ${IPv6_DST} 2>&1 > /dev/null
 		RET=$?
 	else
 		echo "    test_ping: unknown PROTO: ${PROTO}"
-- 
2.34.1


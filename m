Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559DF4055E6
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 15:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356423AbhIINO1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 09:14:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:54044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357955AbhIINFn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Sep 2021 09:05:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBECA632A6;
        Thu,  9 Sep 2021 12:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631188822;
        bh=WwdYoU+YKR2WTEntQqahmsMrosrnyHurpKyhtKXYdh4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HpRMtWpT2g3tlP7eFF6WaOSHWZkhgkVEgamYgQo7Ek/huNjVsyX96+YXV7DtZLADv
         sZoWP87aXuf+wEQqMHNtoTcBCR+Kl5F0kIqxR9V7Hwwt4XZJD0jTNaPgQvC97NGmD7
         S58U9dVmleih+eoodtOe30UE0umFQV4hW0MMZGLNPSEXngcX1Sylvu+WPya5AL2yUN
         wpyRFDGFsLDn6+ydD3x4jK/HRDeTUAvza00sZlCFr5ndZuMig7Wa0214MOjrgykk9e
         i1RMqcl1L7DgMtcVRIi7OpM2HLxNrop6ErWlWtfoXkgGXFxwIPfwlGv87AC8EElmsG
         g2LjVDjBP6yvQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yajun Deng <yajun.deng@linux.dev>, Yonghong Song <yhs@fb.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 05/48] netlink: Deal with ESRCH error in nlmsg_notify()
Date:   Thu,  9 Sep 2021 07:59:32 -0400
Message-Id: <20210909120015.150411-5-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210909120015.150411-1-sashal@kernel.org>
References: <20210909120015.150411-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yajun Deng <yajun.deng@linux.dev>

[ Upstream commit fef773fc8110d8124c73a5e6610f89e52814637d ]

Yonghong Song report:
The bpf selftest tc_bpf failed with latest bpf-next.
The following is the command to run and the result:
$ ./test_progs -n 132
[   40.947571] bpf_testmod: loading out-of-tree module taints kernel.
test_tc_bpf:PASS:test_tc_bpf__open_and_load 0 nsec
test_tc_bpf:PASS:bpf_tc_hook_create(BPF_TC_INGRESS) 0 nsec
test_tc_bpf:PASS:bpf_tc_hook_create invalid hook.attach_point 0 nsec
test_tc_bpf_basic:PASS:bpf_obj_get_info_by_fd 0 nsec
test_tc_bpf_basic:PASS:bpf_tc_attach 0 nsec
test_tc_bpf_basic:PASS:handle set 0 nsec
test_tc_bpf_basic:PASS:priority set 0 nsec
test_tc_bpf_basic:PASS:prog_id set 0 nsec
test_tc_bpf_basic:PASS:bpf_tc_attach replace mode 0 nsec
test_tc_bpf_basic:PASS:bpf_tc_query 0 nsec
test_tc_bpf_basic:PASS:handle set 0 nsec
test_tc_bpf_basic:PASS:priority set 0 nsec
test_tc_bpf_basic:PASS:prog_id set 0 nsec
libbpf: Kernel error message: Failed to send filter delete notification
test_tc_bpf_basic:FAIL:bpf_tc_detach unexpected error: -3 (errno 3)
test_tc_bpf:FAIL:test_tc_internal ingress unexpected error: -3 (errno 3)

The failure seems due to the commit
    cfdf0d9ae75b ("rtnetlink: use nlmsg_notify() in rtnetlink_send()")

Deal with ESRCH error in nlmsg_notify() even the report variable is zero.

Reported-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
Link: https://lore.kernel.org/r/20210719051816.11762-1-yajun.deng@linux.dev
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netlink/af_netlink.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 541410f1c3b7..453b0efdc0d7 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2409,13 +2409,15 @@ int nlmsg_notify(struct sock *sk, struct sk_buff *skb, u32 portid,
 		/* errors reported via destination sk->sk_err, but propagate
 		 * delivery errors if NETLINK_BROADCAST_ERROR flag is set */
 		err = nlmsg_multicast(sk, skb, exclude_portid, group, flags);
+		if (err == -ESRCH)
+			err = 0;
 	}
 
 	if (report) {
 		int err2;
 
 		err2 = nlmsg_unicast(sk, skb, portid);
-		if (!err || err == -ESRCH)
+		if (!err)
 			err = err2;
 	}
 
-- 
2.30.2


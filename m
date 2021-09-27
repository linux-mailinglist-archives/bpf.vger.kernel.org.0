Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1B141946B
	for <lists+bpf@lfdr.de>; Mon, 27 Sep 2021 14:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbhI0MlO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Sep 2021 08:41:14 -0400
Received: from www62.your-server.de ([213.133.104.62]:38768 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbhI0MlK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Sep 2021 08:41:10 -0400
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mUpuq-000Giw-Ov; Mon, 27 Sep 2021 14:39:28 +0200
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     alexei.starovoitov@gmail.com
Cc:     andrii@kernel.org, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        syzbot+664b58e9a40fbb2cec71@syzkaller.appspotmail.com,
        syzbot+33f36d0754d4c5c0e102@syzkaller.appspotmail.com,
        Stanislav Fomichev <sdf@google.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH bpf v2 2/2] bpf, test, cgroup: Use sk_{alloc,free} for test cases
Date:   Mon, 27 Sep 2021 14:39:21 +0200
Message-Id: <20210927123921.21535-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210927123921.21535-1-daniel@iogearbox.net>
References: <20210927123921.21535-1-daniel@iogearbox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.3/26305/Mon Sep 27 11:04:42 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF test infra has some hacks in place which kzalloc() a socket and perform
minimum init via sock_net_set() and sock_init_data(). As a result, the sk's
skcd->cgroup is NULL since it didn't go through proper initialization as it
would have been the case from sk_alloc(). Rather than re-adding a NULL test
in sock_cgroup_ptr() just for this, use sk_{alloc,free}() pair for the test
socket. The latter also allows to get rid of the bpf_sk_storage_free() special
case.

Fixes: 8520e224f547 ("bpf, cgroups: Fix cgroup v2 fallback on v1/v2 mixed mode")
Fixes: b7a1848e8398 ("bpf: add BPF_PROG_TEST_RUN support for flow dissector")
Fixes: 2cb494a36c98 ("bpf: add tests for direct packet access from CGROUP_SKB")
Reported-by: syzbot+664b58e9a40fbb2cec71@syzkaller.appspotmail.com
Reported-by: syzbot+33f36d0754d4c5c0e102@syzkaller.appspotmail.com
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Tested-by: syzbot+664b58e9a40fbb2cec71@syzkaller.appspotmail.com
Tested-by: syzbot+33f36d0754d4c5c0e102@syzkaller.appspotmail.com
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Song Liu <songliubraving@fb.com>
---
 net/bpf/test_run.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 2eb0e55ef54d..b5f4ef35357c 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -552,6 +552,12 @@ static void convert_skb_to___skb(struct sk_buff *skb, struct __sk_buff *__skb)
 	__skb->gso_segs = skb_shinfo(skb)->gso_segs;
 }
 
+static struct proto bpf_dummy_proto = {
+	.name   = "bpf_dummy",
+	.owner  = THIS_MODULE,
+	.obj_size = sizeof(struct sock),
+};
+
 int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 			  union bpf_attr __user *uattr)
 {
@@ -596,20 +602,19 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 		break;
 	}
 
-	sk = kzalloc(sizeof(struct sock), GFP_USER);
+	sk = sk_alloc(net, AF_UNSPEC, GFP_USER, &bpf_dummy_proto, 1);
 	if (!sk) {
 		kfree(data);
 		kfree(ctx);
 		return -ENOMEM;
 	}
-	sock_net_set(sk, net);
 	sock_init_data(NULL, sk);
 
 	skb = build_skb(data, 0);
 	if (!skb) {
 		kfree(data);
 		kfree(ctx);
-		kfree(sk);
+		sk_free(sk);
 		return -ENOMEM;
 	}
 	skb->sk = sk;
@@ -682,8 +687,7 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	if (dev && dev != net->loopback_dev)
 		dev_put(dev);
 	kfree_skb(skb);
-	bpf_sk_storage_free(sk);
-	kfree(sk);
+	sk_free(sk);
 	kfree(ctx);
 	return ret;
 }
-- 
2.27.0


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F673F2FDB
	for <lists+bpf@lfdr.de>; Fri, 20 Aug 2021 17:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241392AbhHTPo0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Aug 2021 11:44:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241250AbhHTPoR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Aug 2021 11:44:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50AD661102;
        Fri, 20 Aug 2021 15:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629474219;
        bh=YfA+tOkdL/QPwzZz/TpWFF/d4EvIqgCG0FJgSj26TqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sFmwhjo/J9dL/ifp6s8mveuNeDUf/tkwGHqCpBHB81v5qPx908oBygpF/h2UvZjrk
         Kij159tLSMN+tRov4LUOn3KpLxMRMQ5FHhRPAsDeUOiuqs3wXPeZtiG6AsgCfTCBq+
         w0y1bHXQypI9rRKrsUz9rFRw6iXVBdsTA5CLTttS8eWj8y0ghAg/KVFn7dWngM6WJl
         QFBN302xY+dj72xrJ6ZJPjnXFjJiZ7deRPvnBcBvJxguBhsVT4MikINyOUWGrn3pmW
         A+fVTX3Rqobp2iTdQvVlHT4NtzTe/kxFv+K6ol3M4qs7gzPsogxR57/rcTM02Ctxm9
         m4Th6R8Plcm8Q==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, shayagr@amazon.com,
        john.fastabend@gmail.com, dsahern@kernel.org, brouer@redhat.com,
        echaudro@redhat.com, jasowang@redhat.com,
        alexander.duyck@gmail.com, saeed@kernel.org,
        maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
        tirthendu.sarkar@intel.com, toke@redhat.com
Subject: [PATCH v12 bpf-next 15/18] bpf: test_run: add xdp_shared_info pointer in bpf_test_finish signature
Date:   Fri, 20 Aug 2021 17:40:28 +0200
Message-Id: <98d3c6b3d93c7923f938a97d3f26daa68192eec3.1629473234.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629473233.git.lorenzo@kernel.org>
References: <cover.1629473233.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

introduce xdp_shared_info pointer in bpf_test_finish signature in order
to copy back paged data from a xdp multi-buff frame to userspace buffer

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 net/bpf/test_run.c | 48 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 2173dba0742f..869dcf23a1ca 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -129,7 +129,8 @@ static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat,
 
 static int bpf_test_finish(const union bpf_attr *kattr,
 			   union bpf_attr __user *uattr, const void *data,
-			   u32 size, u32 retval, u32 duration)
+			   struct skb_shared_info *sinfo, u32 size,
+			   u32 retval, u32 duration)
 {
 	void __user *data_out = u64_to_user_ptr(kattr->test.data_out);
 	int err = -EFAULT;
@@ -144,8 +145,36 @@ static int bpf_test_finish(const union bpf_attr *kattr,
 		err = -ENOSPC;
 	}
 
-	if (data_out && copy_to_user(data_out, data, copy_size))
-		goto out;
+	if (data_out) {
+		int len = sinfo ? copy_size - sinfo->xdp_frags_size : copy_size;
+
+		if (copy_to_user(data_out, data, len))
+			goto out;
+
+		if (sinfo) {
+			int i, offset = len, data_len;
+
+			for (i = 0; i < sinfo->nr_frags; i++) {
+				skb_frag_t *frag = &sinfo->frags[i];
+
+				if (offset >= copy_size) {
+					err = -ENOSPC;
+					break;
+				}
+
+				data_len = min_t(int, copy_size - offset,
+						 skb_frag_size(frag));
+
+				if (copy_to_user(data_out + offset,
+						 skb_frag_address(frag),
+						 data_len))
+					goto out;
+
+				offset += data_len;
+			}
+		}
+	}
+
 	if (copy_to_user(&uattr->test.data_size_out, &size, sizeof(size)))
 		goto out;
 	if (copy_to_user(&uattr->test.retval, &retval, sizeof(retval)))
@@ -674,7 +703,8 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	/* bpf program can never convert linear skb to non-linear */
 	if (WARN_ON_ONCE(skb_is_nonlinear(skb)))
 		size = skb_headlen(skb);
-	ret = bpf_test_finish(kattr, uattr, skb->data, size, retval, duration);
+	ret = bpf_test_finish(kattr, uattr, skb->data, NULL, size, retval,
+			      duration);
 	if (!ret)
 		ret = bpf_ctx_finish(kattr, uattr, ctx,
 				     sizeof(struct __sk_buff));
@@ -842,8 +872,8 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 		goto out;
 
 	size = xdp.data_end - xdp.data_meta + sinfo->xdp_frags_size;
-	ret = bpf_test_finish(kattr, uattr, xdp.data_meta, size, retval,
-			      duration);
+	ret = bpf_test_finish(kattr, uattr, xdp.data_meta, sinfo, size,
+			      retval, duration);
 	if (!ret)
 		ret = bpf_ctx_finish(kattr, uattr, ctx,
 				     sizeof(struct xdp_md));
@@ -934,8 +964,8 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 	if (ret < 0)
 		goto out;
 
-	ret = bpf_test_finish(kattr, uattr, &flow_keys, sizeof(flow_keys),
-			      retval, duration);
+	ret = bpf_test_finish(kattr, uattr, &flow_keys, NULL,
+			      sizeof(flow_keys), retval, duration);
 	if (!ret)
 		ret = bpf_ctx_finish(kattr, uattr, user_ctx,
 				     sizeof(struct bpf_flow_keys));
@@ -1039,7 +1069,7 @@ int bpf_prog_test_run_sk_lookup(struct bpf_prog *prog, const union bpf_attr *kat
 		user_ctx->cookie = sock_gen_cookie(ctx.selected_sk);
 	}
 
-	ret = bpf_test_finish(kattr, uattr, NULL, 0, retval, duration);
+	ret = bpf_test_finish(kattr, uattr, NULL, NULL, 0, retval, duration);
 	if (!ret)
 		ret = bpf_ctx_finish(kattr, uattr, user_ctx, sizeof(*user_ctx));
 
-- 
2.31.1


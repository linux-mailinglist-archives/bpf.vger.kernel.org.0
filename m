Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90CC53583D6
	for <lists+bpf@lfdr.de>; Thu,  8 Apr 2021 14:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbhDHMwm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Apr 2021 08:52:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231715AbhDHMwb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Apr 2021 08:52:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9DAB610FC;
        Thu,  8 Apr 2021 12:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617886340;
        bh=GJ/Gc5WgCUZBKk9WOaKkWbMlJw+xIWKy2//BUCEEa0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cyF1V0w5q8gmySuIf8clT+gQOalIg+Vscej234uQI4E0f41RNCdegqfqo8b2irnc9
         Z9nbaQ6/Lpv9ZMooKsu+KpzxcZBm98BNEW0QyKOWKBkvA8oBgWLDkcBNUMKzU3f0Oo
         WvpgD+Up+Q87AgWOUCPfZT7T1zYworPuzrjS67XRZp0AQN/TWEtjzwC1BVQxxi0JPz
         lZgXY48vN086Q1ksfBF5MQwH1FCNfBpR8bdgb44WzQlzt3OA3bzV14KHSZlZS70H3G
         wg4XgecmWcOPIxo38lIVcd0XrjRq/4lixHh5lREhQFmtBJAimBewYDK4Rer3Zzw3Dz
         lNVbA1X5AmS1w==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, shayagr@amazon.com,
        sameehj@amazon.com, john.fastabend@gmail.com, dsahern@kernel.org,
        brouer@redhat.com, echaudro@redhat.com, jasowang@redhat.com,
        alexander.duyck@gmail.com, saeed@kernel.org,
        maciej.fijalkowski@intel.com
Subject: [PATCH v8 bpf-next 13/14] bpf: test_run: add xdp_shared_info pointer in bpf_test_finish signature
Date:   Thu,  8 Apr 2021 14:51:05 +0200
Message-Id: <152d8d49b9cee26b78afedcace6c2336fc79406c.1617885385.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617885385.git.lorenzo@kernel.org>
References: <cover.1617885385.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

introduce xdp_shared_info pointer in bpf_test_finish signature in order
to copy back paged data from a xdp multi-buff frame to userspace buffer

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 net/bpf/test_run.c | 48 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index bb953b2e6501..65c944ebc2da 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -128,7 +128,8 @@ static int bpf_test_run(struct bpf_prog *prog, void *ctx, u32 repeat,
 
 static int bpf_test_finish(const union bpf_attr *kattr,
 			   union bpf_attr __user *uattr, const void *data,
-			   u32 size, u32 retval, u32 duration)
+			   struct xdp_shared_info *xdp_sinfo, u32 size,
+			   u32 retval, u32 duration)
 {
 	void __user *data_out = u64_to_user_ptr(kattr->test.data_out);
 	int err = -EFAULT;
@@ -143,8 +144,37 @@ static int bpf_test_finish(const union bpf_attr *kattr,
 		err = -ENOSPC;
 	}
 
-	if (data_out && copy_to_user(data_out, data, copy_size))
-		goto out;
+	if (data_out) {
+		int len = xdp_sinfo ? copy_size - xdp_sinfo->data_length
+				    : copy_size;
+
+		if (copy_to_user(data_out, data, len))
+			goto out;
+
+		if (xdp_sinfo) {
+			int i, offset = len, data_len;
+
+			for (i = 0; i < xdp_sinfo->nr_frags; i++) {
+				skb_frag_t *frag = &xdp_sinfo->frags[i];
+
+				if (offset >= copy_size) {
+					err = -ENOSPC;
+					break;
+				}
+
+				data_len = min_t(int, copy_size - offset,
+						 xdp_get_frag_size(frag));
+
+				if (copy_to_user(data_out + offset,
+						 xdp_get_frag_address(frag),
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
@@ -673,7 +703,8 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	/* bpf program can never convert linear skb to non-linear */
 	if (WARN_ON_ONCE(skb_is_nonlinear(skb)))
 		size = skb_headlen(skb);
-	ret = bpf_test_finish(kattr, uattr, skb->data, size, retval, duration);
+	ret = bpf_test_finish(kattr, uattr, skb->data, NULL, size, retval,
+			      duration);
 	if (!ret)
 		ret = bpf_ctx_finish(kattr, uattr, ctx,
 				     sizeof(struct __sk_buff));
@@ -755,7 +786,8 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 		goto out;
 
 	size = xdp.data_end - xdp.data + xdp_sinfo->data_length;
-	ret = bpf_test_finish(kattr, uattr, xdp.data, size, retval, duration);
+	ret = bpf_test_finish(kattr, uattr, xdp.data, xdp_sinfo, size, retval,
+			      duration);
 
 out:
 	bpf_prog_change_xdp(prog, NULL);
@@ -841,8 +873,8 @@ int bpf_prog_test_run_flow_dissector(struct bpf_prog *prog,
 	if (ret < 0)
 		goto out;
 
-	ret = bpf_test_finish(kattr, uattr, &flow_keys, sizeof(flow_keys),
-			      retval, duration);
+	ret = bpf_test_finish(kattr, uattr, &flow_keys, NULL,
+			      sizeof(flow_keys), retval, duration);
 	if (!ret)
 		ret = bpf_ctx_finish(kattr, uattr, user_ctx,
 				     sizeof(struct bpf_flow_keys));
@@ -946,7 +978,7 @@ int bpf_prog_test_run_sk_lookup(struct bpf_prog *prog, const union bpf_attr *kat
 		user_ctx->cookie = sock_gen_cookie(ctx.selected_sk);
 	}
 
-	ret = bpf_test_finish(kattr, uattr, NULL, 0, retval, duration);
+	ret = bpf_test_finish(kattr, uattr, NULL, NULL, 0, retval, duration);
 	if (!ret)
 		ret = bpf_ctx_finish(kattr, uattr, user_ctx, sizeof(*user_ctx));
 
-- 
2.30.2


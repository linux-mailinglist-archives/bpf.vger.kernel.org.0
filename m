Return-Path: <bpf+bounces-51211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9CEA31E91
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 07:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09DCE188A42D
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 06:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F88C1FC102;
	Wed, 12 Feb 2025 06:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z15EPbjV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2148E1FBEBE;
	Wed, 12 Feb 2025 06:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341169; cv=none; b=h5uX9S0klD/N54DNLvlq2yUx4wT51xwrI1Zy7P24aw8YhUhPplHV+3AJnJ/d40Gxbpe54Uh7vHMRvAfR3rMw1SLuu+mJirHbG5xEcL3vyFiHZXGpHG4h9zcc7IqoZnceW1ykEDI2DW+xqL9hnXx64lcjZYqQMaIMy/WO94GQoSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341169; c=relaxed/simple;
	bh=3f4fr3wEVqOkIsOc+1STd0Ns5iBgLGFkFca2uJbMweM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q7wXefFyxPIQUq2ZOMkBS/jFMrOjleezJvgpSj8xLDiuswCdizKTi38Fn7fNb4nU3rzQ5XCiyIH6aKcbBhxJk5x7xlbNZa2f1zTWc5om3qibzctWJEcysW3kyD1lvI8rP0xTIcKnDszHfcYAP3xBac/d6kNLApzxkLvC0HS8rR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z15EPbjV; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f6a47d617so68087835ad.2;
        Tue, 11 Feb 2025 22:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739341167; x=1739945967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jcgdad4TkftRTh1q65WudnE3mEROlme3+Pzdel+ZVs=;
        b=Z15EPbjV9SgoWxdzXWt3W6SZqkXF5DLs/lqGVSL5Bpa3GHg05MiNyEIfFQ4zgHN8vM
         /G80sHKr3VrZ7hsSByCslX55s74aIx0od9CxXNISXlPoFtri//qs6CPctdsVfjloikvA
         6ytD/nDC7JOHIcznoYKFu/mh61UymE353aJFtI+5c74gzN6xneBEzVbHxRHIfukUqe5t
         c94s/vz91oXRA+ezb8VJYL3YYsfuzqV0zRnQs1SAJFYJbqV9VvrnoUc7Q+JFmb9n0JkC
         BKIwSAqjLqjmPNp0t0OnIWSpiEG54kJTMurdl+IyLWZaa5Y2ZZLn7OLwi5KBGCqljoy0
         51oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739341167; x=1739945967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/jcgdad4TkftRTh1q65WudnE3mEROlme3+Pzdel+ZVs=;
        b=CL434Wm3Fj9HVkGXgYH7X3tnlj6BRNuaiRlFxFtQV6uTIkqPmvi4VEcIbdHaMkVQa6
         29ANnPvygcKYHzjNXBqR8qf7wYzkEoCe/Jdy0md/Rlx1d6fDf6NfHkzHLXlQrvp7Ivjc
         PJZOrxFr9L5X7W9yiz4rxzPJ5aprnU4ATVbV9S9Gdwi8Kr8jR1Rc1ERiugUNR0+11/dO
         aewkdt4fq+OkPgaY7ypllnqoRdColDiDAbg6pdEtD4UhVlfmAU2ohi/j+wMMW9/3Uto7
         HNrn/ADtYzmRLCzoDESqUSW8/GdG+I1yOxyCI8KKSHWPQxo2GI3XmMxCEk3YSOFMnQYm
         8bnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU99JEDjWluWkfbcqYoB/Qltyygvz+8MucQfjRptDn0kLvJXn8bje5k4wwyCLAgEYATRWWYdGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgsaPgBKTcnix4v1DjxPCG7wmGMXqcC28lFyW02hSUwkX++tTP
	1xCve54lfi/9LLDaH9iYaXwCmvLFoD9t81PVP923xnWaZDG5EMIv
X-Gm-Gg: ASbGncsqdzaVRBu7NdvqPs+r0YJX3vQqQ8WWEszamAb4zw+unyMqcHywhA86ogBUFl2
	tJTAa5bVwSSjqanUPeuzuJdrPBujFI8cBEru3htfm5G2hyqZ3o5VOdCzvfTjWGQg53lCo8avqQA
	NQQGW1Ez98tNYZYqjtMMp08FSeY6sU0LMuZcQ/VPhx3maoKw58LO9AQIrLIWZewC0O+5J/klFFK
	WOHeUDMNiIYHDeEL5i/NP+34yeCbIfvHBoPvBkgQ+GrlT7k5DSvlVGnxVHQEaGWpnyCnzq1ufW4
	gjBCOPqzggkVisqNEidjXPWK6ES3NIe0gh10337Tb/VSJ380sRQa+B6cOCMM/DQ=
X-Google-Smtp-Source: AGHT+IGCJodLeoTVznZzVe6+8pwvtmFWVOSmICQ8bDlup/vGrc01J01tOUdaqfD4QtiJwC/n8gOsjQ==
X-Received: by 2002:a17:902:db01:b0:220:c34c:5760 with SMTP id d9443c01a7336-220c34c5af5mr6287225ad.51.1739341167239;
        Tue, 11 Feb 2025 22:19:27 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3683dac7sm105277835ad.142.2025.02.11.22.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 22:19:26 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com,
	willemb@google.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	ykolal@fb.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH bpf-next v10 04/12] bpf: disable unsafe helpers in TX timestamping callbacks
Date: Wed, 12 Feb 2025 14:18:47 +0800
Message-Id: <20250212061855.71154-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250212061855.71154-1-kerneljasonxing@gmail.com>
References: <20250212061855.71154-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New TX timestamping sock_ops callbacks will be added in the
subsequent patch. Some of the existing BPF helpers will not
be safe to be used in the TX timestamping callbacks.

The bpf_sock_ops_setsockopt, bpf_sock_ops_getsockopt, and
bpf_sock_ops_cb_flags_set require owning the sock lock. TX
timestamping callbacks will not own the lock.

The bpf_sock_ops_load_hdr_opt needs the skb->data pointing
to the TCP header. This will not be true in the TX timestamping
callbacks.

At the beginning of these helpers, this patch checks the
bpf_sock->op to ensure these helpers are used by the existing
sock_ops callbacks only.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 net/core/filter.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 8631036f6b64..7f56d0bbeb00 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5523,6 +5523,11 @@ static int __bpf_setsockopt(struct sock *sk, int level, int optname,
 	return -EINVAL;
 }
 
+static bool is_locked_tcp_sock_ops(struct bpf_sock_ops_kern *bpf_sock)
+{
+	return bpf_sock->op <= BPF_SOCK_OPS_WRITE_HDR_OPT_CB;
+}
+
 static int _bpf_setsockopt(struct sock *sk, int level, int optname,
 			   char *optval, int optlen)
 {
@@ -5673,6 +5678,9 @@ static const struct bpf_func_proto bpf_sock_addr_getsockopt_proto = {
 BPF_CALL_5(bpf_sock_ops_setsockopt, struct bpf_sock_ops_kern *, bpf_sock,
 	   int, level, int, optname, char *, optval, int, optlen)
 {
+	if (!is_locked_tcp_sock_ops(bpf_sock))
+		return -EOPNOTSUPP;
+
 	return _bpf_setsockopt(bpf_sock->sk, level, optname, optval, optlen);
 }
 
@@ -5758,6 +5766,9 @@ static int bpf_sock_ops_get_syn(struct bpf_sock_ops_kern *bpf_sock,
 BPF_CALL_5(bpf_sock_ops_getsockopt, struct bpf_sock_ops_kern *, bpf_sock,
 	   int, level, int, optname, char *, optval, int, optlen)
 {
+	if (!is_locked_tcp_sock_ops(bpf_sock))
+		return -EOPNOTSUPP;
+
 	if (IS_ENABLED(CONFIG_INET) && level == SOL_TCP &&
 	    optname >= TCP_BPF_SYN && optname <= TCP_BPF_SYN_MAC) {
 		int ret, copy_len = 0;
@@ -5800,6 +5811,9 @@ BPF_CALL_2(bpf_sock_ops_cb_flags_set, struct bpf_sock_ops_kern *, bpf_sock,
 	struct sock *sk = bpf_sock->sk;
 	int val = argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
 
+	if (!is_locked_tcp_sock_ops(bpf_sock))
+		return -EOPNOTSUPP;
+
 	if (!IS_ENABLED(CONFIG_INET) || !sk_fullsock(sk))
 		return -EINVAL;
 
@@ -7609,6 +7623,9 @@ BPF_CALL_4(bpf_sock_ops_load_hdr_opt, struct bpf_sock_ops_kern *, bpf_sock,
 	u8 search_kind, search_len, copy_len, magic_len;
 	int ret;
 
+	if (!is_locked_tcp_sock_ops(bpf_sock))
+		return -EOPNOTSUPP;
+
 	/* 2 byte is the minimal option len except TCPOPT_NOP and
 	 * TCPOPT_EOL which are useless for the bpf prog to learn
 	 * and this helper disallow loading them also.
-- 
2.43.5



Return-Path: <bpf+bounces-18243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5742817E02
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 00:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A54FF1C21BAF
	for <lists+bpf@lfdr.de>; Mon, 18 Dec 2023 23:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8946768FF;
	Mon, 18 Dec 2023 23:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbbjc3Vq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71095768F5;
	Mon, 18 Dec 2023 23:19:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D5BC433C7;
	Mon, 18 Dec 2023 23:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702941547;
	bh=mb4JShlNgFcFzqJPMkJYMBxBp7G/9sUOoyth2iJ29MU=;
	h=From:To:Cc:Subject:Date:From;
	b=gbbjc3Vqvg0EEXvgKGaZyQMfeiKuSjlJLGXKICnQR+d6Bdw0wQ1UUhnIchZ+yVnIs
	 VIjP0Ek5ooIRLoXb6vgctrUpCCbrf2SwrET+TLHOTfa8309xRW7zM9AgIMCx9BxXZw
	 62e81HwJby/8A3NygBiktVxg5lb/wogcD+Jz8Tsq2Nxp+8QSSTyxytZQ72KUr7oSLb
	 ANo3u9gpC5+FdhfZs44UEmkUa9jYUWzT3Qd7Fb4kWCuJnj8ooVYOYoz6jAoDWluVjD
	 Q7Rvxae94lkGZoaQcB1DyPj1JM64fe/YQON4oL3v09EVXKc4q+8nNYNeZazvBa58PM
	 3jZ4nzpYiZz/g==
From: Jakub Kicinski <kuba@kernel.org>
To: ast@kernel.org
Cc: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	syzbot+f43a23b6e622797c7a28@syzkaller.appspotmail.com,
	martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	keescook@chromium.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next] bpf: use nla_ok() instead of checking nla_len directly
Date: Mon, 18 Dec 2023 15:19:04 -0800
Message-ID: <20231218231904.260440-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nla_len may also be too short to be sane, in which case after
recent changes nla_len() will return a wrapped value.

Reported-by: syzbot+f43a23b6e622797c7a28@syzkaller.appspotmail.com
Fixes: 172db56d90d2 ("netlink: Return unsigned value for nla_len()")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: martin.lau@linux.dev
CC: daniel@iogearbox.net
CC: john.fastabend@gmail.com
CC: ast@kernel.org
CC: andrii@kernel.org
CC: song@kernel.org
CC: yonghong.song@linux.dev
CC: kpsingh@kernel.org
CC: sdf@google.com
CC: haoluo@google.com
CC: jolsa@kernel.org
CC: keescook@chromium.org
CC: bpf@vger.kernel.org
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 6d89a9cf33c9..24061f29c9dd 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -203,7 +203,7 @@ BPF_CALL_3(bpf_skb_get_nlattr_nest, struct sk_buff *, skb, u32, a, u32, x)
 		return 0;
 
 	nla = (struct nlattr *) &skb->data[a];
-	if (nla->nla_len > skb->len - a)
+	if (!nla_ok(nla, skb->len - a))
 		return 0;
 
 	nla = nla_find_nested(nla, x);
-- 
2.43.0



Return-Path: <bpf+bounces-43867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FF29BABA6
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 05:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE8151F2168B
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 04:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C21178CEC;
	Mon,  4 Nov 2024 04:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVcI4EoE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5586FC5;
	Mon,  4 Nov 2024 04:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730692942; cv=none; b=gNfNjc5W+Xmch4N/s41WZSB7VfbS+MUfyevZkk3gUhSoY64v6L1r1Heq5+7H277HoTAcK+cp6T3SlC85mWEeGwVe16Yx2trWP5w+x4Pf18s83giICGlDpm9ZBeBU7w+2imbRMUPVlPPpwSZM3BmBN4C6sfmJ9Vdb9mDWedWtJCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730692942; c=relaxed/simple;
	bh=WWT3SMNHvJyx/SDhrxhY6GP2KynQvDNBGvhsdhLcAZo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m/HbV5a6i+wfOnRnRetKCSOH0K7L8L5xJOLvpo2WzY/PGkE2BP8EGBtuF5rdbmSPjPZsCsQih05znWKB2z2rNMhN/Icsi3KshTfs0YPlTTKFw/wlYd2gc8jf2eEjK7ZfUDwLHOEnf1NNvNEsZ/J+LlbggZIWU8j59G32og9cqGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVcI4EoE; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-720c2db824eso3423671b3a.0;
        Sun, 03 Nov 2024 20:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730692940; x=1731297740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jb2cn9o/Hwz3SJMKUwCFXwcDUKiJHlS1xO2b6PXNQ3Q=;
        b=RVcI4EoEFlSWCIgsEMoPmpXbpRmdqN9kSjGziquZbuM5nYXnM1RSL2ch8I7YfG/p+F
         TTBWhekKdbNMrjDpaoJ9agyVwajyoE+x+6sHU2OZOi/PQqEzM9ckmZnXENpNHG830286
         B3150Ho3cf8vRc43vEPeeQiRFpzRn3+Fct/lDFUVfa/Wyk9FKc1qpclvm6s8qpfBjYeD
         JjFH+QkuCzylPuaUQQJjlU8cYASD6NSmoekIRjPqqxmGq5O4yMXnCJ5zTiV3pcJaNYZA
         x2vN0claffGYWVnNhGpD3r98eA8XBwbX1DJ5m9GAdfKi4bTlmHl7DLGyPd8p3gBtN3qz
         CWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730692940; x=1731297740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jb2cn9o/Hwz3SJMKUwCFXwcDUKiJHlS1xO2b6PXNQ3Q=;
        b=akwuarsRDdGRtLaA0PoP9P8rYV3OZxq8N6eUkm+BfCjh9CyrGqVOoUXE1jJ/8tluT9
         uaZvG5U9U6/eRb6oe+2uWr6esQk5FOa6CLm/IJQnrLJBiZ+63C4MHSHtNEFFcFH9kt0p
         juBDIdxMtVuFKQ1/cGlouK4hFbrBvKRWULUNCdakfRJcHXXnCI7gg79QN+tYZaM1Jb72
         ttALSDjORF1yPsZfpDbZ1rPysfADHHwd107QVmDejW1eUPp2x8SJCt9kn6xaxlF/Qpwx
         R+N01yjnGZBgk6PKPXzKrpFU1XDRDAMTNIi5Hq98G4bcQNPMNliC7mPT7NfAO7yC3f0I
         dpKA==
X-Forwarded-Encrypted: i=1; AJvYcCU2BlnM3jeT6Xzue0ZuDyEGc1Ht6ri/4smG02KV+5cFnISmbh/F1+YNgsW7qn9LeYIBBWrO6XWLh2ROC+4V@vger.kernel.org, AJvYcCURQuIHPzSfewwFBR0uKGzs9NnHLVqhM+wegG5TohLuYUj6YoAouqIovChNzr5Gt2bPmrE02crE@vger.kernel.org, AJvYcCXDSjjKVSmC9ZCtHtRi6YKtUMIqdyzNEAm8suwYwDT3L9YrmulL/RKZk2UcyKRmhIUhWh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHD6UmpNafRoSt7kE/upQ2vq+ObgNdA2G0tiM2ynY79u3zc0md
	9/05rxhzwQz0PH2MlL5JjZA1ywTZrUk3lDvoHZvBsX8bX5bLdhwd
X-Google-Smtp-Source: AGHT+IE1OZbBNCZcEmID2bWCABD4sivztlFo8OEcEVwSbZH0zbElhez8HpN5Df/d39Yxm+3+oGaNEw==
X-Received: by 2002:a05:6a20:e30b:b0:1d8:abf3:58be with SMTP id adf61e73a8af0-1d9a8402d5emr42807803637.21.1730692940132;
        Sun, 03 Nov 2024 20:02:20 -0800 (PST)
Received: from debian.resnet.ucla.edu (s-169-232-97-87.resnet.ucla.edu. [169.232.97.87])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7ee45a0ec8bsm6083747a12.79.2024.11.03.20.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 20:02:19 -0800 (PST)
From: Daniel Yang <danielyangkang@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org (open list:BPF [NETWORKING] (tcx & tc BPF, sock_addr)),
	netdev@vger.kernel.org (open list:BPF [NETWORKING] (tcx & tc BPF, sock_addr)),
	linux-kernel@vger.kernel.org (open list)
Cc: Daniel Yang <danielyangkang@gmail.com>,
	syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com
Subject: [PATCH net] Drop packets with invalid headers to prevent KMSAN infoleak
Date: Sun,  3 Nov 2024 20:02:07 -0800
Message-Id: <20241104040218.193632-1-danielyangkang@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KMSAN detects uninitialized memory stored to memory by
bpf_clone_redirect(). Adding a check to the transmission path to find
malformed headers prevents this issue. Specifically, we check if the length
of the data stored in skb is less than the minimum device header length. If
so, drop the packet since the skb cannot contain a valid device header.
Also check if mac_header_len(skb) is outside the range provided of valid
device header lengths.

Testing this patch with syzbot removes the bug.

Macro added to not affect normal builds.

Fixes: 88264981f208 ("Merge tag 'sched_ext-for-6.12' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext")
Reported-by: syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=346474e3bf0b26bd3090
Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
---
v1: Enclosed in macro to not affect normal builds

 net/core/filter.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index cd3524cb3..9c5786f9c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2191,6 +2191,14 @@ static int __bpf_redirect_common(struct sk_buff *skb, struct net_device *dev,
 		return -ERANGE;
 	}
 
+#if IS_ENABLED(CONFIG_KMSAN)
+	if (unlikely(skb->len < dev->min_header_len ||
+		     skb_mac_header_len(skb) < dev->min_header_len ||
+		     skb_mac_header_len(skb) > dev->hard_header_len)) {
+		kfree_skb(skb);
+		return -ERANGE;
+	}
+#endif
 	bpf_push_mac_rcsum(skb);
 	return flags & BPF_F_INGRESS ?
 	       __bpf_rx_skb(dev, skb) : __bpf_tx_skb(dev, skb);
-- 
2.39.2



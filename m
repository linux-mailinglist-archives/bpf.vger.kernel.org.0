Return-Path: <bpf+bounces-42498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CFE9A4BBC
	for <lists+bpf@lfdr.de>; Sat, 19 Oct 2024 09:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72FAA1F2377C
	for <lists+bpf@lfdr.de>; Sat, 19 Oct 2024 07:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907DB1DDC22;
	Sat, 19 Oct 2024 07:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mH+E7fWv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEC91D7E5B;
	Sat, 19 Oct 2024 07:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729321915; cv=none; b=ZJt7hFPS3Pt4ArXL0+0/JGonaeHv/zLtsihAydmXwFG+IG5xWv8mCV6hPA9wJtWc7RBHE/QKRYiKd/i5mTgw4c98lONT0igoZP+f8JUq2oGSVCWr13qYzLKaEuxbjIOjlrniGhFuWGkRJ/0z28+6g0mWWgg+3Ad/nXrihcjj0X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729321915; c=relaxed/simple;
	bh=gyYDzQGKOqgYMYaJdzUg3i6tJ8ixJ54mQLbSTkrE1/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ss1rlZKfLSuwgEGQLDP/zNYNx9IFqCqQXzT88d0igCfmR1wirYs3uiOWvx5G7kfZzggdsrIbnTcHKDghst2R+uJ3wr877Ct1p7ikdFNA+7I1ioxyEFv5O0rVBTbHpPY46zzh81du/dINYUZB0jqqi7V7WD8gI8b/Gq3rqXWtsMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mH+E7fWv; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20c77459558so25624925ad.0;
        Sat, 19 Oct 2024 00:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729321912; x=1729926712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Gn+yGZNlg35IH0UZAn+lxJ6+L1bLg4klZElPzwowdU=;
        b=mH+E7fWvdqEoGZRLaRghNCw5mMVBNrSbww20HRsh3eSZaxfxPv+pfyOzVXrtggf/Ip
         NJUSNLNHzdKcZsYXhRh1XLK5iA2hWpiFirXV8QD7qXXT5zcnCb4of6sdNOMOrf5hacUn
         j3WfXmzKR7JXh0chK7kvoeqvLeh44utWMvq+4bRdaRx/Ulaa8v0wv68vsnuTtWtg+627
         PvNJIoRj/jG2ysowVW7EN4rdxibLHQSDPRI4B62Xa+yDGY9tnoS050h0QJvX1y94xUh3
         EGX+9PUqSYbmcVU1xkkIHbzvxqVebA1jlP4NeFGpQpzH43kR1djVirmKA6pU576+TkZI
         CCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729321912; x=1729926712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Gn+yGZNlg35IH0UZAn+lxJ6+L1bLg4klZElPzwowdU=;
        b=dDGg1JdVIjcwZfRCUBoLjpXgBht+3PDPle37tA7CHkhv1MKCMFAEmVEac0YHAYTwvx
         fYoYzC5Fwtq7Qi/JtMTqu1JIP8ltcFlHpo5omDnE/zdrZtD9qsQ7C3znZJkiu7SXy3ZN
         FGsJqPuYX2NHDlJgdbQ+h7MvdhuRP4eaUSwp0XX18GSaRISu0LlyEyFnF1nYyswK5IxP
         Av2GMWViXiN5gXKt+vvKvsVJ3vVtOMSIrZUKfC77e5wtLT7K9TiHE5omeMCHpLa0bDfm
         YewWHs3dO3VmPrB+eDU3xH4ouiLjs396/kcVLP1dJqaASI+84nRAkYckdQa6r9TaNM6k
         ZWBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqw7Q9bBFcYN9NYuqGkuUVR6nuMl8Rve9sohItPj+A8DIEX+zOOZn6LObmbD1j4Knh8yk=@vger.kernel.org, AJvYcCXd1K8rPoJ3HPoC3KYI9wEL6C8Rtu2d73CiaES4AZI9cDg1rb5U2Y5vJ1HLqHKm57Ruj0tEmmV0JoUM7mgT@vger.kernel.org, AJvYcCXsFSAUIsKCKG/zpBXoMuFxFpDV9Uv+R7oKwGew49gqz72JATZyTE+rGof7a8wtU+QmapWjtvfo@vger.kernel.org
X-Gm-Message-State: AOJu0YyjfLhK1uQeWdGJ5CWEMF/bang3Bqb1kI+tFPW8OsfD4zZhPwzI
	qExVqOEc4/K9EsR3Be42z1H9T2Kc0JSi+mAYK2GdByQ/oiGS56+rVnbDJQmhh9g=
X-Google-Smtp-Source: AGHT+IE/SkDlNN6p0OGPS3TeQrfyaFsGLBzlRh1iKulhu+uDf+sHLST8POK39eHc2Pb5oKWkazqeww==
X-Received: by 2002:a17:903:1c7:b0:20d:2ce5:750d with SMTP id d9443c01a7336-20e5a725bfbmr72473375ad.12.1729321912151;
        Sat, 19 Oct 2024 00:11:52 -0700 (PDT)
Received: from debian.resnet.ucla.edu (s-169-232-97-87.resnet.ucla.edu. [169.232.97.87])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20e5a8d6408sm22609135ad.166.2024.10.19.00.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 00:11:51 -0700 (PDT)
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
	bpf@vger.kernel.org (open list:BPF [NETWORKING] (tcx & tc BPF, sock_addr)),
	netdev@vger.kernel.org (open list:BPF [NETWORKING] (tcx & tc BPF, sock_addr)),
	linux-kernel@vger.kernel.org (open list)
Cc: Daniel Yang <danielyangkang@gmail.com>,
	syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com
Subject: [PATCH net] Drop packets with invalid headers to prevent KMSAN infoleak
Date: Sat, 19 Oct 2024 00:11:39 -0700
Message-Id: <20241019071149.81696-1-danielyangkang@gmail.com>
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
of the data stored in skb is less than the minimum device header length.
If so, drop the packet since the skb cannot contain a valid device header.
Also check if mac_header_len(skb) is outside the range provided of valid
device header lengths.

Testing this patch with syzbot removes the bug.

Fixes: 88264981f208 ("Merge tag 'sched_ext-for-6.12' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext")
Reported-by: syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=346474e3bf0b26bd3090
Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
---
 net/core/filter.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index cd3524cb3..92d8f2098 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2191,6 +2191,13 @@ static int __bpf_redirect_common(struct sk_buff *skb, struct net_device *dev,
 		return -ERANGE;
 	}
 
+	if (unlikely(skb->len < dev->min_header_len ||
+		     skb_mac_header_len(skb) < dev->min_header_len ||
+		     skb_mac_header_len(skb) > dev->hard_header_len)) {
+		kfree_skb(skb);
+		return -ERANGE;
+	}
+
 	bpf_push_mac_rcsum(skb);
 	return flags & BPF_F_INGRESS ?
 	       __bpf_rx_skb(dev, skb) : __bpf_tx_skb(dev, skb);
-- 
2.39.2



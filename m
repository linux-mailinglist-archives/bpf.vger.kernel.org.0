Return-Path: <bpf+bounces-41230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B911B9944C7
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 11:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F7671F2345E
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 09:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777A11C2448;
	Tue,  8 Oct 2024 09:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLyewEiC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23BE18C036;
	Tue,  8 Oct 2024 09:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728381099; cv=none; b=Lbi96bGEED+gdBU9GzU9xXfbvM6At8TTaQ7dTbRUDv5pEaoqfj6oINmldjzNTcFa/Dwev3vZBaXOly4PDcmcCykJ5WHWOJWT85qaU7rsv1z5/ikrdLG860WAjGQX/yAKqyGyyf0HDWkmLEOVkRiFr9mLIN/ib6ZMzgQlLHXkMCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728381099; c=relaxed/simple;
	bh=8OSNU7mieaAQeLBXSucsuY/25TVKLVtBL09ISEs48SA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ptps4/qJftjMVPuJQcDvXq7VTjI7PD8KqpJF5apRvpay/kCRyTF1hc5oAblQMxiP5WJ/J3mzbuINLdmQI9s143LSCNJUiQyXBN2YSZF0uQi672VHhkWf0wAu/gvv5NKuWQTTJGxcFNx1lEzxGtxfZpK9VKlHZVC/y+G9voOhnEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLyewEiC; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20b7259be6fso59493095ad.0;
        Tue, 08 Oct 2024 02:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728381097; x=1728985897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=quADWjfjiuWGufDN5ENxiTYOZZcFg6R0qU2ip7FRzFI=;
        b=GLyewEiCuqkUOIj+MHVzNGm+a4Mctss34MfxUGgvxbm6whhO9T+UABqise9DM3E+nD
         d3bW6DxjtcWC5EGueStYVIOBsgL37sUSv+WB6+DycKBSBI4vklMcQrmt/XKBGIKTm07N
         2gt5luvW73lrlblKx4q+p+mTq5Z+lE0MtzHDAvzlg7mdIii+0aCVmVeP2EWGMZ9RC4/D
         zsU3h7n8d5djDOs8lAVw7unD2hSUAPSbItUC5c4PZpfWgQyHsCSNKw6M+iLaFCBR2eKd
         51bVx2eaQhA0yIsbgRb4z6Yu1cPknM2vof34XGwPPb4qtRwFNrgVyNVErIUrbXshmt3T
         c58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728381097; x=1728985897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=quADWjfjiuWGufDN5ENxiTYOZZcFg6R0qU2ip7FRzFI=;
        b=tqoe2JQWyCnMC8XI+VF5clTgLqHPznolX9NsRi7dNBkhC3UrpoTqTwjyU+0eUVd0ro
         Tc0rdQAoV9nV27E51YswcfIfoySYTjc47tYm0UKbnre0fQFxDNN5M9FbkNWCj0SMVk5f
         lIgF/aAE5qn0saKjk/veTiHGfA1L/7Hl06WUSoN6V5lz1I3v4Tg3Go+sFlyCLwUI7aGD
         SY7kvKV27qnBta3Lmyv+kmwwd/Z7GGKli0Qop48WgqAkn+Whdbl4ZAiL2I8f8P9UkJ23
         9VcqLxtc15XRboQXrh6NNZVjgYU3T2qVaTcMbW+yjQl2dbUv2xSGFHbUpKw0Ols2fmks
         vN+A==
X-Forwarded-Encrypted: i=1; AJvYcCUCFE7xuc5RW1G+ey640IOaJ1eR5L0YZ9zoyb/m6wEq5EOjc/B48GElRKCxKLmBxZwwabkMEBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzsDHDrwup8ISoxLtKPQ26FFsbLop7ZoodIB9ZOgUWvm77bAHo
	hG6Pzg57Ae7XA3PWBpZHvd0ZEeMvYu/+3hQpgbKxnXae/vK9akwF
X-Google-Smtp-Source: AGHT+IFwzIm6ObBTvUC419Yc30oGlwpkyQujouLzvxxd+x7/D42VC6ZhVjGTd3ub+HdIgukNhvzypQ==
X-Received: by 2002:a17:902:da8d:b0:205:3e6d:9949 with SMTP id d9443c01a7336-20bff03973emr207418595ad.52.1728381097019;
        Tue, 08 Oct 2024 02:51:37 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138cfd25sm52527345ad.73.2024.10.08.02.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 02:51:36 -0700 (PDT)
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
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 4/9] net-timestamp: introduce TS_ACK_OPT_CB to generate tcp acked timestamp
Date: Tue,  8 Oct 2024 17:51:04 +0800
Message-Id: <20241008095109.99918-5-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241008095109.99918-1-kerneljasonxing@gmail.com>
References: <20241008095109.99918-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

When the last sent skb in each sendmsg() is acknowledged in TCP layer,
we can print timestamp by setting BPF_SOCK_OPS_TS_ACK_OPT_CB in
bpf program.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/uapi/linux/bpf.h       | 5 +++++
 net/core/skbuff.c              | 3 +++
 tools/include/uapi/linux/bpf.h | 5 +++++
 3 files changed, 13 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 0d00539f247a..1b478ec18ac2 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7029,6 +7029,11 @@ enum {
 					 * feature is on. It indicates the
 					 * recorded timestamp.
 					 */
+	BPF_SOCK_OPS_TS_ACK_OPT_CB,	/* Called when all the skbs are
+					 * acknowledged when SO_TIMESTAMPING
+					 * feature is on. It indicates the
+					 * recorded timestamp.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 8faaa96c026b..2b1b2f7d271a 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5559,6 +5559,9 @@ static bool bpf_skb_tstamp_tx(struct sock *sk, u32 scm_flag,
 		case SCM_TSTAMP_SND:
 			cb_flag = BPF_SOCK_OPS_TS_SW_OPT_CB;
 			break;
+		case SCM_TSTAMP_ACK:
+			cb_flag = BPF_SOCK_OPS_TS_ACK_OPT_CB;
+			break;
 		default:
 			return true;
 		}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 020ec14ffae6..fc9b94de19f2 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7028,6 +7028,11 @@ enum {
 					 * feature is on. It indicates the
 					 * recorded timestamp.
 					 */
+	BPF_SOCK_OPS_TS_ACK_OPT_CB,	/* Called when all the skbs are
+					 * acknowledged when SO_TIMESTAMPING
+					 * feature is on. It indicates the
+					 * recorded timestamp.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.37.3



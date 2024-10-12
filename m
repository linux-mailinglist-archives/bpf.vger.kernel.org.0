Return-Path: <bpf+bounces-41804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AD399B0B2
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 06:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CF211C2152B
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 04:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAF3137742;
	Sat, 12 Oct 2024 04:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQhHWWjf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B69126C05;
	Sat, 12 Oct 2024 04:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728706057; cv=none; b=c4MZh9b8RfbkkZDq8DKZpLgU0NWmnXjscp4uAQbNEJl5pqmoGuysJ+RpX/eJWZ1BeFQrgk58H4mghrH0tF9nAFLgtWlvIUYNkLg+KRDLJv0JQIPnSvR85n8B3v813Fw3dOaAYoFzO0rOUlK9gA2PXLlljw4Zhw3GXHgsTwMApMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728706057; c=relaxed/simple;
	bh=XvZDLG++0JSemHMyBlIi72WhzAdijUjLEc8Kz8FdA5M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k8bFT/2YsMAUuXwj8BZRP59u3PH7fCSTmBIqzLuB1wSJoOD/pLvWemxV5ly5ogXo+yxRSOKXe/XUakORYWRMXrVc2f1uyMKNf0/UKaF+6EtxNULgnctfSHK5ynoxHoDlt91XJcvPnbsdgnHymOZcbyM61wRqQJHWZzEI6qnld10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQhHWWjf; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20bc506347dso21532405ad.0;
        Fri, 11 Oct 2024 21:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728706055; x=1729310855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3HJwJztm2eU03TzuaP6k1xW94JEkVBvNu9WuqJK/Rk=;
        b=eQhHWWjfouD4Zno3iJJ5LcfMCSL5tw158WDPFjg+IFK5sk5yCJ39kMrGlZC/pVsYYU
         1pxAm5wxj5DqbHkArwZjaWPxTFI1l+AvJ9bnZyh3wzG7ntqppa6Zb0cR/I2DL2B+8XQm
         1+tlKCNXMoJFwClShImiChXxUEfCK6VN9d8XdW/yeqNyg9ZWaSpRvboezB8i3wh5n6ro
         113m4bcBbwajzQ7+N3N+DZugM9x/QagWW5QDEXv2tniYo7q/DKDy2JRYxGqdYTTb9urM
         lTaMMZlAis8AUN9TX6ECLMKwQLBELh78zO9/BUvZQ4xfx9BcjbLwgiYISJr3YMQvgxvL
         iA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728706055; x=1729310855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3HJwJztm2eU03TzuaP6k1xW94JEkVBvNu9WuqJK/Rk=;
        b=WTtZkCNa0RaNYJQUjsjh7e3c+jej9iQmbUH9g006Ulv1QNYbj6vITWE67/ui6/I9fQ
         uyITwkrcD+WNWYh8NGUc5WS0YXut6zHHs0bB8bEOlDRY9IViVoOO+N86HouJ68vB2ih6
         xD30a+Y07+vc7ahvabQf/4hhz5FURDDLE3ZcEYmM699SyXv7q2MebfucqJ1WA3lXDnUi
         DetzCst+aYDrL+xr8DYXI2UqL8D2q5QzUGpgH7PePm0711LF7BEb13hPh4kRDwU29yeO
         dcoh/jiRbAhKlkTd99CB2W3SLP6xducXZgaEhTELE571jP9IhCWVY6jR7bEdeV3x4ZxL
         TxKg==
X-Forwarded-Encrypted: i=1; AJvYcCXyVZt6eWTB65zJXkQqF1G4SO/hrFjgwZk6vhasUZjBULL3ejm/Ahm/O9Eeonwo9QFr3RXZRVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW2tqMMM4UUpb3ay9JRMY208OHytKODv1HsRGQ9yuF9ZYKcDEm
	aMlHqUffUDAWSDOntKlO5z0TkJTP6/capTEMa8v0pP0f2Rq+xppM
X-Google-Smtp-Source: AGHT+IHnd6+UieFd1ANMnkSoFi4BAvkPc5Phb7SB91p5A1CM/dmzEh6c8S9jmCKWMllv9dunVW+7VQ==
X-Received: by 2002:a17:903:1c4:b0:20b:79cb:492f with SMTP id d9443c01a7336-20ca16b4aa0mr83283705ad.43.1728706054791;
        Fri, 11 Oct 2024 21:07:34 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c21301dsm30939685ad.199.2024.10.11.21.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 21:07:34 -0700 (PDT)
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
Subject: [PATCH net-next v2 07/12] net-timestamp: introduce TS_SW_OPT_CB to generate driver timestamp
Date: Sat, 12 Oct 2024 12:06:46 +0800
Message-Id: <20241012040651.95616-8-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241012040651.95616-1-kerneljasonxing@gmail.com>
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

When the skb is about to send from driver to nic, we can print timestamp
by setting BPF_SOCK_OPS_TS_SW_OPT_CB in bpf program.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/uapi/linux/bpf.h       |  5 +++++
 net/core/skbuff.c              | 13 ++++++++++---
 tools/include/uapi/linux/bpf.h |  5 +++++
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 3cf3c9c896c7..0d00539f247a 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7024,6 +7024,11 @@ enum {
 					 * feature is on. It indicates the
 					 * recorded timestamp.
 					 */
+	BPF_SOCK_OPS_TS_SW_OPT_CB,	/* Called when skb is about to send
+					 * to the nic when SO_TIMESTAMPING
+					 * feature is on. It indicates the
+					 * recorded timestamp.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 16e7bdc1eacb..832d53de9874 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5619,7 +5619,8 @@ static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
 	__skb_complete_tx_timestamp(skb, sk, tstype, opt_stats);
 }
 
-static void bpf_skb_tstamp_tx_output(struct sock *sk, int tstype)
+static void bpf_skb_tstamp_tx_output(struct sock *sk, int tstype,
+				     struct skb_shared_hwtstamps *hwtstamps)
 {
 	struct tcp_sock *tp;
 	u32 tsflags;
@@ -5640,11 +5641,17 @@ static void bpf_skb_tstamp_tx_output(struct sock *sk, int tstype)
 		case SCM_TSTAMP_SCHED:
 			cb_flag = BPF_SOCK_OPS_TS_SCHED_OPT_CB;
 			break;
+		case SCM_TSTAMP_SND:
+			cb_flag = BPF_SOCK_OPS_TS_SW_OPT_CB;
+			break;
 		default:
 			return;
 		}
 
-		tstamp = ktime_to_timespec64(ktime_get_real());
+		if (hwtstamps)
+			tstamp = ktime_to_timespec64(hwtstamps->hwtstamp);
+		else
+			tstamp = ktime_to_timespec64(ktime_get_real());
 		tcp_call_bpf_2arg(sk, cb_flag, tstamp.tv_sec, tstamp.tv_nsec);
 	}
 }
@@ -5658,7 +5665,7 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 		return;
 
 	if (static_branch_unlikely(&bpf_tstamp_control))
-		bpf_skb_tstamp_tx_output(sk, tstype);
+		bpf_skb_tstamp_tx_output(sk, tstype, hwtstamps);
 
 	skb_tstamp_tx_output(orig_skb, ack_skb, hwtstamps, sk, tstype);
 }
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index d60675e1a5a0..020ec14ffae6 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7023,6 +7023,11 @@ enum {
 					 * feature is on. It indicates the
 					 * recorded timestamp.
 					 */
+	BPF_SOCK_OPS_TS_SW_OPT_CB,	/* Called when skb is about to send
+					 * to the nic when SO_TIMESTAMPING
+					 * feature is on. It indicates the
+					 * recorded timestamp.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.37.3



Return-Path: <bpf+bounces-41229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BCD9944C5
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 11:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E3DF1F224BE
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 09:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4291C2317;
	Tue,  8 Oct 2024 09:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLzf9/ZF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDA818C036;
	Tue,  8 Oct 2024 09:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728381094; cv=none; b=MEVh1js/BUPRCoobSeGK2GV1W9EOjI3gsNX1m9DnDVqKJ4XoBKYWHuR0Fu/q8rNzlk0vrB/Qg+2V+bdqwLLwM5ktkSPO6gPK8DhhzvXVwUYOTnPeVsyqnfThP8hB4APhscK3x5FiK2BAn/gYJIR3CcP9wNXWSaXaNpEew7eFDKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728381094; c=relaxed/simple;
	bh=+6Z1rn6ppe+Tr7GvfJzb8ihJP1TZEXIeogF0Vwy118Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OSzFAKl6677nrSpQMXCtn9GWOOLXIF7LwGD70zR+xS2vsWkpH8THkS5i3CCjuC2dO2d0CPME/+padpcSADXgAw4oPjdIYhc/tQHflgGSEaQqYTl6ZQESuGa6R50DSU1wq61oR8EtG0m1cU4+PC9K6nI92cYHFQmrS/BtHnxqBi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLzf9/ZF; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20c56b816faso4411705ad.2;
        Tue, 08 Oct 2024 02:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728381092; x=1728985892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvjTOC4Sr8/XyCnIZg/tJ7FeUwowYM7uPRWpo4Tvou4=;
        b=LLzf9/ZFT2VwRg6gogu5M9MDaCslOIzaoGUQD3CGv4x0ta5OiHlqec4ZUeoxrT6V5q
         vLzu8ODP2Zj0jmayzTFwIqxjDu6Y/HixNyFLD6/k6GS1X/rvZtjwhdLi/MmXsgf16v6C
         JQkX/3gc1QGYX7Js9JxlOUR41XEn/3ScpLC+6t2S7xjkZD7ehLa1GZeAZ/GOKZkRTBnd
         gHIWlY6UR5vgKmqqDDaOY0Op/ragGsYTyUUZoYID83Cak/RgIyhRQxHF3pOT4WVMN26x
         +qiAgw0vI/9Hs6jvZ0A6QJX35EYblwLmRm2fK4kmo0EnvneBJK14lVkrp3MA+7yThDzP
         3xug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728381092; x=1728985892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dvjTOC4Sr8/XyCnIZg/tJ7FeUwowYM7uPRWpo4Tvou4=;
        b=i8MaqAXL6bhzbVj5oKiERamHC7tqcuQKzZMVjK7r+jJPkBsWywPhphY4DOTGlHWV6h
         XyW9kDq5ucXAFGI+2U9HWO5Y6IXntI/2zYY6JIFmKKDxc3izxcMnbgE7ks7BcZ0204O9
         7ADD8NuZcbE5Kz8hRDaP+9W6/9okKFEy7zUGSScOGZvL5xZJCxqBNW/Cw49DQmdqmjrE
         OzLVhtW3z4yO+ZIM4wXt3jdniyBANaIejYQLKBE8LGOPNY0x3sp9QjzPCi9f7Z9OzDDO
         WpNpldBRcvqQg3SLDMuG+kR5hY1ZBztu1EpU3DAzX7HPMPvJQB3ESj0uDWortWBk4Vq3
         fgmg==
X-Forwarded-Encrypted: i=1; AJvYcCWm9/3fqO4TyvpiUnBsCjXYFe2ldM0c2Jy+yhzAirSx8rmCNeVpSJoK3MM6D+tAZZCog8T38Ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXh1Wpai8fEnROZQANyOVOqCR+6YBLdo7Vj3xscO6deph8Mosj
	7kuD/zBuhJs2+E+kY88bOWE21ZyFTV690AT/IIOXYqZKKJjPhjDu
X-Google-Smtp-Source: AGHT+IHVVQAtq/gbTsj4clmk/yxX7RID4Gxoyq1AZ2EOoaw0Zd3BfduQgYXIvTnyBayOuDBlSJrQ3Q==
X-Received: by 2002:a17:903:32c1:b0:20b:58f2:e1a0 with SMTP id d9443c01a7336-20bfdfd4340mr202494945ad.18.1728381092193;
        Tue, 08 Oct 2024 02:51:32 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138cfd25sm52527345ad.73.2024.10.08.02.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 02:51:31 -0700 (PDT)
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
Subject: [PATCH net-next 3/9] net-timestamp: introduce TS_SW_OPT_CB to generate driver timestamp
Date: Tue,  8 Oct 2024 17:51:03 +0800
Message-Id: <20241008095109.99918-4-kerneljasonxing@gmail.com>
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

When the skb is about to send from driver to nic, we can print timestamp
by setting BPF_SOCK_OPS_TS_SW_OPT_CB in bpf program.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/uapi/linux/bpf.h       | 5 +++++
 net/core/skbuff.c              | 8 +++++++-
 tools/include/uapi/linux/bpf.h | 5 +++++
 3 files changed, 17 insertions(+), 1 deletion(-)

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
index e697f50d1182..8faaa96c026b 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5556,11 +5556,17 @@ static bool bpf_skb_tstamp_tx(struct sock *sk, u32 scm_flag,
 		case SCM_TSTAMP_SCHED:
 			cb_flag = BPF_SOCK_OPS_TS_SCHED_OPT_CB;
 			break;
+		case SCM_TSTAMP_SND:
+			cb_flag = BPF_SOCK_OPS_TS_SW_OPT_CB;
+			break;
 		default:
 			return true;
 		}
 
-		tstamp = ktime_to_timespec64(ktime_get_real());
+		if (hwtstamps)
+			tstamp = ktime_to_timespec64(hwtstamps->hwtstamp);
+		else
+			tstamp = ktime_to_timespec64(ktime_get_real());
 		tcp_call_bpf_2arg(sk, cb_flag, tstamp.tv_sec, tstamp.tv_nsec);
 		return true;
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



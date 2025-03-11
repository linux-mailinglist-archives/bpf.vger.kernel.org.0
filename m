Return-Path: <bpf+bounces-53789-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7704A5BB3E
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 09:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 704693A9C48
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 08:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DE522AE7C;
	Tue, 11 Mar 2025 08:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGC9k/Rp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8E41EBFEB;
	Tue, 11 Mar 2025 08:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741683394; cv=none; b=uOM1RBQUGzMbw1mYLYh+547Ej/7kBEw5bSvuzfLZdyVCbBAJI/vw/WMbsKtygfvvR2ZxIqlSphMQFuuUrJz9rpLWKGZOZdTkCnYh0JNuMKZxM6+qwV055lAb6waLL0gcbYIe5COsrEUWmJdr2Y9KE3Tm8OAdEFsf/Htv3DjX3ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741683394; c=relaxed/simple;
	bh=+Aad5XPyf1doXoWRlaNoTTUsGkq/7xdCXRgULYAvTog=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f3lwMJtddaHxGvL8b+kwjw0wJQDAJg2kJCagoxkYB7EuGnlnIwFFEyfkaSiAEX+bq0qjTQ1CieVywKu9YbOhAQBma5Q3n+jNWq6sBCG9P4xJHzkpq1O+j0WjRqs44YHBZH8YPpPK8LAGZbUJyxodS2c7hwL3Nh95Hr+5Svrgnxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGC9k/Rp; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e66407963fso4345965a12.2;
        Tue, 11 Mar 2025 01:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741683391; x=1742288191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8T8Uqmta0Kh5TnKQbbsbMXCRaE8kpvtZWd24zT74u40=;
        b=CGC9k/RpufUmfBZgbjv/uDjk12CFPGE80eVp0JLmgAEqh4hXDafo1DZeCka0sIuOHi
         WfEbzg5YLaL6M44XA5CRByrjGjajlEZJAnR8xOA8xymN0//qqLzSxPBRzKtgS3wlEwE5
         n3nbq+eIsUVlTpywmOQV9bXyw2N6qAG+xFYDqmHi4j2FgKkYOhW2HJ6zZjH59kigUVLE
         NrEy34b5rrmM9wsxNcE2IaJKQaXW7pdzfF0ghFjVrpK51NmvkWrbj7Er+S03b8tj2V2Y
         uQvrzTSmS4P43PjL6+f7ZogdLOVpDUkiIOqJz7XOCoYynQ/DaZ9y9s2rYjKk7OBch0TP
         0Kgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741683391; x=1742288191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8T8Uqmta0Kh5TnKQbbsbMXCRaE8kpvtZWd24zT74u40=;
        b=hMlD2BlhwtNn1ZeCAy9wklyeYzcNCIys35X4zWFMVVMPGX5KBHJ4TWeyOmBPdGe2l2
         PabSALSsGCGDKOPbXZPQb+83hn3yr0jGo+8Q8SI9IWoCRt/cnZDJqvWhGFIxtTBDmIa7
         4cAjzlNVuvYwHtC49lkx2+qUG/fEHmD9nJFFoVzNEvNoeimy0MwHyLBpnqcgEFZCkpwy
         o09DR/yol1K4uJ4SbpAdjY+PLVmEg2ryuu2nuwIino47DJhJ4zuHb3oVLm/4DCkaogom
         nDNHFc57w1Rh2XCQH1ckVnVYSpK54HZ1ZEKZYA6rgaBkV+tYhR/uAdgdMWgZmsBwNbl5
         Hn5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQ76LGOpfz4QpiXXQwN6vRUw0nw03oJld0Szirx1kGN1W+hKifhKyqzTCpzDg4xSCBdY/D1us=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaXIQv0GNRmcVJn0mTmQfQN6uKF6H5JEJQDec/PE6C8k9rxBes
	S6gZuE7ssZfFCDDsQh6Jc51mb8Bs88vKb0K/ztmLlJtHnhFVm70/
X-Gm-Gg: ASbGncu32NfRv15yhL/OHrwe4244nke1XZ3usfHuaSgbJZp2+OaEEjuek2xGXjsBh40
	3y+EY34n8Zf35UvzsE/gQ2e70i2lcStzcrG5+HSOXwjJSMS74s6SvMHyr85dXHxAVkL1RUVC0Iv
	ULBSFWTAZo7/d0ytWCtwxMQz/KIddyCe7Fs0opQDEwZQj+Vh5FqzidBsnesDGpfBM52ir9FR+kp
	EFPm044GplzXd0Z2aOppzGsXOKJeRGh05DWHZamH304yztIEX74jrxMxb35wo0FKaiE1KFSR8dM
	z5u8TIvGUO34nTwssSX51tPgNwzLZZyuZxfYRWuVNwWvWnvHhtKkGFWJ7PcxBY9BkbUaOxN69lv
	6KhA+Gw==
X-Google-Smtp-Source: AGHT+IF6ACQ6AxNXkHMPkgGq8F9yjaVt8BsRr6twsndH8SEX88V3Hszmk+4U51DNSXra82p9mAYixQ==
X-Received: by 2002:a05:6402:4581:b0:5e4:cf2e:891c with SMTP id 4fb4d7f45d1cf-5e5e22dc3a3mr20277798a12.12.1741683391168;
        Tue, 11 Mar 2025 01:56:31 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c766a16esm7965571a12.60.2025.03.11.01.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 01:56:30 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
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
	horms@kernel.org,
	kuniyu@amazon.com,
	ncardwell@google.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH bpf-next v2 1/6] bpf: introduce bpf_sol_tcp_getsockopt to support TCP_BPF flags
Date: Tue, 11 Mar 2025 09:54:32 +0100
Message-Id: <20250311085437.14703-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250311085437.14703-1-kerneljasonxing@gmail.com>
References: <20250311085437.14703-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch refactors a bit on supporting getsockopt for TCP BPF flags.
For now, only TCP_BPF_SOCK_OPS_CB_FLAGS. Later, more flags will be added
into this function.

No functional changes here.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 net/core/filter.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index a0867c5b32b3..2932de5cc57c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5282,6 +5282,26 @@ static int sol_socket_sockopt(struct sock *sk, int optname,
 			     KERNEL_SOCKPTR(optval), *optlen);
 }
 
+static int bpf_sol_tcp_getsockopt(struct sock *sk, int optname,
+				  char *optval, int optlen)
+{
+	if (optlen != sizeof(int))
+		return -EINVAL;
+
+	switch (optname) {
+	case TCP_BPF_SOCK_OPS_CB_FLAGS: {
+		int cb_flags = tcp_sk(sk)->bpf_sock_ops_cb_flags;
+
+		memcpy(optval, &cb_flags, optlen);
+		break;
+	}
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int bpf_sol_tcp_setsockopt(struct sock *sk, int optname,
 				  char *optval, int optlen)
 {
@@ -5415,20 +5435,9 @@ static int sol_tcp_sockopt(struct sock *sk, int optname,
 		if (*optlen < 1)
 			return -EINVAL;
 		break;
-	case TCP_BPF_SOCK_OPS_CB_FLAGS:
-		if (*optlen != sizeof(int))
-			return -EINVAL;
-		if (getopt) {
-			struct tcp_sock *tp = tcp_sk(sk);
-			int cb_flags = tp->bpf_sock_ops_cb_flags;
-
-			memcpy(optval, &cb_flags, *optlen);
-			return 0;
-		}
-		return bpf_sol_tcp_setsockopt(sk, optname, optval, *optlen);
 	default:
 		if (getopt)
-			return -EINVAL;
+			return bpf_sol_tcp_getsockopt(sk, optname, optval, *optlen);
 		return bpf_sol_tcp_setsockopt(sk, optname, optval, *optlen);
 	}
 
-- 
2.43.5



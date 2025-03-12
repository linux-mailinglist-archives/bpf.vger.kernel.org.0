Return-Path: <bpf+bounces-53893-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4130A5E085
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 16:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FBB97AA5B8
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 15:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41532528F0;
	Wed, 12 Mar 2025 15:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbPfhuIC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158E1250BFA;
	Wed, 12 Mar 2025 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741793787; cv=none; b=lOmbFDUP+LxAF7W0fkhAIq4DyQ9+o100OgSOP1CIZ4tFe4prcNbpR9LVkY/nc6ds1upLEdc+WMrsF8wWhbQ1o9mBn0Fh/TN8aCgLH6YOnY7fL2nkjs+XmRml8OeJ7W64nQhAQlgOhdA+5f3dRfy0gWg6bWzw0Lb8keu7iKSoTHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741793787; c=relaxed/simple;
	bh=Tch7y1CukP5jx++pF34KjErW5dxeSlzBY2Tru7LU6lU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kupl/i6oYZ0wK7V9q52G10VMmTUFTbJBNYpCtdsBwKKPfxkuQXJMDju2WdIzFY9u0ZhJXDaLFY2Dm+vdgcChoeQiEc2D+ZrZyigz1R3vmqcXHBBTon8kP1bpMfHNCCpH8ijuVDV1P8AoUvoo2oUn67MBVu9FnW9AdNyHjUrviHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbPfhuIC; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-224100e9a5cso132835435ad.2;
        Wed, 12 Mar 2025 08:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741793785; x=1742398585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RloDxb8gbXe9v36aikwRPJswC5qN9OsoL3FMniv5dsM=;
        b=bbPfhuIC4dTKsaaY7msCPV6YR7mMC2nu/kR/HGaTPU8YCPGZ7zj8j/+LhjBMi1TPUA
         pcQ1zohvxJy2jLvaJpTxE3JLc6QFGvECsD605pXiBPGFUQ9u/2G+1fs4yVsbn1C9+eLp
         35at/dBRFeO0UQxML1H2Gz85HTGbyOE8/z3LbvnkNAq+8YCjy8+bnd5ocEqeifxCojmZ
         KSJUZSn1R2SKhFiAbBzSoaplffF8Y/PAN3MQr08k2IKvMz+4deDdUx2aHmNTkvArq8BZ
         74tVGb4kdi8+gA9bz3CBvD/mOipvIhoAk2dBW5yQ+DceWDlcTgSFvZ3OqxwfPdHvXIRy
         Uzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741793785; x=1742398585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RloDxb8gbXe9v36aikwRPJswC5qN9OsoL3FMniv5dsM=;
        b=F2rk+FyUaKaXwWxug7t/zFJ2aAIAn4YxMuYghWFAMgwz3iuy1tA2uZRb6Fav7xa9t4
         gQuBxhPbACdvKWSQicvcSLGLZSPbF3fBUYyRbyhojw4L8+KLfqZnt0gEvTCvNDiCEqyF
         XsWaEEjxArPnuburzeMloYkTg4GuARECb8JV4dquKgRoba6gBEHsHZY19MFewaicbtiA
         8K3OGav4GHdZRWEMXlNLfBjlK889ZkJ0Ly/AHaQa8tkxtWQW7OF8ENfSUQPze5YNs/p9
         9k4BWli/ceEoTtxtD6VimjgaVQPECMiTAbZFQJgMBHdd2fnJA9bGwfsKfrk9wQp7sEV9
         XmIg==
X-Forwarded-Encrypted: i=1; AJvYcCUdsBfGU60wlfZQ5j8T8AzzG68q99Or2g5SGPoVcc3Q2tdx89PLf4qxkDr+ttG3Nj7/w8N8yyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXyDqTpqMHuMZbd1SvoBlAK2f4P9HttyTKVHPGKDxiDtgV1p+d
	A7n4ZOegOZOTj5H1V2kNQA3d04hT5Duh/+9tiilCcKoHWQjiBa3r
X-Gm-Gg: ASbGncvLjjgg7XHgK+l96rKSzncO/qCcErfiWR8DOcfhbP064Y08qBy7dXdimoEEA0J
	i3UdU8QdpK+3yBn9SyxMm1/Bu/JWsmEwZlX50bib40Jc+rq7jXOJyBikXU8z2gLT9dR5VQpPAIr
	Q4eQ5QFqYV9T94WyjuoIOIrglZyZzGWMRKWztqFCmfFfit2rsSYdUe8jwzuWGOhIHHH6aAQzgUz
	TZKhHB4Wmu1xIkqIu37d4YeT0xpYI3WNTiDydI7oUAhcA/oAVH7KwXls20V8KWdXGCaRt028QC4
	kBOfZ2gsWbVFbGTk2VFhgN1PSUMi5EEk7HYgrDXHnwZtoPjqheXmBzFjJF5N7q9swRfxnXNNA4a
	E0wxbDJnZAQ==
X-Google-Smtp-Source: AGHT+IGWvTLsIH/N8gaP91xx9wsTUWLhAy73S304tMjBtzUIRiL48+MaFxieHtTQmfyUEFxexx61lw==
X-Received: by 2002:a05:6a00:4fc6:b0:736:32d2:aa82 with SMTP id d2e1a72fcca58-736aab17045mr30578644b3a.23.1741793785294;
        Wed, 12 Mar 2025 08:36:25 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.244.131.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736ab812cb0sm10813562b3a.164.2025.03.12.08.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 08:36:25 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 3/4] tcp: bpf: support bpf_getsockopt for TCP_BPF_DELACK_MAX
Date: Wed, 12 Mar 2025 16:35:22 +0100
Message-Id: <20250312153523.9860-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250312153523.9860-1-kerneljasonxing@gmail.com>
References: <20250312153523.9860-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support bpf_getsockopt if application tries to know what the delayed ack
max time is.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 net/core/filter.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 4d34d35af5c7..46ae8eb7a03c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5301,6 +5301,12 @@ static int bpf_sol_tcp_getsockopt(struct sock *sk, int optname,
 		memcpy(optval, &rto_min_us, optlen);
 		break;
 	}
+	case TCP_BPF_DELACK_MAX: {
+		int delack_max_us = jiffies_to_usecs(inet_csk(sk)->icsk_delack_max);
+
+		memcpy(optval, &delack_max_us, optlen);
+		break;
+	}
 	default:
 		return -EINVAL;
 	}
-- 
2.43.5



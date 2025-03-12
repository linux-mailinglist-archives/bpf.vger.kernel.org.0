Return-Path: <bpf+bounces-53892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE86A5E07C
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 16:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BC1B17ABFD
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 15:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971AF2517B8;
	Wed, 12 Mar 2025 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfNRMRLG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C812685C5E;
	Wed, 12 Mar 2025 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741793773; cv=none; b=tM7ezva3HX1+gD6iO6O55o9sU9Oq4GKctNfK3HzD7rgV4fSDjnqSfcQdrHFw9AIgSVQO/BCjDOoLUUJXVFaO4WZmiNA93o63MJCXryVeVXKz0aKvMXG4hSNa37MIOBeYpKYDYlwHLD/6vJvmwk1an+P83M1sWiOQmyJ/1xDQWbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741793773; c=relaxed/simple;
	bh=ykb2g5yizED+vebhylmrflSTLVLfkil8AAMNomOGoYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rQdOrpRp9Pa7bUCILwvt/rP+UQTxzWNVlgUvl2XV2qpzD8rXfx/IhuUnRCwSqdYdnisCHDokNxJIo1Nymym+8Xke3Jw0yyWiUE+xqd6NVs1uRIM3W0xShESyt5DYaz8Atkqm/V3gYA4kPSAFN8iW7eMSziAEGK58a0LEB8W/JXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfNRMRLG; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22409077c06so44676455ad.1;
        Wed, 12 Mar 2025 08:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741793771; x=1742398571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Yd0B7kz/F6zvlGEGELE4rgUtQ3PdQMGH8uZAdiGdh0=;
        b=jfNRMRLGr49SwapI+wSnQoIaFP6USizNABVZG8YM10UVGle+P7ltK346u79tQWVbPB
         ouaHPAsRaykCoVMLGvkJiRkyxWlbeq6IrDAU8fbI0SraRDpmA+qKe35TSmsaiIPdbZzV
         bUZkK9A2wFChFqqtRUluute9qVwZ3LAZw84vuD6IAw0XM3sqwyfLr5EJG3VVuajjrEcZ
         gBuU75CmMQFuJPzWnQbXvk5TgscL9D6/zZWFRNjcnsXHkBkW2Ds7hdMixxgE+22CY6JX
         x1mq4jYs9NxIDmlZwVtoijsEjWLhxQQPlaYoyA559n6BLLklbTWy75FvdV0MLhtL9f7+
         JTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741793771; x=1742398571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Yd0B7kz/F6zvlGEGELE4rgUtQ3PdQMGH8uZAdiGdh0=;
        b=E1GJ6oWraYN7GLG6yzhhWqKlcJCvcdMXAyIM+vc/YG1pVv3EDeSxVhZres371d+79O
         6t8UTwnPQdUbgVHWzQM43lAQxFNqxT64tw8WR9NOYinUOYxppf8LzpCvbfpN+6c/BaCU
         5LZPNQH+rgtmxcY2H4yR8EnU80irmhRp+DHJ8EzUxRnSJFG7yL/+jwI8W8Awh4t7mH6l
         459NTu4nqnse6WoTmrfbWgUxbtec0OLnokOBZll/XCGet4cAjWRtUbRGZmCrSlfEdZQl
         gfWAG8cWY/4L4mutV1Z52YfnInkByVMhdIDTkvSx3qRz4Y/DOW2mShAih2dZ+d07c+ru
         O+ww==
X-Forwarded-Encrypted: i=1; AJvYcCUkcLq8Dr5XrbLfmNQbiawicj83A1AFSRzQXUWmm1bC7e4e/2hOEJAHY932AE2JoV2DTXruMX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH9ZuIxwWcGKuaHorUc/sln2KyYTB2OgCNK2AgKSmO2pZsR9Ls
	vRKnvqOyhT61GfXOa34GoctPZCCckqKWwfa+cGlL5bcUDihZslv8
X-Gm-Gg: ASbGncsaniIlel0fgsqJYchgbctjfRphJ7IDMaPdRjv11QCEmiZtSkXe+vYWG1k3FyH
	Q8oKDIFPyfnY4BR4OO4PM4FOwxVfgEOpMERKXJZbgQTzFk8OIB/fCzoRzFVcZipC+QMO+KflTMD
	+hB8FwBlVAzx+IJ33VBxPAmaE4qGbMG7f1p4mo7dA056LuDxAxK/lM3c08FdH3IxDFydzWFf3Y3
	sIksyNwjsT53t6V+WYbqAXqVOKEGbqG9dq5WoHMTJfBbOB0vMhCRqRA349dm9Mi2lciYMwJnf0C
	hvN0d1uoOBWRDm0a43G+jqlIrQ+63OIlvcO7UbyCUQYq0py0CKAvN2gffBb1zpNJqkDHMQsxMIS
	XcXQG9WYnPRqT47bAO7Fe
X-Google-Smtp-Source: AGHT+IH4uVhAOjRgGFwmXOxHr7LwTqlx68YagHZ0LOcJjdGx9ElqqD2ZEQ6Aak73gbZ+bUE9YBRnuA==
X-Received: by 2002:a05:6a00:ac5:b0:736:5dc6:a14f with SMTP id d2e1a72fcca58-736aab14d4emr32761274b3a.23.1741793771067;
        Wed, 12 Mar 2025 08:36:11 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.244.131.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736ab812cb0sm10813562b3a.164.2025.03.12.08.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 08:36:10 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 2/4] tcp: bpf: support bpf_getsockopt for TCP_BPF_RTO_MIN
Date: Wed, 12 Mar 2025 16:35:21 +0100
Message-Id: <20250312153523.9860-3-kerneljasonxing@gmail.com>
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

Support bpf_getsockopt if application tries to know what the RTO MIN
of this socket is.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 net/core/filter.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 2932de5cc57c..4d34d35af5c7 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5295,6 +5295,12 @@ static int bpf_sol_tcp_getsockopt(struct sock *sk, int optname,
 		memcpy(optval, &cb_flags, optlen);
 		break;
 	}
+	case TCP_BPF_RTO_MIN: {
+		int rto_min_us = jiffies_to_usecs(inet_csk(sk)->icsk_rto_min);
+
+		memcpy(optval, &rto_min_us, optlen);
+		break;
+	}
 	default:
 		return -EINVAL;
 	}
-- 
2.43.5



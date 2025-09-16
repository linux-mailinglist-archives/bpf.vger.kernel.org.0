Return-Path: <bpf+bounces-68578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B353BB7D731
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80DCD7B3C7E
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 23:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219272D3EC0;
	Tue, 16 Sep 2025 23:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERkghSEG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9F32F28FB
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 23:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758065831; cv=none; b=G2LFzBX0ol9PN28XzyhpkHbfoWhgE1FU1lG+s1PSztpcwThNYUnASIGkNXI1IhuXYh1lDdFKHqVFMXxNA574Z6/tMi+U3iOr2cMzVaxri6nNiNzeYI4v+qoecxMuy0y/+gMJtMcycV3lnwsrirtCNKz6hIf32XEmuPoHJ8/6iik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758065831; c=relaxed/simple;
	bh=4zExsXXH/SP5++Ezhrb0D7/XIwVEqeU1IThRjhVHR3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dCjuxWEVaVWUoLSR5Fl0CzE2+qVvk19F4H0S0n4lJ/BMJZhZh/saoj9xu2hxkP1YleaxW6AmWSug5b2cN6bbcVNTyBHZRYhw+vCTcAL9+cQfjz7XfBB8FRcuNb40UwWF7wKRElhbzwSS2hY3LcPYkSLaHBRtQLNhFp9/TlTqcsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERkghSEG; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3eb08d8d9e7so241307f8f.0
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 16:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758065828; x=1758670628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8SWmC2itkqnMJpsFaId8GIlvMlHfaGUxIRRxe09aBc=;
        b=ERkghSEGWN+k/b89qJ/1mn9wI5jTJ/dbajO7cKFoplXAyZAcIi2pjCt3unNQKx5esd
         4E+OWt/hyMNK1y7tV2ievUO3D4n8y6nLVWL/0ZcF0i70LcmfrdBFr8cfbVvw5Vlr6GMQ
         evVpIwWBC1160J5GyGkJQcJB9SR9UJLemtdMnwSVcy1AHu/xsIBd5TGt9sjeNxnY4/6b
         oLBHRQIKFIaOWIrIcAapmiDr58eU3uHG7oLXSCDakjKbSwt58Mh3x+zpzrAEZWNgyscq
         XQNGLNLrteD9O9vb4gT6mpQtFOCeKbHsyioRZcP2vHj2rENrNFeHTqLBuorgI12lC0Oh
         1+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758065828; x=1758670628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N8SWmC2itkqnMJpsFaId8GIlvMlHfaGUxIRRxe09aBc=;
        b=Byjtfa35zUVruDw/1flhROrSth+Hm+xPA87DEwEuYMMgloGd7ghwECir2IVLUbhK77
         E1xoAsyCTvvAjsLAS+TeSd4SeL2jKXKEO7VgTPOAaKa3b3UM0VGcrm1uj/KKzWcXvckB
         yExxaXg/6ByOqju4UHVieOUHvuA8Via0dQcVuBzTJaYzKZRLaKJI7yQnFPpSU/4VEzZp
         YnRRqy1LuJY0TRuh0y9KG6zGmqdjDTqv+YOrlQkxE2B7315N9wMk21/FEscX5jD2YLqY
         sJtkKwCXA8Xo3MXuDjeXRT04ZNKcgJTPnsy8ncFNqt2sWsuu6jPw8bTB9LXRbFROQMr0
         wJUA==
X-Gm-Message-State: AOJu0YzxKuRyV4ps/oCzmsXTj4QNIy05sjr0TmlDzc1gpy/uWr3uejNr
	zLGNRzmO/ia1gwAziPvRyufyrGulXKA0FinrWv4f0xPs7u5KQHtSPMRfU6X14g==
X-Gm-Gg: ASbGncvG+TcYxST3AtC+k6llsuLV0JZA8CWo7PWSOMUYsdPWtzKCi6Xy0VLjTtEvmio
	9MLyaKhvMOuTSHeSqp+UaaSkowu2gdgjW3tlv7j1sRv178c+1Wbr1QtwuVe0dvQx011bffRYosH
	gmO2aMg8k9D0HC7m5vnyrnObrvKgGi9o8aZTXX1ZBkJrW9c5eSRvlU63ygSefDHTmGjibvlfzbG
	IYSAa+YobueF63NPREeuz0Fz+JP8UdOnJH1UZ7anntRsvfGg7kZCdh79ys+4kfRjeH7dQCKPCxP
	cdvwcmgKk6yWa/FfSN1Tk2VP45Ugd1XJuSwf7+atMperE5hRY4STDTZqdHxTE8VEZKhZ4ossvQY
	8dTB420Ax05x2Cp83xq1h2A==
X-Google-Smtp-Source: AGHT+IFTg2+cgNuSFNp0o2OvBnafboUYbmGV6K/d/z09J+M5PhXt1p0ON+4YEL2OfFYEkj0/npjyoA==
X-Received: by 2002:a05:6000:2302:b0:3eb:d6eb:f677 with SMTP id ffacd0b85a97d-3ec9d70dc03mr3594948f8f.6.1758065827935;
        Tue, 16 Sep 2025 16:37:07 -0700 (PDT)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f32136cdasm26989795e9.4.2025.09.16.16.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:37:07 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v5 4/8] bpf: verifier: permit non-zero returns from async callbacks
Date: Wed, 17 Sep 2025 00:36:47 +0100
Message-ID: <20250916233651.258458-5-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916233651.258458-1-mykyta.yatsenko5@gmail.com>
References: <20250916233651.258458-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

The verifier currently enforces a zero return value for all async
callbacks—a constraint originally introduced for bpf_timer. That
restriction is too narrow for other async use cases.

Relax the rule by allowing non-zero return codes from async callbacks in
general, while preserving the zero-return requirement for bpf_timer to
maintain its existing semantics.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c9e68c3f0991..e01335ef43ea 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10867,7 +10867,7 @@ static int set_timer_callback_state(struct bpf_verifier_env *env,
 	__mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
 	__mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
 	callee->in_async_callback_fn = true;
-	callee->callback_ret_range = retval_range(0, 1);
+	callee->callback_ret_range = retval_range(0, 0);
 	return 0;
 }
 
@@ -17152,9 +17152,8 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 	}
 
 	if (frame->in_async_callback_fn) {
-		/* enforce return zero from async callbacks like timer */
 		exit_ctx = "At async callback return";
-		range = retval_range(0, 0);
+		range = frame->callback_ret_range;
 		goto enforce_retval;
 	}
 
-- 
2.51.0



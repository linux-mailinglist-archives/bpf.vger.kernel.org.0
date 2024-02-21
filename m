Return-Path: <bpf+bounces-22387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFE485D1C7
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 08:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D773B24F2C
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 07:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26873B781;
	Wed, 21 Feb 2024 07:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FPP/f1JQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2332B3AC24
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 07:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708501942; cv=none; b=izeBIjK2pxkwIaW6G58vocAG1Wt5Cc+UB/immYCxzlarmgXv4BWBwuAoCwxDT9meOhMyKwX61M7X6NxtIFe6t5nTOxdeige37QZprOy4/IKYx3DW9LyoYtDkAzrvl3x7Cflu3Adgq/zczmYKYmWMXmUY9SCvjsqDsMrcBk0Sp40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708501942; c=relaxed/simple;
	bh=00z6bws04C82/2aSQhowJadToGiFWd0rd+rEp7aO6Us=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BZViNOHfYtTcpYLzqmDvaNgU37cTG2R2tXcz+cFR/XktWYrSQ8WavDJJX2AYw1SaxE+hmU+PeRSL1wTXRwgWnlHYl/YX0LE3ZrGA/KtYkrxjN0fGfJAGc6g3QP/TkJYBVXWTXS4Slnx8NWoFU+DqVuddc7U2B/U32Dwo5JeP1Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FPP/f1JQ; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60883345d73so2420017b3.1
        for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 23:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708501939; x=1709106739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X481Qy+H21udIbTR0RfLzvcKIxylLX8qewST0PUMQFw=;
        b=FPP/f1JQ2U/Eq5dZiDf3BG+4TPMiBiSifad/A0OjhApZdxD6vslThiYyquIVsrFqgA
         Q8Gwa6iSVaooKgKoLhNZENNHsTBDVcEu7q4xBbLEJM/2A2cbISEyc1mPso9fMim4Tbh4
         EGUXF+GXpCKiikVHvA5LDFoTVKfhLue/ioqF9umQLbeAOJ/TC55zbmAynp5CHKhorW3+
         vMaYtDE63LKozp1s0YGKaID+pfQePPGNQVpQQzybtP2LCWKZ7UUN1c6lSEH5NAdx0out
         8wn1/cXslGZVZBuMv61HJt5HJeWeLu4l426O7R7j+SOcQ1IwqenJOokBAln0sjGObRxN
         FY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708501939; x=1709106739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X481Qy+H21udIbTR0RfLzvcKIxylLX8qewST0PUMQFw=;
        b=KOBuSNpNRHfyie1imfpKyn/JJ2KwPz++QP+1fm9T/WT5rRy4sELXV2V+LcJH6bBfZR
         wA5XxGAo41jJqRHx8hb/BTSD92fkkUR1lud7ZdPCYBkINxlxTDgZ2ZIPa/GrAopCZj+F
         hxCmjkP1ShxbWXoVQ+o9dBufFtMizh6KRLlqD1Nl6WLFrGOYLPOhIdKiRoQUHlSKvs5C
         rpwp0JbnFHNLZGiuDxFP3m81yl2SIXOLYp/4+9jeoCxXHKA59tCvBUH8RGovSwOFeL3z
         Un342Ps4dNYvFRmoCIwIQY6oOyHBGFAy/bXqthpXE2qoUMWavS+k/TUGf+DLzQsRM4pG
         /Qkw==
X-Gm-Message-State: AOJu0YwASzdpov2Zk+hL8hQallcXojjErXs3EEmOwAUzNavZI2EEUSO0
	Y62NvM++Wn7guMtTbLYrc7ksk2NnnhX0lMJZCObvi+a5sqx9kqX2apXLiiJM
X-Google-Smtp-Source: AGHT+IFYxOgnpvOwdN6a1rpQX3diRrXw8IXBZ1IrauGsNiBEXMf9mwSlEu5OAzs3+sM5DkhuFbXLEA==
X-Received: by 2002:a81:ae22:0:b0:607:7d2a:f654 with SMTP id m34-20020a81ae22000000b006077d2af654mr17522516ywh.19.1708501939209;
        Tue, 20 Feb 2024 23:52:19 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:26eb:2942:8151:a089])
        by smtp.gmail.com with ESMTPSA id m205-20020a8171d6000000b006048e2331fcsm2488715ywc.91.2024.02.20.23.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 23:52:18 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v4 1/3] bpf, net: allow passing NULL prog to check_member.
Date: Tue, 20 Feb 2024 23:52:11 -0800
Message-Id: <20240221075213.2071454-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240221075213.2071454-1-thinker.li@gmail.com>
References: <20240221075213.2071454-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

To reuse the check_member function of the bpf_struct_ops structure for
checking if an operator is supported, we permit passing a NULL value for
the "prog" argument in check_member. The check_member function of the
bpf_struct_ops structure will be utilized for checking cfi_stubs in a
subsequent patch when registering a struct_ops type.

netdev@vger.kernel.org
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 net/bpf/bpf_dummy_struct_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
index 02de71719aed..5fe5461d3173 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -178,7 +178,7 @@ static int bpf_dummy_ops_check_member(const struct btf_type *t,
 	case offsetof(struct bpf_dummy_ops, test_sleepable):
 		break;
 	default:
-		if (prog->aux->sleepable)
+		if (prog && prog->aux->sleepable)
 			return -EINVAL;
 	}
 
-- 
2.34.1



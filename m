Return-Path: <bpf+bounces-18133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C63F815F42
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 14:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87D11B21FC3
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 13:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6D644C8A;
	Sun, 17 Dec 2023 13:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9hAjbwN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340D844C84;
	Sun, 17 Dec 2023 13:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-1d04c097e34so14932175ad.0;
        Sun, 17 Dec 2023 05:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702819123; x=1703423923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PexKnGDC9KL8jYd/W6R/JoiOIqAz49gn3mOLUjN8jRE=;
        b=K9hAjbwN0tlxoQd+GPw1ZMwCm8qU2p6EoMyz0Cmjbl/JqZvUetX0fJT/kPadUAY7WX
         KQeLVdIqTST6t1+dSSq8sgxVEw6ZUZ7tEFbhO+rJjLYJwdjNQ602DY4eMwbKcJ45o9hT
         HS4USO49UfNmEdwZ1s1Oklnnc6PbyF/GS/tmbatCsEcvs1eNNSGQIEHM40/mddSdW0SK
         V24aXudhzhmCnX88le8pGKqXUFF48UoP8d1HUwgresvCyF4BUtwhnHKRhJOJJ0xDAgIW
         Y6HH/3ua0iuUaglg2Dkd+jNAKgRTrTwjaemHkDs52QFzblMdI5d1WSstCpFQH1PtNc6+
         RTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702819123; x=1703423923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PexKnGDC9KL8jYd/W6R/JoiOIqAz49gn3mOLUjN8jRE=;
        b=vCjvD0poxFEbQSq7p0260BgzJWC6Eo1718zvv/Kub0UH3n26etid6V3lVQ2UQTd3xa
         BNvJ8wU+ZkwrM+hphhlqt118IDGCmn2mVYteJ3M4Gseuecipp4BV4osOnrAxWgF06l0z
         rmW9fsh0bstyZ12X25POE2ZOboAQulxY0VpXg4W8kYoVkHyTfhLDqHmKMajl8lNI1xiR
         HcNIeECO72kILnj/dBTWzYugD2cB45yOM0d8ToYe14uGRfY/gtkfBSskULnI56B946rI
         VMUUoCFqid7geWkhHOjMx/bicZxbPyHBi83R7sHTrTnBsc2XBUmKTy30XjJ3oe5f6rbC
         y36Q==
X-Gm-Message-State: AOJu0Yy6RtJa3gFKOiyrsRF4e1bvjYOHZP8QyLjSydDXdkKMQ9ZdDdyG
	pud2CqODYtxmbAm/ZOqmfqo=
X-Google-Smtp-Source: AGHT+IFSKFKS7ShBmrZbgsjYihorhPt4xMO6ojj00w2oovDASLD6r75Xm3pDP8KAgJjKK0IkLGxqAQ==
X-Received: by 2002:a17:903:2307:b0:1d0:6ffd:610d with SMTP id d7-20020a170903230700b001d06ffd610dmr17224306plh.47.1702819123386;
        Sun, 17 Dec 2023 05:18:43 -0800 (PST)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902f7ca00b001d395d3df30sm1099425plw.130.2023.12.17.05.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 05:18:43 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	alexei.starovoitov@gmail.com
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Menglong Dong <menglong8.dong@gmail.com>
Subject: [PATCH bpf-next v4 3/3] selftests/bpf: add testcase to verifier_bounds.c for JMP_NE
Date: Sun, 17 Dec 2023 21:17:16 +0800
Message-Id: <20231217131716.830290-4-menglong8.dong@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231217131716.830290-1-menglong8.dong@gmail.com>
References: <20231217131716.830290-1-menglong8.dong@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add testcase for the logic that the verifier tracks the BPF_JNE for regs.
The assembly function "reg_not_equal()" that we add is exactly converted
from the following case:

  u32 a = bpf_get_prandom_u32();
  u64 b = 0;

  a %= 8;
  /* the "a > 0" here will be optimized to "a != 0" */
  if (a > 0) {
    /* now the range of a should be [1, 7] */
    bpf_skb_store_bytes(skb, 0, &b, a, 0);
  }

Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index ec430b71730b..3fe2ce2b3f21 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -1075,4 +1075,31 @@ l0_%=:	r0 = 0;						\
 	: __clobber_all);
 }
 
+SEC("tc")
+__description("bounds check with JMP_NE for reg edge")
+__success __retval(0)
+__naked void reg_not_equal(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	r1 = 0;						\
+	*(u64*)(r10 - 8) = r1;				\
+	call %[bpf_get_prandom_u32];			\
+	r4 = r0;					\
+	r4 &= 7;					\
+	if r4 == 0 goto l0_%=;				\
+	r1 = r6;					\
+	r2 = 0;						\
+	r3 = r10;					\
+	r3 += -8;					\
+	r5 = 0;						\
+	call %[bpf_skb_store_bytes];			\
+l0_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm(bpf_skb_store_bytes)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.39.2



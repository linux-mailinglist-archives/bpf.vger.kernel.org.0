Return-Path: <bpf+bounces-18130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B4A815F3B
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 14:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D8E51C20FA3
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 13:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DA84436C;
	Sun, 17 Dec 2023 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dkvj1h8z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7E743179;
	Sun, 17 Dec 2023 13:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-6cedc988cf6so909394b3a.3;
        Sun, 17 Dec 2023 05:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702819110; x=1703423910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lQbN5jnfroCdMT9/OE3fN9dv/c20W/j5cn0ShbBuNw4=;
        b=Dkvj1h8zTD4I2aBQCQblt5s4Pl2Tm4IqRIMzIE1jUV6dJhTy1gTDySX+3Q0TnXGIRp
         +l/LFS0s4lCmmZrUFro3PhPcX+jWj8wK3XnBg3wheC8v3o6S7RpgRcIEq4BgOcnfmcRO
         RQngRBoT0RHbEsCXYqnZJg3Vm73p3HUHv0nMyZ0OInzNQQjz6KDPWrJqV32jwNxXEgez
         Ej5KTdEsS533htAwqTKYtg3D2wiUaBUjRxo7O+XxoMKGGLBW9WwPVzg1ZpFM01XfBNLG
         BgQyR9ldtY9d8vdesS3B/8tD13zKjdV4o49r2ZdPQxkAxGrSSFJe2B3DUVTddRrdEwqj
         xU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702819111; x=1703423911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lQbN5jnfroCdMT9/OE3fN9dv/c20W/j5cn0ShbBuNw4=;
        b=c/pYhPR2L5RZY04ofs8jKx34HjLxDIgTlFjxlnQnThVUKK+1FC3D66KboPkuKStbQU
         1AD4KQnevF0kBVH+R5eCUTXqjku8S16jecyi/JBACCzdfYqlsv8nd9+/IcNrePkLvCKz
         Sii7I+03+SbhcHuvY+TIvPrvy0+BMWUKCSupfJ++BD9QRksVhK1Kwy4hxTr+sHLPCOkq
         OB4TXkDi7gjEmEsiNbaO2k3wRpDk7M41996fU0kaWO5wRZa9LMQnxRmHfhCH9JWNHbXz
         B6DbSsEnsEuVvKUCfhBI8+d+JZqGw19eBG6JKQcR+vrPijO3H4rHMaEveTEcZWDArtZO
         0iqA==
X-Gm-Message-State: AOJu0YxvfLVugM1RQKz7kN+DSUYV3A/qPOMxq9HVCy0VTrAyRR1OYdni
	doP89zpq577ViTY7yNBCOLU=
X-Google-Smtp-Source: AGHT+IFUqn1FDPJEQWz8S0no09rhx1Ig/9TWcnWNWveys60auFOX2t1i1oZjal71GbPwGj5KqmcCKA==
X-Received: by 2002:a17:902:ecce:b0:1d0:c849:780 with SMTP id a14-20020a170902ecce00b001d0c8490780mr8892530plh.70.1702819110569;
        Sun, 17 Dec 2023 05:18:30 -0800 (PST)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902f7ca00b001d395d3df30sm1099425plw.130.2023.12.17.05.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 05:18:29 -0800 (PST)
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
Subject: [PATCH bpf-next v4 0/3] bpf: support to track BPF_JNE
Date: Sun, 17 Dec 2023 21:17:13 +0800
Message-Id: <20231217131716.830290-1-menglong8.dong@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, the reg bounds is not handled for BPF_JNE case, which can cause
the failure of following case:

  /* The type of "a" is u32 */
  if (a > 0 && a < 100) {
    /* the range of the register for a is [0, 99], not [1, 99],
     * and will cause the following error:
     *
     *   invalid zero-sized read
     *
     * as a can be 0.
     */
    bpf_skb_store_bytes(skb, xx, xx, a, 0);
  }

In the code above, "a > 0" will be compiled to "if a == 0 goto xxx". In
the TRUE branch, the dst_reg will be marked as known to 0. However, in the
fallthrough(FALSE) branch, the dst_reg will not be handled, which makes
the [min, max] for a is [0, 99], not [1, 99].

In the 1st patch, we reduce the range of the dst reg if the src reg is a
const and is exactly the edge of the dst reg For BPF_JNE.

In the 2nd patch, we just activate the test case for this logic in
range_cond(), which is committed by Andrii in the
commit 8863238993e2 ("selftests/bpf: BPF register range bounds tester").

In the 3rd patch, we convert the case above to a testcase and add it to
verifier_bounds.c.

Changes since v3:
- do some adjustment to the crafted cases that we added in the 2nd patch
- add the 3rd patch

Changes since v2:
- fix a typo in the subject of the 1st patch
- add some comments to the 1st patch, as Eduard advised
- add some cases to the "crafted_cases"

Changes since v1:
- simplify the code in the 1st patch
- introduce the 2nd patch for the testing

Menglong Dong (3):
  bpf: make the verifier tracks the "not equal" for regs
  selftests/bpf: activate the OP_NE login in range_cond()
  selftests/bpf: add testcase to verifier_bounds.c for JMP_NE

 kernel/bpf/verifier.c                         | 38 ++++++++++++++++++-
 .../selftests/bpf/prog_tests/reg_bounds.c     | 20 +++++++---
 .../selftests/bpf/progs/verifier_bounds.c     | 27 +++++++++++++
 3 files changed, 78 insertions(+), 7 deletions(-)

-- 
2.39.2



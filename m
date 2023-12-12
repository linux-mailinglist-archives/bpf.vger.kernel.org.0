Return-Path: <bpf+bounces-17525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B896880ED03
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 14:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 754852816DE
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 13:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1548161675;
	Tue, 12 Dec 2023 13:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApIsWLvV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09419A8;
	Tue, 12 Dec 2023 05:15:32 -0800 (PST)
Received: by mail-oo1-xc44.google.com with SMTP id 006d021491bc7-590a2a963baso2155443eaf.2;
        Tue, 12 Dec 2023 05:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702386931; x=1702991731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Tlr6Isxfo0VAkoIC5C/TmG4WBg0mKgqYVQoYoM3bP8=;
        b=ApIsWLvVgaWZXoBBEEg1N/ai8y8vkK8J8oqkJ1jAGXK5u2WanGfPXzlXLwigzpCjHi
         oa+5kSIAmbUxxcRRYxwJL/fsr3QblKePeAjBqjEa5zJkZc0CUMikElz6ZV3e1s9AyCPK
         XfX9EExW8awH9G/UA9LMCfEu9XnUydzK0TVzw2daixHJNZN2ty2rmWJvW190mG9nZse9
         7wYgi69uYhZuTYX7CtoledSdcYz8czlYPq1/EwR2DAcTll7MlwRc5nrekeSz27TXQI5F
         lAfg50ZOmlctnS1KyqRkaUHiYLB5CE0/g0r7FdAEXtHOIBwEsSO1WgAKp079lhAC5k4v
         2uXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702386931; x=1702991731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Tlr6Isxfo0VAkoIC5C/TmG4WBg0mKgqYVQoYoM3bP8=;
        b=vq0vfu2JYOWDB1Iq/FGA0YU9Ew6HEtsywxrJ+SEGVtPVMsssF1B6mM6Gz6geIR6HQ+
         6y+rrQxFK4mC2+ShjAgHSq25+3gFLuQASCf4SppGrfEGjt6Jbbqp0Prwe4aBMzVqJ4T3
         PzLy/IxMxUDfqevNpKCBhbmPOItlOFagpmre0bx+5khjekbaj9Dn2Rf6uNO9stdXUycO
         kH30j7Ox10cyrl91pCHb2u9WuAWs97j7itDPpECSZ82KFOZ8RURT4wwaoSQh5wDKEjlj
         Uo71wPf9os/Ga13K7bn1NM6PJyKBWIOfbCS2OPH+ldiIVv1DFs6sdt0L4p3bFjOE3hbt
         FtXw==
X-Gm-Message-State: AOJu0YxFAcMU+L/acQ3U1vgN8NrpDQl9DXHkYP9ONiTx3FKdfFYUhf1A
	qfxJiSy00Q+mZqPwjtlPXO0=
X-Google-Smtp-Source: AGHT+IF7PQtN+v6kqLCKt2uAXW/3k9UAzdlm/zMH+0rvmBCA/ikFfct6c1Mx8I7JdkL0dsQOaSFD/A==
X-Received: by 2002:a05:6358:7e03:b0:170:ef25:aa5c with SMTP id o3-20020a0563587e0300b00170ef25aa5cmr670918rwm.17.1702386931118;
        Tue, 12 Dec 2023 05:15:31 -0800 (PST)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id x20-20020aa793b4000000b006c4d2479bf8sm8095026pff.51.2023.12.12.05.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 05:15:30 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
To: andrii@kernel.org,
	yonghong.song@linux.dev
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
Subject: [PATCH net-next v2 0/2] bpf: support to trace BPF_JNE
Date: Tue, 12 Dec 2023 21:10:29 +0800
Message-Id: <20231212131031.3088661-1-menglong8.dong@gmail.com>
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

  /* The type of "a" is u16 */
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

In the code above, "a > 0" will be compiled to "jmp xxx if a == 0". In the
TRUE branch, the dst_reg will be marked as known to 0. However, in the
fallthrough(FALSE) branch, the dst_reg will not be handled, which makes
the [min, max] for a is [0, 99], not [1, 99].

In the 1st patch, we reduce the range of the dst reg if the src reg is a
const and is exactly the edge of the dst reg For BPF_JNE.

In the 2nd patch, we just activate the test case for this logic in
range_cond(), which is committed by Andrii in the
commit 8863238993e2 ("selftests/bpf: BPF register range bounds tester").

Changes since v1:
- simplify the code in the 1st patch
- introduce the 2nd patch for the testing

Menglong Dong (2):
  bpf: make the verifier trace the "not qeual" for regs
  selftests/bpf: activate the OP_NE login in range_cond()

 kernel/bpf/verifier.c                         | 29 ++++++++++++++++++-
 .../selftests/bpf/prog_tests/reg_bounds.c     |  7 +----
 2 files changed, 29 insertions(+), 7 deletions(-)

-- 
2.39.2



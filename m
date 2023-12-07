Return-Path: <bpf+bounces-16984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D771B807F6D
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 05:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6E62821DD
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 04:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9695A5682;
	Thu,  7 Dec 2023 04:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1c7Kbnv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2331ED73
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 20:12:09 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-67abaab0bc7so3240556d6.2
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 20:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701922327; x=1702527127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vn6lBK3+Aw3ObPlUimPue3j773eIEiOpnQMBhHdMn6M=;
        b=c1c7Kbnv2igY6Ew7Za1LJTwnIIztzkNUyhtautrUbdTaR5bxKZ7sMMdagNN6EsevKg
         klj77/LBtHUeopIL0+CdoA7kc/wzc5T7HpBmGqX4OVNvsUaFgQUtaadGU/UjFotVC0cz
         iGta7MqaBqhwbG2IQruz5+rpj6KoaQsasrigLkIIBPXCni3E1A/b/27V2Kjahfs3OVSV
         HzkxP8/NS1z+9GoIqkGGhyn7ILsrz9V40hti1OCm8I6fqdlrnT22JHwADk8dysqJ3M8i
         30oq4LJUOowBKjrR7kvRoKA2RvfAxoHy2jNG4sP86FXMYM+2odLju/9dLovdbvycUiI0
         eF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701922327; x=1702527127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vn6lBK3+Aw3ObPlUimPue3j773eIEiOpnQMBhHdMn6M=;
        b=fylny74YUeYhh9gwNN1zR+DpC5KBvgPTzwwyX8GIJipuCgoNkJq2jpjPlJlKjz0ywf
         CSZQD0dtuQUA4GyqqJ8mD2UMgCul1yip9B77RNvsqRzdYGd0YcMWdAIvShk9ZrFe2Agt
         ePEjkxWHiLN18Morsop/AYcle3AZhUOp6JmxfIquw413/ywLSOkrmERgRS9knpHRwWoL
         MbWuYz3mfhTLgkCsHKUPucTI21v1/ytPXdc4qecxEz+bRMR11PTgg7vocAhvacDwgsLT
         zoJP/MgF+8Nm34fwAbDvE0IApz4GLju9Diz4B+bGt6MKcYLrKwMfGCsLGq9KI707oLBy
         YFpw==
X-Gm-Message-State: AOJu0YzU4ysRVRITU/yj58BGAP19sRRjLDlyfcpkbfSHof3tF406fwSq
	peSXiO63mfgQHH0ZE1eIdmZQrqQ4ObxxBg==
X-Google-Smtp-Source: AGHT+IGEB3hVrG8VA/TN5B7kNJch3rR0ZPLtaL64WeS+iu923+JP+UJpU8V+FYArYKlfgQ2tvJYnIg==
X-Received: by 2002:a0c:ef8c:0:b0:67a:4da4:e23c with SMTP id w12-20020a0cef8c000000b0067a4da4e23cmr1695517qvr.56.1701922327407;
        Wed, 06 Dec 2023 20:12:07 -0800 (PST)
Received: from andrei-framework.verizon.net ([2600:4041:599b:1100:225d:9ebb:8c9b:7326])
        by smtp.gmail.com with ESMTPSA id o6-20020a056214108600b0066cf4fa7b47sm172808qvr.4.2023.12.06.20.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 20:12:06 -0800 (PST)
From: Andrei Matei <andreimatei1@gmail.com>
To: bpf@vger.kernel.org
Cc: sunhao.th@gmail.com,
	andrii.nakryiko@gmail.com,
	eddyz87@gmail.com,
	Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf-next v5 0/3] bpf: fix verification of indirect var-off stack access
Date: Wed,  6 Dec 2023 23:11:47 -0500
Message-Id: <20231207041150.229139-1-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

V4 to V5:
  - split the test into a separate patch

V3 to V4:
  - include a test per Eduard's request
  - target bpf-next per Alexei's request (patches didn't change)


V2 to V3:
  - simplify checks for max_off (don't call
    check_stack_slot_within_bounds for it)
  - append a commit to protect against overflow in the addition of the
    register and the offset

V1 to V2:
  - fix max_off calculation for access size = 0


Andrei Matei (3):
  bpf: fix verification of indirect var-off stack access
  bpf: add verifier regression test for previous patch
  bpf: guard stack limits against 32bit overflow

 kernel/bpf/verifier.c                         | 20 +++++--------
 .../selftests/bpf/progs/verifier_var_off.c    | 29 +++++++++++++++++++
 2 files changed, 36 insertions(+), 13 deletions(-)

-- 
2.40.1



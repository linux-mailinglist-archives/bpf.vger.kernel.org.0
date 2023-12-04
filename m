Return-Path: <bpf+bounces-16592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC178038FB
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 16:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 225901F21190
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 15:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43412C867;
	Mon,  4 Dec 2023 15:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiB0FBsJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30747D2
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 07:38:28 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-67a91a373edso26980256d6.1
        for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 07:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701704307; x=1702309107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LoygOWr+c9ZNtymQP6ibNLV3K9K6pJ37D/K5g/YnTxs=;
        b=QiB0FBsJ24NP3rTr4RQzYyMWiwA2Ts4PZckbgHZ8eXke2KUWRxVJLxEQCi/WVDeGj8
         5q6x71mXBz0o1cKWFgkzeeryYP7GRjz8MC3Zf9XFlcRRMDYDpPyJ7PfGKfFvApSS6shx
         x5Tp6Pv0dIkp20z2Y0FwVex6XdYc/PmbBDbpuEwXRfs4w2lNKWUQ1Tnk3UwQzJxc4lr3
         LbRF0xuxQTXEipylzbUUhSEquyyaex1uzI9FEyiRSMXhFz5Xw17uCVHQjQ0Jdz29kg4X
         eFyC5D7F4iCRc4XOM/K5NuUzNuZIcjdv2yIiGi15PRTzjvmdaOsVuzE7welLXl/fsuC/
         jVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701704307; x=1702309107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LoygOWr+c9ZNtymQP6ibNLV3K9K6pJ37D/K5g/YnTxs=;
        b=JjNgqpHWLrsQp4BB5mTdIx/84T89jce/QCHYyhgL3UV43YSNgEjL8BRhdwwSlxIjNI
         azI4poDRDMksXiGfI0m4j5zANgEx0KO+IrT1UbfFNMBR1QcNFTjMcWPeja28YAy/mrWz
         DDgxvcCF+pTmqLR14CoLzcZo67ySuIMBQCDkdU9EWmyPB7Re16BWtSg9p7eUgmKT1N70
         FHDP8v5Dw3qNMRWTEC53hXPW4aSxGkvcsFyq20yjAnQubyhe3BV62oGfmhk/RUs9hSjK
         CfwOODrKMn8OBKYz/C3iDPC8Bfu8lu9JCw5ESkwK4LU8PyPd9NmussQNy6VxBNd7E9kD
         z9VA==
X-Gm-Message-State: AOJu0Yxz/T5FhA6TYQ7OUJx7HYUlGyLjAcVvKD/8Y3FFXUILeln0hZej
	Jprbe1gNGMt2avVhBEylwlrUNPltVldd3w==
X-Google-Smtp-Source: AGHT+IF6aDaImwrBEyzw+rLz8vUfguxatIwBu6TFlTMDPTX0Gd8uyEQosHg5MAiBH0kwpuA+w65M5g==
X-Received: by 2002:ad4:4041:0:b0:67a:a721:82f3 with SMTP id r1-20020ad44041000000b0067aa72182f3mr5306080qvp.77.1701704306779;
        Mon, 04 Dec 2023 07:38:26 -0800 (PST)
Received: from andrei-framework.verizon.net ([2600:4041:599b:1100:332b:1ae7:497f:f030])
        by smtp.gmail.com with ESMTPSA id x10-20020a0c8e8a000000b0065b13180892sm1280450qvb.16.2023.12.04.07.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 07:38:26 -0800 (PST)
From: Andrei Matei <andreimatei1@gmail.com>
To: bpf@vger.kernel.org
Cc: sunhao.th@gmail.com,
	andrii.nakryiko@gmail.com,
	Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf V2 0/1] bpf: fix verification of indirect var-off stack access
Date: Mon,  4 Dec 2023 10:38:16 -0500
Message-Id: <20231204153817.11758-1-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

V1 to V2:
  - fix max_off calculation for access size = 0

Andrei Matei (1):
  bpf: fix verification of indirect var-off stack access

 kernel/bpf/verifier.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.40.1



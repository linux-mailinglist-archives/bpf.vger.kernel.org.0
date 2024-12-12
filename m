Return-Path: <bpf+bounces-46692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 556119EE2C6
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 10:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DCB7188B40B
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 09:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2914720FA8C;
	Thu, 12 Dec 2024 09:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHuGb0M8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E3820E330
	for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 09:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733995259; cv=none; b=SFDqjbpD3L2A+lW4TS0DRgVWiO+X0XhNEMIWFtRipfnz1rWWk7qmga1R69H2RZyb/CeHAUMnmnIF0FXhmDYMSbGhsVmY7xxx/r5BzX0WZCm0pXPIfNiBLq/I3bMFTGLT+edWH7M7HTfqy3JcRbQKAelq9zvv8/5THgXYoD2s/BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733995259; c=relaxed/simple;
	bh=dGvZJ7ZcCqj/RKkcnMG3SHQh4y/RAi9Tn1MuktEK5lo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NCu/UbjnpVgVk54huL80DhTSTW7uyjIq2ifQwctnqOPFT5gcAYCnJ8+vhG38H8oi3dks2Nw0QeIpPjLnD5waJVx0GG5+QprahgbJWJy8d5g89MJs41rGplqrfXVviLR/xS3OrHVI91Sdx9xkuFW/1WfFrbNPUptYKGtjlM9TqyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHuGb0M8; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-3862a921123so233093f8f.3
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 01:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733995256; x=1734600056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hUNRL1gxt/e8Jwrd5BQZnBmhyHx0YKbwJtmiB0ZxML8=;
        b=XHuGb0M85wJXvOSzmNSNN0OBtZO7t+O9opLzvVeHX8ER0xADjy25Wxic4z5FXwMszk
         UjFyJiV8bhd6RhQduIbHLkZTf9CxNbKqpc5YZnPo8GCpqWGTpu1Di0c83HtAt/1jOYZw
         /D3jc4GuW0dUTk+xCGr5D7SY1/vUVcOnNLUNA8UB1azMyPh+iTaKteiNNo/NDvoQGT8C
         lNrlfUEuQEvdfqC9uMC+jupBijCRNzDBO6F8lbOcwSEIGT2xZ6gVlzGijcp+lz0l0PuP
         v3PNYf7Mi6Vh1poJGjnKQlJ51X+MVIZhR2malrcQ2EjyhbBGbSyqlf1dltEBLhOFdHkg
         /Ayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733995256; x=1734600056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hUNRL1gxt/e8Jwrd5BQZnBmhyHx0YKbwJtmiB0ZxML8=;
        b=Tgr99q6zHK9/kdXx8+LKWCVq/aCOiaHYErF1g1AmlTBVi+DUy6qhEMGygqoRay/qS6
         plJVR9Jol7OOnMsEYpGuFSpKEdgFVgvw7M9lxCVkHYma29A4Ij1TC8sRoiXi/Y2U5fTF
         /UuDP/YDHunUfdnJzSclykO7VMMMml/0czrVgMCI+UAfgVFILFBN+VJSddwVmWrdq84W
         yGSZ2v0VcGXCy8iMM2OsgfjkBSO6Ktbo69gS9VpTeFIWzlw+VsDxyjmuhJa3rCiry3EE
         glL7F96o4U+yB/xcvmYE90kNRvZSnjlKYK+Gxg/s9qUar0i40vR3ipR/XSKC6wu0nOqW
         gFPQ==
X-Gm-Message-State: AOJu0YxXB1aaGT6jwAl7TeG0XL9g6D8O1nEXlBN4gXqoLXJ3zZAHphag
	tKeNzzlDWBDG+PnzB9mFz8ASRFinv3z4mghXdSMoMfQyKP4fFsRfeGBHS9kiFwQ=
X-Gm-Gg: ASbGnct5WHOBkXIUYoAE9qLEUnDJwCIbFa84XWQlfAcsWeYJXVQMIw7u8+GYktWT9cL
	vMXJzpzNh4cIGTwd9FtTyA96CIT1kXS6vHuox86s3bD3bGJd1SP8XYiilssHFsA60Ga32La4esw
	gEogqx8k198pQTmQ/BvE8frDEKSKd6v7bFsWIsY3ZCXGFwLtvolUg1uPb5nDR/DU3D+uHZcIrUO
	XbAwqB7QdCs4xFuQp+r9VEV5BipXtthyGPlgLfcHqkplpRwCYOtA2VbjWD+k8S+NmSaIyJpp1xz
	+CFtXt8=
X-Google-Smtp-Source: AGHT+IG8VLsHUCr6YVE+27wPQuIpBEIXAtg+OW/RADO4zm6ua4x0McojQIBvuKlRb6mqduGDsCrzaQ==
X-Received: by 2002:a05:6000:156e:b0:386:4034:f9a6 with SMTP id ffacd0b85a97d-387877dcaa4mr1997234f8f.57.1733995255797;
        Thu, 12 Dec 2024 01:20:55 -0800 (PST)
Received: from localhost (fwdproxy-cln-015.fbsv.net. [2a03:2880:31ff:f::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436256b453bsm10666195e9.31.2024.12.12.01.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 01:20:54 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Robert Morris <rtm@mit.edu>,
	kernel-team@fb.com
Subject: [PATCH bpf v1 0/2] Add missing size check for BTF-based ctx access
Date: Thu, 12 Dec 2024 01:20:48 -0800
Message-ID: <20241212092050.3204165-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=818; h=from:subject; bh=dGvZJ7ZcCqj/RKkcnMG3SHQh4y/RAi9Tn1MuktEK5lo=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnWqgu3cUInyroIXag8Wna1d9Y2B2WzfwfvNmEo1DW MzeMg1WJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ1qoLgAKCRBM4MiGSL8RymaxEA CExABg6/3PkyT5GrVn6PIFpt7NUhLQh5o25oa6Dn0Wk/btpLCK05iSTrjXTuXP+QOhkGnsaK5k63Tg 9uT3ZQ8GxivJ4zEiSMR55XYo54B1vBTI21Tn0Qy4JhccmmscZFz/ZedFkargZT7TICqppzJMz8xDX7 ajgqPds9is1rXUp8DzjzUH7/A8DCei9krfun9SC9E6QjaqMK4U9XuktkgOKojCsIpzyXBKcSC/Yggz PEbd4xDwtMn8nJ2A9MuteFZ/HgLFKKv8IYV9CukQ1NAylM0x3UBhFuF96oKFGEMg4J9CHEzp8AKXLr MnGB1TQJXC147C4Df/pLnwHAoS34qYVER4GfgsOC+Ae7/TSowYFa5a8jifRKnsjmGOuPHsH+v5Fo3l ukH8Ka9lK6plIi8ZvwROJ2nsuuCmV49IXi5l7bCn7wwLHYMzfQ4VEqt0pwGe2XKAIgr24ttHseSKJi fimqLKViEJf2iKPSq3r+LspzE3imyP3KXUjP7JT+WRzTh5BPcEfIydOpSpzL8KHkLTXAjX7Qo2ROVR 1vHAH8IgqY35rgyR7Cwlhkosub0xnSNFrOKvE2PDaFlsZlOqxeTU/X9AAbimw+t5+s9Dgck30S7SXG /9bsBFL4JbUBK2sRvnJpjov/946rWMTFEbiVie3jdKyiXO3dEnZ4nX2OhcyA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

This set fixes a issue reported for tracing and struct ops programs
using btf_ctx_access for ctx checks, where loading a pointer argument
from the ctx doesn't enforce a BPF_DW access size check. The original
report is at link [0]. Also add a regression test along with the fix.

  [0]: https://lore.kernel.org/bpf/51338.1732985814@localhost

Kumar Kartikeya Dwivedi (2):
  bpf: Check size for BTF-based ctx access of pointer members
  selftests/bpf: Add test for narrow ctx load for pointer args

 kernel/bpf/btf.c                              |  6 +++
 .../bpf/progs/verifier_btf_ctx_access.c       | 40 ++++++++++++++++++-
 .../selftests/bpf/progs/verifier_d_path.c     |  4 +-
 3 files changed, 46 insertions(+), 4 deletions(-)


base-commit: 7d0d673627e20cfa3b21a829a896ce03b58a4f1c
-- 
2.43.5



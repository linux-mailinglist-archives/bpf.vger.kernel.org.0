Return-Path: <bpf+bounces-39299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4750F971362
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 11:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E736E1F24650
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 09:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11261B2EE6;
	Mon,  9 Sep 2024 09:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EG4XSgUo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D2513635E;
	Mon,  9 Sep 2024 09:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725873912; cv=none; b=hp5h8nLktNSvZfLbzB7xvutQPZOz4isPtvK8hvdSO3Vlq3Cj835nD0gNFNJBvPuEI9DYEkurspfX8pH+He/PXMlG1wcPqsteBaaOHFOP631f+OUk3TTV6S1MKjZfS0GC3763FYNtnAQl8lLy2wVL3QNz1sUsbB4MROXKhxKnUV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725873912; c=relaxed/simple;
	bh=f9doZcjVFArASb9dbYt2x5+a2iHWNwoVPGEanccSp0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WDxgRn0h4TaCSKmiAyfl3ANhKJHmBEJaZsxUOlnptOl3o/dtvLTyyp0/jXFbn+f1SLpBnVBWp63h4BJ6QzVPUeUplESyjbFDfgNeOqqyp3o832Dxeii1kKk7H0MzeEQ/4NTLwnLgd6m/ySGEWkWA0g1Rt1Ax9XUjAZlWn6P/hUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EG4XSgUo; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-374c4c6cb29so3720753f8f.3;
        Mon, 09 Sep 2024 02:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725873909; x=1726478709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wToLwRna9wIBAJfs7h3uLbgF0mg1/0PdR0cl9lfLUXU=;
        b=EG4XSgUoMznUvQ8WD+g2mPpMp/VhlU5oqNat+yeKd1cabbJo6tehu1VPaSmo1pMh7+
         WoJIL5hOLb3UaKepXCATOdEWEzx7dbnR0EH2Mww+5HCmWuR4RxUjHRwEv3oM+ZusCoMM
         PEwEdJ/N88dMTM9PBGwT+SgbjBSi8cwHOl5GnY5y/w5NKZ4tXEEhR3UrcVU1h0SfDMTj
         LNIloCN7bhjgsMIYLdd03Q0XwPd+xhbSZQtLD3D1RFnZRcd796ytZIx8IHBe2JgPDohv
         oqSjZtEjaeGx6XfL3VPMZ6eXSGedRRpxCtQT+CqqnjLBqPDEh1GGcm2Bz6FvpwkOkdSx
         HXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725873909; x=1726478709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wToLwRna9wIBAJfs7h3uLbgF0mg1/0PdR0cl9lfLUXU=;
        b=T8fps3Tu1cGZOg86eBi4qtv6t6QCbgPjjIEfmXLJusnmsFZpEiVK0ONir2n63coUTf
         vEp0hTniQR5ZQGRESaNT1tlzM9zpvsn/F6Jx9IUb5HL91E9sQxlnDN4Quajswbp/OmYg
         dCpPuRBTgbvHub9WDbdamOXZhO5DKEFlICn0Wpg4eqqZVgPwcZ5TiFqg4aNaBB1J0c4o
         CErzZBvvG1Zbj8dTFhVDO8EOD159XDwgj+YjQHuh8kqaBnfx8VCm783fwrn0tN2T4rqn
         TFrxpR3fOU7+XDLCEdjFYcakHzv+KBz+SUKGyRGGpiWzJQl9KQdezFedu0ia+mMSvr/o
         kwfw==
X-Forwarded-Encrypted: i=1; AJvYcCUYJfYMQP1Rh/xr6M7W0rNyg2m12svyDwn591VKu9OYsDqSWviYyfIj7pcyIvhFgXo7KvH443KLo/UJwPusCF0=@vger.kernel.org, AJvYcCVHTFXd5UMonLWKE3j7fbkw4DY3sSM32+ZqH5dX/5kNBWoTunLQply2yBKrK1O3+5I+a5Dqz8UjP/bABKOg@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3QOtgr4RM1KgSWdk2kRmVn07Ef0M0zu7tU18dTsN560fJqcDh
	w7wPQwScIFGEKOkfg4XRn17YKhewPfNd/Mlz0tU7KclksTSvoxFy
X-Google-Smtp-Source: AGHT+IGuOUZW8JfB1MsVbsK8nG3srNYZ5a1oDKhL7eNUhgRJB4Sg7lULx1UNOiHkNAnIx2BP3nZ//Q==
X-Received: by 2002:a5d:658f:0:b0:374:bd01:707c with SMTP id ffacd0b85a97d-3789243fd50mr5494083f8f.48.1725873907992;
        Mon, 09 Sep 2024 02:25:07 -0700 (PDT)
Received: from void.void ([141.226.14.150])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956653d1sm5481129f8f.33.2024.09.09.02.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 02:25:07 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2] bpftool: Fix typos
Date: Mon,  9 Sep 2024 12:24:41 +0300
Message-ID: <20240909092452.4293-1-algonell@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in documentation.

Reported-by: Matthew Wilcox <willy@infradead.org>
Reported-by: Quentin Monnet <qmo@kernel.org>
Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 tools/bpf/bpftool/Documentation/bpftool-gen.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-gen.rst b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
index 1b426e58a7cd..ca860fd97d8d 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
@@ -172,7 +172,7 @@ bpftool gen min_core_btf *INPUT* *OUTPUT* *OBJECT* [*OBJECT*...]
     CO-RE based application, turning the application portable to different
     kernel versions.
 
-    Check examples bellow for more information how to use it.
+    Check examples below for more information on how to use it.
 
 bpftool gen help
     Print short help message.
-- 
2.46.0



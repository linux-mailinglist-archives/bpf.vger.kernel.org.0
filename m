Return-Path: <bpf+bounces-39194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF5D970473
	for <lists+bpf@lfdr.de>; Sun,  8 Sep 2024 01:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E71841C20FF8
	for <lists+bpf@lfdr.de>; Sat,  7 Sep 2024 23:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2442216A935;
	Sat,  7 Sep 2024 23:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdmPObxu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1645814F109;
	Sat,  7 Sep 2024 23:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725750651; cv=none; b=ayAGWqs8sbVOoCMpGuAynGV3zgkqpjioGbe3z92OGIu/zVzOwqMWSkeSSq8aF/D1LebgwD9l0EvY6pI4z1F26pNk3O8f09aIzP5r6jMfQ+kh+otpin6JgqwKfT9QyUtMP7S91LrNoItOOrZlmje4R73PJ7O5kBiN3D726/b0Nio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725750651; c=relaxed/simple;
	bh=l2kQYB77bC2AxhU+af9yBzS2fBMywHuBKH/qnAgGpeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V+/iEeW1mqsJ7QMETA22jvwDd9CkxmlglHVrQlkXYUzlfsmalXAdY12MB5DsOmNTqOcedMh9oV3eT/zmthCpsvaRjzUx6VsFX1FT3QwuQ/eIPzAMnAtmK14efoMeXDnd22dqRi2dPXeJsE1R/1XGygWHBJMdw5BPSL0WYeSR8J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdmPObxu; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42bbbff40bbso26789415e9.2;
        Sat, 07 Sep 2024 16:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725750648; x=1726355448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yT3dqWHm/QQeGC3GsIPG3eqkFd/IFt3zVxvD83TpSdU=;
        b=XdmPObxut5yFEMq/QCe3Qm3ntSLmdMQUfuLuxE7KIMA3RHB0ytU7u9nQZaVV/6LrDA
         ZmIaMlFs3O3wPtBc7/OaD4mPW7j8ti5doSe4nMqxT7Cj4MD/2Ln2g/6XkP+z3XrmiiQS
         S0QrBKdnUsoJ9M+kmHbMR9+sn3/OwQgVyugAT7m6a1+b07aqgCyPdhjd8Ak8e44rwZ60
         asJKlRmAUVXWNOm2I1jLZirKCwwOHT8XPk4h3kk6eTuCC1jm/HyX6BTbrmffE70jc4rQ
         t32OIv36/Op5NS64Yd1tP6qxPyu2icIRvkK78psXh4X45+bNKARQZ24G+aDff3DARkS1
         Qxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725750648; x=1726355448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yT3dqWHm/QQeGC3GsIPG3eqkFd/IFt3zVxvD83TpSdU=;
        b=qGDgPSNv6pSeUMi3CJbB48mBsaNfpj2zO7HwuvZnp8enyC6vqx4ESbUt2Obi525a2T
         j0pukeAXoJeStkTeu3bYQx5tz9hqQeCUhbLl6Z/QEFncn2OXO3P+oTdLgY6XbeWt0/dH
         U/xyq53WIo2IhLUL/JKY1E3DxmbnjIqLncIvX6fb7K1fQuS8X3eLKARI3VSF6e1PdLN0
         Y8Vl06DZxpaWSuZumtyY9HwULazKASzEOMvC7+v+gE8CQ2rt8lKkFype0J6DU1xS6Nwv
         pmijqExig69d0IQagbx2wW35hGr8ESWTkqB01/X31JNEvP3zdB6DR2x8idaTXzdVL7bB
         0NYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/DGkur4YwHWShaqb2vy+5G0+iMXxMhaqDJGidmdIr/mboWUQREqVZLv9uvdVtOSjplA2fZsvQF3nZ7Hcd@vger.kernel.org, AJvYcCUxPWxv5Z4DPxc3JN+HtNXije7z578SvDjOBnLNt6QE8XlWhY8pYBBcxyrgWUM1qSxMIcgXSy+ULGf7t+AEBVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK+E+cQ/2Tvv1dB+/BWW6g0a3LSAbOc6hYfuzf3EX+iCLd0ZIH
	NBcTHRbB9Y+Us/dUuD0GCkzxpggM8Lo3oOCx6PD6C2ZNgrCNWqvn
X-Google-Smtp-Source: AGHT+IGRlh7xezCJGsZisParei4WZZPnc8M77SkuN4s19NYt8Sx7WPkDUFWcZGbzQ038g0whCgsHAg==
X-Received: by 2002:a5d:4b47:0:b0:374:c56c:fbb4 with SMTP id ffacd0b85a97d-378895c9ee0mr4444881f8f.22.1725750647370;
        Sat, 07 Sep 2024 16:10:47 -0700 (PDT)
Received: from void.void ([141.226.8.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d363asm2232537f8f.72.2024.09.07.16.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 16:10:47 -0700 (PDT)
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
Subject: [PATCH] bpftool: Fix a typo
Date: Sun,  8 Sep 2024 02:10:10 +0300
Message-ID: <20240907231028.53027-1-algonell@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in documentation.

Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 tools/bpf/bpftool/Documentation/bpftool-gen.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-gen.rst b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
index c768e6d4ae09..6c3f98c64cee 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
@@ -172,7 +172,7 @@ bpftool gen min_core_btf *INPUT* *OUTPUT* *OBJECT* [*OBJECT*...]
     CO-RE based application, turning the application portable to different
     kernel versions.
 
-    Check examples bellow for more information how to use it.
+    Check examples below for more information how to use it.
 
 bpftool gen help
     Print short help message.
-- 
2.46.0



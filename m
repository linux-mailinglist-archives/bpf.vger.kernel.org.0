Return-Path: <bpf+bounces-59999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A388AD1059
	for <lists+bpf@lfdr.de>; Sun,  8 Jun 2025 00:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66F5D7A685D
	for <lists+bpf@lfdr.de>; Sat,  7 Jun 2025 22:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6F5215F56;
	Sat,  7 Jun 2025 22:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwzdHG9d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6580E1DFFD;
	Sat,  7 Jun 2025 22:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749335119; cv=none; b=oU/qlEk8sc8NkghMse3+Qh7v7QP5uGru8dZGEJJ6V/picbRkowmKWGLuXRGsVE7yUCBNP7VGxnKGAL2iu4/WKUDWzUfhPYX7h4yp3tSV/sd0fDDReg2OM8oyTOuT1toQCUzuJYwcN5/gO4ugBblYlMkHenTW5CCUSdM2MsATMyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749335119; c=relaxed/simple;
	bh=BLnpYT3tIjxoOgloeFcWLZNjx3PnOBfRHMI8+URAW1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k+5WwL22edarIMLVlets16KTYEGhAnN7pnH1ivqgQadpAVS7tnG1thaC07kY7196sybx8xrV8qhsFK5hGBH/N0y5AuF1XblfEJEs/OfQj0CNo9pKwNo2x8GZ+18PGxR89kPuKCokUN25rz2UkUY5m9KF/XNY4DWQHVbqw7oQXYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwzdHG9d; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so25199595e9.1;
        Sat, 07 Jun 2025 15:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749335114; x=1749939914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sea8Gg8ezTMJqHnowDTp53rVa8UnGfLbbrawMe2YBRQ=;
        b=DwzdHG9db8gNTOYUGAqjvWr5vTvTScp7xqD10IyspQRVe+CqAL6u3u/475zy9JE2ZP
         SYStZgfj1qh3qXe0bbEBAsR4x2XxfJtDFPPjzZwZWnCMyY9eB7yZ33iyM45veHqEYihI
         PAr+NWCEp1dhQ7ZlaZzmjk2vNrCbNFEXB95+mS/yJDgxigUkPrUjI5vTJvdZ693e/jw+
         h4lno4zqNGAjj3r8KaxuCdr5kVdYTWwUR+sOn8bYk5j6XS3wg/sRCGIltS4ciGD3SrFZ
         uW2wpKQ80tBcLamN3OKK4UU92BUj9oTJBUkusJVS6qGa2ewp/6DcKWiJHesngJZu3+tx
         NS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749335114; x=1749939914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sea8Gg8ezTMJqHnowDTp53rVa8UnGfLbbrawMe2YBRQ=;
        b=bfIv9opqThENjx9UQ+gvOCjsSC0/696klsPKIEQs1po25L6B5DJ+EQ6GS1he8f0M1Z
         d+Ivh5Y6z7YKlgMKlYvug3gRJoluCj3b2ksEeRA/J9S5TkdFhlQ8zoy27FylhqKOCglL
         rNYMB2c83ornVpujk3FhSIbJCFrkzaJEaXLYTWh3pqE+vdJXNsfxII5HxmSEBvzlG9Dk
         bWm25WpmOz9aTC3FXrk3vemhU2FE+orP/YoHpy6VaGHb9oEqivIxgFJiJtigk2fun76Q
         ukBogV4cocNwI/jVzZ7fuTbXwOal44of+YMWlMN8XhYlMmwVxkhZdeBU4f1Ik2vPGaTt
         8UNg==
X-Forwarded-Encrypted: i=1; AJvYcCVHe8RkFiB9qwO3MVPgqKxSPOkJqUrIqMKTcaznurDd5dKn6V0RwUbT3thSjwqAel3HbrwueG4xvFRW@vger.kernel.org, AJvYcCVbsse5QtV2WB8xH4gs79MhNU+g8y7xqSyRcuo1vj1e/Xm7b5fF7YXZ0zDZIlbcPRoRFlKomPcggxV3aclL@vger.kernel.org, AJvYcCXkWpsaPZDoXWaX10n8Zy/yUvwjizv/7DQpFLs9OW/m5Z1hv9M48VmX2jipS5tAHKjd3Bo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWdlWXKFToH7RCYUfiw6J94p30LW196hmlNHJSJZB2VfG5cnOS
	E0Wen0iOSATvUbSUU0VUWHqMLyVoHtDb1YjGyFtKCZV3pWlra9dg0gsV
X-Gm-Gg: ASbGnctENkG5ssk2FQaeZ0cQ8P7YPlP/xK+SOns+duNzfGdIYMKejWW7cyeRHbzK6K7
	vO94cZ0bGGEIr4cnaIRdsbEz4wT/IR9dqMEKcdTV9iEU3Reheu0fMZjprDJARHKxVaUqMhRp/03
	ogRZIzFw3IxecM2gzw+fgwzFIJBANLCVCcq/2ByiTG7JQwvIrqkXU+SOWjXuJixRJfG+pRNweBx
	7uEBOF8VwXnE8oKyaR2XT4/IN8dm409kf0RKuC67JB2u+7ULtPWi4NnR3a4KphcDsuyQwCi+5A/
	k80EjyRl8oRxtIyc4lRhJwg3/JmnuPBwFQnm4rwRAkP3s8nlcTnEaitdmj5BnwLlTfIHpQYs3Ro
	knhy9jhS0y6v0xj7qFsYYRIy8sOo=
X-Google-Smtp-Source: AGHT+IH2kxAFqwhXhvh1J4Q6sLDBM7OkVBUQneiruJ6EFCVe6l7dbSq4sqdx2KY7TLILAfMMiSUwAw==
X-Received: by 2002:a05:600c:3510:b0:43c:f509:2bbf with SMTP id 5b1f17b1804b1-451f88d836amr128626825e9.15.1749335113330;
        Sat, 07 Jun 2025 15:25:13 -0700 (PDT)
Received: from ekhafagy-ROG-Zephyrus-M16-GU603HR-GU603HR.. ([41.232.132.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5323be604sm5546262f8f.42.2025.06.07.15.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jun 2025 15:25:13 -0700 (PDT)
From: Eslam Khafagy <eslam.medhat1993@gmail.com>
To: 
Cc: skhan@linuxfoundation.org,
	eslam.medhat1993@gmail.com,
	David Vernet <void@manifault.com>,
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
	Jiri Olsa <jolsa@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Dave Thaler <dthaler1968@googlemail.com>,
	bpf@vger.kernel.org (open list:BPF [DOCUMENTATION] (Related to Standardization)),
	bpf@ietf.org (open list:BPF [DOCUMENTATION] (Related to Standardization)),
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf-next] Documentation: Enhance readability in BPF docs
Date: Sun,  8 Jun 2025 01:24:25 +0300
Message-ID: <20250607222434.227890-1-eslam.medhat1993@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The phrase "dividing -1" is one I find confusing.  E.g.,
"INT_MIN dividing -1" sounds like "-1 / INT_MIN" rather than the inverse.
"divided by" instead of "dividing" assuming the inverse is meant.

Signed-off-by: Eslam Khafagy <eslam.medhat1993@gmail.com>
---
 Documentation/bpf/standardization/instruction-set.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index ac950a5bb6ad..39c74611752b 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -350,8 +350,8 @@ Underflow and overflow are allowed during arithmetic operations, meaning
 the 64-bit or 32-bit value will wrap. If BPF program execution would
 result in division by zero, the destination register is instead set to zero.
 Otherwise, for ``ALU64``, if execution would result in ``LLONG_MIN``
-dividing -1, the destination register is instead set to ``LLONG_MIN``. For
-``ALU``, if execution would result in ``INT_MIN`` dividing -1, the
+divided by -1, the destination register is instead set to ``LLONG_MIN``. For
+``ALU``, if execution would result in ``INT_MIN`` divided by -1, the
 destination register is instead set to ``INT_MIN``.
 
 If execution would result in modulo by zero, for ``ALU64`` the value of
-- 
2.43.0



Return-Path: <bpf+bounces-41460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD16997408
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 20:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9713B2607E
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 18:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1311E1C35;
	Wed,  9 Oct 2024 18:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThhSi1Kb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230D61E131D;
	Wed,  9 Oct 2024 18:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497113; cv=none; b=q0i4ms0Guyy0YZmatVcR1yJWg/rgIpOjUPebpKfPL8zWvXKri4xVf+6Knjpqq0AugkquTpjKHgVQcesbFZR6ApxQhX7LH3nG3Yi8kO3YhOCJjYeeITjJ3VAtqpxc4ARY+fqyfNWTnBZo6vvYoH9JgeZRX3lY2JsocMT+2O2DoJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497113; c=relaxed/simple;
	bh=dTst3TzcEyw3tRqilTUktgkbQoYxklC5Ta/NvbE8BKw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JsacD37Qd7nsMv7PieaiVI2I4cHzzJ6yiUUI+s7Z3e7XI7eNONEiwCbks9jEdWsNm8bZWajD8rsrG8yncWDF57L5zVzPwlhAw4+EtLeMJP1c51Z3RRdD3ShRdCTskrfQA4zJFQ6TMCtGaaKhsbM+d2WmIIMM5PXozZAlaiklZAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThhSi1Kb; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5398fb1a871so9316e87.3;
        Wed, 09 Oct 2024 11:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728497110; x=1729101910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cg5cj1gCluVnGdiYqSgBY4zdUcGWuMAkq5T51OVrPiA=;
        b=ThhSi1KbJXXFB8A7Kaq47AW4O1LQ7vRFyKqq4RXLL804H8EcBr9aljKeTJ7Xg37NdP
         5H+3pdMLhjTuX35Lk2N5YFlZOT+95brybkiDceonKZ/058tAUniGyw0DH8hKh5qduPyT
         0umJ4oUrHIBiGk1pR268pa/n2YMDcUrOB8Nxwg8DwgBPynOWyQhlifdEU6unyqxLYj21
         8fhiFvgJMpUkV7Wi/JZ2ADbih3rHBvsuFrgRSaYmgS3MaRcqRAVf+xbfVaOlnGMqrz73
         c/76t2FDtkWMIGDp9hKRfjqaN4k5Q2k9W/qlj3TnYhXbmH1Bm/qkbUbVtm+1AkshjjJ6
         DXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728497110; x=1729101910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cg5cj1gCluVnGdiYqSgBY4zdUcGWuMAkq5T51OVrPiA=;
        b=OoJHjzFTlSImX4mX0KB4GnXAiNKyYWiQisRGqI67riatmKmuTNPSM0x36LYI5xD7ER
         18ZtRtpHC/k58epkG0c0KnX3aRSzGj2izDtIJ8cHNrjwUVHyY9NcvAI/BTuJRtJRZKp/
         9IAQ2gaoxizSaeLgVVijEP6AZMQ+JCSsALGEIeLPf9B0yHf67j+le8Teb3ckvaPW/OE6
         N6YKmbOcoGErQDlx7rwJcffPX7hpdvH5S/uVBuu1gO3NoKAROihP5zymFa92N0vgMxFl
         A2P2a6LcKLXGQWD0U+bD++fHhKSuMAvbl7sYdGLprYNAHtOPpZkpfpq7qzCXciCmv3tA
         SBEw==
X-Forwarded-Encrypted: i=1; AJvYcCVxgdqwr7W5QznZaTKXMJ0ToO2CIoN6jz54OBvaQvCO+AFbV+3Gr8Yxw8aEyrgOqEx4JcY=@vger.kernel.org, AJvYcCWrLg3xkWHCEddC+eq5EdybpIGbLDIpW7lZwX+mzuuDxV31e+ZpgxYgY0WuX74lRq3bQTAeeB9drvV6Ikuh@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7RiFJrRyPJ1IvDbwv9sh7HkpKA4ZqM4yL7IPnNgA6iaG55UGo
	oa7IqCOUyiNSkdv3Abm++tzD6SZSa2GlundCUB0P31BWq5Q/BOT4
X-Google-Smtp-Source: AGHT+IEjRBA8jNMnfVfMn7a9XGrUXb9Bhm9Z7vnut0to/79rWfwo+X0c7kx8GI6nz487wAaM691i2w==
X-Received: by 2002:a05:6512:3e25:b0:52c:e17c:3741 with SMTP id 2adb3069b0e04-539c4892c13mr2452171e87.5.1728497109987;
        Wed, 09 Oct 2024 11:05:09 -0700 (PDT)
Received: from teknoraver-mbp.access.network ([89.101.6.116])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1697024fsm10972801f8f.95.2024.10.09.11.05.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Oct 2024 11:05:08 -0700 (PDT)
From: Matteo Croce <technoboy85@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Matteo Croce <teknoraver@meta.com>
Subject: [PATCH bpf] bpf: fix argument type in bpf_loop documentation
Date: Wed,  9 Oct 2024 19:05:00 +0100
Message-ID: <20241009180500.87367-1-technoboy85@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matteo Croce <teknoraver@meta.com>

The `index` argument to bpf_loop() is threaded as an u64.
This lead in a subtle verifier denial where clang cloned the argument
in another register[1].

[1] https://github.com/systemd/systemd/pull/34650#issuecomment-2401092895

Signed-off-by: Matteo Croce <teknoraver@meta.com>
---
 include/uapi/linux/bpf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 8ab4d8184b9d..874af0186fe8 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5371,7 +5371,7 @@ union bpf_attr {
  *		Currently, the **flags** must be 0. Currently, nr_loops is
  *		limited to 1 << 23 (~8 million) loops.
  *
- *		long (\*callback_fn)(u32 index, void \*ctx);
+ *		long (\*callback_fn)(u64 index, void \*ctx);
  *
  *		where **index** is the current index in the loop. The index
  *		is zero-indexed.
-- 
2.46.0



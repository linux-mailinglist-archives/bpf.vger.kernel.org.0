Return-Path: <bpf+bounces-21553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C4884EB73
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 23:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E91931F2CD24
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 22:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D36F4F21A;
	Thu,  8 Feb 2024 22:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="FqzfZBO+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2554F603
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 22:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707430495; cv=none; b=irhydB4y7Plp1jbS5Tl0TPaRNvJs2B6gu7vO/wFW3ChhqshW69KGtGxExa+cg8/BZF0GXpokYz3jWbHWXjewMeJUgswzCUk9tZiGaPOOtpLnQHr2kkzYa3quq0MOKM/qqXhzWfb3geodj2vaj3GY2e5Vjmk6PhzE1hKJ3SCQCBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707430495; c=relaxed/simple;
	bh=KBgjCSfbctojtJG2AQu7QX78zPZBvF41zPWL1dvCiVA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NaHtvJajODxw1SRMWsYq32cLcV8Jo0bgRc+qIwZn4/oP9YQAjb6HvULJo+wajcKkNmjY+aalwkHl2Jh8GrcyS6oEGQII4ZMq4k6RPI04bFtq8Bhrs+6wo5tcSTOIjyM6gwrLnE6joXHPUBY8KJ1TFJ9ix8s5eDD3LBOk71PvNyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=FqzfZBO+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d93edfa76dso2598515ad.1
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 14:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1707430493; x=1708035293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TslwQ3ipme5SpeiZwhrffuh7Ucx5TElMvVQFOWDiWhg=;
        b=FqzfZBO+ptegK9syvB6uzPvOnLcZhbwRlhbwTOTpKYLhyHYTZk+vlKrkMf86hw3QNt
         BVZArI8g039SnbuIeV+q7l0LOEAe6ozszhdig5Hz7GOH88X535IqCJmpDTstd/lB7xfC
         3PaulRBJvKhtSkQoQKn23woE/ovV6m696ZCCTQK60qygNFsok57ss/8x2dGucYrB9RX7
         gt1qEnYzk4AjxylmFZpVnMNMNXbH9zEZwMHpfiScG9JMz9m0OtVI0+7khmgGOme91t2r
         /wq47kkSICvQPNEyodAubQhmt8p7dRUFCHBuPfwDNLI8alEg8bogwyGPHWKYVCJ81wJx
         hJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707430493; x=1708035293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TslwQ3ipme5SpeiZwhrffuh7Ucx5TElMvVQFOWDiWhg=;
        b=rycYx8x37wKFeu4POdJP2AAmW3FmXD7ME8DU7ZAH4Re/MTv39xUKMsR7uZhC201nNy
         NAmAahkvtpOq2dQnywPn2FT9jhSeinsa70zcTTOWubrElknNEt+VTkkh76ewDdnjyHjM
         QBB+QUMhBaReKAJEevdIwLIz/bfiGZUw+je5D/q1JhsA18g84lQIyFoNpJm2qBfjzEnQ
         Ah1KsBvIBQFN+0MxhRgJeh0p2Tc251mCDJWuk2W0Df3X0anbRBvFkZTttVyP1ZnRJ19s
         EsaM+loiUDKsHb/aXLqCZGwio60gaO7GWrq3TaNRJnksGkuKRfaeRUmAdy97UkUfw2Li
         sf4g==
X-Gm-Message-State: AOJu0YyBikv6dhTd3tKFtO7g7HH6VVTO+7I29nhPx8khQoguSQqNqUuL
	IUpIrSfc/aOzAFWP/bPTDeV9q1eNMXjgJAecPtfLekJ3NuGEtSApXpDdtOsH/6c=
X-Google-Smtp-Source: AGHT+IGlQKtqpZZdyVe6q1GsedLmcNPuTDXqsROPx4fWCP9+iM4FCz/SpuO6+//xJghMpqAivI9VmA==
X-Received: by 2002:a17:90b:2317:b0:296:6bd5:42df with SMTP id mt23-20020a17090b231700b002966bd542dfmr668554pjb.38.1707430492615;
        Thu, 08 Feb 2024 14:14:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWVdW+bbu50ZthDHHoaBIIM6AjYliuovtdpoQOiVEQ9s0by2iwqmbh1a29BIdYs6VR1HfP1IefOwGurrkZWmw2Mj5h5OMQ=
Received: from ubuntu2310.lan (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id kf3-20020a17090305c300b001d90b9ec345sm259465plb.114.2024.02.08.14.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 14:14:52 -0800 (PST)
From: Dave Thaler <dthaler1968@googlemail.com>
X-Google-Original-From: Dave Thaler <dthaler1968@gmail.com>
To: bpf@vger.kernel.org
Cc: bpf@ietf.org,
	Dave Thaler <dthaler1968@gmail.com>
Subject: [PATCH bpf-next] bpf, docs: Update ISA document title
Date: Thu,  8 Feb 2024 14:14:49 -0800
Message-Id: <20240208221449.12274-1-dthaler1968@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

* Use "Instruction Set Architecture (ISA)" instead of "Instruction Set
  Specification"
* Remove version number

As previously discussed on the mailing list at
https://mailarchive.ietf.org/arch/msg/bpf/SEpn3OL9TabNRn-4rDX9A6XVbjM/

Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
---
 Documentation/bpf/standardization/instruction-set.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index bdfe0cd0e..868d9f617 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -1,11 +1,11 @@
 .. contents::
 .. sectnum::
 
-=======================================
-BPF Instruction Set Specification, v1.0
-=======================================
+======================================
+BPF Instruction Set Architecture (ISA)
+======================================
 
-This document specifies version 1.0 of the BPF instruction set.
+This document specifies the BPF instruction set architecture (ISA).
 
 Documentation conventions
 =========================
-- 
2.40.1



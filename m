Return-Path: <bpf+bounces-59852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDDCAD0009
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 12:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59F8F162ABF
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 10:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32AD286887;
	Fri,  6 Jun 2025 10:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FogBjyXj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C060981724;
	Fri,  6 Jun 2025 10:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749204343; cv=none; b=L8qRiR4A6tumb+FUU7A7QIexb7vP+6UUWiXT+NE/wVdomYQf8RajWuDh5joS6et87Xg7mx1Cx61+x2fnJE+o6JbxD7558ERSrmIIh3ZOt6m8CzYsfElMJbRVPHv8pqlTOanmIL0n5FLYTVLfJwWPVrRYHm0dR6ixshrsJEzIp7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749204343; c=relaxed/simple;
	bh=I9QfnjJpp1IHLl4r9WsdAMzzwXNE41MW2uuYdb9xsww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=InA6gqvq5kFt0Y3oZmwsZAbTxRaoxe2qtRvgGIqX7OEwsvwikxA9SMDLrFHLuMqkFJ+mBhX1cjCW6A+7rExe4zyUbnrTMfX4J41jmKqR1PPFTnUfnNbNt04vFqDDMorjHu40uHNZFKScHTOjwwxGkUj04RXkEFGiegxYN+Y03HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FogBjyXj; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-451d7b50815so16891665e9.2;
        Fri, 06 Jun 2025 03:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749204340; x=1749809140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WjnxTpZiZMmemhu9+gN3x+mfAc+4/4gkspcZdPB3RU8=;
        b=FogBjyXj1XsgfN1x2WQ9eyNYF8r8leA/RUOb1dCk1n2r2wdNKrPW1WQrSbQwJohRS6
         R0rbOuioXKhElUFul47hYzRXK2AtAcukO9Lc6opCMPnwcrIdR74Hl+F7AM3aYW92m8Y4
         Fh4q+WuYyOCVn9to6KYqFcq5N0q6y69UQLosOAYvnznWFkl5poGG8p0BXPh/ozXeoJoe
         7h2okjL+i+yyKWBpS/KCkUHlCrbfTuOk+9n0sXKPtU3OURPxOPq/FopKBm6GrxD3I0au
         diGsqctSVvMg8jiI/QxmEwzHUGKntq/LheAS9BjGkft5Np4EbSAH+IKADq5zPkFAPWGz
         RwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749204340; x=1749809140;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WjnxTpZiZMmemhu9+gN3x+mfAc+4/4gkspcZdPB3RU8=;
        b=eAWk5qop5cPw3fVUnIO0oFk8XLzKMgrAOfERRUHCSGmTAThEywyqOJx1FVK9SNpKEp
         8luUZuxnC1d1Ee2M6VHVsze4eu9x3S6gaccItG9etMVSsA6H+X99dkxZMvpi2rtZJZ5Z
         AG4JrlvF4VdNzHA6Uandw/7aRhzp2Kp66s+yuHLtOBgqGOAY9DMR8Tjs19oDAgK4gvKe
         xIcqCdxbuRii1iV6KfvV4GWIvoIYA4uAENq27RCLMFHbF6UYWoieujEF7jjtfkgU69LZ
         YEbdIlQ2Bvttw+1DnRTQXbEj70Sqp9EgIqyybfvMhapK6zNJlSWozs4qS+VGV6hv1SN5
         /u7g==
X-Forwarded-Encrypted: i=1; AJvYcCWtn52bMZhcC8EnM6uMQ/lDBstOsNGvf7lbEWIkgZEhj9ziSP2TpJ4z6tJv8rih4mW/uDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY1NEmC8GG25hCMgox8LxhFX/X9WK1yPUXdpHxelUXy3k2GFf+
	ZrPga3nMFBWi+kxAErFpd2930UOjFMOFiWR+yIy2Jz2rX1IT6muyFJfTA7VRLUDYVpEbHQ==
X-Gm-Gg: ASbGnctsqic7t/HSNf3ZBzMpRT0NGygdmWc4dMQhFFBwXuh019c/32mM1rpTqxFj3Ng
	XpyViPjXXmWh3G8gSWZcXJdAOyD0MpEnLGPCD7sAIQpAAmDkPAVQnHgs3h0az/bDB+4NKEW4SnS
	RV82WFWCT3Ty3zVWEad3+x/GkNTWyY8nl+L17YNUQSrfE/c3KBI+63xeQGyv31KrQet4FjSMHW5
	ZDXKluQb/FX5zFpQRh55ZJy0jvRVcbYonLgG4/4iLDT85fTVRxNWLJyZeVUyMDw+eH7xn9M8j/F
	z7ggnOeDU2zTakJKKSbexIMbkVtcAPOv/xyHiqY8gRMI5V2xCseGOvfkrAqlkJC3xvnRRSC9hxJ
	EuAoZFsocyy+CQZWtiDLCF7X8Rn0=
X-Google-Smtp-Source: AGHT+IHSOXrvYeur1SPB4BIR8D4sBFs0wkN8Oi5xSNd925qiAYZ55JlxY+VTLu8xLk2WemkqZZZcRw==
X-Received: by 2002:a05:600c:4e4f:b0:44a:b9e4:4e6f with SMTP id 5b1f17b1804b1-452013ac461mr30792575e9.16.1749204339649;
        Fri, 06 Jun 2025 03:05:39 -0700 (PDT)
Received: from ekhafagy-ROG-Zephyrus-M16-GU603HR-GU603HR.. ([41.232.132.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4524d8af1f3sm17064995e9.1.2025.06.06.03.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 03:05:39 -0700 (PDT)
From: Eslam Khafagy <eslam.medhat1993@gmail.com>
To: void@manifault.com,
	ast@kernel.org
Cc: linux-doc@vger.kernel.org,
	skhan@linuxfoundation.org,
	bpf@vger.kernel.org,
	Eslam Khafagy <eslam.medhat1993@gmail.com>
Subject: [PATCH bpf-next] Documentation: Fix spelling mistake.
Date: Fri,  6 Jun 2025 13:05:11 +0300
Message-ID: <20250606100511.368450-1-eslam.medhat1993@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typo "desination => destination"
in file
Documentation/bpf/standardization/instruction-set.rst

Signed-off-by: Eslam Khafagy <eslam.medhat1993@gmail.com>
---
 Documentation/bpf/standardization/instruction-set.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index fbe975585236..ac950a5bb6ad 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -350,9 +350,9 @@ Underflow and overflow are allowed during arithmetic operations, meaning
 the 64-bit or 32-bit value will wrap. If BPF program execution would
 result in division by zero, the destination register is instead set to zero.
 Otherwise, for ``ALU64``, if execution would result in ``LLONG_MIN``
-dividing -1, the desination register is instead set to ``LLONG_MIN``. For
+dividing -1, the destination register is instead set to ``LLONG_MIN``. For
 ``ALU``, if execution would result in ``INT_MIN`` dividing -1, the
-desination register is instead set to ``INT_MIN``.
+destination register is instead set to ``INT_MIN``.
 
 If execution would result in modulo by zero, for ``ALU64`` the value of
 the destination register is unchanged whereas for ``ALU`` the upper
-- 
2.43.0



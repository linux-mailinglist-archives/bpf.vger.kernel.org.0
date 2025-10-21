Return-Path: <bpf+bounces-71604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E63BF7E91
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 19:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BF5F50738A
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 17:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA2534C14F;
	Tue, 21 Oct 2025 17:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ne9DUyQi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D3E34B693
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 17:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067933; cv=none; b=Y4QBXXqQMJLJXO8bY2aUl8mItOJa+SRPSs9HmfeDdy/fhGHK5I+saqIThrRHNdjOYF8RxQJorgGsba7T3/6O9aT1/j5jqTC7TvKGcRm8cm3OLyXW2ZlCHKZ/QUMp9ea0QlL45/+CBpZU1ikCJPrnwYBLZ/haToTJU0D2bXP+HO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067933; c=relaxed/simple;
	bh=Z6X3mqZcPYraf2DVQKy1+mGtHY5lO4bJYnXE5CeEFvM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KCFjmNeeEUkmDkYq/CQjL8gK0x8qMnC1NADMxqWSzF6SQ5SdPP25JH7XvH2H/1eqGZ98j2BANaqwqI2oE/BhxqanDYzbLO6lr7g0/vnpiBfOFqkcTxwuyT59ul6mXRVTxFMYvSwwdw2e5si9pHB+1GADn8bsF4SRshckkKdlgZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ne9DUyQi; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b550eff972eso3982298a12.3
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 10:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761067931; x=1761672731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aQ+zArbjDCMGCO6Bvb9dufDVd7PF4/gLdFb+sRMsH6U=;
        b=Ne9DUyQi6jQQJwWvr4DrlTjDDf1bFrIXEOf1fa225G4PlaxZmJZWTVQJngmFQ6GDpN
         BUa6Z6RPQHPTecOOxP5BSLVNvS7rRSljLdFMMbqHjG4u/x/Dg+WiFQQjmIqFPfGJwLgV
         4D4SO3XuuwAn+8zu1a5j86P5ea287pVTUbMWfntenWAuj6ESrPj7SIJOzlu3jyKgFcMn
         Yh7jQo0wfvYUdwNvDwHG0shHbi/+S3AQ6sVkMLaAD/n+UY8c9mAWxWjDuuIqhYvpyAu1
         TQmunr7oCRfmwvE6ghPBcnmmuFjtQxf2lSmkYNZFEkFFeI0oyRrZlVzNn/Ko53d8jE5P
         eG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761067931; x=1761672731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aQ+zArbjDCMGCO6Bvb9dufDVd7PF4/gLdFb+sRMsH6U=;
        b=cJFSHE3R0PbdDlI8UMNCswV2AwEb0vGGdGMiUW7iwhy8x/uEpVLOmP4MJ0Gcy1HMYb
         OuZjuW72fpYHIsVIvjDdm3+QQAv7CzuV95w4ECYA42lJuS1AYAHyx/4NtN3cPM3z8Q+b
         ioaAw/ky66hpXIzanvFo7ojIV92wU2CDefsUcbPkHPYJt+VMR6ALwTCkZJHNv+b9Drt5
         feqW3fUW1W3wAUsslEpXax5DjvuGK9n0t2rhzyOFrOXV+S0mnw1SbXWeDFdlBmjc024J
         PvuF6HdIOIlVSkqe3CZP/kePuXqMH7t4b2QF8fCtM6yTOGqxeLr3t9VY76ojnZQkHfJN
         DkLw==
X-Forwarded-Encrypted: i=1; AJvYcCVkOx81nPfsCLyRjTUrkS9Kwsj77ZZ3fIDuu+uM9DnRVbQ+BZqKDjW63MZewe2HV9PNZ0o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/9aA5LZlO5OyjAx7siXkh4QewlWyg1yhWq/ZOmlXPHB24mSzT
	2fy9irGwFU2N063pg9+2CHgJeDiMo/OQNKAReMy1dDYZduzPF+6zhK5r
X-Gm-Gg: ASbGncssofNXLo9d7z+4MBKiBmnz6J4MnmcAjzBL+W2rCCDm7+iFBjrXFcukg0y2axu
	OAwEYQe96c77qrQYS/WwyTA2nE8RaprtqoC/hqofylNhnZ4g5ULLziirLueJuNJbIQ6af8JfuzC
	F/eIqevgm7eaCTlWuZTufsk3nU7qrZTD7V4VPgpr0FCv1mw77lV9vbeI0NFUwxiUqSRlw1eRs+U
	A7pZ7kS+qccDpqCZvWwuSEtYcKBbe7xoBBK4F0v3uexxhCjPLwdY/QM0HUNaZQzAdJCZI7bT2mF
	ON6ZPkHWDnnB4dwMgnKU8D6/6s5YH10isEm6XK111fYMxZoJe5d3rORgoQbvssl2Tt8/AzNHbKS
	k/OWvJ5UJcUu2dydJGQ21vzZjYg0E4PADGy++66DfMcPKDn2TV0vP9xVlBg0PXfwwgF9FqRXQc2
	z9QiLT4BWiTqUovg==
X-Google-Smtp-Source: AGHT+IHBTh8hb/ic48yiyeOWMvVLJaZLWfjl5/Ft3cSUM4e+h+FFQOTWZmBhfmoXN8HdMJnPfxcabQ==
X-Received: by 2002:a17:902:c950:b0:292:fc65:3584 with SMTP id d9443c01a7336-292fc6538acmr13530505ad.50.1761067930650;
        Tue, 21 Oct 2025 10:32:10 -0700 (PDT)
Received: from 192.168.1.4 ([104.28.246.147])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b346aasm10941006a12.20.2025.10.21.10.32.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Oct 2025 10:32:10 -0700 (PDT)
From: Alessandro Decina <alessandro.d@gmail.com>
To: netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Tirthendu Sarkar <tirthendu.sarkar@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	Alessandro Decina <alessandro.d@gmail.com>
Subject: [PATCH net v2 0/1] i40e: xsk: advance next_to_clean on status descriptors
Date: Wed, 22 Oct 2025 00:31:59 +0700
Message-Id: <20251021173200.7908-1-alessandro.d@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Submitting v2 since while linting v1 I moved the ntp definition in the
wrong place. Apologies for the noise.

Link to v1: https://lore.kernel.org/netdev/20251021135913.5253-1-alessandro.d@gmail.com/T/#u

Changes since v1:
 * advance next_to_process after accessing the current descriptor

Alessandro Decina (1):
  i40e: xsk: advance next_to_clean on status descriptors

 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)


base-commit: 49d34f3dd8519581030547eb7543a62f9ab5fa08
-- 
2.43.0



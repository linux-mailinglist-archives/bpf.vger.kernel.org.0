Return-Path: <bpf+bounces-63826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1835BB0B47C
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 11:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5337189B3E8
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 09:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE331E5B64;
	Sun, 20 Jul 2025 09:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ED+vLG6Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDDA1EA65;
	Sun, 20 Jul 2025 09:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753002693; cv=none; b=lOYa9n0RD8HO2/mdRveyBKsiZOupxZ/R0YmhoExL2jC9Hntpz8Nl2eFnZ3OSNSfj0NXOZ8qdyPrH5FP8AIaWtNRCChwr/Z+e5aS7J/1QDoMz4OmFBiH5+do2tg/+O0H3gio09t5cFxq7KUU/9VPMmQAPGUbq6G3h44UliQ/SIQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753002693; c=relaxed/simple;
	bh=wie3zAjgVALuc7NjlqJG/3+QLcMwoX5yvQ3EwfDjXTE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=erOq5Mz1PBsOFzns8XIAUnl43B7dqGFYLx/MuuE+loPjs42jrIhKUsWX8ICJFwt1RKXXHEKBc0Voth/xbtWFdzIJBuqdJfm+NtImkg/0RRJQj8cxCnzscl7ok0VONOoXQPQJtO+0brQpP6F94MhV8vJQCwF9y8TRbdi/5APMD6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ED+vLG6Q; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-74ce477af25so2178182b3a.3;
        Sun, 20 Jul 2025 02:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753002691; x=1753607491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iWrXKbM+G34xoKVnK1eplahDGaVhKpTnihCDqzU7Q9c=;
        b=ED+vLG6QCmNV/JiC5zDP998zetskJwaW8IczlFr6IAVEzt96pAybV9UTRUNC95Z0pM
         7aXjTF2izbf8FCAF06C7EA7J8p0afLV6LwAFOveVeRO/G4EK7odOiEBfwyOB4KfCGpK4
         mhfI7GTcTyflc1tTY3S6ityTnrCooSZsde0jl3swBzpAv9IDTLykMK+7nMPSNrfOBB02
         AQiq+l/q9HcA9ehQ4GrdvucjRhGhc+v+fWC00ddwTK+7DytCRhZu4HLamsGUzr7F3TE0
         3qiZpgxqv1BO/Q1ThXrR2NiM+U2yhzaJVI0vQKE+5zeFDPw6qN89h87bmommh3E9MKOT
         IGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753002691; x=1753607491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iWrXKbM+G34xoKVnK1eplahDGaVhKpTnihCDqzU7Q9c=;
        b=famTTb8akimh3OFKBPzFZ/lytU0+7d9SFHx+7Ne7FAUOjSpyC+QHm8K1UjfTKgCZad
         6DBJLGH2WKxSB5VAJX4PIL0QrLASsUg08bxrtf3kWMAb7f0blraTipBybYq5cjMGZe9e
         mXQoo3SbHlpWapK5Z50MeuNmpA/TnYCHMp1kmVfwcKo7DdK7qdGRf98DVYb2PfRvQdFg
         WcJ4sF+QEATzAXqhsPJVN6VdRmtCwxx12R3R5vHh0pn02j1RVm8xi/SwlVJl0z12AyC3
         F/MjjOsT3fryrWj1lAdFXYpWzIEcL6j7dornI8RwwN3TzYXV9uxY73K1UNER5HVAPbOn
         LCDg==
X-Forwarded-Encrypted: i=1; AJvYcCV3qsFf5nwpulfMewRA81a1pG4RZTQe72ZA3gRPRzIZthl0WvdK6nLmoAr7rpoKQe+uFVYS8fU=@vger.kernel.org
X-Gm-Message-State: AOJu0YythS9J69SCoBsLBAB1rv0BydVoMQu7oXH/XRVDXF/uF416DAHo
	9tOdYvtvwLj/JDdt/1kgSXPEwK2hDH9Kr4VdPcO+7Ejnp2AYODUmwVhx
X-Gm-Gg: ASbGncs8m0XYqugiY9PJmVCPFgl3/E9RUscPFWK/kM75Mn2P95D7oYjbCJgHFGlDZTz
	H5e+1IP8Yf6WU/uzpQMzpcKYrLtdCHheMqn/qbsq+CqeblmRAAF77ao07/gJ4xIitvIHyr+QLo8
	8pQCUCd+2ysemX3alWkBK8qriJXMM3Do9D3XykWAPQkj9iZuW9fba/uJSYIlzFEhM9PzdnEIoGx
	5ZpHm07jDBaQAfmvQmo127/3QlT7ZcM5wdWHExCG2cnlIgnC+sdwJ/+NoFU0CVu2UhFT8tGhAyv
	7JNDVVdTcGcAl9KqdTBn9Q/v491aFT8awUcOuyYyLxwOXiqqg6ucZAAco23KD7sfvwSszXZW3Ks
	zOsdrq8BjANBVCc4fBAAUnTw9HDmB+Spu8ToHyaFb7CY82CwyfL+fecQOUc0=
X-Google-Smtp-Source: AGHT+IFxnWK1x+9KvMP+PbmzAvTkrGWlhYtcdtm8EXw47+H9FngwkBEW6Wbvc53qUZM+VZOp33M0dw==
X-Received: by 2002:a05:6a20:9389:b0:234:3932:2958 with SMTP id adf61e73a8af0-2381245729dmr24494413637.20.1753002691445;
        Sun, 20 Jul 2025 02:11:31 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.24.59])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb76d53fsm3902585b3a.105.2025.07.20.02.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 02:11:31 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 0/5] ixgbe: xsk: a couple of changes for zerocopy
Date: Sun, 20 Jul 2025 17:11:18 +0800
Message-Id: <20250720091123.474-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

The series mostly follows the development of i40e/ice to improve the
performance for zerocopy mode in the tx path.

Jason Xing (5):
  ixgbe: xsk: remove budget from ixgbe_clean_xdp_tx_irq
  ixgbe: xsk: resolve the underflow of budget in ixgbe_xmit_zc
  ixgbe: xsk: use ixgbe_desc_unused as the budget in ixgbe_xmit_zc
  ixgbe: xsk: support batched xsk Tx interfaces to increase performance
  ixgbe: xsk: add TX multi-buffer support

 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   6 +-
 .../ethernet/intel/ixgbe/ixgbe_txrx_common.h  |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  | 121 ++++++++++++------
 3 files changed, 86 insertions(+), 43 deletions(-)

-- 
2.41.3



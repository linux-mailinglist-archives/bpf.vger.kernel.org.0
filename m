Return-Path: <bpf+bounces-71078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F026CBE1C77
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 08:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3A5AD4F4967
	for <lists+bpf@lfdr.de>; Thu, 16 Oct 2025 06:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1482DF3E8;
	Thu, 16 Oct 2025 06:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgdjtGMB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1C62DF12D
	for <bpf@vger.kernel.org>; Thu, 16 Oct 2025 06:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760596793; cv=none; b=b4f4MPiiZi/CGgnE0XvmG2dA46lCWktZR2W41bg5To8dZzUm7OZJARQuJ7haPcuBTl3L5XbLiXRRiLYrvwsgguHlmQXdlMIIWctzL37bb7FFUKm0biy2vw9uxCFl4Lm1RLo6PaQXtArhBz1hWCmEwJk5OFBM3Ic1Ee/+cE0y9YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760596793; c=relaxed/simple;
	bh=Re3HZ4gIsytAj8WtvrtsMLS2KigITSDotekP2IDPNbA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MTt56u3ZGUg5gTT23H5Rl0BVVPDUSInZMfpC8NkCEBGRVJSVnXinNwAcD/d9X3eZjMTy5aF11eouoVKfpN7OK/s3sAW4UTi1hoiFkAM3p/WHUaC9M5UU7goLe8W1jemrMo5jQQss6yRFxZHrCqU4RdotpLrxz3Y8syj8ufMWjWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgdjtGMB; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b6093f8f71dso213870a12.3
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 23:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760596791; x=1761201591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XLYz+sxApW+N3B2ZP3MIw842hzBlsff9zJ8nO/j1d5k=;
        b=SgdjtGMBWkCAijuyzExCSfUdaw/NNiQ63w0qydaejibM1WG3Vu6ZY1mKhxIq0Fj2nY
         vxgSh1rAblJf7L3k04LINcw695rGFzlqySks8DBr/sqgqslLDbh4G+/E9uzKjx67wOFY
         uq6AOgd98umJLtTvy33CCmryS3y1MWIVfweFD1a1lO8qYY/fXbUyADllp69+L4hymU8m
         XaW0BVB9OAjlh47grSIgDLpFnuL11HhtqjqT3TEaRzObMmXuGh7UiJfc8EuY9FTzs/ks
         klc2fNhbVh82N3EMVSKV15HXKJ9+G7VzK2cdULMhr36eqjl4zLXJiC3/xO5gX4GK1Vs3
         Z/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760596791; x=1761201591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XLYz+sxApW+N3B2ZP3MIw842hzBlsff9zJ8nO/j1d5k=;
        b=ZKTNk9VO+vyd2YWjygXsYt52NAK4yKXDjSPNQo702c2BCUcSTxvlV3XkIWbC2dS9EY
         7awK9dJUHFXevZE0ljoVB+St8oie3FmF9b9Qu59+SI3qP+SVA3JlzhxrxqIj/45SpUPn
         Nux0HEPUrNIRRIPgz9+HR3sp/bF8SWWIXMFTDX2a2eTcwtfsEKyJSRA1tWjdulRQ/Ihs
         Am8d0G7OrDhR1Nl+sNsKXRfHKFYkKVzYwRLlnEtzZslpDL2hPGeaQHxSkBiX4Uhz2fN8
         O/YBQA5phXx7TeWF2sYvNN2JMFfVaFR0QZfOt6UkkwLC8ymF4KgdyxVAgX0O/PVODGir
         RsSQ==
X-Gm-Message-State: AOJu0YwtFE2/bDJI3GuPS+g3HkQnAt+Nb4+rkDe/H+GCyjnF8MdNUpB6
	+IcMJ8ImCqWv698PHzitEji/jLIL1YH8e5r4a9oqFoNe8/x0AvkRaVQU
X-Gm-Gg: ASbGncuEOpJwWNdJqCpGxd3m/YX3sukT2W2ExDzdI3aDqBsZ8s1F5RIQl+Ag9tW8zDp
	bBL6Ibb9OV68LSB1BOXoH3sIcfRUWseDDtl8bEmsMlVedppr/Xu+bkdz0hq9JPztxSb289B/aJ4
	imabBo6Tw7RxufX/80d9cOv9WiUwinItKOuQe8abeROMSm0hwNplrWi3yB0SDU94FwmkM9dmiSJ
	k/5C3QfNpyRes5D3YBzVE0AiTK1p2ks4/MPJGuyn4Et3gxR4465ZP9cm66OHzP24DImjmyyQNar
	vDoBMagZ0t3MEyhFwHa0+8sVxclfA6NhkGsBbpykA48VKzDYg1DM1lRrRbpcOMkOrL9qfEQGSf+
	ZD0vvgcdaqFZ8ixbtEFPWsVe9vBCkv8kxCY+1usa81Vb+pvMNgYfNr+1GH6veVPsUkfTfxBVJNZ
	CZZB3I1VfsihmshAJY1+Fs2raaslTl79tclRpBKeIif4bJuE6g5+E=
X-Google-Smtp-Source: AGHT+IERjmYAk4jdxuLqgB3pee8YjcgnDd7TPXuBe1q9Otc92V9NoAqnoqGjA5dhRZzhmASR6Uev6A==
X-Received: by 2002:a17:902:cf0f:b0:290:a3ba:1a8a with SMTP id d9443c01a7336-290a3ba1d59mr18628905ad.53.1760596791121;
        Wed, 15 Oct 2025 23:39:51 -0700 (PDT)
Received: from localhost.localdomain ([2409:891f:1d64:636e:f4f7:9293:7b0c:3078])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099b0215esm17555295ad.112.2025.10.15.23.39.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Oct 2025 23:39:50 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	root <root@localhost.localdomain>
Subject: [PATCH bpf-next 0/2] bpf: MM related minor changes 
Date: Thu, 16 Oct 2025 14:39:27 +0800
Message-Id: <20251016063929.13830-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: root <root@localhost.localdomain>

These two minor patches were developed during the implementation of
BPF-THP: 

  https://lwn.net/Articles/1042138/

As suggested by Andrii, they are being submitted separately for review.

Yafang Shao (2):
  bpf: mark mm->owner as __safe_rcu_or_null
  bpf: mark vma->{vm_mm,vm_file} as __safe_trusted_or_null

 kernel/bpf/verifier.c                   | 9 +++++++++
 tools/testing/selftests/bpf/progs/lsm.c | 8 +++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

-- 
2.47.3



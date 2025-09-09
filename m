Return-Path: <bpf+bounces-67921-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C451B503E8
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 19:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E3C43A9FEB
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 17:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D90F316915;
	Tue,  9 Sep 2025 17:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="2xT1kLZO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C84371EB6
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 17:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437244; cv=none; b=aWPCB4043aIkovu5aeGR/t0xPeYH5IIlJXiMmI1EYfyj1C0RyY8hd4R2AhZIZOfO/J+lFw1vU7dD+XUB9151Z5OWkehylWtwXlxkqO7YBPdZXc6YWAdYRbnnXH7XVZmHVLZWUY40R+9fIviXCje8TwNYnrFNeKG8fYo+16KHHIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437244; c=relaxed/simple;
	bh=l70Tt3FuZHgPclFIM+NfxP198WHw2epKUvxqXGbrz+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2NzTBfqkJwHxaZ6PGVkNmDbYESr84qkpnaQpVfpCwGsADMUH3AERDvc8gASLAwXwB9GiTn/ZWPm6pKW37Cs4Sl9A99LOBsSe8MSiUR8K92ly9Rpc/89OxOzPXyN8fQGvNIoVINQXEpkJn39OdVQ7VFYKbuCFNbBxMtHEYk/AEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=2xT1kLZO; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b4fc0249e41so259061a12.2
        for <bpf@vger.kernel.org>; Tue, 09 Sep 2025 10:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1757437242; x=1758042042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gH5okahG80CFaiitNQPCJC0OENnKbKego7xVaG7PJGg=;
        b=2xT1kLZO0SoU7EoPSyPSjTEILC+3KbmAv7CyL+49X104TYQDpu1yMb3pe6fdZyrg03
         xsJHfIOaDNE/pDRiZ2MpHhfmL9ZYybZLE1dPF5F/1aRgP+9nHe/UayJeH8mqOt5ios5P
         Wx5JlBDQTQDjCtrYk4I6Rro8azn/S1rzWpEWQKXUmMFCZMlfBjqBNiUW3MIP02JyfRhK
         kkeen3RYClpMenogabM4ZEAoa2TZWuHfe3GZkwaFp9MqTltjkZcOHLesgaFexefMHvy3
         2xv2+K/khGriRpaUZYGBR4o23ofLgpM5Uwz0s5waHUc/jv6j/yjBYsJKZZUJ7R5oUaYX
         YK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757437242; x=1758042042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gH5okahG80CFaiitNQPCJC0OENnKbKego7xVaG7PJGg=;
        b=a+mLl7cglPPhh2hszs1FRpZpbrwzSuYPv5FRrKh2ASNEbvVLpc0rIMprbf/fgLQwp8
         Gt6JZxOrBk5bmuhiJyG1R/xiuxtZ6AENiLaZdoI6VSm3hTJYMIMQ5CQ3ZtPkAlk2B8dm
         XhJE9pp+6HBB6Ims0bfsbTxq6N6m3EqiMCJvHQqLvT5Iocsfm+OluhnaJE/CS7lPor2m
         n//I7qMfRwOidGKwxDSm5Njl4k86UuVMQcU1eSbcxSrFyMMv3IqcmOA75ClTLRl+St9L
         eG7GoTfLzHnTt2lV7qlADh9l9q9z2Mqbzo/lCy7ukKriPors41zt53JLQsg6HczCfK2u
         0s8Q==
X-Gm-Message-State: AOJu0YxD1pGXea2AqRamwvETYsJTbYzPZnH0Sc0pZ/HeOkBfWuoAsJCZ
	GCb7XVmGl17R6mspChAM2ciV3Xq/MFhPc40+5bHZ2UUmH7Q9tc/xIUirzWR+D3gyi8TeAMVmCJK
	Prir0
X-Gm-Gg: ASbGncu12o4UwemZb7q+VHiIQRg81edPfN2Yf64xvoaT0aJzjwyAlRRq33RrtRv3vvS
	kb3VVW0vdFPVjMoucXR+ClS+A6nRSUrkyL5LSKbhhN5D3dAM+U4f1b2nOtLlyF2rbBB7somxcr4
	6QaWfPwlMbiDXfTCwa54Wzs9+S1G0zeOcetClWfV80pEBPo+725NsFuxNQMBLQnU2g7E+86Puso
	a3jGEFtdthFbrvyEHZ4BRjPJEXa4x9U5dXSNa4LGHW2QuDQ5wdAz4/ja4VOAQkksLvXyiPShGuY
	+0u1jEKBTAD2TySA1UoTtZHQXwIuPZTDnSvVTTRGfFmF9uYoqzt5VtOCOwTs68vl/uc5S0Vp/1B
	xSrMH7yfKkAZGcC7u2lgh17JFEN96FvsDzO7zh22okYYkIw==
X-Google-Smtp-Source: AGHT+IE9t/bVVwp+x9aU6YApQEJhEPGf3ZFC2snlfCBL2peHMOS3ErwrvPCjskLHZK2jWDRAnLK5cg==
X-Received: by 2002:a17:90b:4ac9:b0:32b:9e6f:f36b with SMTP id 98e67ed59e1d1-32d43f65c55mr8635918a91.3.1757437241613;
        Tue, 09 Sep 2025 10:00:41 -0700 (PDT)
Received: from t14.. ([104.133.198.228])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548a6a814esm251733a12.29.2025.09.09.10.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 10:00:41 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Aditi Ghag <aditi.ghag@isovalent.com>
Subject: [RFC PATCH bpf-next 12/14]  bpf: Allow bpf_sock_(map|hash)_update from BPF_SOCK_OPS_UDP_CONNECTED_CB
Date: Tue,  9 Sep 2025 10:00:06 -0700
Message-ID: <20250909170011.239356-13-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909170011.239356-1-jordan@jrife.io>
References: <20250909170011.239356-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Finally, enable the use of bpf_sock_map_update and bpf_sock_hash_update
from the BPF_SOCK_OPS_UDP_CONNECTED_CB sockops hook to allow automatic
management of the contents of a socket hash.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 net/core/sock_map.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index b0b428190561..08b6d647100c 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -522,7 +522,8 @@ static bool sock_map_op_okay(const struct bpf_sock_ops_kern *ops)
 {
 	return ops->op == BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB ||
 	       ops->op == BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB ||
-	       ops->op == BPF_SOCK_OPS_TCP_LISTEN_CB;
+	       ops->op == BPF_SOCK_OPS_TCP_LISTEN_CB ||
+	       ops->op == BPF_SOCK_OPS_UDP_CONNECTED_CB;
 }
 
 static bool sock_map_redirect_allowed(const struct sock *sk)
-- 
2.43.0



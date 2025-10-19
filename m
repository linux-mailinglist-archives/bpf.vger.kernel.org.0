Return-Path: <bpf+bounces-71327-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 390F6BEEC1B
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 22:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40B981898D42
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 20:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027902ECE90;
	Sun, 19 Oct 2025 20:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0D7aSde"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F1C222585
	for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 20:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760904938; cv=none; b=j/CbCEFG2B67OQucdoxod1VO9BE3fhnjZPEMagWhPTU8OBTQ94Gi7GkU/48ImQYDAQ31XS7OJ6QumIxynN8WM2seLYmapkX0+s9mnUvIgqGHoNyi9who+xdHh8NqJQZzjkBD39QZFpaEDCqgSRbjSU4KDbiVTi0sMKx2bg2WI/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760904938; c=relaxed/simple;
	bh=zEibW0fbiDJz4sjJNb92Etcezz+KgG0J670j15lVQBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qEi3k2MvoahDBxGYiIbrQ2cqAnn6EO06RwXQFow73D2hUav0LDkQsvhqmy9zT67I4UKKd5pAqL3bHakhyb121+b+5d5WQN3NEfQNZl2S/IsXAP/C879OaaUncZ0rNqs4ncRTjrWSQCj5uZe7CmQ6b1qu/EeYx2VadqeSbIo5458=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0D7aSde; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47112a73785so27399665e9.3
        for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 13:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760904935; x=1761509735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mECsmozFOIZoqG19gm6b3t2WEiqfOoVU9JKTKTjQgw=;
        b=S0D7aSdenD5nO5YcBKWYls/JAYbzHs5gt5DDKP7LHwYHYin9eiWkCaMVyVtoJLAc2l
         O9xITRznEo68lYduzNpWPT+k2hwkVPQ15C3YgIypQ2yIuul/7FPGDdSyy96A1B5FcXqt
         GVV9NCLsHi/fqjYvk00YCQOFua0dR3HoShlxTyz4rbCqxJS9C45TBNtKErfK2tS2Yrnv
         YwF+WlQwo6Dd8ijGcFLd30sCC8LqUJlZ4xi/4tzNJAPYO56Xku1OJvAxPUA3iAKBhC8V
         KYQkId0x2x8qmvrp2TWEKkiaY4WjErZHqPKueU+OqenIDvk2z3+pszjekFj5CQryLFcd
         GwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760904935; x=1761509735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mECsmozFOIZoqG19gm6b3t2WEiqfOoVU9JKTKTjQgw=;
        b=Md9OLPZN8UPoSmfefjIsmMSMUArAI/9M7mOMVr6TA7fJdB+9uEyKrpau2LOIjagZRp
         GR7FT2K8a3Sd7MXLpiwg/slLd+ht2aFoePxC8bJb+aD5vMDVQLCqVnH2O74vjT76Yl9H
         LMWLOeooTmAGW3e7uf1SjhJPYA0+z3S8RDEu5govRUImptBLSCrwxNxhiXCB2tEZTMIC
         QrUXXek6e4glr8qiCFmwDjnhbHNoCrb3tKfOeFQbMQWB8d1rLcLzgBGw9GuL8Zu1xFOX
         FpLYVv3bhiM/FUqLltwKdobrlE5i5P4yZMfRULrCU8/8R3DY4R3LByVsMasXkS8fS5Aa
         z36w==
X-Gm-Message-State: AOJu0YwREeq21U1vpoXOhJxO7P2dGmwb0osNrtDiHZ1hemwPwh7MYIgQ
	EYFcOmDpUY6hxMfoIqae/+J6ngRrQaV8VvK792A8vc3Ccf5RMTKWv+laynCF1A==
X-Gm-Gg: ASbGncs/rPtIIzpRIi0Z8eTd/lYCuKqJzpBP6LireHpNJDBwR6GAs+KuI22s3dudoTE
	nOHxOBb9xdKVvptCY/Y+QlXiYsuCclkKc8cRJ2/gpVDxrgyavp2RxjzB3rRb+jnnWaT3FrN5Vo8
	TiZpRzGRqrvUpbbHqvmmiqd+LrBshhUVvCTd7DcLJeD3WgCTDIvso8AqbIGW4ZstryDBk9iNbox
	BYRKNKO8Kat1+C/LDNG02EK9r11rcp1xJA9mDADRaf2sMnuBm4MUx+tAT47qNvBE4T9WlGc3bYp
	DP7KgjrnHAGXaHF0X4Xm2QrSmax9Bf/J3Sd93pMutFNABJsVpnWSKTaArnfhZkCr0s1LF2cSYRT
	zzh4UWaOj5b+/sDw5D+7lO6RGLDa4YtcIqkaAzqNnNjerVRvpoDVdAlv10InQjrT7vDIXI4YX3n
	6Xgk5GCkfj+WxQY+Ciy+Y=
X-Google-Smtp-Source: AGHT+IGM2J8Ep1zS8O75kLk0X+ri2DAfnP/XapNi8a3SnauKJlWwqaTtu5tyTGSBGXLphwxnfSzM1w==
X-Received: by 2002:a05:600c:34d0:b0:471:114e:5894 with SMTP id 5b1f17b1804b1-471179122aamr81691135e9.25.1760904934747;
        Sun, 19 Oct 2025 13:15:34 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144c831asm190460105e9.13.2025.10.19.13.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 13:15:33 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v6 bpf-next 12/17] bpf, docs: do not state that indirect jumps are not supported
Date: Sun, 19 Oct 2025 20:21:40 +0000
Message-Id: <20251019202145.3944697-13-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The linux-notes.rst states that indirect jump instruction "is not
currently supported by the verifier". Remove this part as outdated.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 Documentation/bpf/linux-notes.rst | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/Documentation/bpf/linux-notes.rst b/Documentation/bpf/linux-notes.rst
index 00d2693de025..64ac146a926f 100644
--- a/Documentation/bpf/linux-notes.rst
+++ b/Documentation/bpf/linux-notes.rst
@@ -12,14 +12,6 @@ Byte swap instructions
 
 ``BPF_FROM_LE`` and ``BPF_FROM_BE`` exist as aliases for ``BPF_TO_LE`` and ``BPF_TO_BE`` respectively.
 
-Jump instructions
-=================
-
-``BPF_CALL | BPF_X | BPF_JMP`` (0x8d), where the helper function
-integer would be read from a specified register, is not currently supported
-by the verifier.  Any programs with this instruction will fail to load
-until such support is added.
-
 Maps
 ====
 
-- 
2.34.1



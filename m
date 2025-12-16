Return-Path: <bpf+bounces-76657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 114DCCC07C8
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 02:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58F26301CD0F
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 01:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53264285406;
	Tue, 16 Dec 2025 01:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="J55RSp7e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CF428469F
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 01:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765849661; cv=none; b=UgB9BQZ0PSxK+lLNe3noax9NL96GVJFQgS7EdjwF6psWmhhmkdECnkF9+1Opvr+31XuGPFa/LdQihcfG+uIlw5MKGpmfWgvXCL0mzqcagNH8jrjoFQFF7H3/wO27IdoNGr+390mZsyZWRZYq7smDErGiR7TlJ5nY/p9oLMXmfto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765849661; c=relaxed/simple;
	bh=HuZXI95juWseGbDh51wdyacCyHv+8S45PBJH1kDP9iQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=fvny1fY8SF0KJmydrW6+xjDtuS8RyPHV0qPLywK1KTH3fCiPxnC547chLWO+imELv+xDUGgee5VECsqVoS+etZQnJjTX/Uyi+13Y9xbZ/4WQlMEoJ1DjK7r7r2ZwyOHt9rglyjA/42iJkJdFJ48f51yYKRfiJvgRPlnoLh424XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=J55RSp7e; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7ade456b6abso3117192b3a.3
        for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 17:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1765849659; x=1766454459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jQOYML69oTsOQ75vYxPwSIyfraEydi6o2qTswuNZTTg=;
        b=J55RSp7eBQ7Z8p3gFjZq1l4pYcO/OpgfA5WS26qqrYpKeItonTokfhnS/wvzpKT4Id
         HmbtwNlKH8KvXRHzSN56Ndg0cnwZKAzfTKaYFGmUq4KOXdRW1MIBHqM0uTrYuDOJVBZw
         QHd7TUKAttDAEJBmaDrHvHYRRIDwin1EuVy8/JZY4JaxIYuNAu06h1Nu0iCZDniQAEoG
         9F5XTyHXm4ultiDII7w/51bQoCxUJdf8c66mtUdRgbcF7ybdf+Gf/jnjEUU51HK+titM
         9dWkkErSjm6AzTZljE7CZ6n0lGXQiPPg9wsgr6/JWxlQBJgV7idfQo2qpqPsxdDJ6rle
         LSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765849659; x=1766454459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQOYML69oTsOQ75vYxPwSIyfraEydi6o2qTswuNZTTg=;
        b=BMFWGtREpSHXw14GC5rBZpyVe/bB7paJR/sEZzvz8sQcBfwHLDybDJ7jLrnHb3rJJa
         ELOry7f3mISi1m2Xh1pJpva99NdbaUHBWfQ+/Jiqfo0kqqf43hcOTsVsIQnPg2F9C9+t
         kIbyNKFrk2Z8RxoMEggRlx8WjbljWIP94YjYLWSxewaBOSktZHmbuCJdfoUF8vFqagLu
         eGen6VdVnWfUDcAM6YM7a7BDUuuHKVLJ94W7TCnp5aXVBdB3DJS87UUwMfVreXZ+SakF
         kQV7PYz5sLdQ/xRty7JB83fGEot8MgvwNrifkapk/hvkCZ+L0MuT2as/8NkTlOyEr8V3
         7AFw==
X-Forwarded-Encrypted: i=1; AJvYcCWmPiTiHuAxrRCGeaGCHU6/ksY/q96Ak8bTUMopsWF+W3LSsBMRIzTgHmVDCIEbLCOKNFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBpKOjSmG3iNinJ8tSs2Ezps+YSZKAJdtGP76HPXy0rjgJl16R
	PCxGSD79Pdgl7g16d91N3YOWVtDXB3/1yEmGIEDHRygd0CZ6aleGFmeX5x66TjQwKXU=
X-Gm-Gg: AY/fxX407DfTg5V5r8tX49yEzZvAHGJzXKM94cK453BlxosZEy+JDTv+ZB2f5lT0O2Y
	MHRvUoXwFNUTgZq6778JMZL6H3z8ytlQPuZ0YDn2mbKZMLG/JnsRIltPVAA7UJzf8dEPWsz+2Tb
	mR4XDYAL3QVNpVHIqtYKWSrucTJwyJW+g8+wG/ZDdffleFahB0fF2uoO8aBtOtKsb4Gce7fBz5+
	jiEPy1PPqoJN7QAitR9vw5g5dPvO9ViwN/bS59jtoyzdslH+c5bilXx8nSqWxtF9AlSz0HdN3kz
	WiPXRpb2gBH9bjyk7V06AWI46iCd6iviIe4OyGaECIswwWg+B3bJleDA7O8bBh30qkvFUl71iwt
	WWlG5LOmJNlYN0DDs4sPYuts8Tg+fS6l32fj+9BBvx+7VRsakIimm8bsJl8fqbeeuiICwZQzj17
	3CIdxcs18Ys1mkbs0JqnXB02OuAtMvwhYBKIIzHFl1ldWv
X-Google-Smtp-Source: AGHT+IFb4p41Qgk4jrG7oAwM1kTzSPIz8GaGD809Q++LMxasrDyli3QXNwxda2W99S4WH1s8MPX1mQ==
X-Received: by 2002:a05:6a20:3945:b0:34f:b50e:e2e2 with SMTP id adf61e73a8af0-369afa01a2cmr11969729637.58.1765849658920;
        Mon, 15 Dec 2025 17:47:38 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.224])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2c963b53sm13632790a12.36.2025.12.15.17.47.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Dec 2025 17:47:38 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	andii@kernel.org,
	andybnac@gmail.com,
	apatel@ventanamicro.com,
	ast@kernel.org,
	ben.dooks@codethink.co.uk,
	bjorn@kernel.org,
	bpf@vger.kernel.org,
	charlie@rivosinc.com,
	cl@gentwo.org,
	conor.dooley@microchip.com,
	cuiyunhui@bytedance.com,
	cyrilbur@tenstorrent.com,
	daniel@iogearbox.net,
	debug@rivosinc.com,
	dennis@kernel.org,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux@rasmusvillemoes.dk,
	martin.lau@linux.dev,
	palmer@dabbelt.com,
	pjw@kernel.org,
	puranjay@kernel.org,
	pulehui@huawei.com,
	ruanjinjie@huawei.com,
	rkrcmar@ventanamicro.com,
	samuel.holland@sifive.com,
	sdf@fomichev.me,
	song@kernel.org,
	tglx@linutronix.de,
	tj@kernel.org,
	thuth@redhat.com,
	yonghong.song@linux.dev,
	yury.norov@gmail.com,
	zong.li@sifive.com
Subject: [PATCH v3 0/3] RISC-V: add percpu.h to include/asm
Date: Tue, 16 Dec 2025 09:47:18 +0800
Message-Id: <20251216014721.42262-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1->v2:
1. Support percpu add/and/or operations for non-ZABHA
2. Implement optimization: store percpu offset in thread_info

v2->v3:
1. Fix this_cpu_cmpxchg128() compilation issue when
system_has_cmpxchg128() is unsupported
2. Fix sparse warning issues

Yunhui Cui (3):
  riscv: remove irqflags.h inclusion in asm/bitops.h
  riscv: introduce percpu.h into include/asm
  riscv: store percpu offset into thread_info

 arch/riscv/include/asm/asm.h         |   6 +-
 arch/riscv/include/asm/bitops.h      |   1 -
 arch/riscv/include/asm/percpu.h      | 248 +++++++++++++++++++++++++++
 arch/riscv/include/asm/switch_to.h   |   8 +
 arch/riscv/include/asm/thread_info.h |   5 +-
 arch/riscv/kernel/asm-offsets.c      |   1 +
 arch/riscv/kernel/smpboot.c          |   7 +
 arch/riscv/net/bpf_jit_comp64.c      |   9 +-
 8 files changed, 269 insertions(+), 16 deletions(-)
 create mode 100644 arch/riscv/include/asm/percpu.h

-- 
2.39.5



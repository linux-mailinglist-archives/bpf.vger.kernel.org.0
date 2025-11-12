Return-Path: <bpf+bounces-74319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3443EC54080
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 19:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 104F6345C2D
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 18:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44E934AB1C;
	Wed, 12 Nov 2025 18:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DO8KfNHs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075732D73B0
	for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 18:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762973924; cv=none; b=JI7JRe/BdZ47bp/69VNMDjKmiw2Nw+fkOgZXNHudYf9u/sh8aaEJnpZZHQW4yi22Tk+wCOuSNEihLH66+mbNRhD6U3V4DhXOu+ovKOgLHA6uM2IZZswtO8QOor8orPEv4jQ6OGh4Jja7V0Sffn6zXbTZkot2i4bwju8Q7b95lHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762973924; c=relaxed/simple;
	bh=OBztE/uAyD9lr46W6vhtoV9FTCD8I0/1QOZzxfkm6Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HZBBAplXYSExgPMH8NmfIOxWdEPUbas46DBGrfcgEYOkheNol8Xiegt2mrA9stqQlyMFnucL1T8wQKQ0ffSYxNWr+6UrdUuAB8FLn0xxyObZIIJ4LCs+qBA6IVSUC+eOByCJRTLrFftoPRq0EYAWH0eLfKTlSOXSkLExCgC1F0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DO8KfNHs; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3410c86070dso893287a91.1
        for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 10:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762973922; x=1763578722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/O7yTljWefVJj/yKLEyf8lcxmUjNGkJCaYIrrJsOmVk=;
        b=DO8KfNHsJJEefdtAV3R49zaqKk4z+vhR/LyVrqpaTKsrSghAjU5vSu/3BroAn8qK61
         TFzhyOnlGis0r1voxk1+iwFyOn9otKxJ+ad82Kn+RvWdgT2fTvZb4JCJVuL2yM65B1tE
         RxXDZt09jxK2tDhP4M2Y7GabTy8yJaLruqRu/n/M3TxFzEFARJ8HOHGcYdiuh4J4E7r1
         5jNChUtQJkFwR9yR7WU1mkUZnjpN7hwqY0f5I8GWcUZ8nWRYJOLdqKpBHxNCQqZ3BrSm
         nCI6yPaE8dDUfo63rciC3PfAIRLXTL3tC0KY5+2feHYmk9JaVd8D4AgIdtG+ZBu7HxKf
         dcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762973922; x=1763578722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/O7yTljWefVJj/yKLEyf8lcxmUjNGkJCaYIrrJsOmVk=;
        b=M2umwKdJODDZgEXIWTuyNYQf17tm/193uh+mKofIARpxZvwHbX3hrh5g3K/ctRx6qQ
         vYBelLRZi9w7AkzBneJkkJ/m3zjnN/H6HZ90PwoccF/tjlvU/SMnFkqiJnr1Gn3Zf2Oj
         VyJMcBqtzUfUOonoeWcxsUhU/MQOzCOK8ra+3HcyngvuGjVMnrnUEbwT03WGh3NDUB63
         s45MyUBjGmhLM1IeinmyIDwuQTOWFsiA5jHahWhmw/ohfUjhhmuV7iLWC8UKDY22wxgA
         sd7QooWNZW+Rqt4w6U2+4zKLiiV/dTec/8NV5H/3E5e8XWB5cE9pV+fzvV64lkfRMXQr
         K17g==
X-Forwarded-Encrypted: i=1; AJvYcCXJBPTb6Epfs1KvSmE9A0uu3HEf4Zx9E9oICc0KV41HuPbqMhN/nFF+5PQ5ell1g16ns5w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb6kqfoTv5ocrQU1gLJz7qYaP9zCdDf5ac2/gSWv/9R6GemdQl
	eEBK+0qkX/Pz2j/THVxU53dHod5vAjwPQCsHQEC1Is75Va/NEFlTkYFE
X-Gm-Gg: ASbGncvaPvMWV6bYJtgIiHg4U2nUkyRwHWZE9y4jDrrxdiYOXsFCDcGyItgLnzuhfHc
	PT5TSeBpAcnFOQplaoeMeS8ycBja6Ubea2q6HbuYX/DFYtp8loBe82SNYq1o0RBdJC4ms1votns
	959jZslYFXu/rGPHuGrVW1V/ieAhegX+ImIbxpsIPJWbMuQDL1PBEixgnsMOEg8gTxsciQf7bGl
	2B7NssFZG4PHozZ7VJAnBaLbR4zbuTvTi63noOAQvSEMeziQnVlHlpz6vJsoC0w4rWHUSSaCWED
	MFZEcy+F++PWCvevNovKCA04kQv7Aj8jAST58zYO56Md9QWRhDmdsJ1W80v5M1huRuF6qhG2uii
	FHCl5whelriVPHwW/WizbaSjVHijG4NGg3LDHF4i6moQ0ijnV1K6Ko1H1Nm+mkPWVJPfhI3+zZ0
	6EdfBaw3smiEsGW1DFK4Fhn+ReiEyyakEb
X-Google-Smtp-Source: AGHT+IFuEPZwrG3ybBGzaBAcVZuN7O+EKp4bIF5cDVmcAe1qISW3MyunxL6iIy3B7hwXG80OQE7DWQ==
X-Received: by 2002:a17:90b:2dc6:b0:330:6d2f:1b5d with SMTP id 98e67ed59e1d1-343ddeda060mr5173580a91.26.1762973922286;
        Wed, 12 Nov 2025 10:58:42 -0800 (PST)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-343e06fe521sm3491565a91.1.2025.11.12.10.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 10:58:41 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 0/4] make vmalloc gfp flags usage more apparent
Date: Wed, 12 Nov 2025 10:58:29 -0800
Message-ID: <20251112185834.32487-1-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We should do a better job at enforcing gfp flags for vmalloc. Right now, we
have a kernel-doc for __vmalloc_node_range(), and hope callers pass in
supported flags. If a caller were to pass in an unsupported flag, we may
BUG, silently clear it, or completely ignore it.

If we are more proactive about enforcing gfp flags, we can making sure
callers know when they may be asking for unsupported behavior.

This patchset lets vmalloc control the incoming gfp flags, and cleans up
some hard to read gfp code.

---
Linked rfc [1] and rfc v2[2] for convenience.

v2:
  - Add __GFP_HARDWALL[3] for bpf and drm users.
  - cc BPF mailing list

RFC -> PATCH:
  - Collected review tags (Patches 1 & 4)
  - Add unlikely keyword to help the compiler
  - Replace pr_warn() with WARN(1)

RFC v2:
  - Whitelist supported gfp flags instead of blacklisting the unsupported
  - Move the flags check up to the only exported functions that accept
    flags:
	__vmalloc_noprof() and vmalloc_huge_node_prof()

[1] https://lore.kernel.org/linux-mm/20251030164330.44995-1-vishal.moola@gmail.com/
[2] https://lore.kernel.org/linux-mm/20251103190429.104747-1-vishal.moola@gmail.com/
[3] https://lore.kernel.org/linux-mm/20251110160457.61791-1-vishal.moola@gmail.com/T/#me8b548520ce9c81a5099c00abe53dd248c16eae7

Vishal Moola (Oracle) (4):
  mm/vmalloc: warn on invalid vmalloc gfp flags
  mm/vmalloc: Add a helper to optimize vmalloc allocation gfps
  mm/vmalloc: cleanup large_gfp in vm_area_alloc_pages()
  mm/vmalloc: cleanup gfp flag use in new_vmap_block()

 mm/vmalloc.c | 48 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 8 deletions(-)

-- 
2.51.1



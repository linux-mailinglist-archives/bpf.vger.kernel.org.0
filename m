Return-Path: <bpf+bounces-60706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7006ADAC79
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 11:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713C8188DFFE
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 09:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43F92741C6;
	Mon, 16 Jun 2025 09:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="hViOd2+A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC71233737
	for <bpf@vger.kernel.org>; Mon, 16 Jun 2025 09:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750067740; cv=none; b=QXoJZIepWgg2Ubvb9rdaUo4v+xibL8vbpDuahMZuNFgHIJSbFXxlVWUNLVYZo6urw0dFh5rHH1mDNxKKhIxqjAJcUOKmUDu0bOMxOLpIgt31eU/QJRGdt3m7oJEaHGZILO1M5V1W79FDZHdOIVXdJahB0D3YVKgFvk5vGDBo9Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750067740; c=relaxed/simple;
	bh=drPrCveQJ2nF38aDlX6Xryfirhzqd9PmLSAMhJNpAOA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fkQocGS7wGmgpHCzTWWciA79XtXed0cSgHQxp+hdagdklzyNJi7Unjc7IpzzdQZ/y+VQWCoJ9lZp/ZF8dMZ6/OoFZdR50xcS10JP2Zy/MN/Nql3X/s6p8dh74raAx7z5xz5RG8lVtd+sc1ubhb2lMsJKUSRMiBa6SdHxOYFCFV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=hViOd2+A; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-452f9735424so13361455e9.3
        for <bpf@vger.kernel.org>; Mon, 16 Jun 2025 02:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1750067736; x=1750672536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PQ3V0gzJmMqB9pDar/canoJsIJpbRR3q/9+xStbVMrA=;
        b=hViOd2+AeKV5D5pCAbje8Dpk9JicmEvAsEV2xVF24mVfLV8KCvHccUPxLUnXd7Qo8U
         OYiNes7FxIlGaNgjACmB/ZEj6TpkLoUdyhwPJTbSRhooB3q10hLVDNLLBfkEYHaWC/Kw
         NwRmP+M8HsYK5YOOPVMWIcJwWz5AFmD2Zq7M/9MsXPdZD3Yf6uao+B+7LQlGjCJMImFD
         2un2djr589tVyoRXt+hlJ3nBS8N8iRgWfdow0HXkZN9T5RFMDnq/rSSvg7OJjiBDVAXe
         7mzPlJCPa+yKBBZ8EplBU3/jfvJuFkkFWaiLkVOs/XzDl4220YqpMDqpEq3ITFozC320
         L3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750067736; x=1750672536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PQ3V0gzJmMqB9pDar/canoJsIJpbRR3q/9+xStbVMrA=;
        b=LgGoABfyCBaTBgKszRKZcm/3UX9A2zuniD6HF8B6Os/yk55LjdYX8nCmDAuiHBxGPH
         vsubmPOmbkvU4W5P+kC9cOFI1+JfCs3Uaf302MYNr3JYDCp1Ep9pZmfCSJbFMMCBMsek
         p5J3gAHNndU5cLjxkODmXbI3ebcFtgYczOvxU4rmd5K6NbFVeDV6o86BfY6O/DDPgR1a
         it+aKEOTS83lhPgmP7TsIlzND3DXmV/OKBxmOaHoDFpLA0CzRav2rRyDatmBxd767nDn
         gHiPDma93McRK5Uec8Sv2I9WwE1Ns2GE991BgDkYp8muxDI79vU8h44EbwxWyBviDdqk
         UsRg==
X-Forwarded-Encrypted: i=1; AJvYcCXCyhnQAB6SNsfTjEYmtAFNou3qTH070J1g7qSvFvbHVVKfXTUktsfnJQ5tIDQwbNAWab4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLtXyenj8ju7wut/QXF5jTUg8ONEHJBCy1jwSZURWGKiWDT8As
	t5iYBLl3WZNs8+b3qIuF94sOU3iXAM9HMnioQZErYksoNMg1s7xq1KsOMZex0vKgijQ=
X-Gm-Gg: ASbGncs4s7f+vZOeMZC8x+k3RXXn2JD5kgNxjRJfsYIUmfTOoYiJUL/8/usAjcNRVgo
	iuOhVX1qbdLsLcFnjvWKGHcWR5ttXZEgfc5L4kddabVkbDdy3BxO59yui4akUBdUJa+JuAXb9u7
	gwHNfb/XHCoY5xeVlf2/vS1uXVsN3oSeFmebXowiDK7Cu0yVCzKxHh8TvZWEstGoax0xKPmhaNL
	+O/DxYFMl1UrWhyrw7mCcKq9U7Y3n0NomokhpuAFHwp+q8enlTw2kM0S7tomXuI7CtxwzeQ1wCF
	WgFQxqxgF29Fyc9nr5EIPQcXfEqeGZP8JdJcl0g5o1TBONCaEzhpOgIcGDU+22FJ
X-Google-Smtp-Source: AGHT+IGsunl5K1ssoQSRQmIgzglzisrnybJwWxpgkBqoS6HCLg2uMYiKE39WDsXJ7qi/USmCgzVtaA==
X-Received: by 2002:a05:6000:401e:b0:3a4:f7dc:8a62 with SMTP id ffacd0b85a97d-3a57189690emr6979169f8f.0.1750067736249;
        Mon, 16 Jun 2025 02:55:36 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac1:2880:f0::2e0:113])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b28876sm10554308f8f.73.2025.06.16.02.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 02:55:35 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>
Subject: [PATCH] bpf: Call cond_resched() to avoid soft lockup in trie_free()
Date: Mon, 16 Jun 2025 10:55:32 +0100
Message-Id: <20250616095532.47020-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matt Fleming <mfleming@cloudflare.com>

Calls to kfree() in trie_free() can be expensive for KASAN-enabled
kernels. This can cause soft lockup warnings when traversing large maps,

  watchdog: BUG: soft lockup - CPU#41 stuck for 76s! [kworker/u518:14:1158211]

Avoid an unbounded loop and periodically check whether we should reschedule.

Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
---
 kernel/bpf/lpm_trie.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index be66d7e520e0..a35619cd99f6 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -646,6 +646,8 @@ static void trie_free(struct bpf_map *map)
 			RCU_INIT_POINTER(*slot, NULL);
 			break;
 		}
+
+		cond_resched();
 	}
 
 out:
-- 
2.34.1



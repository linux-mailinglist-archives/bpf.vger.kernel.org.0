Return-Path: <bpf+bounces-58715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86795AC0485
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 08:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B39621BA7B69
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 06:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8374221729;
	Thu, 22 May 2025 06:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKrHnVdM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2563B22155F
	for <bpf@vger.kernel.org>; Thu, 22 May 2025 06:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747894892; cv=none; b=kXRJ//iL9mQVpabWg0VsjnoMXvfS+6ktH8QZ7PUC1rse9aHC1Mu5j4rhHcXZkMfM1N/Rvid4XNFwdm9tfauhcwUKmH9KZrksK1tjAd3voROtrrvOI02WkZb+7lmYjWyxl873gAWbnRzU/A3YWcXoVOVyeCAgIn0+jQ6p4PO5fH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747894892; c=relaxed/simple;
	bh=puMynW4zD7IPkVFt4K+WJDb7uPcb9R9cgzymYGi+Pug=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eL/RQ4pyvJzjDbaFfXrT10aCN6DZvuu2WZ0JRJRBp12JeYl3xSCyL/OxJ34SrIa48GEyW30CzcLtN/WiIxYNxPo5Hob32uVNLwvuXb5/pdca5kJGND4px35PbnCy6eg7R8B8GP5aO+7NRjNPshfqu/aGwT7c26jT9Wou/kgWbis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKrHnVdM; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b170c99aa49so5110680a12.1
        for <bpf@vger.kernel.org>; Wed, 21 May 2025 23:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747894890; x=1748499690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KGWKJ/FFW6TO4mSgE5/ePobxrfpMUhRMXzJ9EfvPL38=;
        b=YKrHnVdMmFXaumUky/mgPmv/SnIU+3hV+Lwo1E0RGWoiT6JvsAxyQaHO4UY2AA65T6
         bsYqYOh83wJZjLZm7dLXz6gEgnCLEvSPCTIEvBADJOMHen6pxakifkR+tykA+xFfVriQ
         8EuELxv3GyNxiDmDB4Dqh7nmwZLrYNUVlmA9zuHr7eWsSbOt8I4L56+8ROeRkxeGaVIC
         upj6iALkKt7DHet0FiCOigi+zBe0zqf5DxqG9sHn+s1jAOEovtq4gKuB2yMMWjYTElyQ
         ScBXJFcADFhMQc5+ZpoX0DMD09ZKFznuicO+SnLxMLRGYXlez8QxSJBAFPKGiLYpt6nu
         xqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747894890; x=1748499690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KGWKJ/FFW6TO4mSgE5/ePobxrfpMUhRMXzJ9EfvPL38=;
        b=Qo/a8PopY0kmk0CRWBGMJ3RzYvDe8HJPg0b01qxJ/p29NXvIq3bj9Gj7i9YJzqwrCI
         P33jL7uqHoAi7sENFbagmXfSv4rXCBDSvuD2jaDvwbpNDTw+BdpqziCg8G2xUagrGUcS
         7B0y5Uh9hOmgN3bFkcH2Ld4O3recRpUSNatukRysaNQt8OurdiIKTBv/9xlhkyCoZl4G
         hahh7fTFOyO0PQHTxlYmxmEBVjuHx+VK/EUQInflzfkDvM1ekImVBPp3z/Po1fJLRmD6
         y8O2k6dGgXQ+vL4oVLzFYDnMbCDdZ+uWWXZ4A9fCUTR46KbRSzr1kKtc1vi9R1c7iI24
         PZ1Q==
X-Gm-Message-State: AOJu0YySTZlOkY96dylQpFhRXlERJfGmqlpoBHOzX2R6lcLHzcHlXiKJ
	y6eoB46pevR883nR5d2FOzD9waVfeFMk8zlwZ+//eVFm6SSDnXjoAvrnE2PXnw==
X-Gm-Gg: ASbGncu+1GX+gxqfWeF4hPXEPcpvk3kpIEiskj3Q4WbsaxyR11WREUNdFHBfP9M0n9o
	2DA1wopiSO0URFq/zY3D0tL0BRCEGm4Xxoxjj2DKGVku/zY57DPyx2rk0I/x4Uya9LMmu9uvEZW
	JzDIyEY5Y4qFwmmDcXbmo7clfNYd3xqIjfa4bMKGY1Z2X+kD3mb6qtNWYVr7vnEWLasWZN/f8MP
	WxIMZe/drJyTf2kTX0MtRvB4JvKnvBS1gAXfkv5qPJ+UKUtCq/KydeH844fV0nwphEAgCjSCERF
	2goWc1PKjwwP4Zt1z+eIl+xUXkttXspEfWmR1CPj1fbKiX52I19j25Km5knNcQbKdjGVm3pVZg/
	MU5EeD9mG+ytB6isYBuqprOty1FI=
X-Google-Smtp-Source: AGHT+IGJZXWsZJtfk/x6D+O0CT7k7WTHMqIBkVeVxzGXV+30HfJkSc+BnyAwwSTetq+shsdRtmVHZQ==
X-Received: by 2002:a17:903:94f:b0:226:38ff:1d6a with SMTP id d9443c01a7336-231d43d9cacmr304188885ad.7.1747894889891;
        Wed, 21 May 2025 23:21:29 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-233b1bf1cdasm24399965ad.181.2025.05.21.23.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 23:21:29 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
To: bpf@vger.kernel.org
Cc: Tony Ambardar <tony.ambardar@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH bpf-next v1] libbpf: Fix inheritance of BTF pointer size
Date: Wed, 21 May 2025 23:21:16 -0700
Message-Id: <20250522062116.1885601-1-tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update btf_new_empty() to copy the pointer size from a provided base BTF.
This ensures split BTF works properly and fixes test failures seen on
32-bit targets:

  root@qemu-armhf:/usr/libexec/kselftests-bpf# ./test_progs -a btf_split
  __test_btf_split:PASS:empty_main_btf 0 nsec
  __test_btf_split:PASS:main_ptr_sz 0 nsec
  __test_btf_split:PASS:empty_split_btf 0 nsec
  __test_btf_split:FAIL:inherit_ptr_sz unexpected inherit_ptr_sz: actual 4 != expected 8
  [...]
  #41/1    btf_split/single_split:FAIL

Fixes: ba451366bf44 ("libbpf: Implement basic split BTF support")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/lib/bpf/btf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 8d0d0b645a75..b1977888b35e 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -995,6 +995,7 @@ static struct btf *btf_new_empty(struct btf *base_btf)
 
 	if (base_btf) {
 		btf->base_btf = base_btf;
+		btf->ptr_sz = base_btf->ptr_sz;
 		btf->start_id = btf__type_cnt(base_btf);
 		btf->start_str_off = base_btf->hdr->str_len + base_btf->start_str_off;
 		btf->swapped_endian = base_btf->swapped_endian;
-- 
2.34.1



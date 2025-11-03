Return-Path: <bpf+bounces-73339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FE3C2B908
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 13:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34C514F3252
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 11:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961E33081A3;
	Mon,  3 Nov 2025 11:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMuuswEV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC23306D58
	for <bpf@vger.kernel.org>; Mon,  3 Nov 2025 11:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762171129; cv=none; b=TpAk3aixhxoPGVVerZdrJyxTfHIquHqA52g6m7dDVK0boyDJ7NTH/DLyb4bHDeSThZ8++M0pA0I9KiOy8rS9Tx32bZ3tDQ2KQSSWEMqpPXb7SJ6EmXI0ihG9Rb7TEYsx5UPzNWipUIvNGDW0jt9NO1cS0w6eF9v2AYxs32ZWRp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762171129; c=relaxed/simple;
	bh=pMpOTKHGuWFSPBIGEnzVqEdHstlTInYMW+kdV08lPyc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hlAg4N2dX03TZ8hT9iXw9oDJam6TpYtqNMFlmjIbannfnERTISEHGxkeYSv0ZX5wrVaQ1N5oUvKOBq89qogorjhgc3RM9+aGtbg4gdUP90Bb6tGjP5eXIHFoeoNWtKFca8GQjm4rLOGL6bOZ2WPAxO6fk0EeI73vCvm3C6kqZxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMuuswEV; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-b556284db11so3621207a12.0
        for <bpf@vger.kernel.org>; Mon, 03 Nov 2025 03:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762171127; x=1762775927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PYDeaZxJ8Vy/RtTKvUvYMgpW20VocJ4bgzuBiRDeJ4s=;
        b=XMuuswEViDtOjFKRmi+xDJkygKNebsRHd8vrRItMa0kOv+O4G9b891Y6Efo6d9fuDs
         n+Rm9lJ3nXFDqsnXy6x8IqLBiN/0EdNkvjwZFZPqLjeO2vAupqHmX3NChXunwgUUcPdE
         y4JyO3qlpeqZKHmWYsjtNSZHA0/DAQsjurCl04ETEV21Symnu+NdoABzsNaDTYXdre/L
         sqiHyCzuX+r1YmACxJ3SgIqEa6xASZlwE/H/6nRGMd6OIIiKc6VfXxiy2lXo/TkgOgiO
         9VjeC3xMnn2cEv/0UqSofoVlModyuIEdFxJdArUrG6vqZwI+C3z6ndStN2hPtKmOSZ3Y
         y4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762171127; x=1762775927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PYDeaZxJ8Vy/RtTKvUvYMgpW20VocJ4bgzuBiRDeJ4s=;
        b=iPYXK1thuURTNtTrraJIZZ9AxY74U1D+OOvkGX1l8Y0LjiEBjnGcR29Iv9RRIl3F44
         /TmcG0fcLKajGVoXiBVwLdzkM8pGPziW2dcT8BpCEczWYxsuJtUjpsrR3thLTV6BFFvb
         nOESmm9V6D+2Vm+VkEeV5Pc6IMWnQo2YgIrsjH1QywnyTm8STyQO0Fw//rD2bwHkegTb
         9bfzgGj3LH9UpJHxoBa3CcuEeHC9LXE6WMPM+n1rrVY0cL4PpT3P0USd8fAPGnib40an
         RUdXgNAk1kSVlNYBjkpVyoyukP7Mj4ROVZlbIoja6Z/pO9VuCTh1CXxexr5fLniikdpY
         rrjA==
X-Forwarded-Encrypted: i=1; AJvYcCVv7nvAyutnZ5Y93A6kvsCcPxm4aojJEUfY0f6I13a0//Ba9V3trWHhfzldjyDLW1cBFfc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7vj/Nmar+qw8NsnuWvJOISp5yL+fl4oNNvn480ck32kMQey+9
	3xi+Gv890+nJSdAFMyu8MdrueUm+lwMK9yQ/WT/wN4Veb5kWxhW3NpXZ
X-Gm-Gg: ASbGncv4O9z+1LBd7D+n5ngAo6Rl0O2R9BS6jRuITdo8ISdxVXAhAAJ2NriJawVCz/X
	1/dyVL5cfPZIWlr3ZIwW2Azvyc2CEAP8s3UlEJvbgj2DI+oeJPjK2pyqGaNir9rM7x7u5O0vWkY
	5gbH9UAx3diwq95RbMvb3LR6LB0agA/gQB/9LOOHA3F6KMgcYPfc2Xze0X1wGGKttJ7dWdKI9hv
	UCK0RtmWFuIp+DWnrVR2O4Df3FhsdexTMvxRRtczNZC+/OsLzHUeaVanQrx+n3hbhZkXOYEx1fm
	IWKo3Q+K4Ztw3xOGDnzB5JfvwlDylqjmxrrgRo3eeWdbV+rH4XdQwuoVsKr3T75QfmlkPb0dKZP
	bX7lMfOgHRHvqB0rduqfc+lhUiaVpl9sDa0zzZn74Qr8mBa5hl9U5A7Hg4VkUsMIr5QbLwbZalI
	gsrk/YT2W7mgxLEb7Tow==
X-Google-Smtp-Source: AGHT+IFXydWTCjfY7kW5EClVfFYcgTumDC8G1OQBK9cjulV1DvxhDVl+Eev+vOVvJD1GEs1h0EFx3w==
X-Received: by 2002:a17:903:2285:b0:290:2a14:2ed5 with SMTP id d9443c01a7336-2951a390655mr143399485ad.4.1762171126796;
        Mon, 03 Nov 2025 03:58:46 -0800 (PST)
Received: from E07P150077.ecarx.com.cn ([103.52.189.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295268ca9fdsm118304485ad.42.2025.11.03.03.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 03:58:46 -0800 (PST)
From: Jianyun Gao <jianyungao89@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Jianyun Gao <jianyungao89@gmail.com>,
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
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools))
Subject: [PATCH v2] libbpf: Complete the missing @param and @return tags in btf.h
Date: Mon,  3 Nov 2025 19:58:36 +0800
Message-Id: <20251103115836.144339-1-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Complete the missing @param and @return tags in the Doxygen comments of
the btf.h file.

Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
---
v1->v2:
Try to fix the CI FAILURE issue by rebasing the local code to the latest
version. The v1 version is here:

https://lore.kernel.org/lkml/20251030113254.1254264-1-jianyungao89@gmail.com/

 tools/lib/bpf/btf.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index ccfd905f03df..cc01494d6210 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -94,6 +94,7 @@ LIBBPF_API struct btf *btf__new_empty(void);
  * @brief **btf__new_empty_split()** creates an unpopulated BTF object from an
  * ELF BTF section except with a base BTF on top of which split BTF should be
  * based
+ * @param base_btf base BTF object
  * @return new BTF object instance which has to be eventually freed with
  * **btf__free()**
  *
@@ -115,6 +116,10 @@ LIBBPF_API struct btf *btf__new_empty_split(struct btf *base_btf);
  * When that split BTF is loaded against a (possibly changed) base, this
  * distilled base BTF will help update references to that (possibly changed)
  * base BTF.
+ * @param src_btf source split BTF object
+ * @param new_base_btf pointer to where the new base BTF object pointer will be stored
+ * @param new_split_btf pointer to where the new split BTF object pointer will be stored
+ * @return 0 on success; negative error code, otherwise
  *
  * Both the new split and its associated new base BTF must be freed by
  * the caller.
@@ -264,6 +269,9 @@ LIBBPF_API int btf__dedup(struct btf *btf, const struct btf_dedup_opts *opts);
  * to base BTF kinds, and verify those references are compatible with
  * *base_btf*; if they are, *btf* is adjusted such that is re-parented to
  * *base_btf* and type ids and strings are adjusted to accommodate this.
+ * @param btf split BTF object to relocate
+ * @param base_btf base BTF object
+ * @return 0 on success; negative error code, otherwise
  *
  * If successful, 0 is returned and **btf** now has **base_btf** as its
  * base.
-- 
2.34.1



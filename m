Return-Path: <bpf+bounces-55446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7C2A7F8F6
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 11:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13C133B8EAC
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 09:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49A826461C;
	Tue,  8 Apr 2025 09:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTtdDgRC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F5326461D
	for <bpf@vger.kernel.org>; Tue,  8 Apr 2025 09:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744102811; cv=none; b=iPS1DLZv9nXRUmb0RJRC/+5kJVLj2/ESxSCr+JT7P7n4ReoD42EprkoJKJmCgSLMR6qOyI+NZ6h4Y7mlUUzmGM7u6HFya954rNWR9nzSGrhxHRsSsbnwkCxyWF3WqRzlEh29vNgCb5li6FzBVT1himDqLSAUteB00tkYcIWVtcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744102811; c=relaxed/simple;
	bh=IOBaPhBPQn243ogcXRBwDDvATe+ezveJxDBto5NgdQs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PsvaRWWfqR23VuZqxCkLOEe8oREjdAKNLfI3OJIDyxTof6SGYgT8emRnss5eWPUuJu5bW1auK9TUSQL+24hNEisuLuZKkG/R0InF3uqSWcyWu51wBrk+7Bu/Zd4/q5G3yTPFiBtGnSXUXUEYa5oft9guMq8JnGW7gO0RwSGDFrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTtdDgRC; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39c30d9085aso3100361f8f.1
        for <bpf@vger.kernel.org>; Tue, 08 Apr 2025 02:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744102808; x=1744707608; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k0RtXYV55mAwNkiErUaiSZF4QXdkRd5ukBwSAyasdVQ=;
        b=mTtdDgRCFCqMnDanLZY0umehsglfT1ghe9gKFAGfhF3aQ9ZI3G9lxpVOS6RzEBZJxx
         W/K9kNylgCM/FO2Sh0YQV8LVsSCDCpP77ph0w7q9YOLReZQo1ouj/uQXxqp2Ma+gGz3D
         Kg5jzTVuvtI19N4c+mPdn62LHultv2++/0G0j42s531JCaAJeCziZG9y+lqcM5SBh0HK
         ep6cwz31XJt2+YVIpJR5XJkitqL5UdPdq4teuTaJXlRKLc9UqpEs37RLKksQxnFKem+i
         ZJHUPi6gtOtX/v+hOQx7I/2w05CZeKn3dX+Y8BDoz6MuQQbb8FmZbPuPxvKaRnbwLw3/
         NQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744102808; x=1744707608;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k0RtXYV55mAwNkiErUaiSZF4QXdkRd5ukBwSAyasdVQ=;
        b=wzq3ocVQSC9AV+xOGXztunt9BGOOWig/6J5Xcb9yObbjRSGJzn1E5RWy/80OjemfEb
         +wGQ1/OveGO2UPciQ4rXdQHGX1n/bkMgWLSSzv1PYVFl4ZdJZPoEG44NmF1h2KOGP7Rj
         Uwz1IEQONbPh6ZPuqpc1+4HTnOhNdcQZlAj31OmCzJkzpyAr85RH4+6/4Fi5ReJldKgC
         SvnOmTnazfG45fMyIYFfsOpuwPt/gux9+RiDR8uR6Zb26CNpo3mAlmYFjx2PXWhPrjmI
         qxylLBLjCApeUY6qwrPO4DiPG3mEZd/JcXamFhgo/kIW9m3ejMQvHykn7dkiAmJOrhbA
         Y2RQ==
X-Gm-Message-State: AOJu0YzF44vZGRryRsbFyGh4sMgRV8C7M/3ifXcc1Lro4Eu0rgQTXugh
	5/lYlqIyQeMzLQaUKRkgU+T0F9cUwI6bLkuwtne3mgpOIANKKBRBeZjCfQ==
X-Gm-Gg: ASbGnct0RAfZc29dS+lzOfDVEyFFsLdzgHZ7jjXnQCr8I8m1Ob/w2ormEb9WSofQHJ6
	F6z970gm4KancLmGX3U1JN7rIk43uIz6p2bkShkAzF1LqI1+OqcKI4sjX6V4C6hcd/lVlNyKi6N
	xs97ai5QRZZwcxnJOcpSqgTySeCi6hX1q/GXJ7SHCY5T6S/HXv+/PAShzkptBJ465VOv+AWHGsq
	4904yEyD34poy/DbYRPRoAVQ6srmC6eyB42OBZbbXR7QDQ4cPTKGu3nuv5a0YJ/0DAMNIhARub6
	V3sbQMaPKGBzD9pQXANWdAN+NcaVAYSc+EpoPl/ENRWC6PhvdBILGHxj+vUBKq+2EZQxmcmEW56
	b7rEq9OcpBt9EvWFdt8yMAh5j6oTR81K/Ai/sBsOfovI=
X-Google-Smtp-Source: AGHT+IGPkPGzMYBymYfGMbSXwRJVFOrnPha+/4SLcSH/jn3Bq1ITGLwoMrUNK4f/OjQQ6LQMS2n1UA==
X-Received: by 2002:a05:6000:2406:b0:38f:3a89:fdb5 with SMTP id ffacd0b85a97d-39cb3575d97mr13413751f8f.11.1744102807493;
        Tue, 08 Apr 2025 02:00:07 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0024496da6ab48450e.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:2449:6da6:ab48:450e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3020da22sm14555925f8f.68.2025.04.08.02.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 02:00:06 -0700 (PDT)
Date: Tue, 8 Apr 2025 11:00:04 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 1/2] bpf: Clarify role of BPF_F_RECOMPUTE_CSUM
Message-ID: <ff6895d42936f03dbb82334d8bcfd50e00c79086.1744102490.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

BPF_F_RECOMPUTE_CSUM doesn't update the actual L3 and L4 checksums in
the packet, but simply updates skb->csum (according to skb->ip_summed).
This patch clarifies that to avoid confusions.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 include/uapi/linux/bpf.h       | 14 +++++++++-----
 tools/include/uapi/linux/bpf.h | 14 +++++++++-----
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 28705ae67784..9c184a66ebcd 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1995,11 +1995,15 @@ union bpf_attr {
  * long bpf_skb_store_bytes(struct sk_buff *skb, u32 offset, const void *from, u32 len, u64 flags)
  * 	Description
  * 		Store *len* bytes from address *from* into the packet
- * 		associated to *skb*, at *offset*. *flags* are a combination of
- * 		**BPF_F_RECOMPUTE_CSUM** (automatically recompute the
- * 		checksum for the packet after storing the bytes) and
- * 		**BPF_F_INVALIDATE_HASH** (set *skb*\ **->hash**, *skb*\
- * 		**->swhash** and *skb*\ **->l4hash** to 0).
+ * 		associated to *skb*, at *offset*. The *flags* are a combination
+ * 		of the following values:
+ *
+ * 		**BPF_F_RECOMPUTE_CSUM**
+ * 			Automatically update *skb*\ **->csum** after storing the
+ * 			bytes.
+ * 		**BPF_F_INVALIDATE_HASH**
+ * 			Set *skb*\ **->hash**, *skb*\ **->swhash** and *skb*\
+ * 			**->l4hash** to 0.
  *
  * 		A call to this helper is susceptible to change the underlying
  * 		packet buffer. Therefore, at load time, all checks on pointers
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 28705ae67784..9c184a66ebcd 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1995,11 +1995,15 @@ union bpf_attr {
  * long bpf_skb_store_bytes(struct sk_buff *skb, u32 offset, const void *from, u32 len, u64 flags)
  * 	Description
  * 		Store *len* bytes from address *from* into the packet
- * 		associated to *skb*, at *offset*. *flags* are a combination of
- * 		**BPF_F_RECOMPUTE_CSUM** (automatically recompute the
- * 		checksum for the packet after storing the bytes) and
- * 		**BPF_F_INVALIDATE_HASH** (set *skb*\ **->hash**, *skb*\
- * 		**->swhash** and *skb*\ **->l4hash** to 0).
+ * 		associated to *skb*, at *offset*. The *flags* are a combination
+ * 		of the following values:
+ *
+ * 		**BPF_F_RECOMPUTE_CSUM**
+ * 			Automatically update *skb*\ **->csum** after storing the
+ * 			bytes.
+ * 		**BPF_F_INVALIDATE_HASH**
+ * 			Set *skb*\ **->hash**, *skb*\ **->swhash** and *skb*\
+ * 			**->l4hash** to 0.
  *
  * 		A call to this helper is susceptible to change the underlying
  * 		packet buffer. Therefore, at load time, all checks on pointers
-- 
2.43.0



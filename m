Return-Path: <bpf+bounces-43131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC749AF81A
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 05:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70BE9282E56
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 03:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC3818A6CE;
	Fri, 25 Oct 2024 03:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcGLqGYf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FD542A81
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 03:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729826431; cv=none; b=X3wtpHJk+9dghiKi6+/mlj+Z1OuTRzuRnvDdDH4tAqwuKf74CEuN9NPAGHL9/2AmdECC7PYruzTIIKPJ+355+ZRQB4sdKb4FAfbT5yg6LviBZlOfZmIXSbeWtK+SNG8D8Kvi3YDi7kNageg9zbQ92xysWow8UXpomU6hLn6zik0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729826431; c=relaxed/simple;
	bh=IzyRmrZ4R2/uYPfMIJIbxtWH3q11EUpQBZUwGr5UhRA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rR54nzn07LYnffzfjiIE7CKU74hdfo7jlIGBY9q1DvYAReU43A5eU+62tq8tNMn1vrGVF67N4tW1PuseksY5OY9iMRRnUo1J3J1tCazjjw5vImb1yWP9/JwKB7TZWsDwMs+YZLx6T4yJMyj2Ie18GjKYhz92EXQBSHIoJtAAQg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcGLqGYf; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7c1324be8easo1861311a12.1
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 20:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729826428; x=1730431228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1vlugpJTt6Ls2D7fL2S6D2Zykcy5m4I71v94Mm8dawQ=;
        b=bcGLqGYfbvNn+tM8mdhol0bPCoF3+5xbriL1B30YGgVYUgsQHk/7cUYPpo8M6gE8iD
         csUN8I6RpDkx07egJiJlDbjYA4solzvkZvRJzs41crUZC2cq9T9a7yG2qHD8T9gpW+3F
         3BTBr/MhRF92SilClnE+PkWre2X5K2fCcO6y0Y6J5m68LcYEOe3jMbsZA4xOOvT9qw+n
         fM0MOKeptHsSaW9GbndnaEJ5nAH79l8ooh0PVhznvglgJ1qmLZl5htCzIVNGz/x9N5vv
         +mnCw3Aj9+VoV54zfKSi6HWEH2L/IyrILdtzFHSzJuJ0IXETaUICrk4CwhlFuozc+Eol
         fF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729826428; x=1730431228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1vlugpJTt6Ls2D7fL2S6D2Zykcy5m4I71v94Mm8dawQ=;
        b=HKAvSuurYhxZdz16oRZhwwNLnzGmImpqxuC4xSaZo1SE1Hl+lLfwDhGI5hinlHx/pR
         +VZmQPdaV7qb/ZQ1hxbR4zFnRpXJlPH2TbEU0b+0yProElj0hMJ9igsiWytq1XLjXkdO
         oT6wOIX4hW1q09cM601uKjgAqimAKyS24jLfICbUhPtUiQ4C+/CwWRDenKywppoP1QWN
         nVkpImaS/4nNhfDp+WOGjXoSmiELr9qRBciS5lXdKPQLdh2y0VAdKxxLNcpOuDGDFy3r
         ybAPB3ImpvLhxQHlFV/tVNpdHUk3yyqWgIjp8Qc4k679HY5NrhCdcazeLP+K8lwB/PUL
         HTkw==
X-Gm-Message-State: AOJu0YxGnZmai0+ZPqBzveMTatoSU7SAXUDNUMFSRZzj4RykFKMkGOz4
	IpLNHMhaQdY03Z5NQlPUcgwRfXKbkfZ7uTLvLusZmX9/OG1DELSEBScMBw==
X-Google-Smtp-Source: AGHT+IFswTXSp6aK1ydRNIMdKuy0nDyFiX4LaSbuLKAUYb0cglOfOX9d8A49xy7AgHYvnfFx3SdnFw==
X-Received: by 2002:a17:903:244c:b0:20b:5ef8:10a6 with SMTP id d9443c01a7336-20fb88aa47bmr61820465ad.8.1729826428446;
        Thu, 24 Oct 2024 20:20:28 -0700 (PDT)
Received: from r210.hsd1.ca.comcast.net ([2601:648:4280:48f0::d8bf])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc017863sm1465915ad.165.2024.10.24.20.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 20:20:28 -0700 (PDT)
From: Vincent Li <vincent.mc.li@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Vincent Li <vincent.mc.li@gmail.com>
Subject: [PATCH] selftests/bpf: remove xdp_synproxy IP_DF check
Date: Fri, 25 Oct 2024 03:19:52 +0000
Message-Id: <20241025031952.1351150-1-vincent.mc.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In real world production websites, the IP_DF flag
is not always set for each packet from these websites.
the IP_DF flag check breaks Internet connection to
these websites for home based firewall like BPFire
when XDP synproxy program is attached to firewall
Internet facing side interface. see [0]

[0] https://github.com/vincentmli/BPFire/issues/59

Signed-off-by: Vincent Li <vincent.mc.li@gmail.com>
---
 tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c b/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
index f8f5dc9f72b8..62b8e29ced9f 100644
--- a/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
+++ b/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
@@ -21,7 +21,6 @@
 
 #define tcp_flag_word(tp) (((union tcp_word_hdr *)(tp))->words[3])
 
-#define IP_DF 0x4000
 #define IP_MF 0x2000
 #define IP_OFFSET 0x1fff
 
@@ -442,7 +441,7 @@ static __always_inline int tcp_lookup(void *ctx, struct header_pointers *hdr, bo
 		/* TCP doesn't normally use fragments, and XDP can't reassemble
 		 * them.
 		 */
-		if ((hdr->ipv4->frag_off & bpf_htons(IP_DF | IP_MF | IP_OFFSET)) != bpf_htons(IP_DF))
+		if ((hdr->ipv4->frag_off & bpf_htons(IP_MF | IP_OFFSET)) != 0)
 			return XDP_DROP;
 
 		tup.ipv4.saddr = hdr->ipv4->saddr;
-- 
2.34.1



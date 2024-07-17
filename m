Return-Path: <bpf+bounces-34958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 044689341A9
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 19:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D4EA1F243EA
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 17:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B96188CD8;
	Wed, 17 Jul 2024 17:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrV80G4j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC53C183080;
	Wed, 17 Jul 2024 17:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721238475; cv=none; b=bRKsGvmN635AnwOAbs6LWbYkH93V2dDhQjY5Rf1KlsfW0me10PYVLRfL+RwdvlgVXk4MHfnxUZ/kuHeZ/l1Q5sKMJl0ogjb7mbLkQ3nRq6609RQcLYCu4zuIi6F1qU+c6Lj9E2U+7uUAnW/GsLisyShG653tmbQ0PXEw+OvytKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721238475; c=relaxed/simple;
	bh=hlw8mQSVUmKVKhzFLnEybQ+LNvuuiXl75EnFgGgdVXA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UmYKD+HPGYLGyOpviumjEDdBop4sdrlUXhKfw2jivtDZfLfjf0CJCvteVd8Is1I2EeB5DugQ3eH9BssXUFWbGILDrrEXxWQK0I29za48MIowWdSI1Xjf1IqXIjWW+LNfnShV82vHvgcRwzf5AjQDOm2MxdmJ9PTY8VCXlFIHP8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrV80G4j; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2caaae31799so5095613a91.0;
        Wed, 17 Jul 2024 10:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721238473; x=1721843273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u0sh2Qx0QKHKW9EVnBg4PhiJlHbuvx8m1ke9g+ElCrk=;
        b=SrV80G4jhEiubSCv4i9krR+1AeNhD3f8aSTGLDTyjQPkfbqyojjsAldkFIjYfHKlcC
         pT4SF0cnUgflhGFdpHTCe1gc3TMYSPQfH3s95tx8LverH7L2x5N/W6nlzjRcuoR3AlC9
         lfQ8cP6AxaF0wm1eYPbPvlBMyEVj4jlq5FG2o6AyI1VS1YUyeRYJPj0hOTITczbiL6zh
         21W1L0UeozWPZnOFRZSbPOQ6K64YhfIQVUDDpii7Q8NIRyBzBdOd0Gu3uZBOaSpjW0A0
         WgZJuxdQJmNr5VEHBbJKAMx5eAUlosEz7IQRdENd5Wo4b27/38KZR2t478saSbViKgUu
         VQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721238473; x=1721843273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u0sh2Qx0QKHKW9EVnBg4PhiJlHbuvx8m1ke9g+ElCrk=;
        b=FoFEtQQJIxKDQA8gTftSBmh//htxMZcZMrS5dKymKHCzUFkw3JYseTN/1P0y9+WdfI
         HSycqAKRclMksSrWh+S/3gHMShj1RFhf0XFD7alrvC6GMC5fi1I1nkepGMumaqoRy6SG
         5V/7oXt847Hna66XPs4pgKBDhrGbyzCPc0SX5YdtAFtzZlsK44L4E/k4aXUBiwuSg0Dh
         R1cj5aWH4HeoHF+lT1zqr36z6FF2LoDKBh98HAUfGQ2hLWQ3gu+fcOM90wElhmLjV7ra
         hH7u1c8zWSUrpTvkbL+zUR7CVFd/6Vdz6pEbTKETTImHwWoQqQaBYLb1O2wnijQ1eTyF
         eV8w==
X-Forwarded-Encrypted: i=1; AJvYcCW8on7LbysGvrFVvAz8dmxkfKqD0wANpC6VEfT6/qBu6J70XJTx3d3dfFgAsuAYWfJPH4rHna3ntX53hy3F3qJgraUBhH16yzyb2ejWRaPC3ZrZq8fczXKmg9sUQyrT4j5t
X-Gm-Message-State: AOJu0Ywn/zDJjecuXR85+ekvZAkSwiANYyyxUoTXNEjIBSnak2BW9FSi
	8eK/xTYZIYD5tyd+A6G1LZfY5NFsVhDxAL0U1CWCTCJ5T/AsL16B
X-Google-Smtp-Source: AGHT+IFNpZSwxKYCjKtdzPxrBLb/WA0ob6ivkZ0SDSsRQkxtL212u4LOI9S4TGdzA6qgOIaGGf8CsA==
X-Received: by 2002:a17:90a:fd04:b0:2cb:4f14:2a70 with SMTP id 98e67ed59e1d1-2cb529327f7mr1951043a91.30.1721238472901;
        Wed, 17 Jul 2024 10:47:52 -0700 (PDT)
Received: from localhost ([116.198.225.81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb601ec946sm217440a91.37.2024.07.17.10.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 10:47:52 -0700 (PDT)
From: Tao Chen <chen.dylane@gmail.com>
To: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	chen.dylane@gmail.com
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [v2 PATCH bpf-next 2/4] bpftool: add net attach/detach command to tcx prog
Date: Thu, 18 Jul 2024 01:47:49 +0800
Message-Id: <20240717174749.1511366-1-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now, attach/detach tcx prog supported in libbpf, so we can add new
command 'bpftool attach/detach tcx' to attach tcx prog with bpftool
for user.

 # bpftool prog load tc_prog.bpf.o /sys/fs/bpf/tc_prog
 # bpftool prog show
	...
	192: sched_cls  name tc_prog  tag 187aeb611ad00cfc  gpl
	loaded_at 2024-07-11T15:58:16+0800  uid 0
	xlated 152B  jited 97B  memlock 4096B  map_ids 100,99,97
	btf_id 260
 # bpftool net attach tcx_ingress name tc_prog dev lo
 # bpftool net
	...
	tc:
	lo(1) tcx/ingress tc_prog prog_id 29

 # bpftool net detach tcx_ingress dev lo
 # bpftool net
	...
	tc:
 # bpftool net attach tcx_ingress name tc_prog dev lo
 # bpftool net
	tc:
	lo(1) tcx/ingress tc_prog prog_id 29

Test environment: ubuntu_22_04, 6.7.0-060700-generic

Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 tools/bpf/bpftool/net.c | 43 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
index 1b9f4225b394..60b0af40109a 100644
--- a/tools/bpf/bpftool/net.c
+++ b/tools/bpf/bpftool/net.c
@@ -67,6 +67,8 @@ enum net_attach_type {
 	NET_ATTACH_TYPE_XDP_GENERIC,
 	NET_ATTACH_TYPE_XDP_DRIVER,
 	NET_ATTACH_TYPE_XDP_OFFLOAD,
+	NET_ATTACH_TYPE_TCX_INGRESS,
+	NET_ATTACH_TYPE_TCX_EGRESS,
 };
 
 static const char * const attach_type_strings[] = {
@@ -74,6 +76,8 @@ static const char * const attach_type_strings[] = {
 	[NET_ATTACH_TYPE_XDP_GENERIC]	= "xdpgeneric",
 	[NET_ATTACH_TYPE_XDP_DRIVER]	= "xdpdrv",
 	[NET_ATTACH_TYPE_XDP_OFFLOAD]	= "xdpoffload",
+	[NET_ATTACH_TYPE_TCX_INGRESS]	= "tcx_ingress",
+	[NET_ATTACH_TYPE_TCX_EGRESS]	= "tcx_egress",
 };
 
 static const char * const attach_loc_strings[] = {
@@ -647,6 +651,32 @@ static int do_attach_detach_xdp(int progfd, enum net_attach_type attach_type,
 	return bpf_xdp_attach(ifindex, progfd, flags, NULL);
 }
 
+static int get_tcx_type(enum net_attach_type attach_type)
+{
+	switch (attach_type) {
+	case NET_ATTACH_TYPE_TCX_INGRESS:
+		return BPF_TCX_INGRESS;
+	case NET_ATTACH_TYPE_TCX_EGRESS:
+		return BPF_TCX_EGRESS;
+	default:
+		return __MAX_BPF_ATTACH_TYPE;
+	}
+}
+
+static int do_attach_tcx(int progfd, enum net_attach_type attach_type, int ifindex)
+{
+	int type = get_tcx_type(attach_type);
+
+	return bpf_prog_attach(progfd, ifindex, type, 0);
+}
+
+static int do_detach_tcx(int targetfd, enum net_attach_type attach_type)
+{
+	int type = get_tcx_type(attach_type);
+
+	return bpf_prog_detach(targetfd, type);
+}
+
 static int do_attach(int argc, char **argv)
 {
 	enum net_attach_type attach_type;
@@ -692,6 +722,11 @@ static int do_attach(int argc, char **argv)
 	case NET_ATTACH_TYPE_XDP_OFFLOAD:
 		err = do_attach_detach_xdp(progfd, attach_type, ifindex, overwrite);
 		break;
+	/* attach tcx prog */
+	case NET_ATTACH_TYPE_TCX_INGRESS:
+	case NET_ATTACH_TYPE_TCX_EGRESS:
+		err = do_attach_tcx(progfd, attach_type, ifindex);
+		break;
 	default:
 		break;
 	}
@@ -738,6 +773,11 @@ static int do_detach(int argc, char **argv)
 		progfd = -1;
 		err = do_attach_detach_xdp(progfd, attach_type, ifindex, NULL);
 		break;
+	/* detach tcx prog */
+	case NET_ATTACH_TYPE_TCX_INGRESS:
+	case NET_ATTACH_TYPE_TCX_EGRESS:
+		err = do_detach_tcx(ifindex, attach_type);
+		break;
 	default:
 		break;
 	}
@@ -944,7 +984,8 @@ static int do_help(int argc, char **argv)
 		"       %1$s %2$s help\n"
 		"\n"
 		"       " HELP_SPEC_PROGRAM "\n"
-		"       ATTACH_TYPE := { xdp | xdpgeneric | xdpdrv | xdpoffload }\n"
+		"       ATTACH_TYPE := { xdp | xdpgeneric | xdpdrv | xdpoffload | tcx_ingress\n"
+		"			 | tcx_egress }\n"
 		"       " HELP_SPEC_OPTIONS " }\n"
 		"\n"
 		"Note: Only xdp, tcx, tc, netkit, flow_dissector and netfilter attachments\n"
-- 
2.34.1



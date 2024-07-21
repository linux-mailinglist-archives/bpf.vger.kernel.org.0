Return-Path: <bpf+bounces-35192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C957B938508
	for <lists+bpf@lfdr.de>; Sun, 21 Jul 2024 16:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53EF61F21C49
	for <lists+bpf@lfdr.de>; Sun, 21 Jul 2024 14:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C501649BF;
	Sun, 21 Jul 2024 14:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTkw67hu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC92A8F66;
	Sun, 21 Jul 2024 14:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721572951; cv=none; b=KQw+NvBspr2l98BVUNdFOmzDgaWp9sAfGr0WXXHwkN+yLmJr82nS6ptPFTPlF9NCP8C/cdtHWLRkuu/PJdWipK0GMQq78zMKFn9z3sgL+BkO5HHsF8RQRIGgLw5HlPCwHJr+kK3aQksMOEXRYMexNpGwxER15AqLDmt6g7hEkP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721572951; c=relaxed/simple;
	bh=guTMrBNWCCj3x3CBZP4CXoEn+Wy/dse1eYwuyj4IxNg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Env+wayDVE3hul6/L28JNy5nn2xHKnWc5yqO+1Htpa4DBPLZO5RNxPk+TFc9LRhGakGFcr9R8T7WuMN+2u0eTtDqB7NJJn6p5RxmXpEcoB7w4j710uLHrAkBaThGedC1U6Wym3u0LBnKSlRqOjubmOhYdhHqKX6FC/ICMvbaig4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTkw67hu; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2cb674b48ccso1592312a91.2;
        Sun, 21 Jul 2024 07:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721572949; x=1722177749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WvvkNmauGXe467uoPM8a1FFpY63QozPxGUOvyMzBA+U=;
        b=TTkw67hu/YncMePIKhxsRVwbhNv5/2a7UXOAdw1baFwIE5POHAxjW2OccePD0y6CG6
         Eau81k6MRXb6ZhOHgZU+E3IbW5g8kg5+ZN4Hh4b/jmmd6cKliYvqABfChJHntykMBdnX
         PjnJmfYc0RQZmUM99vkhx1Kqkowx2pJSzp/YA9SUp56y+NXmQIHEpSsmun1JNSkGocV1
         GNWhWm+/fNYZExDrEi8KjH7aUUncHbmKWN/FAs2ihHkjSw+h1rP4JnpWbam6rfT18pJj
         1+Dc+AdAhmttAbu6GYxu25wXV2rcOC+fck7lAAsOzRur4py08AJRPNBsHmu5mNQ8hm6g
         /LZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721572949; x=1722177749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WvvkNmauGXe467uoPM8a1FFpY63QozPxGUOvyMzBA+U=;
        b=rPkm0WcHR0d3KeS2wyObNvvGQkxRqnG0PYTVbi9aam9iPdszTf2SH7Qwunvb1uL+SA
         3h5L9bHCr2j/mJ1nCiZd5B1Ft1PtQa7pscL9MpQbUu9tQwGSvSEh1kji6Vzh6to9WfWF
         c6WDmu+gUqQ713kA1Qi5kJfaF3YDe6lc/pc6ho/9gbOTjbbAvjH21RO1ObfVcbV9Uifc
         RZbIQgfAIV3iPpIe9GpVFi5LHm0DisPPnBeDZ8ZX70+jxwLzrGxL6hWIL6pcHXdMT4Gj
         ni/+f2+wT+HblDxS0Z+V27tyyl4Xl6TDiG7e5+jQ/2QXHYxenMF/Va0eY5oRBsJJsalX
         jXdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnwEnk81MjlVItMezIKKJPaukmeJFLBbQjP9puyb1jjq0QEMp1w3AtRJDzrN5aa+C6P/rGqqVDXOKDvnBZvwNkCU03FC43I8XYZUGspXHhUBENcPYAMEfducGAh7KJUbX/
X-Gm-Message-State: AOJu0YwlnU6WRqdY9ZwyuanTyWlPGeM8hur1YL/KZA1qpbYe5hg/nZSo
	vYlgprVHh4iaDhqetuSn37aVjYw0NSoarXLCdm+lsVDsiAvfpUgX
X-Google-Smtp-Source: AGHT+IHuJbNhmcrB2AfJVeX2K4UsZsGkxV5B06qNfzVq5kwuLSB7WBdkAw+EpSjTirL04fw4YzCWKw==
X-Received: by 2002:a17:90b:28e:b0:2c9:73ff:6a0c with SMTP id 98e67ed59e1d1-2cd15ee7214mr2502612a91.20.1721572948786;
        Sun, 21 Jul 2024 07:42:28 -0700 (PDT)
Received: from localhost ([117.147.31.23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb775416fasm6264683a91.53.2024.07.21.07.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 07:42:28 -0700 (PDT)
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
Subject: [v3 PATCH bpf-next 2/4] bpftool: add net attach/detach command to tcx prog
Date: Sun, 21 Jul 2024 22:42:21 +0800
Message-Id: <20240721144221.96228-1-chen.dylane@gmail.com>
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
index 1b9f4225b394..2a51f1c25732 100644
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
+		return -1;
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
+		"                        | tcx_egress }\n"
 		"       " HELP_SPEC_OPTIONS " }\n"
 		"\n"
 		"Note: Only xdp, tcx, tc, netkit, flow_dissector and netfilter attachments\n"
-- 
2.34.1



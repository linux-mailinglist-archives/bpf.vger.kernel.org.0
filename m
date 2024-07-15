Return-Path: <bpf+bounces-34816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C363A931332
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 13:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D15C1F23C00
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 11:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E66C18A93D;
	Mon, 15 Jul 2024 11:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcjuZQJp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62C518A925;
	Mon, 15 Jul 2024 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721043434; cv=none; b=Vj9suj+V8kRgLL6hjE62ooKnqiKoyyXDtw2pD8rzt9t5g1wR4/36KeuSoqK6l3u7lYfHLNhOonc1hFt7biExXPJueEpwEMaFQTIt75rRms0d8iAvUvubFIMpxq3v0P7NXFb2lAaSuYDg43d/5nFD+auWp7zeWCSowxTJeKBry/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721043434; c=relaxed/simple;
	bh=1QUcsR+BiVPRqwBvfE5+BpO2UKVt8GgqxB8nghPOXWg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BzVtrmuSs7IQmSut6tBPzMn9MffQ+WqMCETN/5ZrqJkmwxAM+M1G2Yu2yiIy083t4AxnFpcfCahk8RXu00qxg+KXh0PvFaN4TD7ag+ORyTOYcNkEkiuk3655jlffGAfUfWpERfa77Ljo8/cjoUicPkrJ3jznS5/Ls3VIIr0vNWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcjuZQJp; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-706a1711ee5so2717714b3a.0;
        Mon, 15 Jul 2024 04:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721043432; x=1721648232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3sefb0CySiaiRrHnR/EzipZicbEpcn9KQcRu1F8eSY=;
        b=AcjuZQJp2St3RlR1D5WiuOx5V7S3S/F4U0rKTL0IP3cr2cnXLi4IbNHzxjMUM6O/J3
         Lh8lnN1xzl3ai5vm5F0C29+kdmSmotgyUyHXYsm3LqNZnoFVUQvvBEddoJ/YMRJZB6mI
         rZTM/D/ZJ6aQytPqssBa6l3NI8k3VH1TRp9iUPRIft8mYQneS0IBJ5Nj5/3Ay3Qkxdjm
         jCkdR72ZMohvEYFk3vfj+mKmhj0nAU6kXPdDpcpIjfvVXYCUukpJCycs6MnZzxQreyiF
         KKn3BHUNW+t2QXQKlvH7+fwzUI3qBpaY3MdyE5Jdi/pQx7YulIJ6YUlaQSSjCgPyWF+c
         c0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721043432; x=1721648232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b3sefb0CySiaiRrHnR/EzipZicbEpcn9KQcRu1F8eSY=;
        b=rYNopr4bbMzp8ZQbpZtBrQ7RIN4SmslB+0sVOURiIpw22PK//sPiJtWUHNV16lGRDE
         SINaGVvAmkgErkc8BzA0HR3PXtCQ/pwGGFh3CaUNgQ0VuM0M73tAyiQcAUJMa8Z3eMVP
         WLdIrEIxce5CidcJFg8ypRKKKAMXyTk0erJIejd3zsxZkvdCKZ+W0wxYIekYjSyvHp4K
         TNoGo6c3nhclAEEjUkdKBF6Kjk+4XxOGz9ptb0VqjAuvxM13wtQM6pvbEGIK5P2lqZnj
         9ZhUbyY29B3eJi4W+GFAFNRFfKt8QX6TptQ7dV06Vzv2TsjqEzyatyRHNUWTAr92tw77
         nkOA==
X-Forwarded-Encrypted: i=1; AJvYcCV6qt8VDVQud4p2sJiOJoM4JbRpN4eIK7n40XMOx8s3GAJZlzkn+TxuJTuWVUJAvuddif8oHT07bFYQP7ah3CJjizRbYLZesp8JVf6QLoiRKXm4zoOVUwlLkBSayy3OqPzY
X-Gm-Message-State: AOJu0Yz0J8AX7DiK1B9xVBwE0hV6mFk/VZdQ3s3LMW30lgt8uAPe9PYm
	MNVPU0BeGg7683Ra+N/50LX467Nb2HpheHLn/5po17FCiws5pyld
X-Google-Smtp-Source: AGHT+IELDSghqsJ5SvzpPtMIsnQUL8zllWJcQtJ6eQ++tSJ+WPlujPq3wziYMh93vzcKE2vkEJKmHQ==
X-Received: by 2002:a05:6a21:e89:b0:1c2:922f:379c with SMTP id adf61e73a8af0-1c29822d199mr17708540637.23.1721043431732;
        Mon, 15 Jul 2024 04:37:11 -0700 (PDT)
Received: from localhost ([116.198.225.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eb9c90asm4255021b3a.12.2024.07.15.04.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 04:37:11 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next 1/3] bpftool: add net attach/detach command to tcx prog
Date: Mon, 15 Jul 2024 19:37:02 +0800
Message-Id: <20240715113704.1279881-2-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240715113704.1279881-1-chen.dylane@gmail.com>
References: <20240715113704.1279881-1-chen.dylane@gmail.com>
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
 # bpftool net attach tcxingress name tc_prog dev lo
 # bpftool net
	...
	tc:
	lo(1) tcx/ingress tc_prog prog_id 29

 # bpftool net detach tcxingress dev lo
 # bpftool net
	...
	tc:
 # bpftool net attach tcxingress name tc_prog dev lo
 # bpftool net
	tc:
	lo(1) tcx/ingress tc_prog prog_id 29

Test environment: ubuntu_22_04, 6.7.0-060700-generic

Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 tools/bpf/bpftool/net.c | 52 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
index 968714b4c3d4..be7fd76202f1 100644
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
+	[NET_ATTACH_TYPE_TCX_INGRESS]	= "tcxingress",
+	[NET_ATTACH_TYPE_TCX_EGRESS]	= "tcxegress",
 };
 
 static const char * const attach_loc_strings[] = {
@@ -647,6 +651,32 @@ static int do_attach_detach_xdp(int progfd, enum net_attach_type attach_type,
 	return bpf_xdp_attach(ifindex, progfd, flags, NULL);
 }
 
+static int get_tcx_type(enum net_attach_type attach_type)
+{
+	int type = 0;
+
+	if (attach_type == NET_ATTACH_TYPE_TCX_INGRESS)
+		type |= BPF_TCX_INGRESS;
+	else if (attach_type == NET_ATTACH_TYPE_TCX_EGRESS)
+		type |= BPF_TCX_EGRESS;
+
+	return type;
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
@@ -694,6 +724,15 @@ static int do_attach(int argc, char **argv)
 		goto cleanup;
 	}
 
+	/* attach tcx prog */
+	if (is_prefix("tcx", attach_type_strings[attach_type]))
+		err = do_attach_tcx(progfd, attach_type, ifindex);
+	if (err) {
+		p_err("interface %s attach failed: %s",
+		      attach_type_strings[attach_type], strerror(-err));
+		goto cleanup;
+	}
+
 	if (json_output)
 		jsonw_null(json_wtr);
 cleanup:
@@ -732,6 +771,16 @@ static int do_detach(int argc, char **argv)
 		return err;
 	}
 
+	/* detach tcx prog */
+	if (is_prefix("tcx", attach_type_strings[attach_type]))
+		err = do_detach_tcx(ifindex, attach_type);
+
+	if (err < 0) {
+		p_err("interface %s detach failed: %s",
+		      attach_type_strings[attach_type], strerror(-err));
+		return err;
+	}
+
 	if (json_output)
 		jsonw_null(json_wtr);
 
@@ -928,7 +977,8 @@ static int do_help(int argc, char **argv)
 		"       %1$s %2$s help\n"
 		"\n"
 		"       " HELP_SPEC_PROGRAM "\n"
-		"       ATTACH_TYPE := { xdp | xdpgeneric | xdpdrv | xdpoffload }\n"
+		"       ATTACH_TYPE := { xdp | xdpgeneric | xdpdrv | xdpoffload | tcxingress\n"
+		"			| tcxegress}\n"
 		"       " HELP_SPEC_OPTIONS " }\n"
 		"\n"
 		"Note: Only xdp, tcx, tc, netkit, flow_dissector and netfilter attachments\n"
-- 
2.34.1



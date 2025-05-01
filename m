Return-Path: <bpf+bounces-57163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DA9AA6637
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 00:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D435D9C7468
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 22:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61D2266B7F;
	Thu,  1 May 2025 22:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iP7XXbFO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25D1243969;
	Thu,  1 May 2025 22:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746138630; cv=none; b=fzj6yONiNDOvo8eKOUaO284GIMzjqpbqp0s1yWdL3q/i5VvtXoo0Q2o+hSKeRn+GrUPSMocYr1pmDaLON/R4+tZQyC4CAQV0lbESTwlhhC2wesQGLMiuB4O5yrsGF0hU0DBR/KRyQOfFbey7O06v5QYMEV298RcEN3bxHsi4svc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746138630; c=relaxed/simple;
	bh=NFInLjUiODgwiMg6Mnpeh+6ZYqB1SRC9NlpbMWbg/4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VdH/WmlsSLXGUWvl2r+4HgpQLd4zQ351hftazcZ4tvE7thibbdb1ZeJ9RufJY4XSnoIkc6CmUJddY4cJWOUmnaHlSExFfsi7E9EIbNwtCB9RCQfynE9Iy6LLgs83CX6PMeyQv7eF/D6ymd04O251gOfQL1u7G5XGM+NRSQRxEB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iP7XXbFO; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-227a8cdd241so19045235ad.3;
        Thu, 01 May 2025 15:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746138628; x=1746743428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3plIVAUbnGlwJ1tl0OtUjjCEb9eoxi+ebNBKQQl2Bg=;
        b=iP7XXbFO1Bc5JvvF7ZPSOG/LYIWgSwN49wHwA175EyWqUU4cH2w4i8t2WBstm7q4f+
         UhsH5VHSaHWWSj8fyjEiSkpA31nxRhQA2T+jX9ytg6pO3+MXBXEAlUM++O3TAkuSI9sW
         5g//LpwrzHiN7RmKvGWNVKQVoodAgRL7kvMaejBDSipId4gVuwqvc1W7Zqw1Kasv6cmE
         olaSjOzmXDLZVG1IilfUhcJ17Doz/3dYrFUe9G6UOtR2fTqQ9cQ4VHey/xF8j1Qs98nN
         +/h4a9k6eJonhI/tNJGqgwTepyNELQW0run6s7P6VStO3EoZ1UV0oPZqeC4KDWZAAV8u
         Twfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746138628; x=1746743428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3plIVAUbnGlwJ1tl0OtUjjCEb9eoxi+ebNBKQQl2Bg=;
        b=L+Cbb38ZppAxq4UkerIBtVnUGwRzv03tJlQ1B43YiiPxQuNmR8P6YT/0Po30knDCbH
         DvK97TbQPra24Gu/u3oIMqnK0TNXEV8jmfb4HnRR+5V1AsBAVc7Ol/jD/LAAxYf6BW9E
         mqhmuennsxYpSBduDWh3tdIqorTsEU0bQ5yu+61ljPuk3WlB7DxlLiVJM1v9Ai5RR+tU
         OokqndW9mYRGBvZQlmCoaPORQHdqNxaERGP6wltjo/5Ywg/Qz8YKkP85xxYTwyMjXTSN
         JduQdHG+yc1+XNeJAO6vyspDk6SeADfkxv0J7tQaV8EKk4lgDQcKB0rKPatqabs0DsBL
         RVkA==
X-Gm-Message-State: AOJu0Yx070PWFiI/i+l9IFfaY9P6dZF4xd3URcvU0fybFKSKJ9eyatvD
	rOsMsub44LPUKjvP/JplqOdgRLrz31qvvEX4A4PMlh+8Py2ojkwNuatgQw==
X-Gm-Gg: ASbGncuKG8lLXDqundfAML2jfpaCAq2PBdLeNbyf8+3WcY+HN1LuJL7uxm7hw5l8DBm
	ej5p1E7MFUyOPLJyqs5c2Vt8rxgsxFisR5x5HUoWcQAqHboxO2Z3ESNt4Eixlqv61TcVuKMQU7I
	TZ4TipX5PDUld4bVw56xdg7mG8MV8SctgEeUhdQT+8Msouh1H3gpBXmYMsAeOLRPRJjy50AZUbr
	iCJxaKLNYBL1ZnbgrzNSOZEpr+4j/1xlCC+yMvVxqktz0GyWc3D203kcgAIblUdpBBm6wQA6Qmi
	hLNZFzO4PnGAGZaJPnLt+vb35TPaixE=
X-Google-Smtp-Source: AGHT+IH795Oje1HBdKkNUu4xxNRrQxcTYED8o/F44x70bVqlvp0dSmWteseMHb4sCIraFwNeedgWzw==
X-Received: by 2002:a17:902:ea01:b0:215:94eb:adb6 with SMTP id d9443c01a7336-22e103b1e92mr9351915ad.40.1746138627974;
        Thu, 01 May 2025 15:30:27 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e108fbc91sm1454845ad.114.2025.05.01.15.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 15:30:27 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	xiyou.wangcong@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next/net v1 2/5] selftests/bpf: Test setting and creating bpf qdisc as default qdisc
Date: Thu,  1 May 2025 15:30:22 -0700
Message-ID: <20250501223025.569020-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501223025.569020-1-ameryhung@gmail.com>
References: <20250501223025.569020-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First, test that bpf qdisc can be set as default qdisc. Then, attach
an mq qdisc to see if bpf qdisc can be successfully created and grafted.

The test is a sequential test as net.core.default_qdisc is global.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/prog_tests/bpf_qdisc.c      | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
index c9a54177c84e..c954cc2ae64f 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
@@ -159,6 +159,79 @@ static void test_qdisc_attach_to_non_root(void)
 	bpf_qdisc_fifo__destroy(fifo_skel);
 }
 
+static int get_default_qdisc(char *qdisc_name)
+{
+	FILE *f;
+	int num;
+
+	f = fopen("/proc/sys/net/core/default_qdisc", "r");
+	if (!f)
+		return -errno;
+
+	num = fscanf(f, "%s", qdisc_name);
+	fclose(f);
+
+	return num == 1 ? 0 : -EFAULT;
+}
+
+static void test_default_qdisc_attach_to_mq(void)
+{
+	struct bpf_qdisc_fifo *fifo_skel;
+	char default_qdisc[IFNAMSIZ];
+	struct netns_obj *netns;
+	char tc_qdisc_show[64];
+	struct bpf_link *link;
+	char *str_ret;
+	FILE *tc;
+	int err;
+
+	fifo_skel = bpf_qdisc_fifo__open_and_load();
+	if (!ASSERT_OK_PTR(fifo_skel, "bpf_qdisc_fifo__open_and_load"))
+		return;
+
+	link = bpf_map__attach_struct_ops(fifo_skel->maps.fifo);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
+		bpf_qdisc_fifo__destroy(fifo_skel);
+		return;
+	}
+
+	err = get_default_qdisc(default_qdisc);
+	if (!ASSERT_OK(err, "read sysctl net.core.default_qdisc"))
+		goto out;
+
+	err = write_sysctl("/proc/sys/net/core/default_qdisc", "bpf_fifo");
+	if (!ASSERT_OK(err, "write sysctl net.core.default_qdisc"))
+		goto out;
+
+	netns = netns_new("bpf_qdisc_ns", true);
+	if (!ASSERT_OK_PTR(netns, "netns_new"))
+		goto out;
+
+	SYS(out_restore_dflt_qdisc, "ip link add veth0 type veth peer veth1");
+	SYS(out_delete_netns, "tc qdisc add dev veth0 root handle 1: mq");
+
+	tc = popen("tc qdisc show dev veth0 parent 1:1", "r");
+	if (!ASSERT_OK_PTR(tc, "tc qdisc show dev veth0 parent 1:1"))
+		goto out_delete_netns;
+
+	str_ret = fgets(tc_qdisc_show, sizeof(tc_qdisc_show), tc);
+	if (!ASSERT_OK_PTR(str_ret, "tc qdisc show dev veth0 parent 1:1"))
+		goto out_delete_netns;
+
+	str_ret = strstr(tc_qdisc_show, "qdisc bpf_fifo");
+	if (!ASSERT_OK_PTR(str_ret, "check if bpf_fifo is created"))
+		goto out_delete_netns;
+
+	SYS(out_delete_netns, "tc qdisc delete dev veth0 root mq");
+out_delete_netns:
+	netns_free(netns);
+out_restore_dflt_qdisc:
+	write_sysctl("/proc/sys/net/core/default_qdisc", default_qdisc);
+out:
+	bpf_link__destroy(link);
+	bpf_qdisc_fifo__destroy(fifo_skel);
+}
+
 void test_bpf_qdisc(void)
 {
 	struct netns_obj *netns;
@@ -178,3 +251,8 @@ void test_bpf_qdisc(void)
 
 	netns_free(netns);
 }
+
+void serial_test_bpf_qdisc_default(void)
+{
+	test_default_qdisc_attach_to_mq();
+}
-- 
2.47.1



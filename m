Return-Path: <bpf+bounces-52503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DB5A43FB0
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 13:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0927F1772FA
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 12:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38CF268C5A;
	Tue, 25 Feb 2025 12:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2tAHPgI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C5D267F62
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 12:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740487858; cv=none; b=MqIpiGTeUzApe0FZ0yzsMRng6OeY4DW0IlLRauZ3UBZSPio98sR8pb7ZvZg3rDzD/rdxZy+TdGhSEVfIBWYOZvdXh+7dwdX3Hht6pBTySc0y/AXjROqvnBObnFMcViQasFR3YEkyKKeWuqsOOhec9OriMbvTkIvplo42ZIowyXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740487858; c=relaxed/simple;
	bh=w2VDTZKgosHrBADgJ7K6NtMsV8whOrzUHimMApriL5c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HxTcm6Q7xGCjSRLYbIA8HrfdHmJZwHsA1kLg1uEImyu73tVqyKqvp0EANMvGpuJoui2Ve0Ii7ajk9g0icrK06XLZdo7kpPmwKFwGLtRQjt7H7McioCyEBke2lKiWVpP4SPhX1WZbWYgMPr4L0sp6PE7Dq9sX0r36s+sQWALbVes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2tAHPgI; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38f504f087eso4365774f8f.1
        for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 04:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740487855; x=1741092655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVlAZ/3eLH7YAGDTd7s2pnGjibHGsmeFO5jJjUGJuF0=;
        b=b2tAHPgIXJGW81VreEAcEb/KIO64SCc4460jlIEK9EICT0+ooGeRZBqO54k0t2mAsh
         7aXCWa6fVJS+vDMOu2wcfakTkOc/q2tdeNIEPIkzA0iRgyDIltUW7uCmm9Pmt/0KRMkV
         X+SWnmhJhGriTZozT7IIMw2FwR3GTkA71dFQa55mBJzM3LysD8d/24bAu3o+T/kVoQoG
         fBwS6eOtCuBEKT7QDlbK65HiqsxD5hfpqelsXXgK1JOBKGvFFjNDWBRVxXK8jDAJ81kM
         +TQ+x4zarbrqr94Y6O5WLm1sZ9UmB6ioNgDaMg/CtG4IQVNq5dlCKZigaHXJEDJ/rPCX
         hO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740487855; x=1741092655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jVlAZ/3eLH7YAGDTd7s2pnGjibHGsmeFO5jJjUGJuF0=;
        b=lDpcLyNDrJMc3cRmvfItwNySrCdvUEV2YHsjF+qmyn/pWUPz2wxJmnWGxO9vQoIt/6
         I+8QoHaua5n8FBOZ/ml8k/thGj4KcdXft3pXdjeR5XhN5ir33RzzivfidCvJl/5wcjUt
         AnW8ylLKZBFZu8eyycs5Wz/LRQYdp1oAEGKjlnOvkC1cm/QKZRLbNgHbSy5PGtfcR+eW
         6pgcUKrI68aY/6lIhJQOI8k/vVJG39AU/Y6+1jgjigetkVpMQWJ2+xFBJUzScuinxr3X
         oqcDSfvHsW/xeDIVV/UPMAxphFfW94MLDaFHXNHJsD8TGzO3JtXp6sZLR0TnVuo6gHxJ
         KfzA==
X-Gm-Message-State: AOJu0YzSs4chpoNcmUzQ+IHEtMOmGxxiB2FFeLiW1sbF2OsjMH9WKnzm
	RkAHalMC1JsbBN4L0pBPcVblKar5/y+8hBDKq6kziq6kNS+03LGbRcVZ6xhH7ec=
X-Gm-Gg: ASbGncsDO7RkLacxVbvN5AgfRucb/W2GTG5SEoHunH6hzvU2mCkeAJpZt0w+vfNMzJN
	JkUikEC+h4ye6qOfpiQnnbwHTlGMaBoHwjo+pKSl2LHOnII3649drzL8p3T/geC4ik5NOHwO4i3
	90zJtf9NNha1ZI6kry53lDkQjSwsksm4LCpH4SL+T45FHzc666YnuM02n3PRbYJBYtI9TJBOvsT
	tUcAPszopBX9OLLoStfcBVOi1a09q82mrviGkg/Dk4fcAkIMfm43djkQFez/tysjGUZ/T2z6EA5
	Hc5ppzD2Q6+Ve7hgiXMWtrsrwrC/trPZnF5cCyh1lphFsQBLziXOvQFBh6yFVekKJliViCKJ1QD
	1wqopidUHde9yoJo5Y4cqsjyAnDRtGRMQp3+N4Q==
X-Google-Smtp-Source: AGHT+IGDjaSSUhkdTNE7pUYhX5oDc0uxmpZLH30KAwGOQH7av5KG6G9ecglKBdpvqUAbvTGdm3WrDQ==
X-Received: by 2002:a05:6000:1546:b0:38f:3c8a:4bf4 with SMTP id ffacd0b85a97d-38f6e7561cdmr13806131f8f.6.1740487854874;
        Tue, 25 Feb 2025 04:50:54 -0800 (PST)
Received: from mtardy-friendly-lvh-runner.c.cilium-dev.internal (72.253.76.34.bc.googleusercontent.com. [34.76.253.72])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-390cd8e7165sm2194754f8f.73.2025.02.25.04.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 04:50:54 -0800 (PST)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: add cgroup_skb netns cookie tests
Date: Tue, 25 Feb 2025 12:50:31 +0000
Message-Id: <20250225125031.258740-2-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250225125031.258740-1-mahe.tardy@gmail.com>
References: <20250225125031.258740-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add netns cookie test that verifies the helper is now supported and work
in the context of cgroup_skb programs.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../selftests/bpf/prog_tests/netns_cookie.c   | 21 ++++++++++++-------
 .../selftests/bpf/progs/netns_cookie_prog.c   |  9 ++++++++
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/netns_cookie.c b/tools/testing/selftests/bpf/prog_tests/netns_cookie.c
index ac3c3c097c0e..e00cd34586dd 100644
--- a/tools/testing/selftests/bpf/prog_tests/netns_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/netns_cookie.c
@@ -33,20 +33,25 @@ void test_netns_cookie(void)

 	skel->links.get_netns_cookie_sockops = bpf_program__attach_cgroup(
 		skel->progs.get_netns_cookie_sockops, cgroup_fd);
-	if (!ASSERT_OK_PTR(skel->links.get_netns_cookie_sockops, "prog_attach"))
+	if (!ASSERT_OK_PTR(skel->links.get_netns_cookie_sockops, "prog_attach_sockops"))
 		goto done;

 	verdict = bpf_program__fd(skel->progs.get_netns_cookie_sk_msg);
 	map = bpf_map__fd(skel->maps.sock_map);
 	err = bpf_prog_attach(verdict, map, BPF_SK_MSG_VERDICT, 0);
-	if (!ASSERT_OK(err, "prog_attach"))
+	if (!ASSERT_OK(err, "prog_attach_sk_msg"))
 		goto done;

 	tc_fd = bpf_program__fd(skel->progs.get_netns_cookie_tcx);
 	err = bpf_prog_attach_opts(tc_fd, loopback, BPF_TCX_INGRESS, &opta);
-	if (!ASSERT_OK(err, "prog_attach"))
+	if (!ASSERT_OK(err, "prog_attach_tcx"))
 		goto done;

+	skel->links.get_netns_cookie_cgroup_skb = bpf_program__attach_cgroup(
+		skel->progs.get_netns_cookie_cgroup_skb, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.get_netns_cookie_cgroup_skb, "prog_attach_cgroup_skb"))
+		goto cleanup_tc;
+
 	server_fd = start_server(AF_INET6, SOCK_STREAM, "::1", 0, 0);
 	if (CHECK(server_fd < 0, "start_server", "errno %d\n", errno))
 		goto cleanup_tc;
@@ -69,16 +74,18 @@ void test_netns_cookie(void)
 	if (!ASSERT_OK(err, "getsockopt"))
 		goto cleanup_tc;

-	ASSERT_EQ(val, cookie_expected_value, "cookie_value");
+	ASSERT_EQ(val, cookie_expected_value, "cookie_value_sockops");

 	err = bpf_map_lookup_elem(bpf_map__fd(skel->maps.sk_msg_netns_cookies),
 				  &client_fd, &val);
 	if (!ASSERT_OK(err, "map_lookup(sk_msg_netns_cookies)"))
 		goto cleanup_tc;

-	ASSERT_EQ(val, cookie_expected_value, "cookie_value");
-	ASSERT_EQ(skel->bss->tcx_init_netns_cookie, cookie_expected_value, "cookie_value");
-	ASSERT_EQ(skel->bss->tcx_netns_cookie, cookie_expected_value, "cookie_value");
+	ASSERT_EQ(val, cookie_expected_value, "cookie_value_sk_msg");
+	ASSERT_EQ(skel->bss->tcx_init_netns_cookie, cookie_expected_value, "cookie_value_init_tcx");
+	ASSERT_EQ(skel->bss->tcx_netns_cookie, cookie_expected_value, "cookie_value_tcx");
+	ASSERT_EQ(skel->bss->cgroup_skb_init_netns_cookie, cookie_expected_value, "cookie_value_init_cgroup_skb");
+	ASSERT_EQ(skel->bss->cgroup_skb_netns_cookie, cookie_expected_value, "cookie_value_cgroup_skb");

 cleanup_tc:
 	err = bpf_prog_detach_opts(tc_fd, loopback, BPF_TCX_INGRESS, &optd);
diff --git a/tools/testing/selftests/bpf/progs/netns_cookie_prog.c b/tools/testing/selftests/bpf/progs/netns_cookie_prog.c
index c6edf8dbefeb..94040714af18 100644
--- a/tools/testing/selftests/bpf/progs/netns_cookie_prog.c
+++ b/tools/testing/selftests/bpf/progs/netns_cookie_prog.c
@@ -28,6 +28,7 @@ struct {
 } sock_map SEC(".maps");

 int tcx_init_netns_cookie, tcx_netns_cookie;
+int cgroup_skb_init_netns_cookie, cgroup_skb_netns_cookie;

 SEC("sockops")
 int get_netns_cookie_sockops(struct bpf_sock_ops *ctx)
@@ -91,4 +92,12 @@ int get_netns_cookie_tcx(struct __sk_buff *skb)
 	return TCX_PASS;
 }

+SEC("cgroup_skb/ingress")
+int get_netns_cookie_cgroup_skb(struct __sk_buff *skb)
+{
+	cgroup_skb_init_netns_cookie = bpf_get_netns_cookie(NULL);
+	cgroup_skb_netns_cookie = bpf_get_netns_cookie(skb);
+	return SK_PASS;
+}
+
 char _license[] SEC("license") = "GPL";
--
2.34.1



Return-Path: <bpf+bounces-53996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DDFA6007C
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 20:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83C437AEDE3
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 19:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D5A1F4727;
	Thu, 13 Mar 2025 19:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eydlmvif"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED261F462C;
	Thu, 13 Mar 2025 19:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741892614; cv=none; b=CU9khicWmD+gsYD2u5KczBUSEDx2Hc/S4z5zX7yAVcDvFhigClgDkfBzPxh9BpTDSYCiGwv2OeZQ0zBwuHg0T5y5P6CJdipUBby/JCImYZVPUut8+H8SPbVSVY90S+/bSCpo3v1pIxqrlyAdsHOLgRdH07qp23DUd7lQsXuWFsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741892614; c=relaxed/simple;
	bh=sVVkbk0Gn1THhmgFQQYZXWJ516ceqWV7SjuSKbWsCVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J0lPNYwN0b1T2vVRjNlALrx0jhOBRVOz/wUYOY6oA76ejfewFNffPx7Q4oyaf+GSSLfktD2WKlp+0SkPXRHfjbnn0mEfxZ8X74Lh+vJFENVrWBWWe8PZB6Hye2VYhpA2v+7/BNFCBCFIP9hmtRpadHWuUgKji14YhUiWuJkZbk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eydlmvif; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2239c066347so29308425ad.2;
        Thu, 13 Mar 2025 12:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741892612; x=1742497412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCot4AmKUdSjbCpz+84y1dF8CcLEygWZ6VcGHROBKi0=;
        b=eydlmvifiu4V47qAOr84ZA8ekI8XGsU22C7eoYiotnJDh8b0Z2rj3Fx3mafBfbP/Uy
         GnUNM2qG6bXePN8lcbMtQLH+tFeQT3ZgW9kVzst2/Va6Y/nP3NjA985IUNrIrcldqROx
         iofDyc5EAcizvEh/268t5gDHEnQftnPSDapNwr3oNZ5O+vF56UcxoqKcXQm2fAGWREsI
         za2YPGW55InbWFsKWd5fEPVMWvNb+f3P1Fww1LuUeYnoshEKlAV1PL95z0fFYnPFVvLW
         jPeg7uOOBip2xK14u1taTDyVpEF0eZR6+aG1Bp5g5B5MDoz7q1nmfKN4jBcpNCBh4+pd
         UTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741892612; x=1742497412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tCot4AmKUdSjbCpz+84y1dF8CcLEygWZ6VcGHROBKi0=;
        b=b5Ayl9QHg7EJVVkIv1KWP0wKBHovWZ5FHtOLSgm09CYMSOMGw9ozJoGuULts//8KyI
         1bkJQYLlcgIRkOiARq3yD2XQNsVYtummA1msyYm96jswDXKL2fa4609HpnNxykJcbG6N
         EsjoTJv5bsqCUZLXbzoZnW/CyBHgyGC118ZQ1u378M8xicj7XcxeoBWycAVbX2n49ySu
         tEtEov9LBkJj09FGKvv8GQ4gVMxmedm3AbQlMPXCKZZ9Y7ExADaAxxahPpbZqKGFgd+j
         POr5OThlA71P4amJhPe7za4BrjEQOdSawHX16avMzFw0U18SbyYiR69rFhGT1zdRB4LR
         gtSg==
X-Gm-Message-State: AOJu0YzRy/qf3HhRVixLSdDhJGX/Sq9tqMQ5IRaDwfK4t9E7HbRTpJ3i
	QzdXQjLxNRaIAx2Ne3rpsVIj9DLhPEMAmUQZCMN0H6HYBSSXcSRUcrLqeyaMuXKltQ==
X-Gm-Gg: ASbGncs+SlHdA4zUOW0MbDIhYocfNQ/fPEWPyBw0bEpTKPwQDlqbWiVApi8flDL5eXY
	71qhlbHhUIQbBrUrLDW+snVyNnOrjIN273UUAx8aehUcsbQDV0PKNoOGilpuMIS4edJEbJk9jQs
	gRkhCXaXGHHBRKjhO3kobyK7qevXmMiXP//2yE7oZDGcU3ze5iE17OcJCgcyPmSLifQSZe5bKUh
	WxBuJN9e4K0HTvvILu9HbJwFMqe1M1ptPkap3pQBvIP4ABwTMO0Owf6tSAEiS0urD8PFocagamX
	2wbcaJGBMICxkTsoL1TpGNzUB0pIjaV+dGwifMuiPQNntJjryiBbkKZNJOVHZ3KuXl60uzUj548
	a60WgMHHuDVbTeE19t2M=
X-Google-Smtp-Source: AGHT+IFcgckZIHb7EgaqKgDoLhpaDOmWYBrHtekFHUNMF3R+5I8Lmmus5FfGtN8IseJYr0qbpesiGQ==
X-Received: by 2002:a05:6a00:c83:b0:736:34a2:8a20 with SMTP id d2e1a72fcca58-7371f19f4e0mr853476b3a.21.1741892612098;
        Thu, 13 Mar 2025 12:03:32 -0700 (PDT)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9e2f45sm1652505a12.29.2025.03.13.12.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 12:03:31 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	kuba@kernel.org,
	edumazet@google.com,
	xiyou.wangcong@gmail.com,
	jhs@mojatatu.com,
	sinquersw@gmail.com,
	toke@redhat.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 13/13] selftests/bpf: Test attaching bpf qdisc to mq and non root
Date: Thu, 13 Mar 2025 12:03:07 -0700
Message-ID: <20250313190309.2545711-14-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250313190309.2545711-1-ameryhung@gmail.com>
References: <20250313190309.2545711-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Until we are certain that existing classful qdiscs work with bpf qdisc,
make sure we don't allow attaching a bpf qdisc to non root. Meanwhile,
attaching to mq is allowed.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 tools/testing/selftests/bpf/config            |  1 +
 .../selftests/bpf/prog_tests/bpf_qdisc.c      | 75 +++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 6b0cab55bd2d..3201a962b3dc 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -74,6 +74,7 @@ CONFIG_NET_MPLS_GSO=y
 CONFIG_NET_SCH_BPF=y
 CONFIG_NET_SCH_FQ=y
 CONFIG_NET_SCH_INGRESS=y
+CONFIG_NET_SCH_HTB=y
 CONFIG_NET_SCHED=y
 CONFIG_NETDEVSIM=y
 CONFIG_NETFILTER=y
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
index 7e8e3170e6b6..5d4fa5ad40e1 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
@@ -86,6 +86,77 @@ static void test_fq(void)
 	bpf_qdisc_fq__destroy(fq_skel);
 }
 
+static void test_qdisc_attach_to_mq(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_tc_hook, hook,
+			    .attach_point = BPF_TC_QDISC,
+			    .parent = TC_H_MAKE(1 << 16, 1),
+			    .handle = 0x11 << 16,
+			    .qdisc = "bpf_fifo");
+	struct bpf_qdisc_fifo *fifo_skel;
+	struct bpf_link *link;
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
+	SYS(out, "ip link add veth0 type veth peer veth1");
+	hook.ifindex = if_nametoindex("veth0");
+	SYS(out, "tc qdisc add dev veth0 root handle 1: mq");
+
+	err = bpf_tc_hook_create(&hook);
+	ASSERT_OK(err, "attach qdisc");
+
+	bpf_tc_hook_destroy(&hook);
+
+	SYS(out, "tc qdisc delete dev veth0 root mq");
+out:
+	bpf_link__destroy(link);
+	bpf_qdisc_fifo__destroy(fifo_skel);
+}
+
+static void test_qdisc_attach_to_non_root(void)
+{
+	DECLARE_LIBBPF_OPTS(bpf_tc_hook, hook, .ifindex = LO_IFINDEX,
+			    .attach_point = BPF_TC_QDISC,
+			    .parent = TC_H_MAKE(1 << 16, 1),
+			    .handle = 0x11 << 16,
+			    .qdisc = "bpf_fifo");
+	struct bpf_qdisc_fifo *fifo_skel;
+	struct bpf_link *link;
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
+	SYS(out, "tc qdisc add dev lo root handle 1: htb");
+	SYS(out_del_htb, "tc class add dev lo parent 1: classid 1:1 htb rate 75Kbit");
+
+	err = bpf_tc_hook_create(&hook);
+	if (!ASSERT_ERR(err, "attach qdisc"))
+		bpf_tc_hook_destroy(&hook);
+
+out_del_htb:
+	SYS(out, "tc qdisc delete dev lo root htb");
+out:
+	bpf_link__destroy(link);
+	bpf_qdisc_fifo__destroy(fifo_skel);
+}
+
 void test_bpf_qdisc(void)
 {
 	struct netns_obj *netns;
@@ -98,6 +169,10 @@ void test_bpf_qdisc(void)
 		test_fifo();
 	if (test__start_subtest("fq"))
 		test_fq();
+	if (test__start_subtest("attach to mq"))
+		test_qdisc_attach_to_mq();
+	if (test__start_subtest("attach to non root"))
+		test_qdisc_attach_to_non_root();
 
 	netns_free(netns);
 }
-- 
2.47.1



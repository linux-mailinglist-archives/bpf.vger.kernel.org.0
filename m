Return-Path: <bpf+bounces-6046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3457648D9
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 09:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE131C214C0
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 07:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B261C2F9;
	Thu, 27 Jul 2023 07:37:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9FBBE72
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 07:37:50 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52926A42
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 00:37:23 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-686f94328a4so119404b3a.0
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 00:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690443442; x=1691048242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r//0VfNIsSS7LjEKz2w3sxhtDAhJR7x5LJkBswgmGuQ=;
        b=bvNQcm1txH3rhOO7bm1O9db1gBgcBMCQs09BOjh+n6R3VBja2J59RqrtgNWO9awRAF
         EmhJsX7mQDb9SHJfhSrkICHn+WQAe+gtR3inPpRAzBY6qQm1agnybe8DuKumdO5jlFKe
         3YHkH7nP76dnwLFRRldyNlJof4ZD7ZNlpVEshWiVntSoFuZJgffmlqMqIhPq7i/8LGKD
         cnP86b8NCN8urnuP2ojgUdnkOLytJMwGVrSs3Rp5ZqjCx+OJDr2iX6bR9VytoWWz39b+
         J/IBNZIBta/QlN/Xir19mHZ05UZLuiWy9NoVByRL9UYOatX6ERlOMwp7Y8Ubo90+OnSE
         +4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690443442; x=1691048242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r//0VfNIsSS7LjEKz2w3sxhtDAhJR7x5LJkBswgmGuQ=;
        b=QQpAf5RcsZKOyFopD9cArgz5Gv68OcY3j/oj1dcBLDtfpIDF1+t4oF+LwKxMsDq2Y4
         gO7vagb9v6Pl23xS9Ski+SPLoz2xE/9UUDhO1sd/jATpdHPukmT3o1Is9Th3lZRl0Jgf
         7MH2MrMko+GKkYWu+sf6LKDXovkettvugUXRy39Wo2vLnV3xIK9D6YNwZqRn525fxq0o
         uJGqYo6Y+WCOTyVzuUMX6+26f7yuoZVOOmP/OKBU6ntOuaGp2rpGe8We83Jc1iTo/igx
         ylOwB3ShPfvwDN+HKfnVloLCfqUbzf/nH0m94XFr9k98QP1LykPHTfv1Uy9BLK98egyb
         Wn4A==
X-Gm-Message-State: ABy/qLagr5ksXyqR+H9GxymssEbhdb7+C6Xs30RKMQ/QNoSMHJ2tmIu1
	ecKitxQe9MmZ2KskM/GGc+eccA==
X-Google-Smtp-Source: APBJJlG4+R4jPSCVEGlR6rgLCmNVhaHd81UbthPsy8RJlP61GxssPJqO3tI7kRrjB9mH7WDD/QMfIA==
X-Received: by 2002:a05:6a21:329d:b0:13a:cfdf:d7a1 with SMTP id yt29-20020a056a21329d00b0013acfdfd7a1mr2311681pzb.2.1690443442119;
        Thu, 27 Jul 2023 00:37:22 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.134])
        by smtp.gmail.com with ESMTPSA id s196-20020a6377cd000000b005638a70110bsm733919pgc.65.2023.07.27.00.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 00:37:21 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wuyun.abel@bytedance.com,
	robin.lu@bytedance.com,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [RFC PATCH 3/5] libbpf, bpftool: Support BPF_PROG_TYPE_OOM_POLICY
Date: Thu, 27 Jul 2023 15:36:30 +0800
Message-Id: <20230727073632.44983-4-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230727073632.44983-1-zhouchuyi@bytedance.com>
References: <20230727073632.44983-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Support BPF_PROG_TYPE_OOM_POLICY program in libbpf and bpftool, so that
we can identify and use BPF_PROG_TYPE_OOM_POLICY in our application.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 tools/bpf/bpftool/common.c     |  1 +
 tools/include/uapi/linux/bpf.h | 14 ++++++++++++++
 tools/lib/bpf/libbpf.c         |  3 +++
 tools/lib/bpf/libbpf_probes.c  |  2 ++
 4 files changed, 20 insertions(+)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index cc6e6aae2447..c5c311299c4a 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -1089,6 +1089,7 @@ const char *bpf_attach_type_input_str(enum bpf_attach_type t)
 	case BPF_TRACE_FENTRY:			return "fentry";
 	case BPF_TRACE_FEXIT:			return "fexit";
 	case BPF_MODIFY_RETURN:			return "mod_ret";
+	case BPF_OOM_POLICY:			return "oom_policy";
 	case BPF_SK_REUSEPORT_SELECT:		return "sk_skb_reuseport_select";
 	case BPF_SK_REUSEPORT_SELECT_OR_MIGRATE:	return "sk_skb_reuseport_select_or_migrate";
 	default:	return libbpf_bpf_attach_type_str(t);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 60a9d59beeab..9da0d61cf703 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -987,6 +987,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_SK_LOOKUP,
 	BPF_PROG_TYPE_SYSCALL, /* a program that can execute syscalls */
 	BPF_PROG_TYPE_NETFILTER,
+	BPF_PROG_TYPE_OOM_POLICY,
 };
 
 enum bpf_attach_type {
@@ -1036,6 +1037,7 @@ enum bpf_attach_type {
 	BPF_LSM_CGROUP,
 	BPF_STRUCT_OPS,
 	BPF_NETFILTER,
+	BPF_OOM_POLICY,
 	__MAX_BPF_ATTACH_TYPE
 };
 
@@ -6825,6 +6827,18 @@ struct bpf_cgroup_dev_ctx {
 	__u32 minor;
 };
 
+enum {
+	BPF_OOM_CMP_EQUAL   = (1ULL << 0),
+	BPF_OOM_CMP_GREATER = (1ULL << 1),
+	BPF_OOM_CMP_LESS    = (1ULL << 2),
+};
+
+struct bpf_oom_ctx {
+	__u64 cg_id_1;
+	__u64 cg_id_2;
+	__u8  cmp_ret;
+};
+
 struct bpf_raw_tracepoint_args {
 	__u64 args[0];
 };
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 214f828ece6b..10496bb9b3bc 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -118,6 +118,7 @@ static const char * const attach_type_name[] = {
 	[BPF_TRACE_KPROBE_MULTI]	= "trace_kprobe_multi",
 	[BPF_STRUCT_OPS]		= "struct_ops",
 	[BPF_NETFILTER]			= "netfilter",
+	[BPF_OOM_POLICY]		= "oom_policy",
 };
 
 static const char * const link_type_name[] = {
@@ -204,6 +205,7 @@ static const char * const prog_type_name[] = {
 	[BPF_PROG_TYPE_SK_LOOKUP]		= "sk_lookup",
 	[BPF_PROG_TYPE_SYSCALL]			= "syscall",
 	[BPF_PROG_TYPE_NETFILTER]		= "netfilter",
+	[BPF_PROG_TYPE_OOM_POLICY]		= "oom_policy",
 };
 
 static int __base_pr(enum libbpf_print_level level, const char *format,
@@ -8738,6 +8740,7 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("struct_ops.s+",	STRUCT_OPS, 0, SEC_SLEEPABLE),
 	SEC_DEF("sk_lookup",		SK_LOOKUP, BPF_SK_LOOKUP, SEC_ATTACHABLE),
 	SEC_DEF("netfilter",		NETFILTER, BPF_NETFILTER, SEC_NONE),
+	SEC_DEF("oom_policy",       OOM_POLICY, BPF_OOM_POLICY, SEC_ATTACHABLE_OPT),
 };
 
 static size_t custom_sec_def_cnt;
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 9c4db90b92b6..dbac3e98a2d7 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -129,6 +129,8 @@ static int probe_prog_load(enum bpf_prog_type prog_type,
 	case BPF_PROG_TYPE_LIRC_MODE2:
 		opts.expected_attach_type = BPF_LIRC_MODE2;
 		break;
+	case BPF_PROG_TYPE_OOM_POLICY:
+		opts.expected_attach_type = BPF_OOM_POLICY;
 	case BPF_PROG_TYPE_TRACING:
 	case BPF_PROG_TYPE_LSM:
 		opts.log_buf = buf;
-- 
2.20.1



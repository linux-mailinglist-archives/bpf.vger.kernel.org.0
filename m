Return-Path: <bpf+bounces-4519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C4974C080
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 04:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC5ED1C20917
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 02:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFBF23CB;
	Sun,  9 Jul 2023 02:56:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EC423BC
	for <bpf@vger.kernel.org>; Sun,  9 Jul 2023 02:56:57 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F248CE45;
	Sat,  8 Jul 2023 19:56:55 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-666e6541c98so2834932b3a.2;
        Sat, 08 Jul 2023 19:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688871415; x=1691463415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJbjCQYxRAs+VPYdeuTTJaYGlsJ3tGDUZYUQNUVCwBU=;
        b=LZtTf5b+AwjTEQl6wlR+Z3LehWGk9cUy2xxrRxC3JTEllxaiodRjflzwQF4992izzH
         U+nt8wnu+xTYR4IddBRfhXzCiFAA9yInPM2mL910EL/TkS49RKPRtE23QTLNOnyO9v+n
         A+bb5Z8QG4/T3c0ngJvEhJScuEyZrgAw36xS8lJdMwTJtl9kh5+Tmdh/6aipjmtCOaKs
         U/jrkDOwobJMbmg29lzWtAnzhDv8eGV9PWard7q4LaWUrUGc4csLZSS0gSgJwlh7yTm2
         1uTG+FX2feUOwymcPhrkKId9cb1SDP1jXGNumRDw142iyGd8TWTywXB6DCtndVKi6/yT
         dEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688871415; x=1691463415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJbjCQYxRAs+VPYdeuTTJaYGlsJ3tGDUZYUQNUVCwBU=;
        b=JOar8AYgSavqUUpmRy841O/pTlrmAdrV4m8mH+woFRd72xmhsUhaoVu6YZQrfz2WC5
         /HSS5GiGixJmTxLZRggVqQWGD/A356fdkwM+3C1sgpoOqD8ymfrcxt6xUFJAW3QGRMTE
         O/uwn1O/aDALVmj6JfaJpdR+8MEkr0+ZC1REe2ul/V3AfEjHfWTQ4Oz8/5e6bujR9HmS
         t7ilpIeNlix1jL5RjMr3LFa8jjTg+SSJZHjxeu64eNV4FdZ2aSHPlIXOErUynTg5/XNJ
         CBwHsMrECFRM1giftSsmQMvE0SlHe2a9ws58yDb25bI/KphsGo0+fsGS2iW8IohkL7b/
         driA==
X-Gm-Message-State: ABy/qLYy9U4Rc5P9/LyaCju7eKvMdr2uCMJaNlK997XtePBHd1JE27KF
	n/JgwYe7ByX3HFLzJwjiwNE=
X-Google-Smtp-Source: APBJJlFntdymA3SvvMTmMX8IL3DGD0P6FacjBurTcox4KVtuZegyt10ArYnyWsuQgh8tr5g2C65/7A==
X-Received: by 2002:a05:6a00:3920:b0:682:4edf:b9c7 with SMTP id fh32-20020a056a00392000b006824edfb9c7mr12069333pfb.2.1688871415345;
        Sat, 08 Jul 2023 19:56:55 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:14bb:5400:4ff:fe80:41df])
        by smtp.gmail.com with ESMTPSA id e9-20020aa78249000000b00682ad247e5fsm5043421pfn.179.2023.07.08.19.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 19:56:54 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	quentin@isovalent.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v7 bpf-next 08/10] bpf: Support ->fill_link_info for perf_event
Date: Sun,  9 Jul 2023 02:56:28 +0000
Message-Id: <20230709025630.3735-9-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230709025630.3735-1-laoar.shao@gmail.com>
References: <20230709025630.3735-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

By introducing support for ->fill_link_info to the perf_event link, users
gain the ability to inspect it using `bpftool link show`. While the current
approach involves accessing this information via `bpftool perf show`,
consolidating link information for all link types in one place offers
greater convenience. Additionally, this patch extends support to the
generic perf event, which is not currently accommodated by
`bpftool perf show`. While only the perf type and config are exposed to
userspace, other attributes such as sample_period and sample_freq are
ignored. It's important to note that if kptr_restrict is not permitted, the
probed address will not be exposed, maintaining security measures.

A new enum bpf_perf_event_type is introduced to help the user understand
which struct is relevant.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 include/uapi/linux/bpf.h       |  35 ++++++++
 kernel/bpf/syscall.c           | 146 +++++++++++++++++++++++++++++++++
 kernel/trace/bpf_trace.c       |  10 ++-
 tools/include/uapi/linux/bpf.h |  35 ++++++++
 4 files changed, 223 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index a4e881c64e0f..600d0caebbd8 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1057,6 +1057,16 @@ enum bpf_link_type {
 	MAX_BPF_LINK_TYPE,
 };
 
+enum bpf_perf_event_type {
+	BPF_PERF_EVENT_UNSPEC = 0,
+	BPF_PERF_EVENT_UPROBE = 1,
+	BPF_PERF_EVENT_URETPROBE = 2,
+	BPF_PERF_EVENT_KPROBE = 3,
+	BPF_PERF_EVENT_KRETPROBE = 4,
+	BPF_PERF_EVENT_TRACEPOINT = 5,
+	BPF_PERF_EVENT_EVENT = 6,
+};
+
 /* cgroup-bpf attach flags used in BPF_PROG_ATTACH command
  *
  * NONE(default): No further bpf programs allowed in the subtree.
@@ -6444,6 +6454,31 @@ struct bpf_link_info {
 			__u32 count; /* in/out: kprobe_multi function count */
 			__u32 flags;
 		} kprobe_multi;
+		struct {
+			__u32 type; /* enum bpf_perf_event_type */
+			__u32 :32;
+			union {
+				struct {
+					__aligned_u64 file_name; /* in/out */
+					__u32 name_len;
+					__u32 offset; /* offset from file_name */
+				} uprobe; /* BPF_PERF_EVENT_UPROBE, BPF_PERF_EVENT_URETPROBE */
+				struct {
+					__aligned_u64 func_name; /* in/out */
+					__u32 name_len;
+					__u32 offset; /* offset from func_name */
+					__u64 addr;
+				} kprobe; /* BPF_PERF_EVENT_KPROBE, BPF_PERF_EVENT_KRETPROBE */
+				struct {
+					__aligned_u64 tp_name;   /* in/out */
+					__u32 name_len;
+				} tracepoint; /* BPF_PERF_EVENT_TRACEPOINT */
+				struct {
+					__u64 config;
+					__u32 type;
+				} event; /* BPF_PERF_EVENT_EVENT */
+			};
+		} perf_event;
 	};
 } __attribute__((aligned(8)));
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 4aa6e5776a04..ee8cb1a174aa 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3364,9 +3364,155 @@ static void bpf_perf_link_dealloc(struct bpf_link *link)
 	kfree(perf_link);
 }
 
+static int bpf_perf_link_fill_common(const struct perf_event *event,
+				     char __user *uname, u32 ulen,
+				     u64 *probe_offset, u64 *probe_addr,
+				     u32 *fd_type)
+{
+	const char *buf;
+	u32 prog_id;
+	size_t len;
+	int err;
+
+	if (!ulen ^ !uname)
+		return -EINVAL;
+	if (!uname)
+		return 0;
+
+	err = bpf_get_perf_event_info(event, &prog_id, fd_type, &buf,
+				      probe_offset, probe_addr);
+	if (err)
+		return err;
+
+	if (buf) {
+		len = strlen(buf);
+		err = bpf_copy_to_user(uname, buf, ulen, len);
+		if (err)
+			return err;
+	} else {
+		char zero = '\0';
+
+		if (put_user(zero, uname))
+			return -EFAULT;
+	}
+	return 0;
+}
+
+#ifdef CONFIG_KPROBE_EVENTS
+static int bpf_perf_link_fill_kprobe(const struct perf_event *event,
+				     struct bpf_link_info *info)
+{
+	char __user *uname;
+	u64 addr, offset;
+	u32 ulen, type;
+	int err;
+
+	uname = u64_to_user_ptr(info->perf_event.kprobe.func_name);
+	ulen = info->perf_event.kprobe.name_len;
+	err = bpf_perf_link_fill_common(event, uname, ulen, &offset, &addr,
+					&type);
+	if (err)
+		return err;
+	if (type == BPF_FD_TYPE_KRETPROBE)
+		info->perf_event.type = BPF_PERF_EVENT_KRETPROBE;
+	else
+		info->perf_event.type = BPF_PERF_EVENT_KPROBE;
+
+	info->perf_event.kprobe.offset = offset;
+	if (!kallsyms_show_value(current_cred()))
+		addr = 0;
+	info->perf_event.kprobe.addr = addr;
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_UPROBE_EVENTS
+static int bpf_perf_link_fill_uprobe(const struct perf_event *event,
+				     struct bpf_link_info *info)
+{
+	char __user *uname;
+	u64 addr, offset;
+	u32 ulen, type;
+	int err;
+
+	uname = u64_to_user_ptr(info->perf_event.uprobe.file_name);
+	ulen = info->perf_event.uprobe.name_len;
+	err = bpf_perf_link_fill_common(event, uname, ulen, &offset, &addr,
+					&type);
+	if (err)
+		return err;
+
+	if (type == BPF_FD_TYPE_URETPROBE)
+		info->perf_event.type = BPF_PERF_EVENT_URETPROBE;
+	else
+		info->perf_event.type = BPF_PERF_EVENT_UPROBE;
+	info->perf_event.uprobe.offset = offset;
+	return 0;
+}
+#endif
+
+static int bpf_perf_link_fill_probe(const struct perf_event *event,
+				    struct bpf_link_info *info)
+{
+#ifdef CONFIG_KPROBE_EVENTS
+	if (event->tp_event->flags & TRACE_EVENT_FL_KPROBE)
+		return bpf_perf_link_fill_kprobe(event, info);
+#endif
+#ifdef CONFIG_UPROBE_EVENTS
+	if (event->tp_event->flags & TRACE_EVENT_FL_UPROBE)
+		return bpf_perf_link_fill_uprobe(event, info);
+#endif
+	return -EOPNOTSUPP;
+}
+
+static int bpf_perf_link_fill_tracepoint(const struct perf_event *event,
+					 struct bpf_link_info *info)
+{
+	char __user *uname;
+	u32 ulen;
+
+	uname = u64_to_user_ptr(info->perf_event.tracepoint.tp_name);
+	ulen = info->perf_event.tracepoint.name_len;
+	info->perf_event.type = BPF_PERF_EVENT_TRACEPOINT;
+	return bpf_perf_link_fill_common(event, uname, ulen, NULL, NULL, NULL);
+}
+
+static int bpf_perf_link_fill_perf_event(const struct perf_event *event,
+					 struct bpf_link_info *info)
+{
+	info->perf_event.event.type = event->attr.type;
+	info->perf_event.event.config = event->attr.config;
+	info->perf_event.type = BPF_PERF_EVENT_EVENT;
+	return 0;
+}
+
+static int bpf_perf_link_fill_link_info(const struct bpf_link *link,
+					struct bpf_link_info *info)
+{
+	struct bpf_perf_link *perf_link;
+	const struct perf_event *event;
+
+	perf_link = container_of(link, struct bpf_perf_link, link);
+	event = perf_get_event(perf_link->perf_file);
+	if (IS_ERR(event))
+		return PTR_ERR(event);
+
+	switch (event->prog->type) {
+	case BPF_PROG_TYPE_PERF_EVENT:
+		return bpf_perf_link_fill_perf_event(event, info);
+	case BPF_PROG_TYPE_TRACEPOINT:
+		return bpf_perf_link_fill_tracepoint(event, info);
+	case BPF_PROG_TYPE_KPROBE:
+		return bpf_perf_link_fill_probe(event, info);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static const struct bpf_link_ops bpf_perf_link_lops = {
 	.release = bpf_perf_link_release,
 	.dealloc = bpf_perf_link_dealloc,
+	.fill_link_info = bpf_perf_link_fill_link_info,
 };
 
 static int bpf_perf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 31ec0e2853ec..897edfc9ca12 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2369,9 +2369,13 @@ int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
 	if (is_tracepoint || is_syscall_tp) {
 		*buf = is_tracepoint ? event->tp_event->tp->name
 				     : event->tp_event->name;
-		*fd_type = BPF_FD_TYPE_TRACEPOINT;
-		*probe_offset = 0x0;
-		*probe_addr = 0x0;
+		/* We allow NULL pointer for tracepoint */
+		if (fd_type)
+			*fd_type = BPF_FD_TYPE_TRACEPOINT;
+		if (probe_offset)
+			*probe_offset = 0x0;
+		if (probe_addr)
+			*probe_addr = 0x0;
 	} else {
 		/* kprobe/uprobe */
 		err = -EOPNOTSUPP;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index a4e881c64e0f..600d0caebbd8 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1057,6 +1057,16 @@ enum bpf_link_type {
 	MAX_BPF_LINK_TYPE,
 };
 
+enum bpf_perf_event_type {
+	BPF_PERF_EVENT_UNSPEC = 0,
+	BPF_PERF_EVENT_UPROBE = 1,
+	BPF_PERF_EVENT_URETPROBE = 2,
+	BPF_PERF_EVENT_KPROBE = 3,
+	BPF_PERF_EVENT_KRETPROBE = 4,
+	BPF_PERF_EVENT_TRACEPOINT = 5,
+	BPF_PERF_EVENT_EVENT = 6,
+};
+
 /* cgroup-bpf attach flags used in BPF_PROG_ATTACH command
  *
  * NONE(default): No further bpf programs allowed in the subtree.
@@ -6444,6 +6454,31 @@ struct bpf_link_info {
 			__u32 count; /* in/out: kprobe_multi function count */
 			__u32 flags;
 		} kprobe_multi;
+		struct {
+			__u32 type; /* enum bpf_perf_event_type */
+			__u32 :32;
+			union {
+				struct {
+					__aligned_u64 file_name; /* in/out */
+					__u32 name_len;
+					__u32 offset; /* offset from file_name */
+				} uprobe; /* BPF_PERF_EVENT_UPROBE, BPF_PERF_EVENT_URETPROBE */
+				struct {
+					__aligned_u64 func_name; /* in/out */
+					__u32 name_len;
+					__u32 offset; /* offset from func_name */
+					__u64 addr;
+				} kprobe; /* BPF_PERF_EVENT_KPROBE, BPF_PERF_EVENT_KRETPROBE */
+				struct {
+					__aligned_u64 tp_name;   /* in/out */
+					__u32 name_len;
+				} tracepoint; /* BPF_PERF_EVENT_TRACEPOINT */
+				struct {
+					__u64 config;
+					__u32 type;
+				} event; /* BPF_PERF_EVENT_EVENT */
+			};
+		} perf_event;
 	};
 } __attribute__((aligned(8)));
 
-- 
2.30.1 (Apple Git-130)



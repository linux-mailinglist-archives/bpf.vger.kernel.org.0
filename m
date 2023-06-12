Return-Path: <bpf+bounces-2413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE23272C9A2
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 17:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 201E01C20B1B
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 15:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C67A1DDE8;
	Mon, 12 Jun 2023 15:16:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2B319511
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 15:16:30 +0000 (UTC)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA40170A;
	Mon, 12 Jun 2023 08:16:25 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-62de1a3e354so11409986d6.3;
        Mon, 12 Jun 2023 08:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686582984; x=1689174984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvHWDyuzXCb0xSQICwGSRrHmdLNiWivuKicwgtJGuF0=;
        b=acZmy/AZzVjotiDaxrFHHOi65rdBA+c7GziUNy6NKa4uMD/HHbv0tiX0536cjLym6E
         7BTPUDAiPHyfz/cEYYFWoB9TQ9f4YjgEEMfN8UuFwJ2le4pwdy29Z5T8ljTiq9yy0Y2J
         h+6m4MbJREap02cESVzHPZVGK/T8itdYlt69zTxXBz2QnCMZTWoQxylHYCpLmHFTQgIJ
         uG28L7Cn6dgXrG2VXdbT1sr4j8Q0Z00wJl5QhZiWup6Elx1oesG0zWP3qAQSY1N5WRcA
         vsfrgNLTVNwLsbTPdOeBbIoRhe6Q1T+edcFoyUv3MKiqfvdEeP/3aC1xxV4Ar0wp0xWz
         mx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686582984; x=1689174984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GvHWDyuzXCb0xSQICwGSRrHmdLNiWivuKicwgtJGuF0=;
        b=WqrL9XawBQrIKG6D7Vj590wiMIWVDmNlUgHMSUheOF3f3cXE9GL2UY0ksCJAmDCQyO
         R8ygElFaQuwIMFV3Sxt4Fjz2BNh4Yj77JkJyE/QHacJbntTSkxBPPwB8EH2cNIKN6VI+
         HatjNIjQ/ooVZDQY63Q/265RaAQVq5wEqSjmehSjU9sEhxL7eokTYB2GOo1fP0H5+5Xo
         mmfQZ3YSdEeqCI0/wQIxEV96I44JQCc8ajN82yvXpzO6+q96tVGoAX8HWovu0tlc78z/
         7SHPTtpVVyyuBRUe4hn+5Lz2gR2Mg4NUAnIIGtb7uoKaQ+LlCUU+xAxNA8LVHksxlqqX
         wSQQ==
X-Gm-Message-State: AC+VfDwfb1CXbZhHgRKmv7kDNyO3RlqLg2spexS9Ef2AWa0m5lMUt3Eu
	HzuDmMWJiDHObQ9qwDlCgcY=
X-Google-Smtp-Source: ACHHUZ7ngTKYVJl8Ne8oAgxRsj3uYgqLzEw4vaff4vDYxVXleMJOfFNXgxuZfE2vjGsMqZSC9ROzuA==
X-Received: by 2002:a05:6214:27e1:b0:62d:d809:1f7 with SMTP id jt1-20020a05621427e100b0062dd80901f7mr6812274qvb.21.1686582984597;
        Mon, 12 Jun 2023 08:16:24 -0700 (PDT)
Received: from vultr.guest ([108.61.23.146])
        by smtp.gmail.com with ESMTPSA id o17-20020a0cf4d1000000b0062de0dde008sm1533953qvm.64.2023.06.12.08.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 08:16:23 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 08/10] bpf: Support ->fill_link_info for perf_event
Date: Mon, 12 Jun 2023 15:16:06 +0000
Message-Id: <20230612151608.99661-9-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230612151608.99661-1-laoar.shao@gmail.com>
References: <20230612151608.99661-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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

A new enum bpf_link_perf_event_type is introduced to help the user
understand which struct is relevant.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/uapi/linux/bpf.h       |  32 +++++++++++
 kernel/bpf/syscall.c           | 124 +++++++++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  32 +++++++++++
 3 files changed, 188 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 23691ea..8d4556e 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1056,6 +1056,16 @@ enum bpf_link_type {
 	MAX_BPF_LINK_TYPE,
 };
 
+enum bpf_perf_link_type {
+	BPF_PERF_LINK_UNSPEC = 0,
+	BPF_PERF_LINK_UPROBE = 1,
+	BPF_PERF_LINK_KPROBE = 2,
+	BPF_PERF_LINK_TRACEPOINT = 3,
+	BPF_PERF_LINK_PERF_EVENT = 4,
+
+	MAX_BPF_LINK_PERF_EVENT_TYPE,
+};
+
 /* cgroup-bpf attach flags used in BPF_PROG_ATTACH command
  *
  * NONE(default): No further bpf programs allowed in the subtree.
@@ -6443,7 +6453,29 @@ struct bpf_link_info {
 			__u32 count;
 			__u32 flags;
 		} kprobe_multi;
+		struct {
+			__u64 config;
+			__u32 type;
+		} perf_event; /* BPF_LINK_PERF_EVENT_PERF_EVENT */
+		struct {
+			__aligned_u64 file_name; /* in/out: buff ptr */
+			__u32 name_len;
+			__u32 offset;            /* offset from name */
+			__u32 flags;
+		} uprobe; /* BPF_LINK_PERF_EVENT_UPROBE */
+		struct {
+			__aligned_u64 func_name; /* in/out: buff ptr */
+			__u32 name_len;
+			__u32 offset;            /* offset from name */
+			__u64 addr;
+			__u32 flags;
+		} kprobe; /* BPF_LINK_PERF_EVENT_KPROBE */
+		struct {
+			__aligned_u64 tp_name;   /* in/out: buff ptr */
+			__u32 name_len;
+		} tracepoint; /* BPF_LINK_PERF_EVENT_TRACEPOINT */
 	};
+	__u32 perf_link_type; /* enum bpf_perf_link_type */
 } __attribute__((aligned(8)));
 
 /* User bpf_sock_addr struct to access socket fields and sockaddr struct passed
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 80c9ec0..fe354d5 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3303,9 +3303,133 @@ static void bpf_perf_link_dealloc(struct bpf_link *link)
 	kfree(perf_link);
 }
 
+static int bpf_perf_link_fill_name(const struct perf_event *event,
+				   char __user *uname, u32 ulen,
+				   u64 *probe_offset, u64 *probe_addr,
+				   u32 *fd_type)
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
+	len = strlen(buf);
+	if (buf) {
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
+static int bpf_perf_link_fill_probe(const struct perf_event *event,
+				    struct bpf_link_info *info)
+{
+	char __user *uname;
+	u64 addr, offset;
+	u32 ulen, type;
+	int err;
+
+#ifdef CONFIG_KPROBE_EVENTS
+	if (event->tp_event->flags & TRACE_EVENT_FL_KPROBE) {
+		uname = u64_to_user_ptr(info->kprobe.func_name);
+		ulen = info->kprobe.name_len;
+		info->perf_link_type = BPF_PERF_LINK_KPROBE;
+		err = bpf_perf_link_fill_name(event, uname, ulen, &offset,
+					      &addr, &type);
+		if (err)
+			return err;
+
+		info->kprobe.offset = offset;
+		if (type == BPF_FD_TYPE_KRETPROBE)
+			info->kprobe.flags = 1;
+		if (!kallsyms_show_value(current_cred()))
+			return 0;
+		info->kprobe.addr = addr;
+		return 0;
+	}
+#endif
+
+#ifdef CONFIG_UPROBE_EVENTS
+	if (event->tp_event->flags & TRACE_EVENT_FL_UPROBE) {
+		uname = u64_to_user_ptr(info->uprobe.file_name);
+		ulen = info->uprobe.name_len;
+		info->perf_link_type = BPF_PERF_LINK_UPROBE;
+		err = bpf_perf_link_fill_name(event, uname, ulen, &offset,
+					      &addr, &type);
+		if (err)
+			return err;
+
+		info->uprobe.offset = offset;
+		if (type == BPF_FD_TYPE_URETPROBE)
+			info->uprobe.flags = 1;
+		return 0;
+	}
+#endif
+
+	return -EOPNOTSUPP;
+}
+
+static int bpf_perf_link_fill_tracepoint(const struct perf_event *event,
+					 struct bpf_link_info *info)
+{
+	char __user *uname = u64_to_user_ptr(info->tracepoint.tp_name);
+	u32 ulen = info->tracepoint.name_len;
+	u64 addr, off;
+	u32 type;
+
+	info->perf_link_type = BPF_PERF_LINK_TRACEPOINT;
+	return bpf_perf_link_fill_name(event, uname, ulen, &off, &addr, &type);
+}
+
+static int bpf_perf_link_fill_perf_event(const struct perf_event *event,
+				    struct bpf_link_info *info)
+{
+	info->perf_event.type = event->attr.type;
+	info->perf_event.config = event->attr.config;
+	info->perf_link_type = BPF_PERF_LINK_PERF_EVENT;
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
+	if (!event->prog)
+		return -EINVAL;
+	if (event->prog->type == BPF_PROG_TYPE_PERF_EVENT)
+		return bpf_perf_link_fill_perf_event(event, info);
+	if (event->prog->type == BPF_PROG_TYPE_TRACEPOINT)
+		return bpf_perf_link_fill_tracepoint(event, info);
+	return bpf_perf_link_fill_probe(event, info);
+}
+
 static const struct bpf_link_ops bpf_perf_link_lops = {
 	.release = bpf_perf_link_release,
 	.dealloc = bpf_perf_link_dealloc,
+	.fill_link_info = bpf_perf_link_fill_link_info,
 };
 
 static int bpf_perf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 23691ea..8d4556e 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1056,6 +1056,16 @@ enum bpf_link_type {
 	MAX_BPF_LINK_TYPE,
 };
 
+enum bpf_perf_link_type {
+	BPF_PERF_LINK_UNSPEC = 0,
+	BPF_PERF_LINK_UPROBE = 1,
+	BPF_PERF_LINK_KPROBE = 2,
+	BPF_PERF_LINK_TRACEPOINT = 3,
+	BPF_PERF_LINK_PERF_EVENT = 4,
+
+	MAX_BPF_LINK_PERF_EVENT_TYPE,
+};
+
 /* cgroup-bpf attach flags used in BPF_PROG_ATTACH command
  *
  * NONE(default): No further bpf programs allowed in the subtree.
@@ -6443,7 +6453,29 @@ struct bpf_link_info {
 			__u32 count;
 			__u32 flags;
 		} kprobe_multi;
+		struct {
+			__u64 config;
+			__u32 type;
+		} perf_event; /* BPF_LINK_PERF_EVENT_PERF_EVENT */
+		struct {
+			__aligned_u64 file_name; /* in/out: buff ptr */
+			__u32 name_len;
+			__u32 offset;            /* offset from name */
+			__u32 flags;
+		} uprobe; /* BPF_LINK_PERF_EVENT_UPROBE */
+		struct {
+			__aligned_u64 func_name; /* in/out: buff ptr */
+			__u32 name_len;
+			__u32 offset;            /* offset from name */
+			__u64 addr;
+			__u32 flags;
+		} kprobe; /* BPF_LINK_PERF_EVENT_KPROBE */
+		struct {
+			__aligned_u64 tp_name;   /* in/out: buff ptr */
+			__u32 name_len;
+		} tracepoint; /* BPF_LINK_PERF_EVENT_TRACEPOINT */
 	};
+	__u32 perf_link_type; /* enum bpf_perf_link_type */
 } __attribute__((aligned(8)));
 
 /* User bpf_sock_addr struct to access socket fields and sockaddr struct passed
-- 
1.8.3.1



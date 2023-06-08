Return-Path: <bpf+bounces-2109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D91727CF2
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 12:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEA161C20FE6
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 10:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCD4D2FA;
	Thu,  8 Jun 2023 10:35:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB22C8FD
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 10:35:46 +0000 (UTC)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0882103
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 03:35:43 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-62b671e0a0dso3978866d6.1
        for <bpf@vger.kernel.org>; Thu, 08 Jun 2023 03:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686220543; x=1688812543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6mSN8B6rsVi3+V/BwBxx2tAFIVmO4m7KApI1B2488Y=;
        b=Uv8iwfGoBk1QqMFIGFV4fZtuWB+MbOtXzsvW3Rr3VmEaDqNjgTW9uJt0uu4jLL2GJO
         x23Wl7RMSFZgAjziwgLiJa/WkBdSnipDuZucT8a9Aiov+46u50/+Pilx7popSbt3ZLbm
         QyZZb9/GBF6JODHxnU+lUyO5rM3+IiTHJNdyU+aue59IU9ftiV9qG2klu8GJAUZgieID
         cSMMDZpn8w3l7NGqV+RuGiqUUtTuNI+wN//1AAgnOYC/YMxU+MgOjpqeeVLWvm7NItiP
         t46maIGX8Q9BrE9MATNyE5FSHIg483rKNpSXxK1GYvDFy2qF7BEayXltzd8fosVpTBjs
         exHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686220543; x=1688812543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N6mSN8B6rsVi3+V/BwBxx2tAFIVmO4m7KApI1B2488Y=;
        b=fknGktU05SqYYsAuDg0XF6RQLwVT7JXQARbuatUcAR45nWy6jEMKJYxWyr8aUnBJ8b
         1NXdJcxWfAp4CKlIcMxIkkqsXqopLoQgDk0xi6aijT8x/Kq6J7zA/hVNZmRTQPh+H+Y7
         GS2SxG+caldASJhqhTDFgu5+3IyJCd3SDBYwL6ZiB3eC8iMqe6MOGyhTTRAx1IDR4cyy
         C+EgenEslPif1A3HvQYxGL4Qvzd4k5b2ihieWQA1ydRsuz2TgHJD9/MC0C2b1FIhyFA2
         KUiuxW/zl0WvRYUZ+7vK3WpbC7r2c7tBmEzW5iFb89QVAg3MEJj3GcHZbnUPZ5zIgKPv
         LjZg==
X-Gm-Message-State: AC+VfDwKgmzArMpczhuHEQ14diE8o8lSOabPL8M+CW+CYvqo4aAzXuc2
	Bim6xR4WspuN1ChHyvhKjig=
X-Google-Smtp-Source: ACHHUZ7gn7CBkRWcMSIJsIOvGE8yzT1u0xjBmK7w8q8wbGAoye5PUAosZv3TeNwiGUx98YrUKtq/+w==
X-Received: by 2002:ad4:5964:0:b0:616:5460:aafd with SMTP id eq4-20020ad45964000000b006165460aafdmr1163428qvb.3.1686220542910;
        Thu, 08 Jun 2023 03:35:42 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:1000:2418:5400:4ff:fe77:b548])
        by smtp.gmail.com with ESMTPSA id p16-20020a0cf550000000b0062839fc6e36sm302714qvm.70.2023.06.08.03.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 03:35:42 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	quentin@isovalent.com
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 bpf-next 08/11] bpf: Support ->fill_link_info for perf_event
Date: Thu,  8 Jun 2023 10:35:20 +0000
Message-Id: <20230608103523.102267-9-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230608103523.102267-1-laoar.shao@gmail.com>
References: <20230608103523.102267-1-laoar.shao@gmail.com>
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
ignored. It's important to note that if kptr_restrict is set to 2, the
probed address will not be exposed, maintaining security measures.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/uapi/linux/bpf.h       | 22 ++++++++++
 kernel/bpf/syscall.c           | 98 ++++++++++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h | 22 ++++++++++
 3 files changed, 142 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index d99cc16..c3b821d 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6443,6 +6443,28 @@ struct bpf_link_info {
 			__u32 count;
 			__u8  retprobe;
 		} kprobe_multi;
+		union {
+			struct {
+				/* The name is:
+				 * a) uprobe: file name
+				 * b) kprobe: kernel function
+				 */
+				__aligned_u64 name; /* in/out: name buffer ptr */
+				__u32 name_len;
+				__u32 offset;	/* offset from the name */
+				__u64 addr;
+				__u8 retprobe;
+			} probe; /* uprobe, kprobe */
+			struct {
+				/* in/out: tracepoint name buffer ptr */
+				__aligned_u64 tp_name;
+				__u32 name_len;
+			} tp; /* tracepoint */
+			struct {
+				__u64 config;
+				__u32 type;
+			} event; /* generic perf event */
+		} perf_event;
 	};
 } __attribute__((aligned(8)));
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 80c9ec0..e349bdb 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3303,9 +3303,107 @@ static void bpf_perf_link_dealloc(struct bpf_link *link)
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
+	char __user *uname = u64_to_user_ptr(info->perf_event.probe.name);
+	u32 ulen = info->perf_event.probe.name_len;
+	u64 addr, off;
+	u32 type;
+	int err;
+
+	err = bpf_perf_link_fill_name(event, uname, ulen, &off, &addr, &type);
+	if (err)
+		return err;
+	info->perf_event.probe.offset = off;
+	if (type == BPF_FD_TYPE_KRETPROBE || type == BPF_FD_TYPE_URETPROBE)
+		info->perf_event.probe.retprobe = 1;
+	else
+		info->perf_event.probe.retprobe = 0;
+
+	if (kptr_restrict == 2)
+		return 0;
+	info->perf_event.probe.addr = addr;
+	return 0;
+}
+
+static int bpf_perf_link_fill_tp(const struct perf_event *event,
+				 struct bpf_link_info *info)
+{
+	char __user *uname = u64_to_user_ptr(info->perf_event.tp.tp_name);
+	u32 ulen = info->perf_event.tp.name_len;
+	u64 addr, off;
+	u32 type;
+
+	return bpf_perf_link_fill_name(event, uname, ulen, &off, &addr, &type);
+}
+
+static int bpf_perf_link_fill_event(const struct perf_event *event,
+				    struct bpf_link_info *info)
+{
+	info->perf_event.event.type = event->attr.type;
+	info->perf_event.event.config = event->attr.config;
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
+		return bpf_perf_link_fill_event(event, info);
+	if (event->prog->type == BPF_PROG_TYPE_TRACEPOINT)
+		return bpf_perf_link_fill_tp(event, info);
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
index d99cc16..c3b821d 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6443,6 +6443,28 @@ struct bpf_link_info {
 			__u32 count;
 			__u8  retprobe;
 		} kprobe_multi;
+		union {
+			struct {
+				/* The name is:
+				 * a) uprobe: file name
+				 * b) kprobe: kernel function
+				 */
+				__aligned_u64 name; /* in/out: name buffer ptr */
+				__u32 name_len;
+				__u32 offset;	/* offset from the name */
+				__u64 addr;
+				__u8 retprobe;
+			} probe; /* uprobe, kprobe */
+			struct {
+				/* in/out: tracepoint name buffer ptr */
+				__aligned_u64 tp_name;
+				__u32 name_len;
+			} tp; /* tracepoint */
+			struct {
+				__u64 config;
+				__u32 type;
+			} event; /* generic perf event */
+		} perf_event;
 	};
 } __attribute__((aligned(8)));
 
-- 
1.8.3.1



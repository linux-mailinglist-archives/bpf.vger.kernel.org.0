Return-Path: <bpf+bounces-1663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CE071FCBE
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 10:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23E661C20B91
	for <lists+bpf@lfdr.de>; Fri,  2 Jun 2023 08:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2192174E3;
	Fri,  2 Jun 2023 08:52:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CA346AA
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 08:52:54 +0000 (UTC)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DE5170C
	for <bpf@vger.kernel.org>; Fri,  2 Jun 2023 01:52:52 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-ba8a0500f4aso1905515276.3
        for <bpf@vger.kernel.org>; Fri, 02 Jun 2023 01:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685695972; x=1688287972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CoWktiecpuhKACCKJUKAizBJc2ltmc/bGhYBs8kLMUM=;
        b=ZYEqJ8OuXlCu6gf9K6H/5BgfWS6vKYTBKyG8875ALuLG5eSTaQaMqPa7/vhYIou9bl
         y5G8V/jlDJJNsmKs0O1uRT/AwJpBqnIGC08Kmdd6VmNa/5Pc2ltiCS/VsPyUG83SkUOi
         uoH4+iQnYUXWxrXytBdsucJgNVjhuiJVcIcdC516D9oXJ2kAclyZey2W7g0y1Mtjjyig
         t/bYg4XnyY6WkkDLcE9BkmueBLMxq7zvPblSTMwQY3repmiZecnnQXo4a9olVdINMLCx
         HwIXR3TFUbjql4OT3zUzhjSMitjiak3yzcBr5f8u/4jk4730jmyVRAH+ETqa9u4MtLz7
         +TBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685695972; x=1688287972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CoWktiecpuhKACCKJUKAizBJc2ltmc/bGhYBs8kLMUM=;
        b=aMlHzkmngnyz2wxDOrZE7jpD3SHg1C/O+c08ohrwcddDm7lvf21LOTHgFq4M5ZbfAw
         tdcj8cIakwt4geF1Lh1P+XrsdtDQOm11he0Xkv6FtqzMLqt/uvD0GKjPWoA0g0GqNTaQ
         8rz3argyUmmAk2WBJ4Ur/wSE+ag42Ehrt+k6cLS0J/Tm+XBecGArvDr0TZBEdlGHKi/J
         IZRECH/u+J2BRg9HVzI8reUbvyRohlFmUh++OXAS6iK+wOGnHXgAyHXeD55yFSgdfy8y
         O/hHD3VxYm35mC0uuq6PGAJZcOMhznQ62wxIyHysv+RSs30xErZQAURiGbDY09q6VPXq
         Igdg==
X-Gm-Message-State: AC+VfDx6ISd4Q/KUxFzSgXV6sHkMcBv4MIE8CivWUakXdbNK04VIQh9L
	8U36nVXvy8HKAhEIo4KQPRyths4IYNpu6U+mtkk=
X-Google-Smtp-Source: ACHHUZ7fi91OeEcVZlNzOkv8THwi1vuf3/Vjrb7au7prtsBMMHAHGgIszktmyIkAboA6lhALKIgjrw==
X-Received: by 2002:a0d:c802:0:b0:565:c4af:1a90 with SMTP id k2-20020a0dc802000000b00565c4af1a90mr10892241ywd.40.1685695971961;
        Fri, 02 Jun 2023 01:52:51 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:5401:1e90:5400:4ff:fe75:fb5d])
        by smtp.gmail.com with ESMTPSA id b123-20020a0dd981000000b00565c29cf592sm289828ywe.10.2023.06.02.01.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 01:52:51 -0700 (PDT)
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
Subject: [PATCH bpf-next 5/6] bpf: Support ->fill_link_info for perf_event
Date: Fri,  2 Jun 2023 08:52:38 +0000
Message-Id: <20230602085239.91138-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230602085239.91138-1-laoar.shao@gmail.com>
References: <20230602085239.91138-1-laoar.shao@gmail.com>
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

By adding support for ->fill_link_info to the perf_event link, users will
be able to inspect it using `bpftool link show`. While users can currently
access this information via `bpftool perf show`, consolidating the link
information for all link types in one place would be more convenient.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/uapi/linux/bpf.h       |  6 ++++++
 kernel/bpf/syscall.c           | 45 ++++++++++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  6 ++++++
 3 files changed, 57 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 22c8168..87ecf8b 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6442,6 +6442,12 @@ struct bpf_link_info {
 			__u64 addrs;
 			__u32 count;
 		} kprobe_multi;
+		struct {
+			__aligned_u64 name; /* in/out: symbol name buffer ptr */
+			__u64 addr;
+			__u32 name_len;
+			__u32 offset;
+		} perf_event;
 	};
 } __attribute__((aligned(8)));
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 80c9ec0..da2de8e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3303,9 +3303,54 @@ static void bpf_perf_link_dealloc(struct bpf_link *link)
 	kfree(perf_link);
 }
 
+static int bpf_perf_link_fill_link_info(const struct bpf_link *link,
+					struct bpf_link_info *info)
+{
+	struct bpf_perf_link *perf_link = container_of(link, struct bpf_perf_link, link);
+	char __user *ubuf = u64_to_user_ptr(info->perf_event.name);
+	u32 ulen = info->perf_event.name_len;
+	const struct perf_event *event;
+	u64 probe_offset, probe_addr;
+	u32 prog_id, fd_type;
+	const char *buf;
+	size_t len;
+	int err;
+
+	if (!ulen ^ !ubuf)
+		return -EINVAL;
+	if (!ubuf)
+		return 0;
+
+	event = perf_get_event(perf_link->perf_file);
+	if (IS_ERR(event))
+		return PTR_ERR(event);
+
+	err = bpf_get_perf_event_info(event, &prog_id, &fd_type,
+				      &buf, &probe_offset,
+				      &probe_addr);
+	if (err)
+		return err;
+
+	len = strlen(buf);
+	if (buf) {
+		err = bpf_copy_to_user(ubuf, buf, ulen, len);
+		if (err)
+			return err;
+	} else {
+		char zero = '\0';
+
+		if (put_user(zero, ubuf))
+			return -EFAULT;
+	}
+	info->perf_event.addr = probe_addr;
+	info->perf_event.offset = probe_offset;
+	return 0;
+}
+
 static const struct bpf_link_ops bpf_perf_link_lops = {
 	.release = bpf_perf_link_release,
 	.dealloc = bpf_perf_link_dealloc,
+	.fill_link_info = bpf_perf_link_fill_link_info,
 };
 
 static int bpf_perf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 22c8168..87ecf8b 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6442,6 +6442,12 @@ struct bpf_link_info {
 			__u64 addrs;
 			__u32 count;
 		} kprobe_multi;
+		struct {
+			__aligned_u64 name; /* in/out: symbol name buffer ptr */
+			__u64 addr;
+			__u32 name_len;
+			__u32 offset;
+		} perf_event;
 	};
 } __attribute__((aligned(8)));
 
-- 
1.8.3.1



Return-Path: <bpf+bounces-1366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB7F713A0D
	for <lists+bpf@lfdr.de>; Sun, 28 May 2023 16:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18C4F1C20975
	for <lists+bpf@lfdr.de>; Sun, 28 May 2023 14:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B0C5693;
	Sun, 28 May 2023 14:20:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567F6566E
	for <bpf@vger.kernel.org>; Sun, 28 May 2023 14:20:43 +0000 (UTC)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB51C7
	for <bpf@vger.kernel.org>; Sun, 28 May 2023 07:20:41 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-6260a9ef126so10476476d6.2
        for <bpf@vger.kernel.org>; Sun, 28 May 2023 07:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685283641; x=1687875641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BZgF3NwqqEP5WsJnEoKQ69scbxD7d0B2xVAyMAX9Is=;
        b=pZQBuvwNcT9NGwDibmjUsvSU6I5Q97XBJ8BrLAV+z3dYjbMQJksiVDHGKzHs2Rn2pu
         uUGNMWuM9SEnrz+hsqNF/8z643Ds0p5IdjVxqHOTPIcmJp6LQ7g8eqm2LQeatnEOx27s
         MMZzj6KvhAk6GJlRYqjAS9uWbEHyWHqcbDx7iHl84RSp4wluZxqkixjRVpS8VX3kepr6
         BF5anr21B8RHBo8TgjgzAbbi4afQ+BEqrI6tVj80la/b+KEQv7UiRbBZGCZXMIUAaXfz
         nKqVZCuiADE84GHHqS5xopGWdsTzr+SMs1Q+S5SvP2YPjaOoZG5tOGJW2K/co0102qoy
         Z39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685283641; x=1687875641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BZgF3NwqqEP5WsJnEoKQ69scbxD7d0B2xVAyMAX9Is=;
        b=LtO3Sn4p9FrY4ItPt9nsclSpyL3b+Ti9lPBDXMiVKtsd0IEbWQs8A+uGiCpQsMEGU8
         h9vFyVnotVzjuO0QpcITt+tAYUhvqxcAVQD30sLV9AHgeqb/t9i/j7J0bSZo/4Pq8RLI
         gb85uJ9osV7icZnAzvzU5HRL21I9S+Eeu8jtKoqZRAGH7xDWG4emEfuL9cXW2jPj5WKG
         vfpYWiNz3RLKdKZEXM0aW3MVYzDiQSAmoJ+XXq09sGdUHBfmlA36JPS4aDqTiBiML8h1
         R10fQYMDpHSKu8izk38dwm/2RTsuElcsH8FfDrs7f5e+MVd/t5LHMwsE62GeQHJDJMvh
         +Zbg==
X-Gm-Message-State: AC+VfDz2SrtN1fP8NN5B4q38IpfrSSaYXsARFq1J4r8OmfcnmBYygtGS
	LXYDhC74WB/dIwJ7HLpIfEfPfjxervllX6Y9uoI=
X-Google-Smtp-Source: ACHHUZ6vXe5ADKAAPgI0St1FUXlr36q3Sg/gipHwN4cs9eykV4DOgz+ondpbWcMsOjyr3ZYNm1Fmxw==
X-Received: by 2002:a05:6214:1ccd:b0:623:9126:8d7b with SMTP id g13-20020a0562141ccd00b0062391268d7bmr6316616qvd.28.1685283640818;
        Sun, 28 May 2023 07:20:40 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:5:38f3:5400:4ff:fe74:5668])
        by smtp.gmail.com with ESMTPSA id l11-20020a0cc20b000000b006238dc71f5csm10qvh.144.2023.05.28.07.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 07:20:40 -0700 (PDT)
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
	quentin@isovalent.com
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 7/8] bpf: Support ->fill_link_info for perf_event
Date: Sun, 28 May 2023 14:20:26 +0000
Message-Id: <20230528142027.5585-8-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230528142027.5585-1-laoar.shao@gmail.com>
References: <20230528142027.5585-1-laoar.shao@gmail.com>
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
 kernel/bpf/syscall.c           | 46 ++++++++++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  6 ++++++
 3 files changed, 58 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 6be9b1d..1f2be1d 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6438,6 +6438,12 @@ struct bpf_link_info {
 			__aligned_u64 addrs;
 			__u32 count;
 		} kprobe_multi;
+		struct {
+			__aligned_u64 name;
+			__aligned_u64 addr;
+			__u32 name_len;
+			__u32 offset;
+		} perf_event;
 	};
 } __attribute__((aligned(8)));
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 33a72ec..b12707e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3329,10 +3329,56 @@ static void bpf_perf_link_show_fdinfo(const struct bpf_link *link,
 	seq_printf(seq, "offset:\t%llu\n", probe_offset);
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
+	info->perf_event.name_len = len + 1;
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
 	.show_fdinfo = bpf_perf_link_show_fdinfo,
+	.fill_link_info = bpf_perf_link_fill_link_info,
 };
 
 static int bpf_perf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 6be9b1d..1f2be1d 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6438,6 +6438,12 @@ struct bpf_link_info {
 			__aligned_u64 addrs;
 			__u32 count;
 		} kprobe_multi;
+		struct {
+			__aligned_u64 name;
+			__aligned_u64 addr;
+			__u32 name_len;
+			__u32 offset;
+		} perf_event;
 	};
 } __attribute__((aligned(8)));
 
-- 
1.8.3.1



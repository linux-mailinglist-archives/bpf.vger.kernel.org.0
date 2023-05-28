Return-Path: <bpf+bounces-1364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E39713A08
	for <lists+bpf@lfdr.de>; Sun, 28 May 2023 16:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A64280E5F
	for <lists+bpf@lfdr.de>; Sun, 28 May 2023 14:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C625689;
	Sun, 28 May 2023 14:20:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A194C566E
	for <bpf@vger.kernel.org>; Sun, 28 May 2023 14:20:41 +0000 (UTC)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF501B8
	for <bpf@vger.kernel.org>; Sun, 28 May 2023 07:20:39 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3f6a3a76665so19225241cf.1
        for <bpf@vger.kernel.org>; Sun, 28 May 2023 07:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685283639; x=1687875639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODhBZoAYfxi0mcbicAztGxp9Mvcqb5LLQ3RqkHtqQYg=;
        b=I9ZmF+wzWUPhDuN2zSxdiCKsckosQPRetOGdeUYNHgBsSyYsB+jLHF6fYGzmjU3pgm
         yTk7fVuE8e+7OJPiygxXZIz4G7oiQKS29vhoRGpPogfKa3v9k6Td3F3dLw4VB7IwfX+d
         qqNDVbzZcsHvmEOKQxhvZGR83+r2XEfDo4WayjtEFKKD8vKXuyC5dtKuKjSfdCQI4gp/
         DWfSY8Ly4YbvW9l2XIn2IyghFojrMhUnG5NvCSdnVpmEnH4QmiDSQfrHBYBIRIOqVnL4
         invJu/u7RkTdpw9rIyvkEf2yt1X3h900rOzJQTroEIVUFbicKbJvTmrpspzi60nGOv0J
         5xyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685283639; x=1687875639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ODhBZoAYfxi0mcbicAztGxp9Mvcqb5LLQ3RqkHtqQYg=;
        b=JSMZnBwGVXcsDqX2ERgDNReUJKRL40HEfNsH/Vi8uJJActiImo9mQv6k0NpKZtG642
         sN5QUnT+QCvHnBf9hZJZ+5HBoWS2jyNaqDNcbKtDcxtuhfnJNfPy/b5QqfR0qHyRghHt
         4SRrFzmMCm37TvRR0QPQgo/+bYrytLv36tu4LAjRWfrlpGjTnMsmBOxR5awprKV7kzcQ
         fw09kpWCC3K2+JboXr3Y0n6h+T3gw8aXYVJFoVJIoxOmtNy7HQiauP4KlGpP3SfLq5h5
         qhnnPqHFxnHCVsBF9IRJ6ccHVhplnjScY5+ZLiXxGBAWH8xCo3c8SNTU7K67xOb0guQa
         q+2A==
X-Gm-Message-State: AC+VfDxueM3EYkWjA/UScEurV79gFQ2ZmPBTLxgR5TCRQXW+n1Aqf8fC
	TX6mP1Oml7qLfu0QxO1zlqs=
X-Google-Smtp-Source: ACHHUZ57HJVGSogcsFD2ZVInOh2ZubtsJ6ZbdjVqg3+mARP5OCFEDBcKd5Kk31nhcGxPsQbLibbQ3Q==
X-Received: by 2002:a05:6214:4015:b0:616:859a:471a with SMTP id kd21-20020a056214401500b00616859a471amr4814126qvb.17.1685283638991;
        Sun, 28 May 2023 07:20:38 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:5:38f3:5400:4ff:fe74:5668])
        by smtp.gmail.com with ESMTPSA id l11-20020a0cc20b000000b006238dc71f5csm10qvh.144.2023.05.28.07.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 07:20:38 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next 5/8] bpf: Support ->show_fdinfo for perf_event
Date: Sun, 28 May 2023 14:20:24 +0000
Message-Id: <20230528142027.5585-6-laoar.shao@gmail.com>
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

By adding support for ->show_fdinfo to the perf_event link, users will be
able to examine it through the task's fdinfo. The expected result is as
follows:

$ cat /proc/9637/fdinfo/11
pos:    0
flags:  02000000
mnt_id: 15
ino:    2094
link_type:      perf
link_id:        1
prog_tag:       a04f5eef06a7f555
prog_id:        5
func:   kernel_clone
addr:   ffffffff8d0bc310
offset: 0

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/syscall.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 92a57ef..e6b5127 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3297,9 +3297,36 @@ static void bpf_perf_link_dealloc(struct bpf_link *link)
 	kfree(perf_link);
 }
 
+static void bpf_perf_link_show_fdinfo(const struct bpf_link *link,
+				      struct seq_file *seq)
+{
+	struct bpf_perf_link *perf_link = container_of(link, struct bpf_perf_link, link);
+	const struct perf_event *event;
+	u64 probe_offset, probe_addr;
+	u32 prog_id, fd_type;
+	const char *buf;
+	int err;
+
+	event = perf_get_event(perf_link->perf_file);
+	if (IS_ERR(event))
+		return;
+
+	err = bpf_get_perf_event_info(event, &prog_id, &fd_type,
+				      &buf, &probe_offset,
+				      &probe_addr);
+	if (err)
+		return;
+
+	if (buf)
+		seq_printf(seq, "func:\t%s\n", buf);
+	seq_printf(seq, "addr:\t%llx\n", probe_addr);
+	seq_printf(seq, "offset:\t%llu\n", probe_offset);
+}
+
 static const struct bpf_link_ops bpf_perf_link_lops = {
 	.release = bpf_perf_link_release,
 	.dealloc = bpf_perf_link_dealloc,
+	.show_fdinfo = bpf_perf_link_show_fdinfo,
 };
 
 static int bpf_perf_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
-- 
1.8.3.1



Return-Path: <bpf+bounces-2937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3457371AD
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 18:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79BA32813D2
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 16:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0271B8EF;
	Tue, 20 Jun 2023 16:30:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F075E1B8E8
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 16:30:34 +0000 (UTC)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4330C171F;
	Tue, 20 Jun 2023 09:30:32 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-25e8545ea28so3810718a91.0;
        Tue, 20 Jun 2023 09:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687278631; x=1689870631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csnu/PPXuzoZEYX0jMZNNmLxIgRmJ8iwLveK+VUisPM=;
        b=MamyoigDD8/KYULAGuJyRQOiIYhHq405MFY/wtvJS65w1uvxJbjdmuFfUVZRk6K/Dw
         2Bn8mrK80iEEW1MHg7eSbkDSLrV+nEiV9hD3XYdrn6zb2v8ZFTav+SheSxGBdY1/8p7x
         onSgNmJAb5VwvdrH8XG/k3Se90HqyKzJxBP5jonMjBFPDrcHJpVpoAsl+Y3rK0YnPasI
         t3QCS28BT8uIvxSYzZaPX5p3brVO0u1gMgRhqEwcC28FGf1acSYTczGfsh2VSy8GSQ1X
         qYlMI4GNT1dZT2LqvKxaxaMEQtk/9IxtO0NOZ9KWY+oGrB/draNVJwJepNLiwqJjNcIo
         +3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687278631; x=1689870631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csnu/PPXuzoZEYX0jMZNNmLxIgRmJ8iwLveK+VUisPM=;
        b=IpboZL/OfJcdDJmYDooo5YiTDIuUwMCO6DVGZQp713dA1tDrV8QLCg3x0vSs3X4daq
         /q9Bm+Zxq5eoMj03/CEs+w9OF1tduGXRq2Mr+Mf3g5DImoOnWP2K0yOMbEsbBkLFfG/h
         cyk2kYH/m2i71/i8d7iLSp6urHHUtOe07bYOOV5Cl+9uVQ7n4lA2Zuc+sXN9gHth8Y28
         qFycrEjtJDQyR4SiGCQl/h3LgPEcH/mKJ1oSkVw1ww3gswraoQ9ddBOQa+oIuE+HwlNZ
         SOR4KIjoq6EY3MWpNAoQVJylZAZHS4IY7z90f9BwqyYdWXevKXU8cn3hY6FbNguQKnji
         vUIA==
X-Gm-Message-State: AC+VfDxoYRb/wb+n8YqoYvOejhThCyckoOjvPOsRlD5MoF9eMbSDU3tV
	9avC9BI30DUP1WAiZJNQ6NM=
X-Google-Smtp-Source: ACHHUZ6L7OQk+gxigAJp1mKsms3iXg1i07QBB1g9uLSR+2Zx1jRaBGI+4RSoIl7o1r3pSLMfje8nNQ==
X-Received: by 2002:a17:90a:52:b0:25b:c53e:4697 with SMTP id 18-20020a17090a005200b0025bc53e4697mr12667051pjb.16.1687278631647;
        Tue, 20 Jun 2023 09:30:31 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac02:b96:5400:4ff:fe7b:3b23])
        by smtp.gmail.com with ESMTPSA id t8-20020a17090a3b4800b0025c1cfdb93esm1854286pjf.13.2023.06.20.09.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:30:31 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 08/11] bpf: Add bpf_perf_link_fill_common()
Date: Tue, 20 Jun 2023 16:30:05 +0000
Message-Id: <20230620163008.3718-9-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230620163008.3718-1-laoar.shao@gmail.com>
References: <20230620163008.3718-1-laoar.shao@gmail.com>
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

Add a new helper bpf_perf_link_fill_common(), which will be used by
perf_link based tracepoint, kprobe and uprobe.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/syscall.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6af003d..db9b500 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3306,6 +3306,40 @@ static void bpf_perf_link_dealloc(struct bpf_link *link)
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
 static const struct bpf_link_ops bpf_perf_link_lops = {
 	.release = bpf_perf_link_release,
 	.dealloc = bpf_perf_link_dealloc,
-- 
1.8.3.1



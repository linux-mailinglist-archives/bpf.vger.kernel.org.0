Return-Path: <bpf+bounces-1360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E77A97139FE
	for <lists+bpf@lfdr.de>; Sun, 28 May 2023 16:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BEED1C20975
	for <lists+bpf@lfdr.de>; Sun, 28 May 2023 14:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F0E566B;
	Sun, 28 May 2023 14:20:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFD63D75
	for <bpf@vger.kernel.org>; Sun, 28 May 2023 14:20:37 +0000 (UTC)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA88BD
	for <bpf@vger.kernel.org>; Sun, 28 May 2023 07:20:36 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-626117a8610so4857486d6.1
        for <bpf@vger.kernel.org>; Sun, 28 May 2023 07:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685283635; x=1687875635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBoEWBqQyZgr3XlDnho9z66TJOllaOiv5eDkisHvHIo=;
        b=ki7M5e+7P3IHf3LUN9HC9GugaP4aUF0NIils16+Y24HFWg2PeeXUZ3DSJMJPirh55B
         dkg61W4zy3YbNDwXuVPiSQX5F323bLjBWoZ/1bgzMFF4qS+K0TJY+ETr+NwQXNaYQd9U
         XOWyOFMSww6nNzU59pAjjae4fK6OzeZ/HyTe0tffMcNdzQRreJ3FL/SCsw/k/h3ytWGH
         5ZaKDXHCjqJMepelXsxDBINwDgj64YnbH/UnHvr4oj2xgaBFguOgc8Qijg4K2jBSRxwG
         jtwWYTU5kz0gjextdJklm69SwbMBj+RHHKQESsr5zUI3dHaWK5E67ywObzqSwPkI7Abj
         eM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685283635; x=1687875635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBoEWBqQyZgr3XlDnho9z66TJOllaOiv5eDkisHvHIo=;
        b=dRoBn8SRO3BEyvOukMQ19kyS9dJh2x110LieACB3tF4nOv0s2Clc/jYhBBO4gb5p/J
         QVEllndI5rfrEiBoZjoA9CHAN2FTJ+dRoqFzFJjdzqh/T+aZ2sLaMPov+NR09e4/hUWU
         QnSp9eV31ecq7GWAdZRPQPDQdujXnhU8Nj/OHXkNL+jDe61d9LjYyp+5parG0FbTClu+
         NfKrn+23iyKHoZQaGFIpCNQPKlQZLw4mk3/OBmKcp10WKrkiFcnQ2vYwZi0HMucbY1M1
         wSjCX/jiR3wLrGL73j8o/dKJ3mcEvZyRMfYj8JZzfP0rGJUbCxlaJ8on7/58aU6WAFFz
         SV1A==
X-Gm-Message-State: AC+VfDy3JSzrKcEPVcJjWw7nlNNVnJJZASFBHTKlAg3PYzDggtMs/5as
	KZWrNMdpBr+Uud4I5SJzPq8=
X-Google-Smtp-Source: ACHHUZ4p4g1uTBECLOLWDkQeXDg5a4VTrhMWgn2TScw09pUFV4HKnIOQHrW1XTa3PqSs3RmnOshMqw==
X-Received: by 2002:a05:6214:3011:b0:626:199e:1b7d with SMTP id ke17-20020a056214301100b00626199e1b7dmr2713120qvb.61.1685283635591;
        Sun, 28 May 2023 07:20:35 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:5:38f3:5400:4ff:fe74:5668])
        by smtp.gmail.com with ESMTPSA id l11-20020a0cc20b000000b006238dc71f5csm10qvh.144.2023.05.28.07.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 07:20:35 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next 1/8] bpf: Support ->show_fdinfo for kprobe_multi
Date: Sun, 28 May 2023 14:20:20 +0000
Message-Id: <20230528142027.5585-2-laoar.shao@gmail.com>
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

Currently, there is no way to check which functions are attached to a
kprobe_multi link, causing confusion for users. It is important that we
provide a means to expose these functions. The expected result is as follows,

$ cat /proc/10936/fdinfo/9
pos:    0
flags:  02000000
mnt_id: 15
ino:    2094
link_type:      kprobe_multi
link_id:        2
prog_tag:       a04f5eef06a7f555
prog_id:        11
func_count:     4
func_addrs:     ffffffffaad475c0
                ffffffffaad47600
                ffffffffaad47640
                ffffffffaad47680

$ cat /proc/10936/fdinfo/9 | grep "func_addrs" -A 4 | \
  awk '{ if (NR ==1) {print $2} else {print $1}}' | \
  awk '{"grep " $1 " /proc/kallsyms"| getline f; print f}'
ffffffffaad475c0 T schedule_timeout_interruptible
ffffffffaad47600 T schedule_timeout_killable
ffffffffaad47640 T schedule_timeout_uninterruptible
ffffffffaad47680 T schedule_timeout_idle

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/trace/bpf_trace.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 2bc41e6..0d84a7a 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2548,9 +2548,26 @@ static void bpf_kprobe_multi_link_dealloc(struct bpf_link *link)
 	kfree(kmulti_link);
 }
 
+static void bpf_kprobe_multi_link_show_fdinfo(const struct bpf_link *link,
+				      struct seq_file *seq)
+{
+	struct bpf_kprobe_multi_link *kmulti_link;
+	int i;
+
+	kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
+	seq_printf(seq, "func_count:\t%d\n", kmulti_link->cnt);
+	for (i = 0; i < kmulti_link->cnt; i++) {
+		if (i == 0)
+			seq_printf(seq, "func_addrs:\t%lx\n", kmulti_link->addrs[i]);
+		else
+			seq_printf(seq, "           \t%lx\n", kmulti_link->addrs[i]);
+	}
+}
+
 static const struct bpf_link_ops bpf_kprobe_multi_link_lops = {
 	.release = bpf_kprobe_multi_link_release,
 	.dealloc = bpf_kprobe_multi_link_dealloc,
+	.show_fdinfo = bpf_kprobe_multi_link_show_fdinfo,
 };
 
 static void bpf_kprobe_multi_cookie_swap(void *a, void *b, int size, const void *priv)
-- 
1.8.3.1



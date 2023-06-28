Return-Path: <bpf+bounces-3659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C0F74107D
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 13:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A311B1C2037B
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 11:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25307C2C6;
	Wed, 28 Jun 2023 11:53:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9310BA32
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 11:53:49 +0000 (UTC)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6107630C4;
	Wed, 28 Jun 2023 04:53:48 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-560c617c820so3963958eaf.3;
        Wed, 28 Jun 2023 04:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687953227; x=1690545227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+JRogB97bxWoJfOW0CfNRh76/adLfjmSnF+g9dS4Ezc=;
        b=GnusNgABpuKY8gpdEbEsu3Us8MDTvBk2f0DYbBID8edgmy0bAOYEkinU3Ofqo4xvi5
         Dl0MQt+3HQzJlx7ECrC69z7hDs9mv2fP34tLUYmbJ4h0kHF7C7tXjAdLCV0vfV1TDHn/
         RQBZ4u7T47WZm5WxVuko3uBjhmwKCTxYXkW0OYEEeQfFswtKUrT0sEj5Gdl5jNkhCvB8
         jRDjDuQo/u/WuhXNXCteaGmNjgu+u0ih7KYbvvJLdy5LtolDKIECgeAYkeVmyHYvd8v/
         fdrT/TuzZRbbiYVQuNsGvndVwd+9jcmxT2VvJ07FhXozFw+LSLwx36Begj0Jq6rQWICx
         B4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687953227; x=1690545227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+JRogB97bxWoJfOW0CfNRh76/adLfjmSnF+g9dS4Ezc=;
        b=H6+bHjekecfIQ+prBl7m/n8rczvRYFKN4/SXDjh8yKyao7xYsi3CCK4KobS7jvAIwi
         piURGqU/6sqc7zmtiWEFwqygq9nKRwiyWF06f08nxH4D9rKnweOT1i2eE4z/oKrvlpJK
         DEPCYSXXqDEShT+cXF7/G9qOhRCa/WsaEaz6Y9LWyzqSjbpR12hqJJAwdUHDdGVet/0Q
         mnaplNNW/72D2NgtvXhXdNeF2kAsf3VtarCFoJL+gH5BC5jNNH42zyHh/uhLA+8U2wp2
         YsfioEmVfPPAKOSzNQeR6Lz0sxub63flJQPJAD07ClVee56GdK6J6D035bidkDDqnZ8r
         9gig==
X-Gm-Message-State: AC+VfDxU0jgmk54yGER44ttfEmCqj9SFkG2GFribIIWuhQ6bH0vFXtT4
	RNuzVix6sG6qfsyKPDr9G/Q=
X-Google-Smtp-Source: ACHHUZ5Rzw2tWyuJVQyziP8V98yhwN/0tWukiwZG8B06140BjuwfXQurN5KkrxoPkFlfM4rQenFyFg==
X-Received: by 2002:a05:6808:120a:b0:39e:b985:b47e with SMTP id a10-20020a056808120a00b0039eb985b47emr40633682oil.36.1687953227630;
        Wed, 28 Jun 2023 04:53:47 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac02:b79:5400:4ff:fe7d:3e26])
        by smtp.gmail.com with ESMTPSA id n91-20020a17090a5ae400b002471deb13fcsm8000504pji.6.2023.06.28.04.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 04:53:47 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 08/11] bpf: Add bpf_perf_link_fill_common()
Date: Wed, 28 Jun 2023 11:53:26 +0000
Message-Id: <20230628115329.248450-9-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230628115329.248450-1-laoar.shao@gmail.com>
References: <20230628115329.248450-1-laoar.shao@gmail.com>
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
index 4aa6e5776a04..72de91beabbc 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3364,6 +3364,40 @@ static void bpf_perf_link_dealloc(struct bpf_link *link)
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
2.39.3



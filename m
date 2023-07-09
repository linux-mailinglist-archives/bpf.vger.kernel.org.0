Return-Path: <bpf+bounces-4517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6C574C07E
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 04:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C06351C208D8
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 02:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB9E1FDD;
	Sun,  9 Jul 2023 02:56:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A751FAA
	for <bpf@vger.kernel.org>; Sun,  9 Jul 2023 02:56:54 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2F9E46;
	Sat,  8 Jul 2023 19:56:53 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-668704a5b5bso2800796b3a.0;
        Sat, 08 Jul 2023 19:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688871412; x=1691463412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQPyqPjrgR355vSUeBxjosoT95VpA7rw/d4kqFh1a6c=;
        b=KsqfNH60ZcC0qb44yD0CDDNJIS6i4jXmWznqdLRQOgFtVniH1vxxM97jT8byaH77s1
         n1BQexB+3e03SF+Rjjd6sso+WvO1QgMsPg0AmqxyTQKMoZTPTgaV5xJHm08Yr718xPtw
         4qSjKWSffZaZKe+nvKDbhgVPd4PG/wvWIK2duAgYewxbdz4xu8rBU5dWV0zt4zvuNzXx
         +5Cl4ogUVkG5NhwCCoiiHUZjgbHQsDnxeoSpWThMp2KO6uFSklWZxIPX+N8+tX/0nhQg
         Rw9ykrj2+tlUTIuUAjuibB3mTpo2z9mf/5jzuIl/HtX1INKpA7lcBdNqusox8hE+Gn1T
         DAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688871412; x=1691463412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQPyqPjrgR355vSUeBxjosoT95VpA7rw/d4kqFh1a6c=;
        b=AWhtHEjTGJHcA5bCYiMEJMqlYC88ynlRhVa6GdgchgolIb45r6oe43ikmUqQi8K8jl
         EpXJaIHouk5mOzD6OW3vpXI0LNGLJJ2Nf0lVhOjeDSkhNcqTJjHniTaWGx1zv0n0G+is
         srhkmRkuiair74eQm5om/lVjUaor1epb60iuun20d3qkyvSWxnU46q1uhz0CII+DqFp8
         wOuj+D75aiO+EfNiqlK3Xwpl/FR552DzaJ2IIV1v4s44rs424Rn0736i54uz06OKe+iT
         ij0auFo5j8M57YXmlY+i/cEJeDcYbg6uGT6r2XxHqGGvzm9wqwIdVOy1Q+nMAg3/Zexa
         3Fbg==
X-Gm-Message-State: ABy/qLZCnwcu6jRbyFaYHed1GuQ7nkLuO3w9AWqGbAEEYJhG5fJZkuqe
	0lLrRg5SIS/fetRjdIHJYgs=
X-Google-Smtp-Source: APBJJlG3JImTtsonX2xBxviSv6ikkslHsAO+CDdbRdqT5OohyFitCWx/c5bR71FNy0K4+Q5d8HjuVw==
X-Received: by 2002:a05:6a21:6d88:b0:131:439d:c3bd with SMTP id wl8-20020a056a216d8800b00131439dc3bdmr2644196pzb.20.1688871412592;
        Sat, 08 Jul 2023 19:56:52 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:14bb:5400:4ff:fe80:41df])
        by smtp.gmail.com with ESMTPSA id e9-20020aa78249000000b00682ad247e5fsm5043421pfn.179.2023.07.08.19.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 19:56:52 -0700 (PDT)
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
Subject: [PATCH v7 bpf-next 06/10] bpf: Expose symbol's respective address
Date: Sun,  9 Jul 2023 02:56:26 +0000
Message-Id: <20230709025630.3735-7-laoar.shao@gmail.com>
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

Since different symbols can share the same name, it is insufficient to only
expose the symbol name. It is essential to also expose the symbol address
so that users can accurately identify which one is being probed.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/trace_kprobe.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 249eb14d0f7a..bf2872ca5aaf 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1544,18 +1544,10 @@ int bpf_get_kprobe_info(const struct perf_event *event, u32 *fd_type,
 
 	*fd_type = trace_kprobe_is_return(tk) ? BPF_FD_TYPE_KRETPROBE
 					      : BPF_FD_TYPE_KPROBE;
-	if (tk->symbol) {
-		*symbol = tk->symbol;
-		*probe_offset = tk->rp.kp.offset;
-		*probe_addr = 0;
-	} else {
-		*symbol = NULL;
-		*probe_offset = 0;
-		if (kallsyms_show_value(current_cred()))
-			*probe_addr = (unsigned long)tk->rp.kp.addr;
-		else
-			*probe_addr = 0;
-	}
+	*probe_offset = tk->rp.kp.offset;
+	*probe_addr = kallsyms_show_value(current_cred()) ?
+		      (unsigned long)tk->rp.kp.addr : 0;
+	*symbol = tk->symbol;
 	return 0;
 }
 #endif	/* CONFIG_PERF_EVENTS */
-- 
2.30.1 (Apple Git-130)



Return-Path: <bpf+bounces-2409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB6F72C99A
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 17:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD2A02810DD
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 15:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34AA1D2D9;
	Mon, 12 Jun 2023 15:16:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD81D19511
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 15:16:23 +0000 (UTC)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378D610C7;
	Mon, 12 Jun 2023 08:16:21 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-43b56039611so802625137.1;
        Mon, 12 Jun 2023 08:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686582980; x=1689174980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzAEwWz2g31UMs4g4MUixj1iNbtJ/dM5TZGhqlQXR9c=;
        b=jAMB3BAwtwsq9nji55JfquI9Qr8zzbiwQWdCMgNif5R1/4cb8dlr5x8BgztqBrwvIV
         XLhCuwpjSIjQEqRtI3NpK+rlmwNhWh+OiBq2RvfYz3bXEZpDryDcxZwXypFSSJ90CjeW
         BRVKRC1SiXfnKVyzk4tWutd8ITR8TzYFEqCry6GSLTBsQGci10jj24M5vbvesyRGBddc
         moXi6X8xTfv/uNo6Nlqw99K/R00h5wrqBI7tdt/QOVPT4OwZfqv4tca9npFst/BgEr3X
         93NuC6pYogGjVdAj69Qo51KNiI6UanLOo95BFXgs+waNK3duc+0LGGCFTL57iEQBXbmA
         qQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686582980; x=1689174980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lzAEwWz2g31UMs4g4MUixj1iNbtJ/dM5TZGhqlQXR9c=;
        b=R1mNsv1wOFqJ26gYQkLN4d4OGgo70u24+JurNIFaRvTLZMVIgFD4D0IX3pPfMU5ikL
         6tTiPvZ8SSo6GfdQYxERPWPFOV53sIYk6ERDlvBN3k48TlyxX5j8eqqjFiTsl0/uRbxp
         6zCsCv3/bq2bq2YF5jSd+4dGtQe2JUK9jdY6MyCbz4V9etPW5xIvNoQRk63tCGlrV3OQ
         fOFqq+axSv5OefGqxlGMy+Fv5mzSNK/bnQ1rN3t01pM4oDoIznRj/zQVaivyTdoreWka
         2fC0WWKTPhZdSxCAuqc7TS0jTzW1MpE8HNVpYy5h4WefLyyxuqU0F8gvDa4PvCb/CUbl
         CxzQ==
X-Gm-Message-State: AC+VfDwIG7iZuyZO4fR2cpnz9qMfTDsGeDXc7mE04aw7u4eJy4P0PYda
	P0VSUrTWRBeHlZd9da416FE=
X-Google-Smtp-Source: ACHHUZ5ILCbD9Vji7iqnZ1bZOvJR0jtZH1GU7vT2Piv/rlTyVMdErvt/kKy2XdlyOiMT0WesjueT9Q==
X-Received: by 2002:a67:f85a:0:b0:42f:e944:7ea0 with SMTP id b26-20020a67f85a000000b0042fe9447ea0mr2527590vsp.6.1686582980213;
        Mon, 12 Jun 2023 08:16:20 -0700 (PDT)
Received: from vultr.guest ([108.61.23.146])
        by smtp.gmail.com with ESMTPSA id o17-20020a0cf4d1000000b0062de0dde008sm1533953qvm.64.2023.06.12.08.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 08:16:19 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 04/10] bpf: Protect probed address based on kptr_restrict setting
Date: Mon, 12 Jun 2023 15:16:02 +0000
Message-Id: <20230612151608.99661-5-laoar.shao@gmail.com>
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

The probed address can be accessed by userspace through querying the task
file descriptor (fd). However, it is crucial to adhere to the kptr_restrict
setting and refrain from exposing the address if it is not permitted.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/trace/trace_kprobe.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 59cda19..e4554db 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1551,7 +1551,10 @@ int bpf_get_kprobe_info(const struct perf_event *event, u32 *fd_type,
 	} else {
 		*symbol = NULL;
 		*probe_offset = 0;
-		*probe_addr = (unsigned long)tk->rp.kp.addr;
+		if (kallsyms_show_value(current_cred()))
+			*probe_addr = (unsigned long)tk->rp.kp.addr;
+		else
+			*probe_addr = 0;
 	}
 	return 0;
 }
-- 
1.8.3.1



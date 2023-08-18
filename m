Return-Path: <bpf+bounces-8056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8477807F1
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 11:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FDEB1C21618
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 09:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F8F18AF0;
	Fri, 18 Aug 2023 09:02:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C0DEAF1;
	Fri, 18 Aug 2023 09:02:20 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772333C1F;
	Fri, 18 Aug 2023 02:01:59 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-688787570ccso544676b3a.2;
        Fri, 18 Aug 2023 02:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692349318; x=1692954118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Irt04AQu1gp3FwbXYU0fkFCp791Xhi8XCApG3i3VWJM=;
        b=ntuVfYW1LpyPRTB8Xz8BFHsz6wyQaqZRA2IZqtrZ0JbjTrLsdKblRbwd0TGQu6B85l
         Ph4EomQPkRqZHnBt0MrxWO4siN/BMGqKuJcK+k07QII20aq46hmns6an7ajwWMBFi6aB
         Ac0nNgYWGuzKnFF8tTk1wazzShGH1ukF8/SyCBvlJzdup9vrSs+9G8yc7DqQ5qPTzKHZ
         /acU+H5/hApwc5kTHX9xxDpPYrXBjsxnzNXi8PKF3I+SXlZgADGikGyaHCvpb+KPvUNu
         9iiuLYMLzqarl8PCbor3unRB8X9oKk8bHxadd1TFuYVaZtjHslefJaqDquX4ICA0ip1a
         a/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692349318; x=1692954118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Irt04AQu1gp3FwbXYU0fkFCp791Xhi8XCApG3i3VWJM=;
        b=XS24/aMIn15uzgf7G705PvZb/jgs/WJToYhX8BAEnSNh7ocJUyexK9CaGG0mmgkcW6
         xuzTS51jS4/EI3/QqF3HI4wxHh20EZ5vNox8eCxsEicHNI2xt6aMRZTlF2SqjZYULrMN
         hHXIS+Q2tJnEtAq0TN+RaCrxCMZgotSzzp2NyWVQYsgoKDOgI6SZZaDWv08vgS9YCYVK
         jTrp8npHU3oq2xUKKpExpvjCCMRYrEMFxlv4CuN4UzNkacimXvB8FKNP25hPPIA3eCHb
         YU3B1OGW05xFYcZZcdq2c5kpNjmrAkwKna9CbxHmjwBd9WRUQ4R9JEjJUmNDi+PbDr3I
         uaKw==
X-Gm-Message-State: AOJu0YwjgCA1/JvBgv0Fmz92aUmPHwaV8fEkMxLUHdepyCqOyajrY7EF
	hbwqDqjeEBPxR6vkJHuXPw==
X-Google-Smtp-Source: AGHT+IFJ3IQk8E72MQPJUd7OYtCrSA90dWlqDqIzRYy8Pm9Tah1Qn2g43Y1Wsc2NraPcm5r1lBKI8w==
X-Received: by 2002:a05:6a20:8f28:b0:11f:4707:7365 with SMTP id b40-20020a056a208f2800b0011f47077365mr2567785pzk.38.1692349317681;
        Fri, 18 Aug 2023 02:01:57 -0700 (PDT)
Received: from dell-sscc.. ([114.71.48.94])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902a3c600b001b89045ff03sm1217130plb.233.2023.08.18.02.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 02:01:57 -0700 (PDT)
From: "Daniel T. Lee" <danieltimlee@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [bpf-next 8/9] samples/bpf: refactor syscall tracing programs using BPF_KSYSCALL macro
Date: Fri, 18 Aug 2023 18:01:18 +0900
Message-Id: <20230818090119.477441-9-danieltimlee@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818090119.477441-1-danieltimlee@gmail.com>
References: <20230818090119.477441-1-danieltimlee@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This commit refactors the syscall tracing programs by adopting the
BPF_KSYSCALL macro. This change aims to enhance the clarity and
simplicity of the BPF programs by reducing the complexity of argument
parsing from pt_regs.

Signed-off-by: Daniel T. Lee <danieltimlee@gmail.com>
---
 samples/bpf/test_map_in_map.bpf.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/samples/bpf/test_map_in_map.bpf.c b/samples/bpf/test_map_in_map.bpf.c
index 1883559e5977..9f030f9c4e1b 100644
--- a/samples/bpf/test_map_in_map.bpf.c
+++ b/samples/bpf/test_map_in_map.bpf.c
@@ -103,19 +103,15 @@ static __always_inline int do_inline_hash_lookup(void *inner_map, u32 port)
 	return result ? *result : -ENOENT;
 }
 
-SEC("kprobe/__sys_connect")
-int trace_sys_connect(struct pt_regs *ctx)
+SEC("ksyscall/connect")
+int BPF_KSYSCALL(trace_sys_connect, unsigned int fd, struct sockaddr_in6 *in6, int addrlen)
 {
-	struct sockaddr_in6 *in6;
 	u16 test_case, port, dst6[8];
-	int addrlen, ret, inline_ret, ret_key = 0;
+	int ret, inline_ret, ret_key = 0;
 	u32 port_key;
 	void *outer_map, *inner_map;
 	bool inline_hash = false;
 
-	in6 = (struct sockaddr_in6 *)PT_REGS_PARM2_CORE(ctx);
-	addrlen = (int)PT_REGS_PARM3_CORE(ctx);
-
 	if (addrlen != sizeof(*in6))
 		return 0;
 
-- 
2.34.1



Return-Path: <bpf+bounces-9462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B185E797EF6
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 01:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38DAB2817AD
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 23:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC57D1429E;
	Thu,  7 Sep 2023 23:05:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDDD1427A
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 23:05:56 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B3B1BD7;
	Thu,  7 Sep 2023 16:05:54 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4018af1038cso15841095e9.0;
        Thu, 07 Sep 2023 16:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694127953; x=1694732753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7MCer4dzNlIUrYZ4qbOCKZtdgoy8+2fUxF9mWt007c=;
        b=q0oJiv6kUlZZBamRG/jI6Tw1Tx7+9469Vqmk9WobzkYjGAa64oWlKX+6ZM5gOJRn36
         2zb26Dqavz/JVMi2kiDH7jbbM4ke2dxUgCUygpcPH0RI7rpFf1+YTSPEBQbK3OmneE3b
         s7l3b2d31Me+T6fKAe7u5JQrYEb5n4r19UiO9l4BgoDQIpnSrexyurF86b0cBFEhobki
         C9Kb40XMCDEGczde4eTG3CCEFEy5WanPQ0qszOw/dP2pbGLFqhscAudJUxdQJrXasFRu
         ec6gPyt+hPfh2mA+7nygpDQuGnbmUZejZ0K0db11wmQwryXbltwo8/6sMzZpOKhmm22v
         RjXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694127953; x=1694732753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7MCer4dzNlIUrYZ4qbOCKZtdgoy8+2fUxF9mWt007c=;
        b=umL7pMyaU13QvyeTxIdXo2FCUi8+s8KNkD0kwAzmDPd8nh7lZusgJcnJEVPoyd50hv
         OzQDsGxRhvTjwa7WnAKX18SZWjSkjA4xIspKGaZJjE21wUPYjOEq+1kJGMTTylmBPsg9
         aWnu16IRXvM6x0hu9HBXWdrYbzlbpEW8W9Pb/crTt45dMc5LIjForguCY0oGbpw99iTN
         ASJnrHhcT4jROSI3np/Oa270Dzxii6dXbrS0+nTdjbXz20H7bythgPhrT7OtPAVbXcH9
         kcRTO7yAwwYyOXBrMKvURbpCFPhuHcxs8Y7PUACousPFnJf6EDZbYRy1J0P178Y11wLY
         mDFQ==
X-Gm-Message-State: AOJu0YzUHpLix15K+NFe8W5bcqiN71+nchCShQ3X/1P0xZuEoo7ruslw
	Fz6XLKlUPXSOguo2k0GcM7o=
X-Google-Smtp-Source: AGHT+IH9o2UfFc+G8/B5qOhq5Vk/ilA/8Z9RngR6VQ+AS57swmupXMZktoFeNyX6dUzwShmKqH2HRQ==
X-Received: by 2002:a7b:c456:0:b0:401:cc0b:29c8 with SMTP id l22-20020a7bc456000000b00401cc0b29c8mr757013wmi.29.1694127953347;
        Thu, 07 Sep 2023 16:05:53 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-3-249-32-32.eu-west-1.compute.amazonaws.com. [3.249.32.32])
        by smtp.gmail.com with ESMTPSA id n13-20020a5d484d000000b0031f3b04e7cdsm491358wrs.109.2023.09.07.16.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 16:05:52 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shubham Bansal <illusionist.neo@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: puranjay12@gmail.com
Subject: [PATCH bpf-next v3 1/9] arm32, bpf: add support for 32-bit offset jmp instruction
Date: Thu,  7 Sep 2023 23:05:42 +0000
Message-Id: <20230907230550.1417590-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230907230550.1417590-1-puranjay12@gmail.com>
References: <20230907230550.1417590-1-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The cpuv4 adds unconditional jump with 32-bit offset where the immediate
field of the instruction is to be used to calculate the jump offset.

BPF_JA | BPF_K | BPF_JMP32 => gotol +imm => PC += imm.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 arch/arm/net/bpf_jit_32.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 6a1c9fca5260..c03600fe86f6 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -1761,10 +1761,15 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		break;
 	/* JMP OFF */
 	case BPF_JMP | BPF_JA:
+	case BPF_JMP32 | BPF_JA:
 	{
-		if (off == 0)
+		if (BPF_CLASS(code) == BPF_JMP32 && imm != 0)
+			jmp_offset = bpf2a32_offset(i + imm, i, ctx);
+		else if (BPF_CLASS(code) == BPF_JMP && off != 0)
+			jmp_offset = bpf2a32_offset(i + off, i, ctx);
+		else
 			break;
-		jmp_offset = bpf2a32_offset(i+off, i, ctx);
+
 		check_imm24(jmp_offset);
 		emit(ARM_B(jmp_offset), ctx);
 		break;
-- 
2.39.2



Return-Path: <bpf+bounces-9353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE2479430E
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 20:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 454EE1C20B28
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 18:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9291A1118B;
	Wed,  6 Sep 2023 18:33:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645A56AB1
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 18:33:30 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9F310F7;
	Wed,  6 Sep 2023 11:33:24 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31c6cd238e0so887978f8f.0;
        Wed, 06 Sep 2023 11:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694025203; x=1694630003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aI+tedW+Snwm6nnywIfq2HS1WmOJxbgXON/GP9shUDI=;
        b=iAwXeRcyAsngxbGjxI8g8BqsvSD2ajDlMBLW8myo/8phNLdJFRcQjfhDyZFbeUSRsW
         Hz+M7mAmwTy2lHBkq+ZhOmX76FNkNZQUvNGeRJXo3xHz6YnW6UOleebHMUKzdixAG2eW
         rr6OZhKyhcZwjcDZn53n/6CdD0ujyIrYQiFi0c6Q+zpxoeme7dWp1e1xwbUAb+3znsnx
         RF8tMjYAneZNuHdmbRHeBWX4bSGaE0ay/I+qJF4wuBfUEgkVmJIHwOaKrV79wBGUYJlJ
         Zok6GnjCiR9jEOz2kIvcAcDsuphawNOmuMfRBhXFkoYh/NN7ACTt4d7tpoQ8exGjfZAk
         ojSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694025203; x=1694630003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aI+tedW+Snwm6nnywIfq2HS1WmOJxbgXON/GP9shUDI=;
        b=GyDCekVgQZhCRf/kOZZDOalO+4pCNJX/QEr4mbOcy2bzWSgU8Tu7Ruz6as6SIq6Twu
         p0PgLwttx/iTj9EhI8uttXLeo+rgyN3E+dBuUCQ0MjvUzxjKtBF8UlCdfY+njRhpXM45
         qw15udFkBP+50/TdTk1Q0RmDQ8g+gXSQwuxnw0Van2N7BBqhEQYwEDZan0XFwsbmcu6J
         BuFQtdYmpt3aFMjvfzcG/lsWmmjVnP+1SZy12j0MgfFxAZuL2EhXfPhIA6U/Eqe5udS4
         SsUtdyK7b5kAYsEaZQhERN+dlkvw1VhKOYAKoPzxzx2h5yoab0ybPIgvF8N/udAc53M8
         Nj4Q==
X-Gm-Message-State: AOJu0YzlbWV+Afq1fCEv4DIqM270Fc+21R7EyoiBnWaUT+mZZ37p41cg
	2VR2rPNfu3CJ9loFQrr1upbR5hioTI+i3T8+iBE=
X-Google-Smtp-Source: AGHT+IE6m0+rVA9N3KKSyDoThafXUIGwJjK+CqNo92Ur1i3WFqEWD1V6LVWCC6MapwFwf7D0tAf9pw==
X-Received: by 2002:adf:fc8e:0:b0:319:7ec8:53ba with SMTP id g14-20020adffc8e000000b003197ec853bamr258254wrr.14.1694025202633;
        Wed, 06 Sep 2023 11:33:22 -0700 (PDT)
Received: from ip-172-31-30-46.eu-west-1.compute.internal (ec2-54-170-241-106.eu-west-1.compute.amazonaws.com. [54.170.241.106])
        by smtp.gmail.com with ESMTPSA id l10-20020a5d4bca000000b003180155493esm21094891wrt.67.2023.09.06.11.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 11:33:22 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 1/8] arm32, bpf: add support for 32-bit offset jmp instruction
Date: Wed,  6 Sep 2023 18:33:13 +0000
Message-Id: <20230906183320.1959008-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230906183320.1959008-1-puranjay12@gmail.com>
References: <20230906183320.1959008-1-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The cpuv4 adds unconditional jump with 32-bit offset where the immediate
field of the instruction is to be used to calculate the jump offset.

BPF_JA | BPF_K | BPF_JMP32 => gotol +imm => PC += imm.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
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



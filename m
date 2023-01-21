Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C5C67625B
	for <lists+bpf@lfdr.de>; Sat, 21 Jan 2023 01:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjAUAZ1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 19:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjAUAZN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 19:25:13 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DFE73AC6
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 16:24:40 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id g205so5178027pfb.6
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 16:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yqzLD9MYr6KiuRpe9sBVIUYjbcoAjTXay8FSvvNcEzA=;
        b=MHR/wVyKYf6JT96VHkiXh7CEYEDVoPffKaItvWTQYkqb5rHJs4yenqSdxTxMSVHz+j
         yTwVId05F+a4LgZIJvEYwr/Z+Kp3cPuKqoRsQtDB0NhqenIhkUqAgMAPqdfIgwhwBquy
         j0IOa0HQuJCXXDmTS/eapXe9FaCKi4Kqnd0IFheIYe2vyeMlKwuJ9xv8yo/z1AV3BoE8
         RxMYwUfBVwuNP/0J3tH6j/DJYkV7J/VJFu4Ye/Zsl7NxkbkG6Uo93BHTx8ggSpz2zvNr
         k0dzHcMIZRtFfb3NMInS8GHb0m1QVMiSfJXvnHjq7woslt9FL50lb2uh4VR8hndfWirc
         ZHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqzLD9MYr6KiuRpe9sBVIUYjbcoAjTXay8FSvvNcEzA=;
        b=fJEuhKE/ktYyJ7Pij4d/9jrxAWEoP3nabgvHFyDjVigI69gMzVYnHpk+/MjeKccfMO
         ZrEYjrg6pUg3fYYnoSsOVO777gIfcYudxR2B8zFIQQ6zjFxWblhibznddYMIehNyUA/I
         Hw2eij6uYIZyc9Wke+AlAWFHJsdfLGN8WtdoTyC8jVSUBgtPysq5POyExfDpDkYc2kLy
         Qf17HrescqOSpDzzpDaOMnlcEGRBZy6PKlD7vNkLaFSzcoV7in3121g36tjpDkRhJE+0
         AMYPHLVFdEXjwDs1Y7eKYwDEVbvb2OMLEU4jO8oInGjkIhb6LuLeJkn5AHo1EW6M4nLO
         0vGg==
X-Gm-Message-State: AFqh2kr9HLBtZbfW8VgDtQS7L8ZUZG6q+QN87aPDkH88v6nhYvW7VX3K
        oK6XjJTeg0uOA7OoLYyOifXTWhDsNss=
X-Google-Smtp-Source: AMrXdXsg4S5A1Q5ifQJZ3GRjx/B0AW7FGXnNh4Xv8LHhgYpHOzwyU59dzgE6plKfQYLVCIEMTIaYEA==
X-Received: by 2002:a05:6a00:4207:b0:580:eeae:e4ba with SMTP id cd7-20020a056a00420700b00580eeaee4bamr18434371pfb.4.1674260603663;
        Fri, 20 Jan 2023 16:23:23 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id 65-20020a621844000000b005877d374069sm24251619pfy.10.2023.01.20.16.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 16:23:23 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v5 11/12] selftests/bpf: Add dynptr partial slot overwrite tests
Date:   Sat, 21 Jan 2023 05:52:40 +0530
Message-Id: <20230121002241.2113993-12-memxor@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230121002241.2113993-1-memxor@gmail.com>
References: <20230121002241.2113993-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2463; i=memxor@gmail.com; h=from:subject; bh=vb2M3d6AP1tJHi9lacIFMdvNjgTaEGGdyWxaqNz5OHI=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjyzAkXtdYoVT+uua2rJKUZ75sLYaxpcQxs+Mg4Z+P 6ikII2eJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY8swJAAKCRBM4MiGSL8RyntbEA CgN/UC9rB07GANvrLkbXrPZOHnFgic1ikW/UTeLitsSKTtjDFF8dk1/GRz4oamHhYV1a7Zf/ANAWhO t40GiA1lQLShKohv0qDwEqSD85VtCXQxEahhL0ldEjLGWMebBYj1/hyT5nNwnPiyAWUQHU+Q25VA19 OTeYVnHq+dcXVHRLzp9I+r1H+okBthZLUujl9w07FdSyccvPXisjq9XfiLNNmjM6id0yB7Bowdub36 bsFPWrzCstibKkV1JhGcRdRxBHZ9Zp5Qg/wUK/asiVaZ8uRL1uLd/2DxR5C1Bg+nJyBLzOzXvFwkmZ vgTYU5XpgJnwlyzuX2K/ffbfQFiVlcx93syYYVvpPleIp0DhIVh64gmEVmawTsjiD2L6rByiVQ3Grf rblV6jt+tl5kxkBeC85chcpg1/Vsjhcp36DHxUpNjjtrg0IdRx6169/6JrwZmeP5lEQZj+iF/PLzhq E8k34nf5q7GVlxaWL7MY5XS/Mx1FGcZntxZ6g8HX6RkO40qSNEsluJdZenhUYFhK73vInt6wpkL56J H99xJ2CapLn5jWQvFY3N5qshELQwwz+BaaL+E7VxfEipHvPxgCkaBpM0OjFuCwsLzO1ZR2SFICIk2E /aycmHR0IQgEU9uGXJ3ebd0bHY+e5H5hjx7YmM2AQcUhZtBRG1YBLAZQDzQA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Try creating a dynptr, then overwriting second slot with first slot of
another dynptr. Then, the first slot of first dynptr should also be
invalidated, but without our fix that does not happen. As a consequence,
the unfixed case allows passing first dynptr (as the kernel check only
checks for slot_type and then first_slot == true).

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../testing/selftests/bpf/progs/dynptr_fail.c | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 2d899f2bebb0..1cbec5468879 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -834,3 +834,69 @@ int dynptr_var_off_overwrite(struct __sk_buff *ctx)
 	);
 	return 0;
 }
+
+SEC("?tc")
+__failure __msg("cannot overwrite referenced dynptr") __log_level(2)
+int dynptr_partial_slot_invalidate(struct __sk_buff *ctx)
+{
+	asm volatile (
+		"r6 = %[ringbuf] ll;			\
+		 r7 = %[array_map4] ll;			\
+		 r1 = r7;				\
+		 r2 = r10;				\
+		 r2 += -8;				\
+		 r9 = 0;				\
+		 *(u64 *)(r2 + 0) = r9;			\
+		 r3 = r2;				\
+		 r4 = 0;				\
+		 r8 = r2;				\
+		 call %[bpf_map_update_elem];		\
+		 r1 = r7;				\
+		 r2 = r8;				\
+		 call %[bpf_map_lookup_elem];		\
+		 if r0 != 0 goto sjmp1;			\
+		 exit;					\
+	sjmp1:						\
+		 r7 = r0;				\
+		 r1 = r6;				\
+		 r2 = 8;				\
+		 r3 = 0;				\
+		 r4 = r10;				\
+		 r4 += -24;				\
+		 call %[bpf_ringbuf_reserve_dynptr];	\
+		 *(u64 *)(r10 - 16) = r9;		\
+		 r1 = r7;				\
+		 r2 = 8;				\
+		 r3 = 0;				\
+		 r4 = r10;				\
+		 r4 += -16;				\
+		 call %[bpf_dynptr_from_mem];		\
+		 r1 = r10;				\
+		 r1 += -512;				\
+		 r2 = 488;				\
+		 r3 = r10;				\
+		 r3 += -24;				\
+		 r4 = 0;				\
+		 r5 = 0;				\
+		 call %[bpf_dynptr_read];		\
+		 r8 = 1;				\
+		 if r0 != 0 goto sjmp2;			\
+		 r8 = 0;				\
+	sjmp2:						\
+		 r1 = r10;				\
+		 r1 += -24;				\
+		 r2 = 0;				\
+		 call %[bpf_ringbuf_discard_dynptr];	"
+		:
+		: __imm(bpf_map_update_elem),
+		  __imm(bpf_map_lookup_elem),
+		  __imm(bpf_ringbuf_reserve_dynptr),
+		  __imm(bpf_ringbuf_discard_dynptr),
+		  __imm(bpf_dynptr_from_mem),
+		  __imm(bpf_dynptr_read),
+		  __imm_addr(ringbuf),
+		  __imm_addr(array_map4)
+		: __clobber_all
+	);
+	return 0;
+}
-- 
2.39.1


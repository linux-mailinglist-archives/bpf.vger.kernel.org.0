Return-Path: <bpf+bounces-4965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52687752914
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 18:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1634A281E9C
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 16:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE6A17AB5;
	Thu, 13 Jul 2023 16:49:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30732FB3
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 16:49:35 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229572D75;
	Thu, 13 Jul 2023 09:49:34 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-676f16e0bc4so612990b3a.0;
        Thu, 13 Jul 2023 09:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689266973; x=1691858973;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=brLFB/e/7Oi0GsJYQKM7Ftuw8LYNUfDkAuTAqWsvQ7M=;
        b=Bpm7AH5+MZQDXC1YhqXdmriKkr1YpuXICsupjW+P5fuHWR5vG+hLmD0ArFqSW0GsgO
         3pRbaQdD+hyxx3/hXfqKAzaVF3vIpmKp8F6SUe/MGm7LeGzW53lWYVnGZMwcwgi39UX+
         MgRmrOx/gNQ66Lebaa5mmem/JqLHm1cqw7WXSGre8WKSxsYhQVxquLcNv6eS8wkZH24i
         1DBiwx0h9lJmV2B1SXITA/IfJMmwRvMG6zr6yGxyBa8/fVj/7fuYNQw7r3IQYf09q+dn
         8y2J0mHdQO+Rt1eJaTCAQBazhLUJdcc1mWt5W/AmI5syq5mCqyDGfTzC4NkuGO3mbOgR
         PJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689266973; x=1691858973;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brLFB/e/7Oi0GsJYQKM7Ftuw8LYNUfDkAuTAqWsvQ7M=;
        b=Z0lUs3cDVjhji90RgMxhqPz+DNeLgv6j27zOkeK0CwlMEvFUcin0wfgb3Chc1SRbf8
         ZIEK1sByTDuKdOv1xJE4+klMI0v9KBOszggAMGX0EfcAK41QjeZ1AHjJ7MdLOncGLrPm
         fN8/T7jZLWGq8yxzEZGW4ahsY0BsolHT5/tHerk+v/H9aRAy0/GE2GS+dpJJtVJn6DKa
         9RTdf5Q00z54vLowXDXC9/fulU6xdspsOFaW8uh/zr2NEYxVP2CqMYF/Z2WDIbHC2Ldw
         MRDSMvD8GTEurmFLd7ffYAERmO8VLBR+n6x/+jE/BiIsMUPY61IC8mZizKY96VldC4ML
         f28g==
X-Gm-Message-State: ABy/qLbW6lxxJUrqerVx/XKTA+kqIO2Yp9bD2FuwH1i96a3rS6xMhlMn
	ZPQV1ttgSDuO1oaxCjUdPG8=
X-Google-Smtp-Source: APBJJlE2/yOvvkT5TNtK8z3rt8q1rYhwXnU6AtA4Mbain02P9huskQ4mV2V63ozKdU06FH6qFSLsAg==
X-Received: by 2002:a05:6a00:124b:b0:668:82fe:16e2 with SMTP id u11-20020a056a00124b00b0066882fe16e2mr1906844pfi.16.1689266973264;
        Thu, 13 Jul 2023 09:49:33 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:448:b800:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id 18-20020a056a00073200b006833b73c749sm2341955pfm.22.2023.07.13.09.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 09:49:32 -0700 (PDT)
Subject: [PATCH bpf] bpf,
 arm64: Fix BTI type used for freplace attached functions
From: Alexander Duyck <alexander.duyck@gmail.com>
To: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: xukuohai@huaweicloud.com
Date: Thu, 13 Jul 2023 09:49:31 -0700
Message-ID: 
 <168926677665.316237.9953845318337455525.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Alexander Duyck <alexanderduyck@fb.com>

When running an freplace attached bpf program on an arm64 system w were
seeing the following issue:
  Unhandled 64-bit el1h sync exception on CPU47, ESR 0x0000000036000003 -- BTI

After a bit of work to track it down I determined that what appeared to be
happening is that the 'bti c' at the start of the program was somehow being
reached after a 'br' instruction. Further digging pointed me toward the
fact that the function was attached via freplace. This in turn led me to
build_plt which I believe is invoking the long jump which is triggering
this error.

To resolve it we can replace the 'bti c' with 'bti jc' and add a comment
explaining why this has to be modified as such.

Fixes: b2ad54e1533e ("bpf, arm64: Implement bpf_arch_text_poke() for arm64")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 arch/arm64/net/bpf_jit_comp.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 145b540ec34f..ec2174838f2a 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -322,7 +322,13 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf)
 	 *
 	 */
 
-	emit_bti(A64_BTI_C, ctx);
+	/* bpf function may be invoked by 3 instruction types:
+	 * 1. bl, attached via freplace to bpf prog via short jump
+	 * 2. br, attached via freplace to bpf prog via long jump
+	 * 3. blr, working as a function pointer, used by emit_call.
+	 * So BTI_JC should used here to support both br and blr.
+	 */
+	emit_bti(A64_BTI_JC, ctx);
 
 	emit(A64_MOV(1, A64_R(9), A64_LR), ctx);
 	emit(A64_NOP, ctx);




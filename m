Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CE660DCE1
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 10:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbiJZIQu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Oct 2022 04:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbiJZIQt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Oct 2022 04:16:49 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08EF8D22E;
        Wed, 26 Oct 2022 01:16:48 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id az22-20020a05600c601600b003c6b72797fdso970070wmb.5;
        Wed, 26 Oct 2022 01:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XQrSTyfhMtQPpxxhJU/ar1JrJV7XCzKtcCQvIyVOIy8=;
        b=jl2HFmdzLYBiS+vt9fhpdR7erCRUSVpVoy903eybZ712HPcEgrUVhxUdjNy8vjtq+a
         mGsvt2MbaRAyEioeSN10YIGQjmYqOVLgVn3wWjX1oTI/q70ZUCwWNdo8k+QgGNFmOSoF
         UZaChFiLIlkNUuSFDRZclzqsWhuhd6gvx6wokU8joqeWiFoZHYXv5s4xB25D6bQlvNps
         PPWZ8pwzj0elHveJdi/vtKctM3Ew9vilspuPOZ/58gXRWxJhA412dIhpJJuxxI5erDmc
         +TSXJVMfW5Hh3vF41JK8hLWS0wnPXKnGzYuJQlaZwTivWaOaL/3S+V2f9yHtIqYo2n00
         IovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XQrSTyfhMtQPpxxhJU/ar1JrJV7XCzKtcCQvIyVOIy8=;
        b=Jm7aXTQiaqPXizcmohqD4OuFSCDlY3Kwb11Imd4GxDOFMxddhCGb+OvrpYK5V5klP6
         xHz/I7JZKO/7We8SlweZwn5INm0IfnkG8PpZfsrUqK2WKs8AKbZ2hUnZMdcu2myD1TH2
         bu+2Hu7NYYa3EC2OqVwYLNJ4hvUGqMUUfi8YFKRs1jpLnBEOF8tdlhvgGifThW/feh3N
         fljiJ/L+dtktazNYboTpEjGo5ZUN3B9Atn1fdhHEB+oeJUoGPqNMY6/wrs8uUePAf2G9
         oHX218fW7hptsAP6tydDnxwoI+vo59uck+hXtHM8d7Dx0GpYlHeVSe6x8AQt+dkm9uY0
         n5Vg==
X-Gm-Message-State: ACrzQf0+4LxDa6tDlt1Pbq68c74mIY1aDV5SrpLzzmsyRXn2+t4QyLby
        413/nBjnl5rR+gInMRUQFF4=
X-Google-Smtp-Source: AMsMyM7XmA1X4tNZpHNjEWs8mQT3Wq9+040EXB3IJxVuT7nU9CCPl8Q7M8NbOb/FBrVnwxXk2aORxg==
X-Received: by 2002:a05:600c:1f08:b0:3c6:75b3:f444 with SMTP id bd8-20020a05600c1f0800b003c675b3f444mr1541407wmb.74.1666772207290;
        Wed, 26 Oct 2022 01:16:47 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id f12-20020a05600c4e8c00b003b95ed78275sm1236938wmq.20.2022.10.26.01.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 01:16:46 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] bpftool: Fix spelling mistake "disasembler" -> "disassembler"
Date:   Wed, 26 Oct 2022 09:16:45 +0100
Message-Id: <20221026081645.3186878-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in an error message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/bpf/bpftool/jit_disasm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/jit_disasm.c b/tools/bpf/bpftool/jit_disasm.c
index 58a5017034a2..7b8d9ec89ebd 100644
--- a/tools/bpf/bpftool/jit_disasm.c
+++ b/tools/bpf/bpftool/jit_disasm.c
@@ -223,7 +223,7 @@ static int init_context(disasm_ctx_t *ctx, const char *arch,
 
 	memset(tpath, 0, sizeof(tpath));
 	if (get_exec_path(tpath, sizeof(tpath))) {
-		p_err("failed to create disasembler (get_exec_path)");
+		p_err("failed to create disassembler (get_exec_path)");
 		return -1;
 	}
 
-- 
2.37.3


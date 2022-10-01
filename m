Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E81F5F1BD7
	for <lists+bpf@lfdr.de>; Sat,  1 Oct 2022 12:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiJAKpI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 1 Oct 2022 06:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJAKpG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 1 Oct 2022 06:45:06 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FBB23BD5
        for <bpf@vger.kernel.org>; Sat,  1 Oct 2022 03:45:03 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id b2so13693275eja.6
        for <bpf@vger.kernel.org>; Sat, 01 Oct 2022 03:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=8BosUY18tElRYe26ebCRL2pHI22bw2J0kGndde6SkYk=;
        b=TIxxPtPCgVv/Fyeb2bhOqqTHB4Z/7Rd4tadtN3vixEDeq0xhq5K9fY/PeDIrVkWdmt
         fqXEhNKFQ2YYobOGhH3yxa+vJ37yN2fzAK1nbF4dskKDSQiGfCLMhD8mrTDNMU2qGMJu
         GQvL/RRx61TOvonY4cU7wqX9K0LT1Pz8NZG+/RgpJ8TSj86ohKIHX59NtVsOvROAPi0C
         SVCVznFON0AI72Sxf9jCAUQYZcEOhbzEoQgHp0TJGIyxZiYmBestpXSU6IzEKwu4hQxd
         iPYBJTFXHNgoAN4aceQ83F1tcepo2JhcbWxAUqyijt3BZU2GwfGq5gFtvzQqUKej4XAC
         efMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=8BosUY18tElRYe26ebCRL2pHI22bw2J0kGndde6SkYk=;
        b=Kb0IZHuPw7WpIOpPWRYCXsCkh4DepXzCp8/WZRyAwWCAAk+RlhWliJF4jFjMhR7ZPH
         +b1j0s6pudL4cZT5XG/dVOwozaqJVyCAlkii0HbNVtOAzmn97cvBEXqQJeu6IkaeU3lh
         to6CwHAgoMCa8bp4cpRd/9M1gQwgr4Naf681qlgV8BEiYtLRdpr9dd4RECtfM0cEGx3J
         wt8f2IqxQwum6QMontZyMbaOrG++vGzqi+sgzv7iC1Wpb4jKj1XUP5OaWNMw+U0umHuj
         kzkuTWcHVl7DnBOa4+2LSG6XZ9YXkVfcTJoLLJLBhK0I8hNgnmzRtVl+sCOo/efEQeui
         1fDQ==
X-Gm-Message-State: ACrzQf0GwL7CHXCmpJSnYqjiWFqaTp8MDvtS8CYCIvQxC+KG6tIhoOVr
        T6beyEFjmGC9un1jhQTO1bFxyuY2N1qOCSxJ
X-Google-Smtp-Source: AMsMyM7RnDj1ZrahHIrTNxgjg84wt1EoaqOmhiMhZCjOuwrV7Cy/3zeaoSlaKBvUtURlh8PHgzUATw==
X-Received: by 2002:a17:907:2c47:b0:787:6f95:2bfe with SMTP id hf7-20020a1709072c4700b007876f952bfemr9575210ejc.705.1664621101565;
        Sat, 01 Oct 2022 03:45:01 -0700 (PDT)
Received: from badger.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id y8-20020a056402358800b0044dbecdcd29sm3415635edc.12.2022.10.01.03.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 03:45:01 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 1/2] bpftool: Print newline before '}' for struct with padding only fields
Date:   Sat,  1 Oct 2022 13:44:24 +0300
Message-Id: <20221001104425.415768-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

btf_dump_emit_struct_def attempts to print empty structures at a
single line, e.g. `struct empty {}`. However, it has to account for a
case when there are no regular but some padding fields in the struct.
In such case `vlen` would be zero, but size would be non-zero.

E.g. here is struct bpf_timer from vmlinux.h before this patch:

 struct bpf_timer {
 	long: 64;
	long: 64;};

And after this patch:

 struct bpf_dynptr {
 	long: 64;
	long: 64;
 };

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/btf_dump.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 4221f73a74d0..e4da6de68d8f 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -944,7 +944,11 @@ static void btf_dump_emit_struct_def(struct btf_dump *d,
 					  lvl + 1);
 	}
 
-	if (vlen)
+	/*
+	 * Keep `struct empty {}` on a single line,
+	 * only print newline when there are regular or padding fields.
+	 */
+	if (vlen || t->size)
 		btf_dump_printf(d, "\n");
 	btf_dump_printf(d, "%s}", pfx(lvl));
 	if (packed)
-- 
2.37.3


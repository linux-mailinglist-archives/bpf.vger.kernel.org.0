Return-Path: <bpf+bounces-2567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CB972F149
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 03:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2B581C20A49
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 01:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF0F382;
	Wed, 14 Jun 2023 01:04:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6AD7F
	for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 01:04:09 +0000 (UTC)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B086D1BE6;
	Tue, 13 Jun 2023 18:04:08 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-33cb82122c7so26158285ab.1;
        Tue, 13 Jun 2023 18:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686704648; x=1689296648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bpUdBggZnHoq1zlVFxgo8EOItQu5v4wHe2ZS06ricxs=;
        b=WTzdcCj5MSQnTu/zcHd0iVPWIl5NVOf5nldAKrvbRskPjHibBG39iMDXeKNqqE6oH+
         K3j0qyJ0OLZMOlNPA8nvW00jlSDw+mPRxTzK44xDPc3EpWBYVl3akqgGTKsVbny6b24q
         Y0Zix+Jet8++eqzmp2/22PE5rlamCOPyuE50xg6XJaLU5b2cAY/3QynmS9zCFXuc9MU6
         IqfzsqqzmUnD6dh0hG3XH2tKA6RNZkQPs7d/hJD89fLd+rLlxoUPl2/+c4jb2gy4T/jb
         /3zVebS/7a3qBYWOHT3EyQa50JVXy2mcCOHRDN9heBOBjnJWGihaB83+w4RqSXNF68G+
         P/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686704648; x=1689296648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bpUdBggZnHoq1zlVFxgo8EOItQu5v4wHe2ZS06ricxs=;
        b=kREInvsXXNpUyV6t0nsRscBfRtWzMGFrtRtJEkHaPDQiDW/CoNn6Uwdm6mPYC/FLdM
         RldEGY4gLuD0DY9jzSsY/eRzTv+SCRqf8QkT3D4htqp8R429f73mGDM1KhIy7eymsmWe
         rTPhQNdHLcvd6hMlUQnv/Mo+qAuz6wC1ufS37FM44XY1HU5iEKkDROKLlWJK/wOSxUaw
         KvmObGGldfRHtVIzrQ+pzEbM335cXPRDKtFx1Rgjf99bp8Ves4kGStvsyxytQiU6U8O2
         5AUPlLk0XQGPP3prmDJdHagqb30XD8DlP+HsR7uRx4XbCDYlIh7Sci6YYiMj6cW0qMIZ
         gfhw==
X-Gm-Message-State: AC+VfDzG6L92ZsYt/e7a0TTLsWCphiL6UUuXLQVB3/zf+Ixw6f2H2ZuO
	C3BiGEx3kLWQkcrQakjlDmw=
X-Google-Smtp-Source: ACHHUZ4Agytr6+ZyUd2Iuhgh5sPm4YOf7M1dnl/moE2gtA9y/bz2MI2nor/Tr+O6CBuE4kXx+4QlkA==
X-Received: by 2002:a5e:df4a:0:b0:760:e308:107e with SMTP id g10-20020a5edf4a000000b00760e308107emr10980297ioq.0.1686704647997;
        Tue, 13 Jun 2023 18:04:07 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id b15-20020a029a0f000000b0041f50bf668fsm3735448jal.57.2023.06.13.18.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 18:04:07 -0700 (PDT)
From: Azeem Shaikh <azeemshaikh38@gmail.com>
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	linux-kernel@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Zhen Lei <thunder.leizhen@huawei.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Maninder Singh <maninder1.s@samsung.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Miroslav Benes <mbenes@suse.cz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	bpf@vger.kernel.org
Subject: [PATCH] kallsyms: Replace all non-returning strlcpy with strscpy
Date: Wed, 14 Jun 2023 01:03:54 +0000
Message-ID: <20230614010354.1026096-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 kernel/kallsyms.c |    4 ++--
 kernel/params.c   |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 0f82c3d5a57d..7982cc9d497c 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -667,7 +667,7 @@ static int get_ksymbol_bpf(struct kallsym_iter *iter)
 {
 	int ret;
 
-	strlcpy(iter->module_name, "bpf", MODULE_NAME_LEN);
+	strscpy(iter->module_name, "bpf", MODULE_NAME_LEN);
 	iter->exported = 0;
 	ret = bpf_get_kallsym(iter->pos - iter->pos_ftrace_mod_end,
 			      &iter->value, &iter->type,
@@ -687,7 +687,7 @@ static int get_ksymbol_bpf(struct kallsym_iter *iter)
  */
 static int get_ksymbol_kprobe(struct kallsym_iter *iter)
 {
-	strlcpy(iter->module_name, "__builtin__kprobes", MODULE_NAME_LEN);
+	strscpy(iter->module_name, "__builtin__kprobes", MODULE_NAME_LEN);
 	iter->exported = 0;
 	return kprobe_get_kallsym(iter->pos - iter->pos_bpf_end,
 				  &iter->value, &iter->type,
diff --git a/kernel/params.c b/kernel/params.c
index 6a7548979aa9..07d01f6ce9a2 100644
--- a/kernel/params.c
+++ b/kernel/params.c
@@ -847,7 +847,7 @@ static void __init param_sysfs_builtin(void)
 			name_len = 0;
 		} else {
 			name_len = dot - kp->name + 1;
-			strlcpy(modname, kp->name, name_len);
+			strscpy(modname, kp->name, name_len);
 		}
 		kernel_add_sysfs_param(modname, kp, name_len);
 	}
-- 
2.41.0.162.gfafddb0af9-goog




Return-Path: <bpf+bounces-9421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D41A77976A0
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 18:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 984DA28093C
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 16:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08CD134B0;
	Thu,  7 Sep 2023 16:13:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDB628E7
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 16:13:45 +0000 (UTC)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F224261AF
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 09:13:19 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3a9f88b657eso725883b6e.3
        for <bpf@vger.kernel.org>; Thu, 07 Sep 2023 09:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694102821; x=1694707621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsB9C/kF+PpX2LmrpmF5uLLoJCG5xKVOO9GLDkobJOA=;
        b=lLhckt5kkFBwdzCcWTa9Cj40folVI9GEWC/fJ9tOHTWXc5tAu9u/CowIxmKOy3p5M0
         wY656g3PMlON5V2GvPUdN1cNThn0pyAgGmtj7zKu8n/nayS1hxiFpN8B8Ey85j3rrQMC
         5GHd+3D7rjlYzoL3bFwo+Jhcy0VxACTNMnnLPISK4LjYzdeO1ZIT9PSBeo8VyBn5sBab
         yDxMx9Y6v9hikhBLFzBYaN4VWeNo4Kr4hJtFhe2OvBxodh0TJBSaap5xAv87oN43Nk0F
         Xdb87H76ex1ZiQvpaJR6Wfo+A0vZcCRh2QZeuWLhCWXIrgby74WmZbt5fYCkV1r6qjY+
         7Nkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694102821; x=1694707621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UsB9C/kF+PpX2LmrpmF5uLLoJCG5xKVOO9GLDkobJOA=;
        b=FAPS7EF5YUgqa/kouYQpkxHwuEWIKnkZ3KarRZU1l6Kqs2DbhNuNPsdpk3v+3B6DN0
         zDDyyWmKF1EXZN2Zmik2aB/666i1KBYhGFVZOsI+1UUeKQ8ImvBRuZ5Qj4X+cDSS9y63
         XDACrCArJ3x31uH5Q444sNoaHhtMm1DKgzVIA4dc/knLmmEl8P/iSjuxztfvX3Fm+NBV
         5/fBt1TcsN8RMM4sny/vR6tBc2x0TZyJ0XpgQ0SlHYmMo7ACs6IMm8D47HhDzbyiE2qk
         JjV/0Rk7FmAfWxpkahY6o9KHLjbUPycd0uGT0PJP4er1hiWoEEDyvSWOGWF/iaJcFEmC
         zVdQ==
X-Gm-Message-State: AOJu0YwZzn90CP2oth198RtZ0NJIRS5ELDKzDTmYC9LjYMz/ED+Hmnn8
	ql7RzBHos7AD1pSRNE4nptaJrxBmCRUfpA==
X-Google-Smtp-Source: AGHT+IHagdcCIT/Q9HQaXL/05O4ztQLLIcEjvE+bmfzJKyvjUsTu3HKOCH2yu3ISbYPIXd9+AgbVDw==
X-Received: by 2002:a05:6870:a924:b0:1c3:91b9:e1e7 with SMTP id eq36-20020a056870a92400b001c391b9e1e7mr22496171oab.21.1694065405063;
        Wed, 06 Sep 2023 22:43:25 -0700 (PDT)
Received: from ubuntu.. ([43.132.98.117])
        by smtp.googlemail.com with ESMTPSA id q7-20020a637507000000b00570574feda0sm11860963pgc.19.2023.09.06.22.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 22:43:24 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alan.maguire@oracle.com,
	olsajiri@gmail.com,
	hengqi.chen@gmail.com
Subject: [PATCH bpf-next v2 1/3] libbpf: Resolve symbol conflicts at the same offset for uprobe
Date: Tue,  5 Sep 2023 15:12:55 +0000
Message-Id: <20230905151257.729192-2-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905151257.729192-1-hengqi.chen@gmail.com>
References: <20230905151257.729192-1-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dynamic symbols in shared library may have the same name, for example:

    $ nm -D /lib/x86_64-linux-gnu/libc.so.6 | grep rwlock_wrlock
    000000000009b1a0 T __pthread_rwlock_wrlock@GLIBC_2.2.5
    000000000009b1a0 T pthread_rwlock_wrlock@@GLIBC_2.34
    000000000009b1a0 T pthread_rwlock_wrlock@GLIBC_2.2.5

    $ readelf -W --dyn-syms /lib/x86_64-linux-gnu/libc.so.6 | grep rwlock_wrlock
     706: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 __pthread_rwlock_wrlock@GLIBC_2.2.5
    2568: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 pthread_rwlock_wrlock@@GLIBC_2.34
    2571: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 pthread_rwlock_wrlock@GLIBC_2.2.5

Currently, users can't attach a uprobe to pthread_rwlock_wrlock because
there are two symbols named pthread_rwlock_wrlock and both are global
bind. And libbpf considers it as a conflict.

Since both of them are at the same offset we could accept one of them
harmlessly. Note that we already does this in elf_resolve_syms_offsets.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/lib/bpf/elf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
index 9d0296c1726a..5c9e588b17da 100644
--- a/tools/lib/bpf/elf.c
+++ b/tools/lib/bpf/elf.c
@@ -214,7 +214,10 @@ long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)

 			if (ret > 0) {
 				/* handle multiple matches */
-				if (last_bind != STB_WEAK && cur_bind != STB_WEAK) {
+				if (elf_sym_offset(sym) == ret) {
+					/* same offset, no problem */
+					continue;
+				} else if (last_bind != STB_WEAK && cur_bind != STB_WEAK) {
 					/* Only accept one non-weak bind. */
 					pr_warn("elf: ambiguous match for '%s', '%s' in '%s'\n",
 						sym->name, name, binary_path);
--
2.34.1


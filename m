Return-Path: <bpf+bounces-9618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EDA79A10B
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 03:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A0821C20831
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 01:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6823817E1;
	Mon, 11 Sep 2023 01:51:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2624617C8
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 01:51:27 +0000 (UTC)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F42D135
	for <bpf@vger.kernel.org>; Sun, 10 Sep 2023 18:51:25 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1d4db7959f6so2957893fac.0
        for <bpf@vger.kernel.org>; Sun, 10 Sep 2023 18:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694397084; x=1695001884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pawMJsOKDgu9Gon7EgpgpCFzh+wr1zlriB6K5y8OzVg=;
        b=Fi7VgoSSFaE89ASGtGqHe2qF8toGT/3AKl7KylaACzR9VQuZElebWHH/+eZqmBjVDy
         OFqXFXFcrRqdLcmKt+YPk1pYuaxmnGu33SN2v8TTIy0RUjOxm93qcM6dfS5u9RpFLdKX
         KEOMpS2/uiJP2iXtzwUde50ffXhxhYJq7+AdO6rX6Dn9X75NmTPgEBqqyIjVsm53Sfrz
         DppCrOLC7lAiyED4ANT6bRGKx7Y3TsjgL/6/NLwkSS2snGF/2m/PDp+7IfCpyHXOUnHk
         1IXLlRkWZixFe0blJhw1Gai9qiImX1FqqkAoSkjpZVlO38To1DFofZCfeTqBH3UCySEm
         KO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694397084; x=1695001884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pawMJsOKDgu9Gon7EgpgpCFzh+wr1zlriB6K5y8OzVg=;
        b=P0cWeECvl/GHywmj5MYTubLvbHjjPmAQyvIMwJKDw/F7hD9spqtb56R62d3TcghJMF
         aI5POF8Ulk4ym5TZmks7wyYE7Z/pV4IlxLJ/7pb0ibe5jpjdCzKckIILn3Llgs0EYRzM
         hGH9382JH5SdS52hIbgHhyU9oqXm4WTyozYVVW2ntMDak1JVXmrNEpTkp0z7phUTCRGC
         ZrXfQxASQbS997CbK55/ycqQvEnfEI/akZpNYD9Mi3pCtzv9V4kxv82mg+nCA4O/qAd1
         s0KwM6ltweIckDje1VLJKss3V+aTvXv2l9VjJMZuINPotVa1VcJRDNT7gjXhbpjjreb9
         8fug==
X-Gm-Message-State: AOJu0YxHDyICS1zCDPP/s6LzNP9A6lYgG1FeElyw2J4+cZYyObEVERCF
	FzpTF/bh5lx43obDLQrdQdQ+3UBlLhlOQg==
X-Google-Smtp-Source: AGHT+IEq4Uox5md0v4PPR+sNrPRJxHVpq7JXKkDNlzW3s+BtBoqmbnjTLyYT5Veo4s23lEUcWS11OA==
X-Received: by 2002:a05:6870:f78d:b0:1d5:af57:e916 with SMTP id fs13-20020a056870f78d00b001d5af57e916mr2982424oab.16.1694397084505;
        Sun, 10 Sep 2023 18:51:24 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.3])
        by smtp.gmail.com with ESMTPSA id z14-20020a63b04e000000b0056365ee8603sm4375699pgo.67.2023.09.10.18.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 18:51:24 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alan.maguire@oracle.com,
	olsajiri@gmail.com,
	hengqi.chen@gmail.com,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH bpf-next v3 1/3] libbpf: Resolve symbol conflicts at the same offset for uprobe
Date: Mon, 11 Sep 2023 01:50:50 +0000
Message-Id: <20230911015052.72975-2-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230911015052.72975-1-hengqi.chen@gmail.com>
References: <20230911015052.72975-1-hengqi.chen@gmail.com>
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

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
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



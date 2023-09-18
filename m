Return-Path: <bpf+bounces-10246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8609C7A409B
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 07:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 442182813F1
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 05:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF922523D;
	Mon, 18 Sep 2023 05:50:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B935228
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 05:50:20 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC445123
	for <bpf@vger.kernel.org>; Sun, 17 Sep 2023 22:50:19 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-69042d398b1so2577334b3a.0
        for <bpf@vger.kernel.org>; Sun, 17 Sep 2023 22:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695016219; x=1695621019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pawMJsOKDgu9Gon7EgpgpCFzh+wr1zlriB6K5y8OzVg=;
        b=YpjoADFBU+ODGiXhV/fpYbMUMHsolxMjlKqh4Ssi6gF9FXmGjXszBtWUXf9MXzu21T
         +OCqlLkQ0O5oJWvH/xzT9R8RarmFLONFsP2xMn0WG69gPu9e2cM0oLGlc/iz6V4MOAJE
         TUrmelghNwMekAZgG0rOBtJf89U74RJXL70iFtAlk529qjdKOm4Xnf7AS3djQj26bVqP
         A/yC3iDD4qbsti6mNx3JlP44ludAHMaeSv5pH4Vc9gyrzojVnIxnuY26b5jgEhL1+xa9
         zoQ9dust7sToZKy280Pl6v4Eta4H0g6KJXHoTh/aYL9ky33LDEfqnEo+grKvgxBD/AKn
         w17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695016219; x=1695621019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pawMJsOKDgu9Gon7EgpgpCFzh+wr1zlriB6K5y8OzVg=;
        b=TdJUNbXX4ikjTf9mBQtTiJXEZ4VZHMkBuTuYnYWAgZkmPMbQQoPvg1W8zCCUNGA8bj
         wJ3JW9gKH8tVplm6jKPIzt5b029oI1xZEGuJEG19plzU6981nUlYF6tANWcn76U5qEg7
         5GVeUFrO/ARA1QbLqr3iwDc8CJLP6NXqkh3H9a37a4ZWrTaANUbG8SnOpYAmvQ5mPbfA
         6FlhfbP4W+2aUsrGkuxdjK2/Kh3TfWmUNAXPTZ3qixCXJ5C51sOz30idOCYZMS2CCsZP
         ElI6VVVtWXnZHia9uwxzSyRNDDv+cc2V2T+EviNRgrzg7UcFHYKzXK9+dMvwApG75pRP
         3oxw==
X-Gm-Message-State: AOJu0Yy2n6TzV20tWTr5i6e/rXPcENSDNcNvimCvJmJXgOB9Eg/BEqOT
	19Cc46eQyomiKo6zE+nePNCvC7Y24hmu3A==
X-Google-Smtp-Source: AGHT+IFPvFGpyeuvHSvOJwfWt1DgSY2fsP/0dYTsY8FxXWVvbmTzqx1l0H/HbApO23If9hiEAaIAbw==
X-Received: by 2002:a05:6a00:2d1a:b0:690:38b6:b2db with SMTP id fa26-20020a056a002d1a00b0069038b6b2dbmr9820491pfb.6.1695016218899;
        Sun, 17 Sep 2023 22:50:18 -0700 (PDT)
Received: from ubuntu.. ([203.205.141.25])
        by smtp.googlemail.com with ESMTPSA id i15-20020aa787cf000000b006877a17b578sm6374496pfo.40.2023.09.17.22.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 22:50:18 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alan.maguire@oracle.com,
	olsajiri@gmail.com,
	hengqi.chen@gmail.com,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH bpf-next v4 1/3] libbpf: Resolve symbol conflicts at the same offset for uprobe
Date: Mon, 18 Sep 2023 02:48:11 +0000
Message-Id: <20230918024813.237475-2-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918024813.237475-1-hengqi.chen@gmail.com>
References: <20230918024813.237475-1-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
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



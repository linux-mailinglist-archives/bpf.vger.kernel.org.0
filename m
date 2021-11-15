Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA08451D7C
	for <lists+bpf@lfdr.de>; Tue, 16 Nov 2021 01:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348857AbhKPAag (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Nov 2021 19:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238597AbhKOTaN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Nov 2021 14:30:13 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE1FC061224
        for <bpf@vger.kernel.org>; Mon, 15 Nov 2021 11:18:56 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id fv9-20020a17090b0e8900b001a6a5ab1392so686153pjb.1
        for <bpf@vger.kernel.org>; Mon, 15 Nov 2021 11:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PB5GUFs5f+m2nVEY35YykB5F9U2TeFXf/TB4jp9nzJQ=;
        b=D7VdecOC+cJezG5p7C6xtYxueS6mvn4xFOVUnK+jnReCLBdCMsVGba+ON3vqoh6vgJ
         kQUkZ24fwyN5t1uoL0+0s32hLF7sZ8dAimaj+ic3iqcsJzUhY1lJ3if35chqYD9scF/m
         9E3Hu6tpb/Fu2Tn67srFFdPPSOCzlTQZIzuzmlHPaF2GV3B7cbTag94PpeHyjvcun5vn
         mloVDrIq6X/HbqKtWwtBACsWPGxIcGpZ8eLQJrUwTdc0zhTsquislclyEQnh/lowWTKt
         2ZcBFPChmUgt3k0JOZ3kFBFXYR+Z0vCi7I0x7RdJMNDAo4B/ZpkIPvzLEG1gzU8/eoeQ
         2p5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PB5GUFs5f+m2nVEY35YykB5F9U2TeFXf/TB4jp9nzJQ=;
        b=GEYoup5iju0gNC3xFi5IV3Y371opczRe8t0tM97xuHvT8fSRqJLqTxt0tHifGKQdFF
         bQxRp3SwqPhMAJy/+HE8q2xau76BszHfuHN6MhENZc0088GBBUST8NoL4qns282MBpHt
         V8xUIOJCZqUZ6oBYpon6QYiQLZDlFhc7m6O56lgCIiZM7wT4DcAlsBriteTZkLFVJQec
         Nqv97PGu2/FFP7XoaddEoBmeqt42R9XEjaK19vqTq8tfoaznxe4GntD24M5Nf7G+2Xiu
         Vt6mL0trvObC4HBQNj/FkrmW9jq12Ob/toG/C8tTDVEI3hddtmpcQUc2OBgqhHGzqUUw
         PzDQ==
X-Gm-Message-State: AOAM532wqORiVhBoP59lJA8SgKyEC5ytIMYkWu696H8x4dBBQobC3tmL
        A6agzCXSRdf3yDb7GEBeA2lDh87R+Ms=
X-Google-Smtp-Source: ABdhPJwBy7ClxT6uoose4uzZr8owAW0WASdoKYcT8ko2VHi7Bf5iCHEaauHD7ldxMx61LXYM8aRlqg==
X-Received: by 2002:a17:90a:e506:: with SMTP id t6mr1102891pjy.9.1637003935676;
        Mon, 15 Nov 2021 11:18:55 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:502e:73f4:8af1:9522])
        by smtp.gmail.com with ESMTPSA id on6sm111462pjb.47.2021.11.15.11.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 11:18:55 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Pavel Skripkin <paskripkin@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf v1 3/3] tools/resolve_btfids: Demote unresolved symbol message to debug
Date:   Tue, 16 Nov 2021 00:48:40 +0530
Message-Id: <20211115191840.496263-4-memxor@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211115191840.496263-1-memxor@gmail.com>
References: <20211115191840.496263-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1208; h=from:subject; bh=5zKu8YbLk2/tQC2/IPEz36iS/1TQBcHMJEOqg0OClAg=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBhkrI2thqzTsu5si1jp+oNh+7smaM+3APoRJnr2xPo JqmtIDOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYZKyNgAKCRBM4MiGSL8RyhjvD/ 0e6eYj7iw1u2n2ywhjs6AK8S6qBd+Sq+EHRv/+2XNivrMU5Q69e7QfbmWJmZvO6wUpBrqyWulJm7b+ X0wG//hEEqDDwlfqd7+oUJaRz0QsCdCkPHFhFRBubpDgCwF9vmcS/gt6YJA7cyBgmmeimFZk1j2q8+ n8S/YfZd9kbbmQ+NZENE4+3j5j7SwIoRZP3Ddl2V0IyTl3QzdhUKKDBcmn5ULinAowMYAdEM4F6F3v ztKoGfWApWLBAiEWO9HC273fttV84YLzL+Tbpq4YX/c+oOxsB/9Q8iEh+oQTL+vyx3bF+zlQ2thgng 289thkOlegbAogv/W2a4ekFpRE3hwdUoRgyfuQef4pM8oeBrtNIM5bhfNxR7gGv8nZ+vi4en6DrOMt vNrmhPvu7Z9C3ImI1lkIWu+Un2PgP652c326fcLfJsIFoZa5cqLF3apZT8RYIJ3Q2+is4y6fRPsv3b EXsQ2FlA3UWXZr2dSHJ0KgrgzOo26FR99ZDyDCr2EwciccB/3FLPVr4IuFahiTMMp9ms0YTZh460bl /Nz3KnYQMnSGETxXeCRSDUzLoy0PBVARPd9h+XFwq6v/BtS597GZcT+SfXpuyKfEgqems0ENsrtR0Q YOmNqDWown5eR99gPXb7toktT4cZEyvS9cfsoGzDxrWLFGQ/0VVgM0h1O72A==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

resolve_btfids prints a warning when it finds an unresolved symbol,
(id == 0) in id_patch. This can be the case for BTF sets that are empty
(due to disabled config options), hence printing warnings for certain
builds, most recently seen in [0]. Hence, demote the warning to debug
log level to avoid build time noise.

  [0]: https://lore.kernel.org/all/1b99ae14-abb4-d18f-cc6a-d7e523b25542@gmail.com

Fixes: 0e32dfc80bae ("bpf: Enable TCP congestion control kfunc from modules")
Reported-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/bpf/resolve_btfids/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index a59cb0ee609c..833bfcc9ccf6 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -569,7 +569,7 @@ static int id_patch(struct object *obj, struct btf_id *id)
 	int i;
 
 	if (!id->id) {
-		pr_err("WARN: resolve_btfids: unresolved symbol %s\n", id->name);
+		pr_debug("WARN: resolve_btfids: unresolved symbol %s\n", id->name);
 	}
 
 	for (i = 0; i < id->addr_cnt; i++) {
-- 
2.33.1


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F81E41B254
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 16:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241308AbhI1Or3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 10:47:29 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:38622 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241295AbhI1Or3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Sep 2021 10:47:29 -0400
Received: by mail-ed1-f48.google.com with SMTP id dj4so84667011edb.5
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 07:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=SPtSSBmTOBYC7sxQTiWWKjk6kTWqLMhnUvx5+091SpM=;
        b=pmbmA4s6Y/YvGEL+QzzZN7WRYtes8Fo/4ltpEywf77P9mGp+2ZMvgkZJTpNoPkk/FI
         sjFC2dLE89ZTsrX3NMyF3z1LEQ//ZsS/HhPvCIkHwK2+FIgG6ruHXybjFEt5DFFJvTZj
         tgx/sXLm8jUkGsoX+L2rNxSdFAngjGowCOO1INwaxd0FZKDoy+ZT/SEcFbxNhCyVv4gY
         BokUh5vKfn0Cikc8oeXJokKdSlPAbW9KKuKZTU9pat7WiC0a1nMwYiVWKQ068T7Ti3HJ
         uUAuaWy2Yd5IZJRrjtIj3GUIYAysSzXTMKC4dFOqiQFEYn4dUEi0zaEwBSli4vv/YGS1
         qnqg==
X-Gm-Message-State: AOAM531kwzRA9MLzhiTtK/Z++WKWrvqEGj+wlbQEqjNjHBlaitlVQ408
        LiARBGsEyREXLqXMOvTGgW4=
X-Google-Smtp-Source: ABdhPJzJB3n145etHtYtPgYhjWhyAjFvBzFaBgA/PbKtBVf2s2cnZrxAjBFhm5xCoAzmfq1Ho21rKQ==
X-Received: by 2002:a17:907:2064:: with SMTP id qp4mr7190905ejb.317.1632840320496;
        Tue, 28 Sep 2021 07:45:20 -0700 (PDT)
Received: from localhost (mob-31-159-58-194.net.vodafone.it. [31.159.58.194])
        by smtp.gmail.com with ESMTPSA id bd2sm5259064edb.65.2021.09.28.07.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 07:45:19 -0700 (PDT)
Date:   Tue, 28 Sep 2021 16:45:15 +0200
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        john.fastabend@gmail.com, lmb@cloudflare.com, mcroce@microsoft.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH RFC bpf-next 01/10] bpf: Prepare relo_core.c for kernel
 duty.
Message-ID: <20210928164515.46fad888@linux.microsoft.com>
In-Reply-To: <20210917215721.43491-2-alexei.starovoitov@gmail.com>
References: <20210917215721.43491-1-alexei.starovoitov@gmail.com>
        <20210917215721.43491-2-alexei.starovoitov@gmail.com>
Organization: Microsoft
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 17 Sep 2021 14:57:12 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> From: Alexei Starovoitov <ast@kernel.org>
> 
> Make relo_core.c to be compiled with kernel and with libbpf.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

I give it a try with a sample co-re program.
I don't know how much of them will stay in the final work, but the
debug prints are borked because of the printk trailing \n.
I managed to get a decent output like:

[   36.154379] libbpf: prog 'prog_name': relo #0: kind <byte_off> (0), spec is [24] STRUCT net_device.ifindex (0:17 @ offset 208)
[   36.154399] libbpf: prog 'prog_name': relo #0: matching candidate #0 [2617] STRUCT net_device.ifindex (0:17 @ offset 208)
[   36.154524] libbpf: prog 'prog_name': relo #0: patched insn #0 (LDX/ST/STX) off 208 -> 208
[   36.155319] libbpf: prog 'prog_name': relo #0: kind <byte_off> (0), spec is [24] STRUCT net_device.ifindex (0:17 @ offset 208)

With this change:

--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -79,6 +79,9 @@ do {				\
 #include "btf.h"
 #include "str_error.h"
 #include "libbpf_internal.h"
+
+#define KERN_CONT
+
 #endif
 
 #define BPF_CORE_SPEC_MAX_LEN 32
@@ -1125,7 +1128,7 @@ static void bpf_core_dump_spec(int level, const struct bpf_core_spec *spec)
 	t = btf__type_by_id(spec->btf, type_id);
 	s = btf__name_by_offset(spec->btf, t->name_off);
 
-	libbpf_print(level, "[%u] %s %s", type_id, btf_kind_str(t), str_is_empty(s) ? "<anon>" : s);
+	libbpf_print(level, KERN_CONT "[%u] %s %s", type_id, btf_kind_str(t), str_is_empty(s) ? "<anon>" : s);
 
 	if (core_relo_is_type_based(spec->relo_kind))
 		return;
@@ -1135,29 +1138,33 @@ static void bpf_core_dump_spec(int level, const struct bpf_core_spec *spec)
 		e = btf_enum(t) + spec->raw_spec[0];
 		s = btf__name_by_offset(spec->btf, e->name_off);
 
-		libbpf_print(level, "::%s = %u", s, e->val);
+		libbpf_print(level, KERN_CONT "::%s = %u", s, e->val);
 		return;
 	}
 
 	if (core_relo_is_field_based(spec->relo_kind)) {
 		for (i = 0; i < spec->len; i++) {
 			if (spec->spec[i].name)
-				libbpf_print(level, ".%s", spec->spec[i].name);
+				libbpf_print(level, KERN_CONT ".%s", spec->spec[i].name);
 			else if (i > 0 || spec->spec[i].idx > 0)
-				libbpf_print(level, "[%u]", spec->spec[i].idx);
+				libbpf_print(level, KERN_CONT "[%u]", spec->spec[i].idx);
 		}
 
-		libbpf_print(level, " (");
+		libbpf_print(level, KERN_CONT " (");
 		for (i = 0; i < spec->raw_len; i++)
-			libbpf_print(level, "%s%d", i == 0 ? "" : ":", spec->raw_spec[i]);
+			libbpf_print(level, KERN_CONT "%s%d", i == 0 ? "" : ":", spec->raw_spec[i]);
 
 		if (spec->bit_offset % 8)
-			libbpf_print(level, " @ offset %u.%u)",
+			libbpf_print(level, KERN_CONT " @ offset %u.%u)",
 				     spec->bit_offset / 8, spec->bit_offset % 8);
 		else
-			libbpf_print(level, " @ offset %u)", spec->bit_offset / 8);
+			libbpf_print(level, KERN_CONT " @ offset %u)", spec->bit_offset / 8);
 		return;
 	}
+
+#ifndef RELO_CORE
+	libbpf_print(level, KERN_CONT "\n");
+#endif
 }
 
 /*
@@ -1250,7 +1257,6 @@ int bpf_core_apply_relo_insn(const char *prog_name, struct bpf_insn *insn,
 	pr_debug("prog '%s': relo #%d: kind <%s> (%d), spec is ", prog_name,
 		 relo_idx, core_relo_kind_str(relo->kind), relo->kind);
 	bpf_core_dump_spec(LIBBPF_DEBUG, &local_spec);
-	libbpf_print(LIBBPF_DEBUG, "\n");
 
 	/* TYPE_ID_LOCAL relo is special and doesn't need candidate search */
 	if (relo->kind == BPF_CORE_TYPE_ID_LOCAL) {
@@ -1283,7 +1289,6 @@ int bpf_core_apply_relo_insn(const char *prog_name, struct bpf_insn *insn,
 		pr_debug("prog '%s': relo #%d: %s candidate #%d ", prog_name,
 			 relo_idx, err == 0 ? "non-matching" : "matching", i);
 		bpf_core_dump_spec(LIBBPF_DEBUG, &cand_spec);
-		libbpf_print(LIBBPF_DEBUG, "\n");
 
 		if (err == 0)
 			continue;


Regards,
-- 
per aspera ad upstream

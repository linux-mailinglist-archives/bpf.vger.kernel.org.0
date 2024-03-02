Return-Path: <bpf+bounces-23221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 609F486EDCD
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 02:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0E3CB23BBD
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 01:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A978F41;
	Sat,  2 Mar 2024 01:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9FgWaU/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2880379F0
	for <bpf@vger.kernel.org>; Sat,  2 Mar 2024 01:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709342387; cv=none; b=R91/TIkC6+5WbdN/yGthq7UG87Zd5sifH4yynPwQRHhNvu/qaF5R92oPaIGaDlG0t14dvuiTnEPiu5CQ6x56OEB2hunn/bcDaLI0K8GOVrPd6niq5SaIWz4oS/PKEiZYZs4CPcIVFbk/C8icsxNnTh5n97aTZepNFOSz8WQMD7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709342387; c=relaxed/simple;
	bh=nUkIQZPM3LRiGOpMWExTB9RP1/yUYZ9tgkvLPZ1fzy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o1q9B0eoUzaNX1ImY2qOWGaGtDeTL7QfxTCPNk6w68zsRCdUKkOfMoLyIoyGPvAYeO3fFU4FlqXdVI9RasAqzzFCqDxVIap3VVxjjwvBbx2wxopiNEKbXE2pApQ4hEvx4OnjuRM4/6kYkKiKKstEgySH7SkIKwW/j5GPHoLyR04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9FgWaU/; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d180d6bd32so29835701fa.1
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 17:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709342384; x=1709947184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UhUPWk3UjTaTqNBC5ATm8e8X0DkmyV8N6srirKnp6dA=;
        b=j9FgWaU/OSuJkGpZbmLwm3Hn5NCg4xCyds6hWfagJQXWNVWtdD756IfacCDZLfMrvv
         ZC6z15CEbyTopTqUsIfCkiuMfZVMTIDc5MorYT1lRJIb1IlI78WFzKEfZL/8+QKU88N2
         TKcmYPRjuod0vE1RjYNczc197G7IgXG1FwYkPBri8eGPA98ckIKcB8VZUZ7iiFn0pL+X
         2+nPFnK7J94ONovZnOEdnDxJ9H6VLZePKBq02GFDWQZ7ypN9PJ6Fs209AXVaCJIdL0ju
         pq0Uni3ws6z6YwN/Z5V+gQAZ04kgmusNlcraMfqR0wQeU3hMoj9kwngn86nFdQX1biIU
         Obzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709342384; x=1709947184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UhUPWk3UjTaTqNBC5ATm8e8X0DkmyV8N6srirKnp6dA=;
        b=SVb3u1jzI2aA2aSpdbJz/TqLSsHYasaZphfkpzQ9CsVyJaO7xB668dtYbtHMGaKZoh
         bAi/KAgZc32FV6UMrc2C8yZVnq9HAYDeJUEtR48BJ/7ev35kngrSI/UlYdlbbLvOk3mS
         HAFQ3kI3KqIsHGVKG4yZgl4zqpnfVP5RatOVoM1qOYPj5TCJJmjsepU79H9HybLWx+IL
         yCIj9e6Y4c1sex5JnnjMadH+RMoUHYIk7F53EUkCMOjeVqKz1gx70TiA16FYPXwsvAlA
         ga2tcyj3d73VHhlm7ilaGWWpApjfpFH7mpAJZud82HtXgX4bWQP3rIHaYm9vy0p6IKpW
         S6HQ==
X-Gm-Message-State: AOJu0YwknMNt8GHD7wp+DG/CVXDWd65tEWsXSZar5koQwVaPaf7Y9y5Y
	mAh8y40R3TRHPcWXeqnMhpLK+NVCV/fZPDcvPsynr1VffqdZ0xtaF4vUyyxK
X-Google-Smtp-Source: AGHT+IGkRas/ZZxHpXWvGAcqywiEbP/UR9GQnRcD5Vlw20dVo4g4OtEAZuT+cYmbQzEn7Hg4YEw1pQ==
X-Received: by 2002:a2e:9959:0:b0:2d2:650f:9587 with SMTP id r25-20020a2e9959000000b002d2650f9587mr2623042ljj.13.1709342383996;
        Fri, 01 Mar 2024 17:19:43 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z23-20020a2e9657000000b002d295828d3fsm767386ljh.9.2024.03.01.17.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 17:19:43 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	void@manifault.com,
	sinquersw@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 08/15] libbpf: sync progs autoload with maps autocreate for struct_ops maps
Date: Sat,  2 Mar 2024 03:19:13 +0200
Message-ID: <20240302011920.15302-9-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240302011920.15302-1-eddyz87@gmail.com>
References: <20240302011920.15302-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Automatically select which struct_ops programs to load depending on
which struct_ops maps are selected for automatic creation.
E.g. for the BPF code below:

    SEC("struct_ops/test_1") int BPF_PROG(foo) { ... }
    SEC("struct_ops/test_2") int BPF_PROG(bar) { ... }

    SEC(".struct_ops.link")
    struct test_ops___v1 A = {
        .foo = (void *)foo
    };

    SEC(".struct_ops.link")
    struct test_ops___v2 B = {
        .foo = (void *)foo,
        .bar = (void *)bar,
    };

And the following libbpf API calls:

    bpf_map__set_autocreate(skel->maps.A, true);
    bpf_map__set_autocreate(skel->maps.B, false);

The autoload would be enabled for program 'foo' and disabled for
program 'bar'.

To achieve this:
- for struct_ops programs referenced from struct_ops maps set autoload
  property at open() to false;
- when creating struct_ops maps set autoload property of referenced
  programs to true.

(Note: struct_ops programs not referenced from any map would have
 their autoload property set to true by default.
 If attach_btf_id and expected_attach_type properties would not be
 specified for such programs manually, the load phase would fail).

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/libbpf.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 25c452c20d7d..60d78badfc71 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1151,6 +1151,7 @@ static int bpf_map__init_kern_struct_ops(struct bpf_map *map)
 			 * attach_btf_id and member_idx
 			 */
 			if (!prog->attach_btf_id) {
+				prog->autoload = true;
 				prog->attach_btf_id = kern_type_id;
 				prog->expected_attach_type = kern_member_idx;
 			}
@@ -3187,6 +3188,11 @@ static bool obj_needs_vmlinux_btf(const struct bpf_object *obj)
 	}
 
 	bpf_object__for_each_program(prog, obj) {
+		/* Note: struct_ops programs referenced from struct_ops maps
+		 * would have their autoload reset to false after open(),
+		 * but that is fine as corresponding map would trigger
+		 * "needs_vmlinux_btf" anyways.
+		 */
 		if (!prog->autoload)
 			continue;
 		if (prog_needs_vmlinux_btf(prog))
@@ -9452,6 +9458,12 @@ static int bpf_object__collect_st_ops_relos(struct bpf_object *obj,
 			return -EINVAL;
 		}
 
+		/* struct_ops programs autoload is computed depending
+		 * on autocreate property of corresponding maps,
+		 * see bpf_map__init_kern_struct_ops().
+		 */
+		prog->autoload = false;
+
 		st_ops->progs[member_idx] = prog;
 
 		/* st_ops->data will be exposed to users, being returned by
-- 
2.43.0



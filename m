Return-Path: <bpf+bounces-11118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EA17B3767
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 18:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 2228DB20B4B
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 16:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2C3521C2;
	Fri, 29 Sep 2023 16:00:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CF8521B8
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 16:00:48 +0000 (UTC)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B6A195
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 09:00:47 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-277504a23a1so636756a91.0
        for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 09:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696003247; x=1696608047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6eh/EJKqdsqol1mjtuJz+fNwEXURq/P9nWsmSEQk+Wo=;
        b=HtLEYKnfc3dcoZCBHBVhwNT34SjuVG4aB4yQolg6uOmn3vzVtfcLw2ESFHyI7U141C
         dNdnr3120FQ8ClOl6OladGQfRIVMQLsgGeqmPfYjruaNyAjjtYE5Ne9SNWdFcXTTOdnI
         4H5x5Kt9RaYRkkhhbezDhWP0kU5ubUnXbzsA1QQ4NRjXm4c2mu9+z2wD+BO9Y+iZ93NP
         S7H1ASXCEIQ9IbqEiRfHOy6m8C+xiyRwJy4kkGSzVaPREpi4av+7WxcwjK8OJmlzrnZ2
         ZEEAt2pMnI79lwjSsW08+mr9y+pVDX/Ff72Anlo2y/iUj8gvcHlMvBd7yhLxEpbINF0I
         2nQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696003247; x=1696608047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6eh/EJKqdsqol1mjtuJz+fNwEXURq/P9nWsmSEQk+Wo=;
        b=Z4NSrWwLeYz4A64qdfSFsDKTkBbwTgxPGi5gDsVEzEOrJfeEKhbUPDs1XE4RR6guPa
         VbbGSOroAvZeNMAxbBOgQ4GaJ6lkGlVb6YoxjIOamMD8vJCAyoxEUqzVQAcm2enSfCX0
         Ex71iwviNRzZ62XzBQXNzmlYVabqyjWYogvxDVImvUQTcYvMgJHa36uV5jSN/tLK+m6o
         BclHfHdqdAnEHGkqf+fauX3FHLuH20eT1gYGOb13A6uus4KSPjr86omzwnnMefL1WBLT
         RcwuIvUoTO2N7Rqkl3tkoQhS2UPKpMkOvbn7ieHYD0oKDtyAMAWpM2mBdNRhF9B6oyH6
         rMyg==
X-Gm-Message-State: AOJu0YyeP/QFquJDFVkAGT4B13dqPxmeJbN3WKX0g8Vh9pv8uaSVWXkJ
	BuxkfmbDNZ8TyLjz/mNzxTNvVxq/3KKjh3up
X-Google-Smtp-Source: AGHT+IFWoua2O8QmhvU2O2wXJwfSXGyl1wdOALGcZJUn+9toFVNt1xmyWd/KirHXlbkkoIN45a2TVg==
X-Received: by 2002:a17:90b:1498:b0:26d:49a0:2071 with SMTP id js24-20020a17090b149800b0026d49a02071mr7208218pjb.13.1696003246468;
        Fri, 29 Sep 2023 09:00:46 -0700 (PDT)
Received: from ubuntu.. ([113.64.186.166])
        by smtp.googlemail.com with ESMTPSA id gt15-20020a17090af2cf00b0026d6ad176c6sm1935306pjb.0.2023.09.29.09.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 09:00:46 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	olsajiri@gmail.com,
	hengqi.chen@gmail.com,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH bpf-next v2] libbpf: Allow Golang symbols in uprobe secdef
Date: Fri, 29 Sep 2023 15:59:54 +0000
Message-Id: <20230929155954.92448-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Golang symbols in ELF files are different from C/C++
which contains special characters like '*', '(' and ')'.
With generics, things get more complicated, there are
symbols like:

  github.com/cilium/ebpf/internal.(*Deque[go.shape.interface { Format(fm
  t.State, int32); TypeName() string;github.com/cilium/ebpf/btf.copy() g
  ithub.com/cilium/ebpf/btf.Type}]).Grow

Matching such symbols using `%m[^\n]` in sscanf, this
excludes newline which typically does not appear in ELF
symbols. This should work in most use-cases and also
work for unicode letters in identifiers. If newline do
show up in ELF symbols, users can still attach to such
symbol by specifying bpf_uprobe_opts::func_name.

A working example can be found at this repo ([0]).

  [0]: https://github.com/chenhengqi/libbpf-go-symbols

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/lib/bpf/libbpf.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b4758e54a815..31b8b252e614 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11114,7 +11114,7 @@ static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, stru
 
 	*link = NULL;
 
-	n = sscanf(prog->sec_name, "%m[^/]/%m[^:]:%ms",
+	n = sscanf(prog->sec_name, "%m[^/]/%m[^:]:%m[^\n]",
 		   &probe_type, &binary_path, &func_name);
 	switch (n) {
 	case 1:
@@ -11624,14 +11624,14 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 static int attach_uprobe(const struct bpf_program *prog, long cookie, struct bpf_link **link)
 {
 	DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, opts);
-	char *probe_type = NULL, *binary_path = NULL, *func_name = NULL;
-	int n, ret = -EINVAL;
+	char *probe_type = NULL, *binary_path = NULL, *func_name = NULL, *func_off;
+	int n, c, ret = -EINVAL;
 	long offset = 0;
 
 	*link = NULL;
 
-	n = sscanf(prog->sec_name, "%m[^/]/%m[^:]:%m[a-zA-Z0-9_.@]+%li",
-		   &probe_type, &binary_path, &func_name, &offset);
+	n = sscanf(prog->sec_name, "%m[^/]/%m[^:]:%m[^\n]",
+		   &probe_type, &binary_path, &func_name);
 	switch (n) {
 	case 1:
 		/* handle SEC("u[ret]probe") - format is valid, but auto-attach is impossible. */
@@ -11642,7 +11642,17 @@ static int attach_uprobe(const struct bpf_program *prog, long cookie, struct bpf
 			prog->name, prog->sec_name);
 		break;
 	case 3:
-	case 4:
+		/* check if user specifies `+offset`, if yes, this should be
+		 * the last part of the string, make sure sscanf read to EOL
+		 */
+		func_off = strrchr(func_name, '+');
+		if (func_off) {
+			n = sscanf(func_off, "+%li%n", &offset, &c);
+			if (n == 1 && *(func_off + c) == '\0')
+				func_off[0] = '\0';
+			else
+				offset = 0;
+		}
 		opts.retprobe = strcmp(probe_type, "uretprobe") == 0 ||
 				strcmp(probe_type, "uretprobe.s") == 0;
 		if (opts.retprobe && offset != 0) {
-- 
2.34.1



Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57802584B9A
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 08:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbiG2GSg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 02:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234550AbiG2GSf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 02:18:35 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB97AA452
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 23:18:32 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id l193so2879414pge.9
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 23:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0SYg0CTxdwa1b3hUISLWI5spIJadhH+yWV2oUsW7H0k=;
        b=nIy5g3hPzw0IEY6ETGoF94L/ngfNubfdK1gUkExwcE1Y9xNcbgbZzAteBWJ+2YuRJ3
         wztaV8yLc/GJrpIr6RhmQfFZI+Jn6QckKekVc0C/NGOeGW6K6CW7YCab6tZRYV+JStC3
         Pnp/c/qnI3zGrizyKgtmv4TbspqMvZmy7B5iyXqNFodn0zs+Flql5eIp8jmjJ8VRqi3b
         mnHXtVniePUqdapfizkLOv85NzkOZ6vljgo+GGikclC3s5w/kH0qHzUuIjq5O6lnNpb+
         IIIuylt9zX0TUjSWp9FJ1g/nxicaR4WN3Pz8JKyz6gDokrnZSmnmBoliIBXTA+5b+1AM
         xbNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0SYg0CTxdwa1b3hUISLWI5spIJadhH+yWV2oUsW7H0k=;
        b=ice2LtK+74YMEfOlNjP4VQi5oG8DbnzUga+YACZMDdXkZzae9MDTUwetR/txTFyTJv
         J4x0TABD62l1S2PbQuwXtkWD4Jrq+rygjECeN2UxTri/dApEUEpRRApALvRKH+0l5Uiy
         Otifyn5ZU/3IAwDFPcDekJ3bzdoyz9XsK+PHpJS0J4+ANW6Q1FE++85jVRAZPeQQe+jJ
         IGnz/4mieDMA1tnZcw4JdBkaBXGZwEoGMey7m0RJRqjfaVZPOgxDkCCDJkM9l/OCQsw+
         R6fU6S6O2Xuedoq7gbcDDB3vWRm2nI8Y+4r6JwBvHhOgR0o3IVUgvU0ElJJyTVoquG+l
         /UBg==
X-Gm-Message-State: AJIora/ce12OxPNFrpA6TIoZF6zbfgSDTVDk3+gvZqfDe6KnyuTk08Fj
        xPtKY6nKla9pOK/AbG3050bsS2vcLLY=
X-Google-Smtp-Source: AGRyM1sSdbUj6SQcLA8/dMIDNXSNUDCVVDY8IjlBjaAbYX06vD+0RVJPgLDza5Lh41rCasy+8TWHVw==
X-Received: by 2002:a62:140e:0:b0:52b:780d:fb9d with SMTP id 14-20020a62140e000000b0052b780dfb9dmr2322335pfu.65.1659075511781;
        Thu, 28 Jul 2022 23:18:31 -0700 (PDT)
Received: from localhost (fwdproxy-prn-116.fbsv.net. [2a03:2880:ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id u11-20020a17090341cb00b0016d9d6d05f7sm2513424ple.273.2022.07.28.23.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 23:18:31 -0700 (PDT)
From:   Manu Bretelle <chantr4@gmail.com>
To:     bpf@vger.kernel.org, andrii@kernel.org, quentin@isovalent.com
Subject: [PATCH bpf-next] remove BPF_OBJ_NAME_LEN restriction when looking up bpf program by name
Date:   Thu, 28 Jul 2022 23:18:17 -0700
Message-Id: <20220729061817.126062-1-chantr4@gmail.com>
X-Mailer: git-send-email 2.30.2
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

From: chantra <chantr4@gmail.com>

bpftool was limiting the length of names to
[BPF_OBJ_NAME_LEN](https://github.com/libbpf/bpftool/blob/2d7bba1e8c17dd0422879c856cda66723b209952/src/common.c#L823-L826).

Since
https://github.com/libbpf/bpftool/commit/61833a284f48b90f6802c141c8356de64bb41e10
we can get the full program name from BTF.

This diffs remove the restriction of name length when running `bpftool
prog show name ${name}`.

Test:
Tested against some internal program names that were longer than
`BPF_OBJ_NAME_LEN`, here a redacted example of what was ran to test.

```
$ sudo bpftool prog show name some_long_program_name
Error: can't parse name
$ sudo ./bpftool prog show name some_long_program_name
123456789: tracing  name some_long_program_name  tag taghexa  gpl ....
...
...
...
```
---
 tools/bpf/bpftool/common.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index 067e9ea59e3b..bc9017877296 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -722,6 +722,7 @@ print_all_levels(__maybe_unused enum libbpf_print_level level,
 
 static int prog_fd_by_nametag(void *nametag, int **fds, bool tag)
 {
+	char prog_name[MAX_PROG_FULL_NAME];
 	unsigned int id = 0;
 	int fd, nb_fds = 0;
 	void *tmp;
@@ -754,12 +755,21 @@ static int prog_fd_by_nametag(void *nametag, int **fds, bool tag)
 			goto err_close_fd;
 		}
 
-		if ((tag && memcmp(nametag, info.tag, BPF_TAG_SIZE)) ||
-		    (!tag && strncmp(nametag, info.name, BPF_OBJ_NAME_LEN))) {
+		if (tag && memcmp(nametag, info.tag, BPF_TAG_SIZE)) {
 			close(fd);
 			continue;
 		}
 
+
+
+		if (!tag) {
+			get_prog_full_name(&info, fd, prog_name, sizeof(prog_name));
+			if (strcmp(nametag, prog_name)) {
+				close(fd);
+				continue;
+			}
+		}
+
 		if (nb_fds > 0) {
 			tmp = realloc(*fds, (nb_fds + 1) * sizeof(int));
 			if (!tmp) {
@@ -820,10 +830,6 @@ int prog_parse_fds(int *argc, char ***argv, int **fds)
 		NEXT_ARGP();
 
 		name = **argv;
-		if (strlen(name) > BPF_OBJ_NAME_LEN - 1) {
-			p_err("can't parse name");
-			return -1;
-		}
 		NEXT_ARGP();
 
 		return prog_fd_by_nametag(name, fds, false);
-- 
2.30.2


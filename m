Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92EE586BE1
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 15:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbiHANY0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 09:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiHANYY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 09:24:24 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437903206A
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 06:24:23 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id d65-20020a17090a6f4700b001f303a97b14so12003989pjk.1
        for <bpf@vger.kernel.org>; Mon, 01 Aug 2022 06:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JLo+cqdChzkSZzadSGSQzj47WRgl4h2edDVULDweSVo=;
        b=B4+9+17XbZmThjycCerE7/KbK3Q7ac5D8m77f9aqLua7lyIhXLIUUB+wXvWMFFydLO
         j79m6//gxKVtYxkzz3r1Ib8jpBOuWWDONX7pkTFNAQzHclVm8RlIIH1sKH1BCT7SV/2Z
         TFZ42iMd+aTqEKYdN0sKpRyyCHM20PQ3/CXgq8avyjUAiyjIAMwPRVB0n0ApbnTfXGJ1
         tc3x7zOVwNZZLDUk84hm1QQDvcFnPnjkUIfHDlM4IqO8LRgmMpa2qGJnyyCC41TsSeKR
         qXh23D+N7Pw6tExYPgDf4vtgm/V18C7TXR8xYPgLkbonF5yj+ZKjBycr5uZyTVMgZrAx
         gReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JLo+cqdChzkSZzadSGSQzj47WRgl4h2edDVULDweSVo=;
        b=HqguVKK8Ua9X+5NmfIQe1iG7sHfTGd1N5nvhblQdZUX2oWK163AbvsjAqm2N2NblTQ
         3k1sBUuLaL8vcP+KtMpPcPpT6p1N69T5A4NYIvHUqVLHXyLGZ2gsTCmyr08mPd8i3oti
         MKwZwRC7wp4kx8EYvgoKI7trfjPsHql1qgK3RN7kxn2wxpBxVjzQ+otd9y0BttqJVvDv
         LbDnftXMWU82v+BcXLrjugL51o6mRJBVVofrlqco8b4CSlgXyTWEix2hGQC6sthp6HqS
         e6zDj9p1In8EXr7Pal70KfroCQb5Z4PQ92TREVXDXY8bW2Ry3r/JCrYAkKMXQ74lHSdJ
         nN1Q==
X-Gm-Message-State: ACgBeo0U+eyP/nl5EwfJHnMRC6yJKotJIkkSGtfEJN4wecIaWs780kbJ
        dY+yI140U+kYeRq7nNGVV5O/RmPTIYw=
X-Google-Smtp-Source: AA6agR42Dv0NEzPLyS6t3VGDgJnGtNT8MxWTAZF8O89dEn6OIgcYbDYUzA5r7s7T0qKBPc36YqvcRg==
X-Received: by 2002:a17:90b:3b49:b0:1f4:df09:d671 with SMTP id ot9-20020a17090b3b4900b001f4df09d671mr11123718pjb.129.1659360262156;
        Mon, 01 Aug 2022 06:24:22 -0700 (PDT)
Received: from localhost (fwdproxy-prn-118.fbsv.net. [2a03:2880:ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id g18-20020aa79dd2000000b0052d4ffac466sm1369194pfq.188.2022.08.01.06.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 06:24:21 -0700 (PDT)
From:   Manu Bretelle <chantr4@gmail.com>
To:     bpf@vger.kernel.org, andrii@kernel.org, quentin@isovalent.com
Subject: [PATCH bpf-next v3] bpftool: Remove BPF_OBJ_NAME_LEN restriction when looking up bpf program by name
Date:   Mon,  1 Aug 2022 06:24:09 -0700
Message-Id: <20220801132409.4147849-1-chantr4@gmail.com>
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

bpftool was limiting the length of names to BPF_OBJ_NAME_LEN in prog_parse
fds.

Since commit b662000aff84 ("bpftool: Adding support for BTF program names")
we can get the full program name from BTF.

This patch removes the restriction of name length when running `bpftool
prog show name ${name}`.

Test:
Tested against some internal program names that were longer than
`BPF_OBJ_NAME_LEN`, here a redacted example of what was ran to test.

    # previous behaviour
    $ sudo bpftool prog show name some_long_program_name
    Error: can't parse name
    # with the patch
    $ sudo ./bpftool prog show name some_long_program_name
    123456789: tracing  name some_long_program_name  tag taghexa  gpl ....
    ...
    ...
    ...
    # too long
    sudo ./bpftool prog show name $(python3 -c 'print("A"*128)')
    Error: can't parse name
    # not too long but no match
    $ sudo ./bpftool prog show name $(python3 -c 'print("A"*127)')

Signed-off-by: Manu Bretelle <chantr4@gmail.com>

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

---

v1 -> v2:
* Fix commit message to follow patch submission guidelines
* use strncmp instead of strcmp
* reintroduce arg length check against MAX_PROG_FULL_NAME

v2 -> v3:
* Fix alignment with opening parenthesis
---
 tools/bpf/bpftool/common.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index 067e9ea59e3b..8727765add88 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -722,6 +722,7 @@ print_all_levels(__maybe_unused enum libbpf_print_level level,
 
 static int prog_fd_by_nametag(void *nametag, int **fds, bool tag)
 {
+	char prog_name[MAX_PROG_FULL_NAME];
 	unsigned int id = 0;
 	int fd, nb_fds = 0;
 	void *tmp;
@@ -754,12 +755,20 @@ static int prog_fd_by_nametag(void *nametag, int **fds, bool tag)
 			goto err_close_fd;
 		}
 
-		if ((tag && memcmp(nametag, info.tag, BPF_TAG_SIZE)) ||
-		    (!tag && strncmp(nametag, info.name, BPF_OBJ_NAME_LEN))) {
+		if (tag && memcmp(nametag, info.tag, BPF_TAG_SIZE)) {
 			close(fd);
 			continue;
 		}
 
+		if (!tag) {
+			get_prog_full_name(&info, fd, prog_name,
+					   sizeof(prog_name));
+			if (strncmp(nametag, prog_name, sizeof(prog_name))) {
+				close(fd);
+				continue;
+			}
+		}
+
 		if (nb_fds > 0) {
 			tmp = realloc(*fds, (nb_fds + 1) * sizeof(int));
 			if (!tmp) {
@@ -820,7 +829,7 @@ int prog_parse_fds(int *argc, char ***argv, int **fds)
 		NEXT_ARGP();
 
 		name = **argv;
-		if (strlen(name) > BPF_OBJ_NAME_LEN - 1) {
+		if (strlen(name) > MAX_PROG_FULL_NAME - 1) {
 			p_err("can't parse name");
 			return -1;
 		}
-- 
2.30.2


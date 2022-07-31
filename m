Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FB458604C
	for <lists+bpf@lfdr.de>; Sun, 31 Jul 2022 20:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiGaSKv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 31 Jul 2022 14:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiGaSKv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 31 Jul 2022 14:10:51 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD6FA193
        for <bpf@vger.kernel.org>; Sun, 31 Jul 2022 11:10:50 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id x7so8592036pll.7
        for <bpf@vger.kernel.org>; Sun, 31 Jul 2022 11:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1nqfIOdDtwMXR2oqlxfOA/ZiP+LTfGK3RwTusDejpX4=;
        b=BX+nSPY/2TLrpg0311blwi6SOwVn52PCgFr5MNcT2bUfbgK3dTeGDhNfND89MFeRFv
         UjQHNm0GjM9pAYBT911yhLKt6/6whIZFQWAeo2txB3t4cU/ArKKE/vs75oXvE96i0jn/
         jBBagC73UXRBRKsl4f/ci4hbdY3e4wqb75fgUeAEj9DQMRiTqu5eyR0GIQSN94jkJ7qB
         gwCjjT028MYacSkyBw5roJFlxUIi+S1s++7eQoDtc8etgdrPxq4e4Dsesej8W2u/B/ot
         OtbMktzB/tg4faGTZVVSTpiOt3gyvH335oVPLVMhvgL2g6ihKSZnNm5+DWU8JGsnsjR2
         LVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1nqfIOdDtwMXR2oqlxfOA/ZiP+LTfGK3RwTusDejpX4=;
        b=WzkWHeRnVfV6VbZ3ewKd/Eeld1guinTOsBxoFPHphS9jdFgQp6hVO2+UvOnRKm6WIY
         09DgodfSDra/ajEt7csJjfGePkwkbCIQBouPpyaX/FULk1Y7MqtXnB01nbeESGeC9Mrh
         Y3uMAEl1Lhf8d+MRFLWR9Pojo1t2fOfgM80Pk7V9IVqlV2DfnlXJT0VD2gPK/qHXnCh0
         a9LKoHTGUt/cL9vsiDnerS4JuQn1gnBnqN2gMGmDeYulGPPxoGwxZNtWWhR7BTo49m5a
         vEqK295GbhhjQczHIbv1AIu1OfJiFMAZfuOapsSgWoK+Gi2RFjX2GZ19oIxre7a1fp1L
         oZRw==
X-Gm-Message-State: ACgBeo33MvbAgTzSGR0lezr2/QEn0iAXa0bGgDZQ/VoBjOkZ3pHqDMMf
        FVY/hMNB+9yo5lkxccmKRkr4xNnIRqw=
X-Google-Smtp-Source: AA6agR5kSwYf1qjDfW2AkQOxz+z8nbd9hR4lMhXOMLekUmDAa04rHsHBcFW4JtH1ZrrjSd7Jx3p0Kg==
X-Received: by 2002:a17:902:cec6:b0:16e:ec03:ff1 with SMTP id d6-20020a170902cec600b0016eec030ff1mr1645052plg.96.1659291049210;
        Sun, 31 Jul 2022 11:10:49 -0700 (PDT)
Received: from localhost (fwdproxy-prn-027.fbsv.net. [2a03:2880:ff:1b::face:b00c])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b0016c6a6d8967sm7775891plb.83.2022.07.31.11.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 11:10:48 -0700 (PDT)
From:   Manu Bretelle <chantr4@gmail.com>
To:     bpf@vger.kernel.org, andrii@kernel.org, quentin@isovalent.com
Subject: [PATCH bpf-next v2] bpftool: Remove BPF_OBJ_NAME_LEN restriction when looking up bpf program by name
Date:   Sun, 31 Jul 2022 11:10:07 -0700
Message-Id: <20220731181007.3130320-1-chantr4@gmail.com>
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

---

v1 -> v2:
* Fix commit message to follow patch submission guidelines
* use strncmp instead of strcmp
* reintroduce arg length check against MAX_PROG_FULL_NAME


 tools/bpf/bpftool/common.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index 067e9ea59e3b..3ea747b3b194 100644
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
+				sizeof(prog_name));
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


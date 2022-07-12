Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9601572359
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 20:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbiGLSq2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 14:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234302AbiGLSpp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 14:45:45 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C624DC18D;
        Tue, 12 Jul 2022 11:42:41 -0700 (PDT)
Received: from pwmachine.numericable.fr (240.119.92.79.rev.sfr.net [79.92.119.240])
        by linux.microsoft.com (Postfix) with ESMTPSA id C2BDC20B4774;
        Tue, 12 Jul 2022 11:42:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C2BDC20B4774
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1657651360;
        bh=OEY4SCaZOdzoodOggn7g2GbcN708PzYV4oDIBcVzPs8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jO0HxQK9lvP9P+x/pmco0rGE7YwmDMbKnHN9PE/y9aNWLDlBJHjKtN9DcLSmbiT61
         10Pz2tcdcPzN4DyZjYkO9pIfoRR/Waf0csSxLbC6bS8Dhbo9upOeYFkG7IWnbnEhxh
         THDv77/yuDXeTGM8MzAG+uHF64+F2UbfD9SGsgpk=
From:   Francis Laniel <flaniel@linux.microsoft.com>
To:     bpf@vger.kernel.org
Cc:     Francis Laniel <flaniel@linux.microsoft.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH v1 1/1] bpftool: Add generating command to C dumped file.
Date:   Tue, 12 Jul 2022 20:42:25 +0200
Message-Id: <20220712184225.52429-2-flaniel@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712184225.52429-1-flaniel@linux.microsoft.com>
References: <20220712184225.52429-1-flaniel@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This commit adds the following lines to file generated by dump:
/*
 * File generated by bpftool using:
 * bpftool btf dump file /sys/kernel/btf/vmlinux format c
 * DO NOT EDIT.
 */
This warns users to not edit the file and documents the command used to
generate the file.

Signed-off-by: Francis Laniel <flaniel@linux.microsoft.com>
---
 tools/bpf/bpftool/btf.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 7e6accb9d9f7..eecfc27370c3 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -415,7 +415,8 @@ static void __printf(2, 0) btf_dump_printf(void *ctx,
 }
 
 static int dump_btf_c(const struct btf *btf,
-		      __u32 *root_type_ids, int root_type_cnt)
+		      __u32 *root_type_ids, int root_type_cnt,
+		      int argc, char **argv)
 {
 	struct btf_dump *d;
 	int err = 0, i;
@@ -425,6 +426,14 @@ static int dump_btf_c(const struct btf *btf,
 	if (err)
 		return err;
 
+	printf("/*\n");
+	printf(" * File generated by bpftool using:\n");
+	printf(" * bpftool btf dump");
+	for (i = 0; i < argc; i++)
+		printf(" %s", argv[i]);
+	printf("\n");
+	printf(" * DO NOT EDIT.\n");
+	printf(" */\n");
 	printf("#ifndef __VMLINUX_H__\n");
 	printf("#define __VMLINUX_H__\n");
 	printf("\n");
@@ -507,8 +516,10 @@ static bool btf_is_kernel_module(__u32 btf_id)
 static int do_dump(int argc, char **argv)
 {
 	struct btf *btf = NULL, *base = NULL;
+	char **orig_argv = argv;
 	__u32 root_type_ids[2];
 	int root_type_cnt = 0;
+	int orig_argc = argc;
 	bool dump_c = false;
 	__u32 btf_id = -1;
 	const char *src;
@@ -649,7 +660,8 @@ static int do_dump(int argc, char **argv)
 			err = -ENOTSUP;
 			goto done;
 		}
-		err = dump_btf_c(btf, root_type_ids, root_type_cnt);
+		err = dump_btf_c(btf, root_type_ids, root_type_cnt,
+				 orig_argc, orig_argv);
 	} else {
 		err = dump_btf_raw(btf, root_type_ids, root_type_cnt);
 	}
-- 
2.25.1


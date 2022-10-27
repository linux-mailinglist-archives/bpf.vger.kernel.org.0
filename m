Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB5360F949
	for <lists+bpf@lfdr.de>; Thu, 27 Oct 2022 15:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236204AbiJ0Nid (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Oct 2022 09:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236208AbiJ0Nib (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Oct 2022 09:38:31 -0400
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45861814BB;
        Thu, 27 Oct 2022 06:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1666877906;
        bh=GjdxY+5+AWezFVXzHMoHNfEQigyrPEi9AWt7c8Do1xI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=SNo/maKr//31FlJr19a9qQzO5O7G992c5+enWbmr4J+EP81rWOqflMSDBl8BJ1dPZ
         8QkhrF3DUW66yqKIVqd6YmhbYvDOmYNnOe4We38mat6zUTs3xwCj7lYa9FhBt8tHfq
         Yr+L1/xwg7FdbxFEY5AH0xCaJqRbr2XPEruKfTVE=
Received: from localhost.localdomain ([39.156.73.13])
        by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
        id 99635C94; Thu, 27 Oct 2022 21:38:22 +0800
X-QQ-mid: xmsmtpt1666877902ta2m04jj8
Message-ID: <tencent_C0A1D82C934B5895D65788D11A4456835607@qq.com>
X-QQ-XMAILINFO: Mm/8i8/T4yneTH87S8NiHWlXuaRzKgvN5M8NHOgZB5GzvA3VGBGMgX+8haIDr1
         BNsIp8NI/v/wgxjzXeqxJJ6ip+m71oC18O1UPWrmtyFonQ/pbM7oxfdCnMcabTfq02QOqWiZUKdY
         7zMWzAshYIcGimYlaWK8JlkU/kNt74M+c/ijVrWKf3of3UWeCm4LikrSZw5dBJvwCu9U5iHsIGj5
         AnVK4yMV4RmnoVSxL8NIvtuVEGY3dgs4biT2TxN4HwS/5orLp8M7Bpn4YJHrtyIqJ2TUDbIfLAFQ
         5EDmsqwWB5pA8lA5nvnPdQQrztZPXy1WSV8jZ/4qArWvThUI8QS18pY95QaTWUzWpHJIf9b0Evvx
         1Jc2eNnt2YoEzMWKL7S6PuzagwjK37N70uCoDbAfbuu2sc5cTnLCUkOVeXunb9PGZ2ROVInIM2NH
         k4647QzjOYW1wXtXisCo3nqj30FIbsx5KqH2D42Q2zajUO6cGc//0go9qGMBgIZKbitkO45zGwsQ
         ymVHJrrU3NmKN/pvRyh3aCGdYJcveVE4Nq/0RWiLsGM0O9BcPkQv4sGs/aNALLGUCiUnPJpc+HVO
         oJZOtzyM2tQRPEqJGgGznWTbxreouJepVrEehW/Kx9vW0n7Eu34x6DpxWBRthDmpFlgOI5OZJEFF
         QdITi4Q62RToNOIuCvwtd1zHeUVplAvoBqAYJvb3sWekF3xjPtLG19zuEas3dmNmt/NyGa+jb4me
         hIptZhwu/hvLwPdH6IySJ/AqjxGlWz1pApmDuwhnXR+epXNPaykEwgsg7jOn/a8jdLukD4/pp6Zb
         Iior9A+HxWYWB555B8MczkHG96/gKe+kRrtocobyiWLVw98MniVUrP23lmcXYp/pnimuIVZjn0J4
         xHeSrMq6qh8g3HPI7U9gU4NHvnMPxMJRM+s5UwNCEDhBscG3m8VmwgoVuy7ygnozU02W9nSRfT61
         fXSzC1ZbMhqGvHIO5H21FTzl0nPuAY6piroi2rGPbJLqFPVTjxN9e3Z9/IWYqddNt5BkOiQnwYSL
         WYssK2WFuTsJzujmof
From:   Rong Tao <rtoax@foxmail.com>
Cc:     Rong Tao <rongtao@cestc.cn>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and
        Tools)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf-next] samples/bpf: Fix sockex3: missing BPF prog type
Date:   Thu, 27 Oct 2022 21:38:20 +0800
X-OQ-MSGID: <20221027133820.82970-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <tencent_9E1B74096164395DDAAB4CBFE68CE6216E0A@qq.com>
References: <tencent_9E1B74096164395DDAAB4CBFE68CE6216E0A@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

since commit 450b167fb9be("libbpf: clean up SEC() handling"),
sec_def_matches() does not recognize "socket/xxx" as "socket", therefore,
the BPF program type is not recognized, we should add a custom program
type handler for "socket/xxx".

 $ cd samples/bpf
 $ sudo ./sockex3
 libbpf: prog 'bpf_func_PARSE_IP': missing BPF prog type, check ELF section name 'socket/3'
 libbpf: prog 'bpf_func_PARSE_IP': failed to load: -22
 libbpf: failed to load object './sockex3_kern.o'
 ERROR: loading BPF object file failed

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 samples/bpf/sockex3_user.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/samples/bpf/sockex3_user.c b/samples/bpf/sockex3_user.c
index cd6fa79df900..d18d7a3600b0 100644
--- a/samples/bpf/sockex3_user.c
+++ b/samples/bpf/sockex3_user.c
@@ -22,6 +22,14 @@ struct pair {
 	__u64 bytes;
 };
 
+static int socket_prog_type_id;
+
+__attribute__((destructor))
+static void unregister_socket_sec_handlers(void)
+{
+	libbpf_unregister_prog_handler(socket_prog_type_id);
+}
+
 int main(int argc, char **argv)
 {
 	int i, sock, key, fd, main_prog_fd, jmp_table_fd, hash_map_fd;
@@ -31,6 +39,13 @@ int main(int argc, char **argv)
 	char filename[256];
 	FILE *f;
 
+	LIBBPF_OPTS(libbpf_prog_handler_opts, socket_opts,
+		.cookie = 1,
+	);
+
+	socket_prog_type_id = libbpf_register_prog_handler("socket/",
+			BPF_PROG_TYPE_SOCKET_FILTER, 0, &socket_opts);
+
 	snprintf(filename, sizeof(filename), "%s_kern.o", argv[0]);
 
 	obj = bpf_object__open_file(filename, NULL);
-- 
2.31.1


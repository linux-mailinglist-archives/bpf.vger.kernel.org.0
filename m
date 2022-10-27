Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067C860F921
	for <lists+bpf@lfdr.de>; Thu, 27 Oct 2022 15:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236004AbiJ0NeI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Oct 2022 09:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbiJ0NeH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Oct 2022 09:34:07 -0400
X-Greylist: delayed 7198 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 27 Oct 2022 06:34:04 PDT
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C0E119BE7;
        Thu, 27 Oct 2022 06:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1666877639;
        bh=GjdxY+5+AWezFVXzHMoHNfEQigyrPEi9AWt7c8Do1xI=;
        h=From:To:Cc:Subject:Date;
        b=dU1e0lJBoP77e+IOEtKjuNB0afhXZNc75K+MhlMQqaR4RpKLB8866iiw1xj8CHlWc
         xDOm/IV5UI2Yy8eIjL8LN6JXeD8YxDTFRtmTGYKpuPAO7b3mRSSkaaUU0/JbnIkSK7
         1zDqCUCirOK3OstXLyFpKM3hIHeSzx14oB/MB41I=
Received: from localhost.localdomain ([39.156.73.13])
        by newxmesmtplogicsvrszb1-0.qq.com (NewEsmtp) with SMTP
        id 8780DAB7; Thu, 27 Oct 2022 21:33:56 +0800
X-QQ-mid: xmsmtpt1666877636tofyzi5o3
Message-ID: <tencent_9E1B74096164395DDAAB4CBFE68CE6216E0A@qq.com>
X-QQ-XMAILINFO: M/oQ2p0eBD4ucPNFPdulFn6XkbjsqBssByBETcbBXgqTmEtzPPTBjvwLRuJ8Nl
         El1P2/RKMYYULAM1T4qIsISKAhoD4DrYwUvaB1X0mC2o5gR+JWRjQbpShC2nL59KtKYt8/0uqVnc
         B40cAoKVGNlfoFJpfSB86p49zyYhECnka+AOVzEpj29zVyOpNn4dXNkI2/xCgcfUsmpNjiTQC4T8
         Unv+CwhBD81G1ylx8yljs141YDfr23VK//9C3zP0OxSgQnTf9BNCwnBQRB7lTVhoYdr9yJwVVLvp
         AHT/6OGksFj8581GgenOQQ+lhEj+Txj4cJixCpGHdBNkJQK6XurpG41qWo+I8hqk7NGeLoLXsFuF
         7KzCt3nIj1ip3AzuaauDHEVe4XEL3bTS1HkW+DYOEw6I7TI1yKptxpnL9OFtC0p83CIO6roFyz6E
         bBXiyrJlXqpgNMZFNgzSB4VRTWaouHvfDB0iSELUtDPhMlf+2ZOPJG1eUYaZuwdl16GdONRVFEQN
         o6zF4EOxN3xpWEfAJx4w3UVDm8eyCL5lgsrgBKNqBDss7TTDc7Y81RnynAQvDC/C7ZqwDyHa7ak3
         2ptoaLGxqja20oqnUfmjAuu17LQUHiI5vGUm55FbVTczbP5IkmU5F87gWlYowiBvlA5XW7jKGn/q
         LPTzMrZN4vW8PdQXJdwLJmJJfZBPD6oVRpl4RJ3k42xpZlz3F06913b8LB9zYIzgOseCEFQsZFEw
         1+nnUprvG7oZzsbTz5WphvaNeWyv4f1A8ggiyhNXtlNRO2xtm8+gZYd8UJnVi5O4Rhen2ChzA3gr
         CEn/uUELjs5cEXZm+C6/fPtTnZr5ezBmno6rAJRj7yTe5KZLKyaLzcoY+yh/33yt5xLPsgYQSb24
         D+6lV8woFfMNqE0WxiXKfSCyfX38hBdswfE6IGLKarpGGQ2EXXyFMCgEDHihv7QhY4uCjfbiMuui
         u3UtWC3V4XVi1wdGnuCY9A+4qI33n8RF/xb2qpLd2f0rOy46ipyA==
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
Subject: [PATCH] samples/bpf: Fix sockex3: missing BPF prog type
Date:   Thu, 27 Oct 2022 21:33:54 +0800
X-OQ-MSGID: <20221027133354.82451-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.31.1
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


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A753368CF21
	for <lists+bpf@lfdr.de>; Tue,  7 Feb 2023 06:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjBGFvz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Feb 2023 00:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjBGFvx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 00:51:53 -0500
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8E24688;
        Mon,  6 Feb 2023 21:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1675749108;
        bh=Uu61Vvpzjinsk/7u3/2Vpkwh2/C9o/qwdZRPl3mAju0=;
        h=From:To:Cc:Subject:Date;
        b=k/28aNCZ1pbZo/hziwCSRJIUND6/wtWkgTZYt8y5Wne7zhTcGIoThOXThT2CDHtZH
         dHv9efK4tz5Tm+sywDdTuRknyrWMJgENIiPcVxhYGcQNzm/CPbBjm2A+4SbOCN2xAT
         KZEBQD2rm16AOwxjfEwkCBoUp66A71If3znTu0t0=
Received: from localhost.localdomain ([39.156.73.13])
        by newxmesmtplogicsvrszc1-0.qq.com (NewEsmtp) with SMTP
        id CECA622A; Tue, 07 Feb 2023 13:51:44 +0800
X-QQ-mid: xmsmtpt1675749104t5lb8r96s
Message-ID: <tencent_FB3E886D062242FF59A997492A3BAF2BA308@qq.com>
X-QQ-XMAILINFO: MfWa+adQHcqu+8EeLx0JfjUibiXx6BH1nky7gewpqUpbCit5tXLw7ZM97tuebC
         JDsGBtRhHUZn+vAw8CVyztAWNOusoMiJECiPyTf7q+kiP6GJaC8qkxEO2cGrzxTswH208L179I4j
         lLls9pAM6hCJwnBPsgVNKmqQqP1CJfHKiySD0UEe9YNBizMxY9d9E2IAUqLm8DiBEVv96M2h+AqF
         o2r6K4ip7RZTdLUQS9liHjTCxGDv+c/X1ESN0EU9jtAVSa+Cp9cdEteAr74YafNbFrZQSyotfFIF
         Ied0z+S9YRPkiyRgEg7Tjxv+EOKqbWnfi4L5/3oY65hZpFBTkqdR2bBX462ncPTDJVEmj4e69TKg
         hfzZH4eShxjPmtm22p5gqiatZ+nKo0eBgmdZOBOi8Ar0oB3FqtMCFUeWJMoqLmQW+gRbzIsz6drT
         cJJx6/uQVTHKhH+zkpKNjQxlyV09QwLZ1fUiRYwMZJY7qgudiqNezI5o/xw9VXtGM3gFylHhRfFI
         FDRITUY7lE56bi0jDbiA2a6jcHmUrDUQIrj3Q5s+Ug96po0E68999C9f1Ax2kLQpOfv6pi1evzy+
         u1+Qp9noah2MbSzXXFkqIVeyPEBoOgVsjOUJUWllmh976XhweHUdviBWBIsBKCuD8ymrbwq8kuqZ
         KjNcOeq5/5W8O43R30BxUTheGUWN3cInKnqsgoxVoM4UHg6kLOkZ8SzAg+kBXdtl0HdKf6L2es76
         dfNGCVlvBf/IkyEBFP3XhySW5Wi/zKjAs0tN6PjIOQqTy8I3n361CmueOuP/VskXeRuMKV4TlNw1
         mc/cXMIZXy2RVXHvETx/GtlX+Kei8n5BzDbmroC1FU3c7TZsv1cvXF3r66HG1O3RawS2mL6q3n/E
         Bipiw1MwS9ATcZjCfN7eKeFsY81z4jgfvfrQf7x6+UEwvZUypjaOCqqZb0wDHXTk0IOkwMx8qJRQ
         9bNZD6oPdUyxzo25P/6E4tHWVCCeyK0WzU+S+oSyg=
From:   Rong Tao <rtoax@foxmail.com>
To:     ast@kernel.org
Cc:     Rong Tao <rongtao@cestc.cn>,
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
Subject: [PATCH] samples: bpf: syscall_tp: Add syscall openat2 enter/exit tracepoint
Date:   Tue,  7 Feb 2023 13:51:43 +0800
X-OQ-MSGID: <20230207055143.37936-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

commit fe3300897cbf("samples: bpf: fix syscall_tp due to unused syscall")
add openat() syscall trapoints, this submit support openat2().

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 samples/bpf/syscall_tp_kern.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/samples/bpf/syscall_tp_kern.c b/samples/bpf/syscall_tp_kern.c
index 50231c2eff9c..e7121dd1ee37 100644
--- a/samples/bpf/syscall_tp_kern.c
+++ b/samples/bpf/syscall_tp_kern.c
@@ -58,6 +58,13 @@ int trace_enter_open_at(struct syscalls_enter_open_args *ctx)
 	return 0;
 }
 
+SEC("tracepoint/syscalls/sys_enter_openat2")
+int trace_enter_open_at2(struct syscalls_enter_open_args *ctx)
+{
+	count(&enter_open_map);
+	return 0;
+}
+
 SEC("tracepoint/syscalls/sys_exit_open")
 int trace_enter_exit(struct syscalls_exit_open_args *ctx)
 {
@@ -71,3 +78,10 @@ int trace_enter_exit_at(struct syscalls_exit_open_args *ctx)
 	count(&exit_open_map);
 	return 0;
 }
+
+SEC("tracepoint/syscalls/sys_exit_openat2")
+int trace_enter_exit_at2(struct syscalls_exit_open_args *ctx)
+{
+	count(&exit_open_map);
+	return 0;
+}
-- 
2.39.1


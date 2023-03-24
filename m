Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7186C88F4
	for <lists+bpf@lfdr.de>; Sat, 25 Mar 2023 00:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjCXXC3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Mar 2023 19:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCXXC2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Mar 2023 19:02:28 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78F11DB8A
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 16:02:26 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso4007267wms.1
        for <bpf@vger.kernel.org>; Fri, 24 Mar 2023 16:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1679698945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zS+xWbkCiPppB/CJ9sjpe+C+S3vg5aSapcI3Dhq8vzc=;
        b=VTNEE9u6nwjVM8eTRMX1pHpZDY3eUC2W/173QWrKrWgQPU4vhQ3EqgI/MjxARyhdwN
         Y2X0VklyoRxKkdYDAKH2+6eTkRW3KOlS2k48lASqQeZOWlSkK7kfMMU2amRU+z61SqfM
         Y3jqXd8OcBBPpNJg4AgMojUH6VakfNLj6emmJRqnsI7XWXUuq/tNAbI10cPomvf9pc22
         Tv8stAxce/aNZ4zGhqcxnQVaN7pGeL4kWyBiofmV6q1lS5zPvYmTsUidOFygbMSOFzLJ
         x6Z3rE8q3M9iu/0ZsSmOfMN6G6J+qsikkY71NkjPfB6gz4LuNNKtL/jk9X01SmSfyn0H
         C9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679698945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zS+xWbkCiPppB/CJ9sjpe+C+S3vg5aSapcI3Dhq8vzc=;
        b=PUTUdwFxLx7ZDWr44vM8LkIvDPgq7VKCnbDcFLR8oFHO1Opjq8FS+PAwwNSH3h8ShP
         UT91fLXYEZzt2HA4viJtNJtCr0LgwUGgnNQeFRnq9y3MVHWT3ONmg7PyRKa2Ic1Qz2Rw
         133cFLWAfUiiVDER7uig5fe35MkHkK4lHVbJHeYzCOeXJdotKKJ23svvKnjaPk+aG1he
         1GIqIVq0j/H3Y9xHWTnWnguzSlfZUOjbgTyDJi6ef5Kr2nRrWPtdsBl1/nZ5HKr3uHaW
         kzAKe775z6tBsn7/RelE7Oa/PokwdqVU4pAXySKO4rPeIfMKGC42FdC+cwpVmb7ZB5Lp
         9qdA==
X-Gm-Message-State: AO0yUKXXNVxFqc+0vzUoWyUi2AkJsxkVuUHGXa5Cr9qivxf3plkE+Nv4
        9BOSKYcfpZFniwB7GOWdWZ21Tg==
X-Google-Smtp-Source: AK7set9RsvBKjYZDAbMuoXaH/1nWA03M1W1j9b/EWmINzo+YuzR8EahARAJgiJG+X4gPJWgxavv9PA==
X-Received: by 2002:a7b:c8c4:0:b0:3ed:b590:96e6 with SMTP id f4-20020a7bc8c4000000b003edb59096e6mr3551179wml.4.1679698945078;
        Fri, 24 Mar 2023 16:02:25 -0700 (PDT)
Received: from harfang.fritz.box ([2a02:8011:e80c:0:c17f:3e3e:3455:90b])
        by smtp.gmail.com with ESMTPSA id c16-20020adffb50000000b002c56179d39esm19340342wrs.44.2023.03.24.16.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 16:02:24 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 2/5] bpftool: Fix bug for long instructions in program CFG dumps
Date:   Fri, 24 Mar 2023 23:02:06 +0000
Message-Id: <20230324230209.161008-3-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230324230209.161008-1-quentin@isovalent.com>
References: <20230324230209.161008-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When dumping the control flow graphs for programs using the 16-byte long
load instruction, we need to skip the second part of this instruction
when looking for the next instruction to process. Otherwise, we end up
printing "BUG_ld_00" from the kernel disassembler in the CFG.

Fixes: efcef17a6d65 ("tools: bpftool: generate .dot graph from CFG information")
Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/xlated_dumper.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
index 6fe3134ae45d..3daa05d9bbb7 100644
--- a/tools/bpf/bpftool/xlated_dumper.c
+++ b/tools/bpf/bpftool/xlated_dumper.c
@@ -372,8 +372,15 @@ void dump_xlated_for_graph(struct dump_data *dd, void *buf_start, void *buf_end,
 	struct bpf_insn *insn_start = buf_start;
 	struct bpf_insn *insn_end = buf_end;
 	struct bpf_insn *cur = insn_start;
+	bool double_insn = false;
 
 	for (; cur <= insn_end; cur++) {
+		if (double_insn) {
+			double_insn = false;
+			continue;
+		}
+		double_insn = cur->code == (BPF_LD | BPF_IMM | BPF_DW);
+
 		printf("% 4d: ", (int)(cur - insn_start + start_idx));
 		print_bpf_insn(&cbs, cur, true);
 		if (cur != insn_end)
-- 
2.34.1


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8262C6CA21D
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 13:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjC0LHN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 07:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbjC0LHL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 07:07:11 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807D049E9
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 04:07:03 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id y14so8320375wrq.4
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 04:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1679915222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MG8Z2QtyneyCwf3D8b9rpGuRSiSn2l42a9tW5macy7s=;
        b=XMXfThx/p0S5O/QAlbVhz/QXhwdNtedCN+1Zy4YvVYHk/JO3ceE0qH8BizsNoR24TF
         oOdkZ2o3eGkpwrKBSLJpj/DGE9EII/f6kwKRcgUIo4D9/5Mquej0BsiU3SHQVYm8Sf9n
         7iNBJyEy2mvKzCBZoNCWSgwFPA3XvNkkJmzS+e9fGX7N9VQe8zjYKjjxBt+tl77KM7R4
         6iIvHcTimHpjtVuuQis5Mn8RDk9oJy0VWafxqkJwkD2neLW+wcA9w/mHWurrpYjasO9y
         HifJnxhvEy5Ke+jyPZHiqR3lPdZap/3uY27LRGdoEud31zhU+XkB324LuESixzSKs+Mn
         tOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679915222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MG8Z2QtyneyCwf3D8b9rpGuRSiSn2l42a9tW5macy7s=;
        b=1hVTsZ/CTXHE+LkIPrIrrvDv1pg7+9zHTAmR7sxH+m+M2xuxS9SUOmfS2mXHCzTxgJ
         uBrvXhDRJzuqHfWOL6lZgTFX3SY0LPrhhMswuMdq2/V7saN+EcSjo7i2irLI0xD8/Tgk
         AxPMYl+jy94T931KPs1xcHuJbMGIURXKd+ENysQCns25p3dAF/VM0ETKJZfojVgX+7Ox
         khlyHFoVgbZpVCVJ6c6uqPlRGjKHu+vkRtFeRpFY5rFBc8ZUZiuVMnpFpLNo7Wdxp5Mu
         YJWyxZ5rUDq6Ir3plvN26ta4UN1ABR1xwuzhRSWsff7MWxFQe1jMOoS1r8JCrqFZtnjB
         Wjpg==
X-Gm-Message-State: AAQBX9fsz3HAj6jJ9PpPz1MFDljX95T/uUFRFLMBmYQn5frvK8jSu789
        sbz0pyhXmpK7g49AvpSPquOvHA==
X-Google-Smtp-Source: AKy350ZRyOfDCJumZHqwkmESd34yxx0HbBy3Zm16JjJj2YwSSX3InghYxpHjFd9KoTGcS7u3+nxaxQ==
X-Received: by 2002:adf:e552:0:b0:2d6:8d2d:5a7c with SMTP id z18-20020adfe552000000b002d68d2d5a7cmr8956370wrm.57.1679915222073;
        Mon, 27 Mar 2023 04:07:02 -0700 (PDT)
Received: from harfang.fritz.box ([2a02:8011:e80c:0:61cd:634a:c75b:ba10])
        by smtp.gmail.com with ESMTPSA id k10-20020a5d6e8a000000b002d1daafea30sm24772958wrz.34.2023.03.27.04.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 04:07:01 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 2/5] bpftool: Fix bug for long instructions in program CFG dumps
Date:   Mon, 27 Mar 2023 12:06:52 +0100
Message-Id: <20230327110655.58363-3-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230327110655.58363-1-quentin@isovalent.com>
References: <20230327110655.58363-1-quentin@isovalent.com>
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
Acked-by: Stanislav Fomichev <sdf@google.com>
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


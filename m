Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE08A6D7D97
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 15:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238215AbjDENVl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Apr 2023 09:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238246AbjDENVk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Apr 2023 09:21:40 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB78A2D6D
        for <bpf@vger.kernel.org>; Wed,  5 Apr 2023 06:21:26 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id he13so1255354wmb.2
        for <bpf@vger.kernel.org>; Wed, 05 Apr 2023 06:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680700885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zS+xWbkCiPppB/CJ9sjpe+C+S3vg5aSapcI3Dhq8vzc=;
        b=BifcG5zy4GGAjCuNWb/AYY+IWFHJelXK/aZKWEm8QTXycusVUbMSDwBIN9mBbo3Q45
         NBzuncKVGxCtWH8DmTjQrfSOh0I9P3JeMm36JLgm9Sqxz46yNc5mZTmqINdgLiGoh6so
         ya7jefq0dn06PFYvpjw5j/Mx/cfaoFGUXEWPzc5QDxHHBuMtNIYN2qMvEP8/Z1wnvdU5
         eM9G74XXcpudUyyJ3o7guLGsoVXFdQ1qI8M+7afHDID7mmSFAPlkN0zTjgpwNCeGSjJS
         vkNuyNNJzoS3ELMGkPlwvYWxVn4+xzl6rglhu+ZSJrfJHd8aAGzbgQuZuuX5oUKl7VLc
         u+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680700885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zS+xWbkCiPppB/CJ9sjpe+C+S3vg5aSapcI3Dhq8vzc=;
        b=RKytLoIopHoCGmLwYvWGj4+NUzPSttDQQu/+vOkB5bKB2sUmMqvJ5BhG8u6+1gW85w
         ZWJMtFfDwJtyGNO90UreAWPPnsXgv/OGtHqxq7uoUauSsL2aMCzTs+q7HkJTc5+MAN8D
         HLUV1lrJfWOYzxtiCgYOHtAijMmItq1gZCdINpS9Dxqz6hN4bwKM+5fSiYQFd9Lqnvsm
         TBXfCHSOWYx3VLfFo/kHXNM40ueVpoivX34OEbUK3753ey7bXd3AELysl5yZyTvKeg+5
         zTSgySbNfUk3Sz333jWsbud+EJIPu0+JxHsk29FwiYgLhKVde+ZssZ76SNqRinDD0BTd
         G7QA==
X-Gm-Message-State: AAQBX9cHuQcos6Yh8Wd3TlMKPJeL6cc4o2+RsLjaKRXdCrFOxiTNXA+F
        UoeJF3fvbQpjkxK5k6Hmpeeeng==
X-Google-Smtp-Source: AKy350bgHvf35niW2VQ1cjnzQ4DScCXmyoaoMJwxEvLcdZbuMTYWLzWjTUlHkBNdBLnO1f9/g2h4SQ==
X-Received: by 2002:a05:600c:288:b0:3ea:d620:570a with SMTP id 8-20020a05600c028800b003ead620570amr4708733wmk.38.1680700885279;
        Wed, 05 Apr 2023 06:21:25 -0700 (PDT)
Received: from harfang.fritz.box ([2a02:8011:e80c:0:8147:b5f5:f4cc:b39b])
        by smtp.gmail.com with ESMTPSA id c22-20020a05600c0ad600b003ed243222adsm2147306wmr.42.2023.04.05.06.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 06:21:24 -0700 (PDT)
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
        bpf@vger.kernel.org, Eduard Zingerman <eddyz87@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v3 2/7] bpftool: Fix bug for long instructions in program CFG dumps
Date:   Wed,  5 Apr 2023 14:21:15 +0100
Message-Id: <20230405132120.59886-3-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230405132120.59886-1-quentin@isovalent.com>
References: <20230405132120.59886-1-quentin@isovalent.com>
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


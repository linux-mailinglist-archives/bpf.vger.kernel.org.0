Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEC1621F1D
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 23:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiKHWWM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 17:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiKHWVx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 17:21:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6843D657ED
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 14:20:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 055BC617BF
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 22:20:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AFEC433D7;
        Tue,  8 Nov 2022 22:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667946032;
        bh=L2quoUCNt0sG+sxUEcyVI38sSsiXpkm6UY2w1aQNSUo=;
        h=From:To:Cc:Subject:Date:From;
        b=ZUIAtzEd8Yf6OjO3PcoUsl8aw0/LCJUPvaYw1BuV+FOPVi8x3SJlykPesH11TC9P+
         NpozSTkFHq1ofLj1ue7B73UDg6HtWE+8r4DxzAy1+Sn5/fowVcsjcu4w9LzBYqQLSl
         NGm0aL1N4fzVk5UbSXlgSLmN05VLbUtANcuo90v3Tjfy0A2DFTVvBaTeMkxykdOyc/
         cfV0H3MXTrENUmoYWi4WSdHzzOGPLt+DaG50g0Sf/RIEbevymEKK3MLgcBdxvNxlYJ
         J+/SalzWs+bswck7i3kT+GLgCcdawEcWmLUHa38CVJPgRmQCJcqbXLLzIt/8OIB2zl
         KS6VkICibj3ng==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH bpf-next 0/3] bpf: Add bpf_vma_build_id_parse helper
Date:   Tue,  8 Nov 2022 23:20:24 +0100
Message-Id: <20221108222027.3409437-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

hi,
adding bpf_vma_build_id_parse helper that parses build ID of ELF file
mapped vma struct passed as an argument.

I originally wanted to add this as kfunc, but we need to be sure the
receiving buffer is big enough and we can't check for that on kfunc
side.

The use case for this helper is to provide the build id for executed
binaries on kernel side, when the monitoring user side does not have
access to the actual binaries.

thanks,
jirka


---
Jiri Olsa (3):
      bpf: Split btf_id/size union in struct bpf_func_proto
      bpf: Add bpf_vma_build_id_parse helper
      selftests/bpf: Add build_id_parse kfunc test

 include/linux/bpf.h                                         |  2 ++
 include/uapi/linux/bpf.h                                    |  9 +++++++++
 kernel/trace/bpf_trace.c                                    | 22 ++++++++++++++++++++++
 scripts/bpf_doc.py                                          |  2 ++
 tools/include/uapi/linux/bpf.h                              |  9 +++++++++
 tools/testing/selftests/bpf/prog_tests/vma_build_id_parse.c | 84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/vma_build_id_parse.c      | 34 ++++++++++++++++++++++++++++++++++
 7 files changed, 162 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/vma_build_id_parse.c
 create mode 100644 tools/testing/selftests/bpf/progs/vma_build_id_parse.c

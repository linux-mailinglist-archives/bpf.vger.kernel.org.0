Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86695621F23
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 23:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiKHWWt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 17:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiKHWV4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 17:21:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0B3657F6
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 14:20:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A57B7617AA
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 22:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C19EC433D6;
        Tue,  8 Nov 2022 22:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667946043;
        bh=097E4lDv+Y0B7rXuKuwKhCPrr0HJz3Uoa/4/kispyPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e4fTqfks783PUDB/p0+y8qSTp1li9CDL722InZ8Jktwt+UoYMtAlMgKBG70T6dGfa
         SCHBwOQxcILYJ6X4YzCUToONucQxpgDSD4j9dqs1g3yaSxLiFq3e7AxAFeuzcV8/1v
         b7Xjh1uEIpB1fL5zANjgZzQr+0JtgI0ieg/lR4wVPYKH0GwmlIRcZ14NXP1th1Np9n
         qwRPVThmmkVBPTcLzKddAjkf/eDI1M6AbYfzjgEgvk2IV/R6NZvITFStEah9M4IUXB
         I31jBNovZD+9V5wgjPNIf5oCmijJSkLE7G18QAL96QcNrlBVq+dg0SZc45mmfesR27
         7fxTe4GM2eQYg==
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
Subject: [PATCH bpf-next 1/3] bpf: Split btf_id/size union in struct bpf_func_proto
Date:   Tue,  8 Nov 2022 23:20:25 +0100
Message-Id: <20221108222027.3409437-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221108222027.3409437-1-jolsa@kernel.org>
References: <20221108222027.3409437-1-jolsa@kernel.org>
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

When having helper that defines both arg*_btf_id and arg*_size fields,
one of those fields will end up with zero value.

With helper definition like:

  .arg1_type      = ARG_PTR_TO_BTF_ID,
  .arg1_btf_id    = &btf_tracing_ids[BTF_TRACING_TYPE_VMA],
  .arg2_type      = ARG_PTR_TO_FIXED_SIZE_MEM,
  .arg2_size      = BUILD_ID_SIZE_MAX,

The arg2_size field initializer zeros out the rest of the arg*_size
fields of its parent annon struct, so it effectively zeros also
arg1_btf_id field.

Moving arg*_btf_id and arg*_size fields into separate unions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 798aec816970..21a1d42b5d4c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -640,6 +640,8 @@ struct bpf_func_proto {
 			u32 *arg5_btf_id;
 		};
 		u32 *arg_btf_id[5];
+	};
+	union {
 		struct {
 			size_t arg1_size;
 			size_t arg2_size;
-- 
2.38.1


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5436AE45E
	for <lists+bpf@lfdr.de>; Tue,  7 Mar 2023 16:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjCGPSr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 10:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjCGPRh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 10:17:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D521499D;
        Tue,  7 Mar 2023 07:14:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 130F960E93;
        Tue,  7 Mar 2023 15:14:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8682EC4339C;
        Tue,  7 Mar 2023 15:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678202089;
        bh=JR9By7TqD68NUWsozTFvETKhHnJ6NH8v+yJVvkVzOps=;
        h=From:Date:Subject:To:Cc:From;
        b=qnpmnBdmeVbcm4fbFN0ouYx5E7pUBwv1ALU5PxHBAmMQ4eJrp7DcHr2bbFGtGlqKC
         HFB5+TVTk1S7vPeQERbYiuE7pIWXXaNfrhb0ZdmVjvs/8QuFI1y7e9vF9c6zTGd/gx
         oEoJPMC4L+LD/QDSjiavR1sK3eWuAsU2NshtXlgbz/GWHvtu/J4UFVaENNaUV9LAD8
         C6IEXk4CGrfESKH7rxbcGF+6Bu8Vme6mWm1MsRYLTfjqYQ8sXWHGAgXO2JFZikbjxV
         fiCIdVTe2HTDtpJ5gCY1UwdyB0KJAPEYtWyJiTHEnlCIGQ1XAh7lhKdySeZ5U1Omsb
         KiNpr5bB2gD0A==
From:   Nathan Chancellor <nathan@kernel.org>
Date:   Tue, 07 Mar 2023 08:14:06 -0700
Subject: [PATCH bpf-next] bpf: Increase size of BTF_ID_LIST without
 CONFIG_DEBUG_INFO_BTF again
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230307-bpf-kfuncs-warray-bounds-v1-1-00ad3191f3a6@kernel.org>
X-B4-Tracking: v=1; b=H4sIAL1UB2QC/x2N0QrCMBAEf6XcswcxFSr+iviQpBsbxLTctbVS+
 u8mPg7Dzu6kkASlW7OTYE2axlzgfGooDC4/wakvTNbY1rSmYz9FfsUlB+WPE3Ff9uOSe+VgzcX
 gCnQAlbl3Cvbichhq4O10hlQxCWLa/p93qrmMbabHcfwA7VJoAY0AAAA=
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, ndesaulniers@google.com,
        trix@redhat.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1971; i=nathan@kernel.org;
 h=from:subject:message-id; bh=JR9By7TqD68NUWsozTFvETKhHnJ6NH8v+yJVvkVzOps=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDCnsIS9MpK98mS7Le0Q9eu0KLUs7sf7jT/8/DPzhqd0v7
 XpuckZqRykLgxgHg6yYIkv1Y9XjhoZzzjLeODUJZg4rE8gQBi5OAZhIQTLDf4eoO2y6866tdarR
 KLtzYuFlx8aQ1Mv2Xbe3qh9zM8jkOcXwm22F+E1ViX3ZHRpuHtHLRNUqd5jVfue5f2Vmo+Tfzlh
 DDgA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

After commit 66e3a13e7c2c ("bpf: Add bpf_dynptr_slice and
bpf_dynptr_slice_rdwr"), clang builds without CONFIG_DEBUG_INFO_BTF
warn:

  kernel/bpf/verifier.c:10298:24: warning: array index 16 is past the end of the array (that has type 'u32[16]' (aka 'unsigned int[16]')) [-Warray-bounds]
                                     meta.func_id == special_kfunc_list[KF_bpf_dynptr_slice_rdwr]) {
                                                     ^                  ~~~~~~~~~~~~~~~~~~~~~~~~
  kernel/bpf/verifier.c:9150:1: note: array 'special_kfunc_list' declared here
  BTF_ID_LIST(special_kfunc_list)
  ^
  include/linux/btf_ids.h:207:27: note: expanded from macro 'BTF_ID_LIST'
  #define BTF_ID_LIST(name) static u32 __maybe_unused name[16];
                            ^
  1 warning generated.

A warning of this nature was previously addressed by
commit beb3d47d1d3d ("bpf: Fix a BTF_ID_LIST bug with
CONFIG_DEBUG_INFO_BTF not set") but there have been new kfuncs added
since then.

Quadruple the size of the CONFIG_DEBUG_INFO_BTF=n definition so that
this problem is unlikely to show up for some time.

Link: https://github.com/ClangBuiltLinux/linux/issues/1810
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 include/linux/btf_ids.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index 3a4f7cd882ca..00950cc03bff 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -204,7 +204,7 @@ extern struct btf_id_set8 name;
 
 #else
 
-#define BTF_ID_LIST(name) static u32 __maybe_unused name[16];
+#define BTF_ID_LIST(name) static u32 __maybe_unused name[64];
 #define BTF_ID(prefix, name)
 #define BTF_ID_FLAGS(prefix, name, ...)
 #define BTF_ID_UNUSED

---
base-commit: 36e5e391a25af28dc1f4586f95d577b38ff4ed72
change-id: 20230307-bpf-kfuncs-warray-bounds-c2040e8ee7ee

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


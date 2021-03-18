Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6181B34058C
	for <lists+bpf@lfdr.de>; Thu, 18 Mar 2021 13:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhCRMbt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Mar 2021 08:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhCRMbf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Mar 2021 08:31:35 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDCDC06174A
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 05:31:34 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id k8so5337415wrc.3
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 05:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KpuzfqcJWxq1OSgDnzQsL0yaJ8WBm7CIQYm3sqIU0Sc=;
        b=RpnJaYkbRDbFmiCH3+01Ee+7Xrm5X0qNe0Oq0E8VR2VKP4xih2Fo0fos1n14yjCRNW
         QhnlVoWujP0OedMTUYQSa4PiUPJQQ9cSjiFxH9fTmrsW/mhsZHc5YN/0tYQNqrnbjkD9
         TGV41PXKmX7sUMoOAeWvPDYk0Xv3YGyAOZkpuD34bYBD4Jc0c9YviqSRqh2FYSVBDfWA
         1F3K3JH6FfiklR8a3NAm3QV1wHPM/dHguk0PF2axnJBvl4Qddggh5upvwXL+Ch7ox3y5
         D/HjUPXXvHxSUZctLi1XU7BoBm2QltYgAIY3NR5d3ngbVYfsv6tCbzb1bKGyR6p8b1ng
         uxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KpuzfqcJWxq1OSgDnzQsL0yaJ8WBm7CIQYm3sqIU0Sc=;
        b=Z6DWWaAYMWzlEBQT2qKwnWDuVqphumkBUzu5ZPloXp/20wgzRymQuDxP/f0YBwMrl2
         GPMzSQ71wFxygmLM9QyPGo9YwVEh26eCPI5Ss5tfNZWhv4Cyvhe4W7zf3/TDfJPb7Lmv
         tlGXGsUH6kPMFY7wDfiuJeHmyQz7EAtMMcv9PVx2BbjZbrTgJSzbGP5L2GwMPR7fzqbj
         ZsXz/Wfa62THzLWshr0ThOeFMPKKe2Kfeb9N32fA4niD/VKwHooq2B8crNxKau6U5w9K
         s+WN/g0i+xy/WsPBeTaZhffIndWCdF4CzRkv9YLbsEpgjp6F6zf9J96NXEVWvQM+eL2X
         YzSw==
X-Gm-Message-State: AOAM533gbY+iyZ3J8qiG0Ifr0uN07IBZJE0cP62o8wKs+XSVBh0K9Y66
        OIFnjGv9WoQ6b0TlRWvx0aA4qA==
X-Google-Smtp-Source: ABdhPJz3x2P6XkXGW+jHLuElLgFmkSO3Z32PkpdIhCW8jm4530+kZe+2JOUAoH0xIdQhgPJDlySWPg==
X-Received: by 2002:a5d:4443:: with SMTP id x3mr9497466wrr.49.1616070693421;
        Thu, 18 Mar 2021 05:31:33 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id v18sm2961421wru.85.2021.03.18.05.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 05:31:32 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf] libbpf: Fix BTF dump of pointer-to-array-of-struct
Date:   Thu, 18 Mar 2021 13:27:01 +0100
Message-Id: <20210318122700.396574-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The vmlinux.h generated from BTF is invalid when building
drivers/phy/ti/phy-gmii-sel.c with clang:

vmlinux.h:61702:27: error: array type has incomplete element type ‘struct reg_field’
61702 |  const struct reg_field (*regfields)[3];
      |                           ^~~~~~~~~

bpftool generates a forward declaration for this struct regfield, which
compilers aren't happy about. Here's a simplified reproducer:

	struct inner {
		int val;
	};
	struct outer {
		struct inner (*ptr_to_array)[2];
	};

	static struct inner a[2];
	struct outer b = {
		.ptr_to_array = &a,
	};

After build with clang -> bpftool btf dump c -> clang/gcc:
./def-clang.h:11:23: error: array has incomplete element type 'struct inner'
        struct inner (*ptr_to_array)[2];

Member ptr_to_array of struct outer is a pointer to an array of struct
inner. In the DWARF generated by clang, struct outer appears before
struct inner, so when converting BTF of struct outer into C, bpftool
issues a forward declaration of struct inner. With GCC the DWARF info is
reversed so struct inner gets fully defined.

That forward declaration is not sufficient when compilers handle an
array of the struct, even when it's only used through a pointer. Note
that we can trigger the same issue with an intermediate typedef:

	struct inner {
	        int val;
	};
	typedef struct inner inner2_t[2];
	struct outer {
	        inner2_t *ptr_to_array;
	};

	static inner2_t a;
	struct outer b = {
	        .ptr_to_array = &a,
	};

Becomes:

	struct inner;
	typedef struct inner inner2_t[2];

And causes:

./def-clang.h:10:30: error: array has incomplete element type 'struct inner'
	typedef struct inner inner2_t[2];

To fix this, clear through_ptr whenever we encounter an intermediate
array, to make the inner struct part of a strong link and force full
declaration.

Fixes: 351131b51c7a ("libbpf: add btf_dump API for BTF-to-C conversion")
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 tools/lib/bpf/btf_dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 2f9d685bd522..0911aea4cdbe 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -462,7 +462,7 @@ static int btf_dump_order_type(struct btf_dump *d, __u32 id, bool through_ptr)
 		return err;
 
 	case BTF_KIND_ARRAY:
-		return btf_dump_order_type(d, btf_array(t)->type, through_ptr);
+		return btf_dump_order_type(d, btf_array(t)->type, false);
 
 	case BTF_KIND_STRUCT:
 	case BTF_KIND_UNION: {
-- 
2.30.2


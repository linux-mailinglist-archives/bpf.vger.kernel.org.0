Return-Path: <bpf+bounces-9112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A0478FDEA
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 14:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FBE8281AE2
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 12:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A24CBE4E;
	Fri,  1 Sep 2023 12:59:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D9DAD3F
	for <bpf@vger.kernel.org>; Fri,  1 Sep 2023 12:59:47 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A9AE0
	for <bpf@vger.kernel.org>; Fri,  1 Sep 2023 05:59:46 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so6619385a12.0
        for <bpf@vger.kernel.org>; Fri, 01 Sep 2023 05:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693573184; x=1694177984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PnrSR8SoyYPOuzDxZXrc+U87TGyEuNN0miBwO1KhILY=;
        b=oIb7H2RG3qGI+65OsCwt+a/i4G6MKGx9mGzX0k8taKh4ICGJ1zmuUclEXm7VVUur6X
         U9M/0d19Abcg8DTSwM5tAdp57ICLvYpDDBOEQYi4g9rr0hSh+5DDVCyBkBnKqcrQKZ2S
         zXiE9dd2/lS/Qx4t0fRK8fq34SKghWCp61UqlqUOTmZP8y8pWE3YkB9nAN0Ck0XNvwi/
         FDUiUukaEQRpuxZWGtB+crAPs/xhL/f+uC7eF0x1XOWa/BFGBULf8OGInaJ1Cn47Qdpo
         1kp+TD++cc8/jBMyJ51slwvW9v0h5KqmguU2mAvWBYRJuOZw8YJvswk+CYgeA4I2XrNi
         ZfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693573184; x=1694177984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PnrSR8SoyYPOuzDxZXrc+U87TGyEuNN0miBwO1KhILY=;
        b=YJiOKzduTk2+l17e+vFbUvOWI0LvBqvIODyu2izD7em3VnihzrLqmlggEV0XGYJoaz
         b7lpGnIsp6tue5j1as8UeP1UQcJj6OSBRFpy/T8w4cgKDUPlREdtVD+GgLBKMoo72LLv
         PL/cQtYuhC312lw/d0/4HFpXEu/y6F+DXgzXWGk4qcYIHQWTqKZ2tZ5Z87VsXWdwJjmY
         eA/yP1+9mwobFuU+ipEPRMXsmSln4S1Vj2b0TGf9zUZuqn2NcO5ucNR+/MxKzi66xFh5
         8VwpVJfvqd4IeTml4RXZygFDjsj76hU7mTm2WIggYOuSMyctyRmIUh4lQtd+cGAAMAcU
         Rpzg==
X-Gm-Message-State: AOJu0Yxi6BGzWhF7qR+kzBKCQnvMOrgU4Qv321sLxpC/JWdFL8BHjSvz
	ejQlZ7NuUTIvrfYc44Uvrhff6/fT8UQs1A==
X-Google-Smtp-Source: AGHT+IFYOmqjymuMwVxgYuKHBogO+nWZNyZkbMy1uOQOBHrOCB/nWTQLRPrP5Kz41JoAHPjtF+/dWQ==
X-Received: by 2002:a05:6402:2550:b0:522:c226:34ea with SMTP id l16-20020a056402255000b00522c22634eamr6871685edb.7.1693573184387;
        Fri, 01 Sep 2023 05:59:44 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id l6-20020aa7c306000000b00528dc95ad4bsm2000817edq.95.2023.09.01.05.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 05:59:43 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH bpf] docs/bpf: Fix "file doesn't exist" warnings in {llvm_reloc,btf}.rst
Date: Fri,  1 Sep 2023 15:59:35 +0300
Message-ID: <20230901125935.487972-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

scripts/documentation-file-ref-check reports warnings for (valid)
cross-links of form:

  :ref:`Documentation/bpf/btf <BTF_Ext_Section>`

Adding extension to the file name helps to avoid the warning, e.g:

  :ref:`Documentation/bpf/btf.rst <BTF_Ext_Section>`

Fixes: be4033d36070 ("docs/bpf: Add description for CO-RE relocations")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309010804.G3MpXo59-lkp@intel.com/
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 Documentation/bpf/btf.rst        | 2 +-
 Documentation/bpf/llvm_reloc.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index ffc11afee569..e43c2fdafcd7 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -803,7 +803,7 @@ structure when .BTF.ext is generated. All ``bpf_core_relo`` structures
 within a single ``btf_ext_info_sec`` describe relocations applied to
 section named by ``btf_ext_info_sec->sec_name_off``.
 
-See :ref:`Documentation/bpf/llvm_reloc <btf-co-re-relocations>`
+See :ref:`Documentation/bpf/llvm_reloc.rst <btf-co-re-relocations>`
 for more information on CO-RE relocations.
 
 4.2 .BTF_ids section
diff --git a/Documentation/bpf/llvm_reloc.rst b/Documentation/bpf/llvm_reloc.rst
index 73bf805000f2..44188e219d32 100644
--- a/Documentation/bpf/llvm_reloc.rst
+++ b/Documentation/bpf/llvm_reloc.rst
@@ -250,7 +250,7 @@ CO-RE Relocations
 From object file point of view CO-RE mechanism is implemented as a set
 of CO-RE specific relocation records. These relocation records are not
 related to ELF relocations and are encoded in .BTF.ext section.
-See :ref:`Documentation/bpf/btf <BTF_Ext_Section>` for more
+See :ref:`Documentation/bpf/btf.rst <BTF_Ext_Section>` for more
 information on .BTF.ext structure.
 
 CO-RE relocations are applied to BPF instructions to update immediate
-- 
2.41.0



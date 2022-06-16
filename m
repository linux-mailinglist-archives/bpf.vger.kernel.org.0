Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC3D54E6E4
	for <lists+bpf@lfdr.de>; Thu, 16 Jun 2022 18:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377006AbiFPQUm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jun 2022 12:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbiFPQUl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jun 2022 12:20:41 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AD343EC5
        for <bpf@vger.kernel.org>; Thu, 16 Jun 2022 09:20:39 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id s12so3751031ejx.3
        for <bpf@vger.kernel.org>; Thu, 16 Jun 2022 09:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9sOnHDhrC9NqDZ1168Chx77lsgaAKJtv3Vw9HfioHEA=;
        b=RmORFZ+J+O9rhDCS5BEwnpS8Myc917PDBduBbP/qi7zp8WEXEAnX5FsTfuQOXQbRIZ
         zUHKe/4RFnvZKh4vDIxkW8cVC0o7ekdK7FxtPnEMqdqq2pWxhxhhBnzBU0e4B5GTTerP
         LKnfTR9FKfzsLxrzlJ9iUzwlyWZcl/Ku4wcFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9sOnHDhrC9NqDZ1168Chx77lsgaAKJtv3Vw9HfioHEA=;
        b=sgn/pq9kf4/rDCsKtP9BiNaGQtwQyoE2DdOHF3JQRjbScCrjE7w93rR0Qkqlh0IsTF
         A3BxUGDrLqRRrZEHTDjpNFhlHJ8TfXw5lNEljfVwWFMFjY6Zy8CVPIdqu4o0JDSoreTQ
         fPaVNf3hY60qUR2VeUh2MD5XLbF65YuE3HrIbpOfyuELw3FotsWZWFUuLmgxHg34o3OB
         QtHmti3z+9tLSJVfjSRm33Pti4Z5sqAN1FfJMnudfOysm0Jl2T/HCCUmeGKVJtld3RPC
         PCYcv2mXG/QkVmzIVnERwByCiAQfBbZHmMONGPOPhMdkBtkmBim/VSF7SCURYFqDMbWj
         ErNg==
X-Gm-Message-State: AJIora+PvWRobUXHbxxGcGiW0DyBfQ9L3Qw3Ummc7AdMQObUZfp2pKYH
        VAVQI1nTAiCchWavTBwIpeN47/eDVw0zgQ==
X-Google-Smtp-Source: AGRyM1uENapBB3D4By0NXki/D8ONzPYmQgpinBeWaUw8fx6JJstBoNxuCkgaXm8pYM1U1OEbVGDRzw==
X-Received: by 2002:a17:907:c1d:b0:70f:469a:3d73 with SMTP id ga29-20020a1709070c1d00b0070f469a3d73mr5206367ejc.248.1655396438245;
        Thu, 16 Jun 2022 09:20:38 -0700 (PDT)
Received: from cloudflare.com (79.184.138.130.ipv4.supernova.orange.pl. [79.184.138.130])
        by smtp.gmail.com with ESMTPSA id q12-20020a5085cc000000b0042ab87ea713sm2064930edh.22.2022.06.16.09.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 09:20:37 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        kernel-team@cloudflare.com
Subject: [PATCH bpf-next v2 0/2] Fix tail call counting with bpf2bpf
Date:   Thu, 16 Jun 2022 18:20:35 +0200
Message-Id: <20220616162037.535469-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Please see patch 1 for the explanation of the problem.
Patch 2 adds a test so that we don't regress.

v1 -> v2:
- switch from __attibute__((always_unused)) to unused to avoid CI failures.

Jakub Sitnicki (2):
  bpf, x86: Fix tail call count offset calculation on bpf2bpf call
  selftests/bpf: Test tail call counting with bpf2bpf and data on stack

 arch/x86/net/bpf_jit_comp.c                   |  3 +-
 .../selftests/bpf/prog_tests/tailcalls.c      | 55 +++++++++++++++++++
 .../selftests/bpf/progs/tailcall_bpf2bpf6.c   | 42 ++++++++++++++
 3 files changed, 99 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf6.c

-- 
2.35.3


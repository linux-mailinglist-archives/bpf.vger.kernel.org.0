Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599324ACE15
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 02:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiBHBrz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Feb 2022 20:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235762AbiBHBZw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Feb 2022 20:25:52 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234CCC061355
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 17:25:50 -0800 (PST)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Jt4xp1Lw9zdZTV;
        Tue,  8 Feb 2022 09:22:38 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpeml500025.china.huawei.com
 (7.185.36.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 8 Feb
 2022 09:25:45 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>
CC:     Ard Biesheuvel <ard.biesheuvel@arm.com>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <houtao1@huawei.com>
Subject: [PATCH bpf-next v3 0/2] bpf, arm64: fix bpf line info
Date:   Tue, 8 Feb 2022 09:25:37 +0800
Message-ID: <20220208012539.491753-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

The patchset addresses two issues in bpf line info for arm64:

(1) insn_to_jit_off only considers the body itself and ignores
    prologue before the body. Fixed in patch #1.

(2) insn_to_jit_off passed to bpf_prog_fill_jited_linfo() is
    calculated in instruction granularity instead of bytes
    granularity. Fixed in patch #2.

Comments are always welcome.

Regards,
Tao

Change Log:
v3:
 * patch #2: explain why bpf2a64_offset() needs update
 * add Fixes tags in both patches

v2: https://lore.kernel.org/bpf/20220125105707.292449-1-houtao1@huawei.com
 * split into two independent patches (from Daniel)
 * use AARCH64_INSN_SIZE instead of defining INSN_SIZE

v1: https://lore.kernel.org/bpf/20220104014236.1512639-1-houtao1@huawei.com

Hou Tao (2):
  bpf, arm64: call build_prologue() first in first JIT pass
  bpf, arm64: calculate offset as byte-offset for bpf line info

 arch/arm64/net/bpf_jit_comp.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

-- 
2.27.0


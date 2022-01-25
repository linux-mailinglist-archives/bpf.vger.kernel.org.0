Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E89049C98C
	for <lists+bpf@lfdr.de>; Wed, 26 Jan 2022 13:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241221AbiAZMXn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Jan 2022 07:23:43 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:16928 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241218AbiAZMXn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Jan 2022 07:23:43 -0500
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JkN830FDPzZfXT;
        Wed, 26 Jan 2022 20:19:47 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpeml500025.china.huawei.com
 (7.185.36.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 26 Jan
 2022 20:23:41 +0800
From:   Hou Tao <houtao1@huawei.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
CC:     Ard Biesheuvel <ard.biesheuvel@arm.com>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <houtao1@huawei.com>
Subject: [PATCH bpf-next v2 0/2] bpf, arm64: fix bpf line info
Date:   Tue, 25 Jan 2022 18:57:05 +0800
Message-ID: <20220125105707.292449-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
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
v2:
 * split into two independent patches (from Daniel)
 * use AARCH64_INSN_SIZE instead of defining INSN_SIZE

v1: https://lore.kernel.org/bpf/20220104014236.1512639-1-houtao1@huawei.com

Hou Tao (2):
  bpf, arm64: call build_prologue() first in first JIT pass
  bpf, arm64: calculate offset as byte-offset for bpf line info

 arch/arm64/net/bpf_jit_comp.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

-- 
2.27.0


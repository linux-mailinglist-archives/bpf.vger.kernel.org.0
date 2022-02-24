Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA6C4C2B54
	for <lists+bpf@lfdr.de>; Thu, 24 Feb 2022 12:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbiBXL7k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Feb 2022 06:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbiBXL7j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Feb 2022 06:59:39 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D19488A3
        for <bpf@vger.kernel.org>; Thu, 24 Feb 2022 03:59:10 -0800 (PST)
Received: from kwepemi500013.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K4BHS050tzdZf0;
        Thu, 24 Feb 2022 19:57:55 +0800 (CST)
Received: from huawei.com (10.67.174.197) by kwepemi500013.china.huawei.com
 (7.221.188.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 24 Feb
 2022 19:59:07 +0800
From:   Xu Kuohai <xukuohai@huawei.com>
To:     <bpf@vger.kernel.org>
CC:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Shuah Khan <shuah@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH bpf-next v3 0/2] Fix btf dump error caused by declaration
Date:   Thu, 24 Feb 2022 07:09:41 -0500
Message-ID: <20220224120943.1169985-1-xukuohai@huawei.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.197]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500013.china.huawei.com (7.221.188.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series fixes a btf dump error caused by forward declaration.

Currently if a declaration appears in the BTF before the definition,
the definition is dumped as a conflicting name, eg:

    $ bpftool btf dump file vmlinux format raw | grep "'unix_sock'"
    [81287] FWD 'unix_sock' fwd_kind=struct
    [89336] STRUCT 'unix_sock' size=1024 vlen=14

    $ bpftool btf dump file vmlinux format c | grep "struct unix_sock"
    struct unix_sock;
    struct unix_sock___2 {	<--- conflict, the "___2" is unexpected
		    struct unix_sock___2 *unix_sk;

This causes a "definition not found" compilation error if the dump output
is used as a header file.

Xu Kuohai (2):
  libbpf: Skip forward declaration when counting duplicated type names
  selftests/bpf: Update btf_dump case for conflicting names

 tools/lib/bpf/btf_dump.c                      |  5 ++
 .../selftests/bpf/prog_tests/btf_dump.c       | 54 ++++++++++++++-----
 2 files changed, 46 insertions(+), 13 deletions(-)

-- 
2.30.2


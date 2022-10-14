Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0BE5FEA2A
	for <lists+bpf@lfdr.de>; Fri, 14 Oct 2022 10:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiJNIKf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Oct 2022 04:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiJNIKe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Oct 2022 04:10:34 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C383F6AA3E;
        Fri, 14 Oct 2022 01:10:28 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MpfFr0z0dzHtcj;
        Fri, 14 Oct 2022 16:10:24 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 14 Oct 2022 16:10:25 +0800
From:   Wang Yufen <wangyufen@huawei.com>
To:     <quentin@isovalent.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
        <yhs@fb.com>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
        <sdf@google.com>, <haoluo@google.com>, <jolsa@kernel.org>,
        <davem@davemloft.net>, <kuba@kernel.org>, <hawk@kernel.org>,
        <nathan@kernel.org>, <ndesaulniers@google.com>, <trix@redhat.com>
CC:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [bpf-next v9 0/3] bpftool: Add autoattach for bpf prog load|loadall
Date:   Fri, 14 Oct 2022 16:31:12 +0800
Message-ID: <1665736275-28143-1-git-send-email-wangyufen@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.70]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset add "autoattach" optional for "bpftool prog load(_all)" to support
one-step load-attach-pin_link.

v8 -> v9: fix link leak, and change pathname_concat(specify not just buffer
	  pointer, but also it's size)
v7 -> v8: for the programs not supporting autoattach, fall back to reguler pinning
	  instead of skipping
v6 -> v7: add info msg print and update doc for the skip program
v5 -> v6: skip the programs not supporting auto-attach,
	  and change optional name from "auto_attach" to "autoattach"
v4 -> v5: some formatting nits of doc
v3 -> v4: rename functions, update doc, bash and do_help()
v2 -> v3: switch to extend prog load command instead of extend perf
v2: https://patchwork.kernel.org/project/netdevbpf/patch/20220824033837.458197-1-weiyongjun1@huawei.com/
v1: https://patchwork.kernel.org/project/netdevbpf/patch/20220816151725.153343-1-weiyongjun1@huawei.com/

Wang Yufen (3):
  bpftool: Add autoattach for bpf prog load|loadall
  bpftool: Update doc (add autoattach to prog load)
  bpftool: Update the bash completion(add autoattach to prog load)

 tools/bpf/bpftool/Documentation/bpftool-prog.rst | 15 ++++-
 tools/bpf/bpftool/bash-completion/bpftool        |  1 +
 tools/bpf/bpftool/prog.c                         | 76 +++++++++++++++++++++++-
 3 files changed, 88 insertions(+), 4 deletions(-)

-- 
1.8.3.1


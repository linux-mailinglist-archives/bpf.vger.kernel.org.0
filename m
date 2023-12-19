Return-Path: <bpf+bounces-18297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B329681898D
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 15:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 634FD288C5C
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 14:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA0D1B268;
	Tue, 19 Dec 2023 14:15:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122DF1A728;
	Tue, 19 Dec 2023 14:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Svdx41fcWz1fydm;
	Tue, 19 Dec 2023 22:14:32 +0800 (CST)
Received: from dggpeml500010.china.huawei.com (unknown [7.185.36.155])
	by mail.maildlp.com (Postfix) with ESMTPS id DF89A1800E3;
	Tue, 19 Dec 2023 22:15:44 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500010.china.huawei.com
 (7.185.36.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 19 Dec
 2023 22:15:43 +0800
From: Xin Liu <liuxin350@huawei.com>
To: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <yanan@huawei.com>,
	<wuchangye@huawei.com>, <xiesongyang@huawei.com>, <kongweibin2@huawei.com>,
	<liuxin350@huawei.com>, <tianmuyang@huawei.com>, <zhangmingyi5@huawei.com>
Subject: An invalid memory access was discovered by a fuzz test
Date: Tue, 19 Dec 2023 22:15:44 +0800
Message-ID: <20231219141544.128812-1-liuxin350@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500010.china.huawei.com (7.185.36.155)

Hi all:

The issue occurred while reading an ELF file in libbpf.c during fuzzing

    Using host libthread_db library "/usr/lib64/libthread_db.so.1".
    0.000243187s DEBUG total counters = 7816
    0.000346533s DEBUG binary maps to 400000-155f280, len = 18215552
    0.000765462s DEBUG init_fuzzer:run_seed: running initial seed path="crash-sigsegv-b905489aaeb39555ff1245117f1efd1677195b9ac1437bfb18b8d2d04099704b"

    Program received signal SIGSEGV, Segmentation fault.
    0x0000000000958e97 in bpf_object.collect_prog_relos () at libbpf.c:4206
    4206 in libbpf.c
    (gdb) bt
    #0 0x0000000000958e97 in bpf_object.collect_prog_relos () at libbpf.c:4206
    #1 0x000000000094f9d6 in bpf_object.collect_relos () at libbpf.c:6706
    #2 0x000000000092bef3 in bpf_object_open () at libbpf.c:7437
    #3 0x000000000092c046 in bpf_object.open_mem () at libbpf.c:7497
    #4 0x0000000000924afa in LLVMFuzzerTestOneInput () at fuzz/bpf-object-fuzzer.c:16
    #5 0x000000000060be11 in testblitz_engine::fuzzer::Fuzzer::run_one ()
    #6 0x000000000087ad92 in tracing::span::Span::in_scope ()
    #7 0x00000000006078aa in testblitz_engine::fuzzer::util::walkdir ()
    #8 0x00000000005f3217 in testblitz_engine::entrypoint::main::{{closure}} ()
    #9 0x00000000005f2601 in main ()
    (gdb)

then, I checked the code and found that scn_data was null at this code(tools/lib/bpf/src/libbpf.c):

    if (rel->r_offset % BPF_INSN_SZ || rel->r_offset >= scn_data->d_size) {
    
The scn_data is derived from the code above:
    
    scn = elf_sec_by_idx(obj, sec_idx);
    scn_data = elf_sec_data(obj, scn);
    
    relo_sec_name = elf_sec_str(obj, shdr->sh_name);
    sec_name = elf_sec_name(obj, scn);
    if (!relo_sec_name || !sec_name)    // don't check whether scn_data is NULL
    	return -EINVAL;

Do sec_data and sec_name always occur together? Is it possible that scn_data is NULL but sec_name
is not NULL? libbpf uses sec_name to determine if it’s a null pointer, Maybe we should do some
check here.


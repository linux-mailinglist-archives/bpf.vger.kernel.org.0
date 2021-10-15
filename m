Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1808C42F524
	for <lists+bpf@lfdr.de>; Fri, 15 Oct 2021 16:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237186AbhJOOYc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Oct 2021 10:24:32 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:25193 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbhJOOYb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Oct 2021 10:24:31 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HW7jj3Vs3z8tfb;
        Fri, 15 Oct 2021 22:21:13 +0800 (CST)
Received: from dggpeml500025.china.huawei.com (7.185.36.35) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 15 Oct 2021 22:22:22 +0800
Received: from [10.174.176.117] (10.174.176.117) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 15 Oct 2021 22:22:22 +0800
From:   Hou Tao <houtao1@huawei.com>
Subject: Question about pointer to forward type
To:     Yonghong Song <yhs@fb.com>, Martin KaFai Lau <kafai@fb.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        "Andrii Nakryiko" <andrii@kernel.org>
Message-ID: <c19f223e-2ef5-9f9a-f741-2fcc7d89fef6@huawei.com>
Date:   Fri, 15 Oct 2021 22:22:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

When adding test case for BPF STRUCT OPS, I got the following error
during test:

libbpf: load bpf program failed: Permission denied
libbpf: -- BEGIN DUMP LOG ---
libbpf:
R1 type=ctx expected=fp
; int BPF_PROG(test_1, struct bpf_dummy_ops_state *state)
0: (b4) w0 = -218893067
; int BPF_PROG(test_1, struct bpf_dummy_ops_state *state)
1: (79) r1 = *(u64 *)(r1 +0)
func 'test_1' arg0 type FWD is not a struct
invalid bpf_context access off=0 size=8

The error is reported from btf_ctx_access(). And the cause is
the definition of struct bpf_dummy_ops_state is separated from
the definition of test_1 function:

test_1 is defined in include/linux/bpf.h

struct bpf_dummy_ops_state;
struct bpf_dummy_ops {
        int (*test_1)(struct bpf_dummy_ops_state *cb);
}

bpf_dummy_ops_state is defined in net/bpf/bpf_dummy_struct_ops.c

struct bpf_dummy_ops_state {
};

So arg0 has BTF_KIND_FWD type, and the check in btf_ctx_access() fails.
The problem can be fixed by moving the definition of bpf_dummy_ops_state
into include/linux/bpf.h or using a void * instead of
struct bpf_dummy_ops_state *. But forward declaration is possible under
STRUCT_OPS scenario, so my question is whether or not it is a known issue
and is there somebody working on this ?

Regards,
Tao
